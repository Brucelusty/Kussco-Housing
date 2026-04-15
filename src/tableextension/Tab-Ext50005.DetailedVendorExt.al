//************************************************************************
tableextension 50005 "DetailedVendorExt" extends "Detailed Vendor Ledg. Entry"
{
    fields
    {
        // Add changes to table fields here
        field(50000; "Reversal Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50001; Reversed; Boolean)
        {
            CalcFormula = Lookup("Vendor Ledger Entry".Reversed WHERE("Transaction No." = FIELD("Transaction No.")));
            FieldClass = FlowField;
        }
        field(50002; "Reversed By"; Code[50])
        {
            CalcFormula = Lookup("Vendor Ledger Entry"."User ID" WHERE("Transaction No." = FIELD("Transaction No.")));
            FieldClass = FlowField;
        }
        field(50003; Description; Text[250])
        {
            CalcFormula = Lookup("Vendor Ledger Entry".Description WHERE("Transaction No." = FIELD("Transaction No."),
                                                                          "Entry No." = FIELD("Vendor Ledger Entry No.")));
            FieldClass = FlowField;
        }
        field(50004; "Transaction Date"; Date)
        {
            DataClassification = ToBeClassified;
            Description = 'Actual Transaction Date(Workdate)';
            Editable = false;
        }
        field(50005; "Application Source"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,CBS,ATM,Mobile,Internet,MPESA,Equity,Co-op,Family,SMS Banking';
            OptionMembers = " ",CBS,ATM,Mobile,Internet,MPESA,Equity,"Co-op",Family,"SMS Banking";
        }
        field(50006; "Account Type"; Code[30])
        {
            CalcFormula = Lookup(Vendor."Account Type" WHERE("No." = FIELD("Vendor No.")));
            FieldClass = FlowField;
        }
        field(50007; "Created On"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(50008; "Member No"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50009; Found; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50010; "Computer Name"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50011; Balance; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50012; "Member House Group"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key13; "Document No.")
        {

        }
    }
    var
        myInt: Integer;
}


