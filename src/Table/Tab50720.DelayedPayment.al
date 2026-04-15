//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50720 "Delayed Payment"
{

    fields
    {
        field(1; No; Code[20])
        {
            Editable = false;
            trigger OnValidate()

            begin

                if No <> xRec.No then begin
                    NoSetup.Get();
                    NoSeriesMgt.TestManual(NoSetup."Delayed Salary No");
                    "No. Series" := '';

                end;
            end;
        }
        field(2; "No. Series"; Code[20])
        {
        }
        field(3; Posted; Boolean)
        {
        }
        field(6; "Posted By"; Code[60])
        {
            Editable = false;
        }
        field(7; "Date Entered"; Date)
        {
        }
        field(8; "Entered By"; Text[60])
        {
        }
        field(9; Remarks; Text[150])
        {
        }
        field(10; "Time Entered"; Time)
        {
        }
        field(11; "Posting date"; Date)
        {

            trigger OnValidate()
            begin
                "Document No" := No;//FnGetCheckOffDescription();
            end;
        }
        field(12; "Account Type"; Enum "Gen. Journal Account Type")
        {

        }

        field(13; "Document No"; Code[20])
        {
        }

        field(14; "Transaction Description"; Text[50])
        {
        }

        field(15; "Payment Type"; Option)
        {
            OptionMembers = ,,all,"Region Only","Region & Grade";
            OptionCaption = ',,all,Region Only,Region & Grade';
            DataClassification = ToBeClassified;
        }
        field(16; Region; Code[50])
        {
        }
        field(17; Grade; Code[50])
        {

        }
        field(18; "Scheduled Amount"; Decimal)
        {
            CalcFormula = sum("Delayed Payment Lines".Amount where("Payment Header No." = field(No)));
            Editable = false;
            FieldClass = FlowField;
        }

        field(19; "Scheduled Amount New Members"; Decimal)
        {
            CalcFormula = sum("Delayed Payment Lines".Amount where("Payment Header No." = field(No), "New Salary" = const(true)));
            Editable = false;
            FieldClass = FlowField;
        }

        field(23; "Account No"; Code[30])
        {
            TableRelation = if ("Account Type" = const("G/L Account")) "G/L Account"
            else
            if ("Account Type" = const(Customer)) Customer where("Salary Account" = const(true))
            else
            if ("Account Type" = const(Vendor)) Vendor
            else
            if ("Account Type" = const("Bank Account")) "Bank Account"
            else
            if ("Account Type" = const("Fixed Asset")) "Fixed Asset";

            trigger OnValidate()
            begin
                if "Account Type" = "account type"::Customer then begin
                    cust.Reset;
                    cust.SetRange(cust."No.", "Account No");
                    if cust.Find('-') then begin
                        cust.CalcFields(cust.Balance);
                        "Account Name" := cust.Name;
                        "Balancing Account Balance" := cust.Balance;
                    end;
                end;


                if "Account Type" = "account type"::Vendor then begin
                    ObjAccount.Reset;
                    ObjAccount.SetRange(ObjAccount."No.", "Account No");
                    if ObjAccount.Find('-') then begin
                        ObjAccount.CalcFields(ObjAccount.Balance);
                        "Account Name" := ObjAccount.Name;
                        "Balancing Account Balance" := ObjAccount.Balance;
                    end;
                end;


                if "Account Type" = "account type"::"G/L Account" then begin
                    "GL Account".Reset;
                    "GL Account".SetRange("GL Account"."No.", "Account No");
                    if "GL Account".Find('-') then begin
                        "GL Account".CalcFields("GL Account".Balance);
                        "Account Name" := "GL Account".Name;
                        "Balancing Account Balance" := "GL Account".Balance;
                    end;
                end;

                if "Account Type" = "account type"::"Bank Account" then begin
                    BANKACC.Reset;
                    BANKACC.SetRange(BANKACC."No.", "Account No");
                    if BANKACC.Find('-') then begin
                        BANKACC.CalcFields(BANKACC.Balance);
                        "Account Name" := BANKACC.Name;
                        "Balancing Account Balance" := BANKACC.Balance;
                    end;
                end;
            end;
        }

        field(24; "Account Name"; Code[50])
        {
        }

        field(25; "Balancing Account Balance"; Decimal)
        {
        }
        field(26; "New Salary"; Boolean) { }

        field(27; "Doc Posting Date"; Date) { }
    }

    keys
    {
        key(Key1; No)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin


    end;

    trigger OnInsert()
    begin

        if No = '' then begin
            NoSetup.Get();
            NoSetup.TestField(NoSetup."Delayed Salary No");
            NoSeriesMgt.GetNextNo(NoSetup."Delayed Salary No");
        end;

        "Date Entered" := Today;
        "Account Type" := "Account Type"::Customer;
        "Time Entered" := Time;
        "Entered By" := UpperCase(UserId);

    end;

    trigger OnModify()
    begin
        //IF Posted = TRUE THEN
        //ERROR('You cannot modify a Posted Check Off');
    end;

    trigger OnRename()
    begin
        if Posted = true then
            Error('You cannot rename a Posted Salary');
    end;

    var
        NoSetup: Record "Sacco No. Series";
        NoSeriesMgt: Codeunit "No. Series";
        cust: Record Customer;
        "GL Account": Record "G/L Account";
        BANKACC: Record "Bank Account";
        ObjAccount: Record Vendor;

    local procedure FnGetCheckOffDescription() rtVal: Text
    var
        SUFFIX: Code[100];
    begin
        SUFFIX := 'SALARIES';

        case Date2dmy("Posting date", 2) of
            1:
                rtVal := 'JAN';
            2:
                rtVal := 'FEB';
            3:
                rtVal := 'MAR';
            4:
                rtVal := 'APR';
            5:
                rtVal := 'MAY';
            6:
                rtVal := 'JUN';
            7:
                rtVal := 'JUL';
            8:
                rtVal := 'AUG';
            9:
                rtVal := 'SEP';
            10:
                rtVal := 'OCT';
            11:
                rtVal := 'NOV';
            12:
                rtVal := 'DEC';

        end;
        exit(rtVal + Format(Date2dmy("Posting date", 3)) + SUFFIX);
    end;
}




