//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50270 "HR Leave Application Card"
{
    ApplicationArea = All;
   // DeleteAllowed = false;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Report,Supervisor Approval,Final Approval';
    SourceTable = "HR Leave Application";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Application Code"; Rec."Application Code")
                {
                    Caption = 'Application No';
                    Editable = false;
                    Importance = Promoted;

                    trigger OnValidate()
                    begin
                        CurrPage.Update;
                    end;
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    Editable = false;
                }
                field("Handed over Report";Rec."Handed over Report")
                {
                    ShowMandatory = True;
                }
                field("Leave Type"; Rec."Leave Type")
                {
                    Editable = "Leave TypeEditable";
                    Importance = Promoted;
                    ShowMandatory = true;

                    trigger OnValidate()
                    begin

                        LeaveBalanceCaption := Rec."Leave Type" + ' - ' + 'Leave Balance';

                        GetLeaveStats(Rec."Leave Type");
                        //  CurrPage.UPDATE;

                        HREmp.Get(Rec."Employee No");
                        if Rec."Leave Type" = 'ANNUAL' then begin
                            if Rec."Days Applied" > dLeft then
                                Error('Days applied cannot exceed leave balance for this leave');
                        end else begin
                            HRLeaveTypes.Reset;
                            HRLeaveTypes.SetRange(HRLeaveTypes.Code, Rec."Leave Type");
                            if HRLeaveTypes.Find('-') then begin
                                if Rec."Days Applied" > HRLeaveTypes.Days then
                                    Error('Days applied cannot exceed leave balance for this leave');
                            end;
                        end;
                        /*
                        IF HREmp.GET("Employee No") THEN BEGIN
                        IF HREmp."Working Sunday"=TRUE THEN
                        SETRANGE("Leave Type",'ANNUAL_W');
                        END;
                        */

                    end;
                }
                field("Leave Balance Per Category"; Rec."Leave Balance Per Category")
                {
                    Caption = 'Leave Balance';
                }
                field("Days Applied"; Rec."Days Applied")
                {
                    Editable = canEdit;
                    Importance = Promoted;
                    ShowMandatory = true;

                    trigger OnValidate()
                    begin
                        HREmp.Get(Rec."Employee No");
                        if Rec."Leave Type" = 'ANNUAL' then begin
                            if Rec."Days Applied" > dLeft then
                                Error('Days applied %1 cannot exceed leave balance for this leave: %2.', rec."Days Applied", dLeft);
                        end else begin
                            HRLeaveTypes.Reset;
                            HRLeaveTypes.SetRange(HRLeaveTypes.Code, Rec."Leave Type");
                            if HRLeaveTypes.Find('-') then begin
                                if Rec."Days Applied" > HRLeaveTypes.Days then
                                    Error('Days applied %1 cannot exceed leave balance for this leave: %2.', rec."Days Applied", HRLeaveTypes);
                            end;

                        end;
                    end;
                }
                field("Expected Leave Bal";Rec."Expected Leave Bal")
                {
                    Caption = 'Expected Leave Balance';
                }
                field("Start Date"; Rec."Start Date")
                {
                    Editable = canEdit;
                    Importance = Promoted;
                    ShowMandatory = true;
                }
                field("Return Date"; Rec."Return Date")
                {
                    Editable = false;
                }
                field("Request Leave Allowance"; Rec."Request Leave Allowance")
                {
                    Editable = canEdit;
                }
                field("Employee No"; Rec."Employee No")
                {
                    Caption = 'Employee No.';
                    Editable = false;
                    Enabled = false;
                    Importance = Promoted;
                }
                field("Employee Name";Rec."Employee Name")
                {
                    Caption = 'Applicant Name';
                    Editable = false;
                    Enabled = false;
                    Importance = Promoted;
                }
                field("Job Tittle"; Rec."Job Tittle")
                {
                    Caption = 'Job Title';
                    Editable = false;
                    Enabled = false;
                    Importance = Promoted;
                }
                field(Gender; Rec.Gender)
                {
                }
                field("Department Code";Rec."Department Code")
                {
                    Caption = 'Department';
                    Editable = false;
                    Enabled = false;
                }
                field(Supervisor; Rec.Supervisor)
                {
                    Editable = false;
                }
                field("Supervisor Name";Rec."Supervisor Name")
                {
                    Caption = 'Supervisor Name';
                    Editable = false;
                }
                field("Supervisor Email"; Rec."Supervisor Email")
                {
                    Caption = 'Supervisor Email';
                    Editable = false;
                }
                field("Approved days"; Rec."Approved days")
                {
                    Editable = canEdit;
                }
                field("Approver Comments"; Rec."Approver Comments")
                {
                    Editable = canEdit;
                }
                field(dEarnd; dEarnd)
                {
                    Caption = 'Total Leave Days';
                    Editable = false;
                    Style = Strong;
                    StyleExpr = true;
                }
                field(dTaken; dTaken)
                {
                    Caption = 'Total Leave Taken';
                    Editable = false;
                    Style = Strong;
                    StyleExpr = true;
                }
                field(dLeft; dLeft)
                {
                    Caption = 'Leave Balance';
                    Editable = false;
                    Enabled = false;
                    Style = Strong;
                    StyleExpr = true;
                }
                field("Application Date"; Rec."Application Date")
                {
                    Editable = false;
                    StyleExpr = true;
                }
                field(Reliever; Rec.Reliever)
                {
                    Caption = 'Reliever Code';
                    Editable = RelieverEditable;
                    ShowMandatory = true;
                }
                field("Reliever Name"; Rec."Reliever Name")
                {
                    Editable = false;
                }
                field("Pending Tasks"; Rec."Pending Tasks")
                {
                    ShowMandatory = true;
                    Editable = canEdit;
                    MultiLine = true;
                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                    Style = StrongAccent;
                    StyleExpr = true;
                }
            }
            group("More Leave Details")
            {
                Caption = 'More Leave Details';
                field("Cell Phone Number"; Rec."Cell Phone Number")
                {
                    Editable = "Cell Phone NumberEditable";
                    Importance = Promoted;
                    ShowMandatory = true;
                }
                field("E-mail Address"; Rec."E-mail Address")
                {
                    Editable = true;
                    Importance = Promoted;
                    ShowMandatory = true;
                }
                field("Details of Examination"; Rec."Details of Examination")
                {
                    Editable = "Details of ExaminationEditable";
                    Importance = Promoted;
                    Visible = false;
                }
                field("Date of Exam"; Rec."Date of Exam")
                {
                    Editable = "Date of ExamEditable";
                    Importance = Promoted;
                    Visible = false;
                }
                field("Number of Previous Attempts"; Rec."Number of Previous Attempts")
                {
                    Editable = NumberofPreviousAttemptsEditab;
                    Importance = Promoted;
                    Visible = false;
                }
            }
            group("Exam Dates")
            {
                Caption = 'Exam Dates';
                Visible = exam;
                field("Date Of Exam 1"; Rec."Date Of Exam 1")
                {
                }
                field("Date Of Exam 2"; Rec."Date Of Exam 2")
                {
                }
                field("Date Of Exam 3"; Rec."Date Of Exam 3")
                {
                }
                field("Date Of Exam 4"; Rec."Date Of Exam 4")
                {
                }
                field("Date Of Exam 5"; Rec."Date Of Exam 5")
                {
                }
                field("Date Of Exam 6"; Rec."Date Of Exam 6")
                {
                }
                field("Date Of Exam 7"; Rec."Date Of Exam 7")
                {
                }
            }
        }
        area(factboxes)
        {
            part(Control1000000003; "HR Leave Applicaitons Factbox")
            {
                SubPageLink = "No." = field("Employee No");
            }
            systempart(s; Outlook)
            {
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
                action(Attachments)
                {
                    Caption = 'Attachments';
                    Image = Attachments;
                    Promoted = true;
                    PromotedCategory = Report;
                    RunObject = Page "HR Leave Documents";
                    RunPageLink = "Doc No." = field("Application Code");
                }
                action(Print)
                {
                    Caption = 'Print';
                    Image = PrintForm;
                    Promoted = true;
                    PromotedCategory = Report;

                    trigger OnAction()
                    begin
                        HRLeaveApp.Reset;
                        HRLeaveApp.SetRange(HRLeaveApp."Application Code", Rec."Application Code");
                        if HRLeaveApp.Find('-') then
                            Report.run(50085, true, true, HRLeaveApp);
                    end;
                }
            }
            group("F&unctions")
            {
                Caption = 'F&unctions';
                action("Send A&pproval Request")
                {
                    Caption = 'Send A&pproval Request';
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;
                    Enabled = canSendApproval;
                    Visible = (Rec."Is Manager");

                    trigger OnAction()
                    var
                        Text001: label 'This Batch is already pending approval';
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                        LeavePeriod: Text;
                        VarEmailSubject: Text;
                        VarEmailBody: Text;
                        SFactory: Codeunit "Au Factory";
                    begin
                        if Rec.Status = Rec.Status::"Pending Approval" then
                            error('Record is already pending approval');
                        Rec.TestField("Leave Type");
                        Rec.TestField("Handed Over Report");
                        Rec.TestField(Reliever);
                        Rec.TestField("Days Applied");
                        Rec.TestField("Cell Phone Number");
                        Rec.TestField("E-mail Address");

                        if Workflowintegration.CheckLeaveApplicationApprovalsWorkflowEnabled(Rec) then begin
                            Workflowintegration.OnSendLeaveApplicationForApproval(Rec);
                        end
                    end;
                }
                action("Cancel Approval Request")
                {
                    Image = CancelApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category5;
                    Enabled = CanCancelApprovalForRecord;
                    Visible = (Rec."Is Manager");

                    trigger OnAction()
                    var
                        ApprovalMgt: Codeunit "Approvals Mgmt.";
                    begin
                        if Workflowintegration.CheckLeaveApplicationApprovalsWorkflowEnabled(Rec) then begin
                            Workflowintegration.OnCancelLeaveApplicationApprovalRequest(Rec);
                        end;
                    end;
                }
                action(Approvals)
                {
                    Caption = 'Approvals';
                    Image = Approval;
                    Promoted = true;
                    PromotedCategory = Category5;
                    Enabled = OpenApprovalEntriesExistForCurrUser;
                    Visible = (Rec."Is Manager");

                    trigger OnAction()
                    var
                        ApprovalEntries: Page "Approval Entries";
                        docyType: Enum "Approval Document Type";
                    begin
                        ApprovalEntries.SetRecordFilters(Database::"HR Leave Application", docyType::"LeaveApplication" , Rec."Application Code");
                        ApprovalEntries.Run;
                    end;
                }
                action("Reject Leave Application")
                {
                    Image = Reject;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    Enabled = canCreate and (not rec.Posted);

                    trigger OnAction()
                    var
                        VarEmailBody: Text;
                        VarEmailSubject: Text;
                        SFactory: Codeunit "Au Factory";
                        ObjApprovals: Record "Approval Entry";
                        Approver: Text;
                        EmailCC: Text;
                        LeavePeriod: Text;
                        Text000: label 'Do you want to post the journal lines?';
                        
                    begin
                        saccoGen.Get();
                        if UserSetup.Get(UserId) then begin
                            if UserSetup.Leave = false then Error('The user %1 cannot alter a leave application.', UserId);
                        end;
                        Rec.Status := Rec.Status::Rejected;
                        Rec.Modify;
                    end;
                }
                action("&Post Leave Application")
                {
                    Caption = '&Post Leave Days';
                    Image = Post;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                  //  Enabled = canCreate and (not rec.Posted);

                    trigger OnAction()
                    var
                        VarEmailBody: Text;
                        VarEmailSubject: Text;
                        SFactory: Codeunit "Au Factory";
                        ObjApprovals: Record "Approval Entry";
                        Approver: Text;
                        EmailCC: Text;
                        LeavePeriod: Text;
                        Text000: label 'Do you want to post the journal lines?';
                        
                    begin
                        saccoGen.Get();
                        if UserSetup.Get(UserId) then begin
                            if UserSetup.Leave = false then Error('The user %1 cannot post leave balances.', UserId);
                        end;
                        
                       // if Rec.Status <> Rec.Status::Approved then
                       //     Error('The Leave Status must be Approved');

                        if Rec."Approved days" = 0 then begin
                            Rec."Approved days" := Rec."Days Applied";
                            Rec.Modify;
                        end;
                        
                        HRLeaveApp.Reset;
                        HRLeaveApp.SetRange(HRLeaveApp."Application Code", Rec."Application Code");
                        if HRLeaveApp.Find('-') then begin
                            HREmp.Get(Rec."Employee No");
                            HREmp.TestField(HREmp."Company E-Mail");
                            if not Confirm(Text000,false) then
                            exit;

                            HRLeaveApp.CreateLeaveLedgerEntries;
                            HRLeaveApp.Posted := true;
                            HRLeaveApp.modify;
                        end;
                    end;
                }
            }
        }
        area(Processing)
        {
            action("Send Sup Approval Request")
            {
                Caption = 'Supervisor Approval';
                Image = Approval;
                Promoted = true;
                PromotedCategory = Category4;
                // Enabled = canSendSupervisorApproval;
                Visible = (not Rec."Is Manager");
                trigger OnAction()
                var
                supApproval: Record "Leave Supervisor Approval";
                begin
                    if Rec.Status = Rec.Status::"Pending Approval" then Error('Record is already pending approval');
                    Rec.TestField(Reliever);
                    Rec.TestField("Handed Over Report");
                    Rec.TestField("Leave Type");
                    Rec.TestField("Days Applied");
                    Rec.TestField("Cell Phone Number");
                    Rec.TestField("E-mail Address");
                    
                    supApproval.Reset();
                    supApproval.SetRange("Leave No.", rec."Application Code");
                    if supApproval.Find('-') then begin
                        if Workflowintegration.CheckLeaveSupWorkflowEnabled(supApproval) then begin
                            Workflowintegration.OnSendLeaveSuperForApproval(supApproval);
                        end;
                    end;
                end;
            }
            action("Cancel Sup Approval Request")
            {
                Caption = 'Cancel Supervisor Approval';
                Image = Cancel;
                Promoted = true;
                PromotedCategory = Category4;
                // Enabled = CanCancelApprovalForRecord;
                Visible = (not Rec."Is Manager");

                trigger OnAction()
                var
                supApproval: Record "Leave Supervisor Approval";
                begin
                    supApproval.Reset();
                    supApproval.SetRange("Leave No.", rec."Application Code");
                    if supApproval.Find('-') then begin
                        if Workflowintegration.CheckLeaveSupWorkflowEnabled(supApproval) then begin
                            Workflowintegration.OnCancelLeaveSuperApprovalRequest(supApproval);
                        end;
                    end;
                end;
            }
            action("Sup Approval Request")
            {
                Caption = 'Approval';
                Image = ApprovalSetup;
                Promoted = true;
                PromotedCategory = Category4;
                Enabled = OpenApprovalEntriesExistForCurrUser;
                Visible = (not Rec."Is Manager");

                trigger OnAction()
                var
                supApproval: Record "Leave Supervisor Approval";
                approvalDoc: Enum "Approval Document Type";
                approvalPage: Page "Approval Entries";
                begin
                    supApproval.Reset();
                    supApproval.SetRange("Leave No.", rec."Application Code");
                    if supApproval.Find('-') then begin
                        approvalPage.SetRecordFilters(Database::"Leave Supervisor Approval", approvalDoc::LeaveSupervisor, Format(supApproval."No."));
                    end;
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        EmpDept := '';
        //PASS VALUES TO VARIABLES ON THE FORM
        FillVariables;
        //GET LEAVE STATS FOR THIS EMPLOYEE FROM THE EMPLOYEE TABLE
        GetLeaveStats(Rec."Leave Type");
        //TO PREVENT USER FROM SEEING OTHER PEOPLES LEAVE APPLICATIONS
        // Rec.SetFilter("User ID", UserId);

        Updatecontrols;
        SetControlAppearance();
        if rec."Leave Type" = 'STUDY' then begin
            exam := true;
        end;
        LeaveBalanceCaption := Rec."Leave Type" + ' - ' + 'Leave Balance';
    end;

    trigger OnAfterGetCurrRecord() begin
        SetControlAppearance();
        Updatecontrols();
    end;

    trigger OnInit()
    begin
        exam:= false;
        NumberofPreviousAttemptsEditab := true;
        "Date of ExamEditable" := true;
        "Details of ExaminationEditable" := true;
        "Cell Phone NumberEditable" := true;
        SupervisorEditable := true;
        RequestLeaveAllowanceEditable := true;
        RelieverEditable := true;
        "Leave Allowance AmountEditable" := true;
        "Start DateEditable" := true;
        "Responsibility CenterEditable" := true;
        "Days AppliedEditable" := true;
        "Leave TypeEditable" := true;
        "Application CodeEditable" := true;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Responsibility Center" := HREmp."Responsibility Center";
    end;

    var
    "LineNo.": Integer;
    [InDataSet]
    "Application CodeEditable": Boolean;
    [InDataSet]
    "Leave TypeEditable": Boolean;
    [InDataSet]
    "Days AppliedEditable": Boolean;
    [InDataSet]
    "Responsibility CenterEditable": Boolean;
    [InDataSet]
    "Start DateEditable": Boolean;
    [InDataSet]
    "Leave Allowance AmountEditable": Boolean;
    [InDataSet]
    RelieverEditable: Boolean;
    [InDataSet]
    RequestLeaveAllowanceEditable: Boolean;
    [InDataSet]
    SupervisorEditable: Boolean;
    [InDataSet]
    "Cell Phone NumberEditable": Boolean;
    [InDataSet]
    "Details of ExaminationEditable": Boolean;
    [InDataSet]
    "Date of ExamEditable": Boolean;
    [InDataSet]
    NumberofPreviousAttemptsEditab: Boolean;
    OpenApprovalEntriesExist: Boolean;
    EnabledApprovalWorkflowsExist: Boolean;
    CanCancelApprovalForRecord: Boolean;
    CanCancelApprovalForRecordSecond: Boolean;
    OpenApprovalEntriesExistForCurrUser: Boolean;
    canSendApproval: Boolean;
    canSendSupervisorApproval: Boolean;
    canCreate: Boolean;
    canEdit: Boolean;
    exam: Boolean;
    dAlloc: Decimal;
    dEarnd: Decimal;
    dTaken: Decimal;
    dLeft: Decimal;
    cReimbsd: Decimal;
    cPerDay: Decimal;
    cbf: Decimal;
    EmpDept: Text[30];
    EmpName: Text[70];
    EmpJobDesc: Text[50];
    SupervisorName: Text[60];
    LeaveDaysText: Text;
    ReleivedBy: Text;
    ReleiverEmail: Text;
    LeaveBalanceCaption: Text;
    Workflowintegration: codeunit WorkflowIntegration;
    ApprovalComments: Page "Approval Comments";
    HRLeaveApp: Record "HR Leave Application";
    HRSetup: Record "HR Setup";
    HRJobs: Record "HR Jobss";
    HREmp: Record "HR Employees";
    HREmp2: Record "HR Employees";
    saccoGen: Record "Sacco General Set-Up";
    UserSetup: Record "User Setup";
    HRLeaveTypes: Record "HR Leave Types";
    BaseCalendarChange: Record "Base Calendar Change";
    LeaveGjline: Record "HR Journal Line";
    HREmailParameters: Record "HR E-Mail Parameters";
    leaveSup: Record "Leave Supervisor Approval";
    approvalEntry: Record "Approval Entry";

    
    local procedure SetControlAppearance()
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    begin
        OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Rec.RecordId);
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(Rec.RecordId);
        if (rec.Status = rec.Status ::"HOD Approval") and (rec."Is Manager" = true) then begin
            canSendApproval := true;
            canSendSupervisorApproval := false;
            canCreate := false;
        end else if (rec.Status = rec.Status ::New) and (rec."Is Manager" = false) then begin
            canSendApproval := false;
            canSendSupervisorApproval := true;
            canCreate := false;
        end
        else if (rec.Status = rec.Status ::"HR Approval") then begin
            canSendApproval := true;
            canSendSupervisorApproval := false;
            canCreate := false;
        end
        else if (rec.Status = rec.Status ::Approved) then begin
            canSendApproval := false;
            canSendSupervisorApproval := false;
            canCreate := true;
        end else begin
            canSendApproval := false;
            canSendSupervisorApproval := false;
            canCreate := false;
        end;


        
        CanCancelApprovalForRecordSecond := ApprovalsMgmt.CanCancelApprovalForRecord(Rec.RecordId);
    end;

    procedure FillVariables()
    begin
        //GET THE APPLICANT DETAILS

        HREmp.Reset;
        if HREmp.Get(Rec."Employee No") then begin
            EmpName := HREmp."First Name" + ' ' + HREmp."Middle Name" + ' ' + HREmp."Last Name";
            EmpDept := HREmp."Global Dimension 2 Code";
            Rec."Job Tittle" := HREmp.Office;
        end else begin
            EmpDept := '';
        end;
        //GET THE JOB DESCRIPTION FRON THE HR JOBS TABLE AND PASS IT TO THE VARIABLE
        HRJobs.Reset;
        if HRJobs.Get(Rec."Job Tittle") then begin
            EmpJobDesc := HRJobs."Job Description";
        end else begin
            EmpJobDesc := '';
        end;

        //GET THE APPROVER NAMES
        HREmp.Reset;
        HREmp.SetRange(HREmp."User ID", Rec.Supervisor);
        if HREmp.Find('-') then begin
            SupervisorName := HREmp."First Name" + ' ' + HREmp."Middle Name" + ' ' + HREmp."Last Name";
        end else begin
            SupervisorName := '';
        end;
    end;


    procedure GetLeaveStats(LeaveType: Text[50])
    begin
        dAlloc := 0;
        dEarnd := 0;
        dTaken := 0;
        dLeft := 0;
        cReimbsd := 0;
        cPerDay := 0;
        cbf := 0;
        if HREmp.Get(Rec."Employee No") then begin
            HREmp.SetFilter(HREmp."Leave Type Filter", LeaveType);
            HREmp.CalcFields(HREmp."Allocated Leave Days", HREmp."Reimbursed Leave Days", HREmp."Total Leave Taken");
            dAlloc := HREmp."Allocated Leave Days";
            dEarnd := HREmp."Allocated Leave Days" + HREmp."Reimbursed Leave Days";
            dTaken := (HREmp."Total Leave Taken" * -1);
            dLeft := dEarnd - dTaken;
            cReimbsd := HREmp."Cash - Leave Earned";
            cPerDay := HREmp."Cash per Leave Day";
            cbf := HREmp."Reimbursed Leave Days";
        end;
    end;


    procedure TESTFIELDS()
    begin
        Rec.TestField("Leave Type");
        Rec.TestField("Days Applied");
        Rec.TestField("Start Date");
        Rec.TESTFIELD(Reliever);
        Rec.TestField(Supervisor);
    end;


    procedure Updatecontrols()
    begin
        canEdit := false;

        if (Rec.Status = Rec.Status::New) or (Rec.Status = Rec.Status::"HOD Approval") then begin
            "Application CodeEditable" := true;
            "Leave TypeEditable" := true;
            "Days AppliedEditable" := true;
            "Responsibility CenterEditable" := true;
            "Start DateEditable" := true;
            "Leave Allowance AmountEditable" := true;
            RelieverEditable := true;
            RequestLeaveAllowanceEditable := true;
            SupervisorEditable := true;
            "Cell Phone NumberEditable" := true;
            //CurrForm."E-mail Address".EDITABLE:=TRUE;
            "Details of ExaminationEditable" := true;
            "Date of ExamEditable" := true;
            NumberofPreviousAttemptsEditab := true;
            canEdit := true;
        end else begin
            "Application CodeEditable" := false;
            "Leave TypeEditable" := false;
            "Days AppliedEditable" := false;
            "Responsibility CenterEditable" := false;
            "Start DateEditable" := false;
            "Leave Allowance AmountEditable" := false;
            RelieverEditable := false;
            RequestLeaveAllowanceEditable := false;
            SupervisorEditable := false;
            "Cell Phone NumberEditable" := false;
            //CurrForm."E-mail Address".EDITABLE:=FALSE;
            "Details of ExaminationEditable" := false;
            "Date of ExamEditable" := false;
            NumberofPreviousAttemptsEditab := false;

            UserSetup.Reset();
            UserSetup.SetRange("User ID", UserId);
            if UserSetup.Find('-') then begin
                if UserSetup.Leave = true then canEdit := true;
            end;
        end;
    end;

    procedure UpdateApprovalControls()
    begin
        canEdit := false;
        HRLeaveApp.Reset();
        HRLeaveApp.SetRange(Status, HRLeaveApp.Status::"Pending Approval");
        if HRLeaveApp.FindSet() then begin
            leaveSup.Reset();
            leaveSup.SetRange("Leave No.", HRLeaveApp."Application Code");
            if leaveSup.Find('-') then begin
                if leaveSup."Approval Status" = leaveSup."Approval Status"::Rejected then begin
                    HRLeaveApp.Status := HRLeaveApp.Status::Rejected;
                    HRLeaveApp.modify;
                end;
                
                if leaveSup."Approval Status" = leaveSup."Approval Status"::Approved then begin
                    approvalEntry.Reset();
                    approvalEntry.SetRange("Document No.", leaveSup."Leave No.");
                    if approvalEntry.FindLast() then begin
                        if approvalEntry.Status = approvalEntry.Status::Approved then begin
                            HRLeaveApp.Status := HRLeaveApp.Status::Approved;
                            HRLeaveApp.modify;
                        end;
                        if approvalEntry.Status = approvalEntry.Status::Rejected then begin
                            HRLeaveApp.Status := HRLeaveApp.Status::Rejected;
                            HRLeaveApp.modify;
                        end;
                    end else begin
                        leaveSup.Validate("Approval Status");
                    end;
                end;
            end;
        end;
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


    procedure DetermineLeaveReturnDates(var fBeginDate: Date; var fDays: Decimal) fReturnDate: Date
    begin
        /*varDaysApplied := fDays;
        fReturnDate := fBeginDate;
        REPEAT
          IF DetermineIfIncludesNonWorking("Leave Type") =FALSE THEN BEGIN
            fReturnDate := CALCDATE('1D', fReturnDate);
            IF DetermineIfIsNonWorking(fReturnDate) THEN
              varDaysApplied := varDaysApplied + 1
            ELSE
              varDaysApplied := varDaysApplied;
            varDaysApplied := varDaysApplied - 1
          END
          ELSE BEGIN
            fReturnDate := CALCDATE('1D', fReturnDate);
            varDaysApplied := varDaysApplied - 1;
          END;
        UNTIL varDaysApplied = 0;
        EXIT(fReturnDate);
               */

    end;


    procedure DetermineIfIncludesNonWorkings(var fLeaveCode: Code[10]): Boolean
    begin
        if HRLeaveTypes.Get(fLeaveCode) then begin
            if HRLeaveTypes."Inclusive of Non Working Days" = true then
                exit(true);
        end;
    end;


    procedure DetermineIfIsNonWorking(var bcDate: Date) Isnonworking: Boolean
    begin

        HRSetup.Find('-');
        HRSetup.TestField(HRSetup."Base Calendar");
        BaseCalendarChange.SetFilter(BaseCalendarChange."Base Calendar Code", HRSetup."Base Calendar");
        BaseCalendarChange.SetRange(BaseCalendarChange.Date, bcDate);

        if BaseCalendarChange.Find('-') then begin
            if BaseCalendarChange.Nonworking = false then
                Error('Start date can only be a Working Day Date');
            exit(true);
        end;

        /*
        Customized.RESET;
        Customized.SETRANGE(Customized.Date,bcDate);
        IF Customized.FIND('-') THEN BEGIN
            IF Customized."Non Working" = TRUE THEN
            EXIT(TRUE)
            ELSE
            EXIT(FALSE);
        END;
         */

    end;


    procedure DeterminethisLeaveEndDates(var fDate: Date) fEndDate: Date
    begin
        /*ReturnDateLoop := TRUE;
        fEndDate := fDate;
        IF fEndDate <> 0D THEN BEGIN
          fEndDate := CALCDATE('-1D', fEndDate);
          WHILE (ReturnDateLoop) DO BEGIN
          IF DetermineIfIsNonWorking(fEndDate) THEN
            fEndDate := CALCDATE('-1D', fEndDate)
           ELSE
            ReturnDateLoop := FALSE;
          END
          END;
        EXIT(fEndDate);
         */

    end;


    procedure CreateLeaveLedgerEntriess()
    begin
        Rec.TestField("Approved days");
        HRSetup.Reset;
        if HRSetup.Find('-') then begin

            LeaveGjline.Reset;
            LeaveGjline.SetRange("Journal Template Name", HRSetup."Leave Template");
            LeaveGjline.SetRange("Journal Batch Name", HRSetup."Leave Batch");
            LeaveGjline.DeleteAll;
            //Dave
            //HRSetup.TESTFIELD(HRSetup."Leave Template");
            //HRSetup.TESTFIELD(HRSetup."Leave Batch");

            HREmp.Get(Rec."Employee No");
            HREmp.TestField(HREmp."Company E-Mail");

            //POPULATE JOURNAL LINES

            "LineNo." := 10000;
            LeaveGjline.Init;
            LeaveGjline."Journal Template Name" := HRSetup."Leave Template";
            LeaveGjline."Journal Batch Name" := HRSetup."Leave Batch";
            LeaveGjline."Line No." := "LineNo.";
            LeaveGjline."Leave Period" := '2024';
            LeaveGjline."Document No." := Rec."Application Code";
            LeaveGjline."Staff No." := Rec."Employee No";
            LeaveGjline.Validate(LeaveGjline."Staff No.");
            LeaveGjline."Posting Date" := Today;
            LeaveGjline."Leave Entry Type" := LeaveGjline."leave entry type"::Negative;
            LeaveGjline."Leave Approval Date" := Today;
            LeaveGjline.Description := 'Leave Taken';
            LeaveGjline."Leave Type" := Rec."Leave Type";
            //------------------------------------------------------------
            //HRSetup.RESET;
            //HRSetup.FIND('-');
            HRSetup.TestField(HRSetup."Leave Posting Period[FROM]");
            HRSetup.TestField(HRSetup."Leave Posting Period[TO]");
            //------------------------------------------------------------
            LeaveGjline."Leave Period Start Date" := HRSetup."Leave Posting Period[FROM]";
            LeaveGjline."Leave Period End Date" := HRSetup."Leave Posting Period[TO]";
            LeaveGjline."No. of Days" := Rec."Approved days";
            if LeaveGjline."No. of Days" <> 0 then
                LeaveGjline.Insert(true);

            //Post Journal
            LeaveGjline.Reset;
            LeaveGjline.SetRange("Journal Template Name", HRSetup."Leave Template");
            LeaveGjline.SetRange("Journal Batch Name", HRSetup."Leave Batch");
            if LeaveGjline.Find('-') then begin
                //  Codeunit.Run(Codeunit::Codeunit55560, LeaveGjline);
            end;
            Rec.Status := Rec.Status::Posted;
            Rec.Modify;

            /*END ELSE BEGIN
            ERROR('You must specify no of days');
            END;
            END;*/
            //NotifyApplicant;
        end;

    end;


    procedure NotifyApplicants()
    var
        recipient: list of [text];
    begin
        HREmp.Get(Rec."Employee No");
        HREmp.TestField(HREmp."Company E-Mail");

        //GET E-MAIL PARAMETERS FOR GENERAL E-MAILS
        HREmailParameters.Reset;
        HREmailParameters.SetRange(HREmailParameters."Associate With", HREmailParameters."associate with"::"Interview Invitations");
        if HREmailParameters.Find('-') then begin


            // HREmp.TestField(HREmp."Company E-Mail");
            // recipient.Add(HREmp."Company E-Mail");
            // SMTP.CreateMessage(HREmailParameters."Sender Name", HREmailParameters."Sender Address", recipient,
            // HREmailParameters.Subject, 'Dear' + ' ' + HREmp."First Name" + ' ' +
            // HREmailParameters.Body + ' ' + "Application Code" + ' ' + HREmailParameters."Body 2", true);
            // SMTP.Send();


            Message('Leave applicant has been notified successfully');
        end;
    end;

    local procedure SendForSupervisor(leave: Record "HR Leave Application")
    var
        supervisorApproval: Record "Leave Supervisor Approval";
    begin
        leave.Reset();
        leave.SetRange("Application Code", Rec."Application Code");
        if leave.Find('-') then begin
            supervisorApproval.Init();
            supervisorApproval."Leave No." := leave."Application Code";
            supervisorApproval."Staff No" := leave."Employee No";
            supervisorApproval."Leave Type" := leave."Leave Type";
            supervisorApproval."Staff Name" := leave."Employee Name";
            supervisorApproval."Leave Account Balance" := leave."Leave Balance Per Category";
            supervisorApproval."Day Applied" := leave."Application Date";
            supervisorApproval."Days Applied" := leave."Days Applied";
            supervisorApproval."Approved Days" := leave."Days Applied";
            if not supervisorApproval.Insert() then supervisorApproval.Modify();
        end;
    end;
}






