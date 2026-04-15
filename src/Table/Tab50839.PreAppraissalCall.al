table 50839 "Pre-Appraisal Call"
{
    Caption = 'Pre-Appraisal Call';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            AutoIncrement = true;
        }

        field(2; "Loan No."; Code[20])
        {
            Caption = 'Loan No.';
            // Adjust the parent table if needed
            TableRelation = "Loans Register"."Loan  No.";
        }

        field(3; "Preappraisal Correspondence"; Option)
        {
            Caption = 'Preappraisal Correspondence';
            OptionMembers = Introduction,"Loan Process Explanation",
                            "Loan Payment Expectation",
                            "Loan Cost",
                            "Status Of Land";
        }

        field(4; Explained; Boolean)
        {
            Caption = 'Explained';
        }

        field(5; Comment; Text[1200])
        {
            Caption = 'Comment';
        }
    }

    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }

        key(LoanKey; "Loan No.")
        {
        }
    }
}
