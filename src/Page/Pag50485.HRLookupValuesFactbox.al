//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50485 "HR Lookup Values Factbox"
{
    ApplicationArea = All;
    Caption = 'HR Lookup Values Factbox';
    PageType = CardPart;
    SourceTable = "HR Lookup Values";

    layout
    {
        area(content)
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
            field("Notice Period";Rec."Notice Period")
            {
            }
            field(Closed; Rec.Closed)
            {
            }
            field("Contract Length";Rec."Contract Length")
            {
            }
            field("Current Appraisal Period";Rec."Current Appraisal Period")
            {
            }
            field("Disciplinary Case Rating";Rec."Disciplinary Case Rating")
            {
            }
            field("Disciplinary Action";Rec."Disciplinary Action")
            {
            }
            field(From; Rec.From)
            {
            }
            field("To";Rec."To")
            {
            }
            field(Score; Rec.Score)
            {
            }
            field("Basic Salary";Rec."Basic Salary")
            {
            }
            field("To be cleared by";Rec."To be cleared by")
            {
            }
        }
    }

    actions
    {
    }
}






