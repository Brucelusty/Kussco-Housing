//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50483 "HR Job Responsibilities"
{
    ApplicationArea = All;
    Caption = 'HR Job Responsibilities';
    DeleteAllowed = true;
    InsertAllowed = true;
    ModifyAllowed = true;
    PageType = Document;
    PromotedActionCategories = 'New,Process,Reports,Qualification';
    SourceTable = "HR Jobss";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'Job Details';
                field("Job ID";Rec."Job ID")
                {
                    Editable = false;
                    Enabled = false;
                    Importance = Promoted;
                }
                field("Job Description";Rec."Job Description")
                {
                    Editable = false;
                    Enabled = false;
                    Importance = Promoted;
                }
                field("Position Reporting to";Rec."Position Reporting to")
                {
                    Enabled = false;
                }
                field("Supervisor Name";Rec."Supervisor Name")
                {
                    Enabled = false;
                }
                field("No of Posts";Rec."No of Posts")
                {
                    Editable = false;
                    Enabled = false;
                }
                field("Occupied Positions";Rec."Occupied Positions")
                {
                    Editable = false;
                }
                field("Vacant Positions";Rec."Vacant Positions")
                {
                    Editable = false;
                    Enabled = false;

                }
                field("Employee Requisitions";Rec."Employee Requisitions")
                {
                }
            }
            part(Control1102755008; "HR Job Responsiblities Lines")
            {
                Caption = 'Job Responsibilities';
                SubPageLink = "Job ID" = field("Job ID");
            }
        }
        area(factboxes)
        {
            systempart(Control1102755013; Outlook)
            {
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Import Evaluation Areas")
            {
                Image = Import;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;

                trigger OnAction()
                begin

                    //DELETE RESPONSIBILITIES PREVIOUSLY IMPORTED
                    HRJobResponsibilities.Reset;
                    HRJobResponsibilities.SetRange(HRJobResponsibilities."Job ID", Rec."Job ID");
                    if HRJobResponsibilities.Find('-') then
                        HRJobResponsibilities.DeleteAll;

                    //IMPORT EVALUATION AREAS FOR THIS JOB
                    HRAppraisalEvaluationAreas.Reset;
                    HRAppraisalEvaluationAreas.SetRange(HRAppraisalEvaluationAreas."External Source Name", Rec."Job ID");
                    if HRAppraisalEvaluationAreas.Find('-') then
                        HRAppraisalEvaluationAreas.FindFirst;
                    begin
                        HRJobResponsibilities.Reset;
                        repeat
                            HRJobResponsibilities.Init;
                            HRJobResponsibilities."Job ID" := Rec."Job ID";
                            HRJobResponsibilities."Responsibility Code" := HRAppraisalEvaluationAreas."Assign To";
                            HRJobResponsibilities."Responsibility Description" := HRAppraisalEvaluationAreas.Code;
                            HRJobResponsibilities.Insert();
                        until HRAppraisalEvaluationAreas.Next = 0;
                    end;
                end;
            }
        }
    }

    var
        HRJobResponsibilities: Record "HR Job Responsiblities";
        HRAppraisalEvaluationAreas: Record "HR Appraisal Eval Areas";
}




