page 50007 "Intermediate Leave  Card"
{
    ApplicationArea = All;
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Report,Functions,Comments';
    SourceTable = "HR Leave Application";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Application Code";rec."Application Code")
                {
                    Caption = 'Application No';
                    Editable = false;
                    Importance = Promoted;

                    trigger OnValidate()
                    begin
                        CurrPage.UPDATE;
                    end;
                }
                field("Responsibility Center";rec."Responsibility Center")
                {
                }
                field("Leave Type";rec."Leave Type")
                {
                    Editable = "Leave TypeEditable";
                    Importance = Promoted;

                    trigger OnValidate()
                    begin
                        /*GetLeaveStats("Leave Type");
                        //  CurrPage.UPDATE;
                        
                        HREmp.GET("Employee No");
                        IF "Leave Type"='ANNUAL' THEN BEGIN
                          IF "Days Applied">Rec.dleft THEN
                           ERROR('Days applied cannot exceed leave balance for this leave');
                        END ELSE BEGIN
                         HRLeaveTypes.RESET;
                         HRLeaveTypes.SETRANGE(HRLeaveTypes.Code,"Leave Type");
                         IF HRLeaveTypes.FIND('-') THEN BEGIN
                          IF "Days Applied">HRLeaveTypes.Days THEN
                           ERROR('Days applied cannot exceed leave balance for this leave');
                        
                         END;
                        END;*/
                        /*
                        IF HREmp.GET("Employee No") THEN BEGIN
                        IF HREmp."Working Sunday"=TRUE THEN
                        SETRANGE("Leave Type",'ANNUAL_W');
                        END;
                        */

                    end;
                }
                field("Days Applied";rec."Days Applied")
                {
                    Editable = "Days AppliedEditable";
                    Importance = Promoted;

                    trigger OnValidate()
                    begin
                        /*MESSAGE('%1',HRLeaveTypes.Days);
                        HREmp.GET("Employee No");
                        IF "Leave Type"='ANNUAL' THEN BEGIN
                          IF "Days Applied">dLeft THEN
                           ERROR('Days applied cannot exceed leave balance for this leave');
                        END ELSE BEGIN
                         HRLeaveTypes.RESET;
                         HRLeaveTypes.SETRANGE(HRLeaveTypes.Code,"Leave Type");
                         IF HRLeaveTypes.FIND('-') THEN BEGIN
                          IF "Days Applied">HRLeaveTypes.Days THEN
                           ERROR('Days applied cannot exceed leave balance for this leave');
                         END;
                        
                        END;
                        */

                    end;
                }
                field("Start Date";rec."Start Date")
                {
                    Editable = "Start DateEditable";
                    Importance = Promoted;
                }
                field("Return Date";rec."Return Date")
                {
                    Editable = false;
                }
                field("Request Leave Allowance";rec."Request Leave Allowance")
                {
                }
                field("Leave Allowance Amount";rec."Leave Allowance Amount")
                {
                }
                field("Employee Details";'')
                {
                    Caption = 'Employee Details';
                    Style = StrongAccent;
                    StyleExpr = TRUE;
                }
                field("Employee No";rec."Employee No")
                {
                    Caption = 'Employee No.';
                    Editable = false;
                    Enabled = false;
                    Importance = Promoted;
                }
                field("Employee Name";rec."Employee Name")
                {
                    Caption = 'Applicant Name';
                    Editable = false;
                    Enabled = false;
                    Importance = Promoted;
                }
                field("Job Tittle";rec."Job Tittle")
                {
                    Caption = 'Job Title';
                    Editable = false;
                    Enabled = false;
                    Importance = Promoted;
                }
                field(Gender;rec.Gender)
                {
                }
                field(EmpJobDesc;EmpJobDesc)
                {
                    Caption = 'Job Description';
                    Editable = false;
                    Enabled = false;
                    Importance = Promoted;
                }
                field(EmpDept;EmpDept)
                {
                    Caption = 'Department';
                    Editable = false;
                    Enabled = false;
                }
                field(Supervisor;rec.Supervisor)
                {
                    Editable = SupervisorEditable;

                    trigger OnValidate()
                    begin
                        //GET THE APPROVER NAMES
                        HREmp.RESET;
                        HREmp.SETRANGE(HREmp."User ID",rec.Supervisor);
                        IF HREmp.FIND('-') THEN
                        BEGIN
                        SupervisorName:=HREmp.County + ' ' + HREmp."Home Phone Number" +HREmp."Post Code";
                        END ELSE BEGIN
                        SupervisorName:='';
                        END;
                    end;
                }
                field(SupervisorName;SupervisorName)
                {
                    Caption = 'Supervisor Name';
                    Editable = false;
                }
                field("Supervisor Email";rec."Supervisor Email")
                {
                    Caption = 'Supervisor Email';
                    Editable = false;
                }
                field("Approved days";rec."Approved days")
                {
                }
                field(Text19010232;Text19010232)
                {
                    CaptionClass = Text19010232;
                    Style = StrongAccent;
                    StyleExpr = TRUE;
                }
                field("Leave Balance";rec."Leave Balance Per Category")
                {
                    Editable = false;
                }
                field("Application Date";rec."Application Date")
                {
                    Editable = false;
                    StyleExpr = TRUE;
                }
                field(Reliever;rec.Reliever)
                {
                    Caption = 'Reliever Code';
                    Editable = RelieverEditable;
                }
                field("Reliever Name";rec."Reliever Name")
                {
                    Editable = false;
                }
                field(Reliever2;rec.Reliever2)
                {
                    Caption = 'Reliever (2)';
                }
                field("Reliever Name2";rec."Reliever Name2")
                {
                    Caption = 'Reliever (2) Name';
                }
                field("Attachments.";rec.Attachments)
                {
                }
                field(Status;rec.Status)
                {
                    Style = StrongAccent;
                    StyleExpr = TRUE;
                }
            }
            group("More Leave Details")
            {
                Caption = 'More Leave Details';
                field("Cell Phone Number";rec."Cell Phone Number")
                {
                    Editable = "Cell Phone NumberEditable";
                    Importance = Promoted;
                }
                field("E-mail Address";rec."E-mail Address")
                {
                    Editable = true;
                    Importance = Promoted;
                }
                field("Details of Examination";rec."Details of Examination")
                {
                    Editable = "Details of ExaminationEditable";
                    Importance = Promoted;
                    Visible = false;
                }
                field("Date of Exam";rec."Date of Exam")
                {
                    Editable = "Date of ExamEditable";
                    Importance = Promoted;
                    Visible = false;
                }
                field("Number of Previous Attempts";rec."Number of Previous Attempts")
                {
                    Editable = NumberofPreviousAttemptsEditab;
                    Importance = Promoted;
                    Visible = false;
                }
            }
            group("Exam Dates")
            {
                Caption = 'Exam Dates';
                field("Date Of Exam 1";rec."Date Of Exam 1")
                {
                }
                field("Date Of Exam 2";rec."Date Of Exam 2")
                {
                }
                field("Date Of Exam 3";rec."Date Of Exam 3")
                {
                }
                field("Date Of Exam 4";rec."Date Of Exam 4")
                {
                }
                field("Date Of Exam 5";rec."Date Of Exam 5")
                {
                }
                field("Date Of Exam 6";rec."Date Of Exam 6")
                {
                }
                field("Date Of Exam 7";rec."Date Of Exam 7")
                {
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
                    PromotedCategory = Category6;
                }
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
                        //DocumentType:=DocumentType::"Leave Application";
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
                }
                action("Reject Leave")
                {
                    Caption = 'Reject Leave';
                    Image = ReopenCancelled;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    begin
                        IF CONFIRM('Are you sure you want to reject leave?',TRUE,FALSE)=TRUE THEN BEGIN
                        rec.Status:=rec.Status::Rejected;
                        rec.MODIFY;
                        END;
                    end;
                }
                action(Print)
                {
                    Caption = 'Print';
                    Image = PrintForm;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        HRLeaveApp.RESET;
                        HRLeaveApp.SETRANGE(HRLeaveApp."Application Code",rec."Application Code");
                        IF HRLeaveApp.FIND('-') THEN
                        REPORT.RUN(51516610,TRUE,TRUE,HRLeaveApp);
                    end;
                }
                action("&Post Leave Application")
                {
                    Caption = '&Post Leave Application';
                    Image = Post;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        //SendSMS: Codeunit "51516165";
                    begin
                        UserSetup.RESET;
                        UserSetup.SETRANGE(UserSetup."User ID",USERID);
                        IF UserSetup.FIND('-') THEN
                          /*IF UserSetup."Post Leave Applications"=FALSE THEN
                            ERROR('You are not allowed to post Leave Applications! Contact Administrator for further Guidance!');*/
                        
                        //
                        IF rec.Status = rec.Status::Posted THEN ERROR('This Leave application has already been posted');
                        IF rec.Status<>rec.Status::Approved THEN
                        ERROR('The Leave Status must be Approved');
                        
                        HRLeaveApp.RESET;
                        HRLeaveApp.SETRANGE(HRLeaveApp."Application Code",rec."Application Code");
                        IF HRLeaveApp.FIND('-')THEN BEGIN
                        HRLeaveApp.CreateLeaveLedgerEntries;
                        
                        END;
                        //
                        if rec.status = rec.Status::Posted then
                        begin
                            rec.MODIFY;
                        end;
                        
                        //SendSMS.FnSendEmails('LEAVE APPROVAL','Dear, '+"Employee Name"+' Your '+FORMAT("Days Applied")+' day leave commencing '+FORMAT("Start Date")+
                        //' have been approved, your leave days balance is '+FORMAT("Leave Balance")+' days.',FORMAT("Employee No"),'Leave Application');
                        
                        
                             //To notify leave applicant
                        // IF CONFIRM('Do you wish to notify the employee')=TRUE THEN BEGIN
                        // HREmp.GET("Employee No");
                        // HREmp.TESTFIELD(HREmp."Email Address");
                        // SMTPSetup.GET();
                        // CompInfo.GET();
                        //   SMTPMail.CreateMessage(SMTPSetup."Email Sender Name",SMTPSetup."Email Sender Address",HREmp."Email Address",'Leave Application','',TRUE);
                        //   SMTPMail.AppendBody(STRSUBSTNO('Your leave application is sucessful',HREmp."Full Name","Leave Type","Approved days","Start Date","End Date",USERID));
                        //   SMTPMail.AppendBody(SMTPSetup."Email Sender Name");
                        //   SMTPMail.AppendBody('<br><br>');
                        //   SMTPMail.AddAttachment(Filename,Attachment);
                        //   SMTPMail.Send;
                        // END;
                        //  MESSAGE('Leave applicant has been notified successfully');

                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        EmpDept:='';
        //PASS VALUES TO VARIABLES ON THE FORM
        FillVariables;
        //GET LEAVE STATS FOR THIS EMPLOYEE FROM THE EMPLOYEE TABLE
        GetLeaveStats(rec."Leave Type");
        //TO PREVENT USER FROM SEEING OTHER PEOPLES LEAVE APPLICATIONS
        //SETFILTER("User ID",USERID);

        Updatecontrols;
    end;

    trigger OnInit()
    begin
        NumberofPreviousAttemptsEditab := TRUE;
        "Date of ExamEditable" := TRUE;
        "Details of ExaminationEditable" := TRUE;
        "Cell Phone NumberEditable" := TRUE;
        SupervisorEditable := TRUE;
        RequestLeaveAllowanceEditable := TRUE;
        RelieverEditable := TRUE;
        "Leave Allowance AmountEditable" := TRUE;
        "Start DateEditable" := TRUE;
        "Responsibility CenterEditable" := TRUE;
        "Days AppliedEditable" := TRUE;
        "Leave TypeEditable" := TRUE;
        "Application CodeEditable" := TRUE;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        rec."Responsibility Center":='FINANCE'
    end;

    var
        HREmp: Record "HR Employees";
        EmpJobDesc: Text[50];
        HRJobs: Record "HR Jobss";
        SupervisorName: Text[60];
        //SMTP: Codeunit "400";
        URL: Text[500];
        dAlloc: Decimal;
        dEarnd: Decimal;
        dTaken: Decimal;
        dLeft: Decimal;
        cReimbsd: Decimal;
        cPerDay: Decimal;
        cbf: Decimal;
        HRSetup: Record "HR Setup";
        EmpDept: Text[30];
        ApprovalMgt: Codeunit 1535;
        HRLeaveApp: Record "HR Leave Application";
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,Receipt,"Staff Claim","Staff Advance",AdvanceSurrender,"Store Requisition","Employee Requisition","Leave Application","Transport Requisition","Training Requisition","Job Approval";
        ApprovalEntries: Page 658;
        HRLeaveLedgerEntries: Record "HR Leave Ledger Entries";
        EmpName: Text[70];
        ApprovalComments: Page 660;
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
        Text19010232: Label 'Leave Statistics';
        Text1: Label 'Reliver Details';
        NoSeriesMgt: Codeunit "No. Series";
        UserSetup: Record 91;
        varDaysApplied: Integer;
        HRLeaveTypes: Record "HR Leave Types";  //"51516193";
        BaseCalendarChange: Record 7601;
        ReturnDateLoop: Boolean;
        mSubject: Text[250];
        ApplicantsEmail: Text[30];
        LeaveGjline: Record "HR Leave Ledger Entries";//"51516197";
        "LineNo.": Integer;
        sDate: Record 2000000007;
        Customized: Record "HR E-Mail Parameters";
        HREmailParameters: Record "HR E-Mail Parameters";
        HRLeavePeriods: Record "HR Leave Periods";
        HRJournalBatch: Record "HR Leave Journal Batch";
        //SMTPSetup: Record 409;
        CompInfo: Record 79;
        //SMTPMail: Codeunit 400;
        Filename: Text;
        Selectedfilter: Date;
        Attachment: Text;

    procedure FillVariables()
    begin
        //GET THE APPLICANT DETAILS

        HREmp.RESET;
        IF HREmp.GET(rec."Employee No") THEN
        BEGIN
        EmpName:=HREmp.County+''+HREmp."Home Phone Number"+''+HREmp."Post Code";
        EmpDept:=HREmp."Fax Number";
        END ELSE BEGIN
        EmpDept:='';
        END;

        //GET THE JOB DESCRIPTION FRON THE HR JOBS TABLE AND PASS IT TO THE VARIABLE
        HRJobs.RESET;
        IF HRJobs.GET(rec."Job Tittle") THEN
        BEGIN
        EmpJobDesc:=HRJobs."Job Description";
        END ELSE BEGIN
        EmpJobDesc:='';
        END;

        //GET THE APPROVER NAMES
        HREmp.RESET;
        HREmp.SETRANGE(HREmp."User ID",rec.Supervisor);
        IF HREmp.FIND('-') THEN
        BEGIN
        SupervisorName:=HREmp.County + ' ' + HREmp."Home Phone Number" + ' ' + HREmp."Post Code";
        END ELSE BEGIN
        SupervisorName:='';
        END;
    end;

    procedure GetLeaveStats(LeaveType: Text[50])
    begin
        dAlloc := 0;
        dEarnd := 0;
        dTaken := 0;
        dLeft := 0;
        cReimbsd := 0;
        cPerDay := 0;
        cbf:=0;
        IF HREmp.GET(rec."Employee No") THEN BEGIN
        HREmp.SETFILTER(HREmp."Leave Type Filter",LeaveType);
        HREmp.CALCFIELDS(HREmp."Allocated Leave Days");
        dAlloc := HREmp."Allocated Leave Days";
        HREmp.VALIDATE(HREmp."Allocated Leave Days");
        dEarnd := HREmp."Total (Leave Days)";
        HREmp.CALCFIELDS(HREmp."Total Leave Taken");
        dTaken := HREmp."Total Leave Taken";
        dLeft :=  HREmp."Leave Balance";
        cReimbsd :=HREmp."Cash - Leave Earned";
        //cPerDay := HREmp."Emmergency Leave Total" ; //mutinda
        HREmp.CALCFIELDS(HREmp."Reimbursed Leave Days");
        cbf:=HREmp."Reimbursed Leave Days";
        END;

    end;

    procedure TESTFIELDS()
    begin
        rec.TESTFIELD("Leave Type");
        rec.TESTFIELD("Days Applied");
        rec.TESTFIELD("Start Date");
        rec.TESTFIELD(Reliever);
        rec.TESTFIELD(Supervisor);
    end;

    procedure Updatecontrols()
    begin

        IF rec.Status=rec.Status::New THEN BEGIN
        "Application CodeEditable" :=TRUE;
        "Leave TypeEditable" :=TRUE;
        "Days AppliedEditable" :=TRUE;
        "Responsibility CenterEditable" :=TRUE;
        "Start DateEditable" :=TRUE;
        "Leave Allowance AmountEditable" :=TRUE;
        RelieverEditable :=TRUE;
        RequestLeaveAllowanceEditable :=TRUE;
        SupervisorEditable :=TRUE;
        "Cell Phone NumberEditable" :=TRUE;
        //CurrForm."E-mail Address".EDITABLE:=TRUE;
        "Details of ExaminationEditable" :=TRUE;
        "Date of ExamEditable" :=TRUE;
        NumberofPreviousAttemptsEditab :=TRUE;
        END ELSE BEGIN
        "Application CodeEditable" :=FALSE;
        "Leave TypeEditable" :=FALSE;
        "Days AppliedEditable" :=FALSE;
        "Responsibility CenterEditable" :=FALSE;
        "Start DateEditable" :=FALSE;
        "Leave Allowance AmountEditable" :=FALSE;
        RelieverEditable :=FALSE;
        RequestLeaveAllowanceEditable :=FALSE;
        SupervisorEditable :=FALSE;
        "Cell Phone NumberEditable" :=FALSE;
        //CurrForm."E-mail Address".EDITABLE:=FALSE;
        "Details of ExaminationEditable" :=FALSE;
        "Date of ExamEditable" :=FALSE;
        NumberofPreviousAttemptsEditab :=FALSE;
        END;
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

    procedure DetermineLeaveReturnDate(var fBeginDate: Date;var fDays: Decimal) fReturnDate: Date
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

    procedure DetermineIfIncludesNonWorking(var fLeaveCode: Code[10]): Boolean
    begin
        IF HRLeaveTypes.GET(fLeaveCode) THEN BEGIN
        IF HRLeaveTypes."Inclusive of Non Working Days" = TRUE THEN
        EXIT(TRUE);
        END;
    end;

    procedure DetermineIfIsNonWorking(var bcDate: Date) Isnonworking: Boolean
    begin
        
        HRSetup.FIND('-');
        HRSetup.TESTFIELD(HRSetup."Base Calendar");
        BaseCalendarChange.SETFILTER(BaseCalendarChange."Base Calendar Code",HRSetup."Base Calendar");
        BaseCalendarChange.SETRANGE(BaseCalendarChange.Date,bcDate);
        
        IF BaseCalendarChange.FIND('-') THEN BEGIN
        IF BaseCalendarChange.Nonworking = FALSE THEN
        ERROR('Start date can only be a Working Day Date');
        EXIT(TRUE);
        END;
        
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

    procedure DeterminethisLeaveEndDate(var fDate: Date) fEndDate: Date
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

    procedure CreateLeaveLedgerEntries()
    begin
        /*TESTFIELD("Approved days");
        HRSetup.RESET;
        IF HRSetup.FIND('-') THEN BEGIN
        
        LeaveGjline.RESET;
        LeaveGjline.SETRANGE("Employee No.",HRSetup."Leave Template");
        LeaveGjline.SETRANGE(,HRSetup."Leave Batch");
        LeaveGjline.DELETEALL;
          //Dave
        //HRSetup.TESTFIELD(HRSetup."Leave Template");
        //HRSetup.TESTFIELD(HRSetup."Leave Batch");
        
        HREmp.GET("Employee No");
        HREmp.TESTFIELD(HREmp."Statistics Group Code");
        
        //POPULATE JOURNAL LINES
        
        "LineNo.":=10000;
        LeaveGjline.INIT;
        LeaveGjline."Employee No.":=HRSetup."Leave Template";
        LeaveGjline."Line No.":=HRSetup."Leave Batch";
        LeaveGjline."Line No.":="LineNo.";
        LeaveGjline."From Date":='2017';
        LeaveGjline."Employee Status":="Application Code";
        LeaveGjline.Type:="Employee No";
        LeaveGjline.VALIDATE(LeaveGjline.Type);
        LeaveGjline."Institution/Company":=TODAY;
        LeaveGjline.Cost:=LeaveGjline.Cost::"1";
        LeaveGjline."Course Grade":=TODAY;
        LeaveGjline."Qualification Type":='Leave Taken';
        LeaveGjline."Leave Type":="Leave Type";
        //------------------------------------------------------------
        //HRSetup.RESET;
        //HRSetup.FIND('-');
        HRSetup.TESTFIELD(HRSetup."Leave Posting Period[FROM]");
        HRSetup.TESTFIELD(HRSetup."Leave Posting Period[TO]");
        //------------------------------------------------------------
        LeaveGjline."Leave Period Start Date":=HRSetup."Leave Posting Period[FROM]";
        LeaveGjline."Leave Period End Date":=HRSetup."Leave Posting Period[TO]";
        LeaveGjline."Expiration Date":="Approved days";
        IF LeaveGjline."Expiration Date"<>0 THEN
        LeaveGjline.INSERT(TRUE);
        
        //Post Journal
        LeaveGjline.RESET;
        LeaveGjline.SETRANGE("Employee No.",HRSetup."Leave Template");
        LeaveGjline.SETRANGE("Line No.",HRSetup."Leave Batch");
        IF LeaveGjline.FIND('-') THEN BEGIN
        CODEUNIT.RUN(CODEUNIT::Codeunit55560,LeaveGjline);
        END;
        Status:=Status::Posted;
        MODIFY;
        
        {END ELSE BEGIN
        ERROR('You must specify no of days');
        END;
        END;}
        //NotifyApplicant;
        END;
        */

    end;

    procedure NotifyApplicant()
    begin
        /*HREmp.GET("Employee No");
        HREmp.TESTFIELD(HREmp."Statistics Group Code");
        
        //GET E-MAIL PARAMETERS FOR GENERAL E-MAILS
        HREmailParameters.RESET;
        HREmailParameters.SETRANGE(HREmailParameters."Associate With",HREmailParameters."Associate With"::"Interview Invitations");
        IF HREmailParameters.FIND('-') THEN
        BEGIN
        
        
             HREmp.TESTFIELD(HREmp."Statistics Group Code");
             SMTP.CreateMessage(HREmailParameters."Sender Name",HREmailParameters."Sender Address",HREmp."Statistics Group Code",//"Company E-Mail",
             HREmailParameters.Subject,'Dear'+' '+ HREmp.County +' '+
             HREmailParameters.Body+' '+"Application Code"+' '+ HREmailParameters."Body 2",TRUE);
             SMTP.Send();
        
        
        MESSAGE('Leave applicant has been notified successfully');
        END;
        */

    end;
}




