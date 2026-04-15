//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50975 "ATM Card Request Batch List"
{
    ApplicationArea = All;
    CardPageID = "ATM Card Request Batch Card";
    Editable = false;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "ATM Card Order Batch";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Batch No.";Rec."Batch No.")
                {
                }
                field("Description/Remarks";Rec."Description/Remarks")
                {
                }
                field(Requested; Rec.Requested)
                {
                }
                field(Status; Rec.Status)
                {
                }
                field("Date Created";Rec."Date Created")
                {
                }
                field("Date Requested";Rec."Date Requested")
                {
                }
                field("Requested By";Rec."Requested By")
                {
                }
                field("Prepared By";Rec."Prepared By")
                {
                }
                field(Date; Rec.Date)
                {
                }
                field("No. Series";Rec."No. Series")
                {
                }
            }
        }
    }

    actions
    {
    }
}






