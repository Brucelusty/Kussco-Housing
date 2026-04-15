//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50743 "Bulk SMS Header List"
{
    ApplicationArea = All;
    CardPageID = "Bulk SMS Header";
    Editable = false;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "Bulk SMS Header";
    SourceTableView=where (Posted=Filter(false));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(No; Rec.No)
                {
                }
                field(Message; Rec.Message)
                {
                }
                field("SMS Type"; Rec."SMS Type")
                {
                }
                field("Date Entered"; Rec."Date Entered")
                {
                }
                field("Time Entered"; Rec."Time Entered")
                {
                }
                field("SMS Status"; Rec."SMS Status")
                {
                }
            }
        }
    }

    actions
    {
    }
}






