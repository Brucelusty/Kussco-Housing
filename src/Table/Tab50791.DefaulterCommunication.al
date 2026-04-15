table 50791 "Defaulter Communication"
{
    fields
    {
        field(1; "Entry No."; Integer) { AutoIncrement = true; }
        field(2; "Case No."; Code[20]) { }
        field(3; "Date Time"; DateTime) { }
        field(4; "Channel"; Enum "Communication Channel") { }
        field(5; "Outcome"; Enum "Communication Outcome") { }
        field(6; "Summary"; Text[250]) { }
        field(7; "Promise To Pay Date"; Date) { }
        field(8; "Created By"; Code[50]) {  Editable = false;}
        field(9; "Call Attempts"; Enum "Call Attemps") { }
        field(10; "Next Follow-up Date"; Date) { }
    }


    keys
    {
        key(Key1; "Entry No.","Case No.","Date Time",Channel)
        {
            Clustered = true;
            
        }
    }
    trigger OnInsert()
    var
        myInt: Integer;
    begin
        "Created By" := USERID;
    end;
}
