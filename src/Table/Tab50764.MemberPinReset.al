table 50764 "Member Pin Reset"
{
    Caption = 'Member Pin Reset';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
        }
        field(15; "No. Series"; Code[20])
        {
            Caption = 'No.';
        }
        field(2; "Account No"; Code[20])
        {
            Caption = 'Account No';
            TableRelation = Customer."No." where(ISNormalMember = filter(true), "Mobile Banking Registered" = filter(true));

            trigger OnValidate()
            begin
                cust.Reset();
                cust.SetRange("No.", "Account No");
                if cust.Find('-') then begin
                    if ("Member Banking" = "Member Banking"::Mobile) and (cust."Mobile Banking" = false) then Error('This member is not registered for Mobile Banking.');
                    if ("Member Banking" = "Member Banking"::Internet) and (cust."Internet Banking" = false) then Error('This member is not registered for Internet Banking.');

                    pinReset.Reset();
                    pinReset.SetRange("Account No", "Account No");
                    pinReset.SetRange("Member Banking", "Member Banking");
                    pinReset.SetFilter("No.", '<>%1', "No.");
                    if pinReset.Find('-') then begin
                        Error('This member has an ongoing pin reset.');
                    end;
                end;
            end;
        }
        field(3; "Member Name"; Text[1000])
        {
            Caption = 'Member Name';
        }
        field(4; "ID No"; Code[20])
        {
            Caption = 'ID No';
        }
        field(5; "Date Requested"; Date)
        {
            Caption = 'Date Requested';
        }
        field(6; "Requested By"; Code[20])
        {
            Caption = 'Requested By';
        }
        field(7; Status; Option)
        {
            OptionCaption = 'New,Pending Approval,Approved,Rejected';
            OptionMembers = New,"Pending Approval",Approved,Rejected;
        }
        field(8; "Date Changed"; Code[20])
        {
            Caption = 'Date Changed';
        }
        field(9; "Changed By"; Code[20])
        {
            Caption = 'Changed By';
        }
        field(10; "Member Banking"; Option)
        {
            OptionCaption = ' ,Mobile,Internet';
            OptionMembers = " ",Mobile,Internet;
        }
    }
    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    begin
        if "No." = '' then begin
            SaccoNoSeries.Get;
            SaccoNoSeries.TestField("Pin Reset Nos");
            NoSeries.GetNextNo(SaccoNoSeries."Pin Reset Nos");
        end;

        "Requested By" := UserId;
        "Date Requested" := Today;
    end;

    var
        noSeries: Codeunit "No. Series";
        saccoNoSeries: Record "Sacco No. Series";
        cust: Record Customer;
        pinReset: Record "Member Pin Reset";
}
