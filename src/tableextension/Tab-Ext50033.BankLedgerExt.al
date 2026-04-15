//************************************************************************
tableextension 50033 "BankLedgerExt" extends "Bank Account Ledger Entry"
{
    fields
    {
        // Add changes to table fields here
        field(50009; "Running Balance"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50010; "Reversal Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50011; "Transaction Date"; Date)
        {
            DataClassification = ToBeClassified;
            Description = 'Actual Transaction Date(Workdate)';
            Editable = false;
        }
        field(50012; "Application Source"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,CBS,ATM,Mobile,Internet,MPESA,Equity,Co-op,Family,SMS Banking';
            OptionMembers = " ",CBS,ATM,Mobile,Internet,MPESA,Equity,"Co-op",Family,"SMS Banking";
        }
        field(50013; "Created On"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(50014; "Computer Name"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50000; "Transaction Count"; Integer)
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = count("Bank Account Ledger Entry" where("Document No." = field("Document No."), Description = field(Description), Amount = field(Amount), "User ID" = field("User ID")));
        }
        field(50001; Payee; Text[2048])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50002; "Item Specification"; Text[2048])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50003; "Imprest Issued Doc No"; Code[100])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50004; "Time Posted"; DateTime)
        {
            DataClassification = ToBeClassified;
            Editable = false;

        }
        field(50005; "Bank Narration"; Text[2048])
        {
            DataClassification = ToBeClassified;
        }
        field(50006; Reconciled; Boolean)
        {

            trigger OnValidate()
            var
                BankAccReconciliation: Record "Bank Acc. Reconciliation";
            begin
                // BankAccReconciliation.Reset();
                // BankAccReconciliation.SetRange("Bank Account No.", "Bank Account No.");
                // if BankAccReconciliation.Find('-') then begin
                //     "Statement No." := BankAccReconciliation."Statement No.";
                //     Modify(true);
                //     //Message('ARRIVED STATEMENT NU %1', "Statement No.");
                // end;
            end;
        }
        field(50007; "Account Affected"; code[60])
        {
            CalcFormula = lookup("Detailed Vendor Ledg. Entry"."Vendor No." where("Document No." = field("Document No.")));
            FieldClass = FlowField;
        }
        field(50008; "Account ATM"; code[60])
        {
            CalcFormula = lookup("ATM Log Entries3"."ATM No" where("Bank Doc_No" = field("Document No.")));
            FieldClass = FlowField;
        }

    }

    var
        myInt: Integer;
}
