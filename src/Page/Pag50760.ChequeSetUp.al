//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50760 "Cheque Set-Up"
{
    ApplicationArea = All;
    Editable = true;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "Cheque Set Up";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Cheque Code";Rec."Cheque Code")
                {
                }
                field("Number Of Leaf";Rec."Number Of Leaf")
                {
                }
                field(Amount; Rec.Amount)
                {
                }
                field("Charge G/L Account";Rec."Charge G/L Account")
                {
                }
            }
        }
    }

    actions
    {
    }
}






