//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50605 "Member Account Freeze Details"
{

    fields
    {
        field(1; "Document No"; Code[30])
        {
            Editable = false;

            trigger OnValidate()
            begin
                if "Document No" <> xRec."Document No" then begin
                    NoSetup.Get();
                    NoSeriesMgt.TestManual(NoSetup."Account Freezing No");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "Member No"; Code[30])
        {
            TableRelation = Customer."No.";

            trigger OnValidate()
            begin
                if ObjCust.Get("Member No") then begin
                    "Member Name" := ObjCust.Name;
                end;
            end;
        }
        field(3; "Member Name"; Code[150])
        {
            Editable = false;
        }
        field(4; "Account No"; Code[30])
        {
            TableRelation = Vendor."No." where("BOSA Account No" = field("Member No"), "Account Type" = filter('103'));

            trigger OnValidate()
            begin
                if ObjAccount.Get("Account No") then begin
                    ObjAccount.CalcFields(ObjAccount.Balance, ObjAccount."Uncleared Cheques");
                    "Current Book Balance" := ObjAccount.GetAvailableBalance();
                    "Current Frozen Amount" := ObjAccount."Frozen Amount";
                    "Overdraft Limit" := ObjAccount."Over Draft Limit Amount";
                end;

                "Current Available Balance" := SFactory.FnRunGetAccountAvailableBalance("Account No");

                ObjFreeze.Reset;
                ObjFreeze.SetRange(ObjFreeze."Account No", "Account No");
                ObjFreeze.SetRange(ObjFreeze."Loan Freeze", false);
                ObjFreeze.SetRange(ObjFreeze.Unfrozen, false);
                if ObjFreeze.FindSet then
                    Error('The Account already has a non-loan frozen amount. Kindly unfreeze the amount before freezing a new amount');

            end;
        }
        field(6; "Amount to Freeze"; Decimal)
        {

            trigger OnValidate()
            begin
                //IF "Amount to Freeze"> "Current Available Balance" THEN
                // ERROR('You cannot freeze an amount more than the Account Available Balance');

                if "Amount to Freeze" < 0 then
                    Error('Amount to freeze cannot be less than zero');
            end;
        }
        field(7; "Reason For Freezing"; Text[1250])
        {
        }
        field(8; "Captured On"; Date)
        {
            Editable = false;
        }
        field(9; "Captured By"; Code[30])
        {
            Editable = false;
        }
        field(10; Frozen; Boolean)
        {
            Editable = true;
            trigger OnValidate()
            begin
                if "Reason For Freezing" = '' then Error('The reason for freezing the specified amount must be captured.');
                Unfrozen := false;
                "Unfrozen By" := '';
                "Unfrozen On" := 0D;
                "Frozen By" := UserId;
                "Frozen On" := Today;

                if ObjAccount.Get("Account No") then begin
                    ObjAccount."Amount to freeze" := "Amount to Freeze";
                    ObjAccount."Frozen Amount" := "Amount to Freeze";
                    ObjAccount.Modify;
                end;
            end;
        }
        field(11; "Frozen On"; Date)
        {
            Editable = false;
        }
        field(12; "Frozen By"; Code[30])
        {
            Editable = false;
            TableRelation = "User Setup"."User ID";
        }
        field(13; Unfrozen; Boolean)
        {
            Editable = true;
            trigger OnValidate()
            begin
                if ("Frozen By" = '') or (Frozen = false) then Error('The amount must be frozen before unfreezing');
                if ("Frozen By" <> UserId) and ((UserId <> 'TELEPOST\NCHEPKORIR')) then Error('The user who froze the amount should be the one to unfreeze');
                if "Reason For UnFreezing" = '' then Error('The reason for unfreezing the specified amount must be captured.');
                Frozen := false;
                "Frozen By" := '';
                "Frozen On" := 0D;
                "Unfrozen By" := UserId;
                "Unfrozen On" := today;

                if ObjAccount.Get("Account No") then begin
                    ObjAccount."Amount to freeze" := 0;
                    ObjAccount."Frozen Amount" := 0;
                    ObjAccount.Modify;
                end;
            end;
        }
        field(14; "Unfrozen On"; Date)
        {
            Editable = false;
        }
        field(15; "Unfrozen By"; Code[30])
        {
            Editable = false;
            TableRelation = "User Setup"."User ID";
        }
        field(16; "No. Series"; Code[30])
        {
        }
        field(17; "Current Available Balance"; Decimal)
        {
            Editable = false;
        }
        field(18; "Uncleared Cheques"; Decimal)
        {
            Editable = false;
        }
        field(19; "Current Frozen Amount"; Decimal)
        {
            Editable = false;
        }
        field(20; "Current Book Balance"; Decimal)
        {
            Editable = false;
        }
        field(21; "Overdraft Limit"; Decimal)
        {
            Editable = false;
        }
        field(22; "Loan Freeze"; Boolean)
        {
        }
        field(23; "Reason For UnFreezing"; Text[1250])
        {
        }
    }

    keys
    {
        key(Key1; "Document No", "Account No", "Member No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        if "Document No" = '' then begin
            NoSetup.Get();
            NoSetup.TestField(NoSetup."Account Freezing No");
            NoSeriesMgt.GetNextNo(NoSetup."Account Freezing No");
        end;
        "Captured By" := UserId;
        "Captured On" := WorkDate;
    end;

    var
        NoSetup: Record "Sacco No. Series";
        NoSeriesMgt: Codeunit "No. Series";
        ObjCust: Record Customer;
        ObjAccount: Record Vendor;
        SFactory: Codeunit "Au Factory";
        ObjFreeze: Record "Member Account Freeze Details";
}




