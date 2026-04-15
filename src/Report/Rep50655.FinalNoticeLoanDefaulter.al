report 50655 "Final Notice Loan Defaulter"
{
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'Layouts\Loan Defaulter 3rd Notice.rdlc';

    dataset
    {
        dataitem("Loans Guarantee Details";"Loans Guarantee Details")
        {
            RequestFilterFields = "Loan No", "Member No";
            column(Loan_No;"Loan No")
            {}
            column(Member_No;"Member No")
            {}
            column(Amont_Guaranteed;"Amont Guaranteed")
            {}
            column(Total_Amount_Guaranteed;"Total Amount Guaranteed")
            {}
            column(AmouuntToRecover;AmouuntToRecover)
            {}
            column(Loanee;Loanee)
            {}
            column(Guarantor;Guarantor)
            {}
            column(pfNo;pfNo)
            {}
            column(LoanType;LoanType)
            {}
            column(recoveryDate;recoveryDate)
            {}
            // column()
            // {}
            column(CompanyInfo_Name;CompanyInfo.Name)
            {}
            column(CompanyInfo_Email;CompanyInfo."E-Mail")
            {}
            column(CompanyInfo_CEO_Sign;CompanyInfo."CEO Signature")
            {}
            column(CompanyInfo_Pic;CompanyInfo.Picture)
            {}
            column(CompanyInfo_Phone;CompanyInfo."Phone No.")
            {}
            column(CompanyInfo_Address;CompanyInfo.Address)
            {}
            // column()
            // {}
            
            trigger OnAfterGetRecord() begin
                recoveryDate := 0D;
                recoveryDate := CalcDate('<30D>', Today);
                LoansR.Reset();
                LoansR.SetRange("Loan  No.", "Loans Guarantee Details"."Loan No");
                if LoansR.Find('-') then begin
                    LoanType := LoansR."Loan Product Type Name";
                    Cust.Reset();
                    Cust.SetRange("No.", LoansR."Client Code");
                    if Cust.Find('-') then begin
                        Loanee := Cust.Name;
                        pfNo := Cust."Payroll No";
                    end;
                    Cust.Reset();
                    Cust.SetRange("No.", "Loans Guarantee Details"."Member No");
                    if Cust.Find('-') then begin
                        Guarantor := Cust.Name;
                        cust.CalcFields("Current Shares");
                        LoansR.CalcFields("Total Outstanding Balance");
                        AmouuntToRecover := Round(((LoansR."Total Outstanding Balance"/LoansR."Approved Amount") * "Loans Guarantee Details"."Amont Guaranteed"), 0.01, '=');
                        if AmouuntToRecover > cust."Current Shares" then AmouuntToRecover := cust."Current Shares";
                    end;
                end;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                // field(SendSMS;SendSMS)
                // {
                //     Caption = 'Send SMS Notification';
                // }
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
        CompanyInfo.CALCFIELDS(Picture,"CEO Signature");
    end;

    var
        Balance: Decimal;
        SenderName: Text[150];
        DearM: Text[60];
        LoanType: Text[1000];
        SharesB: Decimal;
        recoveryDate: Date;
        LoansR: Record "Loans Register";
        SharesAlllocated: Decimal;
        ABFAllocated: Decimal;
        LBalance: Decimal;
        Loanee: Code[50];
        Guarantor: Code[50];
        pfNo: Code[50];
        Cust: Record Customer;
        Vend: Record "Vendor";
        OutstandingBalLoan: Decimal;
        AmouuntToRecover: Decimal;
        OutstandingInt: Decimal;
        LoanNo: Code[30];
        CompanyInfo: Record "Company Information";
        SendSMS: Boolean;
        SMSMessages: Record "SMS Messages";
        iEntryNo: Integer;
        LoansREC: Record "Loans Register";
        CLassify: Codeunit "Loan Aging Classification";
        Guarantors: Record "Loans Guarantee Details";
        Propotion: Decimal;

    procedure SendSMSNotification(LoanProductName: Text[150];OutstandingAmount: Decimal;PhoneNumber: Code[20];ClientName: Text[200])
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
              SMSMessages."SMS Message":='Kindly note that your defaulted '+LoanProductName+' of Kshs '+FORMAT(OutstandingAmount)+' has been transferred to the guarantors for recovery. Contact 0205029200/204/211 for payments.';
              SMSMessages."Telephone No":=PhoneNumber;
              SMSMessages.INSERT;

    end;

    procedure SendSMSNotificationGuarantors(LoanProductName: Text[150];OutstandingAmount: Decimal;ClientName: Text[200];PhoneNumber: Code[40];GuarantorName: Text[200])
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
              SMSMessages."SMS Message":='Dear '+GuarantorName+',kindly note that the '+LoanProductName+'you guaranteed '+ClientName+' is in default and Ksh:'+FORMAT(OutstandingAmount)
              +' will be recovered from your deposits on '+FORMAT(CALCDATE('CM',TODAY))+
              ' if no payment is made. Contact 0205029200/204/211.';
              SMSMessages."Telephone No":=PhoneNumber;
              SMSMessages.INSERT;

    end;
}



