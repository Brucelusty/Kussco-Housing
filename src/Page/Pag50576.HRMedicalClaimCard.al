//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50576 "HR Medical Claim Card"
{
    ApplicationArea = All;
    PageType = Card;
    SourceTable = "HR Medical Claims";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Claim No";Rec."Claim No")
                {

                    trigger OnValidate()
                    begin
                        CurrPage.Update;
                    end;
                }
                field("Member No";Rec."Member No")
                {
                    Caption = 'Employee No.';
                }
                field("Claim Type";Rec."Claim Type")
                {
                }
                field("Claim Date";Rec."Claim Date")
                {
                }
                field("Patient Name";Rec."Patient Name")
                {
                }
                field("Document Ref";Rec."Document Ref")
                {
                    Caption = 'Document No.(From Hospital)';
                }
                field("Date of Service";Rec."Date of Service")
                {
                    Caption = 'Visit Date(Hospital)';
                }
                field("Attended By";Rec."Attended By")
                {
                    Visible = false;
                }
                field(Comments; Rec.Comments)
                {
                }
                field(Dependants; Rec.Dependants)
                {
                }
                field("Amount Charged";Rec."Amount Charged")
                {
                }
                field("Amount Claimed";Rec."Amount Claimed")
                {
                }
                field("Hospital/Medical Centre";Rec."Hospital/Medical Centre")
                {
                }
                field("Claim Limit";Rec."Claim Limit")
                {
                    Editable = false;
                }
                field("User ID";Rec."User ID")
                {
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("&Functions")
            {
                Caption = '&Functions';
                action(Post)
                {
                    Caption = 'Post Claim';
                    Image = PostPrint;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin



                        Rec.TestField("Claim Date");
                        Rec.TestField("Amount Claimed");

                        if Confirm('Do you Wish to Post this transaction?', false) = false then begin exit end;


                        ClaimJNL.Init;
                        ClaimJNL."Document No." := Rec."Document Ref";
                        ClaimJNL."Claim No" := Rec."Claim No";
                        ClaimJNL."Employee No" := Rec."Member No";
                        ClaimJNL."Employee Name" := Rec."Patient Name";
                        ClaimJNL."Claim Date" := Rec."Claim Date";
                        ClaimJNL."Hospital Visit Date" := Rec."Date of Service";
                        ClaimJNL."Claim Limit" := Rec."Claim Limit";
                        ClaimJNL."Balance Claim Amount" := Rec.Balance;
                        ClaimJNL."Amount Charged" := Rec."Amount Charged";
                        ClaimJNL."Amount Claimed" := Rec."Amount Claimed";
                        ClaimJNL.Comments := Rec.Comments;
                        ClaimJNL."USER ID" := UserId;
                        ClaimJNL."Date Posted" := Today;
                        ClaimJNL."Time Posted" := Time;
                        ClaimJNL.Posted := true;
                        ClaimJNL.Insert;



                        Rec."Date Posted" := Today;
                        Rec."Time Posted" := Time;
                        Rec.Posted := true;
                        Rec."Posted By" := UserId;

                        Message('Transaction Posted Successfully');
                    end;
                }
                separator(Action1000000024)
                {
                }
                action(PrintNew)
                {
                    Caption = 'Print/Preview';
                    Image = Print;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        //TESTFIELD(Status,Status::Approved);
                        /*IF (Status=Status::Pending) OR  (Status=Status::"Pending Approval") THEN
                           ERROR('You cannot Print until the document is Approved'); */

                        PHeader2.Reset;
                        PHeader2.SetRange(PHeader2."Member No", Rec."Member No");
                        if PHeader2.FindFirst then
                            Report.run(172199, true, true, PHeader2);

                        /*RESET;
                        SETRANGE("No.","No.");
                        IF "No." = '' THEN
                          REPORT.RUNMODAL(51516000,TRUE,TRUE,Rec)
                        ELSE
                          REPORT.RUNMODAL(51516344,TRUE,TRUE,Rec);
                        RESET;
                        */

                    end;
                }
                action(Approvals)
                {
                    Caption = 'Approvals';
                    Image = Approval;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        ApprovalEntries: Page "Approval Entries";
                    begin

                        if Confirm('Do you Wish to Cancel the approval request', false) = false then begin exit end;/*DocumentType:=DocumentType::ImprestRequisition;
                        ApprovalEntries.Setfilters(DATABASE::"Imprest Header",DocumentType,"No.");
                        ApprovalEntries.RUN;
                        */

                    end;
                }
                action("Send A&pproval Request")
                {
                    Caption = 'Send A&pproval Request';
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        Text001: label 'This Batch is already pending approval';
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        if Confirm('Do you Wish to send this transaction for Approval', false) = false then begin exit end;


                        /*
                        IF ApprovalsMgmt.CheckImprestRequisitionApprovalsWorkflowEnabled(Rec) THEN
                          ApprovalsMgmt.OnSendImprestRequisitionForApproval(Rec);
                        */

                    end;
                }
                action("Canel Approval Request")
                {
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        ApprovalMgt: Codeunit "Approvals Mgmt.";
                    begin
                        //IF ApprovalMgt.CancelBatchAppr(Rec,TRUE,TRUE) THEN;
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        //TO PREVENT USER FROM SEEING OTHER PEOPLES LEAVE APPLICATIONS
        Rec.SetFilter("User ID", UserId);
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        //"Claim Type"='Outpatient';
    end;

    var
        PHeader2: Record "HR Medical Claims";
        HREmp: Record "HR Employees";
        EmpName: Text;
        EmpDept: Text;
        ClaimJNL: Record "HR Medical Claim Entries";

    local procedure FillVariables()
    begin
        //GET THE APPLICANT DETAILS

        HREmp.Reset;
        if HREmp.Get(Rec."Member No") then begin
            EmpName := HREmp.FullName;
            EmpDept := HREmp."Global Dimension 2 Code";
        end else begin
            EmpDept := '';
        end;
    end;
}






