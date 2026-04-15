table 50779 "Loan Deliberartions"
{
    Caption = 'Loan Deliberartions';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Document No"; Code[60])
        {
            Caption = 'Document No';
        }
        field(2; "Loan Notes"; Text[2048])
        {
            Caption = 'Loan Notes';
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                "User iD" := "User iD";
                Date := WorkDate();
                "time." := time;
            end;
        }
        field(3; "Date"; Date)
        {
            Caption = 'Date';
        }
        field(4; "User iD"; Code[60])
        {
            Caption = 'User iD';
        }
        field(5; Stage; Option)
        {
            Caption = 'Stage';
            OptionCaption = 'Application,Appraisal,Valuation,Credit Committee,Rejected,Disbursed,Closed,Approved,Open,Issued,Approval';
            OptionMembers = Application,Appraisal,Valuation,"Credit Committee",Rejected,Disbursed,Closed,Approved,Open,Issued,Approval;
        }
        field(6; "time."; Time)
        {
            Caption = 'time';
        }
        field(7; "Amount"; Decimal)
        {
            Caption = 'Amount';
        }
        field(8; "Next date"; Date)
        {
            Caption = 'Next Date';
        }
    }
    keys
    {
        key(PK; "Document No", "Loan Notes", Date, "time.", "User iD")
        {
            Clustered = true;
        }
    }
}
