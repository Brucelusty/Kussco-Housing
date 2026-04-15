//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50495 "HR Leave Jnl. Template List"
{
    ApplicationArea = All;
    Caption = 'Leave Jnl. Template List';
    Editable = true;
    PageType = List;
    UsageCategory = Lists;
    PromotedActionCategories = 'New,Process,Report,Template';
    SourceTable = "HR Leave Journal Template";

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field(Name; Rec.Name)
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("Source Code"; Rec."Source Code")
                {
                }
                field("Reason Code"; Rec."Reason Code")
                {
                    Visible = true;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Template)
            {
                Caption = 'Template';
                action("&Batches")
                {
                    Caption = '&Batches';
                    Image = ChangeBatch;
                    Promoted = true;
                    PromotedCategory = Category4;
                    RunObject = Page "HR Leave Batches";
                    RunPageLink = "Journal Template Name" = field(Name);
                }
            }
        }
    }
}






