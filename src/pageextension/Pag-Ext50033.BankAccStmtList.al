pageextension 50033 "Bank Acc. Stmt List" extends "Bank Account Statement List"
{
    layout
    {
        // Add changes to page layout here
    }
    
    actions
    {
        // Add changes to page actions here
        // modify(Print)
        // {
        //     // Visible = false;
        // }
        addBefore(Print)
        {
            action(ConvRep)
            {   
                ApplicationArea = Basic, Suite;
                Caption = 'Converted Print';
                // Ellipsis = true;
                Image = TestReport;
                Scope = Repeater;
                trigger OnAction() begin
                    bankRec.Reset();
                    bankRec.SetRange("Bank Account No.", rec."Bank Account No.");
                    bankRec.SetRange("Statement No.", rec."Statement No.");
                    if bankRec.Find('-') then
                        Report.Run(175073, true, false, bankRec);
                end;
            }
        }
    }
    
    var
    myInt: Integer;
    bankRec: Record "Bank Account Statement";
}
