Page 50088 "Behavioral Objectives"
{
    ApplicationArea = All;
    PageType = ListPart;
    SourceTable = "Appraisal Lines Values";
    DeleteAllowed = false;
    SourceTableView = sorting(Values);

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Values;Rec.Values)
                {
                    Caption = 'Value';
                    Editable = false;
                }
                field(Description;Rec.Description)
                {
                    MultiLine = true;
                    Enabled = false;
                }
                field("Target Score";Rec."Target Score")
                {
                    Editable = false;
                }
                field(Score;Rec.Score)
                {
                    Caption = 'Appraisee Score';
                    ShowMandatory = true;
                    Enabled = selfAppraissal;
                    StyleExpr = StyleExprTxt;
                }
                field("Appraisee Comments";Rec."Appraisee Comments")
                {
                    StyleExpr = StyleExprTxt;
                    Enabled = selfAppraissal;
                    MultiLine = true;
                    ShowMandatory = true;
                }
                field("Weighted Appraisee Score";Rec."Weighted Appraisee Score")
                {
                    StyleExpr = StyleExprTxt;
                    ShowMandatory = true;
                    Editable = false;
                }
                field("Supervisor Score";Rec."Supervisor Score")
                {
                    StyleExpr = StyleExprTxt;
                    ShowMandatory = true;
                    Visible = supervisorAppraisal;
                }
                field("Supervisors Comments";Rec."Supervisors Comments")
                {
                    StyleExpr = StyleExprTxt;
                    ShowMandatory = true;
                    Visible = supervisorAppraisal;
                    MultiLine = true;
                }
                field("Average Score";Rec."Average Score")
                {
                    Caption = 'Supervisor Weighted Score';
                    StyleExpr = StyleExprTxt;
                    Visible = supervisorAppraisal;
                    Editable = false;
                }
            }
        }
    }

    actions
    {
    }

    var
    selfAppraissal: Boolean;
    supervisorAppraisal: Boolean;
    finalAppraisal: Boolean;
    StyleExprTxt: Text;
    appraisalHeader: Record "HR Appraisal Header";

    trigger OnAfterGetRecord()
    begin
        UpdateVisibility();
        UpdateEdition();


    end;

    trigger OnOpenPage()
    begin
        UpdateEdition();
    end;

    procedure UpdateVisibility()
    var
        myInt: Integer;
    begin
        // EvaluationVisibility := false;
        // AppraisalH.Reset();
        // AppraisalH.SetRange("No.", Rec."Appraisal No");
        // if AppraisalH.FindSet() then begin
        //     if (AppraisalH."Appraisal Stage" = AppraisalH."Appraisal Stage"::"End Year Evaluation") or (AppraisalH."Appraisal Stage" = AppraisalH."Appraisal Stage"::"Supervisor Evaluation") or
        //     (AppraisalH."Appraisal Stage" = AppraisalH."Appraisal Stage"::"Appraisal Completed") then begin
        //         EvaluationVisibility := false;
        //     end else
        //         EvaluationVisibility := true;
        // end;
        selfAppraissal := false;
        supervisorAppraisal := false;
        finalAppraisal := false;

        appraisalHeader.Reset();
        appraisalHeader.SetRange("No.", rec."Header No");
        if appraisalHeader.Find('-') then begin
            case appraisalHeader."Appraisal Stage" of
                appraisalHeader."Appraisal Stage"::"Target Setting":
                    begin
                        selfAppraissal := true;
                        supervisorAppraisal := false;
                        finalAppraisal := false;
                    end;
                appraisalHeader."Appraisal Stage"::"Achieved Target":
                    begin
                        selfAppraissal := true;
                        supervisorAppraisal := false;
                        finalAppraisal := false;
                    end;
                appraisalHeader."Appraisal Stage"::"Target Approval":
                    begin
                        selfAppraissal := false;
                        supervisorAppraisal := false;
                        finalAppraisal := false;
                    end;
                appraisalHeader."Appraisal Stage"::"Supervisor Evaluation":
                    begin
                        selfAppraissal := false;
                        supervisorAppraisal := true;
                        finalAppraisal := false;
                    end;
                appraisalHeader."Appraisal Stage"::"Appraisal Completed":
                    begin
                        selfAppraissal := false;
                        supervisorAppraisal := true;
                        finalAppraisal := true;
                    end;
            end;
        end;

        if Rec."Average Score" > 70 then begin
            StyleExprTxt := 'Favorable'
        end else if Rec."Average Score" > 60 then begin
            StyleExprTxt := 'Ambiguous'
        end else if Rec."Average Score" > 50 then begin
            StyleExprTxt := 'AttentionAccent'
        end else if Rec."Average Score" > 40 then begin
            StyleExprTxt := 'Unfavorable'
        end else if (Rec."Average Score" < 40) and (Rec."Average Score" > 0) then begin
            StyleExprTxt := 'Attention';
        end else if Rec."Average Score" = 0 then begin
            StyleExprTxt := 'Standard';
        end;
    end;

    procedure UpdateEdition()
    var

    begin
        // if (Rec."Appraisal Stage" = Rec."Appraisal Stage"::"End Year Evaluation") or (Rec."Appraisal Stage" = Rec."Appraisal Stage"::"Supervisor Evaluation") or
        //     (Rec."Appraisal Stage" = Rec."Appraisal Stage"::"Appraisal Completed") then begin
        //     EditField := false;
        // end else
        //     if (Rec."Appraisal Stage" = Rec."Appraisal Stage"::"Target Setting") then begin
        //         EditField := true;
        //     end;
        //end;
    end;
}



