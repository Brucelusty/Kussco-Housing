//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50244 "Posred Funds Transfer List"
{
    ApplicationArea = All;
    CardPageID = "Posted Funds Transfer Card";
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "Funds Transfer Header";
    //SourceTableView =  where(Posted = const(true));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No.";Rec."No.")
                {
                }
                field("Document Date";Rec."Document Date")
                {
                }
                field("Posting Date";Rec."Posting Date")
                {
                }
                field("Paying Bank Account";Rec."Paying Bank Account")
                {
                }
                field("Paying Bank Name";Rec."Paying Bank Name")
                {
                }

            }
        }
    }

    actions
    {
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
       // rec."Pay Mode" := rec."pay mode"::Cash
    end;
}






