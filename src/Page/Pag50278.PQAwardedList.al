page 50278 "PQ Awarded List"
{
    ApplicationArea = All;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "Purchase Header";
    CardPageId = "Purchase QuoteV";
    SourceTableView = where("Document Type" = const(Quote),
                            "AU Form Type" = filter('Purchase Quotes'), "LPO Awarded" = filter(True));

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
            }
        }
        area(Factboxes)
        {

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
    trigger OnOpenPage()
    begin
        //Rec.SetRange("User ID", UserId);
    end;
}


