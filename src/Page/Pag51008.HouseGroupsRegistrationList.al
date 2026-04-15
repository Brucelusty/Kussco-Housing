//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51008 "House Groups Registration List"
{
    ApplicationArea = All;
    CardPageID = "House Group Registration Card";
    DeleteAllowed = false;
    Editable = false;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "House Groups Registration";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("House Group Code";Rec."House Group Code")
                {
                }
                field("House Group Name";Rec."House Group Name")
                {
                }
                field("Date Formed";Rec."Date Formed")
                {
                }
                field("Meeting Date";Rec."Meeting Date")
                {
                }
                field("Group Leader";Rec."Group Leader")
                {
                }
                field("Group Leader Name";Rec."Group Leader Name")
                {
                }
                field("Assistant group Leader";Rec."Assistant group Leader")
                {
                }
                field("Assistant Group Name";Rec."Assistant Group Name")
                {
                }
                field("Meeting Place";Rec."Meeting Place")
                {
                }
                field("No of Members";Rec."No of Members")
                {
                    Editable = false;
                }
                field("Credit Officer";Rec."Credit Officer")
                {
                }
                field("Field Officer";Rec."Field Officer")
                {
                }
                field(Status; Rec.Status)
                {
                }
            }
        }
    }

    actions
    {
    }
}






