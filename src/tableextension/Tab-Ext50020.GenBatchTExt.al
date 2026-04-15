//************************************************************************
tableextension 50020 "GenBatchTExt" extends "Gen. Journal Batch"
{
    fields
    {
        // Add changes to table fields here

        field(50000; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Open,Pending Approval,Approved,Rejected';
            OptionMembers = Open,"Pending Approval",Approved,Rejected;
        }
        field(50001; "Total Scheduled amount"; Decimal)
        {
            CalcFormula = sum("Gen. Journal Line".Amount where("Journal Template Name" = field("Journal Template Name"),
                                                                "Journal Batch Name" = field(Name)));
            FieldClass = FlowField;
        }
        field(50002; "Batch Document No"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50003; "User ID"; Code[50])
        {
            DataClassification = ToBeClassified;
            Editable = true;
        }

    }

    var
        myInt: Integer;
}


