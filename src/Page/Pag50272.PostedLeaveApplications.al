//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50272 "Posted Leave Applications"
{
    ApplicationArea = All;
    CardPageID = "Posted  Leave Application Card";
    Editable = false;
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "HR Leave Application";
    SourceTableView = where(/*Status = filter(Approved),*/ Posted = filter(true));

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                Editable = false;
                field("Application Code";Rec."Application Code")
                {
                    Caption = 'Application No';
                    StyleExpr = true;
                }
                field("Employee No";Rec."Employee No")
                {
                }
                field("Employee Name";Rec."Employee Name")
                {
                }
                field("Leave Type";Rec."Leave Type")
                {
                    Editable = false;
                }
                field("Days Applied";Rec."Days Applied")
                {
                }
                field("Start Date";Rec."Start Date")
                {
                }
                field("Return Date";Rec."Return Date")
                {
                }
                field("End Date";Rec."End Date")
                {
                }
                field("Reliever Name";Rec."Reliever Name")
                {
                }
                field(Status; Rec.Status)
                {
                    Style = StrongAccent;
                    StyleExpr = true;
                }
            }
        }
        area(factboxes)
        {
            part(Control1102755006;"HR Leave Applicaitons Factbox")
            {
                SubPageLink = "No." = field("Employee No");
            }
            systempart(Control1102755004; Outlook)
            {
            }
        }
    }

    actions
    {
    }

    
    trigger OnOpenPage()
    begin
        // HREmp.Reset;
        // HREmp.SetRange(HREmp."User ID", UserId);
        // if HREmp.Get then
        //     Rec.SetRange("User ID", HREmp."User ID")
        // else
        //     //user id may not be the creator of the doc
        //     Rec.SetRange("User ID", UserId);
        if userSetup.Get(UserId) then begin
            if userSetup.Leave = false then begin
                Rec.SetRange(Rec."User ID", UserId);
            end;
        end;
    end;

    trigger OnAfterGetCurrRecord()
    var
        myInt: Integer;
    begin
        if userSetup.Get(UserId) then begin
            if userSetup.Leave = false then begin
                Rec.SetRange(Rec."User ID", UserId);
            end;
        end;
    end;

    trigger OnAfterGetRecord()
    var
        myInt: Integer;
    begin
        if userSetup.Get(UserId) then begin
            if userSetup.Leave = false then begin
                Rec.SetRange(Rec."User ID", UserId);
            end;
        end;
    end;


    var
        ApprovalMgt: Codeunit "Approvals Mgmt.";
        ApprovalEntries: Page "Approval Entries";
        ApprovalComments: Page "Approval Comments";
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,Receipt,"Staff Claim","Staff Advance",AdvanceSurrender,"Bank Slip",Grant,"Grant Surrender","Employee Requisition","Leave Application";
        HRLeaveApp: Record "HR Leave Application";
        HREmp: Record "HR Employees";
        UserSetup: Record "User Setup";

    procedure TESTFIELDS()
    begin
        Rec.TestField("Leave Type");
        Rec.TestField("Days Applied");
        Rec.TestField("Start Date");
        Rec.TestField(Reliever);
        Rec.TestField(Supervisor);
    end;


    procedure TestLeaveFamily()
    var
        LeaveFamily: Record "HR Leave Family Groups";
        LeaveFamilyEmployees: Record "HR Leave Family Employees";
        Employees: Record "HR Employees";
    begin
        LeaveFamilyEmployees.SetRange(LeaveFamilyEmployees."Employee No", Rec."Employee No");
        if LeaveFamilyEmployees.FindSet then //find the leave family employee is associated with
            repeat
                LeaveFamily.SetRange(LeaveFamily.Code, LeaveFamilyEmployees.Family);
                LeaveFamily.SetFilter(LeaveFamily."Max Employees On Leave", '>0');
                if LeaveFamily.FindSet then //find the status other employees on the same leave family
                  begin
                    Employees.SetRange(Employees."No.", LeaveFamilyEmployees."Employee No");
                    Employees.SetRange(Employees."Leave Status", Employees."leave status"::" ");
                    if Employees.Count > LeaveFamily."Max Employees On Leave" then
                        Error('The Maximum number of employees on leave for this family has been exceeded, Contact th HR manager for more information');
                end
            until LeaveFamilyEmployees.Next = 0;
    end;
}






