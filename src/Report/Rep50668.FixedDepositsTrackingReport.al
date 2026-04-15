report 50668 "Fixed Deposits Tracking Report"
{
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = 'Layouts/FDTrackingReport.rdlc';
    
    dataset
    {
        dataitem("Fixed Deposit";"Fixed Deposit")
        {
            RequestFilterFields = "Account No", "Upon Maturity", "Fixed Date", MaturityDate, "Fd Duration";
            column(FD_No;"FD No")
            {}
            column(Account_No;"Account No")
            {}
            column(Account_Name;"Account Name")
            {}
            column(Upon_Maturity;"Upon Maturity")
            {}
            column(FD_Certificate_No;"FD Certificate No")
            {}
            column(Fd_Duration;"Fd Duration")
            {}
            column(Fixed_Date;"Fixed Date")
            {}
            column(Fixed_By;"Fixed By")
            {}
            column(MaturityDate;MaturityDate)
            {}
            column(Amount;Amount)
            {}
            column(Interest_Rate;"Interest Rate")
            {}
            column(Interest_Earned;"Interest Earned")
            {}
            column(interestLessTax;interestLessTax)
            {}
            column(Amount_After_maturity;"Amount After maturity")
            {}
            column(Revoked_Date;"Revoked Date")
            {}
            column(Revoked_By;"Revoked By")
            {}
            column(inclusiveText;inclusiveText)
            {}

            trigger OnAfterGetRecord() begin
                inclusiveText := '';

                if PreviewCall then begin
                    inclusiveText := 'Inclusive of Call Deposits';
                end;

            end;
        }

    }
    
    requestpage
    {
        SaveValues = true;
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                    field(PreviewCall;PreviewCall)
                    {
                        Caption = 'Preview Call';
                    ApplicationArea = All;
                        ToolTip = 'Allow to view Call Deposits together with the Fixed Deposit Amounts';
                        
                    }
                }
            }
        }
    }
    
    var
    myInt: Integer;
    PreviewCall: Boolean;
    inclusiveText: Text[100];
}



