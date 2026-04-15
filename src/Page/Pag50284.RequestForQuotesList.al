page 50284 "Request For Quotes List"
{
    ApplicationArea = All;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "Purchase Header";
    CardPageId = "Request For Quotes Card";
    SourceTableView = where("Document Type" = const(Quote),
                            "AU Form Type" = filter('RFQ'));

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Purcahse Requisition No";Rec."No."){}
            
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


