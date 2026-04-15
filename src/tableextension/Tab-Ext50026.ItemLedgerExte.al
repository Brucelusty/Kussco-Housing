//************************************************************************
tableextension 50026 "ItemLedgerExte" extends "Item Ledger Entry"
{
    fields
    {
        // Add changes to table fields here
        field(50000; "Transaction Date"; Date)
        {
            DataClassification = ToBeClassified;
            Description = 'Actual Transaction Date(Workdate)';
            Editable = false;
        }
        field(50001; "Entry Type Two"; code[40])
        {
            DataClassification = ToBeClassified;
            Description = 'Actual Transaction Date(Workdate)';
            Editable = false;
        }
    }

    var
        myInt: Integer;
}


