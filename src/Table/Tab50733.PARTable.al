table 50733 "PAR Table"
{
    DataClassification = ToBeClassified;
    
    fields
    {
        field(1;No; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Loan Product"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Loan Products Setup".Code;
        }
        field(10;"Total Loan"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(11;"Total Provisioning"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(12;"Total Performing"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(13;"Total Watch"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(14;"Total Substandard"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(15;"Total Doubtful"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(16;"Total Loss"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(17;"Performing Provision"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(18;"Watch Provision"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(19;"Substandard Provision"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(20;"Doubtful Provision"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(21;"Loss Provision"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(22;"PAR Ratio"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(23;"Date of Generation"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(24;"Time of Generation"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(25;Performing; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Loans Register" where("Loans Category" = filter(Perfoming)));
        }
        field(26;Watch; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Loans Register" where("Loans Category" = filter(Watch)));
        }
        field(27;Substandard; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Loans Register" where("Loans Category" = filter(Substandard)));
        }
        field(28;Doubtful; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Loans Register" where("Loans Category" = filter(Doubtful)));
        }
        field(29;Loss; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Loans Register" where("Loans Category" = filter(Loss)));
        }
    }
    
    keys
    {
        key(Key1; No, "Loan Product")
        {
            Clustered = true;
        }
    }
    
    fieldgroups
    {
        // Add changes to field groups here
    }
    
    var
    myInt: Integer;
    
    trigger OnInsert()
    begin
        No:= xRec.No + 100;
    end;
    
    trigger OnModify()
    begin
        
    end;
    
    trigger OnDelete()
    begin
        
    end;
    
    trigger OnRename()
    begin
        
    end;
    
}
