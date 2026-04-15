table 50233 "Mpesa Withdawal Buffer"
{
    Caption = 'Mpesa Withdawal Buffer';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No"; Integer)
        {
            Caption = 'Entry No';
            AutoIncrement = true;
        }
        field(2; "Vendor No"; Code[20])
        {
            Caption = 'Vendor No';
        }
        field(3; "Vendor Name"; Text[100])
        {
            Caption = 'Vendor Name';
        }
        field(4; "Amount Requested"; Decimal)
        {
            Caption = 'Amount Requested';
        }
        field(5; "Posted"; Boolean)
        {
            Caption = 'Posted ';
        }
        field(6; "Originator ID"; Code[200])
        {

        }
        field(7; Reversed; Boolean)
        {

        }
        field(8; "Reversed Posted"; Boolean)
        {

        }
        field(9; "Transaction Description"; Text[2048])
        {

        }
        field(10; "Transaction Date"; Date)
        {
            Editable = false;
        }
        field(11; "Member No"; code[20])
        {

        }
        field(12; "Telephone No"; Code[20])
        {

        }
        field(13; Trace; Code[1048])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("MOBILE MPESA Trans".Trace where("Document No" = field("Originator ID")));
        }
        field(14; "Transaction Completed"; Boolean)
        {
            CalcFormula = lookup("MOBILE MPESA Trans"."Transaction Found" where(Trace = field(trace)));
           FieldClass = FlowField;

        }
        field(15; "Posted Time"; Time)
        {}

        field(16; "Account Balance"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = - sum("Detailed Vendor Ledg. Entry".Amount where("Vendor No." = field("Vendor No"), Reversed = filter(false)));
        }
        field(17; "Manual Posting By"; Code[20])
        {}
        field(18; "Manual Posting"; Boolean)
        {}

    }
    keys
    {
        key(PK; "Entry No", "Originator ID", "Member No", "Telephone No")
        {
            Clustered = true;
        }
    }
}
