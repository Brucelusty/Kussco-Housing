//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50186 "Funds Transfer List"
{
    ApplicationArea = All;
    CardPageID = "Funds Transfer Card";
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "Funds Transfer Header";
    SourceTableView = where(Posted = const(false));

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
       //"Pay Mode" := Rec."pay mode"::Cash
    end;
}






