page 50286 "Bid Analysis Comment"
{
    ApplicationArea = All;
    PageType = ListPart;
    UsageCategory = Lists;
    SourceTable = "Bid Analysis Comment";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(No; Rec.No)
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

                trigger OnAction();
                begin

                end;
            }
        }
    }
    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec."Captured by" := UserId;
        Rec."Date Time" := CurrentDateTime;
    end;
}


