namespace KUSCCOHOUSING.KUSCCOHOUSING;

page 51185 "Loan Deliberations"
{
    ApplicationArea = All;
    Caption = 'Loan Deliberations';
    PageType = ListPart;
    SourceTable = "Loan Deliberartions";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Loan Notes"; Rec."Loan Notes")
                {
                    ToolTip = 'Specifies the value of the Loan Notes field.', Comment = '%';
                    //MultiLine=true;
                }
                field(Amount; Rec.Amount)
                {
                    ToolTip = 'Specifies the value of the Amount field.', Comment = '%';
                    //MultiLine=true;
                }
                field("Next date"; Rec."Next date")
                {
                    ToolTip = 'Specifies the value of the Next Date field.', Comment = '%';
                    //MultiLine=true;
                }
                field("User iD"; Rec."User iD")
                {
                    ToolTip = 'Specifies the value of the User iD field.', Comment = '%';
                    Editable = false;
                    Caption = 'User ID';
                }


            }
        }
    }
}


