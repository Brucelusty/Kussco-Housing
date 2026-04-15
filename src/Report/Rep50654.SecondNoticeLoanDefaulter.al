report 50654 "Second Notice Loan Defaulter"
{
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'Layouts\Loan Defaulter 2nd Notice.rdlc';

    dataset
    {
        dataitem("Loans Register";"Loans Register")
        {
            // DataItemTableView = WHERE("Loans Category"=CONST(Substandard));
            RequestFilterFields = "Client Code","Loan  No.","Loans Category";
            column(OutstandingBalance_Loans;"Loans Register"."Outstanding Balance")
            {
            }
            column(LoanNo_Loans;"Loans Register"."Loan  No.")
            {
            }
            column(ClientName_Loans;"Loans Register"."Client Name")
            {
            }
            column(ClientCode_Loans;"Loans Register"."Client Code")
            {
            }
            column(LoanProductTypeName_LoansRegister;"Loans Register"."Loan Product Type Name")
            {
            }
            column(Loan_Product_Type;"Loan Product Type"){}
            column(OustandingInterest_LoansRegister;"Loans Register"."Outstanding Interest")
            {
            }
            column(CompanyName;CompanyInfo.Name)
            {
            }
            column(CompanyAddress;CompanyInfo.Address)
            {
            }
            column(CompanyPhone;CompanyInfo."Phone No.")
            {
            }
            column(CompanyPic;CompanyInfo.Picture)
            {
            }
            column(CEOSignature;CompanyInfo."CEO Signature")
            {
            }
            column(CompanyEmail;CompanyInfo."E-Mail")
            {
            }
            column(CompanyPage;CompanyInfo."Home Page")
            {
            }
            dataitem("Members Register";"Members Register")
            {
                DataItemLink = "No."=FIELD("Client Code");
                column(City_Members;"Members Register".City)
                {
                }
                column(Address2_Members;"Members Register"."Address 2")
                {
                }
                column(Address_Members;"Members Register".Address)
                {
                }
                column(PayrollStaffNo_MembersRegister;"Members Register"."Payroll No")
                {
                }
            }
            dataitem("Loans Guarantee Details";"Loans Guarantee Details")
            {
                DataItemLink = "Loan No"=FIELD("Loan  No.");
                column(MemberNo_LoansGuaranteeDetails;"Loans Guarantee Details"."Member No")
                {
                }
                column(Name_LoansGuaranteeDetails;"Loans Guarantee Details".Name)
                {
                }
                column(AmontGuaranteed_LoansGuaranteeDetails;"Loans Guarantee Details"."Amont Guaranteed")
                {
                }
            }

            trigger OnAfterGetRecord()
            begin
                AmouuntToRecover:=0;
                "Loans Register".CALCFIELDS("Loans Register"."Outstanding Balance","Loans Register"."Outstanding Interest");
                AmouuntToRecover:=("Loans Register"."Outstanding Balance"+"Loans Register"."Outstanding Interest");  //-"Current Shares";
                OutstandingInt:= "Outstanding Interest";
                LoanNo:="Loan  No.";


                IF LoansREC.GET(LoanNo) THEN
                //MESSAGE('your naame is %1 and loan no is %2',LoansREC."Client Name",LoanNo);
                LoansREC.CALCFIELDS(LoansREC."Outstanding Balance",LoansREC."Outstanding Interest",LoansREC."No. Of Guarantors",LoansREC."Total Loans Outstanding");
                //MESSAGE('outsta bala is %1',LoansREC."Total Loans Outstanding");
                //AmouuntToRecover:=(LoansREC."Total Loans Outstanding");
                OutstandingInt:= "Outstanding Interest";

                Cust.RESET;
                Cust.SETRANGE(Cust."No.","Loans Register"."BOSA No");
                IF Cust.FIND('-') THEN BEGIN
                  IF SendSMS=TRUE THEN BEGIN
                    SendSMSNotification("Loans Register"."Loan Product Type Name",ROUND(("Loans Register"."Outstanding Balance"+"Loans Register"."Outstanding Interest"),0.5,'>'),Cust."Phone No.",Cust.Name);
                    END;
                  END;
                Propotion:=0;
                Propotion:=ROUND(("Loans Register"."Outstanding Balance"/"Loans Register"."Approved Amount"),0.01,'=');
                Guarantors.RESET;
                Guarantors.SETRANGE(Guarantors."Loan No","Loans Register"."Loan  No.");
                IF Guarantors.FINDFIRST THEN
                BEGIN
                REPEAT
                //  MESSAGE('Client%1Amount%2',Guarantors."Member No",Guarantors."Amont Guaranteed");
                Cust.RESET;
                Cust.SETRANGE(Cust."No.",Guarantors."Member No");
                IF Cust.FIND('-') THEN BEGIN
                  IF SendSMS=TRUE THEN BEGIN
                    SendSMSNotificationGuarantors("Loans Register"."Loan Product Type Name",Propotion*Guarantors."Amont Guaranteed","Loans Register"."Client Name",Cust."Phone No.",Cust.Name);
                 END;
                 END;
                UNTIL Guarantors.NEXT=0;
                END;

                if SendSMS then begin
                    Cust.Reset();
                    Cust.SetRange("No.", "Loans Register"."Client Code");
                    if Cust.Find('-') then begin
                        defaulterEmail := LowerCase(Cust."E-Mail");
                        defaulterName := UpperCase(Cust.Name);
                        Recipients.Add(defaulterEmail);
                    end;
                    if defaulterEmail = '' then Error('Ensure the member %1 has an email address.', "Loans Register"."Client Code");
                    
                    LoanG.Reset();
                    LoanG.SetRange("Loan No", "Loans Register"."Loan  No.");
                    if LoanG.FindSet() then begin
                        repeat
                        Cust.Reset();
                        if Cust.Get(LoanG."Member No") then begin
                            CCList.Add(LowerCase(Cust."E-Mail"));
                        end;
                        until LoanG.Next() = 0;
                    end;
                    BccList.Add('info@telepostsacco.co.ke');
                    BccList.Add('debt@telepostsacco.co.ke');
                    
                    LoansApp.RESET;
                    LoansApp.SETRANGE("Loan  No.","Loans Register"."Loan  No.");
                    IF LoansApp.FINDFIRST THEN BEGIN

                        Filename := 'Loan Defaulter 2nd Notice';
                        EmailSubject := 'SECOND DEFAULTER NOTICE';
                        EmailBody := 'Dear '+ LoansApp."Client Name"+', <br><br> Kindly find attached below the second defaulter notice on your defaulted <strong>%1</strong> Loan.';
                        // EmailBody += '<br><br><hr> <strong> Be advised, this is a test case on defaulter notices </strong> </hr>';
                        FinalEmailBody := StrSubstNo(EmailBody, LoansApp."Loan Product Type Name");

                        TempBlob.CreateOutStream(Outstrm, TextEncoding::UTF8);
                        RecRef.GetTable(LoansApp);
                        Report.SaveAs(Report::"Second Notice Loan Defaulter", '', ReportFormat::Pdf, Outstrm, RecRef);
                        TempBlob.CreateInStream(InStrm, TextEncoding::UTF8);
                        ConvertedFile := Base64Conversion.ToBase64(InStrm);

                        EmailMessage.Create(Recipients, EmailSubject, FinalEmailBody, true, CCList, BccList);
                        EmailMessage.AddAttachment(defaulterName +'-Second Defaulter Notice.pdf', 'PDF', ConvertedFile);
                        EmailSend.Send(EmailMessage, Enum::"Email Scenario"::"Demand Notice");

                        if Recipients.Count > 0 then begin
                            Recipients.RemoveRange(1, 1);
                        end;
                        if BccList.Count > 0 then begin
                            BccList.RemoveRange(1, 1);
                        end;
                        i := CCList.Count;
                        if CCList.Count > 0 then begin
                            for i := CCList.Count downto 1 do begin
                                CCList.RemoveRange(1, 1);
                            end;
                        end;
                    end;
                end;
            end;

            trigger OnPreDataItem()
            begin
                CALCFIELDS("Outstanding Balance","Outstanding Interest","Current Shares");//(,LoansR.Outstanding Balance));
                LoansREC.CALCFIELDS(LoansREC."Outstanding Balance",LoansREC."Outstanding Interest",LoansREC."No. Of Guarantors");
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(SendSMS;SendSMS)
                {
                    Caption = 'Send Email Notification';
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        CompanyInfo.GET();
        CompanyInfo.CALCFIELDS(CompanyInfo.Picture,CompanyInfo."CEO Signature");
    end;

    var
        CompanyInfo: Record "Company Information";
        Cust: Record Customer;
        SendSMS: Boolean;
        SMSMessages: Record "SMS Messages";
        iEntryNo: Integer;
        LoansREC: Record "Loans Register";
        AmouuntToRecover: Decimal;
        OutstandingInt: Decimal;
        LoanNo: Code[10];
        CLassify: Codeunit "Loan Aging Classification";
        Guarantors: Record "Loans Guarantee Details";
        Propotion: Decimal;
        loansApp: Record "Loans Register";
        LoanG: Record "Loans Guarantee Details";
        Filename: Text[200];
        defaulterName: Text;
        defaulterEmail: Text;
        EmailSubject: Text;
        EmailBody: Text;
        FinalEmailBody: Text;
        RecRef: RecordRef;
        Outstrm: OutStream;
        TempBlob: Codeunit "Temp Blob";
        EmailSend: Codeunit Email;
        EmailMessage: Codeunit "Email Message";
        EmailScenario: Enum "Email Scenario";
        Recipients: List of [text];
        CCList: List of [Text];
        BccList: List of [Text];
        ConvertedFile: Text;
        Base64Conversion: Codeunit "Base64 Convert";
        InStrm: InStream;
        ChildElements: Code[20];
        emailRecep: Enum "Email Recipient Type";
        i: Integer;

    procedure SendSMSNotification(LoanProductName: Text[150];OutstandingAmount: Decimal;PhoneNumber: Code[20];ClientName: Text[200])
    begin

            //   SMSMessages.RESET;
            //   IF SMSMessages.FIND('+') THEN BEGIN
            //   iEntryNo:=SMSMessages."Entry No";
            //   iEntryNo:=iEntryNo+1;
            //   END
            //   ELSE BEGIN
            //   iEntryNo:=1;
            //   END;
            //   SMSMessages.RESET;
            //   SMSMessages.INIT;
            //   SMSMessages."Entry No":=iEntryNo;
            //   SMSMessages."Account No":=Cust."No.";
            //   SMSMessages."Date Entered":=TODAY;
            //   SMSMessages."Time Entered":=TIME;
            //   SMSMessages.Source:='DEFAULTERS';
            //   SMSMessages."Entered By":=USERID;
            //   SMSMessages."Sent To Server":=SMSMessages."Sent To Server"::No;
            //   SMSMessages."SMS Message":='Dear '+ClientName+', this is to notify you that your '+LoanProductName+ ' of Ksh:'+FORMAT(OutstandingAmount)+
            //   ' is in default for 60 days and is due for CRB listing. kindly repay to avoid recovery from guarantors. Contact 0205029200/204/211';
            //   SMSMessages."Telephone No":=PhoneNumber;
            //   SMSMessages.INSERT;

    end;

    procedure SendSMSNotificationGuarantors(LoanProductName: Text[150];OutstandingAmount: Decimal;ClientName: Text[200];PhoneNumber: Code[40];GuarantorName: Text[200])
    begin

            //   SMSMessages.RESET;
            //   IF SMSMessages.FIND('+') THEN BEGIN
            //   iEntryNo:=SMSMessages."Entry No";
            //   iEntryNo:=iEntryNo+1;
            //   END
            //   ELSE BEGIN
            //   iEntryNo:=1;
            //   END;
            //   SMSMessages.RESET;
            //   SMSMessages.INIT;
            //   SMSMessages."Entry No":=iEntryNo;
            //   SMSMessages."Account No":=Cust."No.";
            //   SMSMessages."Date Entered":=TODAY;
            //   SMSMessages."Time Entered":=TIME;
            //   SMSMessages.Source:='DEFAULTERS';
            //   SMSMessages."Entered By":=USERID;
            //   SMSMessages."Sent To Server":=SMSMessages."Sent To Server"::No;
            //   SMSMessages."SMS Message":='Dear '+GuarantorName+', please note that Kshs'+FORMAT(OutstandingAmount)+' will be recovered from your deposits to repay the defaulted loan by ' +ClientName+
            //    ' as per the guarantor notice. Contact 0205029200/204/211.';
            //   SMSMessages."Telephone No":=PhoneNumber;
            //   SMSMessages.INSERT;

    end;
}




