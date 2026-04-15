//************************************************************************
tableextension 50006 "VendorledgerExt" extends "Vendor Ledger Entry"
{
    fields
    {
        // Add changes to table fields here
        field(50000; "Reversal Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50001; "Transaction Date"; Date)
        {
            DataClassification = ToBeClassified;
            Description = 'Actual Transaction Date(Workdate)';
            Editable = false;
        }
        field(50002; "Application Source"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,CBS,ATM,Mobile,Internet,MPESA,Equity,Co-op,Family,SMS Banking';
            OptionMembers = " ",CBS,ATM,Mobile,Internet,MPESA,Equity,"Co-op",Family,"SMS Banking";
        }
        field(50003; Alerted; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50004; "Member No"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50005; "Created On"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(50006; "Cheque Maturity Date"; Date)
        {
            //TODO after Fixing transactions table
            // CalcFormula = Lookup(Transactions."Expected Maturity Date" WHERE(No = FIELD("Document No.")));
            // FieldClass = FlowField;
        }
        field(50007; "Computer Name"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50008; "Member No II"; Code[30])
        {
            CalcFormula = Lookup(Vendor."BOSA Account No" WHERE("No." = FIELD("Vendor No.")));
            FieldClass = FlowField;
        }
        field(50009; "Account Type"; Code[30])
        {
            CalcFormula = Lookup(Vendor."Account Type" WHERE("No." = FIELD("Vendor No.")));
            FieldClass = FlowField;
        }
    }
    kEYS
    {
        key(Key27; "Document No.")
        {

        }
    }
    var
        myInt: Integer;
}


