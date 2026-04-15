//************************************************************************
tableextension 50023 "FAtableExt" extends "Fixed Asset"
{
    fields
    {
        // Add changes to table fields here

        field(50000; "Date Created"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50001; "Created By"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50002; "Vendor Name"; Text[100])
        {
            Caption = 'Vendor Name';
            DataClassification = ToBeClassified;
            TableRelation = Vendor;
        }
        field(50003; "Asset Label"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50004; Location; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50005; "Payment Details"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50006; "Supplier Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50007; "Asset Disposal/Writeoff Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50008; Custodian; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Fixed Assets Meta Codes".Code;

            trigger OnValidate()
            begin
                objCustodians.Reset;
                objCustodians.SetRange(objCustodians.Code, Custodian);
                if objCustodians.FindSet then
                    "Custodian Name" := objCustodians.Description;
            end;
        }
        field(50009; "Custodian Name"; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(50010; "Action"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50011; DisposedDepreciation; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50012; DisposedCost; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50013; "Reversal Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50014; "Transaction Date"; Date)
        {
            DataClassification = ToBeClassified;
            Description = 'Actual Transaction Date(Workdate)';
            Editable = false;
        }
    }

    var
        objCustodians: Record "Fixed Assets Meta Codes";
}


