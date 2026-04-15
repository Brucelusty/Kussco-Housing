//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51002 "CRM Trainees"
{
    ApplicationArea = All;
    PageType = ListPart;
    SourceTable = "CRM Traineees";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Member No";Rec."Member No")
                {
                }
                field("Member Name";Rec."Member Name")
                {
                }
                field("Member ID No";Rec."Member ID No")
                {
                }
                field("Member Phone No";Rec."Member Phone No")
                {
                }
                field("Member House Group";Rec."Member House Group")
                {
                }
                field("Member House Group Name";Rec."Member House Group Name")
                {
                }
                field(Attended; Rec.Attended)
                {
                }
            }
        }
    }

    actions
    {
    }
}






