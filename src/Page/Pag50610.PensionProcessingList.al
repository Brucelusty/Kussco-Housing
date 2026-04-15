//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50610 "Pension Processing List"
{
    ApplicationArea = All;
    CardPageID = "Pension Processing Header";
    Editable = false;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "Pension Processing Headerr";
    SourceTableView = where(Posted = const(false),
                            Pension = const(true));

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
                field(Posted; Rec.Posted)
                {
                }
                field("Posted By";Rec."Posted By")
                {
                }
                field("Date Entered";Rec."Date Entered")
                {
                }
                field("Entered By";Rec."Entered By")
                {
                }
                field(Remarks; Rec.Remarks)
                {
                }
                field("Date Filter";Rec."Date Filter")
                {
                }
                field("Time Entered";Rec."Time Entered")
                {
                }
                field("Posting date";Rec."Posting date")
                {
                }
                field("Account Type";Rec."Account Type")
                {
                }
                field("Account No";Rec."Account No")
                {
                }
                field("Cheque No.";Rec."Cheque No.")
                {
                }
                field("Document No";Rec."Document No")
                {
                }
                field(Amount; Rec.Amount)
                {
                }
                field("Scheduled Amount";Rec."Scheduled Amount")
                {
                }
                field("Total Count";Rec."Total Count")
                {
                }
                field("Account Name";Rec."Account Name")
                {
                }
                field("Employer Code";Rec."Employer Code")
                {
                }
            }
        }
    }

    actions
    {
    }
}






