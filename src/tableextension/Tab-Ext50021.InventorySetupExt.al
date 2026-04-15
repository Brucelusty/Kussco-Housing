//************************************************************************
tableextension 50021 "InventorySetupExt" extends "Inventory Setup"
{
    fields
    {
        // Add changes to table fields here
        field(50000; "Item Jnl Template"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Item Journal Template";
        }
        field(50001; "Item Jnl Batch"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Item Journal Batch".Name;
        }
        field(50002; "Default Location Stock Limit"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50003; "Internal Return Nos"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
    }

    var
        myInt: Integer;
}


