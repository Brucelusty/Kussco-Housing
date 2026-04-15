Table 50023 "Appraissal Lines WP"
{

    fields
    {
        field(1;"Appraisal No.";Integer)
        {
            Editable = false;
            TableRelation = "HR Appraisal Header"."No.";
        }
        field(2;"Key Value Driver";Code[40])
        {
            Editable = false;
        }
        field(3;"Key Performance Indicator";Text[200])
        {
            Editable = false;
        }
        field(4;"Agreed Performance Targets";Text[2000])
        {
            Editable = false;
            ValuesAllowed = '"<>"';
        }
        field(5;"Appraisee Comments";Text[1000])
        {
        }
        field(6;"Actual Achievement";Text[200])
        {
        }
        field(8;"Self Assesment Score";Decimal)
        {
            // BlankZero = true;
            DataClassification = ToBeClassified;

            trigger OnValidate() begin
                if "Self Assesment Score" > Weight then Error('You cannot place a score greater than the weight of the KPI of %1', Weight);

                "Weighted Self Assessment Score" := Round("Self Assesment Score"/Weight * 80, 1, '=');
            end;
        }
        field(9;"Weighted Self Assessment Score";Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'Use Rating Scale';
            // Editable = false;
        }
        field(10;"Supervisor-Assesment";Decimal)
        {
            // BlankZero = true;
            Caption = 'Supervisor-Assesment(Score)';
            DataClassification = ToBeClassified;
            
            trigger OnValidate()
            begin
                "Weighted Supervisor Score" := Round(("Supervisor-Assesment"/Weight * 80), 1, '=');
            end;
        }
        field(11;"Supervisors Comments";Text[30])
        {
            DataClassification = ToBeClassified;
            Description = 'Use Rating Scale';
            // Editable = false;
        }
        field(12;"Agreed-Assesment Score";Decimal)
        {
            BlankZero = true;
            DataClassification = ToBeClassified;

        }
        field(13;"Header No";Code[40])
        {
        }
        field(14;"Weighted Supervisor Score";Decimal)
        {
        }
        field(15;Weight;Decimal)
        {
            Editable = false;
        }
    }

    keys
    {
        key(Key1;"Appraisal No.","Header No")
        {
            Clustered = true;
        }
        key(Key2;"Key Value Driver")
        {
        }
        key(Key3;"Key Value Driver", "Key Performance Indicator")
        {
        }
        key(Key4;Weight)
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        if Wplines.FindLast then
        "Appraisal No.":=Wplines."Appraisal No."+1
        else
        "Appraisal No.":=1;
    end;

    var
        Wplines: Record "Appraissal Lines WP";
}

