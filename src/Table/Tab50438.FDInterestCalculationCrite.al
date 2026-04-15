//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50438 "FD Interest Calculation Crite"
{

    fields
    {
        field(1; "Code"; Code[30])
        {
        }
        field(2; "Minimum Amount"; Decimal)
        {
            NotBlank = true;
        }
        field(3; "Maximum Amount"; Decimal)
        {
            NotBlank = true;
        }
        field(4; "Interest Rate"; Decimal)
        {
        }
        field(5; Duration; DateFormula)
        {
            Editable = false;
        }
        field(6; "On Call Interest Rate"; Decimal)
        {
        }
        field(7; "No of Months"; Integer)
        {
            Editable = false;
        }
        field(8; "FD Rates Speedkey"; Code[50])
        {
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "Code", "FD Rates Speedkey")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert() begin
        fxdTypes.Reset();
        fxdTypes.SetRange(Code, Code);
        if fxdTypes.Find('-') then begin
            Duration:= fxdTypes.Duration;
            "No of Months" := fxdTypes."No. of Months";
        end;
        if "FD Rates Speedkey" = '' then begin
            "FD Rates Speedkey":= Code +'-'+Format("Minimum Amount");
        end;
    end;

    var
    fxdTypes: Record "Fixed Deposit Type";
}




