//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50456 "Medical Claim Entries"
{
    ApplicationArea = All;
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "HR Medical Claim Entries";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Entry No";Rec."Entry No")
                {
                }
                field("Document No.";Rec."Document No.")
                {
                }
                field("Employee No";Rec."Employee No")
                {
                }
                field("Employee Name";Rec."Employee Name")
                {
                }
                field("Claim Date";Rec."Claim Date")
                {
                }
                field("Hospital Visit Date";Rec."Hospital Visit Date")
                {
                }
                field("Claim Limit";Rec."Claim Limit")
                {
                }
                field("Balance Claim Amount";Rec."Balance Claim Amount")
                {
                }
                field("Amount Claimed";Rec."Amount Claimed")
                {
                }
                field("Amount Charged";Rec."Amount Charged")
                {
                }
                field(Comments; Rec.Comments)
                {
                }
                field("USER ID";Rec."USER ID")
                {
                }
                field("Claim No";Rec."Claim No")
                {
                }
                field("Date Posted";Rec."Date Posted")
                {
                }
                field("Time Posted";Rec."Time Posted")
                {
                }
                field(Posted; Rec.Posted)
                {
                }
            }
        }
    }

    actions
    {
    }
}






