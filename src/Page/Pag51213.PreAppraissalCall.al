page 51213 "Pre-Appraisal Call Part"
{
    ApplicationArea = All;
    PageType = ListPart;
    SourceTable = "Pre-Appraisal Call";
    Caption = 'Pre-Appraisal Call';

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Preappraisal Correspondence"; Rec."Preappraisal Correspondence")
                {
                }

                field(Explained; Rec.Explained)
                {
                }

                field(Comment; Rec.Comment)
                {
                }
            }
        }
    }
}
