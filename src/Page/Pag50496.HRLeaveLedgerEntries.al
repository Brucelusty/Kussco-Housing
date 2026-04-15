//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50496 "HR Leave Ledger Entries"
{
    ApplicationArea = All;
    Caption = 'Leave Ledger Entries';
    DataCaptionFields = "Leave Period";
    Editable = false;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "HR Leave Ledger Entries";

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("Posting Date";Rec."Posting Date")
                {
                }
                field("Leave Period";Rec."Leave Period")
                {
                }
                field("Staff No.";Rec."Staff No.")
                {
                }
                field("Staff Name";Rec."Staff Name")
                {
                }
                field("Leave Type";Rec."Leave Type")
                {
                }
                field("Leave Entry Type";Rec."Leave Entry Type")
                {
                }
                field("No. of days";Rec."No. of days")
                {
                }
                field("Leave Posting Description";Rec."Leave Posting Description")
                {
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("Ent&ry")
            {
                Caption = 'Ent&ry';
                action(Dimensions)
                {
                    Caption = 'Dimensions';
                    RunObject = Page "Default Dimension Where-Used";
                    ShortCutKey = 'Shift+Ctrl+D';
                }
            }
        }
        area(processing)
        {
            action("&Navigate")
            {
                Caption = '&Navigate';
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    Navigate.SetDoc(Rec."Posting Date", Rec."Document No.");
                    Navigate.Run;
                end;
            }
            action("&Rectify")
            {
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    if Confirm('Do you wish to delete this line ?', true) = false then exit;
                    
                    Rec.Delete;
                end;
            }
        }
    }

    var
        Navigate: Page Navigate;
}






