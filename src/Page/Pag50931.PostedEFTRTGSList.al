//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50931 "Posted EFT/RTGS List"
{
    ApplicationArea = All;
    CardPageID = "EFT/RTGS Card";
    Editable = false;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "EFT/RTGS Header";
    SourceTableView = where(Transferred = filter(true));

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
                field(Transferred; Rec.Transferred)
                {
                }
                field("Date Transferred";Rec."Date Transferred")
                {
                }
                field("Time Transferred";Rec."Time Transferred")
                {
                }
                field("Transferred By";Rec."Transferred By")
                {
                }
                field("Date Entered";Rec."Date Entered")
                {
                }
                field("Time Entered";Rec."Time Entered")
                {
                }
                field("Entered By";Rec."Entered By")
                {
                }
                field("Transaction Description";Rec."Transaction Description")
                {
                }
                field("Payee Bank Name";Rec."Payee Bank Name")
                {
                }
                field("Bank  No";Rec."Bank  No")
                {
                }
                field("Salary Processing No.";Rec."Salary Processing No.")
                {
                }
                field("Salary Options";Rec."Salary Options")
                {
                }
                field(Total; Rec.Total)
                {
                }
                field("Total Count";Rec."Total Count")
                {
                }
                field(RTGS; Rec.RTGS)
                {
                }
                field("Document No. Filter";Rec."Document No. Filter")
                {
                }
                field("Date Filter";Rec."Date Filter")
                {
                }
            }
        }
    }

    actions
    {
    }
}






