//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50571 "HR Medical Schemes Card"
{
    ApplicationArea = All;
    PageType = Card;
    SourceTable = "HR Medical Schemes";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Scheme No";Rec."Scheme No")
                {
                }
                field("Medical Insurer";Rec."Medical Insurer")
                {
                }
                field("Scheme Name";Rec."Scheme Name")
                {
                }
                field("In-patient limit";Rec."In-patient limit")
                {
                    Visible = false;
                }
                field("Out-patient limit";Rec."Out-patient limit")
                {
                    Visible = false;
                }
                field("Area Covered";Rec."Area Covered")
                {
                    Visible = false;
                }
                field("Dependants Included";Rec."Dependants Included")
                {
                }
                field(Comments; Rec.Comments)
                {
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Functions")
            {
                Caption = '&Functions';
                action("Medical Scheme Members")
                {
                    Caption = 'Medical Scheme Members';
                    Image = PersonInCharge;
                    Promoted = true;
                    PromotedCategory = Category4;
                    RunObject = Page "HR Medical Scheme Members List";
                }
            }
        }
    }
}






