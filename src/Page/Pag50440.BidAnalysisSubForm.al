//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50440 "Bid Analysis SubForm"
{
    ApplicationArea = All;
    PageType = ListPart;
    SourceTable = "Bid Analysis";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Quote No.";Rec."Quote No.")
                {
                }
                field("Vendor No.";Rec."Vendor No.")
                {
                }
                field("Item No.";Rec."Item No.")
                {
                }
                field(Description; Rec.Description)
                {
                }
                field(Quantity; Rec.Quantity)
                {
                }
                field("Unit Of Measure";Rec."Unit Of Measure")
                {
                }
                field(Amount; Rec.Amount)
                {
                }
                field("Line Amount";Rec."Line Amount")
                {
                }
            }
        }
    }

    actions
    {
    }
}






