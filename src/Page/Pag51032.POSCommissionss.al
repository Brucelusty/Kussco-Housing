page 51032 "POS Commissionss"
{
    ApplicationArea = All;
    Caption = 'POS Commissions ';
    PageType = List;
    SourceTable = "POS Commissions";
    //Editable = false;
    //ModifyAllowed = false;
   // DeleteAllowed = false;
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Lower Limit"; Rec."Lower Limit")
                {
                    ToolTip = 'Specifies the value of the Member No field.';
                }
                field("Upper Limit"; Rec."Upper Limit")
                {
                    ToolTip = 'Specifies the value of the Payroll No field.';
                }
                field("Charge Amount"; Rec."Charge Amount")
                {
                    ToolTip = 'Specifies the value of the Region field.';
                }
                field("Bank charge"; Rec."Bank charge")
                {
                    ToolTip = 'Specifies the value of the Grade field.';
                }
                field("Bank charge Account"; Rec."Bank charge Account")
                {
                    ToolTip = 'Specifies the value of the Gross Amount field.';
                }
                field("Sacco charge"; Rec."Sacco charge")
                {
                    ToolTip = 'Specifies the value of the Net Salary field.';
                }

                field("Sacco charge Account"; Rec."Sacco charge Account")
                {
                    ToolTip = 'Specifies the value of the Net Salary field.';
                }
                field("Excise Duty"; Rec."Excise Duty")
                {
                    ToolTip = 'Specifies the value of the Net Salary field.';
                }
                field("Total Charge"; Rec."Total Charge")
                {
                    ToolTip = 'Specifies the value of the Net Salary field.';
                }
                field("Transaction Type"; Rec."Transaction Type")
                {
                    ToolTip = 'Specifies the value of the Net Salary field.';
                }
            }
        }
    }
}


