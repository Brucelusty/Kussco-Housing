//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50968 "Potential Opportunity list"
{
    ApplicationArea = All;
    CardPageID = "Potential Opportunity Card";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "Lead Management";
    SourceTableView = where(status = const(Opportunity));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No.";Rec."No.")
                {
                }
                field(Name; Rec.Name)
                {
                }
                field("Search Name";Rec."Search Name")
                {
                }
                field(Address; Rec.Address)
                {
                }
                field(City; Rec.City)
                {
                }
                field("Phone No.";Rec."Phone No.")
                {
                }
                field("Salesperson Code";Rec."Salesperson Code")
                {
                }
                field("Country/Region Code";Rec."Country/Region Code")
                {
                }
                field(Comment; Rec.Comment)
                {
                }
                field(status; Rec.status)
                {
                }
                field("Lead Type";Rec."Lead Type")
                {
                }
                field("Lead Status";Rec."Lead Status")
                {
                    Editable = false;
                }
            }
        }
    }

    actions
    {
    }
}






