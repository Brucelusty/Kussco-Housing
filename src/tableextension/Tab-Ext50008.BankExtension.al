//************************************************************************
tableextension 50008 "BankExtension" extends "Bank Account"
{
    fields
    {
        field(50000; "Cashier ID"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = User."User Name";
        }
        field(50001; "Minimum Teller Withholding"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50002; "Account Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Cashier,Treasury,Petty Cash';
            OptionMembers = " ",Cashier,Treasury,"Petty Cash";
        }
        field(50003; "Maximum Teller Withholding"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50004; "Max Withdrawal Limit"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50005; "Max Deposit Limit"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50006; "Bank Type1"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Normal,Petty Cash,Mobile Banking,Bank';
            OptionMembers = Normal,"Petty Cash","Mobile Banking",Bank;
        }
        field(50007; "Bankings Balance"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Balance (LCY)';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50008; "Treasury Balance"; Decimal)
        {
            CalcFormula = sum("Bank Account Ledger Entry"."Amount (LCY)" where("Bank Account No." = field("No."),
                                                                                "Global Dimension 1 Code" = field("Global Dimension 1 Filter"),
                                                                                "Global Dimension 2 Code" = field("Global Dimension 2 Filter"),
                                                                                Description = const('ISSUE TO TELLER'),
                                                                                Amount = filter(< 0)));
            FieldClass = FlowField;
        }
        field(50009; "Received From Treasury"; Decimal)
        {
            CalcFormula = sum("Bank Account Ledger Entry"."Amount (LCY)" where("Bank Account No." = field("No."),
                                                                                "Global Dimension 1 Code" = field("Global Dimension 1 Filter"),
                                                                                "Global Dimension 2 Code" = field("Global Dimension 2 Filter"),
                                                                                Description = filter('ISSUE TO TELLER')));
            FieldClass = FlowField;
        }
        field(50010; CashierID; Code[50])
        {
            Caption = 'User ID';
            DataClassification = ToBeClassified;
            NotBlank = true;
            TableRelation = "User Setup"."User ID";
            //This property is currently not supported
            //TestTableRelation = false;
            // ValidateTableRelation = false;


            trigger OnValidate()
            var
                UserMgt: Codeunit "User Management";
            begin
                //UserMgt.ValidateUserID(CashierID);
            end;
        }
        field(50011; "Bank Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Normal,Cash,"Fixed Deposit",SMPA,"Chq Collection",ATM,Msacco;

            trigger OnValidate()
            begin

                //  TestNoEntriesExist(FieldCaption("Bank Type"));
            end;
        }
        field(50012; "Pending Voucher Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50013; "Responsibility Center"; Code[10])
        {
            Caption = 'Responsibility Center';
            DataClassification = ToBeClassified;
            TableRelation = "Responsibility Center BR";

            trigger OnValidate()
            begin
                /*
                IF NOT UserMgt.CheckRespCenter(1,"Responsibility Center") THEN
                  ERROR(
                    Text005,
                    RespCenter.TABLECAPTION,UserMgt.GetPurchasesFilter);
                    */

            end;
        }
        field(50014; "Bank Branch Name"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(50015; Text; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(50016; "Cheque Clearing Bank"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50017; "Viable to Transact"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50018; "Bank Account Branch"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = filter(2));
        }
        field(50019; "Teller Balance"; Decimal)
        {
            CalcFormula = sum("Bank Account Ledger Entry".Amount where("Bank Account No." = field("No."),
                                                                        "Posting Date" = field("Date Filter")));
            FieldClass = FlowField;
        }
        field(50020; "Max Cheque Deposit Limit"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50021; "EFT/RTGS Bank"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50022; "GL Account"; Code[30])
        {
            // CalcFormula = lookup("Bank Account Posting Group"."G/L Bank Account No." where (Code=field("Bank Acc. Posting Group")));
            // Editable = false;
            // FieldClass = FlowField;
        }
        field(50023; "Bank Classification"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Internal Bank,External Bank';
            OptionMembers = "Internal Bank","External Bank";
        }
        field(50024; "Bankers Cheque Clearing Bank"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50025; "Charge PV Cheque Fee"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50026; "Inward Cheque Clearing Bank"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50027; "End of Day Done"; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50028; "End of Day Done On"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50029; "Teller Shortage Account"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account"."No." where("Direct Posting" = filter(true));
        }
        field(50030; "Teller Excess Account"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account"."No." where("Direct Posting" = filter(true));
        }

        field(50031; "Teller Shortage Account balance"; Decimal)
        {
            CalcFormula = sum("G/L Entry".Amount where("G/L Account No." = field("Teller Shortage Account")));
            FieldClass = FlowField;
        }
        field(50032; "Teller Excess Account balance"; Decimal)
        {
            CalcFormula = sum("G/L Entry".Amount where("G/L Account No." = field("Teller Excess Account")));
            FieldClass = FlowField;
        }
        field(50033; "MPESA Account"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Bank Account"."No.";
        }
        field(50034; "POS Account"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Bank Account"."No.";
        }

    }

    var
        myInt: Integer;
}


