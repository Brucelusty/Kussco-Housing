page 51023 "Treasury Denominations"
{
    ApplicationArea = All;
    Editable = true;
    PageType = ListPart;
    SourceTable = "Treasury Coinage";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(No;Rec.No)
                {
                    Editable = false;
                    Enabled = false;
                }
                field(Code;Rec.Code)
                {
                    Editable = true;
                    Enabled = true;
                }
                field(Description;Rec.Description)
                {
                    Editable = false;
                    Enabled = true;
                }
                field(Type;Rec.Type)
                {
                    Enabled = true;
                }
                field(Value;Rec.Value)
                {
                    Enabled = true;
                }
                field(Quantity;Rec.Quantity)
                {
                }
                field("Total Amount";Rec."Total Amount")
                {
                    Enabled = false;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        /*Overdue := Overdue::" ";
        IF FormatField(Rec) THEN
          Overdue := Overdue::Yes;*/

    end;

    procedure GetVariables(var LoanNo: Code[20];var LoanProductType: Code[20])
    begin
        /*LoanNo:="Loan  No.";
        LoanProductType:="Loan Product Type"; */

    end;
}




