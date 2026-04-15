table 50055 "Salary Processing Details"
{
    DataClassification = ToBeClassified;
    
    fields
    {
        field(1;"Salary Number"; Code[20])
        {
            TableRelation = "Salary Processing Headerr".No;
        }
        field(2;"Member Number"; Code[20])
        {
            TableRelation = Customer."No." where(ISNormalMember = filter(true));
        }
        field(3;"FOSA Number"; Code[20])
        {
            TableRelation = Vendor."No." where("Creditor Type" = filter("FOSA Account"), "Account Type" = filter('103'));
        }
        field(4;"Gross Salary"; Decimal)
        {}
        field(5;"Deduction Account Type"; Enum "Gen. Journal Account Type")
        {}
        field(6;"Deduction Type"; Code[20])
        {
            TableRelation = if("Deduction Account Type" = filter(Vendor)) "Account Types-Saving Products".Code
                            else if("Deduction Account Type" = filter(Customer)) "Loan Products Setup".Code;
            
            trigger OnValidate() begin
                if "Deduction Type" = 'BBF' then begin
                    "Deduction Type Name" := 'Benevolent Fund';
                end else if "Deduction Account Type" = "Deduction Account Type"::Vendor then begin
                    accTypes.Get("Deduction Type");
                    "Deduction Type Name" := accTypes.Description;
                end else if "Deduction Account Type" = "Deduction Account Type"::Customer then begin
                    loanTypes.Get("Deduction Type");
                    "Deduction Type Name" := loanTypes."Product Description";
                end;
            end;
        }
        field(7;"Deduction Type Name"; Text[2000])
        {}
        field(8;"Expected Deduction"; Decimal)
        {}
        field(9;"Posted Deduction"; Decimal)
        {}
        field(10;"Variance Deduction"; Decimal)
        {}
        field(11;Erroneous; Boolean)
        {}
        field(12;Posted; Boolean)
        {}

    }
    
    keys
    {
        key(Key1; "Salary Number", "Member Number", "Deduction Type")
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
        accTypes: Record "Account Types-Saving Products";
        loanTypes: Record "Loan Products Setup";
        salaryProcessing: Record "Salary Processing Headerr";
    
    trigger OnInsert()
    begin
        
    end;
    
    trigger OnModify()
    begin
        
    end;
    
    trigger OnDelete()
    begin
        salaryProcessing.Get("Salary Number");
        if salaryProcessing.Posted then Error('You cannot delete entries for a posted salary. Kindly modify instead.');
    end;
    
    trigger OnRename()
    begin
        
    end;
    
}
