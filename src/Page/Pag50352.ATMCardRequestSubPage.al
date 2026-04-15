//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50352 "ATM Card Request SubPage"
{
    ApplicationArea = All;
    PageType = ListPart;
    SourceTable = "ATM Card Request Lines";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("ATM Application No";Rec."ATM Application No")
                {
                }
                field("ATM Card Account No";Rec."ATM Card Account No")
                {
                }
                field("Account Name";Rec."Account Name")
                {
                    Editable = false;
                }
                field("ATM Card Application Date";Rec."ATM Card Application Date")
                {
                    Editable = false;
                }
                field("Request Type";Rec."Request Type")
                {
                }
                field(Ordered; Rec.Ordered)
                {
                }
                field("Ordered On";Rec."Ordered On")
                {
                }
                field("Ordered By";Rec."Ordered By")
                {
                }
                field("ATM Card No";Rec."ATM Card No")
                {
                }
                field("ID No";Rec."ID No")
                {
                }
                field("Phone No";Rec."Phone No")
                {
                }
            }
        }
    }

    actions
    {
    }
}






