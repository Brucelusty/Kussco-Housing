//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50718 "Salary Processing List"
{
    ApplicationArea = All;
    CardPageID = "Salary Processing Header";
    Editable = false;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "Salary Processing Headerr";
    SourceTableView = where(Posted = const(false));//

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(No; Rec.No)
                {
                }
                field("Account No";Rec."Account No")
                {
                    Caption = 'Employer Account No';
                }
                field("Account Name";Rec."Account Name")
                {
                    Caption = 'Employer Account Name';
                }
                field("Account Type";Rec."Account Type")
                {
                }
                field("Entered By";Rec."Entered By")
                {
                }
                field("Date Entered";Rec."Date Entered")
                {
                }
                field("Time Entered";Rec."Time Entered")
                {
                }
                field("Posting date";Rec."Posting date")
                {
                }
                field("Cheque No.";Rec."Cheque No.")
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






