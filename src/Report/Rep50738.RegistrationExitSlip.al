report 50738 "Registration Exit Slip"
{
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    DefaultRenderingLayout = ExitSlip;

    dataset
    {
        dataitem(Customer; Customer)
        {
            RequestFilterFields = "No.";
            column(No_; "No.")
            { }
            column(Name; Name)
            { }
            column(Payroll_No; "Payroll No")
            { }
            column(ID_No_; "ID No.")
            { }
            column(burialPermit;burialPermit)
            { }
            column(Membership_Status; "Membership Status")
            { }
            column(Member_Deposits; multipliedDeposits)
            { }
            column(Current_Shares; "Current Shares")
            { }
            column(Shares_Retained; "Shares Retained")
            { }
            column(School_Fees_Shares; "School Fees Shares")
            { }
            column(Total_Loan_Balance; totalLoans)
            { }
            column(withdrawalFee; withdrawalFee)
            { }
            column(totalRefund; totalRefund)
            { }
            column(unpaidDividends; "Interest On Deposits" + "Dividend Amount")
            { }
            column(currentLiability; currentLiability)
            { }
            column(Mobile_Phone_No_; "Mobile Phone No")
            { }
            column(reasonExit; reasonExit)
            { }
            column(regDate; regDate)
            { }
            column(Credit; multipliedDeposits + "School Fees Shares" + "Interest On Deposits" + "Dividend Amount")
            { }
            column(Debit; withdrawalFee + totalLoans + currentLiability)
            { }
            column(Remainder; (multipliedDeposits + "School Fees Shares" + "Interest On Deposits" + "Dividend Amount") - (withdrawalFee + totalLoans + currentLiability))
            { }
            column(noticeDate; noticeDate)
            { }
            column(matureDate; matureDate)
            { }
            // column()
            // {}
            column(company_Pic; company.Picture)
            { }
            column(company_Name; company.Name)
            { }
            column(company_Address; company.Address)
            { }
            column(company_Phone; company."Phone No.")
            { }
            column(company_Email; company."E-Mail")
            { }
            column(company_Motto; company.Motto)
            { }
            trigger OnAfterGetRecord()
            begin
                Customer.CalcFields("Total Loan Balance", "Current Shares");


                currentLiability := 0;
                guarDetails.Reset();
                guarDetails.SetRange("Member No", Customer."No.");
                guarDetails.SetRange(Substituted, false);
                if guarDetails.Find('-') then begin
                    repeat
                        loanReg.Reset();
                        loanReg.SetRange("Loan  No.", guarDetails."Loan No");
                        loanReg.SetFilter("Outstanding Balance", '>%1', 0);
                        if loanReg.Find('-') then begin
                            loanReg.CalcFields("Outstanding Balance");
                            currentLiability := currentLiability + (Round(((loanReg."Outstanding Balance" / loanReg."Approved Amount") * guarDetails."Amont Guaranteed"), 0.01, '='));
                        end;
                    until guarDetails.Next() = 0;
                end;

                regDate := 0D;
                noticeDate := 0D;
                matureDate := 0D;
                reasonExit := '';
                totalLoans := 0;
                multipliedDeposits:= 0;
                withNotice.Reset();
                withNotice.SetRange("Member No", Customer."No.");
                if withNotice.Find('-') then begin
                    if withNotice."Withdrawal Type" = withNotice."Withdrawal Type"::Death then begin
                        totalLoans := 0;
                        currentLiability := 0;
                        multipliedDeposits:= "Current Shares" * depMulti;
                    end else begin
                        totalLoans := Customer."Total Loan Balance";
                        multipliedDeposits:= Customer."Current Shares";
                    end;

                    if withNotice."Deposits to be deducted" = true then begin
                        currentLiability := currentLiability;
                    end else begin
                        currentLiability := 0;
                    end;

                    burialPermit := withNotice."Burial Permit Serial";
                    regDate := withNotice."Registration Date";
                    noticeDate := withNotice."Notice Date";
                    matureDate := withNotice."Maturity Date";
                    reasonExit := Format(withNotice."Withdrawal Type");
                end;

                totalRefund := 0;
                totalRefund := (multipliedDeposits + "Dividend Amount" + "Interest On Deposits" + "School Fees Shares") - (withdrawalFee + totalLoans + currentLiability);
                if totalRefund < 0 then totalRefund := 0;
            end;

        }
    }

    requestpage
    {
        AboutTitle = 'Teaching tip title';
        AboutText = 'Teaching tip content';
        layout
        {
            area(Content)
            {
                group(GroupName)
                {

                }
            }
        }
    }

    rendering
    {
        layout(ExitSlip)
        {
            Type = RDLC;
            LayoutFile = 'Layouts/RegistrationExitSlip.rdlc';
        }
    }
    trigger OnInitReport()
    begin
        withdrawalFee := 0;
        depMulti:= 0;
        company.Get();
        saccoGen.Get();
        company.CalcFields(Picture);
        withdrawalFee := saccoGen."Withdrawal Fee";
        depMulti:= 2;
    end;

    var
        number: Integer;
        withdrawalFee: Decimal;
        totalRefund: Decimal;
        currentLiability: Decimal;
        totalLoans: Decimal;
        multipliedDeposits: Decimal;
        depMulti: Integer;
        regDate: Date;
        noticeDate: Date;
        matureDate: Date;
        reasonExit: Text[500];
        burialPermit: Code[50];
        saccoGen: Record "Sacco General Set-Up";
        company: Record "Company Information";
        guarDetails: Record "Loans Guarantee Details";
        loanReg: Record "Loans Register";
        withNotice: Record "Withdrawal Notice";
}
