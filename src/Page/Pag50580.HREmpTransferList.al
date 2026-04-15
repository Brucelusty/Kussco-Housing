//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50580 "HR Emp Transfer List"
{
    ApplicationArea = All;
    CardPageID = "HR Emp Transfer Card";
    Editable = false;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "HR Employee Transfer Header";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Request No";Rec."Request No")
                {
                }
                field("Date Requested";Rec."Date Requested")
                {
                }
                field("Date Approved";Rec."Date Approved")
                {
                }
                field(Status; Rec.Status)
                {
                }
                field("Responsibility Center";Rec."Responsibility Center")
                {
                }
                field("Transfer details Updated";Rec."Transfer details Updated")
                {
                }
            }
        }
    }

    actions
    {
    }
}






