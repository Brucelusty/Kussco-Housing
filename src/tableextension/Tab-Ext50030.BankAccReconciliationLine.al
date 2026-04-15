tableextension 50030 "BankAccReconciliationLine" extends "Bank Acc. Reconciliation Line"
{
    fields
    {
        field(50006; Reconcile; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50007; "Payee Name"; Text[2048])
        {
            DataClassification = ToBeClassified;
        }
        field(50008; "Cash Book Narration"; Text[2048])
        {
            DataClassification = ToBeClassified;
        }
        field(50009; "Cash In"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50010; "Payment"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50020; "Entry No"; Integer)
        {
            Editable = false;
        }
        field(50030;Reconciled;Boolean)
        {

            trigger OnValidate()
            var
                // BankAccStatementLine: Record "50000";
            begin
                /*
                IF xRec.Reconciled = FALSE THEN ERROR('Please use the match manually function');
                //IF "Bank Ledger Entry Line No" = TRUE THEN ERROR('Please remove match for this entry from the bank statement');
                IF NOT CONFIRM('Are you sure you want to un-reconcile this entry') THEN ERROR('You have chosen to leave entry reconciled');
                RemoveApplication(Type);
                
                //**changes
                BankAccStatementLine.RESET;
                BankAccStatementLine.SETRANGE("Bank Account No.","Bank Account No.");
                BankAccStatementLine.SETRANGE("Statement No.","Statement No.");
                BankAccStatementLine.SETRANGE("Statement Line No.","Bank Statement Entry Line No");
                IF BankAccStatementLine.FINDFIRST THEN
                BEGIN
                
                  BankAccStatementLine."Applied Amount" -= "Statement Amount";
                  BankAccStatementLine."Applied Entries" := BankAccStatementLine."Applied Entries" - 1;
                
                  BankAccStatementLine.VALIDATE("Statement Amount");
                  BankAccStatementLine.MODIFY;
                END
                */

            end;
        }
        field(50031;"Open Type";Option)
        {
            OptionCaption = ' ,Unpresented Cheques List,Uncredited Cheques List';
            OptionMembers = " ",Unpresented,Uncredited;
        }
        field(50032;"Bank Ledger Entry Line No";Integer)
        {
        }
        field(50033;"Bank Statement Entry Line No";Integer)
        {
        }
        field(50034;"Reconciling Date";Date)
        {
        }
    }

    var
        myInt: Integer;
}
