//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50585 "Hr Asset Transfer List"
{
    ApplicationArea = All;
    CardPageID = "Hr Asset Transfer Card";
    DeleteAllowed = false;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "HR Asset Transfer Header";

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
                field("No. Series";Rec."No. Series")
                {
                }
                field(Status; Rec.Status)
                {
                }
                field(Transfered; Rec.Transfered)
                {
                }
                field("Date Transfered";Rec."Date Transfered")
                {
                }
                field("Transfered By";Rec."Transfered By")
                {
                }
                field("Time Posted";Rec."Time Posted")
                {
                }
            }
        }
    }

    actions
    {
    }
}






