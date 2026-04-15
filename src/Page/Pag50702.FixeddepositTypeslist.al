//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50702 "Fixed deposit Types list"
{
    ApplicationArea = All;
    CardPageID = "Fixed Deposit Types Card";
    Editable = false;
    DeleteAllowed = false;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "Fixed Deposit Type";
    SourceTableView = sorting(Code)
                      order(descending);

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Rec.Code)
                {
                }
                field(Duration; Rec.Duration)
                {
                }
                field("Interest Rate"; Rec."Interest Rate")
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("No. of Months"; Rec."No. of Months")
                {
                }

            }
        }
    }

    actions
    {
    }
}






