//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50792 "Supervisor Approval Levels"
{
    ApplicationArea = All;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "Supervisors Approval Levels";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Supervisor ID"; Rec."Supervisor ID")
                {
                }
                field("Maximum Approval Amount"; Rec."Maximum Approval Amount")
                {
                }
                field("Transaction Type"; Rec."Transaction Type")
                {
                }
                field("E-mail Address"; Rec."E-mail Address")
                {
                }
            }
        }
    }

    actions
    {
    }
}






