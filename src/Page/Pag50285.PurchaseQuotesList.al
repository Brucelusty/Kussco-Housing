page 50285 "Purchase Quotes List"
{
    ApplicationArea = All;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "Purchase Header";
    CardPageId = "Purchase QuoteV";
    SourceTableView = where("Document Type" = const(Quote),
                            "AU Form Type" = filter('Purchase Quotes'),"LPO Awarded"=filter(false),"LPO Not Awarded"=filter(false));

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Buy-from Vendor No.";Rec."Buy-from Vendor No."){Caption='Vendor No';}
                field("Buy-from Vendor Name";Rec."Buy-from Vendor Name"){Caption='Vendor Name';}
                field("RFQ No";Rec."RFQ No"){}
                field("Posting Description";Rec."Posting Description"){}
                field("Amount Including VAT";Rec."Amount Including VAT"){}
              
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


