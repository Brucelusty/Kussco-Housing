//************************************************************************
tableextension 50025 "ApprovalEntryExt" extends "Approval Entry"
{
    fields
    {
        // Add changes to table fields here
        field(50000; "First Modified By User ID"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50001; "First Modified On"; Date)
        {
            DataClassification = ToBeClassified;
        }
    }

    var
        myInt: Integer;
}


