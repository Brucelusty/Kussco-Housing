page 51147 "Commission Lines Subform"
{
    ApplicationArea = All;
    PageType = ListPart;
    SourceTable = "Commission Lines";
    Caption = 'Commission Lines';

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Member No."; Rec."Member No.")
                {
                }

                field("Commission Amount"; Rec."Commission Amount")
                {
                }

                field("Commission To"; Rec."Commission To")
                {

                }

                field("Commission To Name"; Rec."Commission To Name")
                {
                    Editable = false;
                }
            }
        }
    }
}


