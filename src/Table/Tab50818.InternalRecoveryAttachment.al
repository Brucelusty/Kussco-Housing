table 50818 "Internal Recovery Attachment"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            AutoIncrement = true;
            Editable = false;
        }

        field(2; "Loan No."; Code[20])
        {
            Caption = 'Loan No.';
            TableRelation = "Loans Register"."Loan  No.";
            Editable = false;
        }

        field(3; "File Name"; Text[250]) { Editable = false; }
        field(4; "File Extension"; Text[10]) { }

        field(5; "Attachment"; Blob)
        {
            Subtype = Bitmap;
        }

        field(6; "Uploaded By"; Code[50]) { Editable = false; }
        field(7; "Uploaded On"; DateTime) { Editable = false; }
    }

    keys
    {
        key(PK; "Entry No.", "Loan No.","File Name")
        {
            Clustered = true;
        }

        key(Loan; "Loan No.") { }
    }
    
    fieldgroups
    {
        // Add changes to field groups here
    }
    
}
