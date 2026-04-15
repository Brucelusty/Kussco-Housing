//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50488 "HR Leave Types Card"
{
    ApplicationArea = All;
    PageType = Card;
    SourceTable = "HR Leave Types";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Code"; Rec.Code)
                {
                }
                field(Description; Rec.Description)
                {
                }
                field(Days; Rec.Days)
                {
                }
                field("Acrue Days"; Rec."Acrue Days")
                {
                }
                field("Unlimited Days"; Rec."Unlimited Days")
                {
                }
                field(Gender; Rec.Gender)
                {
                }
                field(Balance; Rec.Balance)
                {
                }
                field("Max Carry Forward Days";Rec."Max Carry Forward Days")
                {
                }
                field("Carry Forward Allowed";Rec."Carry Forward Allowed")
                {
                }
                field("Inclusive of Non Working Days";Rec."Inclusive of Non Working Days")
                {
                }
                field("Inclusive of Saturday";Rec."Inclusive of Saturday")
                {
                }
                field("Inclusive of Sunday";Rec."Inclusive of Sunday")
                {
                }
                field("Inclusive of Holidays";Rec."Inclusive of Holidays")
                {
                }
            }
        }
    }

    actions
    {
    }
}






