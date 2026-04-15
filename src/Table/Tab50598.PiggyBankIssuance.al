//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50598 "Piggy Bank Issuance"
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
                    NoSeriesMgt.TestManual(NoSetup."Piggy Bank No");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "Member No"; Code[30])
        {
            TableRelation = "Customer"."No.";

            trigger OnValidate()
            begin
                if ObjCust.Get("Member No") then begin
                    "Member Name" := ObjCust.Name;
                end;
            end;
        }
        field(3; "Member Name"; Code[100])
        {
            Editable = false;
        }
        field(4; "Piggy Bank Account"; Code[20])
        {
            TableRelation = Vendor."No." where("BOSA Account No" = field("Member No"), "Account Type" = filter('109')
            // ,"Global Dimension 1 Code" = filter('FOSA')
            );

            trigger OnValidate()
            begin
                saccoGen.Get();

                if ObjAccount.Get("Piggy Bank Account") then begin
                    "Piggy Bank Account Name" := ObjAccount."Child Name";
                end;

                detVend.Reset();
                detVend.SetRange("Vendor No.", "Piggy Bank Account");
                detVend.SetRange(Reversed, false);
                if detVend.FindSet() then begin
                    detVend.CalcSums("Credit Amount");
                    if saccoGen."Min. Piggy Bank Bal" = 0 then Error('The minimum Mdosi Jr account balance needs to be setup.');
                    if detVend."Credit Amount" < saccoGen."Min. Piggy Bank Bal" then Error('The account %1''s balance is below the minimum required amount of %2.', rec."Piggy Bank Account", saccoGen."Min. Piggy Bank Bal");
                end;

                ObjPiggyBank.Reset;
                ObjPiggyBank.SetRange(ObjPiggyBank."Piggy Bank Account", "Piggy Bank Account");
                ObjPiggyBank.SetRange(ObjPiggyBank.Issued, true);
                if ObjPiggyBank.FindSet then begin
                    "Exisiting piggy Bank" := true;
                end;
            end;
        }
        field(5; "Piggy Bank Account Name"; Code[100])
        {
            Editable = false;
        }
        field(6; "Exisiting piggy Bank"; Boolean)
        {
            Editable = false;
        }
        field(7; "Issued By"; Code[30])
        {
        }
        field(8; "Issued On"; Date)
        {
        }
        field(9; "Issued To"; Code[50])
        {
        }
        field(10; "Collected By"; Code[60])
        {
        }
        field(11; "Captured By"; Code[30])
        {
        }
        field(12; "No. Series"; Code[30])
        {
        }
        field(13; "Captured On"; Date)
        {
        }
        field(14; Issued; Boolean)
        {
        }
        field(15; "Piggy Bank No"; Code[20])
        {
        }
        field(16; "Issued To ID No"; Code[60])
        {
        }
        field(17; "Issued to Phone Number"; Code[60])
        {
            InitValue = '254';
            trigger OnValidate()
            begin
                if StrLen("Issued to Phone Number") <> 12 then
                    Error('The issued person''s phone no. cannot be more or less than 12 Characters');
            end;

        }
        field(18; "Mode Of Dispatch"; Option)
        {
            OptionMembers = " ",Posta,G4S,Fargo;
        }
        field(19; "Location"; Code[60])
        {
        }
        field(20; "Address"; Code[60])
        {
        }
        field(21; "Tracking Code"; Code[60])
        {
        }
        field(22; "Card Issued to Customer"; Option)
        {
            OptionCaption = ' ,Owner Collected,Card Sent,Card Issued to';
            OptionMembers = " ","Owner Collected","Card Sent","Card Issued to";
            trigger OnValidate()
            var
                Customer: Record Customer;
            begin
                if "Card Issued to Customer" = "Card Issued to Customer"::"Owner Collected" then begin
                    Customer.Reset();
                    Customer.SetRange(Customer."No.", "Member No");
                    if Customer.FindFirst() then begin
                        Rec."Issued to" := Customer.Name;
                        Rec."Issued to Phone Number" := Customer."Mobile Phone No";
                        Rec."Issued To ID No" := Customer."ID No.";
                        Rec."Collected By" := Customer.Name;
                        Rec.Modify();
                    end;
                end;
                if "Card Issued to Customer" <> "Card Issued to Customer"::"Owner Collected" then begin
                    Customer.Reset();
                    Customer.SetRange(Customer."No.", "Member No");
                    if Customer.FindFirst() then begin
                        Rec."Issued to" := '';
                        Rec."Issued to Phone Number" := '';
                        Rec."Issued To ID No" := '';
                        Rec."Collected By" := '';
                        Rec.Modify();
                    end;
                end;
            end;
        }
    }

    keys
    {
        key(Key1; "Document No")
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
            NoSetup.TestField(NoSetup."Piggy Bank No");
            NoSeriesMgt.GetNextNo(NoSetup."Piggy Bank No");
        end;
        "Captured By" := UserId;
        "Captured On" := Today;
    end;

    var
        NoSetup: Record "Sacco No. Series";
        NoSeriesMgt: Codeunit "No. Series";
        // ObjCust: Record "Members Register";
        ObjCust: Record Customer;
        ObjAccount: Record Vendor;
        detVend: Record "Detailed Vendor Ledg. Entry";
        ObjPiggyBank: Record "Piggy Bank Issuance";
        saccoGen: Record "Sacco General Set-Up";
}




