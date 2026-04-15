//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50798 "S-Mobile Accounts"
{
    ApplicationArea = All;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = Vendor;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No.";Rec."No.")
                {
                }
                field(Name; Rec.Name)
                {
                }
                field("ID No.";Rec."ID No.")
                {
                }
                field(Status; Rec.Status)
                {
                }
                field(Blocked; Rec.Blocked)
                {
                }
                field("S-Mobile No";Rec."S-Mobile No")
                {
                }
                field("BOSA Account No";Rec."BOSA Account No")
                {
                }
            }
        }
    }

    actions
    {
    }
}






