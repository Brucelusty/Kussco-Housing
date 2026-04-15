//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51107 "Recruitment Processing List"
{
    ApplicationArea = All;
    CardPageID = "Recruitment Processing Header";
    Editable = false;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "Recruitment Commission Header";
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
            }
        }
    }

    actions
    {
    }
}






