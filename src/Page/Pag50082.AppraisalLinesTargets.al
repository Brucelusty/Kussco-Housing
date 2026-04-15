Page 50082 "Appraisal Lines Targets"
{
    ApplicationArea = All;
    PageType = ListPart;
    SourceTable = "Appraissal Lines WP";
    UsageCategory = Tasks;
    SourceTableView = sorting("Key Value Driver");

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Key Value Driver"; Rec."Key Value Driver")
                {
                    Enabled = false;
                    StyleExpr = StyleExprTxt;
                }
                field("Key Performance Indicator"; Rec."Key Performance Indicator")
                {
                    Enabled = false;
                    StyleExpr = StyleExprTxt;
                }
                field("Agreed Performance Targets"; Rec."Agreed Performance Targets")
                {
                    MultiLine = true;
                    Enabled = false;
                    StyleExpr = StyleExprTxt;
                }
                field(Weight; Rec.Weight)
                {
                    Editable = false;
                    StyleExpr = StyleExprTxt;
                }
                // field("Actual Achievement"; Rec."Actual Achievement")
                // {
                // }
                field("Self Assesment Score"; Rec."Self Assesment Score")
                {
                    ShowMandatory = true;
                    Enabled = selfAppraissal;
                    StyleExpr = StyleExprTxt;
                }
                field("Weighted Self Assessment Score";Rec."Weighted Self Assessment Score")
                {
                    Editable = false;
                    Enabled = selfAppraissal;
                    StyleExpr = StyleExprTxt;
                }
                field("Appraisee Comments"; Rec."Appraisee Comments")
                {
                    MultiLine = true;
                    Enabled = selfAppraissal;
                    ShowMandatory = true;
                    StyleExpr = StyleExprTxt;
                }
                field("Supervisor-Assesment"; Rec."Supervisor-Assesment")
                {
                    ShowMandatory = true;
                    StyleExpr = StyleExprTxt;
                    Visible = supervisorAppraisal;
                }
                field("Supervisors Comments"; Rec."Supervisors Comments")
                {
                    Visible = supervisorAppraisal;
                    MultiLine = true;
                    StyleExpr = StyleExprTxt;
                }
                field("Weighted Supervisor Score"; Rec."Weighted Supervisor Score")
                {
                    Visible = supervisorAppraisal;
                    Editable = false;
                    StyleExpr = StyleExprTxt;
                }
            }
        }
    }

    actions
    {

    }

    var
    staffAppraissal: Boolean;
    selfAppraissal: Boolean;
    supervisorAppraisal: Boolean;
    finalAppraisal: Boolean;
    StyleExprTxt: Text;
    appraisalHeader: Record "HR Appraisal Header";

    trigger OnAfterGetCurrRecord() begin
        staffAppraissal := false;
        selfAppraissal := false;
        supervisorAppraisal := false;
        finalAppraisal := false;

        appraisalHeader.Reset();
        appraisalHeader.SetRange("No.", rec."Header No");
        if appraisalHeader.Find('-') then begin
            case appraisalHeader."Appraisal Stage" of
                appraisalHeader."Appraisal Stage"::"Target Setting":
                    begin
                        staffAppraissal := true;
                        selfAppraissal := true;
                        supervisorAppraisal := false;
                        finalAppraisal := false;
                    end;
                appraisalHeader."Appraisal Stage"::"Achieved Target":
                    begin
                        staffAppraissal := true;
                        selfAppraissal := true;
                        supervisorAppraisal := false;
                        finalAppraisal := false;
                    end;
                appraisalHeader."Appraisal Stage"::"Target Approval":
                    begin
                        staffAppraissal := false;
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
                        staffAppraissal := false;
                        selfAppraissal := false;
                        supervisorAppraisal := true;
                        finalAppraisal := true;
                    end;
            end;
        end;

        if Rec."Weighted Supervisor Score" > 70 then begin
            StyleExprTxt := 'Favorable'
        end else if Rec."Weighted Supervisor Score" > 60 then begin
            StyleExprTxt := 'Ambiguous'
        end else if Rec."Weighted Supervisor Score" > 50 then begin
            StyleExprTxt := 'AttentionAccent'
        end else if Rec."Weighted Supervisor Score" > 40 then begin
            StyleExprTxt := 'Unfavorable'
        end else if (Rec."Weighted Supervisor Score" < 40) and (Rec."Weighted Supervisor Score" > 0) then begin
            StyleExprTxt := 'Attention';
        end else if Rec."Weighted Supervisor Score" = 0 then begin
            StyleExprTxt := 'Standard';
        end;
    end;
}



