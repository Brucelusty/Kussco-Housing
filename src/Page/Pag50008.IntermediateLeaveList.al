page 50008 "Intermediate  Leave  List"
{
    ApplicationArea = All;
    CardPageID = "Intermediate Leave  Card";
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "HR Leave Application";
    SourceTableView = WHERE(Status=CONST(Approved));//,=CONST(false));

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
                field(Status;rec.Status)
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
                        //ApprovalEntries.Setfilters(DATABASE::"HR Leave Application",DocumentType,"Application Code");
                        ApprovalEntries.RUN;
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
                        rec.MODIFY;
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
        // New Comment section   
        // Usersetup.RESET;
        // Usersetup.SETRANGE(Usersetup."User ID",USERID);
        // IF Usersetup.FIND('-') THEN
        //   IF NOT Usersetup.hr THEN
        //    // ERROR('You have no permissions to view this records');
        
        // Usersetup.SETRANGE("User ID",USERID);

    end;

    var
        ApprovalMgt: Codeunit 1535;
        ApprovalEntries: Page 658;
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




