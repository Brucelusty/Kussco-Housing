//************************************************************************
tableextension 50018 "FADEPBOOKEXT" extends "FA Depreciation Book"
{
    fields
    {
        // Add changes to table fields here

        field(50000; "Total Depr. Value to Date"; Decimal)
        {
            CalcFormula = sum("FA Ledger Entry".Amount where("FA No." = field("FA No."),
                                                              "FA Posting Type" = filter(Depreciation)));
            FieldClass = FlowField;
        }
        field(50001; "Total Cost Value to Date"; Decimal)
        {
            CalcFormula = sum("FA Ledger Entry".Amount where("FA No." = field("FA No."),
                                                              "FA Posting Type" = filter("Acquisition Cost" | Appreciation)));
            FieldClass = FlowField;
        }
        field(50002; "Disposed/Writtenoff Cost"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50003; "Disposed/Writtenoff Depr"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50004; "Disposal Salvage Value"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50005; "Initial Cost Value"; Decimal)
        {
            CalcFormula = sum("FA Ledger Entry".Amount where("FA No." = field("FA No."),
                                                              "FA Posting Type" = filter("Acquisition Cost" | Appreciation),
                                                              Amount = filter(> 0)));
            FieldClass = FlowField;
        }
        field(50006; "Next Depreciation Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50007; "Exempt From Depreciation"; Boolean)
        {
            DataClassification = ToBeClassified;
        }

    }

    var
        myInt: Integer;
}


