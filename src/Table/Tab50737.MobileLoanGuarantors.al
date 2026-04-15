table 50737 "Mobile Loan Guarantors"
{

    fields
    {
        field(1; "Loan Entry No."; Integer)
        {
        }
        field(2; "Guarantor Mobile No."; Code[20])
        {
        }
        field(3; "Guarantor Member No."; Code[20])
        {

            trigger OnValidate()
            begin
                "Available Deposits" := 0;


                Members.RESET;
                Members.SETRANGE(Members."No.", "Guarantor Member No.");
                IF Members.FINDFIRST THEN BEGIN
                    Members.CALCFIELDS(Members."Current Shares");
                    "Available Deposits" := Members."Current Shares";
                END;
            end;
        }
        field(4; "Loan Product"; Code[20])
        {
        }
        field(5; "Loan Product Name"; Text[100])
        {
        }
        field(6; "Guarantor Name"; Text[100])
        {
        }
        field(7; "Guarantor Accepted"; Option)
        {
            OptionMembers = Pending,No,Yes;
        }
        field(8; "Guarantor Response Date"; Date)
        {
        }
        field(9; "Guarantor Response Time"; Time)
        {
        }
        field(10; Status; Option)
        {
            OptionMembers = "Pending Approval",Approved,Rejected;
        }
        field(11; "Appraisal Deposit Products"; Code[20])
        {
        }
        field(12; "Available Deposits"; Decimal)
        {
        }
        field(13; "Amount Guaranteed"; Decimal)
        {
        }
        field(14; "Guarantor Dep. A/C"; Code[30])
        {
        }
        field(15; "Date Created"; DateTime)
        {
        }
        field(16; "Loan Status"; Option)
        {
            OptionCaption = 'Pending,Successful,Failed,Pending Guarantors,Appraisal,Approved';
            OptionMembers = Pending,Successful,Failed,"Pending Guarantors",Appraisal,Approved;
            FieldClass = FlowField;
            CalcFormula = Lookup("Sky Mobile Loans".Status WHERE("Entry No" = FIELD("Loan Entry No.")));
        }
        field(17; Identifier; Integer)
        {
        }
    }

    keys
    {
        key(Key1; "Loan Entry No.", "Guarantor Mobile No.")
        {
        }
    }

    fieldgroups
    {
    }

    var
        SavingsAccounts: Record 23;
        Members: Record "Members Register";
}

