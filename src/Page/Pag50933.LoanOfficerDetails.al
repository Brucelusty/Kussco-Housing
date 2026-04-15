//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50933 "Loan Officer Details"
{
    ApplicationArea = All;
    CardPageID = "Loan Officer Card";
    DeleteAllowed = false;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "Loan Officers Details";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Account No.";Rec."Account No.")
                {
                }
                field("Account Type";Rec."Account Type")
                {
                }
                field("Account Name";Rec."Account Name")
                {
                }
                field("Savings Target";Rec."Savings Target")
                {
                }
                field("Member Target";Rec."Member Target")
                {
                }
                field("Disbursement Target";Rec."Disbursement Target")
                {
                }
                field("Payment Target";Rec."Payment Target")
                {
                }
                field("Exit Target";Rec."Exit Target")
                {
                }
                field("No. of Loans";Rec."No. of Loans")
                {
                }
                field(Status; Rec.Status)
                {
                }
                field(Created; Rec.Created)
                {
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            separator(Action1000000012)
            {
            }
            action(Approval)
            {
                Image = Approvals;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    ///rereer
                end;
            }
            separator(Action1000000014)
            {
            }
        }
    }
}






