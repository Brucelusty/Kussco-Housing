//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50251 "Loans Guarantee Details"
{
    ApplicationArea = All;
    PageType = ListPart;
    RefreshOnActivate = false;
    SourceTable = "Loans Guarantee Details";

    layout
    {
        area(content)
        {
            repeater(Control1102760000)
            {

                field("Member No"; Rec."Member No")
                {
                    Caption = 'Member No.';
                }
                field(Name; Rec.Name)
                {
                    Enabled = false;
                }
                field("Mobile No"; Rec."Mobile No")
                {
                    Editable = false;
                }
                field("ID No."; Rec."ID No.")
                {
                    Visible = true;
                    Editable = false;
                }
                field("Guarantorship Multiplier"; Rec."Guarantorship Multiplier")
                {
                    Editable = false;
                }
                field(Shares; Rec.Shares)
                {
                    Caption = 'Current Deposits';
                    Editable = false;
                }
                field("Max Guarantorship"; Rec."Max Guarantorship")
                {
                    Editable = false; 
                }
                field("Committed Shares"; Rec."Committed Shares")
                {
                    Editable = false;
                    Caption = 'Committed Deposits';
                }
                field("Free Shares"; Rec."Free Shares")
                {
                    Editable = false;
                    Caption = 'Free Deposits';
                }
                field("Amont Guaranteed"; Rec."Amont Guaranteed")
                {
                    Caption = 'Amount To Guarantee';

                    trigger OnValidate()
                    begin
                        FnRunGetCummulativeAmountGuaranteed(Rec."Loan No");
                    end;
                }
                field("Loan Balance"; Rec."Loan Balance")
                {
                }
                field("Total Amount Guaranteed"; Rec."Total Amount Guaranteed")
                {
                    Editable = false;
                }
                field("Acceptance Status"; Rec."Acceptance Status")
                {
                    Editable = false;
                }
                field("Date Accepted"; Rec."Date Accepted")
                {
                    Caption = 'Date Responded';
                    Editable = false;
                }
                field("Loanees  No"; Rec."Loanees  No")
                {
                }


                field("Self Guarantee"; Rec."Self Guarantee")
                {
                }
                field(Substituted; Rec.Substituted)
                {
                }
                field(Date; Rec.Date)
                {
                    Editable = false;
                    Visible = false;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin

    end;

    var
        Cust: Record Customer;
        EmployeeCode: Code[20];
        CStatus: Option Active,"Non-Active",Blocked,Dormant,"Re-instated",Deceased,Withdrawal,Retired,Termination,Resigned,"Ex-Company",Casuals,"Family Member","New (Pending Confirmation)","Defaulter Recovery";
        LoanApps: Record "Loans Register";
        StatusPermissions: Record "Status Change Permision";
        RunningBalance: Decimal;

    local procedure FnRunGetCummulativeAmountGuaranteed(VarLoanNo: Code[30])
    var
        LoansGuaranteeDetails: Record "Loans Guarantee Details";
    begin
        RunningBalance := 0;

        LoansGuaranteeDetails.Reset;
        LoansGuaranteeDetails.SetRange(LoansGuaranteeDetails."Loan No", VarLoanNo);
        if LoansGuaranteeDetails.FindSet then begin
            repeat
                RunningBalance := RunningBalance + LoansGuaranteeDetails."Amont Guaranteed";
            until LoansGuaranteeDetails.Next = 0;
        end;
    end;
}






