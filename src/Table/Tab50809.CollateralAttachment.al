table 50809 "Collateral Attachment"
{
    Caption = 'Collateral Attachment';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            AutoIncrement = true;
            Editable = false;
        }

        field(2; "Collateral No."; Code[20])
        {
            Caption = 'Collateral No.';
            TableRelation = "Loan Collateral Register"."Document No";
            Editable = false;
        }

        field(3; "File Name"; Text[250]) { Editable = false;}
        field(4; "File Extension"; Text[10]) { }

        field(5; "Attachment"; Blob)
        {
            Subtype = Bitmap;
        }

        field(6; "Uploaded By"; Code[50]) { Editable = false;}
        field(7; "Uploaded On"; DateTime) {Editable = false; }
    }

    keys
    {
        key(PK; "Entry No.", "Collateral No.","File Name")
        {
            Clustered = true;
        }

        key(Loan; "Collateral No.") { }
    }
}
