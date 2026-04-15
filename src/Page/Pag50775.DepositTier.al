//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50775 "Deposit Tier"
{
    ApplicationArea = All;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "Deposit Tier Setup";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Rec.Code)
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("Minimum Amount"; Rec."Minimum Amount")
                {
                }
                field("Maximum Amount"; Rec."Maximum Amount")
                {
                }
                field("Minimum Dep Contributions"; Rec."Minimum Dep Contributions")
                {
                }
            }
        }
    }

    actions
    {
    }
}






