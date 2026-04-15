table 50014 "InsiderLending"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Member No"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Customer."No." where(ISNormalMember = Const(true));
            trigger OnValidate()
            var
                Customer: Record Customer;
            begin
                Customer.Reset();
                Customer.SetRange("No.", "Member No");
                if Customer.Find('-') then begin
                    "Member Name" := Customer.Name;
                    "ID No." := Customer."ID No.";
                    "E-Mail" := Customer."E-Mail";
                    "Mobile No." := Customer."Mobile Phone No";
                    Employer := Customer."Employer Code";
                end;
            end;

        }
        field(2; "Member Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Position Held"; Option)
        {
            OptionCaption = ' ,Employee,Director,Delegate';
            OptionMembers = ,Employee,Director,Delegate;
        }
        field(4; "ID No."; Code[40])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "E-Mail"; text[1400])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Mobile No."; Code[40])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Employer"; Code[40])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Delegate Region"; Code[40])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Member Delegate Zones".Code;

            trigger OnValidate() begin
                cust.Reset();
                cust.SetRange("No.", "Member No");
                if cust.Find('-') then begin
                    cust."Electral Zone" := "Delegate Region";
                    cust.Modify;
                end;
            end;
        }
    }

    keys
    {
        key(PK; "Member No")
        {
            Clustered = true;
        }
    }

    var
        myInt: Integer;
        cust: Record Customer;

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
