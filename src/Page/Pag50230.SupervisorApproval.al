//************************************************************************
page 50230 "Supervisor Approval Card"
{
    ApplicationArea = All;
    PageType = Card;
    DeleteAllowed = false;
    UsageCategory = Lists;
    SourceTable = "Leave Supervisor Approval";

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("Leave No.";Rec."Leave No.")
                {
                }
                field("Leave Type";Rec."Leave Type")
                {
                }
                field("Staff No";Rec."Staff No")
                {
                }
                field("Staff Name";Rec."Staff Name")
                {
                }
                field("Leave Account Balance";Rec."Leave Account Balance")
                {
                }
                field("Day Applied";Rec."Day Applied")
                {
                    Caption = 'Application Date';
                }
                field("Days Applied";Rec."Days Applied")
                {
                }
                field(Releiver;Rec.Releiver)
                {
                }
                field("Approved Days";Rec."Approved Days")
                {
                }
                field("Approver Remarks";Rec."Approver Remarks")
                {
                    MultiLine = true;
                }
                field("Approval Status";Rec."Approval Status")
                {
                    Style = StrongAccent;
                }
            }
        }
        area(Factboxes)
        {

        }
    }

    actions
    {
        area(Reporting)
        {
            action(LeaveSlip)
            {
                Caption = 'Leave Slip';
                Image = DepositSlip;
                Promoted = true;
                PromotedCategory = Report;
                PromotedOnly = true;

                trigger OnAction() begin
                    leaveApp.Reset();
                    leaveApp.SetRange("Application Code", Rec."Leave No.");
                    if leaveApp.Find('-') then begin
                        Report.Run(50085, true, false, leaveApp);
                    end;
                end;
            }
        }
    }
    var
    leaveSup: Record "Leave Supervisor Approval";
    leaveApp: Record "HR Leave Application";
}




