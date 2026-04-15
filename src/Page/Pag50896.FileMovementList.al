//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50896 "File Movement List"
{
    ApplicationArea = All;
    CardPageID = "File Movement Header";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = true;
    ModifyAllowed = true;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "File Movement Header";
    SourceTableView = where("File Return" = filter(false));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No.";Rec."No.")
                {
                }
                field("Date Requested";Rec."Date Requested")
                {
                }
                field("Requested By";Rec."Requested By")
                {
                }
                field("Responsiblity Center";Rec."Responsiblity Center")
                {
                    Caption = 'Department';
                }
                field("Expected Return Date";Rec."Expected Return Date")
                {
                }
                field("Current File Location";Rec."Current File Location")
                {
                }
                field(Status; Rec.Status)
                {
                }
                field("File Movement Status";Rec."File Movement Status")
                {
                }
            }
        }
    }

    actions
    {
    }
    trigger OnOpenPage()
    begin
        Rec.SetRange("Requested By", UserId);
    end;
}






