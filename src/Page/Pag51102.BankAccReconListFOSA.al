page 51102 "Bank Acc. Recon List FOSA"
{
    ApplicationArea = All;
    Caption = 'Bank Acc. Reconciliation List';
    CardPageID = "Bank Acc. Recon FOSA Card";
    Editable = false;
    PageType = List;
    SourceTable =  "Bank Acc. Reconciliation FOSA";
    SourceTableView = WHERE ("Statement Type"=CONST("Bank Reconciliation"));

    layout
    {
        area(content)
        {
            repeater(GroupName)
            {
                field(BankAccountNo; Rec."Bank Account No.")
                {
                }
                field(StatementNo; Rec."Statement No.")
                {
                }
                field(StatementDate; Rec."Statement Date")
                {
                }
                field(BalanceLastStatement; Rec."Balance Last Statement")
                {
                }
                field(StatementEndingBalance; Rec."Statement Ending Balance")
                {
                }
            }
        }
        area(factboxes)
        {
            // systempart(; Links)
            // {
            //     Visible = false;
            // }
            // systempart(; Notes)
            // {
            //     Visible = false;
            // }
        }
    }

    actions
    {
        area(processing)
        {

        }
    }
}




