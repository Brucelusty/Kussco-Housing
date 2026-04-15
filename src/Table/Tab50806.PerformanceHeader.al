table 50806 "Performance Header"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[20]) {Editable=false; }
        field(2; "Period"; Date) { }
        field(3; "Scope"; Enum "Performance Scope") { }
        field(4; "Officer ID"; Code[20]) { }
        field(5; "Branch Code"; Code[20]) { }
        field(6; "Total Score"; Decimal) { }
        field(7; "Rating"; Enum "Performance Rating") { }
        field(8; Status; Option) { OptionMembers = Open,Calculated,Approved; }
    }

    keys
    {
        key(PK; "No.") { Clustered = true; }
    }

    trigger OnInsert()
    var
        NoSeriesMgt: Codeunit "No. Series";
        KPI: Record "Sacco No. Series";
    begin
        KPI.Get();
        if "No." = '' then
            "No." := NoSeriesMgt.GetNextNo(KPI."Performance Header No");

        Status := Status::Open;
    end;
}


