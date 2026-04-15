table 50827 "Loan Income"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            AutoIncrement = true;
        }

        field(2; "Loan No."; Code[20])
        {
            Caption = 'Appraisal No.';
        }

        field(3; "Type of Income"; Option)
        {
            Caption = 'Type of Income';
            OptionMembers = Salary,"Other Business";
        }

        field(4; "Employer/Business"; Text[100])
        {
            Caption = 'Employer/Business';
        }

        field(5; "Gross Income"; Decimal)
        {
            Caption = 'Gross Income';
        }

        field(6; "Net Income"; Decimal)
        {
            Caption = 'Net Income';
        }
    }

    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }

        key(AppraisalKey; "Loan No.")
        {
        }
    }
}
