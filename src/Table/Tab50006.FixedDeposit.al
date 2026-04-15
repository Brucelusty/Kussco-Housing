table 50006 "Fixed Deposit"
{

    fields
    {
        field(1; "FD No"; Code[30])
        {
            Editable = false;
        }
        field(2; "Account No"; Code[30])
        {
            TableRelation = Vendor."No." WHERE("Account Type" = filter('005'));
            trigger OnValidate()
            begin
                IF Vend.GET("Account No") THEN begin

                    "Account Name" := Vend.Name;
                    "ID NO" := Vend."ID No.";
                    "Staff Number" := Vend."Personal No.";

                end;

            end;
        }
        field(3; "Account Name"; Text[30])
        {
        }
        field(4; "Fd Duration"; Code[10])
        {
            TableRelation = "Fixed Deposit Type".Code;
            trigger OnValidate()
            begin

                vendBalance := 0;



                MonthsX := 0;
                IntRate := 0;
/*                 interestCalc.RESET;
                interestCalc.SETRANGE(interestCalc.Code, "Fd Duration");
                IF interestCalc.FIND('-') THEN BEGIN
                    repeat
                        if (Rec.Amount >= interestCalc."Minimum Amount") and (Rec.Amount <= interestCalc."Maximum Amount") then begin
                            IntRate := interestCalc."Interest Rate";
                            MonthsX := interestCalc."No of Months";
                            callInterest := interestCalc."On Call Interest Rate";
                        end;
                    until interestCalc.Next() = 0;
                END; */
                IF FDType.GET("Fd Duration") THEN begin
                    months := FDType."No. of Months";
                    IntRate := FDType."Interest Rate";
                    MonthsX := FDType."No. of Months";
                end;

                "Interest Rate" := IntRate;
                Duration := MonthsX;
                // "On Call %" := callInterest;
                // "On Call Interest" := 0;
                // "On Call Interest" := ((("On Call %"/12)/100)*Duration)*Amount;

                InterestMonthly := 0;
                InterestP := 0;
                InterestMonthly := ("Interest Rate" / 12);
                InterestP := (InterestMonthly / 100);
                "Interest Earned" := (InterestP * Duration) * Amount;
                MaturityDate := CALCDATE(FORMAT(months) + 'M', TODAY);
                "Withholding Tax" := "Interest Earned" * 0.20;
                interestLessTax := "Interest Earned" * 0.80;
                "Amount After maturity" := Amount + interestLessTax;
            end;
        }
        field(6; Amount; Decimal)
        {
            trigger OnValidate()
            begin

                //GenSetUp.Get();
                // if amount < GenSetUp."Min FD to Earn Interest" then Message('The amount is less than the minimum to earn interest: %1.', GenSetUp."Min FD to Earn Interest");

            end;

        }
        field(7; "Interest Rate"; Decimal)
        {
            Editable = false;
        }
        field(8; "Created by"; Text[30])
        {
        }
        field(9; "No. Series"; Code[10])
        {
        }
        field(10; "Amount After maturity"; Decimal)
        {
        }
        field(11; Date; Date)
        {
            trigger OnValidate()
            begin
                // Date := TODAY;
                MaturityDate := CalcDate(Format(Duration) + 'M', Date);
                Validate(MaturityDate);
            end;
        }
        field(12; MaturityDate; Date)
        {

            trigger OnValidate()
            begin
                IF MaturityDate <= TODAY THEN BEGIN
                    matured := TRUE;
                END;
            end;
        }
        field(13; Posted; Boolean)
        {
        }
        field(14; matured; Boolean)
        {
        }
        field(15; Credited; Boolean)
        {
        }
        field(16; "ID NO"; Code[20])
        {
        }
        field(17; "Posted Date"; Date)
        {
        }
        field(18; "posted time"; Time)
        {
        }
        field(19; "Posted By"; Code[30])
        {
        }
        field(20; "Withholding Tax"; Decimal)
        {
        }
        field(21; interestLessTax; Decimal)
        {
        }
        field(22; Revoked; Boolean)
        {
        }
        field(23; "Revoked Date"; Date)
        {
        }
        field(24; "Revoked Time"; Time)
        {
        }
        field(25; "Revoked By"; Code[60])
        {
        }
        field(26; "Interest Earned"; Decimal)
        {
        }
        field(27; "Fixed"; Boolean)
        {
            Editable = false;
        }
        field(28; "Fixed Date"; Date)
        {
            Editable = false;
        }
        field(29; "Fixed By"; Code[60])
        {
            Editable = false;
        }
        field(30; Duration; Integer)
        {
        }
        field(31; "Staff Number"; Code[20])
        {
        }

        field(32; "Upon Maturity"; Option)
        {
            OptionCaption = ' ,Close The Fixed Deposit Against The Account,Roll-Over The Fixed Deposit and Refix The Principal,Roll-Over The Fixed Deposit and Refix The Principal and Interest';
            OptionMembers = " ","Close the FXD against the Account","Roll-over the FXD and refix the Principal","Roll-over the FXD and refix the Principal and Interest";
        }
        field(33; "FD Certificate No"; Code[60])
        { }
        field(34; Call; Boolean)
        { }
        field(35; "Bank Account"; Code[20])
        {
            TableRelation = "Bank Account"."No.";
        }
    }

    keys
    {
        key(Key1; "FD No")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        ERROR('You are not authorised to delete this transaction.');
    end;

    trigger OnInsert()
    begin

        IF "FD No" = '' THEN BEGIN

            PurchSetup.GET;
            PurchSetup.TESTFIELD(PurchSetup."Fixed Deposit Placement");
            "FD No" := NoSeriesMgt.GetNextNo(PurchSetup."Fixed Deposit Placement");

        END;
        "Created by" := USERID;
        Date := TODAY;
    end;

    var
        PurchSetup: Record "Sacco No. Series";
        CommentLine: Record 97;
        PurchOrderLine: Record 39;
        PostCode: Record 225;
        VendBankAcc: Record 288;
        OrderAddr: Record 224;
        GenBusPostingGrp: Record 250;
        ItemCrossReference: Record "Item Reference";
        RMSetup: Record 5079;
        ServiceItem: Record 5940;
        NoSeriesMgt: Codeunit "No. Series";
        MoveEntries: Codeunit 361;
        UpdateContFromVend: Codeunit 5057;
        DimMgt: Codeunit 408;
        InsertFromContact: Boolean;
        AccountTypes: Record "Account Types-Saving Products";
        UsersID: Record 2000000120;
        FDType: Record "Fixed Deposit Type";
        Cust: Record Customer;
        NOKBOSA: Record "Members Next of Kin";
        NOKApp: Record "Account Agents App Details";
        GenSetUp: Record "Sacco General Set-Up";
        months: Integer;
        FDInterestCriter: Record "FD Interest Calculation Crite";
        fd: Record "Fixed Deposit";
        Vend: Record 23;
        Vendor: Record Vendor;
        InterestMonthly: Decimal;
        InterestP: Decimal;
        IntRate: decimal;
        MonthsX: Integer;
        callInterest: Decimal;
        interestCalc: Record "FD Interest Calculation Crite";
        vendBalance: Decimal;
}

