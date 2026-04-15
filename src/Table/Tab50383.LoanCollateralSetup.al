//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50383 "Loan Collateral Set-up"
{
    DrillDownPageId = "Loan Collateral Setup";
    LookupPageId = "Loan Collateral Setup";

    fields
    {
        field(1; "Code"; Code[20])
        {
            NotBlank = true;

            trigger OnValidate()
            begin
            end;
        }
        field(2; Type; Option)
        {
            NotBlank = true;
            OptionCaption = ' ,,Deposits,Collateral,';
            OptionMembers = " ",Shares,Deposits,Collateral,"Fixed Deposit";
        }
        field(3; "Security Description"; Text[250])
        {
        }
        field(5; Category; Option)
        {
            OptionCaption = ' ,Class A,Class B,Class C';
            OptionMembers = " ","Class A","Class B","Class C";
        }
        field(6; "Value Considered"; Decimal)
        {
            trigger OnValidate()
            begin
                if ("Value Considered" > 1) or ("Value Considered" < 0) then Error('The value considered cannot be greater than 1 or less than 0.');
            end;
        }
        field(7; Security; Option)
        {
            OptionCaption = ' ,Log BooK,Title Deed';
            OptionMembers = " ","Log BooK","Title Deed";
        }
        field(8; "Collateral Posting Group"; Code[20])
        {
            TableRelation = "FA Posting Group".Code;
        }
    }

    keys
    {
        key(Key1; "Code", Type, "Security Description")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        LoanApplications: Record "Loans Register";
}




