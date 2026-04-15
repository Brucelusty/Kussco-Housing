//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50799 "S-Mobile Appplications List"
{
    ApplicationArea = All;
    CardPageID = "S-Mobile Applications Card";
    Editable = false;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "mobile Applications";
    SourceTableView = where(Status = filter(Application | Rejected));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                }
                field("Account No"; Rec."Account No")
                {
                }
                field("Account Name"; Rec."Account Name")
                {
                }
                field(Telephone; Rec.Telephone)
                {
                }
                field("ID No"; Rec."ID No")
                {
                }
                field(Status; Rec.Status)
                {
                }
                field("Date Applied"; Rec."Date Applied")
                {
                }
                field("Time Applied"; Rec."Time Applied")
                {
                }
                field("Created By"; Rec."Created By")
                {
                }
                field(Sent; Rec.Sent)
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
        StatusPermissions.Reset;
        StatusPermissions.SetRange(StatusPermissions."User ID", UserId);
        StatusPermissions.SetRange(StatusPermissions."Function", StatusPermissions."function"::SmobileApp);
        if StatusPermissions.Find('-') = false then
            Error('You do not have permissions for S-Mobile Application.');
    end;

    var
        StatusPermissions: Record "Status Change Permision";
}






