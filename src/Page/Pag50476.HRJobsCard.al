//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50476 "HR Jobs Card"
{
    ApplicationArea = All;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Report,Functions,Job';
    SourceTable = "HR Jobss";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Job ID";Rec."Job ID")
                {
                    Importance = Promoted;
                }
                field("Job Description";Rec."Job Description")
                {
                    Importance = Promoted;
                }
                field("Position Reporting to";Rec."Position Reporting to")
                {
                    Importance = Promoted;
                }
                field("Global Dimension 2 Code";Rec."Global Dimension 2 Code")
                {
                }
                field(Grade; Rec.Grade)
                {
                }
                field("Main Objective";Rec."Main Objective")
                {
                }
                field("Supervisor/Manager";Rec."Supervisor/Manager")
                {
                }
                field("Supervisor Name";Rec."Supervisor Name")
                {
                }
                field("No of Posts";Rec."No of Posts")
                {
                    Importance = Promoted;
                }
                field("Occupied Positions";Rec."Occupied Positions")
                {
                    Importance = Promoted;
                }
                field("Vacant Positions";Rec."Vacant Positions")
                {
                    Importance = Promoted;
                }
                field("Responsibility Center";Rec."Responsibility Center")
                {
                }
                field("Employee Requisitions";Rec."Employee Requisitions")
                {
                }
                field("Key Position";Rec."Key Position")
                {
                }
                field("Date Created";Rec."Date Created")
                {
                    Editable = false;
                    Style = StrongAccent;
                    StyleExpr = true;
                }
                field("Is Supervisor";Rec."Is Supervisor")
                {
                }
                field("G/L Account";Rec."G/L Account")
                {
                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                    Importance = Promoted;
                    Style = StrongAccent;
                    StyleExpr = true;
                }
            }
        }
        area(factboxes)
        {
            part(Control1102755004; "HR Jobs Factbox")
            {
                SubPageLink = "Job ID" = field("Job ID");
            }
            systempart(Control1102755006; Outlook)
            {
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Job)
            {
                action("Raise Requisition")
                {
                    Caption = 'Raise Requisition';
                    Image = Job;
                    Promoted = true;
                    PromotedCategory = Category5;
                    RunObject = Page "HR Employee Requisition Card";
                    RunPageLink = "Job ID" = field("Job ID");
                }
                action("Job Qualifications")
                {
                    Caption = 'Job Qualifications';
                    Image = Card;
                    Promoted = true;
                    PromotedCategory = Category5;
                    RunObject = Page "HR Job Requirement Lines";
                    RunPageLink = "Job Id" = field("Job ID");
                }
                action(Responsibilities)
                {
                    Caption = 'Responsibilities';
                    Image = JobResponsibility;
                    Promoted = true;
                    PromotedCategory = Category5;
                    RunObject = Page "HR Job Responsiblities Lines";
                    RunPageLink = "Job ID" = field("Job ID");
                }
                action(Occupants)
                {
                    Caption = 'Occupants';
                    Image = ContactPerson;
                    Promoted = true;
                    PromotedCategory = Category5;
                    RunObject = Page "HR Job Occupants";
                    RunPageLink = "Job ID" = field("Job ID");
                }
            }
            group(Functions)
            {
                Caption = 'Functions';
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
                        //IF ApprovalsMgmt.CheckSalesApprovalsWorkflowEnabled(Rec) THEN
                        // ApprovalsMgmt.OnSendSalesDocForApproval(Rec);
                        Rec.Status := Rec.Status::Approved;
                        Rec.Modify;
                        Message('Job Approved!')
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
                        Rec.Status := Rec.Status::New;
                        Rec.Modify;
                        Message('Approval Cancelled!')
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        UpdateControls;

        Rec.Validate("Vacant Positions");
    end;

    var
        HREmployees: Record "HR Employees";
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        ShowWorkflowStatus: Boolean;

    local procedure UpdateControls()
    begin
        if Rec.Status = Rec.Status::New then begin
            CurrPage.Editable := true;
        end else begin
            CurrPage.Editable := false;
        end;
    end;


    procedure RecordLinkCheck(job: Record "HR Jobss") RecordLnkExist: Boolean
    var
        objRecordLnk: Record "Record Link";
        TableCaption: RecordID;
        objRecord_Link: RecordRef;
    begin
        objRecord_Link.GetTable(job);
        TableCaption := objRecord_Link.RecordId;
        objRecordLnk.Reset;
        objRecordLnk.SetRange(objRecordLnk."Record ID", TableCaption);
        if objRecordLnk.Find('-') then exit(true) else exit(false);
    end;
}






