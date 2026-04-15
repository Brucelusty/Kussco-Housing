//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50350 "ATM No Linking Card"
{
    ApplicationArea = All;
    PageType = Card;
    SourceTable = "ATM Card Applications";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No.";Rec."No.")
                {
                    Editable = false;
                }
                field("Account No";Rec."Account No")
                {
                }
                field("Account Name";Rec."Account Name")
                {
                }
                field("Account Type";Rec."Account Type")
                {
                    Editable = false;
                }
                field("Branch Code";Rec."Branch Code")
                {
                    Editable = false;
                }
                field("Application Date";Rec."Application Date")
                {
                    Editable = false;
                }
                field("Card No";Rec."Card No")
                {
                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                }
                field("ATM Card Linked";Rec."ATM Card Linked")
                {
                    Editable = false;
                }
                field("ATM Card Linked By";Rec."ATM Card Linked By")
                {
                    Editable = false;
                }
                field("ATM Card Linked On";Rec."ATM Card Linked On")
                {
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Link ATM Card")
            {
                Caption = 'Link ATM Card';
                Enabled = true;
                Image = Link;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    if Rec.Status <> Rec.Status::Approved then
                        Error('This ATM Card application has not been approved');
                end;

            }
        }
    }
}


