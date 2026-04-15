tableextension 50035 "Departments_Ext" extends "Responsibility Center"
{
    fields
    {
        field(50000; "Department Head"; Code[20])
        {
            TableRelation = "HR Employees"."No." where(Supervisor = filter(true));

            trigger OnValidate()
            begin
                employees.Reset();
                employees.SetRange("No.", "Department Head");
                if employees.Find('-') then begin
                    "Department Head Name" := employees.FullName();
                    "Department Head UserId" := employees."User ID";
                end;
            end;
        }
        field(50001; "Department Head Name"; Text[500])
        {

        }
        field(50002; "Department Head UserId"; Code[20])
        {

        }
        field(50003; Staff; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("HR Employees" where("Responsibility Center" = field(Code)));
        }
        field(50004; "Total KVD Weights"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Departmental KVD Weights"."Total Weight" where("Department code" = field(Code)));
        }
        field(50005; "Is Finance"; Boolean)
        {

        }
    }

    keys
    {
        // Add changes to keys here
    }

    fieldgroups
    {
        // Add changes to field groups here
    }

    var
        myInt: Integer;
        employees: Record "HR Employees";
}
