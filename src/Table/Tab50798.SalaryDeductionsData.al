table 50798 "Salary Deductions Data"
{
    Caption = 'Salary Deductions Data';
    DataClassification = ToBeClassified;
    
    fields
    {
        field(1; "Entry No"; Integer)
        {
            Caption = 'Entry No';
        }
        field(2; "Document No"; Code[40])
        {
            Caption = 'Document No';
            TableRelation = "Salary Processing Headerr".No;
        }
        field(3; "Member No"; Code[40])
        {
            Caption = 'Member No';
            TableRelation = Customer."No.";
        }
        field(4; "Vendor No"; Code[40])
        {
            Caption = 'Vendor No';
        }
        field(5; Description; Text[80])
        {
            Caption = 'Description';
        }
        field(6; Amount; Decimal)
        {
            Caption = 'Amount';
        }
        field(7; Name;Text[200])
        {
            Caption = 'Name';
        }
        field(8; "Transaction Type"; Code[20])
        {
        }
        field(9; "Transaction Type Name"; Text[2000])
        {
        }
        field(10; "Expected Amount"; Decimal)
        {
        }
    }
    keys
    {
        key(PK; "Entry No")
        {
            Clustered = true;
        }
    }
}
