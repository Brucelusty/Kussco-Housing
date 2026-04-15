//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50385 "Receipts & Payments"
{

    fields
    {
        field(1; "Transaction No."; Code[20])
        {
        }
        field(2; "Account No."; Code[30])
        {
            NotBlank = true;
            TableRelation = if ("Account Type" = const(Customer)) Customer."No." where(ISNormalMember = const(true))
            else
            if ("Account Type" = const(Debtor)) Customer."No." where(ISNormalMember = const(false))
            else
            // if ("Account Type" = const("Bank Account")) "Bank Account"."No."
            // else
            if ("Account Type" = const("G/L Account")) "G/L Account"."No."
            else
            if ("Account Type" = const(Vendor)) Vendor."No." where("Creditor Type" = filter("FOSA Account"),
                                                                                     Status = filter(<> Closed | Deceased), Blocked = filter(<> Payment | All))
            else
            if ("Account Type" = const(Member)) "Members Register"."No.";

            trigger OnValidate()
            var
                AccountType: Record "Account Types-Saving Products";
            begin


                if ("Account Type" = "account type"::Member) then begin
                    if MembersR.Get("Account No.") then
                        Name := MembersR.Name;

                end;
                if ("Account Type" = "account type"::Customer) then begin
                    if MembersR.Get("Account No.") then
                        Name := MembersR.Name;

                end;


                if ("Account Type" = "account type"::Vendor) then begin
                    if Vend.Get("Account No.") then
                        Name := Vend.Name;
                    AccountType.Reset();
                    AccountType.SetRange(AccountType.Code, Vend."Account Type");
                    if AccountType.FindFirst() then begin
                        //   /  Message('here');
                        "Account Type Name" := AccountType.Description;
                    end;
                end;

                if ("Account Type" = "account type"::"G/L Account") then begin
                    if GLAcct.Get("Account No.") then begin
                        Name := GLAcct.Name;
                    end;
                end;
            end;
        }
        field(3; Name; Text[50])
        {
        }
        field(4; Amount; Decimal)
        {
            NotBlank = true;
        }
        field(5; "Cheque No."; Code[20])
        {

            trigger OnValidate()
            begin
                BOSARcpt.Reset;
                BOSARcpt.SetRange(BOSARcpt."Cheque No.", "Cheque No.");
                BOSARcpt.SetRange(BOSARcpt.Posted, true);
                if BOSARcpt.Find('-') then
                    Error('Cheque no already exist in a posted receipt.');

                if "Receipt Mode" = "receipt mode"::Cheque then begin
                    if StrLen("Cheque No.") <> 6 then
                        Error('Cheque No. Can not be more or less than 6 Characters');
                end;
            end;
        }
        field(6; "Cheque Date"; Date)
        {
        }
        field(7; Posted; Boolean)
        {
            Editable = true;
        }
        field(8; "Employer No."; Code[20])
        {
            Editable = true;
            TableRelation = if (Source = const(BOSA),
                                "Receipt Mode" = filter(Cheque | "Deposit Slip" | Mpesa | "Standing order" | EFT | Cash)) "Bank Account"."No.";
        }
        field(9; "User ID"; Code[50])
        {
            Editable = false;
            TableRelation = "User Setup"."User ID";
        }
        field(10; "Allocated Amount"; Decimal)
        {
            CalcFormula = sum("Receipt Allocation".Amount where("Document No" = field("Transaction No.")));
            Editable = false;
            FieldClass = FlowField;

            trigger OnValidate()
            begin
                CalcFields("Un allocated Amount");
                Validate("Un allocated Amount");
            end;
        }
        field(11; "Transaction Date"; Date)
        {
            Editable = true;
        }
        field(12; "Transaction Time"; Time)
        {
            Editable = false;
        }
        field(13; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(14; "Account Type"; enum "Gen. Journal Account Type")
        {
            InitValue = Customer;
            Editable = false;
            // OptionCaption = 'Member,Debtor,G/L Account,FOSA Loan,Customer,Vendor,Micro';
            // OptionMembers = Member,Debtor,"G/L Account","FOSA Loan",Customer,Vendor,Micro;
        }
        field(15; "Transaction Slip Type"; Option)
        {
            OptionCaption = ' ,Standing Order,Direct Debit,Direct Deposit,Cash,Cheque,M-Pesa';
            OptionMembers = " ","Standing Order","Direct Debit","Direct Deposit",Cash,Cheque,"M-Pesa";
        }
        field(16; "Bank Name"; Code[50])
        {
        }
        field(17; "Teller/Bank Balance"; Decimal)
        {
            Editable = false;
            FieldClass = Normal;
        }
        field(18; "Till/Bank Name"; text[2048])
        {
            Editable = false;

        }
        field(19; "Approval Status"; Option)
        {
            Editable = false;
            OptionCaption = 'Open,Pending Approval,Rejected,Approved';
            OptionMembers = Open,"Pending Approval",Rejected,Approved;
        }
        field(20; "Other User"; Boolean)
        {
            Editable = false;
        }
        field(172000; Insuarance; Decimal)
        {
            FieldClass = Normal;
        }
        field(172001; "Un allocated Amount"; Decimal)
        {
            Editable = false;
            FieldClass = Normal;
        }
        field(172002; Source; Option)
        {
            OptionCaption = 'BOSA,FOSA,MICRO';
            OptionMembers = BOSA,FOSA,MICRO;
            editable = false;
        }
        field(172003; "Receipt Mode"; Option)
        {
            OptionCaption = 'Cash,Cheque,Mpesa,Standing order,Deposit Slip,EFT';
            OptionMembers = Cash,Cheque,Mpesa,"Standing order","Deposit Slip",EFT;
        }
        field(172004; Remarks; Text[50])
        {
        }
        field(172005; "Code"; Code[20])
        {
        }
        field(172006; Type; Option)
        {
            NotBlank = true;
            OptionMembers = " ",Receipt,Payment,Imprest,Advance;
        }
        field(172007; Description; Text[50])
        {
        }
        field(172008; "Default Grouping"; Code[20])
        {
            Editable = false;
        }
        field(172009; "Transation Remarks"; Text[50])
        {
        }
        field(172010; "Customer Payment On Account"; Boolean)
        {
        }
        field(172011; "G/L Account"; Code[20])
        {
            TableRelation = if ("Account Type" = const("G/L Account")) "G/L Account"."No.";

            trigger OnValidate()
            begin
                GLAcc.Reset;

                if GLAcc.Get("G/L Account") then begin
                    //IF Type=Type::Payment THEN
                    //  GLAcc.TESTFIELD(GLAcc."Budget Controlled",TRUE);
                    if GLAcc."Direct Posting" = false then begin
                        Error('Direct Posting must be True');
                    end;
                end;

                /*PayLine.RESET;
                PayLine.SETRANGE(PayLine.Type,Code);
                IF PayLine.FIND('-') THEN
                   ERROR('This Transaction Code Is Already in Use You Cannot Delete');uncomment*/

            end;
        }
        field(172012; Blocked; Boolean)
        {
        }
        field(172013; "Global Dimension 1 Code"; Code[50])
        {
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1),
                                                          "Dimension Value Type" = const(Standard));
        }
        field(172014; "Global Dimension 2 Code"; Code[50])
        {
            CaptionClass = '1,2,2';
            Editable = false;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2),
                                                          "Dimension Value Type" = const(Standard));
        }
        field(172015; "Excess Transaction Type"; Option)
        {
            OptionCaption = 'Deposit Contribution,Safari Saving,Silver Savings,Junior Savings';
            OptionMembers = "Deposit Contribution","Safari Saving","Silver Savings","Junior Savings";
        }

        field(172016; "Account Type Name"; Text[500])
        {
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "Transaction No.")
        {
            Clustered = true;
        }
        key(Key2; "Account Type", Posted)
        {
            SumIndexFields = Amount;
        }
        key(Key3; "Code")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        /*
        IF Posted THEN
        ERROR('Cannot delete a posted transaction');
        */

    end;

    trigger OnInsert()
    var
        ReceiptAllocation: Record "Receipt Allocation";
    begin
        if "Transaction No." = '' then begin
            NoSetup.Get();
            NoSetup.TestField(NoSetup."BOSA Receipts Nos");
            //NoSeriesMgt.GetNextNo(NoSetup."BOSA Receipts Nos");
            "Transaction No." := NoSeriesMgt.GetNextNo(NoSetup."BOSA Receipts Nos");

        end;

        "User ID" := UserId;
        "Transaction Date" := Today;
        "Transaction Time" := Time;
        //Source := Source::BOSA;
        // "Global Dimension 1 Code" := 'BOSA';
        "Global Dimension 2 Code" := SFactory.FnGetUserBranch();
        "Account Type" := "Account Type"::Customer;

        Banks.Reset;
        Banks.SetRange(Banks.CashierID, UserId);
        Banks.SetRange(Banks."Account Type", Banks."account type"::Cashier);
        if Banks.Find('-') then begin
            "Employer No." := Banks."No.";
            "Bank Name" := Banks.Name;
            "Till/Bank Name" := Banks.Name;
        end else
            Error('Cashier needs to be setup.');

        ReceiptAllocation.Reset;
        ReceiptAllocation.SetRange("Document No", Rec."Transaction No.");
        ReceiptAllocation.DeleteAll;
    end;

    trigger OnModify()
    begin
        /*IF Posted THEN
        ERROR('Cannot modify a posted transaction');
        */

    end;

    trigger OnRename()
    begin
        /*IF Posted THEN
        ERROR('Cannot rename a posted transaction');
        */

    end;

    var
        Cust: Record Customer;
        NoSetup: Record "Sacco No. Series";
        NoSeriesMgt: Codeunit "No. Series";
        BOSARcpt: Record "Receipts & Payments";
        GLAcct: Record "G/L Account";
        Mem: Record Customer;

        MembersR: Record Customer;
        Vend: Record Vendor;
        GLAcc: Record "G/L Account";
        PayLine: Record "Payment Line.";
        Banks: Record "Bank Account";
        SFactory: Codeunit "Au Factory";
}




