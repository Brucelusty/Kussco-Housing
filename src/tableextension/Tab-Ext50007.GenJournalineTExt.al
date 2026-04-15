//************************************************************************
tableextension 50007 "GenJournalineTExt" extends "Gen. Journal Line"
{
    fields
    {
        field(50000; "Transaction Type"; Enum TransactionTypesEnum)
        {
            // OptionCaption = ' ,Registration Fee,Shares Capital,Interest Paid,Repayment,Deposit Contribution,Insurance Contribution,BBF Fund,Loan,Coop Shares,Dividend,FOSA Account,Loan Insurance Charged,Loan Insurance Paid,Recovery Account,FOSA Shares,Additional Shares,Interest Due,Capital Reserve,Loan Penalty Charged,Loan Penalty Paid,HouseHold Savings,Housing Coop Shares,Utafiti Housing,Holiday Savings,Dependant 1 Savings,Dependant 2 Savings,Dependant 3 Savings,Interest on Deposits,Share Boost Fee,Rejoining Fee,Dormant Reactivation Fee';
            //  OptionMembers = " ","Registration Fee","Share Capital","Interest Paid",Repayment,"Deposit Contribution","Insurance Contribution","Benevolent Fund",Loan,"Coop Shares",Dividend,"FOSA Account","Loan Insurance Charged","Loan Insurance Paid","Recovery Account","FOSA Shares","Additional Shares","Interest Due","Capital Reserve","Loan Penalty Charged","Loan Penalty Paid","HouseHold Savings","Housing Coop Shares","Utafiti Housing","Holiday Savings","Dependant 1 Savings","Dependant 2 Savings","Dependant 3 Savings","Interest on Deposits","Share Boost Fee","Rejoining Fee","Dormant Reactivation Fee";

            trigger OnValidate()
            begin
                Description := Format("Transaction Type");
                "Loan Balance" := 0;
                if ("Transaction Type" = "Transaction Type"::Repayment) and ("Account Type" = "Account Type"::Customer) then begin
                    if "Loan No" <> '' then begin
                        loansReg.Reset();
                        loansReg.SetRange("Loan  No.", "Loan No");
                        if loansReg.Find('-') then begin
                            "Loan Balance" := loansReg."Approved Amount" + Amount;
                        end;
                    end;
                end;
            end;
        }
        field(50001; "Loan No"; Code[20])
        {
            TableRelation = "Loans Register"."Loan  No." where("Client Code" = field("Account No."));
            trigger OnValidate()
            begin
                loansReg.Reset();
                loansReg.SetRange("Loan  No.", "Loan No");
                if loansReg.Find('-') then begin
                    "test field" := loansReg."Approved Amount";
                end;
            end;
        }
        field(50002; "Loan Product Type"; Code[20])
        {
        }
        field(50003; Interest; Decimal)
        {
        }
        field(50004; Principal; Decimal)
        {
        }
        field(50005; Status; Option)
        {
            OptionCaption = 'Pending,Verified,Approved,Canceled';
            OptionMembers = Pending,Verified,Approved,Canceled;
        }
        field(50006; "User ID"; Code[25])
        {
        }
        field(50007; Posted; Boolean)
        {
        }
        field(50008; Charge; Code[20])
        {
            TableRelation = Resource."No.";

            trigger OnValidate()
            begin
                //IF Res.GET(Charge) THEN
                //Description:=Res.Name;
            end;
        }
        field(50009; "Calculate VAT"; Boolean)
        {
        }
        field(50010; "VAT Value Amount"; Decimal)
        {
        }
        field(50011; Bank; Text[30])
        {
        }
        field(50012; Branch; Text[30])
        {
        }
        field(50013; "Invoice to Post"; Code[20])
        {
        }
        field(50014; Found; Boolean)
        {
        }
        field(50015; "Staff No."; Code[20])
        {
        }
        field(50016; "Prepayment date"; Date)
        {
        }
        field(50017; LN; Code[20])
        {
            //todo
            // CalcFormula = lookup("HR Transport Requisition Pass".code where (code=field("Loan No")));
            // FieldClass = FlowField;
        }
        field(50018; "Group Code"; Code[20])
        {
        }
        field(50019; "Int Count"; Integer)
        {
            CalcFormula = count("Gen. Journal Line" where("Journal Template Name" = const('GENERAL'),
                                                           "Journal Batch Name" = const('INT DUE')));
            FieldClass = FlowField;
        }
        field(50020; "Member Name"; Text[70])
        {
        }
        field(50021; "Interest Due Amount"; Decimal)
        {
        }
        field(50022; "Interest Code"; Code[50])
        {
            Description = 'Investment Management Field';
            Editable = false;
        }
        field(50023; "Investor Interest"; Boolean)
        {
        }
        field(50024; "Int on Dep SMS"; Boolean)
        {
        }
        field(50025; "Dividend SMS"; Boolean)
        {
        }
        field(50026; Text; Text[30])
        {
        }
        field(50027; Blocked; enum "Vendor Blocked")
        {
            CalcFormula = lookup(Vendor.Blocked where("No." = field("Account No.")));
            FieldClass = FlowField;
        }
        field(50028; "ATM SMS"; Boolean)
        {
        }
        field(50029; "Trace ID"; Code[10])
        {
        }
        field(50030; Description2; Text[70])
        {
        }
        field(50031; "test field"; Decimal)
        {
        }
        field(50032; "Group Account No"; Code[20])
        {
        }
        field(50033; "Account No (BOSA)"; Code[20])
        {

            trigger OnValidate()
            begin
                ObjAccountNoBuffer.Reset;
                ObjAccountNoBuffer.SetRange(ObjAccountNoBuffer."Account No", "Account No (BOSA)");
                if ObjAccountNoBuffer.FindSet then begin
                    "Account No." := ObjAccountNoBuffer."Member No";
                    "Transaction Type" := ObjAccountNoBuffer."Transaction Type";
                    "Member Name" := ObjAccountNoBuffer."Account Name";
                    Description := Format(ObjAccountNoBuffer."Transaction Type");
                end;
            end;
        }
        field(50034; "Recovery Transaction Type"; Option)
        {
            OptionCaption = 'Normal,Guarantor Recoverd,Guarantor Paid';
            OptionMembers = Normal,"Guarantor Recoverd","Guarantor Paid";
        }
        field(50035; "Recoverd Loan"; Code[20])
        {
        }
        field(50036; "Application Source"; Option)
        {
            OptionCaption = '" ",CBS,ATM,Mobile,Internet,MPESA,Equity,"Co-op",Family,"SMS Banking"';
            OptionMembers = " ",CBS,ATM,Mobile,Internet,MPESA,Equity,"Co-op",Family,"SMS Banking";
        }
        field(50037; "Customer SubAccount Type"; OPtion)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "",Customer,Member;
        }
        field(50038; "Member No"; Code[60])
        {
            DataClassification = ToBeClassified;

        }
        field(50039; "Salary Receipt Type"; Option)
        {
            OptionCaption = '" ","1-Gross salary","2-Salary Processing Fee","3-Excise Duty","4-Loan Repayment","5-Interest Paid",6-STO,Net Pay';
            OptionMembers = " ","1-Gross salary","2-Salary Processing Fee","3-Excise Duty","4-Loan Repayment","5-Interest Paid","6-STO","Net Pay";
        }
        field(50040; "Loan Balance"; Decimal)
        {

        }

        modify("Account No.")
        {
            TableRelation = if ("Account Type" = filter(Member)) Customer;
        }


    }

    var
        GenJnlTemplate: Record "Gen. Journal Template";
        GenJnlBatch: Record "Gen. Journal Batch";
        GenJnlLine: Record "Gen. Journal Line";
        Currency: Record Currency;
        CurrExchRate: Record "Currency Exchange Rate";
        PaymentTerms: Record "Payment Terms";
        CustLedgEntry: Record "Cust. Ledger Entry";
        VendLedgEntry: Record "Vendor Ledger Entry";
        EmplLedgEntry: Record "Employee Ledger Entry";
        GenJnlAlloc: Record "Gen. Jnl. Allocation";
        VATPostingSetup: Record "VAT Posting Setup";
        GenBusPostingGrp: Record "Gen. Business Posting Group";
        GenProdPostingGrp: Record "Gen. Product Posting Group";
        GLSetup: Record "General Ledger Setup";
        Job: Record Job;
        SourceCodeSetup: Record "Source Code Setup";
        TempJobJnlLine: Record "Job Journal Line" temporary;
        SalespersonPurchaser: Record "Salesperson/Purchaser";
        NoSeriesMgt: Codeunit "No. Series";
        CustCheckCreditLimit: Codeunit "Cust-Check Cr. Limit";
        SalesTaxCalculate: Codeunit "Sales Tax Calculate";
        GenJnlApply: Codeunit "Gen. Jnl.-Apply";
        GenJnlShowCTEntries: Codeunit "Gen. Jnl.-Show CT Entries";
        CustEntrySetApplID: Codeunit "Cust. Entry-SetAppl.ID";
        VendEntrySetApplID: Codeunit "Vend. Entry-SetAppl.ID";
        EmplEntrySetApplID: Codeunit "Empl. Entry-SetAppl.ID";
        DimMgt: Codeunit DimensionManagement;
        PaymentToleranceMgt: Codeunit "Payment Tolerance Management";
        DeferralUtilities: Codeunit "Deferral Utilities";
        // ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        Window: Dialog;
        DeferralDocType: Option Purchase,Sales,"G/L";
        CurrencyCode: Code[10];
        Text014: label 'The %1 %2 has a %3 %4.\\Do you still want to use %1 %2 in this journal line?', Comment = '%1=Caption of Table Customer, %2=Customer No, %3=Caption of field Bill-to Customer No, %4=Value of Bill-to customer no.';
        TemplateFound: Boolean;
        Text015: label 'You are not allowed to apply and post an entry to an entry with an earlier posting date.\\Instead, post %1 %2 and then apply it to %3 %4.';
        CurrencyDate: Date;
        Text016: label '%1 must be G/L Account or Bank Account.';
        HideValidationDialog: Boolean;
        Text018: label '%1 can only be set when %2 is set.';
        Text019: label '%1 cannot be changed when %2 is set.';
        GLSetupRead: Boolean;
        ExportAgainQst: label 'One or more of the selected lines have already been exported. Do you want to export them again?';
        NothingToExportErr: label 'There is nothing to export.';
        NotExistErr: label 'Document number %1 does not exist or is already closed.', Comment = '%1=Document number';
        DocNoFilterErr: label 'The document numbers cannot be renumbered while there is an active filter on the Document No. field.';
        DueDateMsg: label 'This posting date will cause an overdue payment.';
        CalcPostDateMsg: label 'Processing payment journal lines #1##########';
        NoEntriesToVoidErr: label 'There are no entries to void.';
        OnlyLocalCurrencyForEmployeeErr: label 'The value of the Currency Code field must be empty. General journal lines in foreign currency are not supported for employee account type.';
        ObjAccountNoBuffer: Record "BOSA Accounts No Buffer";
        AccTypeNotSupportedErr: label 'You cannot specify a deferral code for this type of account.';
        SalespersonPurchPrivacyBlockErr: label 'Privacy Blocked must not be true for Salesperson / Purchaser %1.', Comment = '%1 = salesperson / purchaser code.';
        BlockedErr: label 'The Blocked field must not be %1 for %2 %3.', Comment = '%1=Blocked field value,%2=Account Type,%3=Account No.';
        BlockedEmplErr: label 'You cannot export file because employee %1 is blocked due to privacy.', Comment = '%1 = Employee no. ';
        Membr: Record "Members Register";
        loansReg: Record "Loans Register";
}


