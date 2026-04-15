table 50840 "TCC Recommendations"
{
    Caption = 'TCC Recommendations';
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
            TableRelation = "Loans Register"."Loan  No."; // adjust if your parent table name differs
        }

        field(3; Criteria; Option)
        {
            Caption = 'Criteria';
            OptionMembers = "Membership >6months",
                            "Active Account",
                            "Shareholding Adequate",
                            "Savings Threshold Met";
        }

        field(4; Compliance; Option)
        {
            Caption = 'Compliance';
            OptionMembers = Complied,"Not Complied";
        }

        field(5; Comments; Text[1200])
        {
            Caption = 'Comments';
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
