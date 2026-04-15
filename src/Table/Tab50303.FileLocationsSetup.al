//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50303 "File Locations Setup"
{

    fields
    {
        field(1; Location; Code[20])
        {
        }
        field(2; Description; Text[100])
        {
        }
        field(3; "Custodian Code"; Code[20])
        {
            TableRelation = "HR Employees"."No.";
            
            trigger OnValidate() begin
                employees.Reset();
                employees.SetRange("No.", "Custodian Code");
                if employees.Find('-') then begin
                    "Custodian Name" := employees.FullName();
                    "Custodian UserId" := employees."User ID";
                    "Custodian Department"  := employees."Responsibility Center";
                end;
            end;
        }
        field(4; "Custodian Name"; Text[500])
        {
            Editable = false;
        }
        field(5; "Custodian UserId"; Code[20])
        {
            Editable = false;
        }
        field(6; "Custodian Department"; Code[20])
        {
            TableRelation = "Responsibility Center".Code;
        }
        field(7; "File Storage"; Boolean)
        {
        }
        field(8; "Account Type"; Option)
        {
            OptionCaption = ' ,Member,FOSA,Staff';
            OptionMembers = " ",Member,FOSA,Staff;
        }
    }

    keys
    {
        key(Key1; Location)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
    employees: Record "HR Employees";
}




