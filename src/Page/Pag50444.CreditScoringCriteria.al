//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50444 "Credit Scoring Criteria"
{
    ApplicationArea = All;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "Credit Score Criteria";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Category; Rec.Category)
                {
                }
                field("Credit Score";Rec."Credit Score")
                {
                }
                field("Min Relationship Length(Years)";Rec."Min Relationship Length(Years)")
                {
                }
                field("Max Relationship Length(Years)";Rec."Max Relationship Length(Years)")
                {
                }
                field("Min Count Range";Rec."Min Count Range")
                {
                }
                field("Max Count Range";Rec."Max Count Range")
                {
                }
                field("YES/No";Rec."YES/No")
                {
                }
                field("Min Amount Range";Rec."Min Amount Range")
                {
                }
                field("Max Amount Range";Rec."Max Amount Range")
                {
                }
            }
        }
    }

    actions
    {
    }
}






