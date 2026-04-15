//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50454 "New Paybill Lines"
{
    ApplicationArea = All;
    PageType = ListPart;
    SourceTable = "File Movement Line";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Document No."; Rec."Document No.")
                {
                }
                field("Purpose/Description"; Rec."Purpose/Description")
                {
                }
                field("Account No."; Rec."Account No.")
                {
                }
                field("File Type"; Rec."File Type")
                {
                }
                field("Account Type"; Rec."Account Type")
                {
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                }
                field("Account Name"; Rec."Account Name")
                {
                }
                field(Control1000000013; Rec."Global Dimension 1 Code")
                {
                }
                field(Control1000000014; Rec."Global Dimension 2 Code")
                {
                }
            }
        }
    }

    actions
    {
    }
}






