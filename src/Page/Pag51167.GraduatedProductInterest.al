namespace PROGRESSIVE.PROGRESSIVE;

page 51167 "Graduated Product Interest"
{
    ApplicationArea = All;
    Caption = 'Graduated Product Interest';
    PageType = ListPart;
    SourceTable = "Product Graduated Interest";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Product Code"; Rec."Product Code")
                {
                    ToolTip = 'Specifies the value of the Product Code field.', Comment = '%';
                    Visible = false;
                }
                field("Minimum Installment"; Rec."Minimum Installment")
                {
                    ToolTip = 'Specifies the value of the Minimum Installment field.', Comment = '%';
                }
                field("Maximum Installment"; Rec."Maximum Installment")
                {
                    ToolTip = 'Specifies the value of the Maximum Installment field.', Comment = '%';
                }

                field(Percentage; Rec.Percentage)
                {
                    ToolTip = 'Specifies the value of the Percentage field.', Comment = '%';
                }

            }
        }
    }
}


