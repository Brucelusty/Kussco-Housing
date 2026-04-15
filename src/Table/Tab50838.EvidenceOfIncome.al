table 50838 "Evidence Of Income"
{
    DataClassification = ToBeClassified;
    Caption = 'Evidence Of Income';

    fields
    {
        field(1; "Entry No."; Integer)
        {
            AutoIncrement = true;
        }

        field(2; "Loan No."; Code[20])
        {
            Caption = 'Loan No.';
            TableRelation = "Loans Register"."Loan  No."; // replace with your parent table
        }

        field(3; "Evidence Of Income"; Option)
        {
            Caption = 'Evidence Of Income';
            OptionMembers = Payslips,"Bank Statements","Mpesa Statements";
        }

        field(4; "Period Covered"; DateFormula)
        {
            Caption = 'Period Covered';
        } 

        field(5; Observations; Text[1200])
        {
            Caption = 'Observations';
        }
    }

    keys
    {
        key(PK; "Entry No.","Loan No.")
        {
            Clustered = true;
        }

        key(LoanKey; "Loan No.")
        {
        }
    }
}
