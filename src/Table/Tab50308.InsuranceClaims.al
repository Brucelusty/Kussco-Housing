table 50308 "Insurance Claims"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Claim No."; Code[20])
        {
            Editable = false;
        }
        field(2; "Bank No."; Code[20])
        {
            Editable = false;
            TableRelation = "Bank Account"."No.";
        }
        field(3; "Claim Description"; Text[2048])
        { }
        field(4; "Claim Date"; Date)
        { }
        field(5; "Initiated By"; Code[20])
        {
            Editable = false;
        }
        field(6; "Initiated On"; Date)
        {
            Editable = false;
        }
        field(7; "Member BOSA No."; Code[20])
        {
            TableRelation = Customer."No." where(ISNormalMember = filter(true), "Membership Status" = filter(Active));
            trigger OnValidate()
            begin
                cust.Reset();
                if cust.Get("Member BOSA No.") then begin
                    "Member Name" := cust.Name;
                    "ID No." := cust."ID No.";
                end;
            end;
        }
        field(8; "ID No."; Code[20])
        {
            Editable = false;
        }
        field(9; "Member Name"; Code[20])
        {
            Editable = false;
        }
        field(10; "Reason For Claim"; Option)
        {
            OptionCaption = ' ,Loan WriteOff,Deposit Refund,Funeral Rider';
            OptionMembers = " ","Loan WriteOff","Deposut Refund","Funeral Rider";

            trigger OnValidate()
            begin
                if "Reason For Claim" = "Reason For Claim"::"Loan WriteOff" then begin
                    cust.Reset();
                    if cust.Get("Member BOSA No.") then begin
                        if cust."Membership Status" <> cust."Membership Status"::Deceased then begin
                            if Confirm('Is this loan writeoff due to the death of the member?', true) = false then exit;

                            cust.CalcFields("Pays Benevolent");
                            if cust."Pays Benevolent" = false then Error('This member has no Benevolent Fund contributions.');

                            cust."Membership Status" := cust."Membership Status"::Deceased;
                            cust.Modify;
                        end;
                    end;
                end else begin
                    cust.Reset();
                    if cust.Get("Member BOSA No.") then begin

                        cust.CalcFields("Pays Benevolent");
                        if cust."Pays Benevolent" = false then Error('This member has no Benevolent Fund contributions.');
                        if cust."Membership Status" <> cust."Membership Status"::Deceased then begin
                            cust."Membership Status" := cust."Membership Status"::Deceased;
                            cust.Modify;
                            Message('The member''s membership status has been changed to deceased.');
                        end;
                    end;
                end;
            end;
        }
        field(11; "Expected Amount"; Decimal)
        { }
        field(13; "Received On"; Date)
        {
            Editable = false;
        }
        field(14; "Recieved By"; Code[20])
        {
            Editable = false;
        }
        field(15; "Cheque No"; Code[20])
        { }
        field(16; "No Series"; Code[20])
        { }
        field(17; Status; Option)
        {
            Editable = false;
            OptionCaption = 'Open,Pending Approval,Approved,Rejected,Invoiced,Paid';
            OptionMembers = Open,"Pending Approval",Approved,Rejected,Invoiced,Paid;
        }
        field(19; "Bank Name"; Code[200])
        {
            Editable = false;
        }
        field(20; Insurer; Code[20])
        {
            Editable = false;
            TableRelation = Customer."No." where("Insurance Account" = filter(true));
        }
        field(21; Invoiced; Boolean)
        {
            Editable = false;
        }
        field(22; "Invoiced By"; Code[20])
        {
            Editable = false;
            TableRelation = "User Setup"."User ID" where("Post Pv" = filter(true));
        }
        field(23; "Invoiced On"; Date)
        {
            Editable = false;
        }
        field(24; Paid; Boolean)
        {
            Editable = false;
        }
        field(25; "Paid By"; Code[20])
        {
            Editable = false;
            TableRelation = "User Setup"."User ID" where("Post Pv" = filter(true));
        }
        field(26; "Paid On"; Date)
        {
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "Claim No.")
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
        saccoNos: Record "Sacco No. Series";
        cust: Record Customer;
        banks: Record "Bank Account";
        fundsGen: Record "Funds General Setup";

    trigger OnInsert()
    begin
        if "Claim No." = '' then begin
            saccoNos.Get();
            saccoNos.TestField("Insurance Claim Nos");
            noSeries.GetNextNo(saccoNos."Insurance Claim Nos");
        end;

        fundsGen.Get();
        Insurer := fundsGen."Insurance Account";
        banks.Get(fundsGen."Insurance Payment Bank");
        "Bank No." := banks."No.";
        "Bank Name" := banks.Name;


        "Initiated On" := Today;
        "Initiated By" := UserId;
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
