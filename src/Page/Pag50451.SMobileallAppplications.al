//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50451 "S-Mobile all Appplications"
{
    ApplicationArea = All;
    CardPageID = "S-Mobile Applications Card";
    Editable = false;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "MOBILE Applications";

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
        area(processing)
        {
            action(Reset)
            {

                trigger OnAction()
                begin
                    if Rec.Status <> Rec.Status::Approved then
                        Error('Application needs to be approved before you reset');

                    Rec.Sent := false;
                    Rec.Modify;
                    Message('Application reset');
                end;
            }
        }
    }

    var
        StatusPermissions: Record "Status Change Permision";
}






