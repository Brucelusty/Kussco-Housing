page 51016 "Net Salary"
{
    ApplicationArea = All;
    Caption = 'Net Salary ';
    PageType = ListPart;
    SourceTable = "Salary Details";
    Editable=false;
    ModifyAllowed=false;
    DeleteAllowed=false;
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Member No"; Rec."Member No")
                {
                    ToolTip = 'Specifies the value of the Member No field.';
                }
                field("Payroll No"; Rec."Payroll No")
                {
                    ToolTip = 'Specifies the value of the Payroll No field.';
                }
                field(Region; Rec.Region)
                {
                    ToolTip = 'Specifies the value of the Region field.';
                }
                field(Grade; Rec.Grade)
                {
                    ToolTip = 'Specifies the value of the Grade field.';
                }
                field("Gross Amount"; Rec."Gross Amount")
                {
                    ToolTip = 'Specifies the value of the Gross Amount field.';
                }
                field("Net Salary"; Rec."Net Salary")
                {
                    ToolTip = 'Specifies the value of the Net Salary field.';
                }
            }
        }
    }
}


