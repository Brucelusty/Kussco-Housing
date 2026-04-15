//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51059 "File Return List"
{
    ApplicationArea = All;
    CardPageID = "File Return Header";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = true;
    ModifyAllowed = true;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "File Movement Header";
    SourceTableView = where("File Return" = filter(true));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No.";Rec."No.")
                {
                }
                field("File Location";Rec."File Location")
                {
                    Caption = 'Destination File Location';
                }
                field(Status; Rec.Status)
                {
                }
                field("Returned By";Rec."Returned By")
                {
                }
                field("Responsiblity Center";Rec."Responsiblity Center")
                {
                    Caption = 'Department';
                    ShowMandatory = true;
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






