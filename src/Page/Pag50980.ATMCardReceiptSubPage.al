//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50980 "ATM Card Receipt SubPage"
{
    ApplicationArea = All;
    PageType = ListPart;
    SourceTable = "ATM Card Receipt Lines";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("ATM Application No";Rec."ATM Application No")
                {
                    Editable = false;
                }
                field("ATM Card Account No";Rec."ATM Card Account No")
                {
                    Editable = false;
                }
                field("Account Name";Rec."Account Name")
                {
                    Editable = false;
                }
                field("ATM Card Application Date";Rec."ATM Card Application Date")
                {
                    Editable = false;
                }
                field("ATM Card No";Rec."ATM Card No")
                {
                }
                field(Received; Rec.Received)
                {
                    Editable = false;
                }
                field("Received By";Rec."Received By")
                {
                    Editable = false;
                }
                field("Received On";Rec."Received On")
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






