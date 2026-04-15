//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50776 "Member Parishes"
{
    ApplicationArea = All;
    PageType = Card;
    SourceTable = "Member's Parishes";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Code"; Rec.Code)
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("Share Class"; Rec."Share Class")
                {
                }
                field("No of Members"; Rec."No of Members")
                {
                    Editable = false;
                }
                field("Male Members"; Rec."Male Members")
                {
                    Editable = false;
                }
                field("Female Members"; Rec."Female Members")
                {
                    Editable = false;
                }
            }
        }
    }

    actions
    {
    }
}






