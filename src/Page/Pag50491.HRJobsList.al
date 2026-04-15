//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50491 "HR Jobs List"
{
    ApplicationArea = All;
    CardPageID = "HR Jobs Card";
    DelayedInsert = false;
    DeleteAllowed = true;
    InsertAllowed = true;
    ModifyAllowed = false;
    PageType = List;
    UsageCategory = Lists;
    PromotedActionCategories = 'New,Process,Report,Functions,Job,Administration';
    RefreshOnActivate = true;
    SourceTable = "HR Jobss";

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                field("Job ID";Rec."Job ID")
                {
                    Importance = Promoted;
                }
                field("Job Description";Rec."Job Description")
                {
                }
                field("No of Posts";Rec."No of Posts")
                {
                }
                field("Responsibility Center";Rec."Responsibility Center")
                {
                    Enabled = false;
                }
                field("Date Created";Rec."Date Created")
                {
                    StyleExpr = true;
                }
                field(Status; Rec.Status)
                {
                    Style = StandardAccent;
                    StyleExpr = true;
                }
            }
        }
        area(factboxes)
        {
            part(Control1102755002; "HR Jobs Factbox")
            {
                SubPageLink = "Job ID" = field("Job ID");
            }
            systempart(Control1102755004; Outlook)
            {
            }
        }
    }

    actions
    {
        area(processing)
        {
            group(Functions)
            {
                Caption = 'Functions';
                action(Approvals)
                {
                    Caption = 'Approvals';
                    Image = Approvals;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,Receipt,"Staff Claim","Staff Advance",AdvanceSurrender,"Bank Slip",Grant,"Grant Surrender","Employee Requisition","Leave Application","Training Application","Transport Requisition",Job;
                        ApprovalEntries: Page "Approval Entries";
                    begin
                        DocumentType := Documenttype::Job;
                        ApprovalEntries.SetRecordFilters(Database::"HR Jobss", DocumentType, Rec."Job ID");
                        ApprovalEntries.Run;
                    end;
                }
                action("Send Approval Request")
                {
                    Caption = 'Send Approval Request';
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    begin
                        /*
                        IF CONFIRM('Send this job position for Approval?',TRUE)=FALSE THEN EXIT;
                        AppMgmt.SendJobApprovalReq(Rec);
                        */

                    end;
                }
                action("Cancel Approval Request")
                {
                    Caption = 'Cancel Approval Request';
                    Image = CancelAllLines;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    begin
                        /*
                        IF CONFIRM('Cancel Approval Request?',TRUE)=FALSE THEN EXIT;
                        AppMgmt.CancelJobAppRequest(Rec,TRUE,TRUE);
                         */

                    end;
                }
            }
            group(Job)
            {
                Caption = 'Job';
                action("Raise Requisition")
                {
                    Caption = 'Raise Requisition';
                    Image = Job;
                    Promoted = true;
                    PromotedCategory = Category5;
                    RunObject = Page "HR Employee Requisitions List";
                    RunPageLink = "Job ID" = field("Job ID");
                    RunPageOnRec = false;

                    trigger OnAction()
                    begin
                        CurrPage.Close;
                    end;
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
        }
        area(navigation)
        {
            action("Job Requirements")
            {
                Caption = 'Job Requirements';
                Image = ApplicationWorksheet;
                Promoted = true;
                PromotedCategory = Category6;
                RunObject = Page "HR Job Requirements";
                RunPageLink = "Job ID" = field("Job ID");
            }
            action(Action1102755018)
            {
                Caption = 'Job Qualifications';
                Image = QualificationOverview;
                Promoted = true;
                PromotedCategory = Category6;
                RunObject = Page "HR Job Qualifications";
            }
            action("Job Responsibilities")
            {
                Caption = 'Job Responsibilities';
                Image = Relationship;
                Promoted = true;
                PromotedCategory = Category6;
                RunObject = Page "HR Job Responsibilities";
                RunPageLink = "Job ID" = field("Job ID");
            }
            action("Appraisal Evaluation Areas")
            {
                Caption = 'Appraisal Evaluation Areas';
                Image = Evaluate;
                Promoted = true;
                PromotedCategory = Category6;
                // RunObject = Page UnknownPage55633;
            }
            action("Lookup Values")
            {
                Caption = 'Lookup Values';
                Image = List;
                Promoted = true;
                PromotedCategory = Category6;
                RunObject = Page "HR Lookup Values List";
            }
        }
        area(reporting)
        {
            action(Jobs)
            {
                Caption = 'Jobs';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                //RunObject = Report "HR Jobs";
            }
            action("Job Occupants")
            {
                Caption = 'Job Occupants';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                //RunObject = Report "HR Job Occupants";
            }
            action("<Report HR Jobs (Vacant)>")
            {
                Caption = 'Vacant Jobs';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                //  RunObject = Report UnknownReport55583;
            }
            action("<Report HR Jobs (Occupied)>")
            {
                Caption = 'Occupied Jobs';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                //   RunObject = Report UnknownReport55584;
            }
            action("<Report HR Job Responsibilities>")
            {
                Caption = 'Job Responsibilities';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                //  RunObject = Report UnknownReport55590;
            }
            action("<Report HR Job Requirements>")
            {
                Caption = 'Job Qualifications';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                //  RunObject = Report UnknownReport55591;
            }
        }
    }
}






