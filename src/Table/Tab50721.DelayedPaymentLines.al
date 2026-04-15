//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50721 "Delayed Payment Lines"
{

    fields
    {
        field(1; "No."; Integer)
        {

            NotBlank = false;
        }
        field(2; "Account No."; Code[20])
        {
            TableRelation = Vendor."No." where("Creditor Type" = const("FOSA Account"));
            ValidateTableRelation = false;

            trigger OnValidate()
            begin


            end;
        }
        field(3; "Staff No."; Code[20])
        {

            trigger OnValidate()
            begin

            end;
        }
        field(4; Name; Text[100])
        {
        }
        field(5; Amount; Decimal)
        {
            DecimalPlaces = 2 : 2;
        }
        field(6; "Date Filter"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(7; Processed; Boolean)
        {
        }
        field(8; "Document No."; Code[20])
        {
        }
        field(9; Date; Date)
        {
        }
        field(10; "No. Series"; Code[20])
        {
        }

        field(11; "Account Name"; Text[70])
        {
        }
        field(12; "ID No."; Code[30])
        {
        }
        field(13; Closed; Boolean)
        {
        }
        field(14; "Payment Header No."; Code[20])
        {
            TableRelation = "Delayed Payment".No where(No = field("Payment Header No."));
        }
        field(15; "Pension No"; Code[30])
        {
        }
        field(16; "BOSA No"; Code[20])
        {
        }
        field(17; "Mobile Phone Number"; Code[35])
        {
            CalcFormula = lookup(Vendor."Mobile Phone No" where("No." = field("Account No.")));
            FieldClass = FlowField;
        }
        field(18; "Member No"; Code[20])
        {
        }
        field(19; Region; Code[50])
        {
        }
        field(20; Grade; Text[20]) { }

        field(21; "New Salary"; Boolean) { }
    }

    keys
    {
        key(Key1; "Staff No.", "Document No.", "Payment Header No.")
        {
            Clustered = true;
        }
        key(Key2; "Account No.", Date, Processed)
        {
            SumIndexFields = Amount;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        SalBuffer.Reset;
        if SalBuffer.Find('+') then
            "No." := SalBuffer."No." + 1;



    end;

    var
        Acc: Record Vendor;
        NoSetup: Record "Sacco No. Series";
        NoSeriesMgt: Codeunit "No. Series";
        SalBuffer: Record "Salary Processing Lines";
}




