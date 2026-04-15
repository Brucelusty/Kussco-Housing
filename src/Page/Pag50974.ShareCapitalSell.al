//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50974 "Share Capital Sell"
{
    ApplicationArea = All;
    PageType = ListPart;
    SourceTable = "Share Capital Sell";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Buyer Member No";Rec."Buyer Member No")
                {
                }
                field("Buyer Name";Rec."Buyer Name")
                {
                    Editable = false;
                }
                field(Amount; Rec.Amount)
                {
                }
                field("Buyer FOSA Account";Rec."Buyer FOSA Account")
                {
                }
            }
        }
    }

    actions
    {
    }
}






