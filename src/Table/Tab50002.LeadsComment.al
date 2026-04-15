table 50002 "Leads Comment"
{
    DataClassification = CustomerContent;
    Caption = 'BC Central Header';

    fields
    {
        field(1; "Document No."; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Document No.';
            trigger OnValidate()
            begin
                "User ID" := UserId;
            end;
        }
        field(2; Description; Text[1500])
        {
            DataClassification = CustomerContent;
            Caption = 'Description';
        }
        field(3; "Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption='Interaction Date';

        }
        field(4; "User ID"; Code[60])
        {
            DataClassification = EndUserIdentifiableInformation;
            Caption = 'User ID';
            Editable = false;
            TableRelation = User."User Name";
            // ValidateTableRelation = false; // Set to false if you want to allow legacy IDs
        }
        field(5; "Interaction Type"; Enum "BD Activity Type")
        {
            DataClassification = CustomerContent;
            Caption = 'Interaction Type';
        }
    }

    keys
    {
        key(PK; "Document No.", Description, Date)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        // Adds a preview when looking up this table
        fieldgroup(DropDown; "Document No.", Description, "Date") { }
    }
}
