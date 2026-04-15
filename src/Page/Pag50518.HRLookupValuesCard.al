//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50518 "HR Lookup Values Card"
{
    ApplicationArea = All;
    PageType = Card;
    SourceTable = "HR Lookup Values";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field(Type; Rec.Type)
                {
                }
                field("Code"; Rec.Code)
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("Supervisor Only"; Rec."Supervisor Only")
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
                label(Control1102755023)
                {
                    CaptionClass = Text19024457;
                }
                field(Score; Rec.Score)
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
                field("Basic Salary";Rec."Basic Salary")
                {
                }
                field("To be cleared by";Rec."To be cleared by")
                {
                }
                field("Last Date Modified";Rec."Last Date Modified")
                {
                    Editable = false;
                }
            }
        }
    }

    actions
    {
    }

    var
        Text19024457: label 'Months';
}






