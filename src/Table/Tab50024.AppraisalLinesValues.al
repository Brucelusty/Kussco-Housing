Table 50024 "Appraisal Lines Values"
{

    fields
    {
        field(1;"Appraisal No.";Integer)
        {
            Editable = false;
            TableRelation = "HR Appraisal Header"."No.";
        }
        field(2;Values;Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Staff Values".Value;
        }
        field(4;Description;Text[2000])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(5;Score;Decimal)
        {
            BlankZero = true;
            DataClassification = ToBeClassified;
        }
        field(6;"Appraisee Comments";Text[300])
        {
            DataClassification = ToBeClassified;
        }
        field(7;"Supervisor Score";Decimal)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate() begin
                if "Supervisor Score" > "Target Score" then Error('The inputted score cannot be greater than the maximum score of %1', "Target Score");

                "Average Score" := Round("Supervisor Score"/"Target Score" * 20, 1, '=');
            end;
        }
        field(8;"Average Score";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(9;"Appraisal Period";Code[60])
        {
            DataClassification = ToBeClassified;
            // Description = 's';
        }
        field(10;"Target Score";Decimal)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate() begin
                if Score > "Target Score" then Error('The inputted score cannot be greater than the maximum score of %1', "Target Score");

                "Weighted Appraisee Score" := Round(Score/"Target Score" * 20, 1, '=');
            end;
        }
        field(14;"Weighted Appraisee Score";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(11;"Supervisors Comments";Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(12;Department;Code[40])
        {
            DataClassification = ToBeClassified;
        }
        field(13;"Header No";Code[60])
        {
        }
    }

    keys
    {
        key(Key1;"Appraisal No.","Header No")
        {
            Clustered = true;
        }
        key(Key2;Values)
        {}
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        if ValuesLines.FindLast then
        "Appraisal No.":=ValuesLines."Appraisal No."+1
        else
        "Appraisal No.":=1;
    end;

    var
        ValuesLines: Record "Appraisal Lines Values";
}

