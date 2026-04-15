//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50463 "Scheduled Statements"
{
    ApplicationArea = All;
    CardPageID = "Scheduled Statements Card";
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "Scheduled Statements";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Document No";Rec."Document No")
                {
                }
                field("Member No";Rec."Member No")
                {
                }
                field("Member Name";Rec."Member Name")
                {
                }
                field("Account No";Rec."Account No")
                {
                }
                field("Statement Period";Rec."Statement Period")
                {
                }
                field(Frequency; Rec.Frequency)
                {
                }
                field("Output Format";Rec."Output Format")
                {
                }
                field("Days of Week";Rec."Days of Week")
                {
                }
                field("Days Of Month";Rec."Days Of Month")
                {
                }
                field("Statement Type";Rec."Statement Type")
                {
                }
                field("Schedule Status";Rec."Schedule Status")
                {
                }
                field("Created By";Rec."Created By")
                {
                }
                field("Created On";Rec."Created On")
                {
                }
                field("Activated By";Rec."Activated By")
                {
                }
                field("Activated On";Rec."Activated On")
                {
                }
                field("Stopped By";Rec."Stopped By")
                {
                }
                field("Stopped On";Rec."Stopped On")
                {
                }
            }
        }
    }

    actions
    {
    }
}






