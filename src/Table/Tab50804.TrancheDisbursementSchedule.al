table 50804 "Tranche Disbursement Schedule"
{
    Caption = 'Tranche Disbursement Schedule';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Loan Number"; Code[40])
        {
            Caption = 'Loan Number';
        }
        field(2; "Member No"; Code[40])
        {
            Caption = 'Member No';
        }
        field(3; "Tranche Amount"; Decimal)
        {
            Caption = 'Tranche Amount';
        }
        field(4; "Scheduled Date"; Date)
        {
            Caption = 'Scheduled Date';
        }
        field(5; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
        }
        field(6; Posted; Boolean)
        {
            Caption = 'Posted';
        }
        field(7; "Posted By"; Code[40])
        {
            Caption = 'Posted By';
        }
        field(8; Select; Boolean)
        {
            Caption = 'Select';
        }
        field(9; "Line No."; Integer)
        {
            AutoIncrement = true;
        }
    }
    keys
    {
        key(PK; "Loan Number","Member No","Scheduled Date","Line No.")
        {
            Clustered = true;
        }
    }

}
