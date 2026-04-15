//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50684 "New EFT/RTGS List"
{
    ApplicationArea = All;
    CardPageID = "EFT/RTGS Card";
    Editable = false;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "EFT/RTGS Header";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(No; Rec.No)
                {
                }
                field("No. Series";Rec."No. Series")
                {
                }
                field("Entered By";Rec."Entered By")
                {
                }
                field("Date Entered";Rec."Date Entered")
                {
                }
                field("Transaction Description";Rec."Transaction Description")
                {
                }
                field(Total; Rec.Total)
                {
                }
                field("Total Count";Rec."Total Count")
                {
                }
                field(Status;Rec.Status)
                {
                }
                field(Transferred; Rec.Transferred)
                {
                }
                field("Transferred By";Rec."Transferred By")
                {
                }
                field("Date Transferred";Rec."Date Transferred")
                {
                }
            }
        }
    }

    actions
    {
    }
}






