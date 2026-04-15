tableextension 50032 "PostedBankReconHeadr" extends "Bank Account Statement"
{
    fields
    {
        // Add changes to table fields here
        field(50008; "Reconciled Amount"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Bank Account Statement Line"."Statement Amount" where(Reconciled = filter(true), "Statement No." = field("Statement No."), "Bank Account No." = field("Bank Account No.")));

        }
        field(50009; "Unreconciled"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Bank Account Statement Line"."Statement Amount" where(Reconciled = filter(false), "Statement No." = field("Statement No."), "Bank Account No." = field("Bank Account No.")));

        }
        field(50010; "Cleared Cheques and Payments"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Bank Account Statement Line"."Statement Amount" where(Reconciled = filter(true), "Statement Amount" = filter(< 0), "Statement No." = field("Statement No."), "Bank Account No." = field("Bank Account No.")));

        }
        field(50011; "Cleared Deposit and Credits"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Bank Account Statement Line"."Statement Amount" where(Reconciled = filter(true), "Statement Amount" = filter(> 0), "Statement No." = field("Statement No."), "Bank Account No." = field("Bank Account No.")));

        }
        field(50012; "UnCleared Cheques and Payments"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Bank Account Statement Line"."Statement Amount" where(Reconciled = filter(false), "Statement Amount" = filter(< 0), "Statement No." = field("Statement No."), "Bank Account No." = field("Bank Account No.")));

        }
        field(50013; "UnCleared Deposit and Credits"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Bank Account Statement Line"."Statement Amount" where(Reconciled = filter(false), "Statement Amount" = filter(> 0), "Statement No." = field("Statement No."), "Bank Account No." = field("Bank Account No.")));

        }
        field(50014; "Difference"; Decimal)
        {

        }
        field(50015; "Test Report Generated"; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50000; "Total Balance on Bank Account"; Decimal)
        {
            AutoFormatExpression = GetCurrencyCode();
            AutoFormatType = 1;
            CalcFormula = Sum("Bank Account Ledger Entry".Amount WHERE("Bank Account No." = FIELD("Bank Account No.")));
            Caption = 'Total Balance on Bank Account';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50001; "Total Applied Amount"; Decimal)
        {
            AutoFormatExpression = GetCurrencyCode();
            CalcFormula = Sum("Bank Account Statement Line"."Applied Amount" WHERE(
                                                                                      "Bank Account No." = FIELD("Bank Account No."),
                                                                                      "Statement No." = FIELD("Statement No.")));
            Caption = 'Total Applied Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50002; "Total Transaction Amount"; Decimal)
        {
            AutoFormatExpression = GetCurrencyCode();
            CalcFormula = Sum("Bank Account Statement Line"."Statement Amount" WHERE(
                                                                                        "Bank Account No." = FIELD("Bank Account No."),
                                                                                        "Statement No." = FIELD("Statement No.")));
            Caption = 'Total Transaction Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50003; "Total Unposted Applied Amount"; Decimal)
        {
            AutoFormatExpression = GetCurrencyCode();
            CalcFormula = Sum("Bank Account Statement Line"."Applied Amount" WHERE(
                                                                                      "Bank Account No." = FIELD("Bank Account No."),
                                                                                      "Statement No." = FIELD("Statement No.")
                                                                                      ));
            Caption = 'Total Unposted Applied Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50004; "Total Difference"; Decimal)
        {
            AutoFormatExpression = GetCurrencyCode();
            CalcFormula = Sum("Bank Account Statement Line".Difference WHERE(
                                                                                "Bank Account No." = FIELD("Bank Account No."),
                                                                                "Statement No." = FIELD("Statement No.")));
            Caption = 'Total Difference';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50005; "Total Paid Amount"; Decimal)
        {
            AutoFormatExpression = GetCurrencyCode();
            CalcFormula = Sum("Bank Account Statement Line"."Statement Amount" WHERE(
                                                                                        "Bank Account No." = FIELD("Bank Account No."),
                                                                                        "Statement No." = FIELD("Statement No."),
                                                                                        "Statement Amount" = FILTER(< 0)));
            Caption = 'Total Paid Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50006; "Total Received Amount"; Decimal)
        {
            AutoFormatExpression = GetCurrencyCode();
            CalcFormula = Sum("Bank Account Statement Line"."Statement Amount" WHERE(
                                                                                        "Bank Account No." = FIELD("Bank Account No."),
                                                                                        "Statement No." = FIELD("Statement No."),
                                                                                        "Statement Amount" = FILTER(> 0)));
            Caption = 'Total Received Amount';
            Editable = false;
            FieldClass = FlowField;
        }

        field(50007; "Cash Book Balance"; Decimal)
        {

        }

    }
    local procedure GetCurrencyCode(): Code[10]
    var
        BankAcc2: Record "Bank Account";
    begin
        if "Bank Account No." = BankAcc2."No." then
            exit(BankAcc2."Currency Code");

        if BankAcc2.Get("Bank Account No.") then
            exit(BankAcc2."Currency Code");

        exit('');
    end;

    var
        myInt: Integer;
        bankrec: Record "Bank Account Statement";
}
