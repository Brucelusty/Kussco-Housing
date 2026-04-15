table 50816 "Recovery Payment Plan(Legal)"
{
    fields
    {
        field(1; "Plan No."; Integer) {AutoIncrement=true;  Editable = false;}
        field(2; "Case No."; Code[20]) { }
        field(3; "Proposed Amount"; Decimal) { }
        field(4; "Installment Frequency"; Option)
        { OptionMembers = Monthly,Weekly; }
        field(5; "Duration (Months)"; Integer) { }
        field(6; "Status"; Enum "Payment Plan Status") {  }
        field(7; "Committee Decision Date"; Date) { }

        field(8; "Start Date"; Date) {}
        field(9; "Payment Method"; Option) {
            OptionMembers =,"Lump Sum Payment", Installements; 
        }
    }

    keys
    {
        key(Key1; "Plan No.", "Case No.", "Proposed Amount", "Installment Frequency")
        {
            Clustered = true;
        }
    }
    trigger OnModify()
    var
        CaseRec: Record "Defaulter Case";
    begin
        if xRec.Status <> Status then begin
            if Status = Status::Approved then begin
                CaseRec.Get("Case No.");
                CaseRec."Under Payment Plan" := true;
                CaseRec."Recovery Stage" := CaseRec."Recovery Stage"::"Conditional Suspension";
                CaseRec.Modify;
            end;

            if Status = Status::Breached then begin
                CaseRec.Get("Case No.");
                CaseRec."Under Payment Plan" := false;
                CaseRec.Modify;
                Codeunit.Run(50100, CaseRec); // Escalation Engine
            end;
        end;
    end;

}
