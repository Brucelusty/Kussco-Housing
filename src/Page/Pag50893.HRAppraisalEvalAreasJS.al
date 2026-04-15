//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50893 "HR Appraisal Eval Areas - JS"
{
    ApplicationArea = All;
    Caption = 'HR Appraisal Evaluation Areas - Job Specific';
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "HR Appraisal Eval Areas";
    SourceTableView = where("Categorize As" = const("Job Specific"));

    layout
    {
        area(content)
        {
            repeater(Control1102760000)
            {
                Editable = true;
                field("Code"; Rec.Code)
                {
                }
                field(Description; Rec.Description)
                {

                    trigger OnValidate()
                    begin
                        Rec.TestField(Code);
                    end;
                }
                field("Assign To"; Rec."Assign To")
                {

                    trigger OnValidate()
                    begin
                        Rec.TestField(Description);
                    end;
                }
                field("Assigned To"; Rec."Assigned To")
                {
                }
                field("Categorize As"; Rec."Categorize As")
                {
                    Editable = false;
                }
                field("Sub Category"; Rec."Sub Category")
                {
                }
                field("Include in Evaluation Form"; Rec."Include in Evaluation Form")
                {
                }
                field("Appraisal Period"; Rec."Appraisal Period")
                {
                }
            }
        }
    }

    actions
    {
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Categorize As" := Rec."categorize as"::"Job Specific";
        Rec."Include in Evaluation Form" := true;
    end;
}






