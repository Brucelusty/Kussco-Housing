table 50758 "Savings Variation"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Variation No"; Code[20])
        {
            Editable = false;
        }
        field(2; "No. Series"; Code[20])
        { }
        field(3; "Created On"; Date)
        { }
        field(4; "Created By"; Code[20])
        { }
        field(5; "Member No"; Code[20])
        {
            TableRelation = Customer."No." where(ISNormalMember = filter(true));

            trigger OnValidate()
            begin
                cust.Reset();
                cust.SetRange("No.", "Member No");
                if cust.Find('-') then begin
                    "Member Name" := cust.Name;
                    "Savings Account Type" := '';
                    "Account Type" := '';
                    "Old Savings" := 0;
                    "Reason for Change" := '';
                end;
            end;
        }
        field(6; "Savings Account Type"; Code[50])
        {
            TableRelation = "Account Types-Saving Products".Code;

            trigger OnValidate()
            begin
                cust.Reset();
                accountTypes.Reset();
                accountTypes.SetRange(Code, "Savings Account Type");
                if accountTypes.Find('-') then begin
                    "Account Type" := accountTypes.Description;
                    if accountTypes.Code = '101' then begin
                        if cust.Get("Member No") then begin
                            "Old Savings" := cust."Share Capital Contribution";
                        end;
                    end else if accountTypes.Code = '102' then begin
                        if cust.Get("Member No") then begin
                            "Old Savings" := cust."Monthly Contribution";
                        end;
                    end else if accountTypes.Code = '104' then begin
                        if cust.Get("Member No") then begin
                            "Old Savings" := cust."ESS Contribution";
                        end;
                    end else if accountTypes.Code = '106' then begin
                        if cust.Get("Member No") then begin
                            "Old Savings" := cust."Jibambe Savings Contribution";
                        end;
                    end else if accountTypes.Code = '107' then begin
                        if cust.Get("Member No") then begin
                            "Old Savings" := cust."Wezesha Savings Contribution";
                        end;
                    end else if accountTypes.Code = '109' then begin
                        if cust.Get("Member No") then begin
                            "Old Savings" := cust."Mdosi Jr Contribution";
                        end;
                    end else if accountTypes.Code = '110' then begin
                        if cust.Get("Member No") then begin
                            "Old Savings" := cust."Pension Akiba Contribution";
                        end;
                    end;
                end;
            end;
        }
        field(7; "Member Name"; Text[500])
        {
            Editable = false;
        }
        field(8; "Old Savings"; Decimal)
        {
            Editable = false;
        }
        field(9; "New Savings"; Decimal)
        { }
        field(10; "Approved By"; Code[20])
        { }
        field(11; "Approved On"; Date)
        { }
        field(12; "Approval Status"; Option)
        {
            Editable = false;
            OptionCaption = ' ,New,Pending Approval,Approved,Cancelled';
            OptionMembers = " ",New,"Pending Approval",Approved,Cancelled;
        }
        field(13; Updated; Boolean)
        {
            Editable = false;
        }
        field(14; "Reason for Change"; Text[2048])
        { }
        field(15; "Account Type"; Text[2048])
        {
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "Variation No")
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
        noSeries: Codeunit "No. Series";
        saccoNoseries: Record "Sacco No. Series";
        cust: Record Customer;
        vend: Record Vendor;
        accountTypes: Record "Account Types-Saving Products";

    trigger OnInsert()
    begin
        saccoNoseries.Get();
        if "Variation No" = '' then begin
            saccoNoseries.TestField("Savings Variation Nos");
            noSeries.GetNextNo(saccoNoseries."Savings Variation Nos");
        end;

        "Created By" := UserId;
        "Created On" := Today;
        "Approval Status" := "Approval Status"::New;
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
