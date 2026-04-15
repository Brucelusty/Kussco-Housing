//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50467 "HR Appraisal Period List"
{
    ApplicationArea = All;
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "HR Lookup Values";
    SourceTableView = where(Type = filter("Appraisal Period"));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Type; Rec.Type)
                {
                }
                field("Code"; Rec.Code)
                {
                }
                field(Description; Rec.Description)
                {
                }
                field(Remarks; Rec.Remarks)
                {
                }
                field("Notice Period"; Rec."Notice Period")
                {
                }
                field(Closed; Rec.Closed)
                {
                }
                field("Current Appraisal Period"; Rec."Current Appraisal Period")
                {
                }
                field(From; Rec.From)
                {
                }
                field("To"; Rec."To")
                {
                }
                field("Last Date Modified"; Rec."Last Date Modified")
                {
                }
            }
        }
        area(factboxes)
        {
            systempart(Control21; Outlook)
            {
            }
            systempart(Control22; Notes)
            {
            }
            systempart(Control23; MyNotes)
            {
            }
            systempart(Control24; Links)
            {
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Close Period")
            {
                Caption = 'Close Period';
                Image = CloseYear;
                Promoted = true;

                trigger OnAction()
                begin
                    if Confirm('Are you sure you want to close the current period') then begin
                        //----Mark this current period as closed---------------------------------------------------
                        objCurrPeriod.Reset;
                        objCurrPeriod.SetRange(objCurrPeriod.Type, objCurrPeriod.Type::"Appraisal Period");
                        objCurrPeriod.SetRange(objCurrPeriod."Current Appraisal Period", true);
                        if objCurrPeriod.Find('-') then begin
                            NewToDate := CalcDate('3M', objCurrPeriod."To");
                            NewFromDate := CalcDate('3M', objCurrPeriod.From);
                            CurrFromDate := objCurrPeriod.From;
                            CurrToDate := objCurrPeriod."To";
                            currPeriod := objCurrPeriod.Code;
                            objCurrPeriod."Current Appraisal Period" := false;
                            objCurrPeriod.Closed := true;
                            objCurrPeriod.Modify;

                            strNewPeriodDesc := Format(NewFromDate, 0, '<Month Text,3> <Year4>');

                            //---Insert the new appraisal period-------------------------------------------------------
                            objNewPeriod.Init;
                            objNewPeriod.Code := strNewPeriodDesc;
                            objNewPeriod.Type := objNewPeriod.Type::"Appraisal Period";
                            objNewPeriod.Description := strNewPeriodDesc;
                            objNewPeriod.Closed := false;
                            objNewPeriod."Current Appraisal Period" := true;
                            objNewPeriod.From := NewFromDate;
                            objNewPeriod."To" := NewToDate;
                            objNewPeriod."Previous Appraisal Code" := objCurrPeriod.Code;
                            if objCurrPeriod."Appraisal Stage" = objCurrPeriod."appraisal stage"::"Target Setting" then
                                objNewPeriod."Appraisal Stage" := objNewPeriod."appraisal stage"::FirstQuarter
                            else
                                if objCurrPeriod."Appraisal Stage" = objCurrPeriod."appraisal stage"::FirstQuarter then
                                    objNewPeriod."Appraisal Stage" := objNewPeriod."appraisal stage"::SecondQuarter
                                else
                                    if objCurrPeriod."Appraisal Stage" = objCurrPeriod."appraisal stage"::SecondQuarter then
                                        objNewPeriod."Appraisal Stage" := objNewPeriod."appraisal stage"::ThirdQuarter
                                    else
                                        if objCurrPeriod."Appraisal Stage" = objCurrPeriod."appraisal stage"::ThirdQuarter then
                                            objNewPeriod."Appraisal Stage" := objNewPeriod."appraisal stage"::EndYearEvaluation;

                            objNewPeriod.Insert;

                            Message('You have successfully closed and Created a new period');
                        end;
                    end;
                end;
            }
        }
    }

    var
        objCurrPeriod: Record "HR Lookup Values";
        objHRSetup: Record "HR Setup";
        decMonths: Decimal;
        objNewPeriod: Record "HR Lookup Values";
        strNewPeriodDesc: Text;
        NewFromDate: Date;
        NewToDate: Date;
        objAppraisalHeader: Record "HR Appraisal Header";
        objAppraisalLine: Record "HR Appraisal Lines";
        CurrFromDate: Date;
        CurrToDate: Date;
        currPeriod: Code[50];
        objNewAppraisalHeader: Record "HR Appraisal Header";
        NoSeriesMgt: Codeunit "No. Series";
        HRSetup: Record "HR Setup";
        objNewAppraisalHeaderX: Record "HR Appraisal Header";


    procedure newAppraisalStage() newAppraisalStage: Text
    begin
    end;
}






