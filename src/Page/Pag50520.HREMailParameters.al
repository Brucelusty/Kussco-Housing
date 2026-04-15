//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50520 "HR E-Mail Parameters"
{
    ApplicationArea = All;
    PageType = Card;
    SourceTable = "HR E-Mail Parameters";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Associate With";Rec."Associate With")
                {
                }
                field("Sender Name";Rec."Sender Name")
                {
                }
                field("Sender Address";Rec."Sender Address")
                {
                }
                field(Recipients; Rec.Recipients)
                {
                }
                field(Subject; Rec.Subject)
                {
                }
                field(Body; Rec.Body)
                {
                }
                field("Body 2";Rec."Body 2")
                {
                }
                field("Body 3";Rec."Body 3")
                {
                }
                field(HTMLFormatted; Rec.HTMLFormatted)
                {
                }
            }
        }
    }

    actions
    {
    }
}






