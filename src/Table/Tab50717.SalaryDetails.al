table 50717 "Salary Details"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No"; Integer)
        {
            Caption = 'Entry No';
            DataClassification = ToBeClassified;
        }
        field(2; "Member No"; Code[60])
        {
            Caption = 'Member No';
            DataClassification = ToBeClassified;
        }
        field(3; "FOSA Account No"; Code[60])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Salary Type"; Option)
        {
            OptionMembers = ,,Milk,Tea,Bonus,Dividends,Pension,Salary,Allowance,Erroneous;
            OptionCaption = ',,Milk,Tea,Bonus,Dividends,Pension,Salary,Allowance,Erroneous';
            DataClassification = ToBeClassified;
        }
        field(5; "Net Salary"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(6; "Posting Date"; Date)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate() begin
                "Posting Month" := Date2DMY("Posting Date", 2);
                "Posting Year" := Date2DMY("Posting Date", 3);
            end;
        }

        field(7; "Gross Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(8; "Document Number"; Code[60])
        {
            Caption = 'Document Number';
            DataClassification = ToBeClassified;
        }

        field(9; Posted; Boolean)
        {
            DataClassification = ToBeClassified;
        }


        field(10; "Region"; Code[60])
        {
            DataClassification = ToBeClassified;
        }

        field(11; "Grade"; Code[60])
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Payroll No"; Code[60])
        {
            DataClassification = ToBeClassified;
        }

        field(13; "Member Name"; Text[200])
        {
            Caption = 'Member Name';
            DataClassification = ToBeClassified;
        }
        field(14; "Posting Month"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Posting Year"; Integer)
        {
            DataClassification = ToBeClassified;
        }

    }

    keys
    {
        key(PK1; "Entry No")
        {
            Clustered = true;
        }
    }

}
