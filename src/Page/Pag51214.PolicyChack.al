page 51214 "TCC Policy Check"
{
    ApplicationArea = All;
    PageType = ListPart;
    SourceTable = "TCC Recommendations";
    Caption = 'TCC Policy Check';

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Criteria; Rec.Criteria)
                {
                }

                field(Compliance; Rec.Compliance)
                {
                }

                field(Comments; Rec.Comments)
                {
                  //  MultiLine = true;
                }
            }
        }
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        // Automatically link to parent Loan
        Rec."Loan No." := Rec."Loan No.";
    end;
}
