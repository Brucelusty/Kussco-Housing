page 50035 "Cheque Register"
{
    ApplicationArea = All;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = Transactions;
    SourceTableView = where("Type _Transactions" = const("Cheque Deposit"), Posted = filter(true));
    Editable = false;
    DeleteAllowed = false;
    InsertAllowed = false;
    
    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(No;Rec.No)
                {
                }
                field("Cheque No";Rec."Cheque No")
                {
                }
                field("Account No";Rec."Account No")
                {
                }
                field("Account Name";Rec."Account Name")
                {
                }
                field("Cheque Date";Rec."Cheque Date")
                {
                }
                field("Expected Maturity Date";Rec."Expected Maturity Date")
                {
                }
                field("Cheque Status";Rec."Cheque Status")
                {
                }
                field(Amount;Rec.Amount)
                {
                }
            }
        }
        area(Factboxes)
        {
            
        }
    }
    
    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                
                trigger OnAction()
                begin
                    
                end;
            }
        }
    }
}


