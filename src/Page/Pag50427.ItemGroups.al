//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50427 "Item Groups"
{
    ApplicationArea = All;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "Item Groups";

    layout
    {
        area(content)
        {
            repeater(Control12)
            {
                field("Code"; Rec.Code)
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("Def. Gen. Prod. Posting Group"; Rec."Def. Gen. Prod. Posting Group")
                {
                    Visible = false;
                }
                field("Def. Inventory Posting Group"; Rec."Def. Inventory Posting Group")
                {
                    Visible = false;
                }
                field("Def. VAT Prod. Posting Group"; Rec."Def. VAT Prod. Posting Group")
                {
                    Visible = false;
                }
                field("Def. Costing Method"; Rec."Def. Costing Method")
                {
                    Visible = false;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control2; Links)
            {
                Visible = false;
            }
            systempart(Control1; Notes)
            {
                Visible = false;
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("&Item Category Code")
            {
                Caption = '&Item Category Code';
                Image = ItemGroup;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Item Categories";

                // RunPageLink = Field51516000=field(Code);
            }
        }
    }
}






