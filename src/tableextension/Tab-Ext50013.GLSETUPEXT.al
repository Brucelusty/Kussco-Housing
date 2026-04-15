//************************************************************************
tableextension 50013 "GLSETUPEXT" extends "General Ledger Setup"
{
    fields
    {
        // Add changes to table fields here

        field(50033; "Journal Approval Nos"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50034; "Bank Balances"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = sum("Bank Account Ledger Entry"."Amount (LCY)" where("Global Dimension 1 Code" = field("Global Dimension 1 Filter"),
                                                                                "Global Dimension 2 Code" = field("Global Dimension 2 Filter"),
                                                                                "Posting Date" = field("Date Filter")));
            Caption = 'Bank Balances';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50035; "Pending L.O.P"; Decimal)
        {
            CalcFormula = sum("Purchase Line"."Outstanding Amount (LCY)" where("Shortcut Dimension 1 Code" = field("Global Dimension 1 Filter"),
                                                                                "Shortcut Dimension 2 Code" = field("Global Dimension 2 Filter"),
                                                                                "Expected Receipt Date" = field("Date Filter"),
                                                                                Amount = filter(<> 0),
                                                                                "Document Type" = filter(<> Quote)));
            FieldClass = FlowField;
        }
        field(50000; "GjnlBatch Approval No"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series".Code;
        }
        field(50001; "LCY Code Decimals"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(50002; "Base No. Series"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Responsibility Center,Shortcut Dimension 1,Shortcut Dimension 2,Shortcut Dimension 3,Shortcut Dimension 4';
            OptionMembers = " ","Responsibility Center","Shortcut Dimension 1","Shortcut Dimension 2","Shortcut Dimension 3","Shortcut Dimension 4","Shortcut Dimension 5","Shortcut Dimension 6","Shortcut Dimension 7","Shortcut Dimension 8";
        }
        field(50003; "Cash Purchases Nos"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50004; "Payroll Posting Group"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50005; "Interbank Transfer Nos"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50006; "Bulk SMS Nos"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50007; "Agency Application Nos"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50008; "CloudPESA Comm Acc"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(50009; "Agent Charges Account"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(50010; "Mobile Charge"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Charges;
        }
        field(50011; "CloudPESA Charge"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50012; "MPESA Settl Acc"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Bank Account";
        }
        field(50013; "PayBill Settl Acc"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Bank Account";
        }
        field(50014; "File Movement Nos"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50015; "family account bank"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Bank Account";
        }
        field(50016; "equity bank acc"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Bank Account";
        }
        field(50017; "coop bank acc"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Bank Account";
        }
        field(50018; "Suspense fb"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(50019; "suspense coop bank"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(50020; "suspense equity"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(50021; "Suspense Paybill"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(50022; "Safaricom Paybill"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(50023; "Transaction Document No"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series".Code;
        }
        field(50024; "Non Earning Cash BenchMark"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50025; "Earning Bank Cash BenchMark"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50026; "Regulator Miinimum Ratio"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50027; "New Member Suspense"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(50028; "CloudPESA Comm Account"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50029; "Paybill Acc"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50030; "MPESA Recon Acc"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50031; "Mobile Comm Account"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50032; "Mobile banking Charge"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
    }

    var
        myInt: Integer;
}


