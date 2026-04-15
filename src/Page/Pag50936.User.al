//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50936 "User"
{
    ApplicationArea = All;
    Editable = false;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = User;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("User Security ID";Rec."User Security ID")
                {
                }
                field("User Name";Rec."User Name")
                {
                }
                field("Full Name";Rec."Full Name")
                {
                }
                field(State; Rec.State)
                {
                }
                // field("Branch Code";"Branch Code")
                // {
                // }
            }
        }
    }

    actions
    {
    }
}






