page 50003 "Credited FD Card"
{
    ApplicationArea = All;
    //Is this the right card for fd?
    CardPageID = "Intermediate Leave  Card";
    DeleteAllowed = false;
    ModifyAllowed = true;
    PageType = List;
    SourceTable = "HR Leave Application";
    SourceTableView = WHERE(Status=FILTER(<>Posted));

    layout
    {
        area(content)
        {
            repeater(General)
            {
                Editable = false;
                field("Application Code";rec."Application Code")
                {
                    Caption = 'Application No';
                    StyleExpr = TRUE;
                }
                field("Employee No";rec."Employee No")
                {
                }
                field("Employee Name";rec."Employee Name")
                {
                }
                field("Leave Type";rec."Leave Type")
                {
                    Editable = false;
                }
                field("Days Applied";rec."Days Applied")
                {
                }
                field("Start Date";rec."Start Date")
                {
                }
                field("Return Date";rec."Return Date")
                {
                }
                field("End Date";rec."End Date")
                {
                }
                field("Reliever Name";rec."Reliever Name")
                {
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Show")
            {
                Caption = '&Show';
            }
            group("F&unctions")
            {
                Caption = 'F&unctions';
                action("&Approvals")
                {
                    Caption = '&Approvals';
                    Image = Approvals;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    begin
                        DocumentType:=DocumentType::"Leave Application";
                        //ApprovalEntry.SetFilter(DATABASE::"HR Leave Application",DocumentType,rec."Application Code");
                        ApprovalEntries.RUN;
                    end;
                }
                action("&Send Approval Request")
                {
                    Caption = '&Send Approval Request';
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    begin

                        TESTFIELDS;
                        TestLeaveFamily;

                        IF CONFIRM('Send this Application for Approval?',TRUE)=FALSE THEN EXIT;
                        rec.Selected:=TRUE;
                        rec."User ID":=USERID;

                        //ApprovalMgt.SendLeaveAppApprovalReq(Rec);
                    end;
                }
                action("&Cancel Approval Request")
                {
                    Caption = '&Cancel Approval Request';
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    begin
                        //ApprovalMgt.CancelLeaveAppRequest(Rec,TRUE,TRUE);
                    end;
                }
                action("Re-Open")
                {
                    Caption = 'Re-Open';
                    Image = ReopenCancelled;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    begin
                        rec.Status:=rec.Status::New;
                        rec.MODIFY();
                    end;
                }
                action(Print)
                {
                    Caption = 'Print';
                    Image = PrintForm;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    begin
                        HRLeaveApp.RESET;
                        HRLeaveApp.SETRANGE(HRLeaveApp."Application Code",rec."Application Code");
                        IF HRLeaveApp.FIND('-') THEN
                        REPORT.RUN(51516170,TRUE,TRUE,HRLeaveApp);
                    end;
                }
                action("Create Leave Ledger Entries")
                {
                    Caption = 'Create Leave Ledger Entries';
                    Image = CreateLinesFromJob;
                    Promoted = true;
                    PromotedCategory = Category4;
                    Visible = false;

                    trigger OnAction()
                    begin
                        rec.CreateLeaveLedgerEntries;
                        rec.RESET();
                    end;
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        /*Usersetup.RESET;
        Usersetup.SETRANGE(Usersetup."User ID",USERID);
        IF Usersetup.FIND('-') THEN
          //IF Usersetup."View All HR Items"=FALSE THEN
           HREmp.RESET;
           HREmp.SETRANGE(HREmp."User ID",USERID);
           IF HREmp.GET THEN
           SETRANGE("User ID",HREmp."User ID")
           ELSE*/
        //user id may not be the creator of the doc
           //SETRANGE("User ID",USERID);
        Usersetup.RESET;
        Usersetup.SETRANGE(Usersetup."User ID",USERID);
        IF Usersetup.FIND('-') THEN
        IF NOT (Usersetup."User ID"='TELEPOST\ADMINISTRATOR') OR (Usersetup."User ID"='TELEPOST\MNDEKEI') THEN
        ERROR('You have no permissions to view this records');

    end;

    var
        ApprovalMgt: Codeunit 1535;
        ApprovalEntries: Page 658;
        ApprovalEntry: Record "Approval Entry";
        ApprovalComments: Page 660;
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,Receipt,"Staff Claim","Staff Advance",AdvanceSurrender,"Bank Slip",Grant,"Grant Surrender","Employee Requisition","Leave Application";
        HRLeaveApp: Record "HR Leave Application";
        HREmp: Record "HR Employees";
        Usersetup: Record 91;

    procedure TESTFIELDS()
    begin
        rec.TESTFIELD("Leave Type");
        rec.TESTFIELD("Days Applied");
        rec.TESTFIELD("Start Date");
        rec.TESTFIELD(Reliever);
        rec.TESTFIELD(Supervisor);
    end;

    procedure TestLeaveFamily()
    var
        Employees: Record "HR Employees";
    begin
        /*LeaveFamilyEmployees.SETRANGE(LeaveFamilyEmployees."Employee No","Employee No");
        IF LeaveFamilyEmployees.FINDSET THEN //find the leave family employee is associated with
        REPEAT
          LeaveFamily.SETRANGE(LeaveFamily.Code,LeaveFamilyEmployees.Family);
          LeaveFamily.SETFILTER(LeaveFamily."Max Employees On Leave",'>0');
          IF LeaveFamily.FINDSET THEN //find the status other employees on the same leave family
            BEGIN
              Employees.SETRANGE(Employees."No.",LeaveFamilyEmployees."Employee No");
              Employees.SETRANGE(Employees."Leave Status",Employees."Leave Status"::" ");
              IF Employees.COUNT>LeaveFamily."Max Employees On Leave" THEN
              ERROR('The Maximum number of employees on leave for this family has been exceeded, Contact th HR manager for more information');
            END
        UNTIL LeaveFamilyEmployees.NEXT = 0;
        */

    end;
}




