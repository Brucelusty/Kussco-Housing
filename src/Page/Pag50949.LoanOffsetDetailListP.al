//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50949 "Loan Offset Detail List-P"
{
    ApplicationArea = All;
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "Loan Offset Details";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Loan No.";Rec."Loan No.")
                {
                    Enabled = false;
                }
                field("Loan Top Up";Rec."Loan Top Up")
                {
                }
                field("Client Code";Rec."Client Code")
                {
                    Editable = false;
                    Enabled = false;
                }
                field("Loan Type";Rec."Loan Type")
                {
                    Editable = false;
                }
                field("Principle Top Up";Rec."Principle Top Up")
                {
                    Editable = false;
                }
                field("Loan Age";Rec."Loan Age")
                {
                    Editable = false;
                }
                field("Remaining Installments";Rec."Remaining Installments")
                {
                    Editable = false;
                }
                field("Interest Top Up";Rec."Interest Top Up")
                {
                    Editable = false;
                }
                field("Monthly Repayment";Rec."Monthly Repayment")
                {
                    Editable = false;
                }
                field("Interest Paid";Rec."Interest Paid")
                {
                    Editable = false;
                }
                field("Outstanding Balance";Rec."Outstanding Balance")
                {
                    Editable = false;
                }
                field("Interest Rate";Rec."Interest Rate")
                {
                    Editable = false;
                }
                field(Commision; Rec.Commision)
                {
                    Caption = 'Levy';
                    Editable = false;
                }
                field("Interest Due at Clearance";Rec."Interest Due at Clearance")
                {
                    Caption = ' Interest Due';
                    Visible = false;
                }
                field("Total Top Up";Rec."Total Top Up")
                {
                    Caption = 'Total Recovery(P+I+Leavy)';
                    Editable = false;
                    Importance = Promoted;
                    Style = Attention;
                    StyleExpr = true;
                }
                field("Partial Bridged";Rec."Partial Bridged")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Staff No";Rec."Staff No")
                {
                    Visible = false;
                }
            }
        }
    }

    actions
    {
    }
}






