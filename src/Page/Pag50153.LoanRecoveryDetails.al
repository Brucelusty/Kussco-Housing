//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50153 "Loan Recovery Details"
{
    ApplicationArea = All;
    ModifyAllowed = true;
    PageType = ListPart;
    SourceTable = "Loan Member Loans";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Guarantor Number";Rec."Guarantor Number")
                {
                    Editable = false;
                }
                field("Member Name";Rec."Member Name")
                {
                    Editable = false;
                }
                // field("Loan Type";Rec."Loan Type")
                // {
                //     Editable = false;
                //     Visible = false;
                // }
                // field("Loan No.";Rec."Loan No.")
                // {
                //     Editable = false;
                //     Visible = false;
                // }
                field("Amont Guaranteed";Rec."Amont Guaranteed")
                {
                    Editable = false;
                }
                field("Guarantors Current Shares";Rec."Guarantors Current Shares")
                {
                    Caption = 'Guarantor''s Deposits';
                    Editable = false;
                }
                // field("Guarantors Committed Shares";Rec."Guarantors Committed Shares")
                // {
                //     Editable = false;
                // }
                // field("Guarantors Free Shares";Rec."Guarantors Free Shares")
                // {
                //     Editable = false;
                // }
                field(Difference;Rec.Difference)
                {
                    Editable = false;
                }
                field("Guarantor Amount Apportioned";Rec."Guarantor Amount Apportioned")
                {
                    Editable = false;
                }
                field("Principal Liability";Rec."Principal Liability")
                {
                    Editable = false;
                }
                field("Interest Liability";Rec."Interest Liability")
                {
                    Editable = false;
                }
            }
        }
    }

    actions
    {
    }
}






