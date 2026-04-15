//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50550 "HR Training Application Card"
{
    ApplicationArea = All;
    DeleteAllowed = true;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Reports,Functions,Show';
    SourceTable = "HR Training Applications";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Application No";Rec."Application No")
                {
                    Editable = false;
                }
                field("Application Date";Rec."Application Date")
                {
                }
                field("Employee No.";Rec."Employee No.")
                {
                    Editable = "Employee No.Editable";
                }
                field("Training Group No.";Rec."Training Group No.")
                {
                }
                field("No. of Participant";Rec."No. of Participant")
                {
                }
                field("Employee Name";Rec."Employee Name")
                {
                    Editable = false;
                }
                field("Employee Department";Rec."Employee Department")
                {
                    Editable = "Employee DepartmentEditable";
                }
                field("Course Title";Rec."Course Title")
                {
                    Editable = "Course TitleEditable";
                }
                field(Description; Rec.Description)
                {
                }
                field("Purpose of Training";Rec."Purpose of Training")
                {
                    MultiLine = false;
                }
                field("From Date";Rec."From Date")
                {
                }
                field("To Date";Rec."To Date")
                {
                }
                field(Duration; Rec.Duration)
                {
                }
                field("Duration Units";Rec."Duration Units")
                {
                }
                field(Location; Rec.Location)
                {
                }
                field("Cost Of Training";Rec."Cost Of Training")
                {
                    Caption = 'Estimated Cost';
                }
                field("Approved Cost";Rec."Approved Cost")
                {
                }
                field(Provider; Rec.Provider)
                {
                }
                field("Provider Name";Rec."Provider Name")
                {
                    Editable = false;
                }
                field("Responsibility Center";Rec."Responsibility Center")
                {
                    Editable = "Responsibility CenterEditable";
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
            part(Control1102755004; "HR Trainings Factbox")
            {
                SubPageLink = "Application No" = field("Application No");
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
                action(Comments)
                {
                    Caption = 'Comments';
                    Image = Comment;
                    Promoted = true;
                    PromotedCategory = Category5;

                    trigger OnAction()
                    var
                        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,Receipt,"Staff Claim","Staff Advance",AdvanceSurrender,"Bank Slip",Grant,"Grant Surrender","Employee Requisition","Leave Application","Training Application","Transport Requisition";
                    begin
                        DocumentType := Documenttype::"Training Application";

                        //ApprovalComments.Setfilters(DATABASE::"HR Training Applications",DocumentType,"Application No");
                        //ApprovalComments.SetUpLine(DATABASE::"HR Training Applications",DocumentType,"Application No");
                        //ApprovalComments.RUN;
                    end;
                }
            }
            group("F&unctions")
            {
                Caption = 'F&unctions';
            }
            group("Request Approval")
            {
                Caption = 'Request Approval';
                action(SendApprovalRequest)
                {
                    Caption = 'Send A&pproval Request';
                    Enabled = not OpenApprovalEntriesExist;
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category9;

                    trigger OnAction()
                    begin

                        Rec.Status := Rec.Status::Approved;
                        Rec.Modify;
                        Message('Fully Approved');
                        //IF ApprovalsMgmt.CheckSalesApprovalsWorkflowEnabled(Rec) THEN
                        //ApprovalsMgmt.OnSendSalesDocForApproval(Rec);
                    end;
                }
                action(CancelApprovalRequest)
                {
                    Caption = 'Cancel Approval Re&quest';
                    Enabled = OpenApprovalEntriesExist;
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category9;

                    trigger OnAction()
                    begin
                        //ApprovalsMgmt.OnCancelSalesApprovalRequest(Rec);
                    end;
                }
                action("&Print")
                {
                    Caption = '&Print';
                    Image = PrintForm;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    begin
                        Rec.TestField(Status, Rec.Status::Approved);

                        HRTrainingApplications.SetRange(HRTrainingApplications."Application No", Rec."Application No");
                        if HRTrainingApplications.Find('-') then
                            Report.run(172603, true, true, HRTrainingApplications);
                    end;
                }
                action("<A ction1102755042>")
                {
                    Caption = 'Re-Open';
                    Image = ReOpen;
                    Promoted = true;
                    PromotedCategory = Category4;
                    Visible = false;

                    trigger OnAction()
                    begin
                        Rec.Status := Rec.Status::New;
                        Rec.Modify;
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin

        if Rec.Status = Rec.Status::New then begin
            "Responsibility CenterEditable" := true;
            "Application NoEditable" := true;
            "Employee No.Editable" := true;
            "Employee NameEditable" := true;
            "Employee DepartmentEditable" := true;
            "Purpose of TrainingEditable" := true;
            "Course TitleEditable" := true;
        end else begin
            "Responsibility CenterEditable" := false;
            "Application NoEditable" := false;
            "Employee No.Editable" := false;
            "Employee NameEditable" := false;
            "Employee DepartmentEditable" := false;
            "Purpose of TrainingEditable" := false;
            "Course TitleEditable" := false;
        end;
    end;

    trigger OnInit()
    begin
        "Course TitleEditable" := true;
        "Purpose of TrainingEditable" := true;
        "Employee DepartmentEditable" := true;
        "Employee NameEditable" := true;
        "Employee No.Editable" := true;
        "Application NoEditable" := true;
        "Responsibility CenterEditable" := true;
    end;

    var
        HREmp: Record "HR Employees";
        EmpNames: Text[40];
        sDate: Date;
        HRTrainingApplications: Record "HR Training Applications";
        ApprovalComments: Page "Approval Comments";
        [InDataSet]
        "Responsibility CenterEditable": Boolean;
        [InDataSet]
        "Application NoEditable": Boolean;
        [InDataSet]
        "Employee No.Editable": Boolean;
        [InDataSet]
        "Employee NameEditable": Boolean;
        [InDataSet]
        "Employee DepartmentEditable": Boolean;
        [InDataSet]
        "Purpose of TrainingEditable": Boolean;
        [InDataSet]
        "Course TitleEditable": Boolean;
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        ShowWorkflowStatus: Boolean;


    procedure TESTFIELDS()
    begin
        Rec.TestField("Course Title");
        Rec.TestField("From Date");
        Rec.TestField("To Date");
        Rec.TestField("Duration Units");
        Rec.TestField(Duration);
        Rec.TestField("Cost Of Training");
        Rec.TestField(Location);
        Rec.TestField(Provider);
        Rec.TestField("Purpose of Training");
    end;
}






