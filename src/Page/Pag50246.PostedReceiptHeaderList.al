//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50246 "Posted Receipt Header List"
{
    ApplicationArea = All;
    CardPageID = "Posted Receipt Header Card";
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "Receipt Header";
    SourceTableView = where(Posted = const(true));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No.";Rec."No.")
                {
                }
                field(Date; Rec.Date)
                {
                }
                field("Bank Code";Rec."Bank Code")
                {
                }
                field("Bank Name";Rec."Bank Name")
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("Amount Received";Rec."Amount Received")
                {
                }
                field("Total Amount";Rec."Total Amount")
                {
                }
                field(Status; Rec.Status)
                {
                }
                field("User ID";Rec."User ID")
                {
                }
            }
        }
    }

    actions
    {
    }
}






