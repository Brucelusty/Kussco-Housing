table 50715 "ReceiptsProcessing_H-Checkoff"
{

    fields
    {
        field(1; No; Code[20])
        {

            trigger OnValidate()
            begin
                IF No = '' THEN BEGIN
                    NoSetup.GET();
                    NoSetup.TESTFIELD(NoSetup."Checkoff Proc Block Nos");
                    NoSeriesMgt.GetNextNo(NoSetup."Checkoff Proc Block Nos");
                END;
            end;
        }
        field(2; "No. Series"; Code[20])
        {
        }
        field(3; Posted; Boolean)
        {
            Editable = false;
        }
        field(6; "Posted By"; Code[60])
        {
            Editable = false;
        }
        field(7; "Date Entered"; Date)
        {
        }
        field(9; "Entered By"; Text[60])
        {
        }
        field(10; Remarks; Text[150])
        {
        }
        field(19; "Date Filter"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(20; "Time Entered"; Time)
        {
        }
        field(21; "Posting date"; Date)
        {
        }
        field(22; "Account Type"; Option)
        {
            OptionCaption = 'G/L Account,Customer,Vendor,Bank Account,Fixed Asset';
            OptionMembers = "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset";
        }
        field(23; "Account No"; Code[30])
        {
            TableRelation = IF ("Account Type" = CONST("G/L Account")) "G/L Account"
            ELSE IF ("Account Type" = CONST(Customer)) Customer
            ELSE IF ("Account Type" = CONST(Vendor)) Vendor
            ELSE IF ("Account Type" = CONST("Bank Account")) "Bank Account"
            ELSE IF ("Account Type" = CONST("Fixed Asset")) "Fixed Asset";

            trigger OnValidate()
            begin
                IF "Account Type" = "Account Type"::Customer THEN BEGIN
                    cust.RESET;
                    cust.SETRANGE(cust."No.", "Account No");
                    IF cust.FIND('-') THEN BEGIN
                        "Employer Name" := cust.Name;

                    END;
                END;

                IF "Account Type" = "Account Type"::"G/L Account" THEN BEGIN
                    "GL Account".RESET;
                    "GL Account".SETRANGE("GL Account"."No.", "Account No");
                    IF "GL Account".FIND('-') THEN BEGIN
                        "Account Name" := "GL Account".Name;
                    END;
                END;

                IF "Account Type" = "Account Type"::"Bank Account" THEN BEGIN
                    BANKACC.RESET;
                    BANKACC.SETRANGE(BANKACC."No.", "Account No");
                    IF BANKACC.FIND('-') THEN BEGIN
                        "Account Name" := BANKACC.Name;

                    END;
                END;
            end;
        }
        field(24; "Document No"; Code[20])
        {
        }
        field(25; Amount; Decimal)
        {

            trigger OnValidate()
            begin
                /*
              IF Amount<>"Scheduled Amount" THEN
              ERROR('The Amount must be equal to the Scheduled Amount');
                  */

            end;
        }
        field(26; "Scheduled Amount"; Decimal)
        {
            CalcFormula = Sum("ReceiptsProcessing_L-Checkoff".Amount WHERE("Receipt Header No" = FIELD(No)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(27; "Total Count"; Integer)
        {
            CalcFormula = Count("ReceiptsProcessing_L-Checkoff" WHERE("Receipt Header No" = FIELD(No)));
            FieldClass = FlowField;
        }
        field(28; "Account Name"; Code[50])
        {
        }
        field(29; "Employer Code"; Code[30])
        {
            TableRelation = "Sacco Employers".Code;
        }
        field(30; "Un Allocated amount-surplus"; Decimal)
        {
        }
        field(31; "Employer Name"; Text[100])
        {
        }
        field(32; "Loan CutOff Date"; Date)
        {
        }
    }

    keys
    {
        key(Key1; No)
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        IF Posted = TRUE THEN
            ERROR('You cannot delete a Posted Check Off');
    end;

    trigger OnInsert()
    begin

        IF No = '' THEN BEGIN
            NoSetup.GET();
            NoSetup.TESTFIELD(NoSetup."Checkoff Proc Block Nos");
            NoSeriesMgt.GetNextNo(NoSetup."Checkoff Proc Block Nos");
        END;

        "Date Entered" := TODAY;
        "Time Entered" := TIME;
        "Entered By" := UPPERCASE(USERID);

    end;

    trigger OnModify()
    begin
        /* // Enock Waumini
       IF Posted = TRUE THEN
       ERROR('You cannot modify a Posted Check Off');
        */

    end;

    trigger OnRename()
    begin
        IF Posted = TRUE THEN
            ERROR('You cannot rename a Posted Check Off');
    end;

    var
        NoSetup: Record "Sacco No. Series";
        NoSeriesMgt: Codeunit "No. Series";
        cust: Record Customer;
        "GL Account": Record "G/L Account";
        BANKACC: Record "Bank Account";
}

