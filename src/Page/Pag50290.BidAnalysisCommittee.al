page 50290 "Bid Analysis Committee"
{
    ApplicationArea = All;
    PageType = ListPart;
    UsageCategory = Lists;
    SourceTable = "Bid Analysis Committee";

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


