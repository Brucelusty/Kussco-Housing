//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50814 "Share Boosting List"
{
    ApplicationArea = All;
    CardPageID = "Share Boosting Card";
    Editable = false;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "Loan PayOff";
    SourceTableView = where(Posted = filter(false));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Document No";Rec."Document No")
                {
                }
                field("Member No";Rec."Member No")
                {
                }
                field("Member Name";Rec."Member Name")
                {
                }
                field("Application Date";Rec."Application Date")
                {
                }
                field("Requested PayOff Amount";Rec."Requested PayOff Amount")
                {
                }
                field("Approved PayOff Amount";Rec."Approved PayOff Amount")
                {
                }
                field("Created By";Rec."Created By")
                {
                }
            }
        }
    }

    actions
    {
    }
}






