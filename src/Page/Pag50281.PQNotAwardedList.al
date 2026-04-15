page 50281 "PQ Not Awarded List"
{
    ApplicationArea = All;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "Purchase Header";
    CardPageId = "Purchase QuoteV";
    SourceTableView = where("Document Type" = const(Quote),
                            "AU Form Type" = filter('Purchase Quotes'), "LPO Awarded" = filter(false));

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


