tableextension 50000 "BankReconHeadr" extends "Bank Acc. Reconciliation"
{
    fields
    {
        // Add changes to table fields here
        field(50000; "Reconciled Amount"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Bank Account Ledger Entry".Amount where(Reconciled = filter(true), "Statement No." = field("Statement No."), Reversed = filter(false), "Bank Account No." = field("Bank Account No.")));

        }
        field(50001; "Unreconciled"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Bank Account Ledger Entry".Amount where(Reconciled = filter(false), "Statement No." = field("Statement No."), Reversed = filter(false), "Bank Account No." = field("Bank Account No.")));

        }
        field(50002; "Cleared Cheques and Payments"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Bank Account Ledger Entry".Amount where(Reconciled = filter(true), Amount = filter(< 0), Reversed = filter(false), "Statement No." = field("Statement No."), Reversed = filter(false), "Bank Account No." = field("Bank Account No.")));

        }
        field(50003; "Cleared Deposit and Credits"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Bank Account Ledger Entry".Amount where(Reconciled = filter(true), Amount = filter(> 0), Reversed = filter(false), "Statement No." = field("Statement No."), Reversed = filter(false), "Bank Account No." = field("Bank Account No.")));

        }
        field(50004; "UnCleared Cheques and Payments"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Bank Account Ledger Entry".Amount where(Reconciled = filter(false), Amount = filter(< 0), Reversed = filter(false), "Statement No." = field("Statement No."), "Bank Account No." = field("Bank Account No.")));

        }
        field(50005; "UnCleared Deposit and Credits"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Bank Account Ledger Entry".Amount where(Reconciled = filter(false), Reversed = filter(false), Amount = filter(> 0), "Statement No." = field("Statement No."), "Bank Account No." = field("Bank Account No.")));

        }
        field(50006; "Difference"; Decimal)
        {

        }
        field(50007; "Test Report Generated"; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50008; "Posted"; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50009; "Statement Start Date"; Date)
        {

        }
        field(50010; "Total Reconciled"; Decimal)
        {

            FieldClass = FlowField;
            CalcFormula = Sum("Bank Acc. Reconciliation Line"."Applied Amount" WHERE("Bank Account No." = FIELD("Bank Account No."), Reconciled = FILTER(True)));
            Editable = false;
        }
        field(50011; "Difference Btw Statements"; Decimal)
        {

        }
        field(50012; "Total Unreconciled"; Decimal)
        {

            FieldClass = FlowField;
            CalcFormula = Sum("Bank Acc. Reconciliation Line"."Statement Amount" WHERE("Bank Account No." = FIELD("Bank Account No."), Reconciled = CONST(False)));
            Editable = false;
        }

    }

    var
        myInt: Integer;
        bankrec: Record "Bank Acc. Reconciliation";
}
