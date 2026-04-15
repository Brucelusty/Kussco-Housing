//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50450 "Appplications approvals"
{
    ApplicationArea = All;
    CardPageID = "S-Mobile Applications Card";
    Editable = false;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "MOBILE Applications";
    SourceTableView = where(Status = filter("Pending Approval"));

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
        area(creation)
        {
            action(Approve)
            {
                Caption = 'Approve';
                Image = Approve;

                trigger OnAction()
                begin
                    if Rec.Status = Rec.Status::"Pending Approval" then begin
                        if Vendor.Get(Rec."Account No") then begin
                            Vendor."S-Mobile No" := Rec.Telephone;
                            Vendor.Modify;
                            Rec.Status := Rec.Status::Approved;
                            Rec.Modify;

                            Message('Application has been approved');

                        end
                    end
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        StatusPermissions.Reset;
        StatusPermissions.SetRange(StatusPermissions."User ID", UserId);
        StatusPermissions.SetRange(StatusPermissions."Function", StatusPermissions."function"::Smobile);
        if StatusPermissions.Find('-') = false then
            Error('You do not have permissions to edit member information.');
    end;

    var
        Vendor: Record Vendor;
        StatusPermissions: Record "Status Change Permision";
}






