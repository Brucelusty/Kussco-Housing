page 50220 "Bank Acc. Reconciliation List2"
{
    ApplicationArea = All;
    Caption = 'Bank Account Reconciliations Posted';
    //Editable = false;
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    Editable = false;
    PageType = List;
    CardPageId = "Bank Acc. Reconciliation2";
    PromotedActionCategories = 'New,Process,Report,Posting';
    SourceTable = "Bank Reconciliation Header";
   
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field(BankAccountNo; Rec."Bank Account No.")
                {
                    ToolTip = 'Specifies the number of the bank account that you want to reconcile with the bank''s statement.';
                }
                field(StatementNo; Rec."Statement No.")
                {
                    ToolTip = 'Specifies the number of the bank account statement.';
                }
                field(StatementDate; Rec."Statement Date")
                {
                    ToolTip = 'Specifies the date on the bank account statement.';
                }
                field(BalanceLastStatement; Rec."Balance Last Statement")
                {
                    ToolTip = 'Specifies the ending balance shown on the last bank statement, which was used in the last posted bank reconciliation for this bank account.';
                }
                field(StatementEndingBalance; Rec."Statement Ending Balance")
                {
                    ToolTip = 'Specifies the ending balance shown on the bank''s statement that you want to reconcile with the bank account.';
                }
            }
        }
        area(factboxes)
        {
            systempart(Control1900383207; Links)
            {
                Visible = false;
            }
            systempart(Control1905767507; Notes)
            {
                Visible = false;
            }
        }
    }

    actions
    {
        area(processing)
        {



        }
    }

    trigger OnInit()
    begin
        //  UseSharedTable := true;
    end;

    trigger OnOpenPage()
    begin
        // Refresh;
    end;

    var
        UseSharedTable: Boolean;
        DeleteConfirmQst: Label 'Do you want to delete the Reconciliation?';

    local procedure Refresh()
    var
        //BankReconciliationMgt: Codeunit "Bank Reconciliation Mgt.";
    begin
        //DeleteAll();
        //BankReconciliationMgt.Refresh(Rec);
    end;
}



