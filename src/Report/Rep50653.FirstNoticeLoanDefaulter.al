report 50653 "First Notice Loan Defaulter"
{
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'Layouts\Loan Defaulter 1st Notice.rdlc';

    dataset
    {
        dataitem("Loans Register";"Loans Register")
        {
            // DataItemTableView = WHERE("Loans Category"=CONST(Watch));
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
            column(CompanyName;CompanyInfo.Name)
            {
            }
            column(OustandingInterest_LoansRegister;"Loans Register".Interest)
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
            // column(CEOSignature;CompanyInfo."CEO Signature")
            // {
            // }
            column(LastPayDate_LoansRegister;"Loans Register"."Last Pay Date")
            {
            }
            column(Issued_Date;"Issued Date"){}
            column(Expected_Date_of_Completion;"Expected Date of Completion"){}
            column(Loan_Product_Type_Name;"Loan Product Type Name"){}
            column(Loan_Product_Type;"Loan Product Type"){}
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

            trigger OnAfterGetRecord()
            begin
                // Cust.RESET;
                // Cust.SETRANGE(Cust."No.","Loans Register"."BOSA No");
                // IF Cust.FIND('-') THEN BEGIN
                //  IF SendSMS=TRUE THEN BEGIN
                //   OutstandingAmount:=CLassify.FnClassifyLoansIndividual("Loans Register"."Loan  No.");
                // //MESSAGE('Hre%1Product%2',OutstandingAmount,"Loans Register"."Loan Product Type Name");
                // "Loans Register".CALCFIELDS("Loans Register"."Outstanding Balance","Loans Register"."Outstanding Interest");
                //    SendSMSNotification("Loans Register"."Loan Product Type Name",ROUND((OutstandingAmount),0.05,'>'));
                //    END;
                //   END;

                if SendSMS then begin
                    Cust.Reset();
                    Cust.SetRange("No.", "Loans Register"."Client Code");
                    if Cust.Find('-') then begin
                        defaulterEmail := LowerCase(Cust."E-Mail");
                        defaulterName := UpperCase(Cust.Name);
                        Recipients.Add(defaulterEmail);
                    end;
                    if defaulterEmail = '' then Error('Ensure the member %1 has an email address.', LoanApp."Client Code");

                    BccList.Add('info@telepostsacco.co.ke');
                    BccList.Add('debt@telepostsacco.co.ke');

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
                    filters := '';
                    LoanApp.RESET;
                    LoanApp.SETRANGE("Loan  No.","Loans Register"."Loan  No.");
                    IF LoanApp.FINDFIRST THEN BEGIN
                        // Report.Run(173011, true, false, LoanApp);
                        Filename := 'Loan Defaulter 1st Notice';
                        EmailSubject := 'FIRST DEFAULTER NOTICE';
                        EmailBody := 'Dear '+ LoanApp."Client Name"+', <br><br> Kindly find attached below the first defaulter notice on your defaulted <strong>%1</strong> Loan.';
                        // EmailBody += '<br><br><hr> <strong> Be advised, this is a test case on defaulter notices </strong> </hr>';
                        FinalEmailBody := StrSubstNo(EmailBody, LoanApp."Loan Product Type Name");

                        TempBlob.CreateOutStream(Outstrm, TextEncoding::UTF8);
                        RecRef.GetTable(LoanApp);
                        Report.SaveAs(Report::"First Notice Loan Defaulter", '', ReportFormat::Pdf, Outstrm, RecRef);
                        TempBlob.CreateInStream(InStrm, TextEncoding::UTF8);
                        ConvertedFile := Base64Conversion.ToBase64(InStrm);

                        EmailMessage.Create(Recipients, EmailSubject, FinalEmailBody, true, CCList, BccList);
                        EmailMessage.AddAttachment(defaulterName +'-First Defaulter Notice.pdf', 'PDF', ConvertedFile);
                        EmailSend.Send(EmailMessage, Enum::"Email Scenario"::"Demand Notice");
                        //Clear the recepients and CC list
                    END;
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

            trigger OnPostDataItem()
            begin
                /*SmtpRec.GET;
                CompanyInfo.GET();
                SenderAddress := SmtpRec."User ID";
                SenderName := COMPANYNAME;
                Subject := STRSUBSTNO('Payslip');
                Body := STRSUBSTNO('Dear '+Loans."Client Name"+','+'<p>Please find attached loan notice ');
                Body:=Body+'<p> Kind Regards,<br> Credit Manager';
                PyslipCapt:='Defaulter Notice '+' '+Loans."Loan  No."+'.pdf';
                  Loans.RESET;
                  Loans.SETRANGE(Loans."Loan  No.","Loans Register"."Loan  No.");
                   IF Loans.FIND('-')THEN BEGIN
                
                   FileName:=FileMangement.ServerTempFileName('.pdf');
                    REPORT.SAVEASPDF(REPORT::"Loan 1 Notice Email",FileName,"Loans Register");
                   // IF Emp."E-Mail" <> '' THEN BEGIN
                    Recipients :={Emp."E-Mail"}'denniskitui@gmail.com';
                    SMTPSetup.CreateMessage(SenderName,SenderAddress,Recipients,Subject,Body,TRUE);
                    SMTPSetup.AddAttachment(FileName,PyslipCapt);
                
                     SMTPSetup.Send;
                //END;
                END;*/

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
        CompanyInfo.GET;
        // CompanyInfo.CALCFIELDS(CompanyInfo.Picture,CompanyInfo."CEO Signature");
        CompanyInfo.CalcFields(CompanyInfo.Picture, CompanyInfo."CEO Signature");
    end;

    var
        Cust: Record Customer;
        SendSMS: Boolean;
        SMSMessages: Record "SMS Messages";
        iEntryNo: Integer;
        OutstandingAmount: Decimal;
        CLassify: Codeunit "Loan Aging Classification";
        Loans: Record "Loans Register";
        SMTPSetup: Codeunit Mail;
        CompanyInfo: Record "Company Information";
        LoanG: Record "Loans Guarantee Details";
        UserSetup: Record "User Setup";
        SenderAddress: Text[80];
        SenderName: Text[50];
        Body: Text[250];
        Subject: Text[80];
        FileName: Text[250];
        FileMangement: Codeunit "File Management";
        HRSetup: Record "HR Setup";
        PayPeriod: Date;
        Emp: Record Employee;
        StaffType: Code[20];
        PyslipCapt: Text;
        SmtpRec: Record "Email Account";
        filters: Text;
        LoanApp: Record "Loans Register";
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

    procedure SendSMSNotification(LoanProductTYpe: Text[200];Amount: Decimal)
    begin
              SMSMessages.RESET;
              IF SMSMessages.FIND('+') THEN BEGIN
              iEntryNo:=SMSMessages."Entry No";
              iEntryNo:=iEntryNo+1;
              END
              ELSE BEGIN
              iEntryNo:=1;
              END;

              SMSMessages.RESET;
              SMSMessages.INIT;
              SMSMessages."Entry No":=iEntryNo;
              SMSMessages."Account No":=Cust."No.";
              SMSMessages."Date Entered":=TODAY;
              SMSMessages."Time Entered":=TIME;
              SMSMessages.Source:='DEFAULTERS';
              SMSMessages."Entered By":=USERID;
              SMSMessages."Sent To Server":=SMSMessages."Sent To Server"::No;
              SMSMessages."SMS Message":='Dear member, this is to notify you that your ' +LoanProductTYpe+ ' loan is in arrears of Kshs:'+FORMAT(Amount)+
             '.Kindly make payments to continue accessing Credit facilities. Contact 0205029200/204/211';

              SMSMessages."Telephone No":=Cust."Phone No.";
              SMSMessages.INSERT;
    end;
}



