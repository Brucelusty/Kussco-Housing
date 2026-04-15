table 50723 "Recovery Notes"
{

    fields
    {
        field(1;"Entry No";Integer)
        {
        }
        field(2;"Loan No";Code[40])
        {
            TableRelation = "Loans Register"."Loan  No." WHERE (Posted=CONST(True));
        }
        field(3;"Recovery Notes";Text[200])
        {
        }
        field(4;Date;Date)
        {
            Editable = false;
        }
        field(5;Times;Time)
        {
            Editable = false;
        }
    }

    keys
    {
        key(Key1;"Entry No","Loan No")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        IF RecoveryNotes.FINDLAST THEN
        "Entry No":=RecoveryNotes."Entry No"+1
        ELSE
        "Entry No":=1;
        Date:=TODAY;
        Times:=TIME;
    end;

    var
        RecoveryNotes: Record "Recovery Notes";
}

