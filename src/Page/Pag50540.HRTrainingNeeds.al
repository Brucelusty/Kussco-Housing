//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50540 "HR Training Needs"
{
    ApplicationArea = All;
    CardPageID = "HR Training Needs Card";
    PageType = List;
    UsageCategory = Lists;
    PromotedActionCategories = 'New,Process,Report,Functions';
    SourceTable = "HR Training Needs";

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                Editable = false;
                field("Code";Rec.Code)
                {
                    Importance = Promoted;
                    Style = StrongAccent;
                    StyleExpr = true;
                }
                field(Description;Rec.Description)
                {
                    Importance = Promoted;
                }
                field(Duration;Rec.Duration)
                {
                }
                field("Duration Units";Rec."Duration Units")
                {
                }
                field("Start Date";Rec."Start Date")
                {
                }
                field("End Date";Rec."End Date")
                {
                }
                field("Re-Assessment Date";Rec."Re-Assessment Date")
                {
                }
                field(Location;Rec.Location)
                {
                }
                field(Provider;Rec.Provider)
                {
                }
                field("Cost Of Training";Rec."Cost Of Training")
                {
                }
                field(Posted;Rec.Posted)
                {
                }
            }
        }
        area(factboxes)
        {
            systempart(Control1102755003;Outlook)
            {
            }
            systempart(Control1102755005;Notes)
            {
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("Training Needs")
            {
                Caption = 'Training Needs';
                action("&Card")
                {
                    Caption = '&Card';
                    Image = Card;
                    Promoted = true;
                    PromotedCategory = Category4;
                    // RunObject = Page "HR Training Needs";
                    // RunPageLink = Code = field(Code);
                }
            }
        }
        area(reporting)
        {
            action(Action1102755006)
            {
                Caption = 'Training Needs';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                //   RunObject = Report UnknownReport55595;
            }
        }
    }
}






