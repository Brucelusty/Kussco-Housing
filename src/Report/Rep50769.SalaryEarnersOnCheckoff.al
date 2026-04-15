report 50769 "Salary Earners on Checkoff"
{
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    DefaultRenderingLayout = SalaryOnCheckoff;
    
    dataset
    {
        dataitem(Vendor;Vendor)
        {
            DataItemTableView = where("Account Type" = filter('103'));
            column(No_;"No.")
            {}
            column(BOSA_Account_No;"BOSA Account No")
            {}
            column(Name;Name)
            {}
            column(loanNo;loanNo)
            {}
            column(employerCode;employerCode)
            {}
            column(recoveryMode;recoveryMode)
            {}
            trigger OnAfterGetRecord() begin
                if (Vendor."Salary earner") or (Vendor."Salary Processing") then begin
                    loansReg.Reset();
                    loansReg.SetRange("Client Code", Vendor."BOSA Account No");
                    loansReg.SetAutoCalcFields("Total Outstanding Balance");
                    loansReg.SetFilter("Total Outstanding Balance", '>%1', 0);
                    loansReg.SetRange("Recovery Mode", loansReg."Recovery Mode"::Checkoff);
                    if loansReg.Find('-') then begin
                        loanNo := loansReg."Loan  No.";
                        employerCode := loansReg."Employer Code";
                        recoveryMode := Format(loansReg."Recovery Mode");
                    end else CurrReport.Skip();
                end else CurrReport.Skip();
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
            }
        }
    }
    
    rendering
    {
        layout(SalaryOnCheckoff)
        {
            Type = RDLC;
            LayoutFile = 'Layouts/SalaryOnCheckoff.rdlc';
        }
    }
    
    var
    myInt: Integer;
    loanNo: Code[20];
    employerCode: Code[20];
    recoveryMode: Code[20];
    vend: Record Vendor;
    loansReg: Record "Loans Register";
}
