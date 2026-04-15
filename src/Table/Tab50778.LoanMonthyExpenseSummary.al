table 50778 "Loan Monthy Expense Summary"
{
    Caption = 'Loan Monthy Expense Summary';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Document No"; Code[40])
        {
            Caption = 'Document No';
        }
        field(2; Lender; Code[500])
        {
            Caption = 'Lender';
        }
        field(3; "Outstanding Balance"; Decimal)
        {
            Caption = 'Outstanding Balance';
        }
        field(4; "Monthly Repayment"; Decimal)
        {
            Caption = 'Monthly Repayment';
        }
        field(5; "Source Of Funds For Repayment"; Text[1200])
        {
            Caption = 'Source Of Funds For Repayment';
        }
        field(6; "Loan Clearance Period"; Integer)
        {
            Caption = 'Loan Clearance Period';
        }
        field(7; "Type Of Loan"; Text[400])
        {
            Caption = 'Type Of Loan';
        }
    }
    keys
    {
        key(PK; "Document No", Lender, "Outstanding Balance", "Monthly Repayment", "Source Of Funds For Repayment")
        {
            Clustered = true;
        }
    }
}
