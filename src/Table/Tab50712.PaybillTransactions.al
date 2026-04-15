table 50712 "Paybill Transactions"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; TransID; Code[40])
        {
            DataClassification = ToBeClassified;

        }
        field(2; TransactionType; Code[40])
        {
            DataClassification = ToBeClassified;
        }

        field(3; TransTime; DateTime)
        {
            DataClassification = ToBeClassified;

        }
        field(4; TransAmount; Decimal)
        {
            DataClassification = ToBeClassified;

        }
        field(5; BusinessShortCode; Code[40])
        {
            DataClassification = ToBeClassified;
        }
        field(6; BillRefNumber; Code[40])
        {
            DataClassification = ToBeClassified;
        }
        field(7; InvoiceNumber; Code[40])
        {
            DataClassification = ToBeClassified;
        }
        field(8; OrgAccountBalance; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(9; ThirdPartyTransID; Code[40])
        {
            DataClassification = ToBeClassified;
        }
        field(10; MSIDN; Code[40])
        {
            DataClassification = ToBeClassified;
        }
        field(11; FirstName; Text[150])
        {
            DataClassification = ToBeClassified;

        }
        field(12; MiddleName; Text[150])
        {
            DataClassification = ToBeClassified;

        }
        field(13; LastName; Text[150])
        {
            DataClassification = ToBeClassified;

        }
        field(14; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Failed,Posted,Pending;
            OptionCaption = 'Failed,Posted,Pending';

        }
        field(15; Keyword; code[50])
        {
            DataClassification = ToBeClassified;

        }
        field(16; TransType; code[50])
        {
            DataClassification = ToBeClassified;

        }
        field(17; IDNo; code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(18; "Posted Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(19; "Posted Time"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(20; "Posting Location"; Code[50])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Detailed Vendor Ledg. Entry"."Document No." where("Document No." = field(TransID)));
        }
        field(21; "Posting Count"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Detailed Vendor Ledg. Entry" where("Document No." = field(TransID)));
        }
        field(22; "Transaction Failed"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(23; "Paybill BST"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(24; "Paybill Dest No"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; TransID)
        {
            Clustered = true;
        }
    }

    var
        myInt: Integer;

    trigger OnInsert()
    begin

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
