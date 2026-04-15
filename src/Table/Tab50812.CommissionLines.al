table 50812 "Commission Lines"
{
    Caption = 'Commission Lines';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            AutoIncrement = true;
        }

        field(2; "Document No."; Code[20])
        {
            Caption = 'Document No.';
        }

        field(3; "Member No."; Code[20])
        {
            Caption = 'Member Number';
        }

        field(4; "Commission Amount"; Decimal)
        {
            Caption = 'Commission Amount';
        }

        field(5; "Commission To"; Code[20])
        {
            Caption = 'Commission To';
            trigger OnValidate()
            var
                Member: Record Customer;
            begin
                if Member.Get("Commission To") then
                    "Commission To Name" := Member.Name;
            end;
        }

        field(6; "Commission To Name"; Text[100])
        {
            Caption = 'Commission To Name';
            Editable = false;
        }
    }

    keys
    {
        key(PK; "Entry No.","Document No.")
        {
            Clustered = true;
        }

        key(DocumentKey; "Document No.")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Entry No.", "Document No.", "Member No.")
        {
        }
    }


}
