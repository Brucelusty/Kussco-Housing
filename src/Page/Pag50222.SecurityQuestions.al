page 50222 "Security Questions"
{
    ApplicationArea = All;
    PageType = List;
    UsageCategory = Administration;
    SourceTable = "Mobile Security Quiz";

    layout
    {
        area(Content)
        {
            group(GENERAL)
            {
                field("Entry No"; Rec."Entry No")
                {

                }
                field(Sec_code; Rec.Sec_code)
                {

                }
                field(Descriptions; Rec.Descriptions)
                {

                }

            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {

                trigger OnAction()
                begin

                end;
            }
        }
    }

    var
        myInt: Integer;
}


