//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50673 "Cashier Transactions Card"
{
    ApplicationArea = All;
    DeleteAllowed = false;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Reports,Approval,Budgetary Control,Cancellation,Category7_caption,Category8_caption,Category9_caption,Category10_caption';
    SourceTable = Transactions;
    SourceTableView = where(Posted = const(false));

    layout
    {
        area(content)
        {
            group(Transactions)
            {
                Caption = 'Transactions';
                field(No; Rec.No)
                {
                    Editable = false;
                }
                field("Member No"; Rec."Member No")
                {
                    trigger OnValidate()
                    var
                        myInt: Integer;
                    begin
                        Rec."Account No" := '';
                        Rec."Book Balance" := 0;
                        Rec."Withdrawal Fee" := 0;
                        Rec."Withdrawal Fee Excise" := 0;
                    end;
                }
                field("Transaction ID"; Rec."Transaction ID") { }
                field("ID No"; Rec."ID No")
                {
                    trigger OnValidate()
                    var
                        myInt: Integer;
                        Cust: Record Customer;
                    begin
                        cust.reset();
                        cust.setrange(cust."ID No.", Rec."ID No");
                        if cust.findfirst then begin
                            Rec."Member No" := cust."No.";
                            Rec."Member Name" := cust.Name;
                        end
                    end;

                }
                field("Member Name"; Rec."Member Name")
                {
                    Editable = false;
                }

                field("Account No"; Rec."Account No")
                {

                    trigger OnValidate()
                    begin

                        if Rec.Posted = true then
                            Error('You cannot modify an already posted record.');

                        CalcAvailableBal;

                        Clear(AccP.Image);
                        Clear(AccP.Signature);
                        if AccP.Get(Rec."Account No") then begin
                            if AccountTypes.Get(AccP."Account Type") then
                                AccP.CalcFields(AccP.Balance);
                            Rec."Account Type" := AccP."Account Type";
                            Rec."Book Balance" := 0;
                            Rec."Balance CF" := 0;
                            Rec."Withdrawal Fee" := 0;
                            Rec."Withdrawal Fee Excise" := 0;
                            Rec."Transaction Type" := '';
                            // Rec."Book Balance" := AccP.Balance - 1000;
                            Rec."Book Balance" := AccP.Balance;
                            Rec."Balance CF" := AccP.GetAvailableBalance();
                            //rec.Modify();
                            /*//Hide Accounts
                            IF AccP.Hide = TRUE THEN BEGIN
                            IF UsersID.GET(USERID) THEN BEGIN
                            IF UsersID."Show Hiden" = FALSE THEN
                            ERROR('You do not have permission to transact on this account.');
                            END;
                            END; */
                            //Hide Accounts
                            //AccP.CALCFIELDS(AccP.Picture,AccP.Signature);
                        end;

                        Rec.CalcFields("Uncleared Cheques");
                        if AccP.Get(Rec."Account No") then begin
                            // Picture:=AccP.Picture;
                            Rec.Signature := AccP.Signature;

                        end;

                        FnShowFields();

                        VarshowSignatories := false;
                        VarShowAgents := false;

                        ObjAccountSignatories.Reset;
                        ObjAccountSignatories.SetRange(ObjAccountSignatories."Account No", Rec."Account No");
                        if ObjAccountSignatories.Find('-') = true then begin
                            VarshowSignatories := true;
                        end;

                        ObjAccountAgent.Reset;
                        ObjAccountAgent.SetRange(ObjAccountAgent."Account No", Rec."Account No");
                        if ObjAccountAgent.FindSet then begin
                            VarShowAgents := true;
                        end;
                    end;
                }
                field("Transaction Type"; Rec."Transaction Type")
                {

                    trigger OnValidate()
                    begin

                        if Rec.Posted = true then
                            Error('You cannot modify an already posted record.');
                        FChequeVisible := false;
                        BChequeVisible := false;
                        BReceiptVisible := false;
                        BOSAReceiptChequeVisible := false;
                        "Branch RefferenceVisible" := false;
                        LRefVisible := false;
                        ChequeTransfVisible := false;
                        ChequeWithdrawalVisible := false;
                        DepositSlipVisible := false;
                        ChequeWithOll := false;

                        //validating cheque
                        if Rec."Transaction Type" = 'ORDCHECK' then begin
                            FChequeVisible := true;
                        end;
                        if Rec."Transaction Type" = 'BANKERSCHEQUE' then begin
                            FChequeVisible := true;
                        end;
                        if Rec."Transaction Type" = 'CHQD' then begin
                            FChequeVisible := true;
                        end;
                        if Rec."Transaction Type" = 'CHQW' then begin
                            FChequeVisible := true;
                        end;




                        if TransactionTypes.Get(Rec."Transaction Type") then begin
                            if TransactionTypes.Type = TransactionTypes.Type::"Cheque Deposit" then begin
                                FChequeVisible := true;
                                Rec.Type := 'Cheque Deposit';
                                Rec.Modify();
                                if (Rec."Account No" = '502-00-000300-00') or (Rec."Account No" = '502-00-000303-00') then
                                    BOSAReceiptChequeVisible := true;
                            end;
                            if TransactionTypes.Type = TransactionTypes.Type::"Bankers Cheque" then begin
                                BChequeVisible := true;
                                Rec.Type := 'Bankers Cheque';
                                Rec.Modify();
                            end;

                            if (Rec."Transaction Type" = 'RECEIPT') or (Rec."Transaction Type" = 'FOSALOAN') then begin
                                BReceiptVisible := true;
                                Rec.Type := 'BOSA Receipt';
                                Rec.Modify();
                            end;

                            TellerTill.Reset;
                            TellerTill.SetRange(TellerTill."Account Type", TellerTill."account type"::Cashier);
                            TellerTill.SetRange(TellerTill.CashierID, UserId);
                            if TellerTill.Find('-') then begin
                                Rec."Bank Account" := TellerTill."No.";
                            end;

                            if TransactionTypes.Type = TransactionTypes.Type::Transfer then begin
                                ChequeTransfVisible := true;
                                Rec.Type := 'Transfer';
                                Rec.Modify();
                            end;

                            if TransactionTypes.Type = TransactionTypes.Type::"Inhouse Cheque Withdrawal" then begin
                                ChequeWithdrawalVisible := true;
                                Rec.Type := 'Withdrawal';
                                Rec.Modify();
                            end;

                            if TransactionTypes.Type = TransactionTypes.Type::"Cheque Withdrawal" then begin
                                ChequeWithOll := true;
                                Rec.Type := 'Cheque Withdrawal';
                                Rec.Modify();
                            end;

                            if TransactionTypes.Type = TransactionTypes.Type::"Deposit Slip" then begin
                                DepositSlipVisible := true;
                                Rec.Type := 'Deposit Slip';
                                Rec.Modify();
                            end;

                            if TransactionTypes.Type = TransactionTypes.Type::Encashment then begin
                                BReceiptVisible := true;
                                Rec.Type := 'Encashment';
                            end;


                        end;

                        if Rec."Branch Transaction" = true then begin
                            "Branch RefferenceVisible" := true;
                            LRefVisible := true;
                        end;

                        // if Acc.Get(Rec."Account No") then begin
                        //     if Acc."Account Category" = Acc."account category"::Project then begin
                        //         "Branch RefferenceVisible" := true;
                        //         LRefVisible := true;
                        //     end;
                        // end;
                        FnShowFields();

                        CalcAvailableBal;

                        ExcessFOSAAccountVisible := false;
                        if (Rec."Excess Transaction Type" = Rec."excess transaction type"::"Fosa Saving") or (Rec."Excess Transaction Type" = Rec."excess transaction type"::"Junior A/c") then begin
                            ExcessFOSAAccountVisible := true;
                        end;
                    end;
                }

                field("Account Type"; Rec."Account Type")
                {
                    Editable = false;
                }
                field("Till Balance"; Rec."Till Balance")
                {
                    Editable = false;
                }

                field("Book Balance"; Rec."Book Balance")
                {
                    Editable = false;
                    Caption = 'Available Balance';
                }

                field("Has Signatories"; Rec."Has Signatories")
                {
                    Importance = Additional;
                }
                field("Signing Instructions"; Rec."Signing Instructions")
                {
                    Editable = false;
                }
                field("Has Special Mandate"; Rec."Has Special Mandate")
                {
                    Editable = false;
                    Importance = Additional;
                    Visible = HasSpecialMandateVisible;
                }
                field("Transacting Agent"; Rec."Transacting Agent")
                {
                    Visible = TransactingAgentVisible;
                }
                field("Agent Name"; Rec."Agent Name")
                {
                    Caption = 'Transacting Agent Name';
                    Editable = false;
                    Visible = TransactingAgentNameVisible;
                }

                field(Amount; Rec.Amount)
                {


                    trigger OnValidate()
                    var
                        Charges: Decimal;
                    begin
                        if Rec."Transaction Type" = 'CHEQUEDEPOSIT' then begin
                            FChequeVisible := true;
                        end;
                        if Rec."Transaction Type" = 'BANKERSCHEQUE' then begin
                            FChequeVisible := true;
                        end;
                        if Rec."Transaction Type" = 'CHQD' then begin
                            FChequeVisible := true;
                        end;
                        if Rec."Transaction Type" = 'CHQW' then begin
                            FChequeVisible := true;
                        end;
                        if ObjAccountType.Get(Rec."Account Type") then begin
                            if (Rec.Amount >= ObjAccountType."Bulk Withdrawal Amount") and (Rec.Type = 'Withdrawal') then begin
                                BulkWithVisible := true;
                            end;
                        end;
                        Charges := 0;

                        //getting sms charges
                        SaccoSetup.get();
                        SMSCharges := SaccoSetup."SMS Fee Amount";

                        //HOLIDAY ACCOUNT
                        Rec."Balance CF" := Rec."Book Balance" - AccountTypes."Minimum Balance" - rec.Amount;
                        // if (rec."Account Type" = 'JIPANGE ACCOUNT') or (rec."Account Type" = 'CHILDREN ACCOUNT') or (rec."Account Type" = 'GROUP ACCOUNT') or (rec."Account Type" = 'HOLIDAY ACCOUNT') or (rec."Account Type" = 'VIP ACCOUNT') and (rec."Transaction Type" = 'CWDSAVING') then begin
                        if VarTransactionType = VarTransactionType::"Cash Withdrawal" then begin
                            if (rec.Amount >= 100) and (rec.Amount <= 5000) then begin
                                Charges := 50;
                                rec."Withdrawal Fee" := Charges;
                                rec."Withdrawal Fee Excise" := Charges * 0.2;
                                Rec."Balance CF" := Rec."Book Balance" - rec."Withdrawal Fee" - rec."Withdrawal Fee Excise" - SMSCharges - Rec.Amount;
                                //rec.Modify();

                            end else
                                if (rec.Amount >= 5001) and (rec.Amount <= 10000) then begin
                                    Charges := 70;
                                    rec."Withdrawal Fee" := Charges;
                                    rec."Withdrawal Fee Excise" := Charges * 0.2;
                                    Rec."Balance CF" := Rec."Book Balance" - rec."Withdrawal Fee" - rec."Withdrawal Fee Excise" - SMSCharges - Rec.Amount;
                                    //rec.Modify();

                                end else

                                    if (rec.Amount >= 10001) and (rec.Amount <= 30000) then begin
                                        Charges := 90;
                                        rec."Withdrawal Fee" := Charges;
                                        rec."Withdrawal Fee Excise" := Charges * 0.2;
                                        Rec."Balance CF" := Rec."Book Balance" - rec."Withdrawal Fee" - rec."Withdrawal Fee Excise" - SMSCharges - Rec.Amount;
                                        //rec.Modify();

                                    end else
                                        if (rec.Amount >= 30001) and (rec.Amount <= 50000) then begin
                                            Charges := 100;
                                            rec."Withdrawal Fee" := Charges;
                                            rec."Withdrawal Fee Excise" := Charges * 0.2;
                                            Rec."Balance CF" := Rec."Book Balance" - rec."Withdrawal Fee" - rec."Withdrawal Fee Excise" - SMSCharges - Rec.Amount;
                                            //rec.Modify();

                                        end else
                                            if (rec.Amount >= 50001) and (rec.Amount <= 100000) then begin
                                                Charges := 120;

                                                rec."Withdrawal Fee" := Charges;

                                                rec."Withdrawal Fee Excise" := Charges * 0.2;
                                                Rec."Balance CF" := Rec."Book Balance" - rec."Withdrawal Fee" - rec."Withdrawal Fee Excise" - SMSCharges - Rec.Amount;
                                                //rec.modify();


                                            end else
                                                if (rec.Amount >= 100001) and (rec.Amount <= 200000) then begin
                                                    Charges := 150;
                                                    rec."Withdrawal Fee" := Charges;
                                                    rec."Withdrawal Fee Excise" := Charges * 0.2;
                                                    Rec."Balance CF" := Rec."Book Balance" - rec."Withdrawal Fee" - rec."Withdrawal Fee Excise" - SMSCharges - Rec.Amount;
                                                    //rec.modify();
                                                end else
                                                    if (rec.Amount >= 200001) and (rec.Amount <= 500000) then begin
                                                        Charges := 200;
                                                        rec."Withdrawal Fee" := Charges;
                                                        rec."Withdrawal Fee Excise" := Charges * 0.2;
                                                        Rec."Balance CF" := Rec."Book Balance" - rec."Withdrawal Fee" - rec."Withdrawal Fee Excise" - SMSCharges - Rec.Amount;
                                                        //rec.modify();
                                                    end else
                                                        if (rec.Amount >= 500001) and (rec.Amount <= 1000000) then begin
                                                            Charges := 500;
                                                            rec."Withdrawal Fee" := Charges;
                                                            rec."Withdrawal Fee Excise" := Charges * 0.2;
                                                            Rec."Balance CF" := Rec."Book Balance" - rec."Withdrawal Fee" - rec."Withdrawal Fee Excise" - SMSCharges - Rec.Amount;
                                                            //rec.modify();
                                                        end else
                                                            if (rec.Amount >= 1000001) and (rec.Amount <= 5000000) then begin
                                                                Charges := 2500;
                                                                rec."Withdrawal Fee" := Charges;
                                                                rec."Withdrawal Fee Excise" := Charges * 0.2;
                                                                Rec."Balance CF" := Rec."Book Balance" - rec."Withdrawal Fee" - rec."Withdrawal Fee Excise" - SMSCharges - Rec.Amount;
                                                                //rec.modify();
                                                            end
                                                            //Rec.Modify();
                                                            //Message('Withdrawal Fee %1',rec."Withdrawal Fee")
                                                            ELSE begin
                                                                Rec."Balance CF" := Rec."Book Balance" - rec."Withdrawal Fee" - Rec.Amount;
                                                                //rec.Modify();
                                                            end;
                        end;
                        if VarTransactionType = VarTransactionType::"Cash Deposit" then begin
                            Rec."Balance CF" := Rec."Book Balance" + Rec.Amount - SMSCharges;
                        end;
                    end;
                }
                field("Minimum Account Balance"; Rec."Minimum Account Balance")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Withdrawal Fee"; Rec."Withdrawal Fee")
                {
                    Editable = false;


                }
                field("Withdrawal Fee Excise"; Rec."Withdrawal Fee Excise")
                {
                    Editable = false;
                }
                field(SMSCharges; SMSCharges)
                {
                    Editable = False;
                    Caption = 'SMS Fee Charges';
                }
                field("Balance CF"; Rec."Balance CF")
                {
                    Editable = false;

                }

                field("Bank Code."; Rec."Bank Code")
                {
                    Visible = false;
                    Caption = 'Cheque Source Bank';
                }
                field(Type; Rec.Type)
                {
                    Visible = false;
                }

                field("Transaction Mode New"; Rec."Transaction Mode New")
                {
                    Caption = 'Transaction Mode';
                }
                field(Description; Rec.Description)
                {
                }
                group(ODDetails)
                {
                    Visible = ODDetailsVisible;
                    field("Overdraft Limit"; Rec."Overdraft Limit")
                    {
                    }
                    field("Overdraft Expiry Date"; Rec."Overdraft Expiry Date")
                    {
                    }
                    field("Overdraft Balance"; Rec."Overdraft Balance")
                    {
                    }
                }
                group(DepositSlip)
                {
                    Visible = DepositSlipVisible;
                    field("Receipt Bank."; Rec."Bank Account")
                    {
                        Caption = 'Receipt Bank';
                    }
                    field("Document Date"; Rec."Document Date")
                    {
                    }
                }
                group(BCheque)
                {
                    Caption = 'BankersCheque Details';
                    Visible = BChequeVisible;
                    field("Bankers Cheque No"; Rec."Bankers Cheque No")
                    {
                    }
                    field(Payee; Rec.Payee)
                    {
                    }
                    field("Post Dated"; Rec."Post Dated")
                    {

                        trigger OnValidate()
                        begin
                            "Transaction DateEditable" := false;
                            if Rec."Post Dated" = true then
                                "Transaction DateEditable" := true
                            else
                                Rec."Transaction Date" := Today;
                        end;
                    }
                    field("Cheque Clearing Bank Code"; Rec."Cheque Clearing Bank Code")
                    {
                        Caption = 'Cheque Clearing Bank_ Code';
                    }
                    field("Cheque Clearing Bank"; Rec."Cheque Clearing Bank")
                    {
                        Caption = 'Cheque Clearing_Bank';
                        Editable = false;
                    }
                }
                group(ChequeWith)
                {
                    Caption = 'Cheque Details';
                    Visible = ChequeWithOll;
                    field("Cheque NoChq"; Rec."Bankers Cheque No")
                    {
                        Caption = 'Cheque No';
                    }

                    field("Cheque Document Number"; Rec."Cheque Document Number")
                    {
                        Caption = 'Cheque Document Number"';
                    }
                    field("CheqWith Payee"; Rec.Payee)
                    {
                        Caption = 'Payee';
                    }
                    field("ChequeWith Post Dated"; Rec."Post Dated")
                    {
                        Caption = 'Post Dated';

                        trigger OnValidate()
                        begin
                            "Transaction DateEditable" := false;
                            if Rec."Post Dated" = true then
                                "Transaction DateEditable" := true
                            else
                                Rec."Transaction Date" := Today;
                        end;
                    }
                    field("Cheque Clearing Bank Code Cheq"; Rec."Cheque Clearing Bank Code")
                    {
                        Caption = 'Cheque Clearing Bank Code';
                    }
                    field("Cheque Clearing Bank Cheq"; Rec."Cheque Clearing Bank")
                    {
                        Caption = 'Cheque Clearing Bank';
                        Editable = false;
                    }
                }
                group(BReceipt)
                {
                    Caption = 'Bosa Receipt Details';
                    Visible = BReceiptVisible;
                    field("BOSA Account No"; Rec."BOSA Account No")
                    {
                        Visible = false;
                    }
                    field("Allocated Amount"; Rec."Allocated Amount")
                    {
                    }
                    field("Receipt Bank"; Rec."Bank Account")
                    {
                    }
                    field("<Document Date.>"; Rec."Document Date")
                    {
                        Caption = 'Document Date';
                        Editable = false;
                    }
                    field("Excess Transaction Type"; Rec."Excess Transaction Type")
                    {
                    }
                    group("Excess FOSA Account")
                    {
                        Caption = 'Excess FOSA Account';
                        Visible = ExcessFOSAAccountVisible;
                        field("Excess Funds Account"; Rec."Excess Funds Account")
                        {
                        }
                    }
                }
                group(FCheque)
                {
                    Caption = 'Cheque Deposit Details';
                    Visible = FChequeVisible;
                    field("Cheque Type"; Rec."Cheque Type")
                    {
                    }
                    field("Clearing Days."; Rec."Clearing Days.")
                    {
                    }
                    field("Cheque No"; Rec."Cheque No")
                    {



                    }
                    field("Bank Code"; Rec."Bank Code")
                    {
                        Caption = 'Cheque Source Bank';
                        Visible = false;
                    }
                    field("<Cheque Clearing Bank_Code>"; Rec."Cheque Clearing Bank Code")
                    {
                        Caption = 'Cheque Clearing Bank Code>';
                    }
                    field("<Cheque_Clearing Bank>"; Rec."Cheque Clearing Bank")
                    {
                        Caption = 'Cheque Clearing Bank';
                        Editable = false;
                    }
                    field("Expected Maturity Date"; Rec."Expected Maturity Date")
                    {
                        Editable = false;
                    }
                    field(Status; Rec.Status)
                    {
                        Editable = false;
                    }
                    field("172048"; Rec."Banking Posted")
                    {
                        Caption = 'Banked';
                        Editable = false;
                    }
                    field("Bank Account"; Rec."Bank Account")
                    {
                        Visible = false;
                    }

                    field("Cheque Destination Type"; Rec."Cheque Destination Type")
                    {
                    }

                    field("Destination Allocated Amount"; Rec."Destination Allocated Amount")
                    {
                        Editable = false;
                    }
                    field("Cheque Date"; Rec."Cheque Date")
                    {
                    }
                    field("Cheque Deposit Remarks"; Rec."Cheque Deposit Remarks")
                    {
                    }
                }
                group(ChequeWithdrawal)
                {
                    Caption = 'Cheque Withdraw Details';
                    Visible = ChequeWithdrawalVisible;
                    field("Cheque TypeWith"; Rec."Cheque Type")
                    {
                        Caption = 'Cheque Type';
                    }
                    field("Drawer's Account No."; Rec."Drawer's Account No")
                    {
                        Caption = 'Drawer''s Account No.';
                    }
                    field("Drawer's NameWith"; Rec."Drawer's Name")
                    {
                        Caption = 'Drawer''s Name';
                        Editable = false;
                    }
                    field("Drawers Cheque No.With"; Rec."Drawers Cheque No.")
                    {
                        Caption = 'Drawers Cheque No.';
                    }
                    field("Cheque DateWith"; Rec."Cheque Date")
                    {
                        Caption = 'Cheque Date';
                    }
                    field("Cheque Deposit RemarksWith"; Rec."Cheque Deposit Remarks")
                    {
                        Caption = 'Cheque Deposit Remarks';
                    }
                    field("Cheque Clearing Bank Code.With"; Rec."Cheque Clearing Bank Code")
                    {
                        Caption = 'Cheque Clearing Bank Code.';
                    }
                }
                group(ChequeTransf)
                {
                    Caption = 'Cheque Transfer Details';
                    Visible = ChequeTransfVisible;
                    field("Cheque TypeTR"; Rec."Cheque Type")
                    {
                        Caption = 'Cheque Type';
                    }
                    field("Drawer's Account No"; Rec."Drawer's Account No")
                    {
                    }
                    field("Drawer's Name"; Rec."Drawer's Name")
                    {
                        Editable = false;
                    }
                    field("Drawers Cheque No."; Rec."Drawers Cheque No.")
                    {
                    }
                    field("Cheque DateTR"; Rec."Cheque Date")
                    {
                        Caption = 'Cheque Date';
                    }
                    field("Cheque Deposit RemarksTR"; Rec."Cheque Deposit Remarks")
                    {
                        Caption = 'Cheque Deposit Remarks';
                    }
                    field("<Cheque Clearing Bank Code.>"; Rec."Cheque Clearing Bank Code")
                    {
                        Caption = 'Cheque Clearing Bank Code.';
                    }
                }
            }
            group("Bulk Withdrawal Details")
            {
                Caption = 'Bulk Withdrawal Details';
                Visible = BulkWithVisible;
                field("Bulk Withdrawal Appl Done"; Rec."Bulk Withdrawal Appl Done")
                {
                    Caption = 'Bulk Withdrawal Application Done';
                    Editable = false;
                }
                field("Bulk Withdrawal Appl Date"; Rec."Bulk Withdrawal Appl Date")
                {
                    Caption = 'Bulk Withdrawal Application Date';
                    Editable = false;
                }
                field("Bulk Withdrawal Appl Amount"; Rec."Bulk Withdrawal Appl Amount")
                {
                    Caption = 'Bulk Withdrawal Application Amount';
                    Editable = false;
                }
                field("Bulk Withdrawal Date"; Rec."Bulk Withdrawal Date")
                {
                    Caption = 'Bulk Withdrawal Date';
                    Editable = false;
                }
                field("Bulk Withdrawal Fee"; Rec."Bulk Withdrawal Fee")
                {
                    Caption = 'Bulk Withdrawal Fee Charged';
                    Editable = false;
                }
                field("Bulk Withdrawal App Done By"; Rec."Bulk Withdrawal App Done By")
                {
                    Caption = 'Bulk Withdrawal Application Done By';
                    Editable = false;
                }
                field("Total Amount Transacted Today"; Rec."Total Amount Transacted Today")
                {
                    Caption = 'Total Amount Withdrawned Today';
                    Editable = false;
                }
                group(BOSAReceiptCheque)
                {
                    Caption = 'Bosa Receipt Cheque Details';
                    Visible = BOSAReceiptChequeVisible;
                }
                field("Account Name"; Rec."Account Name")
                {
                    Editable = false;
                    Importance = Additional;
                }
                field("Transaction Description"; Rec."Transaction Description")
                {
                    Editable = true;
                    Importance = Additional;
                }

                field("Uncleared Cheques"; Rec."Uncleared Cheques")
                {
                }
                field(AvailableBalance; AvailableBalance)
                {
                    Caption = 'Available Balance';
                    Editable = false;
                }
                field("N.A.H Balance"; Rec."N.A.H Balance")
                {
                    Editable = false;
                    Importance = Additional;
                    Visible = false;
                }
                field("IDNo"; Rec."ID No")
                {
                    Editable = false;
                    Importance = Additional;
                }
                field(Cashier; Rec.Cashier)
                {
                    Importance = Additional;
                }
                field("Transaction Date"; Rec."Transaction Date")
                {
                    Editable = false;
                    Importance = Additional;
                }
                field("Transaction Time"; Rec."Transaction Time")
                {
                    Editable = false;
                    Importance = Additional;
                }
                field(Authorised; Rec.Authorised)
                {
                    Editable = false;
                }
                field(Posted; Rec.Posted)
                {
                    Editable = false;
                    Importance = Additional;
                }
                field(Picture; Rec.Picture)
                {
                }
            }
            part("Receipt Allocation"; "Receipt Allocation Cheque")
            {
                SubPageLink = "Document No" = field(No);
                Visible = FChequeVisible;
            }
            // part(AccountAgents; "Account Agent List")
            // {
            //     Caption = 'Account Agents';
            //     SubPageLink = "Account No" = field("Account No");
            //     Visible = VarShowAgents;
            // }
            // part(AccountSignatories; "Account Signatories Details")
            // {
            //     Caption = 'Account Signatories';
            //     SubPageLink = "Account No" = field("Account No");
            //     Visible = VarshowSignatories;
            // }
        }
        area(factboxes)
        {
            part(Contro28; "Member Picture-Uploaded")
            {
                Caption = 'Picture';
                Editable = false;
                ShowFilter = false;
                SubPageLink = "No." = field("Member No");
                //Visible = ShowMembershipImages;
            }
            part(Contro27; "Member Signature-Uploaded")
            {
                Caption = 'Signature';
                Editable = false;
                SubPageLink = "No." = field("Member No");
                //Visible = ShowMembershipImages;
            }

            part(Control1000000000; "FOSA Statistics FactBox")
            {
                SubPageLink = "No." = field("Account No");
            }
            part(Control1000000018; "Member Statistics FactBox")
            {
                SubPageLink = "No." = field("Member No");
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Transaction)
            {
                Caption = 'Transaction';
                action("Account Card")
                {
                    Caption = 'Account Card';
                    Image = Vendor;
                    Promoted = true;
                    RunObject = Page "Member Account Card View";
                    RunPageLink = "No." = field("Account No");
                }
                separator(Action1102760031)
                {
                }
                action("Account Signatories")
                {
                    Caption = 'Signatories Details';
                    Promoted = true;
                    //PromotedCategory = Process;
                    RunObject = Page "Member Account Signatory list";
                    RunPageLink = "Account No" = field("Member No");
                }
            }
            action("Account Agent Details")
            {
                Promoted = true;
                //PromotedCategory = Process;
                RunObject = Page "Account Agent List";
                RunPageLink = "Account No" = field("Account No");
            }
            action("Members Statistics")
            {
                Image = Statistics;
                Promoted = true;
                //PromotedCategory = Process;
                RunObject = Page "Members Statistics";
                RunPageLink = "No." = field("Member No");
            }
            action("Account Statement")
            {
                Promoted = true;
                PromotedCategory = "Report";

                trigger OnAction()
                begin

                    Vend.Reset;
                    Vend.SetRange(Vend."No.", Rec."Account No");
                    if Vend.Find('-') then
                        Report.Run(172890, true, false, Vend)
                end;
            }
            action("Suggest Payments")
            {
                Caption = 'Suggest Monthy Repayments';
                Image = Suggest;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    Rec.TestField(Posted, false);
                    //TESTFIELD("Account No.");
                    Rec.TestField(Amount);
                    // ,Registration Fee,Share Capital,Interest Paid,Loan Repayment,Deposit Contribution,Insurance Contribution,Benevolent Fund,Loan,Unallocated Funds,Dividend,FOSA Account

                    ObjTransactions.Reset;
                    ObjTransactions.SetRange(ObjTransactions."Document No", Rec.No);
                    if ObjTransactions.Find('-') then
                        ObjTransactions.DeleteAll;
                    Datefilter := '..' + Format(Rec."Transaction Date");
                    RunBal := 0;
                    RunBal := Rec.Amount;
                    RunBal := FnRunEntranceFee(Rec, RunBal);
                    RunBal := FnRunShareCapital(Rec, RunBal);
                    RunBal := FnRunInsurance(Rec, RunBal);
                    RunBal := FnRunInterest(Rec, RunBal);
                    RunBal := FnRunLoanInsurance(Rec, RunBal);
                    RunBal := FnRunPrinciple(Rec, RunBal);
                    RunBal := FnRunDepositContribution(Rec, RunBal);
                    //RunBal:=FnRunInsuranceContribution(Rec,RunBal);
                    //RunBal:=FnRunBenevolentFund(Rec,RunBal);
                    if RunBal > 0 then begin
                        if Confirm('Excess Money will allocated to ' + Format(Rec."Excess Transaction Type") + '.Do you want to Continue?', true) = false then
                            exit;
                        case Rec."Excess Transaction Type" of
                            Rec."excess transaction type"::Deposits:
                                FnRunDepositContributionFromExcess(Rec, RunBal);
                            Rec."excess transaction type"::"Fosa Saving":
                                FnRunSavingsProductExcess(Rec, RunBal, 'SAVINGS');
                            Rec."excess transaction type"::"Gold Save":
                                FnRunSavingsProductExcess(Rec, RunBal, 'GOLDSAVE');
                            Rec."excess transaction type"::"Junior A/c":
                                FnRunSavingsProductExcess(Rec, RunBal, 'NFK-JUNIOR');
                        end;
                        //RunBal:=FnRunUnallocatedAmount(Rec,RunBal);
                    end;

                    Rec.CalcFields("Allocated Amount");
                    //"Un allocated Amount":=(Amount-"Allocated Amount");
                    Rec.Modify;
                end;
            }
        }
        area(processing)
        {
            action(Post)
            {
                Caption = 'Post (F11)';
                Image = Post;
                Promoted = true;
                //PromotedCategory = Process;
                ShortCutKey = 'F11';

                trigger OnAction()
                begin


                    if Confirm('Are you sure you want to post this transaction?', false) = true then begin
                        // Rec.TestField("EOD Done?", true);
                        //Check if Posted
                        //Message('Checking if posted......');
                        BankLedger.Reset;
                        BankLedger.SetRange(BankLedger."Document No.", Rec.No);
                        if BankLedger.Find('-') then begin
                            Rec.Posted := true;
                            Rec.Modify;
                            //Message('Transaction is aready posted');
                            CurrPage.Close;
                            exit;
                        end;
                        //Message('Checking if posted ended.');

                        //Auto Update the Excess Amount on Receipt--------------------------------------------
                        Rec.CalcFields("Allocated Amount");
                        if (Rec.Amount > Rec."Allocated Amount") and (Rec.Type = 'RECEIPT') then begin
                            if Confirm('Excess Amount will be Allocated to the ' + Format(Rec."Excess Transaction Type") + ' Account', false) = true then begin
                                ObjReceiptAllocation.Init;
                                ObjReceiptAllocation."Document No" := Rec.No;
                                ObjReceiptAllocation."Member No" := Rec."Member No";
                                ObjReceiptAllocation.Amount := (Rec.Amount - Rec."Allocated Amount");
                                if Rec."Excess Transaction Type" = Rec."excess transaction type"::Deposits then begin
                                    ObjReceiptAllocation."Transaction Type" := ObjReceiptAllocation."transaction type"::"Deposit Contribution";
                                    ObjReceiptAllocation."Account Type" := ObjReceiptAllocation."account type"::Member;
                                    ObjReceiptAllocation.Validate(ObjReceiptAllocation."Transaction Type")
                                end else
                                    if (Rec."Excess Transaction Type" = Rec."excess transaction type"::"Fosa Saving") or (Rec."Excess Transaction Type" = Rec."excess transaction type"::"Junior A/c") then begin
                                        ObjReceiptAllocation."Transaction Type" := ObjReceiptAllocation."transaction type"::" ";
                                        ObjReceiptAllocation."Account No" := Rec."Excess Funds Account";
                                        ObjReceiptAllocation."Account Type" := ObjReceiptAllocation."account type"::Vendor;
                                        ObjReceiptAllocation.Insert;
                                    end;
                            end;
                        end;

                        //End Auto Update the Excess Amount on Receipt--------------------------------------------






                        //Ensure Min Share Capital Is Contributed
                        BosaSetUp.Get();
                        TransactionTypes.Reset();
                        TransactionTypes.SetRange(TransactionTypes.Code, Rec."Transaction Type");
                        if TransactionTypes.Find('-') then begin
                            VarTransactionType := TransactionTypes.Type;
                        end;
                        if Rec.Type = 'BOSA Receipt' then begin
                            if Cust.Get(Rec."Member No") then begin
                                Cust.CalcFields(Cust."Registration Fee Paid", Cust."Shares Retained");
                                if Cust."Shares Retained" < BosaSetUp."Retained Shares" then begin
                                    ReceiptAllocations.Reset;
                                    ReceiptAllocations.SetRange(ReceiptAllocations."Document No", Rec.No);
                                    ReceiptAllocations.SetRange(ReceiptAllocations."Transaction Type", ReceiptAllocations."transaction type"::"Deposit Contribution");
                                    if not ReceiptAllocations.Find('-') then
                                        Message('The Member Must first Contribute Min. Share Capital Amount');

                                    ReceiptAllocations.Reset;
                                    ReceiptAllocations.SetRange(ReceiptAllocations."Document No", Rec.No);
                                    //ReceiptAllocations.SETRANGE(ReceiptAllocations."Transaction Type",ReceiptAllocations."Transaction Type"::"Shares Capital");
                                    if ReceiptAllocations.Find('-') then begin
                                        //IF ReceiptAllocations."Transaction Type"=ReceiptAllocations."Transaction Type"::"Shares Capital" THEN BEGIN
                                        if ReceiptAllocations.Count > 1 then
                                            if ReceiptAllocations.Amount < (BosaSetUp."Retained Shares" - Cust."Shares Retained") then
                                                Message('The Member Must first Contribute Min. Share Capital Amount');
                                    end;
                                end;
                            end;
                        end;

                        if Rec.Cashier <> UpperCase(UserId) then
                            Error('Cannot post a Transaction being processed by %1', Rec.Cashier);

                        BankLedger.Reset;
                        BankLedger.SetRange(BankLedger."Posting Date", Today);
                        BankLedger.SetRange(BankLedger."User ID", Rec."Posted By");
                        BankLedger.SetRange(BankLedger.Description, 'END OF DAY RETURN TO TREASURY');
                        if BankLedger.Find('-') = true then begin
                            Error('You cannot post any transactions after perfoming end of day');
                        end;




                        UsersID.Reset;
                        UsersID.SetRange(UsersID."User Name", UpperCase(UserId));
                        if UsersID.Find('-') then begin
                            //DBranch := UsersID."Branch Code";
                            DBranch := '';
                            DActivity := '';
                            //MESSAGE('%1,%2',Branch,Activity);
                        end;


                        if Rec."Transaction Date" <> Today then begin
                            Rec."Transaction Date" := Today;
                            Rec.Modify;
                        end;



                        if Rec.Posted = true then
                            Error('The transaction has already been posted.');

                        VarAmtHolder := 0;

                        if Rec.Amount <= 0 then
                            Error('Please specify an amount greater than zero.');

                        if Rec."Transaction Type" = '' then
                            Error('Please select the transaction type.');

                        //BOSA Entries
                        /* if (Rec."Account No" = '502-00-000300-00') or (Rec."Account No" = '502-00-000303-00') then begin
                            Rec.TestField("BOSA Account No");
                            if Rec.Amount <> Rec."Allocated Amount" then
                                //Error('Allocated amount must be equall to the transaction amount.');

                        end; */


                        Rec."Post Attempted" := true;
                        Rec.Modify;

                        if VarTransactionType = VarTransactionType::"Cheque Deposit" then begin
                            Rec.TestField("Cheque Type");
                            Rec.TestField("Cheque No");
                            Rec.TestField("Cheque Date");
                            //Rec.TestField("Bank Code");
                            Rec.CalcFields(Rec."Destination Allocated Amount");
                            if Rec."Destination Allocated Amount" <> Rec.Amount then
                                //Error('Amount must be equal to allocated amount.');
                                PostChequeDep;

                            exit;
                        end;

                        if VarTransactionType = VarTransactionType::Transfer then begin
                            Rec.TestField("Drawers Cheque No.");
                            Rec.TestField("Drawer's Account No");

                            PostTransfer;

                            exit;
                        end;

                        if VarTransactionType = VarTransactionType::"Bankers Cheque" then begin

                            PostBankersChequeVer1;

                            exit;

                        end;
                        //Message('starting %1', VarTransactionType);
                        if VarTransactionType = VarTransactionType::"MPESA Withdrawal" then begin


                            PostMpesawithdrawal;

                            exit;

                        end;

                        if VarTransactionType = VarTransactionType::"MPESA Deposit" then begin


                            PostMpesaDeposit();

                            exit;

                        end;


                        if VarTransactionType = VarTransactionType::"POS Withdrawal" then begin


                            PostPOSwithdrawal;

                            exit;

                        end;

                        if VarTransactionType = VarTransactionType::"POS Deposit" then begin


                            PostPOSDeposit();

                            exit;

                        end;
                        if (VarTransactionType = VarTransactionType::Encashment) or (VarTransactionType = VarTransactionType::"Inhouse Cheque Withdrawal") then begin
                            PostEncashment;

                            exit;
                        end;
                        if VarTransactionType = VarTransactionType::"Deposit Slip" then begin
                            PostDepSlipDep;
                        end;


                        if Rec.Type = 'BOSA Receipt' then begin
                            PostBOSAEntries;
                            exit;
                        end;

                        if VarTransactionType = VarTransactionType::Transfer then begin
                            PostTransfer;
                        end;

                        if (VarTransactionType = VarTransactionType::"Cash Withdrawal") or (VarTransactionType = VarTransactionType::"Cash Deposit") then begin
                            //ADDED
                            PostCashDepWith;
                        end;

                        if VarTransactionType = VarTransactionType::"Cheque Withdrawal" then begin
                            PostChequeWith
                        end;

                        exit;
                        //ADDED
                    end;
                end;
            }
            action("Freeze Account")
            {
                Image = "Action";
                Promoted = true;
                PromotedCategory = Process;
                Visible = true;

                trigger OnAction()
                begin
                    if Confirm('Are you Sure you want to Freeze this Account?', false) = true then begin
                        Rec.TestField("Reason For Freezing Account");
                        if Account.Get(Rec."Account No") then begin
                            Account.Status := Account.Status::Frozen;
                            Account.Blocked := Account.Blocked::All;
                            Account."Reason for Freezing Account" := Rec."Reason For Freezing Account";
                            Account."Account Frozen By" := UserId;
                            Account.Modify;
                        end;
                    end;
                    Message('Account Frozen Succesfully');
                end;
            }
            action(SendMail)
            {
                Caption = 'SendMail';
                Promoted = true;
                PromotedCategory = Process;
                Visible = false;

                trigger OnAction()
                begin
                    MailContent := 'Bankers cheque transaction' + ' ' + 'of Kshs' + ' ' + Format(Rec.Amount) + ' ' + 'for'
                    + ' ' + Rec."Account Name" + ' ' + 'needs your approval';


                    SendEmail;
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin

        Rec.SetRange(Cashier, UserId);
        FChequeVisible := false;
        BChequeVisible := false;
        BReceiptVisible := false;
        BOSAReceiptChequeVisible := false;
        ChequeTransfVisible := false;
        TransactionTypes.Reset();
        TransactionTypes.SetRange(TransactionTypes.Code, Rec."Transaction Type");
        if TransactionTypes.Find('-') then begin
            VarTransactionType := TransactionTypes.Type;
        end;
        if (VarTransactionType = VarTransactionType::"Cheque Withdrawal") or (VarTransactionType = VarTransactionType::"Cheque Deposit") then begin
            FChequeVisible := true;
            if (Rec."Account No" = '502-00-000300-00') or (Rec."Account No" = '502-00-000303-00') then
                BOSAReceiptChequeVisible := true;

        end;

        "Branch RefferenceVisible" := false;
        LRefVisible := false;


        if VarTransactionType = VarTransactionType::"Bankers Cheque" then
            BChequeVisible := true;

        if VarTransactionType = VarTransactionType::Encashment then
            BReceiptVisible := true;


        if (Rec."Transaction Type" = 'RECEIPT') or (Rec."Transaction Type" = 'FOSALN') then
            BReceiptVisible := true;

        if VarTransactionType = VarTransactionType::Transfer then
            ChequeTransfVisible := true;

        if Rec."Branch Transaction" = true then begin
            "Branch RefferenceVisible" := true;
            LRefVisible := true;
        end;

        if Acc.Get(Rec."Account No") then begin
            // if Acc."Account Category" = Acc."account category"::Project then begin
            //     "Branch RefferenceVisible" := true;
            //     LRefVisible := true;
            // end;
            //getting sms charges
            SaccoSetup.get();
            SMSCharges := SaccoSetup."SMS Fee Amount";
        end;


        "Transaction DateEditable" := false;
        if Rec."Post Dated" = true then
            "Transaction DateEditable" := true;

        if ObjAccountType.Get(Rec."Account Type") then begin
            if (Rec.Amount >= ObjAccountType."Bulk Withdrawal Amount") and (VarTransactionType = VarTransactionType::"Cash Withdrawal") then begin
                BulkWithVisible := true;
            end;
        end;
        FnShowFields();


        VarshowSignatories := false;
        VarShowAgents := false;

        ObjAccountSignatories.Reset;
        ObjAccountSignatories.SetRange(ObjAccountSignatories."Account No", Rec."Account No");
        if ObjAccountSignatories.Find('-') = true then begin
            VarshowSignatories := true;
        end;

        ObjAccountAgent.Reset;
        ObjAccountAgent.SetRange(ObjAccountAgent."Account No", Rec."Account No");
        if ObjAccountAgent.FindSet then begin
            VarShowAgents := true;
        end;

        ExcessFOSAAccountVisible := false;
        if (Rec."Excess Transaction Type" = Rec."excess transaction type"::"Fosa Saving") or (Rec."Excess Transaction Type" = Rec."excess transaction type"::"Junior A/c") then begin
            ExcessFOSAAccountVisible := true;
        end;
    end;


    trigger OnAfterGetCurrRecord()
    begin

        Rec.SetRange(Cashier, UserId);
        FChequeVisible := false;
        BChequeVisible := false;
        BReceiptVisible := false;
        BOSAReceiptChequeVisible := false;
        ChequeTransfVisible := false;
        TransactionTypes.Reset();
        TransactionTypes.SetRange(TransactionTypes.Code, Rec."Transaction Type");
        if TransactionTypes.Find('-') then begin
            VarTransactionType := TransactionTypes.Type;
        end;
        if (VarTransactionType = VarTransactionType::"Cheque Withdrawal") or (VarTransactionType = VarTransactionType::"Cheque Deposit") then begin
            FChequeVisible := true;
            if (Rec."Account No" = '502-00-000300-00') or (Rec."Account No" = '502-00-000303-00') then
                BOSAReceiptChequeVisible := true;
        end;


    end;

    trigger OnDeleteRecord(): Boolean
    begin
        if Rec.Posted = true then
            Error('You cannot delete an already posted record.');
    end;

    trigger OnInit()
    begin
        "Transaction DateEditable" := true;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Clear(Acc.Image);
        Clear(Acc.Signature);

        Rec."Needs Approval" := Rec."needs approval"::No;
        FChequeVisible := false;


        CashierTrans.Reset;
        CashierTrans.SetRange(CashierTrans.Posted, false);
        CashierTrans.SetRange(CashierTrans.Cashier, UserId);
        if CashierTrans.Count > 10 then begin
            // if CashierTrans."Account No" = '' then begin
            // if Confirm('There are still some Unused Transaction Nos. Continue?', false) = false then begin
            Error('There are more than 10  Unused Transactions. Please utilise them first');
            //   end;
            //  end;
        end;


    end;



    trigger OnModifyRecord(): Boolean
    begin
        /*IF xRec.Posted = TRUE THEN BEGIN
        IF Posted = TRUE THEN
        ERROR('You cannot modify an already posted record.');
        END;*/

    end;

    trigger OnOpenPage()
    begin
        /*IF UsersID.GET(USERID) THEN BEGIN
        IF UsersID.Branch <> '' THEN
        SETRANGE("Transacting Branch",UsersID.Branch);
        END;*/


        if Rec.Posted = true then
            CurrPage.Editable := false;


        FChequeVisible := false;
        BChequeVisible := false;
        BReceiptVisible := false;
        BOSAReceiptChequeVisible := false;
        ChequeTransfVisible := false;
        ChequeWithdrawalVisible := false;
        DepositSlipVisible := false;
        BulkWithVisible := false;
        TransactionTypes.Reset();
        TransactionTypes.SetRange(TransactionTypes.Code, Rec."Transaction Type");
        if TransactionTypes.Find('-') then begin
            VarTransactionType := TransactionTypes.Type;
        end;
        if (VarTransactionType = VarTransactionType::"Cheque Deposit") or (VarTransactionType = VarTransactionType::"Cheque Withdrawal") then begin
            FChequeVisible := true;
            if (Rec."Account No" = '502-00-000300-00') or (Rec."Account No" = '502-00-000303-00') then
                BOSAReceiptChequeVisible := true;

        end;

        "Branch RefferenceVisible" := false;
        LRefVisible := false;


        if VarTransactionType = VarTransactionType::"Bankers Cheque" then
            BChequeVisible := true;

        if VarTransactionType = VarTransactionType::Encashment then
            BReceiptVisible := true;


        if (Rec."Transaction Type" = 'RECEIPT') or (Rec."Transaction Type" = 'FOSALN') then
            BReceiptVisible := true;

        if VarTransactionType = VarTransactionType::Transfer then
            ChequeTransfVisible := true;

        if VarTransactionType = VarTransactionType::"Inhouse Cheque Withdrawal" then begin
            ChequeWithdrawalVisible := true;
        end;

        if VarTransactionType = VarTransactionType::"Deposit Slip" then begin
            DepositSlipVisible := true;
        end;

        if Rec."Branch Transaction" = true then begin
            "Branch RefferenceVisible" := true;
            LRefVisible := true;
        end;

        FnShowFields();

        if ObjAccountType.Get(Rec."Account Type") then begin
            if (Rec.Amount >= ObjAccountType."Bulk Withdrawal Amount") and (Rec.Type = 'Withdrawal') then begin
                BulkWithVisible := true;
            end;
        end;


        VarshowSignatories := false;
        VarShowAgents := false;

        ObjAccountSignatories.Reset;
        ObjAccountSignatories.SetRange(ObjAccountSignatories."Account No", Rec."Account No");
        if ObjAccountSignatories.Find('-') = true then begin
            VarshowSignatories := true;
        end;

        ObjAccountAgent.Reset;
        ObjAccountAgent.SetRange(ObjAccountAgent."Account No", Rec."Account No");
        if ObjAccountAgent.FindSet then begin
            VarShowAgents := true;
        end;


        ExcessFOSAAccountVisible := false;
        if (Rec."Excess Transaction Type" = Rec."excess transaction type"::"Fosa Saving") or (Rec."Excess Transaction Type" = Rec."excess transaction type"::"Junior A/c") then begin
            ExcessFOSAAccountVisible := true;
        end;

    end;

    var
        LoanBalance: Decimal;
        VarTransactionType: Enum FOSATransactionTypesEnum;
        AvailableBalance: Decimal;
        UnClearedBalance: Decimal;
        BankAcc: Record "Bank Account";
        LoanSecurity: Decimal;
        LoanGuaranteed: Decimal;
        GenJournalLine: Record "Gen. Journal Line";
        DefaultBatch: Record "Gen. Journal Batch";
        GLPosting: Codeunit "Gen. Jnl.-Post Line";
        window: Dialog;
        Account: Record Vendor;
        TransactionTypes: Record "Transaction Types";
        TransactionCharges: Record "Transaction Charges";
        TCharges: Decimal;
        LineNo: Integer;
        AccountTypes: Record "Account Types-Saving Products";
        GenLedgerSetup: Record "General Ledger Setup";
        MinAccBal: Decimal;
        FeeBelowMinBal: Decimal;
        AccountNo: Code[30];
        NewAccount: Boolean;
        CurrentTellerAmount: Decimal;
        TellerTill: Record "Bank Account";
        IntervalPenalty: Decimal;
        StandingOrders: Record "Standing Orders";
        AccountAmount: Decimal;
        STODeduction: Decimal;
        Charges: Record Charges;
        "Total Deductions": Decimal;
        STODeductedAmount: Decimal;
        NoticeAmount: Decimal;
        AccountNotices: Record "Account Notices";
        Cust: Record "Members Register";
        AccountHolders: Record Vendor;
        ChargesOnFD: Decimal;
        TotalGuaranted: Decimal;
        VarAmtHolder: Decimal;
        chqtransactions: Record Transactions;
        Trans: Record Transactions;
        TotalUnprocessed: Decimal;
        CustAcc: Record "Members Register";
        AmtAfterWithdrawal: Decimal;
        TransactionsRec: Record Transactions;
        LoansTotal: Decimal;
        Interest: Decimal;
        InterestRate: Decimal;
        OBal: Decimal;
        Principal: Decimal;
        ATMTrans: Decimal;
        ATMBalance: Decimal;
        TotalBal: Decimal;
        DenominationsRec: Record Denominations;
        TillNo: Code[20];
        MPESAACCNO: Code[20];
        FOSASetup: Record "Purchases & Payables Setup";
        Acc: Record Vendor;
        ChequeTypes: Record "Cheque Types";
        ChargeAmount: Decimal;
        TChargeAmount: Decimal;
        DActivity: Code[20];
        DBranch: Code[20];
        UsersID: Record User;
        ChBank: Code[20];
        DValue: Record "Dimension Value";
        ReceiptAllocations: Record "Receipt Allocation";
        Loans: Record "Loans Register";
        Commision: Decimal;
        Cheque: Boolean;
        LOustanding: Decimal;
        TotalCommision: Decimal;
        TotalOustanding: Decimal;
        BOSABank: Code[20];
        InterestPaid: Decimal;
        PaymentAmount: Decimal;
        RunBal: Decimal;
        Recover: Boolean;
        GenSetup: Record "Sacco General Set-Up";
        MailContent: Text[150];
        supervisor: Record "Supervisors Approval Levels";
        TEXT1: label 'YOU HAVE A TRANSACTION AWAITING APPROVAL';
        AccP: Record Vendor;
        LoansR: Record "Loans Register";
        ClearingCharge: Decimal;
        ClearingRate: Decimal;
        [InDataSet]
        FChequeVisible: Boolean;
        [InDataSet]
        BChequeVisible: Boolean;
        [InDataSet]
        BReceiptVisible: Boolean;
        [InDataSet]
        BOSAReceiptChequeVisible: Boolean;
        [InDataSet]
        "Branch RefferenceVisible": Boolean;
        [InDataSet]
        LRefVisible: Boolean;
        ChequeTransfVisible: Boolean;
        [InDataSet]
        "Transaction DateEditable": Boolean;
        Excise: Decimal;
        Echarge: Decimal;
        BankLedger: Record "Bank Account Ledger Entry";
        Vend: Record Vendor;
        ChequeBook: Record "Cheques Register";
        BosaSetUp: Record "Sacco General Set-Up";
        CashierTrans: Record Transactions;
        ChequeWithdrawalVisible: Boolean;
        DepositSlipVisible: Boolean;
        OverDraftCharge: Decimal;
        OverDraftChargeAcc: Code[20];
        ChequeWithOll: Boolean;
        ChequeRegister: Record "Cheque Book Register";
        LoanType: Record "Loan Products Setup";
        GraduatedCharge: Record "CWithdrawal Graduated Charges";
        ExciseDuty: Decimal;
        ShareCapDefecit: Decimal;
        HasSpecialMandateVisible: Boolean;
        TransactingAgentVisible: Boolean;
        TransactingAgentNameVisible: Boolean;
        ObjAccountAgents: Record "Account Agent Details";
        ReceiptAllVisible: Boolean;
        LoanApp: Record "Loans Register";
        Datefilter: Text;
        SURESTEPFactory: Codeunit "Au Factory";
        ObjTransactions: Record "Receipt Allocation";
        BulkWithVisible: Boolean;
        ObjAccountType: Record "Account Types-Saving Products";
        VarMonthlyInt: Decimal;
        ObjProductCharge: Record "Loan Product Charges";
        VarshowSignatories: Boolean;
        VarShowAgents: Boolean;
        ObjAccountSignatories: Record "FOSA Account Sign. Details";
        ObjAccountAgent: Record "Account Agent Details";
        ObjReceiptAllocation: Record "Receipt Allocation";
        ExcessFOSAAccountVisible: Boolean;
        VarNoticeType: Option " ","With Notice","Without Notice";
        ODDetailsVisible: Boolean;
        OpenApprovalEntriesExist: Boolean;
        CanCancelApprovalForRecord: Boolean;
        OpenApprovalEntriesExistForCurrUser: Boolean;
        canSendApproval: Boolean;
        canCreate: Boolean;
        SaccoSetup: Record "Sacco General Set-Up";
        SMSCharges: Decimal;


    procedure CalcAvailableBal()
    begin
        ATMBalance := 0;

        TCharges := 0;
        AvailableBalance := 0;
        MinAccBal := 0;
        TotalUnprocessed := 0;
        IntervalPenalty := 0;
        //+++++++++++++++++++++++++++++Get the transaction type++++++++++++++++++++++++++++
        TransactionTypes.Reset();
        TransactionTypes.SetRange(TransactionTypes.Code, Rec."Transaction Type");
        if TransactionTypes.Find('-') then begin
            VarTransactionType := TransactionTypes.Type;
        end;

        if Account.Get(Rec."Account No") then begin
            Account.CalcFields(Account.Balance, Account."Uncleared Cheques", Account."ATM Transactions");

            AccountTypes.Reset;
            AccountTypes.SetRange(AccountTypes.Code, Rec."Savings Product");
            if AccountTypes.Find('-') then begin
                MinAccBal := AccountTypes."Minimum Balance" + Account."Amount to freeze";//Kitui
                FeeBelowMinBal := AccountTypes."Fee Below Minimum Balance";


                //Check Withdrawal Interval
                if Account.Status <> Account.Status::Deceased then begin
                    if VarTransactionType = VarTransactionType::"Cash Withdrawal" then begin
                        AccountTypes.Reset;
                        AccountTypes.SetRange(AccountTypes.Code, Rec."Savings Product");
                        if Account."Last Withdrawal Date" <> 0D then begin
                            if CalcDate(AccountTypes."Withdrawal Interval", Account."Last Withdrawal Date") > Today then
                                IntervalPenalty := AccountTypes."Withdrawal Penalty";
                        end;
                    end;
                    //Check Withdrawal Interval

                    //Fixed Deposit
                    ChargesOnFD := 0;
                    if AccountTypes."Fixed Deposit" = true then begin
                        if Account."Expected Maturity Date" > Today then
                            ChargesOnFD := AccountTypes."Charge Closure Before Maturity";
                    end;
                    //Fixed Deposit

                    /*
                    //Current Charges
                    TransactionCharges.RESET;
                    TransactionCharges.SETRANGE(TransactionCharges."Transaction Type","Transaction Type");
                    IF TransactionCharges.FIND('-') THEN BEGIN
                    REPEAT
                    IF TransactionCharges."Use Percentage"=TRUE THEN BEGIN
                    TransactionCharges.TESTFIELD("Percentage of Amount");
                    TCharges:=TCharges+(TransactionCharges."Percentage of Amount"/100)*Amount;
                    END ELSE BEGIN
                    TCharges:=TCharges+TransactionCharges."Charge Amount";
                    END;
                    UNTIL TransactionCharges.NEXT=0;
                    END;
                    */

                    TotalUnprocessed := Account."Uncleared Cheques";
                    ATMBalance := Account."ATM Transactions";

                    //FD
                    if AccountTypes."Fixed Deposit" = false then begin
                        if Account.Balance < MinAccBal then
                            AvailableBalance := Account.Balance - FeeBelowMinBal - TCharges - MinAccBal - TotalUnprocessed - ATMBalance -
                                              Account."EFT Transactions" + Account."Cheque Discounted"// IntervalPenalty -
                        else
                            AvailableBalance := Account.Balance - TCharges - MinAccBal - TotalUnprocessed - ATMBalance -
                                              Account."EFT Transactions" + Account."Cheque Discounted";//IntervalPenalty -
                    end else begin
                        AvailableBalance := Account.Balance - TCharges - ChargesOnFD - Account."ATM Transactions" + Account."Cheque Discounted";
                    end;
                end;

                /*MESSAGE('FeeBelowMinBal Is %1',FeeBelowMinBal);
                MESSAGE('TCharges Is %1',TCharges);
                MESSAGE('IntervalPenalty Is %1',IntervalPenalty);
                MESSAGE('MinAccBal Is %1',MinAccBal);
                MESSAGE('TotalUnprocessed Is %1',TotalUnprocessed);
                MESSAGE('ATMBalance Is %1',ATMBalance);
                MESSAGE('EFT Transactions Is %1',Account."EFT Transactions");*/


                //FD

            end;
        end;

        if Rec."N.A.H Balance" <> 0 then
            AvailableBalance := Rec."N.A.H Balance";
        //MESSAGE('Available balance is %1',AvailableBalance);

    end;


    procedure PostChequeDep()
    begin
        //Check teller transaction limits
        TillNo := '';
        TellerTill.Reset;
        TellerTill.SetRange(TellerTill."Account Type", TellerTill."account type"::Cashier);
        TellerTill.SetRange(TellerTill.CashierID, UserId);
        if TellerTill.Find('-') then begin
            TillNo := TellerTill."No.";
            TellerTill.CalcFields(TellerTill.Balance);
            Rec.calcfields(Rec.Types);
            //+++++++++++++++++++++++++++++Get the transaction type++++++++++++++++++++++++++++
            TransactionTypes.Reset();
            TransactionTypes.SetRange(TransactionTypes.Code, Rec."Transaction Type");
            if TransactionTypes.Find('-') then begin
                VarTransactionType := TransactionTypes.Type;
            end;

            if VarTransactionType = VarTransactionType::"Cheque Deposit" then begin
                if Rec.Amount > TellerTill."Max Cheque Deposit Limit" then begin
                    if Rec.Authorised = Rec.Authorised::No then begin
                        Rec."Authorisation Requirement" := 'Cheque Receipt Above teller Limit';
                        Rec.Modify;

                        MailContent := 'The' + ' ' + 'Cashier' + ' ' + Rec.Cashier + ' ' +
                        'cannot Receive a cheque more than allowed ,limit, Maximum limit is' + '' + Format(TellerTill."Max Cheque Deposit Limit") +
                        'you need to authorise';
                        SendEmail;
                        Message('You cannot Receive a cheque more than your allowed limit of %1 unless authorised.', TellerTill."Max Cheque Deposit Limit");

                        exit;
                    end;
                end;
            end;
            DValue.Reset;
            DValue.SetRange(DValue."Global Dimension No.", 2);
            //DValue.SETRANGE(DValue.Code,DBranch);`
            DValue.SetRange(DValue.Code, '01');
            if DValue.Find('-') then begin
                //DValue.TESTFIELD(DValue."Clearing Bank Account");
                ChBank := Rec."Cheque Clearing Bank Code";//DValue."Clearing Bank Account";
            end else
                //ERROR('Branch not set.');
                ChBank := Rec."Bank Account";

            if ChequeTypes.Get(Rec."Cheque Type") then begin
                GenJournalLine.Reset;
                GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
                GenJournalLine.SetRange("Journal Batch Name", 'FTRANS');
                GenJournalLine.DeleteAll;

                LineNo := LineNo + 10000;

                GenJournalLine.Init;
                GenJournalLine."Journal Template Name" := 'GENERAL';
                GenJournalLine."Journal Batch Name" := 'FTRANS';
                GenJournalLine."Document No." := Rec.No;
                GenJournalLine."External Document No." := Rec."Cheque No";
                GenJournalLine."Line No." := LineNo;
                GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                GenJournalLine."Account No." := Rec."Account No";

                GenJournalLine.Validate(GenJournalLine."Account No.");
                GenJournalLine."Posting Date" := Rec."Transaction Date";
                if Rec."Branch Transaction" = true then
                    GenJournalLine.Description := Format(Rec.Types) + '-' + Rec."Branch Refference"
                else
                    //GenJournalLine.Description:="Transaction Description" +'-'+ Description ;
                    GenJournalLine.Description := Format(Rec.Types) + '-' + Rec.Description;
                //Project Accounts
                if Acc.Get(Rec."Account No") then begin
                    // if Acc."Account Category" = Acc."account category"::Project then
                    //     GenJournalLine.Description := Format(Rec.Types) + '-' + Rec."Branch Refference"
                end;
                //Project Accounts
                GenJournalLine.Validate(GenJournalLine."Currency Code");
                GenJournalLine.Amount := -Rec.Amount;
                GenJournalLine.Validate(GenJournalLine.Amount);
                GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                if GenJournalLine.Amount <> 0 then
                    GenJournalLine.Insert;

                LineNo := LineNo + 10000;

                GenJournalLine.Init;
                GenJournalLine."Journal Template Name" := 'GENERAL';
                GenJournalLine."Journal Batch Name" := 'FTRANS';
                GenJournalLine."Document No." := Rec.No;
                GenJournalLine."External Document No." := Rec."Cheque No";
                GenJournalLine."Line No." := LineNo;
                GenJournalLine."Account Type" := GenJournalLine."account type"::"Bank Account";
                GenJournalLine."Account No." := Rec."Cheque Clearing Bank Code";
                GenJournalLine.Validate(GenJournalLine."Account No.");
                GenJournalLine."Posting Date" := Rec."Transaction Date";
                GenJournalLine.Description := 'Cheque Deposit_' + Rec."Cheque No";
                GenJournalLine.Validate(GenJournalLine."Currency Code");
                GenJournalLine.Amount := Rec.Amount;
                GenJournalLine.Validate(GenJournalLine.Amount);
                GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                if GenJournalLine.Amount <> 0 then
                    GenJournalLine.Insert;

                //Post Charges
                ChargeAmount := 0;

                LineNo := LineNo + 10000;
                ClearingCharge := 0;
                GenSetup.Get();

                //MESSAGE('ClearingCharge%1',ClearingCharge);
                GenJournalLine.Init;
                GenJournalLine."Journal Template Name" := 'GENERAL';
                GenJournalLine."Journal Batch Name" := 'FTRANS';
                GenJournalLine."Document No." := Rec.No;
                GenJournalLine."Line No." := LineNo;
                GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                GenJournalLine."Account No." := Rec."Account No";
                GenJournalLine."External Document No." := Rec."ID No";
                GenJournalLine.Validate(GenJournalLine."Account No.");
                GenJournalLine."Posting Date" := Rec."Transaction Date";
                GenJournalLine.Description := 'Clearing Charges';
                GenJournalLine.Validate(GenJournalLine."Currency Code");
                GenJournalLine.Amount := GenSetup."Cheque Deposit Fee";
                GenJournalLine.Validate(GenJournalLine.Amount);
                GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                GenJournalLine."Bal. Account No." := GenSetup."Cheque Deposit Fee Account";
                GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                if GenJournalLine.Amount <> 0 then
                    GenJournalLine.Insert;
                //Post Charges



                //Excise Duty
                GenSetup.Get();

                LineNo := LineNo + 10000;
                GenJournalLine.Init;
                GenJournalLine."Journal Template Name" := 'GENERAL';
                GenJournalLine."Journal Batch Name" := 'FTRANS';
                GenJournalLine."Document No." := Rec.No;
                GenJournalLine."Line No." := LineNo;
                GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                GenJournalLine."Account No." := Rec."Account No";
                GenJournalLine."External Document No." := Rec."ID No";
                GenJournalLine.Validate(GenJournalLine."Account No.");
                GenJournalLine."Posting Date" := Rec."Transaction Date";
                GenJournalLine.Description := 'Excise Duty';
                GenJournalLine.Validate(GenJournalLine."Currency Code");
                GenJournalLine.Amount := ((GenSetup."Cheque Deposit Fee") * GenSetup."Loan Excise Duty(%)") / 100;
                GenJournalLine.Validate(GenJournalLine.Amount);
                GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                GenJournalLine."Bal. Account No." := GenSetup."Excise Duty Account";
                GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                if GenJournalLine.Amount <> 0 then
                    GenJournalLine.Insert;

                //Post New
                GenJournalLine.Reset;
                GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
                GenJournalLine.SetRange("Journal Batch Name", 'FTRANS');
                if GenJournalLine.Find('-') then begin
                    Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco", GenJournalLine);
                end;

                //Post Newvv


                Rec.Posted := true;
                Rec.Authorised := Rec.Authorised::Yes;
                Rec."Supervisor Checked" := true;
                Rec."Needs Approval" := Rec."needs approval"::No;
                Rec."Frequency Needs Approval" := Rec."frequency needs approval"::No;
                Rec."Date Posted" := Today;
                Rec."Time Posted" := Time;
                Rec."Posted By" := UserId;

                if ChequeTypes."Clearing  Days" = 0 then begin
                    Rec.Status := Rec.Status::Honoured;
                    Rec."Cheque Processed" := false;
                    //Rec."Date Cleared" := Today;
                end;
                Rec.Modify;
                TillNo := '';
                TellerTill.Reset;
                TellerTill.SetRange(TellerTill."Account Type", TellerTill."account type"::Cashier);
                TellerTill.SetRange(TellerTill.CashierID, UserId);
                if TellerTill.Find('-') then begin

                    Rec."Bank Used To Post" := TellerTill."No.";

                    rec.Modify();

                end;
            end;


            Message('Cheque deposited successfully.');

            Trans.Reset;
            Trans.SetRange(Trans.No, Rec.No);
            if Trans.Find('-') then begin
                Report.Run(172500, false, true, Trans);
            end;
        end;

        CurrPage.Close;
    end;


    procedure PostDepSlipDep()
    begin
        //+++++++++++++++++++++++++++++Get the transaction type++++++++++++++++++++++++++++
        TransactionTypes.Reset();
        TransactionTypes.SetRange(TransactionTypes.Code, Rec."Transaction Type");
        if TransactionTypes.Find('-') then begin
            VarTransactionType := TransactionTypes.Type;
        end;
        if VarTransactionType = VarTransactionType::"Deposit Slip" then
            DValue.Reset;
        DValue.SetRange(DValue."Global Dimension No.", 2);
        //DValue.SETRANGE(DValue.Code,DBranch);`
        //DValue.SETRANGE(DValue.Code,'NAIROBI');
        if DValue.Find('-') then begin
            //DValue.TESTFIELD(DValue."Clearing Bank Account");
            ChBank := Rec."Cheque Clearing Bank Code";//DValue."Clearing Bank Account";
        end else
            //ERROR('Branch not set.');
            ChBank := Rec."Bank Account";
        Rec.calcfields(Rec.Types);
        //IF ChequeTypes.GET("Cheque Type") THEN BEGIN
        GenJournalLine.Reset;
        GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
        GenJournalLine.SetRange("Journal Batch Name", 'FTRANS');
        GenJournalLine.DeleteAll;

        LineNo := LineNo + 10000;

        GenJournalLine.Init;
        GenJournalLine."Journal Template Name" := 'GENERAL';
        GenJournalLine."Journal Batch Name" := 'FTRANS';
        GenJournalLine."Document No." := Rec.No;
        GenJournalLine."External Document No." := Rec."Cheque No";
        GenJournalLine."Line No." := LineNo;
        GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
        GenJournalLine."Account No." := Rec."Account No";

        GenJournalLine.Validate(GenJournalLine."Account No.");
        GenJournalLine."Posting Date" := Rec."Document Date";
        if Rec."Branch Transaction" = true then
            GenJournalLine.Description := Format(Rec.Types) + '-' + Rec."Branch Refference"
        else
            GenJournalLine.Description := Rec."Transaction Description" + '-' + Rec.Description;
        //Project Accounts
        if Acc.Get(Rec."Account No") then begin
            // if Acc."Account Category" = Acc."account category"::Project then
            //     GenJournalLine.Description := Format(Rec.Types) + '-' + Rec."Branch Refference"
        end;
        //Project Accounts
        GenJournalLine.Validate(GenJournalLine."Currency Code");
        GenJournalLine.Amount := -Rec.Amount;
        GenJournalLine.Validate(GenJournalLine.Amount);
        GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
        GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
        if GenJournalLine.Amount <> 0 then
            GenJournalLine.Insert;

        LineNo := LineNo + 10000;

        GenJournalLine.Init;
        GenJournalLine."Journal Template Name" := 'GENERAL';
        GenJournalLine."Journal Batch Name" := 'FTRANS';
        GenJournalLine."Document No." := Rec.No;
        GenJournalLine."External Document No." := Rec."Cheque No";
        GenJournalLine."Line No." := LineNo;
        GenJournalLine."Account Type" := GenJournalLine."account type"::"Bank Account";
        GenJournalLine."Account No." := Rec."Bank Account";
        GenJournalLine.Validate(GenJournalLine."Account No.");
        GenJournalLine."Posting Date" := Rec."Document Date";
        GenJournalLine.Description := Rec."Account Name";
        GenJournalLine.Validate(GenJournalLine."Currency Code");
        GenJournalLine.Amount := Rec.Amount;
        GenJournalLine.Validate(GenJournalLine.Amount);
        GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
        GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
        if GenJournalLine.Amount <> 0 then
            GenJournalLine.Insert;



        //Post New
        GenJournalLine.Reset;
        GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
        GenJournalLine.SetRange("Journal Batch Name", 'FTRANS');
        if GenJournalLine.Find('-') then begin
            Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco", GenJournalLine);
        end;

        //Post New


        Rec.Posted := true;
        Rec.Authorised := Rec.Authorised::Yes;
        Rec."Supervisor Checked" := true;
        Rec."Needs Approval" := Rec."needs approval"::No;
        Rec."Frequency Needs Approval" := Rec."frequency needs approval"::No;
        Rec."Date Posted" := Today;
        Rec."Time Posted" := Time;
        Rec."Posted By" := UserId;



        Rec.Modify;
        TillNo := '';
        TellerTill.Reset;
        TellerTill.SetRange(TellerTill."Account Type", TellerTill."account type"::Cashier);
        TellerTill.SetRange(TellerTill.CashierID, UserId);
        if TellerTill.Find('-') then begin

            Rec."Bank Used To Post" := TellerTill."No.";

            rec.Modify();

        end;



        Message('Deposit Slip deposited successfully.');

        Trans.Reset;
        Trans.SetRange(Trans.No, Rec.No);
        if Trans.Find('-') then
            Report.Run(172500, false, true, Trans);


        //END;
        CurrPage.Close;

    end;


    procedure PostTransfer()
    begin
        DValue.Reset;
        DValue.SetRange(DValue."Global Dimension No.", 2);
        //DValue.SETRANGE(DValue.Code,DBranch);`
        //DValue.SETRANGE(DValue.Code,'NAIROBI');
        if DValue.Find('-') then begin
            //DValue.TESTFIELD(DValue."Clearing Bank Account");
            ChBank := Rec."Cheque Clearing Bank Code";//DValue."Clearing Bank Account";
        end else
            //ERROR('Branch not set.');
            ChBank := Rec."Bank Account";
        Rec.calcfields(Rec.Types);
        if ChequeTypes.Get(Rec."Cheque Type") then begin
            GenJournalLine.Reset;
            GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
            GenJournalLine.SetRange("Journal Batch Name", 'FTRANS');
            GenJournalLine.DeleteAll;

            LineNo := LineNo + 10000;

            GenJournalLine.Init;
            GenJournalLine."Journal Template Name" := 'GENERAL';
            GenJournalLine."Journal Batch Name" := 'FTRANS';
            GenJournalLine."Document No." := Rec.No;
            GenJournalLine."External Document No." := Rec."Cheque No";
            GenJournalLine."Line No." := LineNo;
            GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
            GenJournalLine."Account No." := Rec."Account No";

            GenJournalLine.Validate(GenJournalLine."Account No.");
            GenJournalLine."Posting Date" := Rec."Transaction Date";
            if Rec."Branch Transaction" = true then
                GenJournalLine.Description := Format(Rec.Types) + '-' + Rec."Branch Refference"
            else
                GenJournalLine.Description := Format(Rec.Types) + '-' + Rec.Description;
            //Project Accounts
            if Acc.Get(Rec."Account No") then begin
                // if Acc."Account Category" = Acc."account category"::Project then
                //     GenJournalLine.Description := Format(Rec.Types) + '-' + Rec."Branch Refference"
            end;
            //Project Accounts
            GenJournalLine.Validate(GenJournalLine."Currency Code");
            GenJournalLine.Amount := -Rec.Amount;
            GenJournalLine.Validate(GenJournalLine.Amount);
            GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
            GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
            if GenJournalLine.Amount <> 0 then
                GenJournalLine.Insert;

            //Debit The drawers Account
            LineNo := LineNo + 10000;
            GenJournalLine.Init;
            GenJournalLine."Journal Template Name" := 'GENERAL';
            GenJournalLine."Journal Batch Name" := 'FTRANS';
            GenJournalLine."Document No." := Rec.No;
            GenJournalLine."External Document No." := Rec."Cheque No";
            GenJournalLine."Line No." := LineNo;
            GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
            GenJournalLine."Account No." := Rec."Drawer's Account No";
            GenJournalLine.Validate(GenJournalLine."Account No.");
            GenJournalLine."Posting Date" := Rec."Transaction Date";
            GenJournalLine.Description := Rec."Account Name";
            GenJournalLine.Validate(GenJournalLine."Currency Code");
            GenJournalLine.Amount := Rec.Amount;
            GenJournalLine.Validate(GenJournalLine.Amount);
            GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
            GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
            if GenJournalLine.Amount <> 0 then
                GenJournalLine.Insert;

            //Post Charges
            ChargeAmount := 0;

            LineNo := LineNo + 10000;
            ClearingCharge := 0;
            if ChequeTypes."Use %" = true then begin
                ClearingCharge := ((ChequeTypes."% Of Amount" * 0.01) * Rec.Amount);
            end else
                ClearingCharge := ChequeTypes."Clearing Charges";
            //MESSAGE('ClearingCharge%1',ClearingCharge);
            GenJournalLine.Init;
            GenJournalLine."Journal Template Name" := 'GENERAL';
            GenJournalLine."Journal Batch Name" := 'FTRANS';
            GenJournalLine."Document No." := Rec.No;
            GenJournalLine."Line No." := LineNo;
            GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
            GenJournalLine."Account No." := Rec."Account No";
            GenJournalLine."External Document No." := Rec."ID No";
            GenJournalLine.Validate(GenJournalLine."Account No.");
            GenJournalLine."Posting Date" := Rec."Transaction Date";
            GenJournalLine.Description := 'Clearing Charges';
            GenJournalLine.Validate(GenJournalLine."Currency Code");
            GenJournalLine.Amount := ClearingCharge;
            GenJournalLine.Validate(GenJournalLine.Amount);
            GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
            GenJournalLine."Bal. Account No." := ChequeTypes."Clearing Charges GL Account";
            GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
            GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
            GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
            if GenJournalLine.Amount <> 0 then
                GenJournalLine.Insert;
            //Post Charges



            //Excise Duty
            GenSetup.Get(0);

            LineNo := LineNo + 10000;
            GenJournalLine.Init;
            GenJournalLine."Journal Template Name" := 'GENERAL';
            GenJournalLine."Journal Batch Name" := 'FTRANS';
            GenJournalLine."Document No." := Rec.No;
            GenJournalLine."Line No." := LineNo;
            GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
            GenJournalLine."Account No." := Rec."Account No";
            GenJournalLine."External Document No." := Rec."ID No";
            GenJournalLine.Validate(GenJournalLine."Account No.");
            GenJournalLine."Posting Date" := Rec."Transaction Date";
            GenJournalLine.Description := 'Excise Duty';
            GenJournalLine.Validate(GenJournalLine."Currency Code");
            GenJournalLine.Amount := (ClearingCharge * GenSetup."Loan Excise Duty(%)") / 100;
            GenJournalLine.Validate(GenJournalLine.Amount);
            GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
            GenJournalLine."Bal. Account No." := GenSetup."Excise Duty Account";
            GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
            GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
            GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
            if GenJournalLine.Amount <> 0 then
                GenJournalLine.Insert;




            //Post New
            GenJournalLine.Reset;
            GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
            GenJournalLine.SetRange("Journal Batch Name", 'FTRANS');
            if GenJournalLine.Find('-') then begin
                Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco", GenJournalLine);
            end;

            //Post New


            Rec.Posted := true;
            Rec.Authorised := Rec.Authorised::Yes;
            Rec."Supervisor Checked" := true;
            Rec."Needs Approval" := Rec."needs approval"::No;
            Rec."Frequency Needs Approval" := Rec."frequency needs approval"::No;
            Rec."Date Posted" := Today;
            Rec."Time Posted" := Time;
            Rec."Posted By" := UserId;

            if ChequeTypes."Clearing  Days" = 0 then begin
                Rec.Status := Rec.Status::Honoured;
                Rec."Cheque Processed" := true;
                Rec."Date Cleared" := Today;
            end;

            Rec.Modify;
            TillNo := '';
            TellerTill.Reset;
            TellerTill.SetRange(TellerTill."Account Type", TellerTill."account type"::Cashier);
            TellerTill.SetRange(TellerTill.CashierID, UserId);
            if TellerTill.Find('-') then begin

                Rec."Bank Used To Post" := TellerTill."No.";

                rec.Modify();

            end;

            //Update Cheque Book
            ChequeBook.Reset;
            ChequeBook.SetRange(ChequeBook."Cheque Book Account No.", Rec."Drawers Member No");
            ChequeBook.SetRange(ChequeBook."Cheque No.", Rec."Drawers Cheque No.");
            if ChequeBook.Find('-') then begin
                ChequeBook.Status := ChequeBook.Status::Paid;
                ChequeBook.Modify;
            end;






            Message('Transfer Posted successfully.');

            Trans.Reset;
            Trans.SetRange(Trans.No, Rec.No);
            if Trans.Find('-') then
                Report.Run(172524, false, true, Trans);


        end;

        CurrPage.Close;
    end;


    procedure PostBankersCheq()
    begin
        //Block Payments
        if Acc.Get(Rec."Account No") then begin
            if Acc.Blocked = Acc.Blocked::Payment then
                Error('This account has been blocked from receiving payments.');
        end;
        //+++++++++++++++++++++++++++++Get the transaction type++++++++++++++++++++++++++++
        TransactionTypes.Reset();
        TransactionTypes.SetRange(TransactionTypes.Code, Rec."Transaction Type");
        if TransactionTypes.Find('-') then begin
            VarTransactionType := TransactionTypes.Type;
        end;


        DValue.Reset;
        DValue.SetRange(DValue."Global Dimension No.", 2);
        DValue.SetRange(DValue.Code, 'Nairobi');
        //DValue.SETRANGE(DValue.Code,DBranch);
        if DValue.Find('-') then begin
            //DValue.TESTFIELD(//DValue."Banker Cheque Account");
            ChBank := Rec."Cheque Clearing Bank Code";
        end else
            Error('Branch not set.');

        CalcAvailableBal;
        Rec.calcfields(Rec.Types);
        //Check withdrawal limits
        if VarTransactionType = VarTransactionType::"Bankers Cheque" then begin
            if AvailableBalance < Rec.Amount then begin
                if Rec.Authorised = Rec.Authorised::Yes then begin
                    Rec.Overdraft := true;
                    Rec.Modify;
                end;

                if Rec.Authorised = Rec.Authorised::No then begin
                    if Rec."Branch Transaction" = false then begin
                        Rec."Authorisation Requirement" := 'Bankers Cheque - Over draft';
                        Rec.Modify;
                        Message('You cannot issue a Bankers cheque more than the available balance unless authorised.');
                        SendEmail;
                        exit;
                    end;
                end;
                if Rec.Authorised = Rec.Authorised::Rejected then
                    Error('Bankers cheque transaction has been rejected and therefore cannot proceed.');
                //SendEmail;
            end;
        end;
        //Check withdrawal limits


        GenJournalLine.Reset;
        GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
        GenJournalLine.SetRange("Journal Batch Name", 'FTRANS');
        GenJournalLine.DeleteAll;

        LineNo := LineNo + 10000;

        GenJournalLine.Init;
        GenJournalLine."Journal Template Name" := 'GENERAL';
        GenJournalLine."Journal Batch Name" := 'FTRANS';
        GenJournalLine."Document No." := Rec.No;
        GenJournalLine."External Document No." := Rec."Bankers Cheque No";
        GenJournalLine."Line No." := LineNo;
        GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
        GenJournalLine."Account No." := Rec."Account No";
        GenJournalLine.Validate(GenJournalLine."Account No.");

        GenJournalLine."Posting Date" := Rec."Transaction Date";
        if Rec."Branch Transaction" = true then
            GenJournalLine.Description := Format(Rec.Types) + '-' + Rec."Branch Refference"
        else
            GenJournalLine.Description := Rec.Description; //"Transaction Description"+'-'+Description ;
        GenJournalLine.Validate(GenJournalLine."Currency Code");
        GenJournalLine.Amount := Rec.Amount;
        GenJournalLine.Validate(GenJournalLine.Amount);
        GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
        GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
        if GenJournalLine.Amount <> 0 then
            GenJournalLine.Insert;

        LineNo := LineNo + 10000;

        GenJournalLine.Init;
        GenJournalLine."Journal Template Name" := 'GENERAL';
        GenJournalLine."Journal Batch Name" := 'FTRANS';
        GenJournalLine."Document No." := Rec.No;
        GenJournalLine."External Document No." := Rec."Bankers Cheque No";
        GenJournalLine."Line No." := LineNo;
        GenJournalLine."Account Type" := GenJournalLine."account type"::"Bank Account";
        GenJournalLine."Account No." := ChBank;
        GenJournalLine.Validate(GenJournalLine."Account No.");
        GenJournalLine."Posting Date" := Rec."Transaction Date";
        GenJournalLine.Description := Rec.Payee;//"Account Name";
        GenJournalLine.Validate(GenJournalLine."Currency Code");
        GenJournalLine.Amount := -Rec.Amount;
        GenJournalLine.Validate(GenJournalLine.Amount);
        GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
        GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
        if GenJournalLine.Amount <> 0 then
            GenJournalLine.Insert;


        //Charges
        TransactionCharges.Reset;
        TransactionCharges.SetRange(TransactionCharges."Transaction Type", Rec."Transaction Type");
        if TransactionCharges.Find('-') then begin
            repeat
                LineNo := LineNo + 10000;

                GenJournalLine.Init;
                GenJournalLine."Journal Template Name" := 'GENERAL';
                GenJournalLine."Journal Batch Name" := 'FTRANS';
                GenJournalLine."Document No." := Rec.No;
                GenJournalLine."External Document No." := Rec."Bankers Cheque No";
                GenJournalLine."Line No." := LineNo;
                GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                GenJournalLine."Account No." := Rec."Account No";
                GenJournalLine.Validate(GenJournalLine."Account No.");
                GenJournalLine."Posting Date" := Rec."Transaction Date";
                GenJournalLine.Description := TransactionCharges.Description;
                GenJournalLine.Validate(GenJournalLine."Currency Code");
                GenJournalLine.Amount := TransactionCharges."Charge Amount";
                GenJournalLine.Validate(GenJournalLine.Amount);
                GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                GenJournalLine."Bal. Account No." := TransactionCharges."G/L Account";
                GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                if GenJournalLine.Amount <> 0 then
                    GenJournalLine.Insert;

                if TransactionCharges."Due Amount" > 0 then begin
                    LineNo := LineNo + 10000;

                    GenJournalLine.Init;
                    GenJournalLine."Journal Template Name" := 'GENERAL';
                    GenJournalLine."Journal Batch Name" := 'FTRANS';
                    GenJournalLine."Document No." := Rec.No;
                    GenJournalLine."External Document No." := Rec."Bankers Cheque No";
                    GenJournalLine."Line No." := LineNo;
                    GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
                    GenJournalLine."Account No." := TransactionCharges."G/L Account";
                    GenJournalLine.Validate(GenJournalLine."Account No.");
                    GenJournalLine."Posting Date" := Rec."Transaction Date";
                    GenJournalLine.Description := TransactionCharges.Description;
                    GenJournalLine.Validate(GenJournalLine."Currency Code");
                    GenJournalLine.Amount := TransactionCharges."Due Amount";
                    GenJournalLine.Validate(GenJournalLine.Amount);
                    GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"Bank Account";
                    GenJournalLine."Bal. Account No." := ChBank;
                    GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                    GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                    GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                    if GenJournalLine.Amount <> 0 then
                        GenJournalLine.Insert;


                end;

            until TransactionCharges.Next = 0;
        end;

        //Charges

        //Excise Duty
        GenSetup.Get(0);

        LineNo := LineNo + 10000;
        GenJournalLine.Init;
        GenJournalLine."Journal Template Name" := 'GENERAL';
        GenJournalLine."Journal Batch Name" := 'FTRANS';
        GenJournalLine."Document No." := Rec.No;
        GenJournalLine."Line No." := LineNo;
        GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
        GenJournalLine."Account No." := Rec."Account No";
        GenJournalLine."External Document No." := Rec."ID No";
        GenJournalLine.Validate(GenJournalLine."Account No.");
        GenJournalLine."Posting Date" := Rec."Transaction Date";
        GenJournalLine.Description := 'Excise Duty';
        GenJournalLine.Validate(GenJournalLine."Currency Code");
        GenJournalLine.Amount := (TransactionCharges."Charge Amount" * GenSetup."Loan Excise Duty(%)") / 100;
        GenJournalLine.Validate(GenJournalLine.Amount);
        GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
        GenJournalLine."Bal. Account No." := GenSetup."Excise Duty Account";
        GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
        GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
        GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
        if GenJournalLine.Amount <> 0 then
            GenJournalLine.Insert;



        //Post New
        GenJournalLine.Reset;
        GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
        GenJournalLine.SetRange("Journal Batch Name", 'FTRANS');
        if GenJournalLine.Find('-') then begin
            Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco", GenJournalLine);
        end;

        //Post New


        Rec."Transaction Available Balance" := AvailableBalance;
        Rec.Posted := true;
        Rec.Authorised := Rec.Authorised::Yes;
        Rec."Supervisor Checked" := true;
        Rec."Needs Approval" := Rec."needs approval"::No;
        Rec."Frequency Needs Approval" := Rec."frequency needs approval"::No;
        Rec."Date Posted" := Today;
        Rec."Time Posted" := Time;
        Rec."Posted By" := UserId;

        Rec.Modify;
        TillNo := '';
        TellerTill.Reset;
        TellerTill.SetRange(TellerTill."Account Type", TellerTill."account type"::Cashier);
        TellerTill.SetRange(TellerTill.CashierID, UserId);
        if TellerTill.Find('-') then begin

            Rec."Bank Used To Post" := TellerTill."No.";

            rec.Modify();

        end;
        /*IF CONFIRM('Are you sure you want to print this bankers cheque?',TRUE)=TRUE THEN BEGIN
        REPORT.RUN(,TRUE,TRUE,Trans)
        END;*/


        Message('Bankers cheque posted successfully.');

        CurrPage.Close;

    end;


    procedure PostEncashment()
    var
        Vend: Record Vendor;
        Member: Record Customer;
        ChargeAmount: Decimal;
        GraduatedCharge: Record "MPESA  Withdrawal";
        GraduatedCharges: Record "Airtime Purchase Charges";
        GraduatedChargeB: Record "External Transfer Charges";
        MpesaComm: Decimal;
        SaccoCommission: Decimal;
        VendorComm: Decimal;
        ExciseDuty: Decimal;
        TotalAmount: Decimal;
        Category: Text;
        VendorCommAccount: Code[20];
        ExciseDutyAccount: Code[20];
        TotalAmountAccount: Code[20];
        SaccoCommissionAccount: Code[20];
        MpesaCommAccount: Code[20];
        SaccoGen: Record "Sacco General Set-Up";
        smsManagement: Codeunit "Sms Management";
        Members: Record Customer;
        CreationMessage: Text[2500];
    begin

        //Block Payments
        if Acc.Get(Rec."Account No") then begin
            if Acc.Blocked = Acc.Blocked::Payment then
                Error('This account has been blocked from receiving payments.');
        end;
        //+++++++++++++++++++++++++++++Get the transaction type++++++++++++++++++++++++++++
        TransactionTypes.Reset();
        TransactionTypes.SetRange(TransactionTypes.Code, Rec."Transaction Type");
        if TransactionTypes.Find('-') then begin
            VarTransactionType := TransactionTypes.Type;
        end;

        CalcAvailableBal;
        Rec.calcfields(Rec.Types);
        //Check withdrawal limits
        if (VarTransactionType = VarTransactionType::Encashment) or (VarTransactionType = VarTransactionType::"Inhouse Cheque Withdrawal") then begin
            if AvailableBalance < Rec.Amount then begin
                if Rec.Authorised = Rec.Authorised::Yes then begin
                    Rec.Overdraft := true;
                    Rec.Modify;
                end;

                if Rec.Authorised = Rec.Authorised::No then begin
                    Rec."Authorisation Requirement" := 'Encashment - Over draft';
                    Rec.Modify;
                    Message('You cannot issue an encashment more than the available balance unless authorised.');
                    MailContent := 'Withdrawal transaction' + 'TR. No.' + ' ' + Rec.No + ' ' + 'of Kshs' + ' ' + Format(Rec.Amount) + ' ' + 'for'
                    + ' ' + Rec."Account Name" + ' ' + 'needs your authorization';
                    SendEmail;

                    //SendEmail;
                    exit;
                end;
                if Rec.Authorised = Rec.Authorised::Rejected then begin
                    MailContent := 'Bankers cheque transaction' + ' ' + 'of Kshs' + ' ' + Format(Rec.Amount) + ' ' + 'for'
                    + ' ' + Rec."Account Name" + ' ' + 'needs your approval';
                    SendEmail;
                    Error('Transaction has been rejected and therefore cannot proceed.');

                end;
            end;
        end;
        //Check withdrawal limits



        //Check Teller Balances
        //ADDED DActivity:='';
        //ADDED DBranch:='';

        TillNo := '';
        TellerTill.Reset;
        TellerTill.SetRange(TellerTill."Account Type", TellerTill."account type"::Cashier);
        TellerTill.SetRange(TellerTill.CashierID, UserId);
        if TellerTill.Find('-') then begin
            //ADDED DActivity:=TellerTill."Global Dimension 1 Code";
            //ADDED DBranch:=TellerTill."Global Dimension 2 Code";
            TillNo := TellerTill."No.";
            TellerTill.CalcFields(TellerTill.Balance);

            CurrentTellerAmount := TellerTill.Balance;

            if CurrentTellerAmount - Rec.Amount <= TellerTill."Min. Balance" then
                Message('You need to add more money from the treasury since your balance has gone below the teller replenishing level.');

            if (VarTransactionType = VarTransactionType::"Cash Withdrawal") or (VarTransactionType = VarTransactionType::Encashment) or (VarTransactionType = VarTransactionType::"Inhouse Cheque Withdrawal") then begin
                if (CurrentTellerAmount - Rec.Amount) < 0 then
                    Error('You do not have enough money to carry out this transaction.');

            end;

            if (VarTransactionType = VarTransactionType::"Cash Withdrawal") or (VarTransactionType = VarTransactionType::Encashment) or (VarTransactionType = VarTransactionType::"Inhouse Cheque Withdrawal") then begin
                if CurrentTellerAmount - Rec.Amount >= TellerTill."Maximum Teller Withholding" then
                    Message('You need to transfer money back to the treasury since your balance has gone above the teller maximum withholding.');

            end else begin
                if CurrentTellerAmount + Rec.Amount >= TellerTill."Maximum Teller Withholding" then
                    Message('You need to transfer money back to the treasury since your balance has gone above the teller maximum withholding.');
            end;


        end;

        if TillNo = '' then
            Error('Teller account not set-up.');

        //Check Teller Balances




        GenJournalLine.Reset;
        GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
        GenJournalLine.SetRange("Journal Batch Name", 'FTRANS');
        GenJournalLine.DeleteAll;

        LineNo := LineNo + 10000;

        GenJournalLine.Init;
        GenJournalLine."Journal Template Name" := 'GENERAL';
        GenJournalLine."Journal Batch Name" := 'FTRANS';
        GenJournalLine."Document No." := Rec.No;
        GenJournalLine."External Document No." := Rec."ID No";
        GenJournalLine."Line No." := LineNo;
        GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
        GenJournalLine."Account No." := Rec."Account No";
        if (Rec."Account No" = '00-0000003000') or (Rec."Account No" = '00-0200003000') then
            GenJournalLine."External Document No." := Rec."ID No";

        GenJournalLine.Validate(GenJournalLine."Account No.");
        GenJournalLine."Posting Date" := Rec."Transaction Date";
        GenJournalLine.Description := Rec.Payee;
        GenJournalLine.Validate(GenJournalLine."Currency Code");
        GenJournalLine.Amount := Rec.Amount;
        GenJournalLine.Validate(GenJournalLine.Amount);
        GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
        GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
        if GenJournalLine.Amount <> 0 then
            GenJournalLine.Insert;


        //Charges
        TCharges := 0;
        //ADDED
        TChargeAmount := 0;


        TransactionCharges.Reset;
        TransactionCharges.SetRange(TransactionCharges."Transaction Type", Rec."Transaction Type");

        if TransactionCharges.Find('-') then begin
            repeat
                LineNo := LineNo + 10000;

                ChargeAmount := 0;
                if TransactionCharges."Use Percentage" = true then begin
                    ChargeAmount := (Rec.Amount * TransactionCharges."Percentage of Amount") * 0.01
                end else
                    ChargeAmount := TransactionCharges."Charge Amount";


                GenJournalLine.Init;
                GenJournalLine."Journal Template Name" := 'GENERAL';
                GenJournalLine."Journal Batch Name" := 'FTRANS';
                GenJournalLine."Document No." := Rec.No;
                GenJournalLine."External Document No." := Rec."ID No";
                GenJournalLine."Line No." := LineNo;
                GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                GenJournalLine."Account No." := Rec."Account No";
                GenJournalLine.Validate(GenJournalLine."Account No.");
                GenJournalLine."Posting Date" := Rec."Transaction Date";
                GenJournalLine.Description := Rec.Payee;
                GenJournalLine.Validate(GenJournalLine."Currency Code");
                GenJournalLine.Amount := ChargeAmount;
                GenJournalLine.Validate(GenJournalLine.Amount);
                GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                GenJournalLine."Bal. Account No." := TransactionCharges."G/L Account";
                GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                if GenJournalLine.Amount <> 0 then
                    GenJournalLine.Insert;

                TChargeAmount := TChargeAmount + ChargeAmount;

            until TransactionCharges.Next = 0;
        end;

        /*
        //Excise
        genSetup.GET();
        
        LineNo:=LineNo+10000;
        
        GenJournalLine.INIT;
        GenJournalLine."Journal Template Name":='GENERAL';
        GenJournalLine."Journal Batch Name":='FTRANS';
        GenJournalLine."Document No.":=No;
        GenJournalLine."External Document No.":="ID No";
        GenJournalLine."Line No.":=LineNo;
        GenJournalLine."Account Type":=GenJournalLine."Account Type"::Vendor;
        GenJournalLine."Account No.":="Account No";
        GenJournalLine.VALIDATE(GenJournalLine."Account No.");
        GenJournalLine."Posting Date":="Transaction Date";
        GenJournalLine.Description:='Excise Duty';
        GenJournalLine.VALIDATE(GenJournalLine."Currency Code");
        GenJournalLine.Amount:=50*GenSetup."Loan Excise Duty(%)";
        GenJournalLine.VALIDATE(GenJournalLine.Amount);
        GenJournalLine."Bal. Account Type":=GenJournalLine."Bal. Account Type"::"G/L Account";
        GenJournalLine."Bal. Account No.":=genSetup."Excise Duty Account";
        GenJournalLine."Shortcut Dimension 1 Code":=DActivity;
        GenJournalLine."Shortcut Dimension 2 Code":=DBranch;
        GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 1 Code");
        GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 2 Code");
        IF GenJournalLine.Amount<>0 THEN
        GenJournalLine.INSERT;
        
        */
        //Charges


        //Teller Entry
        LineNo := LineNo + 10000;

        GenJournalLine.Init;
        GenJournalLine."Journal Template Name" := 'GENERAL';
        GenJournalLine."Journal Batch Name" := 'FTRANS';
        GenJournalLine."Document No." := Rec.No;
        GenJournalLine."External Document No." := Rec."ID No";
        GenJournalLine."Line No." := LineNo;
        GenJournalLine."Account Type" := GenJournalLine."account type"::"Bank Account";
        GenJournalLine."Account No." := TillNo;
        GenJournalLine.Validate(GenJournalLine."Account No.");
        GenJournalLine."Posting Date" := Rec."Transaction Date";
        GenJournalLine.Description := Rec.Payee;
        GenJournalLine.Validate(GenJournalLine."Currency Code");
        GenJournalLine.Amount := -(Rec.Amount);
        GenJournalLine.Validate(GenJournalLine.Amount);
        GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
        GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
        if GenJournalLine.Amount <> 0 then
            GenJournalLine.Insert;


        //Post New
        GenJournalLine.Reset;
        GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
        GenJournalLine.SetRange("Journal Batch Name", 'FTRANS');
        if GenJournalLine.Find('-') then begin
            Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco", GenJournalLine);
        end;

        //Post New


        Rec."Transaction Available Balance" := AvailableBalance;
        Rec.Posted := true;
        Rec.Authorised := Rec.Authorised::Yes;
        Rec."Supervisor Checked" := true;
        Rec."Needs Approval" := Rec."needs approval"::No;
        Rec."Frequency Needs Approval" := Rec."frequency needs approval"::No;
        Rec."Date Posted" := Today;
        Rec."Time Posted" := Time;
        Rec."Posted By" := UserId;

        Rec.Modify;
        TillNo := '';
        TellerTill.Reset;
        TellerTill.SetRange(TellerTill."Account Type", TellerTill."account type"::Cashier);
        TellerTill.SetRange(TellerTill.CashierID, UserId);
        if TellerTill.Find('-') then begin

            Rec."Bank Used To Post" := TellerTill."No.";

            rec.Modify();

        end;

        //Update Cheque Book
        ChequeBook.Reset;
        ChequeBook.SetRange(ChequeBook."Cheque Book Account No.", Rec."Drawers Member No");
        ChequeBook.SetRange(ChequeBook."Cheque No.", Rec."Drawers Cheque No.");
        if ChequeBook.Find('-') then begin
            ChequeBook.Status := ChequeBook.Status::Paid;
            ChequeBook.Modify;
        end;

        Message('Transaction Successful.');

        Trans.Reset;
        Trans.SetRange(Trans.No, Rec.No);
        if Trans.Find('-') then
            if Rec.Type = 'Inhouse Cheque Withdrawal ' then
                Report.Run(172527, false, true, Trans);

        CurrPage.Close;

    end;

    procedure PostMpesawithdrawal()
    var
        Vend: Record Vendor;
        Member: Record Customer;
        ChargeAmount: Decimal;
        GraduatedCharge: Record "MPESA  Withdrawal Bands";
        GraduatedCharges: Record "Airtime Purchase Charges";
        GraduatedChargeB: Record "External Transfer Charges";
        MpesaComm: Decimal;
        SaccoCommission: Decimal;
        VendorComm: Decimal;
        ExciseDuty: Decimal;
        TotalAmount: Decimal;
        Category: Text;
        VendorCommAccount: Code[20];
        ExciseDutyAccount: Code[20];
        TotalAmountAccount: Code[20];
        SaccoCommissionAccount: Code[20];
        MpesaCommAccount: Code[20];
        SaccoGen: Record "Sacco General Set-Up";
        smsManagement: Codeunit "Sms Management";
        Members: Record Customer;
        CreationMessage: Text[2500];
        NetAmount: Decimal;
        Sfactory: Codeunit "SURESTEP FactoryMobile";
        BATCH_TEMPLATE: Code[100];
        BATCH_NAME: Code[100];
        DOCUMENT_NO: Code[100];
        AvailableBalance: Decimal;
        Vendor: Record Vendor;
        MBuffer: Record "Mpesa Withdawal Buffer";
        PendingAmount: Decimal;
    begin

        TillNo := '';
        TellerTill.Reset;
        TellerTill.SetRange(TellerTill."Account Type", TellerTill."account type"::Cashier);
        TellerTill.SetRange(TellerTill.CashierID, UserId);
        if TellerTill.Find('-') then begin
            CalcAvailableBal();
            TillNo := TellerTill."No.";
            MPESAACCNO := TellerTill."MPESA Account";
            GenJournalLine.Reset;
            GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
            GenJournalLine.SetRange("Journal Batch Name", 'FTRANS');
            GenJournalLine.DeleteAll;
            GraduatedCharge.Reset;
            if GraduatedCharge.Find('-') then begin
                repeat
                    if (Rec.Amount >= GraduatedCharge."Min Band") and (Rec.Amount <= GraduatedCharge."Upper Band") then begin
                        VendorComm := 0;
                        ChargeAmount := 0;
                        ExciseDuty := 0;
                        MpesaComm := 0;
                        TotalAmount := 0;
                        ChargeAmount := GraduatedCharge.Total;
                        VendorComm := GraduatedCharge."Vendor Comm";
                        SaccoCommission := GraduatedCharge."Sacco Comm";
                        MpesaComm := GraduatedCharge.Mpesa;
                        ExciseDuty := GraduatedCharge."Excise Duty";
                        TotalAmount := GraduatedCharge.Total;
                        MpesaCommAccount := GraduatedCharge."Mpesa Account";
                        VendorCommAccount := GraduatedCharge."Vendor Comm G/L";
                        SaccoCommissionAccount := GraduatedCharge."Sacco Comm G/L";
                    end;
                until GraduatedCharge.Next = 0;
            end;
            NetAmount := 0;
            Vendor.get(Rec."Account No");
            Vendor.CalcFields(Vendor.Balance);
            MBuffer.Reset();
            MBuffer.SetRange(MBuffer."Vendor No", Rec."Account No");
            MBuffer.SetRange(MBuffer.Posted, false);
            MBuffer.SetRange(MBuffer.Reversed, false);
            if MBuffer.FindSet() then begin
                MBuffer.CalcSums(MBuffer."Amount Requested");
                PendingAmount := MBuffer."Amount Requested";
            end;
            AvailableBalance := 0;
            AvailableBalance := Vendor.Balance - ((Vendor."Uncleared Cheques" - Vendor."Cheque Discounted Amount") + PendingAmount + Vendor."ATM Transactions" + Vendor."EFT Transactions" + 1000 + Vendor."Mobile Transactions" + Vendor."Amount to freeze");
            if (TotalAmount + Rec.Amount) > AvailableBalance then begin
                  if Rec.Authorised = Rec.Authorised::No then begin
                    if Rec."Branch Transaction" = false then begin
                        Rec."Authorisation Requirement" := 'Over draft';
                        Rec.Modify;
                        MailContent := 'Withdrawal transaction' + 'TR. No.' + ' ' + Rec.No + ' ' + 'of Kshs' + ' ' + Format(Rec.Amount) + ' ' + 'for'
                        + ' ' + Rec."Account Name" + ' ' + 'needs your approval';
                        SendEmail;
                        Message('You cannot withdraw more than the available balance unless authorised.');

                        exit;
                    end;
                    if Rec.Authorised = Rec.Authorised::Rejected then
                        Error('Transaction has been rejected and therefore cannot proceed.');

                end;
            end;
            Rec.calcfields(Rec.Types);
            LineNo := LineNo + 10000;

            GenJournalLine.Init;
            GenJournalLine."Journal Template Name" := 'GENERAL';
            GenJournalLine."Journal Batch Name" := 'FTRANS';
            GenJournalLine."Document No." := Rec.No;
            GenJournalLine."External Document No." := Rec."Transaction ID";
            GenJournalLine."Line No." := LineNo;
            GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
            GenJournalLine."Account No." := Rec."Account No";
            GenJournalLine.Validate(GenJournalLine."Account No.");
            GenJournalLine."Posting Date" := Rec."Document Date";
            GenJournalLine."Posting Date" := Today;
            GenJournalLine.Description := 'MPESA Cash Withdrawal - ' + Rec."Member Name";
            GenJournalLine.Validate(GenJournalLine."Currency Code");
            GenJournalLine.Amount := Rec.Amount;
           // GenJournalLine."Bal. Account Type" := GenJournalLine."Bal. Account Type"::"Bank Account";
            //GenJournalLine."Bal. Account No." := Rec."Bank Account";
            GenJournalLine.Validate(GenJournalLine.Amount);
            if GenJournalLine.Amount <> 0 then
                GenJournalLine.Insert;
            LineNo := LineNo + 10000;

            GenJournalLine.Init;
            GenJournalLine."Journal Template Name" := 'GENERAL';
            GenJournalLine."Journal Batch Name" := 'FTRANS';
            GenJournalLine."Document No." := Rec.No;
            GenJournalLine."External Document No." := Rec."Transaction ID";
            GenJournalLine."Line No." := LineNo;
            GenJournalLine."Account Type" := GenJournalLine."account type"::"Bank Account";
            GenJournalLine."Account No." := 'BNK00013';
            GenJournalLine.Validate(GenJournalLine."Account No.");
            GenJournalLine."Posting Date" := Rec."Document Date";
            GenJournalLine."Posting Date" := Today;
            GenJournalLine.Description := 'MPESA Cash Withdrawal - ' + Rec."Member Name";
            GenJournalLine.Validate(GenJournalLine."Currency Code");
            GenJournalLine.Amount := -Rec.Amount;
            GenJournalLine.Validate(GenJournalLine.Amount);
            if GenJournalLine.Amount <> 0 then
                GenJournalLine.Insert;

            BATCH_TEMPLATE := 'GENERAL';
            BATCH_NAME := 'FTRANS';
            DOCUMENT_NO := Rec.No;


            LineNo := LineNo + 10000;
            SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
            GenJournalLine."Account Type"::Vendor, Rec."Account No", Today, TotalAmount, 'FOSA', DOCUMENT_NO,
             'Transaction charges' + ' ' + Vend."No.", '');//


            LineNo := LineNo + 10000;
            SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
            GenJournalLine."Account Type"::"G/L Account", SaccoCommissionAccount, Today, SaccoCommission * -1, 'FOSA', DOCUMENT_NO,
             'Sacco Commission ' + ' ' + Vend."No.", '');

            LineNo := LineNo + 10000;
            SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
            GenJournalLine."Account Type"::"Bank Account", 'BNK00013', Today, MpesaComm * -1, 'FOSA', DOCUMENT_NO,
             'Mobile Trans Mpesa Comm' + ' ' + Vend."No.", '');

            SaccoGen.Get();
            LineNo := LineNo + 10000;
            SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
            GenJournalLine."Account Type"::"G/L Account", SaccoGen."Excise Duty Account", Today, ExciseDuty * -1, 'FOSA', DOCUMENT_NO,
             'Excise Duty Sacco Comm' + ' ' + Vend."No.", '');

            //Post New
            GenJournalLine.Reset;
            GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
            GenJournalLine.SetRange("Journal Batch Name", 'FTRANS');
            if GenJournalLine.Find('-') then begin
                Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco", GenJournalLine);
            end;
            Message('Transaction Posted Successfully!');



            Rec.Posted := true;

            Rec."Date Posted" := Today;
            Rec."Time Posted" := Time;
            Rec."Posted By" := UserId; 



            /* Trans.Reset;
            Trans.SetRange(Trans.No, Rec.No);
            if Trans.Find('-') then begin
                Report.Run(172516, false, true, Trans);
                // REPORT.RUN(172486,FALSE,TRUE,Trans);
            end; */
            Rec.Modify;
            TillNo := '';
            TellerTill.Reset;
            TellerTill.SetRange(TellerTill."Account Type", TellerTill."account type"::Cashier);
            TellerTill.SetRange(TellerTill.CashierID, UserId);
            if TellerTill.Find('-') then begin

                Rec."Bank Used To Post" := TellerTill."No.";

                //  rec.Modify();

            end;

            CurrPage.Close;
        end;
    end;

    procedure PostMpesaDeposit()
    begin
        TillNo := '';
        TellerTill.Reset;
        TellerTill.SetRange(TellerTill."Account Type", TellerTill."account type"::Cashier);
        TellerTill.SetRange(TellerTill.CashierID, UserId);
        if TellerTill.Find('-') then begin
            TillNo := TellerTill."No.";
            MPESAACCNO := TellerTill."MPESA Account";
            GenJournalLine.Reset;
            GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
            GenJournalLine.SetRange("Journal Batch Name", 'FTRANS');
            GenJournalLine.DeleteAll;

            Rec.calcfields(Rec.Types);
            LineNo := LineNo + 10000;

            GenJournalLine.Init;
            GenJournalLine."Journal Template Name" := 'GENERAL';
            GenJournalLine."Journal Batch Name" := 'FTRANS';
            GenJournalLine."Document No." := Rec.No;
            GenJournalLine."External Document No." := Rec."Transaction ID";
            GenJournalLine."Line No." := LineNo;
            GenJournalLine."Account Type" := GenJournalLine."account type"::"Bank Account";
            GenJournalLine."Account No." := MPESAACCNO;
            GenJournalLine.Validate(GenJournalLine."Account No.");
            GenJournalLine."Posting Date" := Rec."Document Date";
            GenJournalLine.Description := 'MpesaCash Deposit ' + Rec."Member Name";
            GenJournalLine.Validate(GenJournalLine."Currency Code");
            GenJournalLine.Amount := -Rec.Amount;
            GenJournalLine.Validate(GenJournalLine.Amount);
            if GenJournalLine.Amount <> 0 then
                GenJournalLine.Insert;
            LineNo := LineNo + 10000;

            GenJournalLine.Init;
            GenJournalLine."Journal Template Name" := 'GENERAL';
            GenJournalLine."Journal Batch Name" := 'FTRANS';
            GenJournalLine."Document No." := Rec.No;
            GenJournalLine."External Document No." := Rec."Transaction ID";
            GenJournalLine."Line No." := LineNo;
            GenJournalLine."Account Type" := GenJournalLine."account type"::"Bank Account";
            GenJournalLine."Account No." := TillNo;
            GenJournalLine.Validate(GenJournalLine."Account No.");
            GenJournalLine."Posting Date" := Rec."Document Date";
            GenJournalLine.Description := 'MpesaCash Deposit ' + Rec."Member Name";
            GenJournalLine.Validate(GenJournalLine."Currency Code");
            GenJournalLine.Amount := Rec.Amount;
            GenJournalLine.Validate(GenJournalLine.Amount);
            if GenJournalLine.Amount <> 0 then
                GenJournalLine.Insert;



            //Post New
            GenJournalLine.Reset;
            GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
            GenJournalLine.SetRange("Journal Batch Name", 'FTRANS');
            if GenJournalLine.Find('-') then begin
                Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco", GenJournalLine);
            end;
            Message('Transaction Posted Successfully!');
            //Post New


            Rec.Posted := true;

            Rec."Date Posted" := Today;
            Rec."Time Posted" := Time;
            Rec."Posted By" := UserId;



            /* Trans.Reset;
            Trans.SetRange(Trans.No, Rec.No);
            if Trans.Find('-') then begin
                Report.Run(172516, false, true, Trans);
                // REPORT.RUN(172486,FALSE,TRUE,Trans);
            end; */
            Rec.Modify;
            TillNo := '';
            TellerTill.Reset;
            TellerTill.SetRange(TellerTill."Account Type", TellerTill."account type"::Cashier);
            TellerTill.SetRange(TellerTill.CashierID, UserId);
            if TellerTill.Find('-') then begin

                Rec."Bank Used To Post" := TellerTill."No.";

                rec.Modify();

            end;

            CurrPage.Close;
        end;
    end;




    //POS

    procedure PostPOSwithdrawal()
    begin
        TillNo := '';
        TellerTill.Reset;
        TellerTill.SetRange(TellerTill."Account Type", TellerTill."account type"::Cashier);
        TellerTill.SetRange(TellerTill.CashierID, UserId);
        if TellerTill.Find('-') then begin
            TillNo := TellerTill."No.";
            MPESAACCNO := TellerTill."POS Account";
            GenJournalLine.Reset;
            GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
            GenJournalLine.SetRange("Journal Batch Name", 'FTRANS');
            GenJournalLine.DeleteAll;
            Rec.calcfields(Rec.Types);

            LineNo := LineNo + 10000;

            GenJournalLine.Init;
            GenJournalLine."Journal Template Name" := 'GENERAL';
            GenJournalLine."Journal Batch Name" := 'FTRANS';
            GenJournalLine."Document No." := Rec.No;
            GenJournalLine."External Document No." := Rec."Transaction ID";
            GenJournalLine."Line No." := LineNo;
            GenJournalLine."Account Type" := GenJournalLine."account type"::"Bank Account";
            GenJournalLine."Account No." := MPESAACCNO;
            GenJournalLine.Validate(GenJournalLine."Account No.");
            GenJournalLine."Posting Date" := Rec."Document Date";
            GenJournalLine.Description := 'POS Withdrawal ' + Rec."Member Name";
            GenJournalLine.Validate(GenJournalLine."Currency Code");
            GenJournalLine.Amount := Rec.Amount;
            GenJournalLine.Validate(GenJournalLine.Amount);
            if GenJournalLine.Amount <> 0 then
                GenJournalLine.Insert;
            LineNo := LineNo + 10000;

            GenJournalLine.Init;
            GenJournalLine."Journal Template Name" := 'GENERAL';
            GenJournalLine."Journal Batch Name" := 'FTRANS';
            GenJournalLine."Document No." := Rec.No;
            GenJournalLine."External Document No." := Rec."Transaction ID";
            GenJournalLine."Line No." := LineNo;
            GenJournalLine."Account Type" := GenJournalLine."account type"::"Bank Account";
            GenJournalLine."Account No." := TillNo;
            GenJournalLine.Validate(GenJournalLine."Account No.");
            GenJournalLine."Posting Date" := Rec."Document Date";
            GenJournalLine.Description := 'POS Withdrawal ' + Rec."Member Name";
            GenJournalLine.Validate(GenJournalLine."Currency Code");
            GenJournalLine.Amount := -Rec.Amount;
            GenJournalLine.Validate(GenJournalLine.Amount);
            if GenJournalLine.Amount <> 0 then
                GenJournalLine.Insert;



            //Post New
            GenJournalLine.Reset;
            GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
            GenJournalLine.SetRange("Journal Batch Name", 'FTRANS');
            if GenJournalLine.Find('-') then begin
                Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco", GenJournalLine);
            end;
            Message('Transaction Posted Successfully!');
            //Post New


            Rec.Posted := true;

            Rec."Date Posted" := Today;
            Rec."Time Posted" := Time;
            Rec."Posted By" := UserId;



            /* Trans.Reset;
            Trans.SetRange(Trans.No, Rec.No);
            if Trans.Find('-') then begin
                Report.Run(172516, false, true, Trans);
                // REPORT.RUN(172486,FALSE,TRUE,Trans);
            end; */
            Rec.Modify;
            TillNo := '';
            TellerTill.Reset;
            TellerTill.SetRange(TellerTill."Account Type", TellerTill."account type"::Cashier);
            TellerTill.SetRange(TellerTill.CashierID, UserId);
            if TellerTill.Find('-') then begin

                Rec."Bank Used To Post" := TellerTill."No.";

                rec.Modify();

            end;

            CurrPage.Close;
        end;
    end;

    procedure PostPOSDeposit()
    begin
        TillNo := '';
        TellerTill.Reset;
        TellerTill.SetRange(TellerTill."Account Type", TellerTill."account type"::Cashier);
        TellerTill.SetRange(TellerTill.CashierID, UserId);
        if TellerTill.Find('-') then begin
            TillNo := TellerTill."No.";
            MPESAACCNO := TellerTill."POS Account";
            GenJournalLine.Reset;
            GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
            GenJournalLine.SetRange("Journal Batch Name", 'FTRANS');
            GenJournalLine.DeleteAll;
            Rec.calcfields(Rec.Types);

            LineNo := LineNo + 10000;

            GenJournalLine.Init;
            GenJournalLine."Journal Template Name" := 'GENERAL';
            GenJournalLine."Journal Batch Name" := 'FTRANS';
            GenJournalLine."Document No." := Rec.No;
            GenJournalLine."External Document No." := Rec."Transaction ID";
            GenJournalLine."Line No." := LineNo;
            GenJournalLine."Account Type" := GenJournalLine."account type"::"Bank Account";
            GenJournalLine."Account No." := MPESAACCNO;
            GenJournalLine.Validate(GenJournalLine."Account No.");
            GenJournalLine."Posting Date" := Rec."Document Date";
            GenJournalLine.Description := 'POS Cash Deposit ' + Rec."Member Name";
            GenJournalLine.Validate(GenJournalLine."Currency Code");
            GenJournalLine.Amount := -Rec.Amount;
            GenJournalLine.Validate(GenJournalLine.Amount);
            if GenJournalLine.Amount <> 0 then
                GenJournalLine.Insert;
            LineNo := LineNo + 10000;

            GenJournalLine.Init;
            GenJournalLine."Journal Template Name" := 'GENERAL';
            GenJournalLine."Journal Batch Name" := 'FTRANS';
            GenJournalLine."Document No." := Rec.No;
            GenJournalLine."External Document No." := Rec."Transaction ID";
            GenJournalLine."Line No." := LineNo;
            GenJournalLine."Account Type" := GenJournalLine."account type"::"Bank Account";
            GenJournalLine."Account No." := TillNo;
            GenJournalLine.Validate(GenJournalLine."Account No.");
            GenJournalLine."Posting Date" := Rec."Document Date";
            GenJournalLine.Description := 'POS Cash Deposit ' + Rec."Member Name";
            GenJournalLine.Validate(GenJournalLine."Currency Code");
            GenJournalLine.Amount := Rec.Amount;
            GenJournalLine.Validate(GenJournalLine.Amount);
            if GenJournalLine.Amount <> 0 then
                GenJournalLine.Insert;



            //Post New
            GenJournalLine.Reset;
            GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
            GenJournalLine.SetRange("Journal Batch Name", 'FTRANS');
            if GenJournalLine.Find('-') then begin
                Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco", GenJournalLine);
            end;
            Message('Transaction Posted Successfully!');
            //Post New


            Rec.Posted := true;

            Rec."Date Posted" := Today;
            Rec."Time Posted" := Time;
            Rec."Posted By" := UserId;



            /* Trans.Reset;
            Trans.SetRange(Trans.No, Rec.No);
            if Trans.Find('-') then begin
                Report.Run(172516, false, true, Trans);
                // REPORT.RUN(172486,FALSE,TRUE,Trans);
            end; */
            Rec.Modify;
            TillNo := '';
            TellerTill.Reset;
            TellerTill.SetRange(TellerTill."Account Type", TellerTill."account type"::Cashier);
            TellerTill.SetRange(TellerTill.CashierID, UserId);
            if TellerTill.Find('-') then begin

                Rec."Bank Used To Post" := TellerTill."No.";

                rec.Modify();

            end;

            CurrPage.Close;
        end;
    end;


    //End POS

    procedure PostCashDepWith()
    begin
        CalcAvailableBal;
        //+++++++++++++++++++++++++++++Get the transaction type++++++++++++++++++++++++++++
        TransactionTypes.Reset();
        TransactionTypes.SetRange(TransactionTypes.Code, Rec."Transaction Type");
        if TransactionTypes.Find('-') then begin
            VarTransactionType := TransactionTypes.Type;
        end;
        //Check withdrawal limits - Available Bal
        if VarTransactionType = VarTransactionType::"Cash Withdrawal" then begin
            //Block Payments
            if Acc.Get(Rec."Account No") then begin
                if Acc.Blocked = Acc.Blocked::Payment then
                    Error('This account has been blocked from receiving payments.');
            end;
            Rec.calcfields(Rec.Types);
            if AvailableBalance < Rec.Amount then begin
                if Rec.Authorised = Rec.Authorised::Yes then begin
                    Rec.Overdraft := true;
                    Rec.Modify;
                end;
                if (Rec."Account Type" <> '103') and (VarTransactionType = VarTransactionType::"Cash Withdrawal") then Error('You can only withdraw on Ordinary accounts.');
                if Rec.Authorised = Rec.Authorised::No then begin
                    if Rec."Branch Transaction" = false then begin
                        Rec."Authorisation Requirement" := 'Over draft';
                        Rec.Modify;
                        MailContent := 'Withdrawal transaction' + 'TR. No.' + ' ' + Rec.No + ' ' + 'of Kshs' + ' ' + Format(Rec.Amount) + ' ' + 'for'
                        + ' ' + Rec."Account Name" + ' ' + 'needs your approval';
                        SendEmail;
                        Message('You cannot withdraw more than the available balance unless authorised.');

                        exit;
                    end;
                    if Rec.Authorised = Rec.Authorised::Rejected then
                        Error('Transaction has been rejected and therefore cannot proceed.');

                end;
            end;
        end;
        //Check withdrawal limits - Available Bal



        //Check Teller Balances
        //ADDED DActivity:='';
        //ADDED DBranch:='';
        Rec.calcfields(Rec.Types);
        TillNo := '';
        TellerTill.Reset;
        TellerTill.SetRange(TellerTill."Account Type", TellerTill."account type"::Cashier);
        TellerTill.SetRange(TellerTill.CashierID, UserId);
        if TellerTill.Find('-') then begin
            TillNo := TellerTill."No.";
            TellerTill.CalcFields(TellerTill.Balance);

            CurrentTellerAmount := TellerTill.Balance;
            if rec.Types = Rec.Types::"Cash Withdrawal" then begin
                if CurrentTellerAmount - Rec.Amount <= TellerTill."Min. Balance" then
                    Message('You need to add more money from the treasury since your balance has gone below the teller replenishing level.');
            end;
            if (Rec."Transaction Type" = 'Withdrawal') or (Rec."Transaction Type" = 'Encashment') then begin
                if (CurrentTellerAmount - Rec.Amount) < 0 then
                    Error('You do not have enough money to carry out this transaction.');
                exit;
            end;
            //MESSAGE('CurrentTellerAmount %1',CurrentTellerAmount);
            if (VarTransactionType = VarTransactionType::"Cash Withdrawal") or (VarTransactionType = VarTransactionType::Encashment) then begin
                if CurrentTellerAmount - Rec.Amount >= TellerTill."Maximum Teller Withholding" then
                    Message('You need to transfer money back to the treasury since your balance has gone above the teller maximum withholding.');

            end else begin
                if CurrentTellerAmount + Rec.Amount >= TellerTill."Maximum Teller Withholding" then
                    Message('You need to transfer money back to the treasury since your balance has gone above the teller maximum withholding.');
            end;

            //Check teller transaction limits
            //cash withdwal
            if (VarTransactionType = VarTransactionType::"Cash Withdrawal") then begin
                if Rec.Amount > TellerTill."Max Withdrawal Limit" then begin
                    if Rec.Authorised = Rec.Authorised::No then begin
                        Rec."Authorisation Requirement" := 'Withdrawal Above teller Limit';
                        Rec.Modify;

                        MailContent := 'The' + ' ' + 'Cashier' + ' ' + Rec.Cashier + ' ' +
                        'cannot withdraw more than allowed ,limit, Maximum limit is' + '' + Format(TellerTill."Max Withdrawal Limit") +
                        'you need to authorise';
                        SendEmail;
                        Message('You cannot withdraw more than your allowed limit of %1 unless authorised.', TellerTill."Max Withdrawal Limit");

                        exit;
                    end;

                    if Rec.Authorised = Rec.Authorised::Rejected then
                        Error('Transaction has been rejected and therefore cannot proceed.');

                end;
            end;


            //Prevent teller from Overdrawing Till

            if VarTransactionType = VarTransactionType::"Cash Withdrawal" then begin
                TellerTill.CalcFields(TellerTill.Balance);
                if Rec.Amount > TellerTill.Balance then begin
                    Error('you cannot transact below your Till balance.');
                end;
            end;

            //Prevent teller from Overdrawing Till



            if VarTransactionType = VarTransactionType::"Cash Deposit" then begin
                if Rec.Amount > TellerTill."Max Deposit Limit" then begin
                    if Rec.Authorised = Rec.Authorised::No then begin
                        Rec."Authorisation Requirement" := 'Deposit above teller Limit';
                        Rec.Modify;
                        MailContent := 'The' + ' ' + 'Cashier' + ' ' + Rec.Cashier + ' ' +
                        'cannot deposit more than allowed limit, Maximum limit is' + '' + Format(TellerTill."Max Deposit Limit") + 'you need to authorise';
                        SendEmail;
                        Message('You cannot deposit more than your allowed limit of %1 unless authorised.', TellerTill."Max Deposit Limit");
                        exit;
                    end;
                    if Rec.Authorised = Rec.Authorised::Rejected then
                        //SendEmail;
                        Error('Transaction has been rejected therefore you cannot proceed.');

                end;
            end;

            //Check teller transaction limits
        end;



        if TillNo = '' then
            Error('Teller account not set-up.');

        //Check Teller Balances


        GenJournalLine.Reset;
        GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
        GenJournalLine.SetRange("Journal Batch Name", 'FTRANS');
        GenJournalLine.DeleteAll;

        LineNo := LineNo + 10000;

        GenJournalLine.Init;
        GenJournalLine."Journal Template Name" := 'GENERAL';
        GenJournalLine."Journal Batch Name" := 'FTRANS';
        GenJournalLine."Line No." := LineNo;
        GenJournalLine."Document No." := Rec.No;
        if (Rec."Transaction Type" = 'CASHWITH') or (Rec."Transaction Type" = 'Encashment') then
            GenJournalLine."External Document No." := Account."ID No."; // "ID No"; //"BOSA Account No";
        GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
        GenJournalLine."Account No." := Rec."Account No";
        if Rec."Account No" = '00-0000000000' then
            GenJournalLine."External Document No." := Account."ID No."; //"ID No";
        GenJournalLine.Validate(GenJournalLine."Account No.");
        GenJournalLine."Posting Date" := Rec."Transaction Date";
        if (Rec."Transaction Type" = 'BOSA') or (Rec."Transaction Type" = 'Encashment') then
            GenJournalLine.Description := Format(Rec.Types) + Rec.Payee
        else begin
            if Rec."Branch Transaction" = true then
                GenJournalLine.Description := Format(Rec.Types) + '-' + Rec."Branch Refference"
            else
                GenJournalLine.Description := Format(Rec.Types) + '-' + Rec.Description;
        end;
        //Project Accounts
        if Acc.Get(Rec."Account No") then begin
            // if Acc."Account Category" = Acc."account category"::Project then
            //     GenJournalLine.Description := Format(Rec.Types) + '-' + Rec."Branch Refference"
        end;
        //Project Accounts

        GenJournalLine.Validate(GenJournalLine."Currency Code");
        if (VarTransactionType = VarTransactionType::"Cash Deposit") or (Rec.Type = 'BOSA Receipt') then
            GenJournalLine.Amount := -Rec.Amount
        else
            GenJournalLine.Amount := Rec.Amount;
        GenJournalLine.Validate(GenJournalLine.Amount);
        GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"Bank Account";
        GenJournalLine."Bal. Account No." := TillNo;
        GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
        GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
        GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
        //  GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
        // GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
        if GenJournalLine.Amount <> 0 then
            GenJournalLine.Insert;

        if (Acc."Mobile Phone No" <> '') then begin
            //Sms.SendSms('Withrawal',Acc."Mobile Phone No",'You have made a cash withdrawal of '+FORMAT(Amount) +'. Waumini SACCO',Acc."No.");

        end;

        //Charges
        TCharges := 0;

        //Charges
        TCharges := 0;
        if Account.Get(Rec."Account No") then begin
            if Account."Staff Account" <> true then begin

                if Rec."Use Graduated Charges" = false then begin
                    TransactionCharges.Reset;
                    TransactionCharges.SetRange(TransactionCharges."Transaction Type", Rec."Transaction Type");
                    if TransactionCharges.Find('-') then begin
                        repeat

                            LineNo := LineNo + 10000;

                            ChargeAmount := 0;
                            if Account.Get(Rec."Account No") then begin
                                if Account."Staff Account" = false then begin
                                    Echarge := ChargeAmount;
                                    GenJournalLine.Init;
                                    GenJournalLine."Journal Template Name" := 'GENERAL';
                                    GenJournalLine."Journal Batch Name" := 'FTRANS';
                                    GenJournalLine."Document No." := Rec.No;
                                    GenJournalLine."Line No." := LineNo;
                                    GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                                    GenJournalLine."Account No." := Rec."Account No";
                                    if Rec."Account No" = '00-0000000000' then
                                        GenJournalLine."External Document No." := Rec."ID No";
                                    GenJournalLine.Validate(GenJournalLine."Account No.");
                                    GenJournalLine."Posting Date" := Rec."Transaction Date";
                                    GenJournalLine.Description := TransactionCharges.Description;
                                    GenJournalLine.Validate(GenJournalLine."Currency Code");
                                    //IF (TransactionCharges."Charge Code",'<>SD') AND (Amount > 20000)  THEN
                                    //ChargeAmount:=200 ELSE
                                    GenJournalLine.Amount := TransactionCharges."Charge Amount";
                                    GenJournalLine.Validate(GenJournalLine.Amount);
                                    GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                                    GenJournalLine."Bal. Account No." := TransactionCharges."G/L Account";
                                    GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                                    GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                                    GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                    if GenJournalLine.Amount <> 0 then
                                        GenJournalLine.Insert;

                                    TChargeAmount := TChargeAmount + ChargeAmount;
                                    ExciseDuty := 0;
                                    GenSetup.get();
                                    ExciseDuty := (GenSetup."Loan Excise Duty(%)" / 100) * TransactionCharges."Charge Amount";

                                    //***Graduated Charge End

                                    LineNo := LineNo + 10000;
                                    GenJournalLine.Init;
                                    GenJournalLine."Journal Template Name" := 'GENERAL';
                                    GenJournalLine."Journal Batch Name" := 'FTRANS';
                                    GenJournalLine."Document No." := Rec.No;
                                    GenJournalLine."Line No." := LineNo;
                                    GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                                    GenJournalLine."Account No." := Rec."Account No";
                                    GenJournalLine."External Document No." := Rec."ID No";
                                    GenJournalLine.Validate(GenJournalLine."Account No.");
                                    GenJournalLine."Posting Date" := Rec."Transaction Date";
                                    GenJournalLine.Description := 'Excise Duty';
                                    GenJournalLine.Validate(GenJournalLine."Currency Code");
                                    GenJournalLine.Amount := ExciseDuty;
                                    GenJournalLine.Validate(GenJournalLine.Amount);
                                    GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                                    GenJournalLine."Bal. Account No." := GenSetup."Excise Duty Account";
                                    GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                                    GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                                    GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                    if GenJournalLine.Amount <> 0 then
                                        GenJournalLine.Insert;
                                end;
                            end;
                        until TransactionCharges.Next = 0;
                    end;
                end;
            end;
        end;

        if ObjAccountType.Get(Rec."Account Type") then begin
            //if Rec.Amount <= ObjAccountType."Bulk Withdrawal Amount" then begin
            if Account.Get(Rec."Account No") then begin
                // if Account."Staff Account" <> true then begin

                //***Graduated Charge
                ChargeAmount := 0;
                //***Graduated Charge
                ChargeAmount := 0;
                if (VarTransactionType = VarTransactionType::"Cash Withdrawal") and Rec."Use Graduated Charges" = true then begin
                    GraduatedCharge.Reset;
                    if GraduatedCharge.Find('-') then begin
                        repeat
                            if (Rec.Amount >= GraduatedCharge."Minimum Amount") and (Rec.Amount <= GraduatedCharge."Maximum Amount") then begin
                                if GraduatedCharge."Use Percentage" = true then begin
                                    ChargeAmount := Rec.Amount * (GraduatedCharge."Percentage of Amount" / 100)
                                end else
                                    ChargeAmount := GraduatedCharge.Amount;
                            end;
                        until GraduatedCharge.Next = 0;
                    end;
                end;
                //Message('Normal Withdrawal Charge %1', ChargeAmount);
                //ChargeAmount:=TransactionCharges."Charge Amount";

                if (VarTransactionType = VarTransactionType::"Cash Withdrawal") and Rec."Use Graduated Charges" = true then begin
                    if Account.Get(Rec."Account No") then begin
                        if Account."Staff Account" = false then begin
                            Echarge := ChargeAmount;

                            LineNo := LineNo + 10000;
                            GenJournalLine.Init;
                            GenJournalLine."Journal Template Name" := 'GENERAL';
                            GenJournalLine."Journal Batch Name" := 'FTRANS';
                            GenJournalLine."Document No." := Rec.No;
                            GenJournalLine."Line No." := LineNo;
                            GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                            GenJournalLine."Account No." := Rec."Account No";
                            if Rec."Account No" = '00-0000000000' then
                                GenJournalLine."External Document No." := Rec."ID No";
                            GenJournalLine.Validate(GenJournalLine."Account No.");
                            GenJournalLine."Posting Date" := Rec."Transaction Date";
                            GenJournalLine.Description := 'Cash Withdrawal Comission';
                            GenJournalLine.Validate(GenJournalLine."Currency Code");
                            //IF (TransactionCharges."Charge Code",'<>SD') AND (Amount > 20000)  THEN
                            //ChargeAmount:=200 ELSE
                            GenJournalLine.Amount := ChargeAmount;
                            GenJournalLine.Validate(GenJournalLine.Amount);
                            GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                            GenJournalLine."Bal. Account No." := GraduatedCharge."Charge Account";
                            GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                            GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                            GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                            if GenJournalLine.Amount <> 0 then
                                GenJournalLine.Insert;

                            TChargeAmount := TChargeAmount + ChargeAmount;

                            ExciseDuty := 0;
                            GenSetup.get();

                            ExciseDuty := (GenSetup."Excise Duty(%)" / 100) * ChargeAmount;

                            //***Graduated Charge End

                            LineNo := LineNo + 10000;
                            GenJournalLine.Init;
                            GenJournalLine."Journal Template Name" := 'GENERAL';
                            GenJournalLine."Journal Batch Name" := 'FTRANS';
                            GenJournalLine."Document No." := Rec.No;
                            GenJournalLine."Line No." := LineNo;
                            GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                            GenJournalLine."Account No." := Rec."Account No";
                            GenJournalLine."External Document No." := Rec."ID No";
                            GenJournalLine.Validate(GenJournalLine."Account No.");
                            GenJournalLine."Posting Date" := Rec."Transaction Date";
                            GenJournalLine.Description := 'Excise Duty';
                            GenJournalLine.Validate(GenJournalLine."Currency Code");
                            GenJournalLine.Amount := ExciseDuty;//(ChargeAmount * (GenSetup."Loan Excise Duty(%)" / 100));
                            GenJournalLine.Validate(GenJournalLine.Amount);
                            GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                            GenJournalLine."Bal. Account No." := GenSetup."Excise Duty Account";
                            GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                            GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                            GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                            if GenJournalLine.Amount <> 0 then
                                GenJournalLine.Insert;

                            //***Graduated Charge End
                            // Message('Here%1UseGra%2Charge%3Excise%4', VarTransactionType, Rec."Use Graduated Charges", ChargeAmount,ExciseDuty);

                        end;
                    end;
                end;
            end;
            //end;
            // end;
        end;



        GenSetup.Get();



        //***Graduated Charge With Notices
        ChargeAmount := 0;
        if ObjAccountType.Get(Rec."Account Type") then begin



            if (VarTransactionType = VarTransactionType::"Cash Withdrawal") and Rec."Use Graduated Charges" = true then begin
                if (Rec."Bulk Withdrawal Appl Done" = true) then begin
                    GraduatedCharge.Reset;
                    GraduatedCharge.SetRange(GraduatedCharge."Notice Status", VarNoticeType);
                    if GraduatedCharge.Find('-') then begin
                        repeat
                            if ((Rec.Amount) >= GraduatedCharge."Minimum Amount") and ((Rec.Amount) <= GraduatedCharge."Maximum Amount") then
                                ChargeAmount := GraduatedCharge.Amount;

                        until GraduatedCharge.Next = 0;
                    end;
                end;
            end;


            //ChargeAmount:=TransactionCharges."Charge Amount";
            if (VarTransactionType = VarTransactionType::"Cash Withdrawal") and Rec."Use Graduated Charges" = true then begin
                if Account.Get(Rec."Account No") then begin
                    if Account."Staff Account" = false then begin
                        Echarge := ChargeAmount;

                        LineNo := LineNo + 10000;
                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name" := 'GENERAL';
                        GenJournalLine."Journal Batch Name" := 'FTRANS';
                        GenJournalLine."Document No." := Rec.No;
                        GenJournalLine."Line No." := LineNo;
                        GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                        GenJournalLine."Account No." := Rec."Account No";
                        if Rec."Account No" = '00-0000000000' then
                            GenJournalLine."External Document No." := Rec."ID No";
                        GenJournalLine.Validate(GenJournalLine."Account No.");
                        GenJournalLine."Posting Date" := Rec."Transaction Date";
                        GenJournalLine.Description := 'Cash Withdrawal Comission';
                        GenJournalLine.Validate(GenJournalLine."Currency Code");
                        //IF (TransactionCharges."Charge Code",'<>SD') AND (Amount > 20000)  THEN
                        //ChargeAmount:=200 ELSE
                        GenJournalLine.Amount := ChargeAmount;
                        GenJournalLine.Validate(GenJournalLine.Amount);
                        GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                        GenJournalLine."Bal. Account No." := GraduatedCharge."Charge Account";
                        GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                        GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                        GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                        if GenJournalLine.Amount <> 0 then
                            GenJournalLine.Insert;

                        TChargeAmount := TChargeAmount + ChargeAmount;


                        ExciseDuty := (GenSetup."Loan Excise Duty(%)" / 100) * ChargeAmount;

                        //***Graduated Charge End

                        LineNo := LineNo + 10000;
                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name" := 'GENERAL';
                        GenJournalLine."Journal Batch Name" := 'FTRANS';
                        GenJournalLine."Document No." := Rec.No;
                        GenJournalLine."Line No." := LineNo;
                        GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                        GenJournalLine."Account No." := Rec."Account No";
                        GenJournalLine."External Document No." := Rec."ID No";
                        GenJournalLine.Validate(GenJournalLine."Account No.");
                        GenJournalLine."Posting Date" := Rec."Transaction Date";
                        GenJournalLine.Description := 'Excise Duty';
                        GenJournalLine.Validate(GenJournalLine."Currency Code");
                        GenJournalLine.Amount := (ChargeAmount * (GenSetup."Loan Excise Duty(%)" / 100));
                        GenJournalLine.Validate(GenJournalLine.Amount);
                        GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                        GenJournalLine."Bal. Account No." := GenSetup."Excise Duty Account";
                        GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                        GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                        GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                        if GenJournalLine.Amount <> 0 then
                            GenJournalLine.Insert;

                    end;
                end;
            end;

        end;



        //ABOVE 20K
        //Charges
        TCharges := 0;
        //IF Amount > 20000 THEN BEGIN

        TransactionCharges.Reset;
        TransactionCharges.SetRange(TransactionCharges."Transaction Type", Rec."Transaction Type");
        TransactionCharges.SetRange(TransactionCharges."Charge Code", '0003');
        if TransactionCharges.Find('-') then begin
            //REPEAT
            LineNo := LineNo + 10000;

            LineNo := LineNo + 10000;

            ChargeAmount := 2;

            if Account.Get(Rec."Account No") then begin
                if Account."Staff Account" = false then begin
                    GenJournalLine.Init;
                    GenJournalLine."Journal Template Name" := 'GENERAL';
                    GenJournalLine."Journal Batch Name" := 'FTRANS';
                    GenJournalLine."Document No." := Rec.No;
                    GenJournalLine."Line No." := LineNo;
                    GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                    GenJournalLine."Account No." := Rec."Account No";
                    if Rec."Account No" = '00-0000000000' then
                        GenJournalLine."External Document No." := Rec."ID No";
                    GenJournalLine.Validate(GenJournalLine."Account No.");
                    GenJournalLine."Posting Date" := Rec."Transaction Date";
                    GenJournalLine.Description := 'Stamp Duty';
                    GenJournalLine.Validate(GenJournalLine."Currency Code");
                    GenJournalLine.Amount := ChargeAmount;
                    GenJournalLine.Validate(GenJournalLine.Amount);
                    GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                    GenJournalLine."Bal. Account No." := TransactionCharges."G/L Account";
                    GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                    GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                    GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                    if GenJournalLine.Amount <> 0 then
                        GenJournalLine.Insert;

                    TChargeAmount := TChargeAmount + ChargeAmount;

                    //UNTIL TransactionCharges.NEXT = 0;
                end;
            end;
            //Charges
        end;
        //END;
        //END;



        //ABOVE 20K
        //Charge withdrawal Freq
        if VarTransactionType = VarTransactionType::"Cash Withdrawal" then begin
            if Account.Get(Rec."Account No") then begin
                if AccountTypes.Get(Account."Account Type") then begin
                    if Account."Last Withdrawal Date" = 0D then begin
                        Account."Last Withdrawal Date" := Today;
                        Account.Modify;
                    end else begin
                        if CalcDate(AccountTypes."Withdrawal Interval", Account."Last Withdrawal Date") > Today then begin
                            //IF CALCDATE(AccountTypes."Withdrawal Interval",Account."Last Withdrawal Date") <= CALCDATE('1D',TODAY) THEN BEGIN
                            LineNo := LineNo + 10000;

                            GenJournalLine.Init;
                            GenJournalLine."Journal Template Name" := 'GENERAL';
                            GenJournalLine."Journal Batch Name" := 'FTRANS';
                            GenJournalLine."Document No." := Rec.No;
                            GenJournalLine."Line No." := LineNo;
                            GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                            GenJournalLine."Account No." := Rec."Account No";
                            if Rec."Account No" = '00-0000000000' then
                                GenJournalLine."External Document No." := Rec."ID No";

                            GenJournalLine.Validate(GenJournalLine."Account No.");
                            GenJournalLine."Posting Date" := Rec."Transaction Date";
                            GenJournalLine.Description := 'Commision on Withdrawal Freq.';
                            GenJournalLine.Validate(GenJournalLine."Currency Code");
                            GenJournalLine.Amount := AccountTypes."Withdrawal Penalty";
                            GenJournalLine.Validate(GenJournalLine.Amount);
                            GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                            GenJournalLine."Bal. Account No." := AccountTypes."Withdrawal Interval Account";
                            GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                            GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                            GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                            if GenJournalLine.Amount <> 0 then
                                GenJournalLine.Insert;

                        end;
                        Account."Last Withdrawal Date" := Today;
                        Account.Modify;

                    end;
                end;
            end;

            //NON-CUSTOMER CHARGE
            if Rec."Account No" = '507-10000-00' then;
            //NON-CUSTOMER CHARGE

        end;
        //Charge withdrawal Freq


        //Charge Overdraft Comission
        if Rec."Authorisation Requirement" = 'Over draft' then begin
            if (Rec."Over Draft Type" = Rec."over draft type"::AWD) and (Rec."Excempt Charge" <> true) then begin
                Charges.Reset;
                Charges.SetRange(Charges.Code, 'AWD');
                if Charges.Find('-') then begin
                    if Charges."Use Percentage" = true then begin
                        OverDraftCharge := Rec.Amount * (Charges."Percentage of Amount" / 100);
                        OverDraftChargeAcc := Charges."GL Account"
                    end else
                        OverDraftCharge := Charges."Charge Amount";
                    OverDraftChargeAcc := Charges."GL Account"
                end;

                LineNo := LineNo + 10000;

                GenJournalLine.Init;
                GenJournalLine."Journal Template Name" := 'GENERAL';
                GenJournalLine."Journal Batch Name" := 'FTRANS';
                GenJournalLine."Document No." := Rec.No;
                GenJournalLine."Line No." := LineNo;
                GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                GenJournalLine."Account No." := Rec."Account No";
                GenJournalLine.Validate(GenJournalLine."Account No.");
                GenJournalLine."Posting Date" := Rec."Transaction Date";
                GenJournalLine.Description := 'Commision on Overdraft';
                GenJournalLine.Validate(GenJournalLine."Currency Code");
                if AccountTypes.Get(Rec."Account Type") then begin
                    GenJournalLine.Amount := OverDraftCharge;
                end;
                GenJournalLine.Validate(GenJournalLine.Amount);
                GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                GenJournalLine."Bal. Account No." := OverDraftChargeAcc;
                GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                if GenJournalLine.Amount <> 0 then
                    GenJournalLine.Insert;


            end;
        end;

        //Charge Overdraft Comission
        if Rec."Authorisation Requirement" = 'Over draft' then begin
            if (Rec."Over Draft Type" = Rec."over draft type"::LWD) and (Rec."Excempt Charge" <> true) then begin
                Charges.Reset;
                Charges.SetRange(Charges.Code, 'LWD');
                if Charges.Find('-') then begin
                    if Charges."Use Percentage" = true then begin
                        OverDraftCharge := Rec.Amount * (Charges."Percentage of Amount" / 100);
                        if LoanType.Get(Rec."LWD Loan Product") then
                            //OverDraftChargeAcc:=Charges."GL Account"
                            OverDraftChargeAcc := LoanType."Loan Interest Account"
                    end else
                        OverDraftCharge := Charges."Charge Amount";
                    if LoanType.Get(Rec."LWD Loan Product") then
                        //OverDraftChargeAcc:=Charges."GL Account"
                        OverDraftChargeAcc := LoanType."Loan Interest Account"
                end;

                LineNo := LineNo + 10000;

                GenJournalLine.Init;
                GenJournalLine."Journal Template Name" := 'GENERAL';
                GenJournalLine."Journal Batch Name" := 'FTRANS';
                GenJournalLine."Document No." := Rec.No;
                GenJournalLine."Line No." := LineNo;
                GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                GenJournalLine."Account No." := Rec."Account No";
                GenJournalLine.Validate(GenJournalLine."Account No.");
                GenJournalLine."Posting Date" := Rec."Transaction Date";
                GenJournalLine.Description := 'Commision on Overdraft';
                GenJournalLine.Validate(GenJournalLine."Currency Code");
                if AccountTypes.Get(Rec."Account Type") then begin
                    GenJournalLine.Amount := OverDraftCharge;
                end;
                GenJournalLine.Validate(GenJournalLine.Amount);
                GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                GenJournalLine."Bal. Account No." := OverDraftChargeAcc;
                GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                if GenJournalLine.Amount <> 0 then
                    GenJournalLine.Insert;


            end;
        end;










        //BOSA Entries
        //IF Type = 'Cash Deposit' THEN BEGIN
        if (Rec."Account No" = '502-00-000300-00') or (Rec."Account No" = '502-00-000303-00') then
            PostBOSAEntries();
        //END;


        //Post New
        GenJournalLine.Reset;
        GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
        GenJournalLine.SetRange("Journal Batch Name", 'FTRANS');
        if GenJournalLine.Find('-') then begin
            Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco", GenJournalLine);
        end;
        //Post New


        Rec."Transaction Available Balance" := AvailableBalance;
        Rec.Posted := true;

        Rec.Authorised := Rec.Authorised::Yes;
        Rec."Supervisor Checked" := true;
        Rec."Needs Approval" := Rec."needs approval"::No;
        Rec."Frequency Needs Approval" := Rec."frequency needs approval"::No;
        Rec."Date Posted" := Today;
        Rec."Time Posted" := Time;
        Rec."Posted By" := UserId;

        Rec.Modify;
        TillNo := '';
        TellerTill.Reset;
        TellerTill.SetRange(TellerTill."Account Type", TellerTill."account type"::Cashier);
        TellerTill.SetRange(TellerTill.CashierID, UserId);
        if TellerTill.Find('-') then begin

            Rec."Bank Used To Post" := TellerTill."No.";

            rec.Modify();

        end;

        //Clear Bulk Withdrawal Details
        if Account.Get(Rec."Account No") and (Rec."Transaction Date" = Today) then begin
            Account."Bulk Withdrawal App Done By" := '';
            Account."Bulk Withdrawal Appl Amount" := 0;
            Account."Bulk Withdrawal Appl Date" := 0D;
            Account."Bulk Withdrawal Appl Done" := false;
            Account."Bulk Withdrawal Fee" := 0;
            Account.Modify;
        end;
        //End Clear Bulk Withdrawal Details

        Rec.calcfields(Rec.Types);
        FnSendCLientSMS(Rec."Member No", Format(Rec.Types), Rec.Amount);
        Trans.Reset;
        Trans.SetRange(Trans.No, Rec.No);
        if Trans.Find('-') then begin
            if VarTransactionType = VarTransactionType::"Cash Deposit" then
                Report.Run(173038, false, true, Trans)
            else
                if Rec.Type = 'BOSA Receipt' then
                    Report.Run(172516, false, true, Trans)
                else
                    if VarTransactionType = VarTransactionType::"Cash Withdrawal" then
                        Report.Run(173039, false, true, Trans)
        end;


        CurrPage.Close;
    end;


    procedure PostBOSAEntries()
    var
        ReceiptAllocation: Record "Receipt Allocation";
    begin
        GenJournalLine.Reset;
        GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
        GenJournalLine.SetRange("Journal Batch Name", 'FTRANS');
        GenJournalLine.DeleteAll;

        Rec.calcfields(Rec.Types);

        //BOSA Cash Book Entry
        if Rec."Transaction Type" = 'RECEIPT' then begin


            LineNo := LineNo + 10000;

            GenJournalLine.Init;
            GenJournalLine."Journal Template Name" := 'GENERAL';
            GenJournalLine."Journal Batch Name" := 'FTRANS';
            GenJournalLine."Document No." := Rec.No;
            GenJournalLine."External Document No." := Rec."Cheque No";
            GenJournalLine."Line No." := LineNo;
            GenJournalLine."Account Type" := GenJournalLine."account type"::"Bank Account";
            GenJournalLine."Account No." := Rec."Bank Account";
            GenJournalLine.Validate(GenJournalLine."Account No.");
            GenJournalLine."Posting Date" := Rec."Document Date";
            GenJournalLine.Description := Rec."Member Name";
            GenJournalLine.Validate(GenJournalLine."Currency Code");
            GenJournalLine.Amount := Rec.Amount;
            GenJournalLine.Validate(GenJournalLine.Amount);
            if GenJournalLine.Amount <> 0 then
                GenJournalLine.Insert;

            ReceiptAllocations.Reset;
            ReceiptAllocations.SetRange(ReceiptAllocations."Document No", Rec.No);
            if ReceiptAllocations.Find('-') then begin
                repeat
                    LineNo := LineNo + 10000;

                    GenJournalLine.Init;
                    GenJournalLine."Journal Template Name" := 'GENERAL';
                    GenJournalLine."Journal Batch Name" := 'FTRANS';
                    GenJournalLine."Line No." := LineNo;
                    GenJournalLine."Document No." := Rec.No;
                    GenJournalLine."External Document No." := Rec."Cheque No";
                    GenJournalLine."Posting Date" := Rec."Document Date";
                    GenJournalLine.Validate(GenJournalLine."Account No.");
                    GenJournalLine."Account Type" := ReceiptAllocations."Account Type";
                    if ReceiptAllocations."Account Type" <> ReceiptAllocations."account type"::Member then begin
                        GenJournalLine."Account No." := ReceiptAllocations."Account No"
                    end else
                        GenJournalLine."Account No." := ReceiptAllocations."Member No";
                    GenJournalLine."Transaction Type" := ReceiptAllocations."Transaction Type";
                    GenJournalLine.Validate(GenJournalLine."Account No.");
                    GenJournalLine.Description := Format(ReceiptAllocations."Transaction Type");
                    GenJournalLine.Amount := -ReceiptAllocations.Amount;
                    GenJournalLine.Validate(GenJournalLine.Amount);
                    GenJournalLine."Loan No" := ReceiptAllocations."Loan No.";
                    if GenJournalLine.Amount <> 0 then
                        GenJournalLine.Insert;


                    //Generate Advice
                    if (ReceiptAllocations."Transaction Type" = ReceiptAllocations."transaction type"::"Registration Fee") then begin
                        if LoansR.Get(ReceiptAllocations."Loan No.") then begin
                            LoansR.CalcFields(LoansR."Outstanding Balance");
                            LoansR.Advice := true;
                            if ((LoansR."Outstanding Balance" - ReceiptAllocations.Amount) < LoansR."Loan Principle Repayment") then
                                LoansR."Advice Type" := LoansR."advice type"::Stoppage
                            else
                                LoansR."Advice Type" := LoansR."advice type"::Adjustment;
                            LoansR.Modify;
                        end;
                    end;
                //Generate Advice

                until ReceiptAllocations.Next = 0;
            end;
        end;


        //Post New
        GenJournalLine.Reset;
        GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
        GenJournalLine.SetRange("Journal Batch Name", 'FTRANS');
        if GenJournalLine.Find('-') then begin
            Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco", GenJournalLine);
        end;
        Message('Transaction Posted Successfully!');
        //Post New


        Rec.Posted := true;

        Rec.Authorised := Rec.Authorised::Yes;
        Rec."Supervisor Checked" := true;
        Rec."Needs Approval" := Rec."needs approval"::No;
        Rec."Frequency Needs Approval" := Rec."frequency needs approval"::No;
        Rec."Date Posted" := Today;
        Rec."Time Posted" := Time;
        Rec."Posted By" := UserId;

        if ChequeTypes."Clearing  Days" = 0 then begin
            Rec.Status := Rec.Status::Honoured;
            Rec."Cheque Processed" := true;
            Rec."Date Cleared" := Today;
        end;

        Trans.Reset;
        Trans.SetRange(Trans.No, Rec.No);
        if Trans.Find('-') then begin
            Report.Run(172516, false, true, Trans);
            Report.Print(172516, Trans.No);

            Report.Run(172516, false, true, Trans);
            // REPORT.RUN(172486,FALSE,TRUE,Trans);
        end;
        Rec.Modify;
        TillNo := '';
        TellerTill.Reset;
        TellerTill.SetRange(TellerTill."Account Type", TellerTill."account type"::Cashier);
        TellerTill.SetRange(TellerTill.CashierID, UserId);
        if TellerTill.Find('-') then begin

            Rec."Bank Used To Post" := TellerTill."No.";

            rec.Modify();

        end;

        CurrPage.Close;
    end;


    procedure PostChequeWith()
    begin
        //Block Payments
        if Acc.Get(Rec."Account No") then begin
            if Acc.Blocked = Acc.Blocked::Payment then
                Error('This account has been blocked from receiving payments.');
        end;
        //+++++++++++++++++++++++++++++Get the transaction type++++++++++++++++++++++++++++
        TransactionTypes.Reset();
        TransactionTypes.SetRange(TransactionTypes.Code, Rec."Transaction Type");
        if TransactionTypes.Find('-') then begin
            VarTransactionType := TransactionTypes.Type;
        end;
        Rec.calcfields(Rec.Types);
        /*DValue.RESET;
        DValue.SETRANGE(DValue."Global Dimension No.",2);
        DValue.SETRANGE(DValue.Code,'Nairobi');
        //DValue.SETRANGE(DValue.Code,DBranch);
        IF DValue.FIND('-') THEN BEGIN
        DValue.TESTFIELD(DValue."Banker Cheque Account");
        ChBank:=DValue."Banker Cheque Account";
        END ELSE
        ERROR('Branch not set.');*/

        CalcAvailableBal;

        //Check withdrawal limits
        if VarTransactionType = VarTransactionType::"Cheque Deposit" then begin
            if AvailableBalance < Rec.Amount then begin
                if Rec.Authorised = Rec.Authorised::Yes then begin
                    Rec.Overdraft := true;
                    Rec.Modify;
                end;

                if Rec.Authorised = Rec.Authorised::No then begin
                    if Rec."Branch Transaction" = false then begin
                        Rec."Authorisation Requirement" := 'Cheque Withdrawal - Over draft';
                        Rec.Modify;
                        Message('You cannot issue a Cheque more than the available balance unless authorised.');
                        SendEmail;
                        exit;
                    end;
                end;
                if Rec.Authorised = Rec.Authorised::Rejected then
                    Error('Cheque Withdrawal transaction has been rejected and therefore cannot proceed.');
                //SendEmail;
            end;
        end;
        //Check withdrawal limits


        GenJournalLine.Reset;
        GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
        GenJournalLine.SetRange("Journal Batch Name", 'FTRANS');
        if GenJournalLine.FindSet() then begin
            GenJournalLine.DeleteAll;
        end;
        LineNo := LineNo + 10000;

        GenJournalLine.Init;
        GenJournalLine."Journal Template Name" := 'GENERAL';
        GenJournalLine."Journal Batch Name" := 'FTRANS';
        GenJournalLine."Document No." := Rec.No;
        GenJournalLine."External Document No." := Rec."Bankers Cheque No";
        GenJournalLine."Line No." := LineNo;
        GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
        GenJournalLine."Account No." := Rec."Account No";
        GenJournalLine.Validate(GenJournalLine."Account No.");

        GenJournalLine."Posting Date" := Rec."Transaction Date";
        if Rec."Branch Transaction" = true then
            GenJournalLine.Description := Format(Rec.Types)
        else
            GenJournalLine.Description := Rec.Payee + Rec."Transaction Description" + '-' + Rec.Description;
        GenJournalLine.Validate(GenJournalLine."Currency Code");
        GenJournalLine.Amount := Rec.Amount;
        GenJournalLine.Validate(GenJournalLine.Amount);
        GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
        GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
        if GenJournalLine.Amount <> 0 then
            GenJournalLine.Insert;

        LineNo := LineNo + 10000;

        GenJournalLine.Init;
        GenJournalLine."Journal Template Name" := 'GENERAL';
        GenJournalLine."Journal Batch Name" := 'FTRANS';
        GenJournalLine."Document No." := Rec.No;
        GenJournalLine."External Document No." := Rec."Bankers Cheque No";
        GenJournalLine."Line No." := LineNo;
        GenJournalLine."Account Type" := GenJournalLine."account type"::"Bank Account";
        GenJournalLine."Account No." := Rec."Cheque Clearing Bank Code";
        GenJournalLine.Validate(GenJournalLine."Account No.");
        GenJournalLine."Posting Date" := Rec."Transaction Date";
        GenJournalLine.Description := Rec.Payee;//"Account Name";
        GenJournalLine.Validate(GenJournalLine."Currency Code");
        GenJournalLine.Amount := -Rec.Amount;
        GenJournalLine.Validate(GenJournalLine.Amount);
        GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
        GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
        if GenJournalLine.Amount <> 0 then
            GenJournalLine.Insert;

        if Account.Get(Rec."Account No") then begin
            if Account."Staff Account" <> true then begin

                //Charges
                TransactionCharges.Reset;
                TransactionCharges.SetRange(TransactionCharges."Transaction Type", Rec."Transaction Type");
                if TransactionCharges.Find('-') then begin
                    repeat
                        LineNo := LineNo + 10000;

                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name" := 'GENERAL';
                        GenJournalLine."Journal Batch Name" := 'FTRANS';
                        GenJournalLine."Document No." := Rec.No;
                        GenJournalLine."External Document No." := Rec."Bankers Cheque No";
                        GenJournalLine."Line No." := LineNo;
                        GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
                        GenJournalLine."Account No." := TransactionCharges."G/L Account";
                        GenJournalLine.Validate(GenJournalLine."Account No.");
                        GenJournalLine."Posting Date" := Rec."Transaction Date";
                        GenJournalLine.Description := TransactionCharges.Description;
                        GenJournalLine.Validate(GenJournalLine."Currency Code");
                        GenJournalLine.Amount := TransactionCharges."Charge Amount" * -1;
                        GenJournalLine.Validate(GenJournalLine.Amount);
                        GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                        GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                        GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                        if GenJournalLine.Amount <> 0 then
                            GenJournalLine.Insert;

                        if TransactionCharges."Include Excise Duty" then begin
                            LineNo := LineNo + 10000;
                            GenSetup.Get();
                            GenJournalLine.Init;
                            GenJournalLine."Journal Template Name" := 'GENERAL';
                            GenJournalLine."Journal Batch Name" := 'FTRANS';
                            GenJournalLine."Document No." := Rec.No;
                            GenJournalLine."External Document No." := Rec."Bankers Cheque No";
                            GenJournalLine."Line No." := LineNo;
                            GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
                            GenJournalLine."Account No." := GenSetup."Excise Duty Account";
                            GenJournalLine.Validate(GenJournalLine."Account No.");
                            GenJournalLine."Posting Date" := Rec."Transaction Date";
                            GenJournalLine.Description := TransactionCharges.Description;
                            GenJournalLine.Validate(GenJournalLine."Currency Code");
                            GenJournalLine.Amount := TransactionCharges."Charge Amount" * (TransactionCharges."Excise Duty (10%)" / 100) * -1;
                            GenJournalLine.Validate(GenJournalLine.Amount);
                            GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                            GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                            GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                            if GenJournalLine.Amount <> 0 then
                                GenJournalLine.Insert;


                            LineNo := LineNo + 10000;

                            GenJournalLine.Init;
                            GenJournalLine."Journal Template Name" := 'GENERAL';
                            GenJournalLine."Journal Batch Name" := 'FTRANS';
                            GenJournalLine."Document No." := Rec.No;
                            GenJournalLine."External Document No." := Rec."Bankers Cheque No";
                            GenJournalLine."Line No." := LineNo;
                            GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                            GenJournalLine."Account No." := Rec."Account No";
                            GenJournalLine.Validate(GenJournalLine."Account No.");
                            GenJournalLine."Posting Date" := Rec."Transaction Date";
                            GenJournalLine.Description := TransactionCharges.Description;
                            GenJournalLine.Validate(GenJournalLine."Currency Code");
                            GenJournalLine.Amount := TransactionCharges."Charge Amount" * (TransactionCharges."Excise Duty (10%)" / 100);
                            GenJournalLine.Validate(GenJournalLine.Amount);
                            GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                            GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                            if GenJournalLine.Amount <> 0 then
                                GenJournalLine.Insert;
                        end;
                        if TransactionCharges."Due Amount" > 0 then begin
                            LineNo := LineNo + 10000;

                            GenJournalLine.Init;
                            GenJournalLine."Journal Template Name" := 'GENERAL';
                            GenJournalLine."Journal Batch Name" := 'FTRANS';
                            GenJournalLine."Document No." := Rec.No;
                            GenJournalLine."External Document No." := Rec."Bankers Cheque No";
                            GenJournalLine."Line No." := LineNo;
                            GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
                            GenJournalLine."Account No." := TransactionCharges."G/L Account";
                            GenJournalLine.Validate(GenJournalLine."Account No.");
                            GenJournalLine."Posting Date" := Rec."Transaction Date";
                            GenJournalLine.Description := TransactionCharges.Description;
                            GenJournalLine.Validate(GenJournalLine."Currency Code");
                            GenJournalLine.Amount := TransactionCharges."Due Amount";
                            GenJournalLine.Validate(GenJournalLine.Amount);
                            GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"Bank Account";
                            GenJournalLine."Bal. Account No." := ChBank;
                            GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                            GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                            GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                            if GenJournalLine.Amount <> 0 then
                                GenJournalLine.Insert;


                        end;

                    until TransactionCharges.Next = 0;
                end;


                //Balancing Account
                //Charges
                TransactionCharges.Reset;
                TransactionCharges.SetRange(TransactionCharges."Transaction Type", Rec."Transaction Type");
                if TransactionCharges.Find('-') then begin
                    TransactionCharges.CalcFields(TransactionCharges."Total Charges");
                    LineNo := LineNo + 10000;

                    GenJournalLine.Init;
                    GenJournalLine."Journal Template Name" := 'GENERAL';
                    GenJournalLine."Journal Batch Name" := 'FTRANS';
                    GenJournalLine."Document No." := Rec.No;
                    GenJournalLine."External Document No." := Rec."Bankers Cheque No";
                    GenJournalLine."Line No." := LineNo;
                    GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                    GenJournalLine."Account No." := Rec."Account No";
                    GenJournalLine.Validate(GenJournalLine."Account No.");
                    GenJournalLine."Posting Date" := Rec."Transaction Date";
                    GenJournalLine.Description := TransactionCharges.Description;
                    GenJournalLine.Validate(GenJournalLine."Currency Code");
                    GenJournalLine.Amount := TransactionCharges."Total Charges";
                    GenJournalLine.Validate(GenJournalLine.Amount);
                    GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                    GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                    if GenJournalLine.Amount <> 0 then
                        GenJournalLine.Insert;
                end;
            end;
        end;

        //Charge Overdraft Comission
        if Rec."Authorisation Requirement" = 'Over draft' then begin
            if (Rec."Over Draft Type" = Rec."over draft type"::AWD) and (Rec."Excempt Charge" <> true) then begin
                Charges.Reset;
                Charges.SetRange(Charges.Code, 'AWD');
                if Charges.Find('-') then begin
                    if Charges."Use Percentage" = true then begin
                        OverDraftCharge := Rec.Amount * (Charges."Percentage of Amount" / 100);
                        OverDraftChargeAcc := Charges."GL Account"
                    end else
                        OverDraftCharge := Charges."Charge Amount";
                    OverDraftChargeAcc := Charges."GL Account"
                end;

                LineNo := LineNo + 10000;

                GenJournalLine.Init;
                GenJournalLine."Journal Template Name" := 'GENERAL';
                GenJournalLine."Journal Batch Name" := 'FTRANS';
                GenJournalLine."Document No." := Rec.No;
                GenJournalLine."Line No." := LineNo;
                GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                GenJournalLine."Account No." := Rec."Account No";
                GenJournalLine.Validate(GenJournalLine."Account No.");
                GenJournalLine."Posting Date" := Rec."Transaction Date";
                GenJournalLine.Description := 'Commision on Overdraft';
                GenJournalLine.Validate(GenJournalLine."Currency Code");
                if AccountTypes.Get(Rec."Account Type") then begin
                    GenJournalLine.Amount := OverDraftCharge;
                end;
                GenJournalLine.Validate(GenJournalLine.Amount);
                GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                GenJournalLine."Bal. Account No." := OverDraftChargeAcc;
                GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                if GenJournalLine.Amount <> 0 then
                    GenJournalLine.Insert;
            end;
        end;


        //Charge Overdraft Comission
        if Rec."Authorisation Requirement" = 'Over draft' then begin
            if (Rec."Over Draft Type" = Rec."over draft type"::LWD) and (Rec."Excempt Charge" <> true) then begin
                Charges.Reset;
                Charges.SetRange(Charges.Code, 'OVERDRAFT');
                if Charges.Find('-') then begin
                    if Charges."Use Percentage" = true then begin
                        OverDraftCharge := Rec.Amount * (Charges."Percentage of Amount" / 100);
                        if LoanType.Get(Rec."LWD Loan Product") then
                            //OverDraftChargeAcc:=Charges."GL Account"
                            OverDraftChargeAcc := LoanType."Loan Interest Account"
                    end else
                        OverDraftCharge := Charges."Charge Amount";
                    if LoanType.Get(Rec."LWD Loan Product") then
                        //OverDraftChargeAcc:=Charges."GL Account"
                        OverDraftChargeAcc := LoanType."Loan Interest Account"
                end;

                LineNo := LineNo + 10000;

                GenJournalLine.Init;
                GenJournalLine."Journal Template Name" := 'GENERAL';
                GenJournalLine."Journal Batch Name" := 'FTRANS';
                GenJournalLine."Document No." := Rec.No;
                GenJournalLine."Line No." := LineNo;
                GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                GenJournalLine."Account No." := Rec."Account No";
                GenJournalLine.Validate(GenJournalLine."Account No.");
                GenJournalLine."Posting Date" := Rec."Transaction Date";
                GenJournalLine.Description := 'Commision on Overdraft';
                GenJournalLine.Validate(GenJournalLine."Currency Code");
                if AccountTypes.Get(Rec."Account Type") then begin
                    GenJournalLine.Amount := OverDraftCharge;
                end;
                GenJournalLine.Validate(GenJournalLine.Amount);
                GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                GenJournalLine."Bal. Account No." := OverDraftChargeAcc;
                GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                if GenJournalLine.Amount <> 0 then
                    GenJournalLine.Insert;
            end;
        end;

        //Post New
        GenJournalLine.Reset;
        GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
        GenJournalLine.SetRange("Journal Batch Name", 'FTRANS');
        if GenJournalLine.Find('-') then begin
            Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco", GenJournalLine);
        end;

        //Post New


        Rec."Transaction Available Balance" := AvailableBalance;
        Rec.Posted := true;
        Rec.Authorised := Rec.Authorised::Yes;

        Rec."Supervisor Checked" := true;
        Rec."Needs Approval" := Rec."needs approval"::No;
        Rec."Frequency Needs Approval" := Rec."frequency needs approval"::No;
        Rec."Date Posted" := Today;
        Rec."Time Posted" := Time;
        Rec."Posted By" := UserId;

        Rec.Modify;
        TillNo := '';
        TellerTill.Reset;
        TellerTill.SetRange(TellerTill."Account Type", TellerTill."account type"::Cashier);
        TellerTill.SetRange(TellerTill.CashierID, UserId);
        if TellerTill.Find('-') then begin

            Rec."Bank Used To Post" := TellerTill."No.";

            rec.Modify();

        end;
        /*IF CONFIRM('Are you sure you want to print this bankers cheque?',TRUE)=TRUE THEN BEGIN
        REPORT.RUN(,TRUE,TRUE,Trans)
        END;*/


        //Mark Cheque Book
        ChequeRegister.Reset;
        ChequeRegister.SetRange(ChequeRegister."Cheque No.", Rec."Bankers Cheque No");
        if ChequeRegister.Find('-') then begin
            ChequeRegister.Issued := true;
            ChequeRegister.Modify;
        end;

        Message('Cheque Withdrawal posted successfully.');
        CurrPage.Close;

    end;


    procedure SuggestBOSAEntries()
    begin
        Rec.TestField(Posted, false);
        Rec.TestField("BOSA Account No");

        ReceiptAllocations.Reset;
        ReceiptAllocations.SetRange(ReceiptAllocations."Document No", Rec.No);
        ReceiptAllocations.DeleteAll;

        PaymentAmount := Rec.Amount;
        RunBal := PaymentAmount;
        Rec.calcfields(Rec.Types);
        Loans.Reset;
        Loans.SetCurrentkey(Loans.Source, Loans."Client Code");
        Loans.SetRange(Loans."Client Code", Rec."BOSA Account No");
        Loans.SetRange(Loans.Source, Loans.Source::" ");
        if Loans.Find('-') then begin
            repeat
                Loans.CalcFields(Loans."Outstanding Balance", Loans."Interest Due");
                Recover := true;

                if (Loans."Outstanding Balance") > 0 then begin
                    if ((Loans."Outstanding Balance" - Loans."Loan Principle Repayment") <= 0) and (Cheque = false) then
                        Recover := false;

                    if Recover = true then begin

                        Commision := 0;
                        if Cheque = true then begin
                            Commision := (Loans."Outstanding Balance") * 0.1;
                            LOustanding := Loans."Outstanding Balance";
                            if Loans."Interest Due" > 0 then
                                InterestPaid := Loans."Interest Due";
                        end else begin
                            LOustanding := (Loans."Outstanding Balance" - Loans."Loan Principle Repayment");
                            if LOustanding < 0 then
                                LOustanding := 0;
                            if Loans."Interest Due" > 0 then
                                InterestPaid := Loans."Interest Due";
                            if (Loans."Outstanding Balance" - Loans."Loan Principle Repayment") > 0 then begin
                                if (Loans."Outstanding Balance" - Loans."Loan Principle Repayment") > (Loans."Approved Amount" * 1 / 3) then
                                    Commision := LOustanding * 0.1;
                            end;
                        end;

                        if PaymentAmount > 0 then begin
                            if RunBal < (LOustanding + Commision + InterestPaid) then begin
                                if RunBal < InterestPaid then
                                    InterestPaid := RunBal;
                                //Commision:=(RunBal-InterestPaid)*0.1;
                                Commision := (RunBal - InterestPaid) - ((RunBal - InterestPaid) / 1.1);
                                LOustanding := (RunBal - InterestPaid) - Commision;

                            end;
                        end;


                        TotalCommision := TotalCommision + Commision;
                        TotalOustanding := TotalOustanding + LOustanding + InterestPaid + Commision;

                        RunBal := RunBal - (LOustanding + InterestPaid + Commision);

                        if (LOustanding + InterestPaid) > 0 then begin
                            ReceiptAllocations.Init;
                            ReceiptAllocations."Document No" := Rec.No;
                            ReceiptAllocations."Member No" := Rec."BOSA Account No";
                            ReceiptAllocations."Transaction Type" := ReceiptAllocations."transaction type"::"Registration Fee";
                            ReceiptAllocations."Loan No." := Loans."Loan  No.";
                            ReceiptAllocations.Amount := ROUND(LOustanding, 0.01);
                            ReceiptAllocations."Interest Amount" := ROUND(InterestPaid, 0.01);
                            ReceiptAllocations."Total Amount" := ReceiptAllocations.Amount + ReceiptAllocations."Interest Amount";
                            ReceiptAllocations.Insert;
                        end;

                        if Commision > 0 then begin
                            ReceiptAllocations.Init;
                            ReceiptAllocations."Document No" := Rec.No;
                            ReceiptAllocations."Member No" := Rec."BOSA Account No";
                            ReceiptAllocations."Transaction Type" := ReceiptAllocations."transaction type"::"Interest Paid";
                            ReceiptAllocations."Loan No." := Loans."Loan  No.";
                            ReceiptAllocations.Amount := ROUND(Commision, 0.01);
                            ReceiptAllocations."Interest Amount" := 0;
                            ReceiptAllocations."Total Amount" := ReceiptAllocations.Amount + ReceiptAllocations."Interest Amount";
                            ReceiptAllocations.Insert;
                        end;

                    end;
                end;

            until Loans.Next = 0;
        end;

        if RunBal > 0 then begin
            ReceiptAllocations.Init;
            ReceiptAllocations."Document No" := Rec.No;
            ReceiptAllocations."Member No" := Rec."BOSA Account No";
            ReceiptAllocations."Transaction Type" := ReceiptAllocations."transaction type"::" ";
            ReceiptAllocations."Loan No." := '';
            ReceiptAllocations.Amount := RunBal;
            ReceiptAllocations."Interest Amount" := 0;
            ReceiptAllocations."Total Amount" := ReceiptAllocations.Amount + ReceiptAllocations."Interest Amount";
            ReceiptAllocations.Insert;

        end;
    end;


    procedure SendEmail()
    begin
        /*
        //send e-mail to supervisor
        supervisor.RESET;
        supervisor.SETFILTER(supervisor."Transaction Type",'withdrawal');
        IF supervisor.FIND('-') THEN BEGIN
         // MailContent:=TEXT1;
        REPEAT
        
         genSetup.GET(0);
         SMTPMAIL.NewMessage(genSetup."Sender Address",'Transactions' +''+'');
         SMTPMAIL.SetWorkMode();
         SMTPMAIL.ClearAttachments();
         SMTPMAIL.ClearAllRecipients();
         SMTPMAIL.SetDebugMode();
         SMTPMAIL.SetFromAdress(genSetup."Sender Address");
         SMTPMAIL.SetHost(genSetup."Outgoing Mail Server");
         SMTPMAIL.SetUserID(genSetup."Sender User ID");
         SMTPMAIL.AddLine(MailContent);
         SMTPMAIL.SetToAdress(supervisor."E-mail Address");
         SMTPMAIL.Send;
         UNTIL supervisor.NEXT=0;
        END;
        */
    end;

    procedure PostBankersChequeVer1()
    var
        ObjCharges: Record Charges;
        VarChargeAmount: Decimal;
        VarChargeAccount: Code[20];
        VarChargeAmountTax: Decimal;
        VarChargeTaxAccount: Code[20];
    begin
        //Block Payments
        if Acc.Get(Rec."Account No") then begin
            if Acc.Blocked = Acc.Blocked::Payment then
                Error('This account has been blocked from receiving payments.');
        end;
        Rec.calcfields(Rec.Types);
        //+++++++++++++++++++++++++++++Get the transaction type++++++++++++++++++++++++++++
        TransactionTypes.Reset();
        TransactionTypes.SetRange(TransactionTypes.Code, Rec."Transaction Type");
        if TransactionTypes.Find('-') then begin
            VarTransactionType := TransactionTypes.Type;
        end;
        /*DValue.RESET;
        DValue.SETRANGE(DValue."Global Dimension No.",2);
        DValue.SETRANGE(DValue.Code,'Nairobi');
        //DValue.SETRANGE(DValue.Code,DBranch);
        IF DValue.FIND('-') THEN BEGIN
        DValue.TESTFIELD(DValue."Banker Cheque Account");
        ChBank:=DValue."Banker Cheque Account";
        END ELSE
        ERROR('Branch not set.');*/

        CalcAvailableBal;

        //Check withdrawal limits
        if VarTransactionType = VarTransactionType::"Bankers Cheque" then begin
            if AvailableBalance < Rec.Amount then begin
                if Rec.Authorised = Rec.Authorised::Yes then begin
                    Rec.Overdraft := true;
                    Rec.Modify;
                end;

                if Rec.Authorised = Rec.Authorised::No then begin
                    if Rec."Branch Transaction" = false then begin
                        Rec."Authorisation Requirement" := 'Cheque Withdrawal - Over draft';
                        Rec.Modify;
                        Message('You cannot issue a Cheque more than the available balance unless authorised.');
                        SendEmail;
                        exit;
                    end;
                end;
                if Rec.Authorised = Rec.Authorised::Rejected then
                    Error('Cheque Withdrawal transaction has been rejected and therefore cannot proceed.');
                //SendEmail;
            end;
        end;
        //Check withdrawal limits


        GenJournalLine.Reset;
        GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
        GenJournalLine.SetRange("Journal Batch Name", 'FTRANS');
        GenJournalLine.DeleteAll;

        LineNo := LineNo + 10000;

        GenJournalLine.Init;
        GenJournalLine."Journal Template Name" := 'GENERAL';
        GenJournalLine."Journal Batch Name" := 'FTRANS';
        GenJournalLine."Document No." := Rec.No;
        GenJournalLine."External Document No." := Rec."Bankers Cheque No";
        GenJournalLine."Line No." := LineNo;
        GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
        GenJournalLine."Account No." := Rec."Account No";
        GenJournalLine.Validate(GenJournalLine."Account No.");

        GenJournalLine."Posting Date" := Rec."Transaction Date";
        if Rec."Branch Transaction" = true then
            GenJournalLine.Description := Format(Rec.Types) + '-' + Rec."Branch Refference"
        else
            GenJournalLine.Description := Format(Rec.Types) + '-' + Rec.Payee; //"Transaction Description"+'-'+Description ;
        GenJournalLine.Validate(GenJournalLine."Currency Code");
        GenJournalLine.Amount := Rec.Amount;
        GenJournalLine.Validate(GenJournalLine.Amount);
        GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
        GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
        if GenJournalLine.Amount <> 0 then
            GenJournalLine.Insert;

        LineNo := LineNo + 10000;

        GenJournalLine.Init;
        GenJournalLine."Journal Template Name" := 'GENERAL';
        GenJournalLine."Journal Batch Name" := 'FTRANS';
        GenJournalLine."Document No." := Rec.No;
        GenJournalLine."External Document No." := Rec."Bankers Cheque No";
        GenJournalLine."Line No." := LineNo;
        GenJournalLine."Account Type" := GenJournalLine."account type"::"Bank Account";
        GenJournalLine."Account No." := Rec."Cheque Clearing Bank Code";
        GenJournalLine.Validate(GenJournalLine."Account No.");
        GenJournalLine."Posting Date" := Rec."Transaction Date";
        GenJournalLine.Description := Rec.Payee;//"Account Name";
        GenJournalLine.Validate(GenJournalLine."Currency Code");
        GenJournalLine.Amount := -Rec.Amount;
        GenJournalLine.Validate(GenJournalLine.Amount);
        GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
        GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
        if GenJournalLine.Amount <> 0 then
            GenJournalLine.Insert;

        if Account.Get(Rec."Account No") then begin
            if Account."Staff Account" <> true then begin

                //Charges
                ObjCharges.Reset;
                ObjCharges.SetRange(ObjCharges."Charge Type", ObjCharges."charge type"::"Bankers Cheque Fee");
                if ObjCharges.Find('-') then begin
                    if ObjCharges."Use Percentage" = false then begin
                        VarChargeAmount := ObjCharges."Charge Amount";
                        VarChargeAccount := ObjCharges."GL Account"
                    end else
                        if ObjCharges."Use Percentage" = true then begin
                            VarChargeAmount := (ObjCharges."Percentage of Amount" / 100) * Rec.Amount;
                            VarChargeAccount := ObjCharges."GL Account"
                        end;

                    LineNo := LineNo + 10000;

                    GenJournalLine.Init;
                    GenJournalLine."Journal Template Name" := 'GENERAL';
                    GenJournalLine."Journal Batch Name" := 'FTRANS';
                    GenJournalLine."Document No." := Rec.No;
                    GenJournalLine."External Document No." := Rec."Bankers Cheque No";
                    GenJournalLine."Line No." := LineNo;
                    GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
                    GenJournalLine."Account No." := VarChargeAccount;
                    GenJournalLine.Validate(GenJournalLine."Account No.");
                    GenJournalLine."Posting Date" := Rec."Transaction Date";
                    GenJournalLine.Description := Format(Rec.Types) + ' Charge';
                    GenJournalLine.Validate(GenJournalLine."Currency Code");
                    GenJournalLine.Amount := VarChargeAmount * -1;
                    GenJournalLine.Validate(GenJournalLine.Amount);
                    GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                    GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                    GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                    if GenJournalLine.Amount <> 0 then
                        GenJournalLine.Insert;

                end;




                //Balancing Account
                //Charges
                ObjCharges.Reset;
                ObjCharges.SetRange(ObjCharges."Charge Type", ObjCharges."charge type"::"Bankers Cheque Fee");
                if ObjCharges.Find('-') then begin
                    if ObjCharges."Use Percentage" = false then begin
                        VarChargeAmount := ObjCharges."Charge Amount";
                        VarChargeAccount := ObjCharges."GL Account"
                    end else
                        if ObjCharges."Use Percentage" = true then begin
                            VarChargeAmount := (ObjCharges."Percentage of Amount" / 100) * Rec.Amount;
                            VarChargeAccount := ObjCharges."GL Account"
                        end;

                    LineNo := LineNo + 10000;

                    GenJournalLine.Init;
                    GenJournalLine."Journal Template Name" := 'GENERAL';
                    GenJournalLine."Journal Batch Name" := 'FTRANS';
                    GenJournalLine."Document No." := Rec.No;
                    GenJournalLine."External Document No." := Rec."Bankers Cheque No";
                    GenJournalLine."Line No." := LineNo;
                    GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                    GenJournalLine."Account No." := Rec."Account No";
                    GenJournalLine.Validate(GenJournalLine."Account No.");
                    GenJournalLine."Posting Date" := Rec."Transaction Date";
                    GenJournalLine.Description := Format(Rec.Types) + ' Charge';
                    GenJournalLine.Validate(GenJournalLine."Currency Code");
                    GenJournalLine.Amount := VarChargeAmount;
                    GenJournalLine.Validate(GenJournalLine.Amount);
                    //GenJournalLine."Bal. Account Type":=GenJournalLine."Bal. Account Type"::"Bank Account";
                    //GenJournalLine."Bal. Account No.":=ChBank;
                    //GenJournalLine.VALIDATE(GenJournalLine."Bal. Account No.");
                    GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                    GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                    if GenJournalLine.Amount <> 0 then
                        GenJournalLine.Insert;
                end;
            end;
        end;

        //Charge Overdraft Comission
        if Rec."Authorisation Requirement" = 'Over draft' then begin
            if (Rec."Over Draft Type" = Rec."over draft type"::AWD) and (Rec."Excempt Charge" <> true) then begin
                Charges.Reset;
                Charges.SetRange(Charges.Code, 'AWD');
                if Charges.Find('-') then begin
                    if Charges."Use Percentage" = true then begin
                        OverDraftCharge := Rec.Amount * (Charges."Percentage of Amount" / 100);
                        OverDraftChargeAcc := Charges."GL Account"
                    end else
                        OverDraftCharge := Charges."Charge Amount";
                    OverDraftChargeAcc := Charges."GL Account"
                end;

                LineNo := LineNo + 10000;

                GenJournalLine.Init;
                GenJournalLine."Journal Template Name" := 'GENERAL';
                GenJournalLine."Journal Batch Name" := 'FTRANS';
                GenJournalLine."Document No." := Rec.No;
                GenJournalLine."Line No." := LineNo;
                GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                GenJournalLine."Account No." := Rec."Account No";
                GenJournalLine.Validate(GenJournalLine."Account No.");
                GenJournalLine."Posting Date" := Rec."Transaction Date";
                GenJournalLine.Description := 'Commision on Overdraft';
                GenJournalLine.Validate(GenJournalLine."Currency Code");
                if AccountTypes.Get(Rec."Account Type") then begin
                    GenJournalLine.Amount := OverDraftCharge;
                end;
                GenJournalLine.Validate(GenJournalLine.Amount);
                GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                GenJournalLine."Bal. Account No." := OverDraftChargeAcc;
                GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                if GenJournalLine.Amount <> 0 then
                    GenJournalLine.Insert;
            end;
        end;


        //Charge Overdraft Comission
        if Rec."Authorisation Requirement" = 'Over draft' then begin
            if (Rec."Over Draft Type" = Rec."over draft type"::LWD) and (Rec."Excempt Charge" <> true) then begin
                Charges.Reset;
                Charges.SetRange(Charges.Code, 'OVERDRAFT');
                if Charges.Find('-') then begin
                    if Charges."Use Percentage" = true then begin
                        OverDraftCharge := Rec.Amount * (Charges."Percentage of Amount" / 100);
                        if LoanType.Get(Rec."LWD Loan Product") then
                            //OverDraftChargeAcc:=Charges."GL Account"
                            OverDraftChargeAcc := LoanType."Loan Interest Account"
                    end else
                        OverDraftCharge := Charges."Charge Amount";
                    if LoanType.Get(Rec."LWD Loan Product") then
                        //OverDraftChargeAcc:=Charges."GL Account"
                        OverDraftChargeAcc := LoanType."Loan Interest Account"
                end;

                LineNo := LineNo + 10000;

                GenJournalLine.Init;
                GenJournalLine."Journal Template Name" := 'GENERAL';
                GenJournalLine."Journal Batch Name" := 'FTRANS';
                GenJournalLine."Document No." := Rec.No;
                GenJournalLine."Line No." := LineNo;
                GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                GenJournalLine."Account No." := Rec."Account No";
                GenJournalLine.Validate(GenJournalLine."Account No.");
                GenJournalLine."Posting Date" := Rec."Transaction Date";
                GenJournalLine.Description := 'Commision on Overdraft';
                GenJournalLine.Validate(GenJournalLine."Currency Code");
                if AccountTypes.Get(Rec."Account Type") then begin
                    GenJournalLine.Amount := OverDraftCharge;
                end;
                GenJournalLine.Validate(GenJournalLine.Amount);
                GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                GenJournalLine."Bal. Account No." := OverDraftChargeAcc;
                GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                if GenJournalLine.Amount <> 0 then
                    GenJournalLine.Insert;
            end;
        end;

        GenSetup.Get();
        //Excise Duty
        ObjCharges.Reset;
        ObjCharges.SetRange(ObjCharges."Charge Type", ObjCharges."charge type"::"Bankers Cheque Fee");
        if ObjCharges.Find('-') then begin
            if ObjCharges."Use Percentage" = false then begin
                VarChargeAmountTax := ObjCharges."Charge Amount" * (GenSetup."Loan Excise Duty(%)" / 100);
                VarChargeTaxAccount := GenSetup."Excise Duty Account";
            end else
                if ObjCharges."Use Percentage" = true then begin
                    VarChargeAmount := (ObjCharges."Percentage of Amount" / 100) * Rec.Amount;
                    VarChargeAmountTax := VarChargeAmount * (GenSetup."Loan Excise Duty(%)" / 100);
                    VarChargeTaxAccount := GenSetup."Excise Duty Account";
                end;
            LineNo := LineNo + 10000;

            GenJournalLine.Init;
            GenJournalLine."Journal Template Name" := 'GENERAL';
            GenJournalLine."Journal Batch Name" := 'FTRANS';
            GenJournalLine."Document No." := Rec.No;
            GenJournalLine."External Document No." := Rec."Bankers Cheque No";
            GenJournalLine."Line No." := LineNo;
            GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
            GenJournalLine."Account No." := Rec."Account No";
            GenJournalLine.Validate(GenJournalLine."Account No.");
            GenJournalLine."Posting Date" := Rec."Transaction Date";
            GenJournalLine.Description := 'Excise Duty';
            GenJournalLine.Validate(GenJournalLine."Currency Code");
            GenJournalLine.Amount := VarChargeAmountTax;
            GenJournalLine.Validate(GenJournalLine.Amount);
            GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
            GenJournalLine."Bal. Account No." := VarChargeTaxAccount;
            GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
            GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
            GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
            if GenJournalLine.Amount <> 0 then
                GenJournalLine.Insert;
        end;


        //Post New
        GenJournalLine.Reset;
        GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
        GenJournalLine.SetRange("Journal Batch Name", 'FTRANS');
        if GenJournalLine.Find('-') then begin
            Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco", GenJournalLine);
        end;

        //Post New


        Rec."Transaction Available Balance" := AvailableBalance;
        Rec.Posted := true;
        Rec.Authorised := Rec.Authorised::Yes;

        Rec."Supervisor Checked" := true;
        Rec."Needs Approval" := Rec."needs approval"::No;
        Rec."Frequency Needs Approval" := Rec."frequency needs approval"::No;
        Rec."Date Posted" := Today;
        Rec."Time Posted" := Time;
        Rec."Posted By" := UserId;

        Rec.Modify;
        TillNo := '';
        TellerTill.Reset;
        TellerTill.SetRange(TellerTill."Account Type", TellerTill."account type"::Cashier);
        TellerTill.SetRange(TellerTill.CashierID, UserId);
        if TellerTill.Find('-') then begin

            Rec."Bank Used To Post" := TellerTill."No.";

            rec.Modify();

        end;
        /*IF CONFIRM('Are you sure you want to print this bankers cheque?',TRUE)=TRUE THEN BEGIN
        REPORT.RUN(,TRUE,TRUE,Trans)
        END;*/


        //Mark Cheque Book
        ChequeRegister.Reset;
        ChequeRegister.SetRange(ChequeRegister."Cheque No.", Rec."Bankers Cheque No");
        if ChequeRegister.Find('-') then begin
            ChequeRegister.Issued := true;
            ChequeRegister.Modify;
        end;

        Message('Cheque Withdrawal posted successfully.');

    end;

    local procedure FnShowFields()
    begin
        HasSpecialMandateVisible := false;
        TransactingAgentVisible := false;
        TransactingAgentNameVisible := false;
        ReceiptAllVisible := false;

        ObjAccountAgents.Reset;
        ObjAccountAgents.SetRange(ObjAccountAgents."Account No", Rec."Account No");
        if ObjAccountAgents.FindSet = true then begin
            HasSpecialMandateVisible := true;
            TransactingAgentVisible := true;
            TransactingAgentNameVisible := true;
        end;


        if Rec."Transaction Type" = 'RECEIPT' then begin
            ReceiptAllVisible := true;
        end;
    end;

    local procedure AllocatedAmountOnDeactivate()
    begin
        CurrPage.Update := true;
    end;

    local procedure FnRunInsurance(ObjRcptBuffer: Record Transactions; RunningBalance: Decimal): Decimal
    var
        AmountToDeduct: Decimal;
        ObjReceiptTransactions: Record "Receipt Allocation";
    begin
        if RunningBalance > 0 then begin
            LoanApp.Reset;
            LoanApp.SetCurrentkey(Source, "Issued Date", "Loan Product Type", "Client Code", "Staff No", "Employer Code");
            LoanApp.SetRange(LoanApp."Client Code", ObjRcptBuffer."Member No");
            LoanApp.SetFilter(LoanApp."Date filter", Datefilter);
            if LoanApp.Find('-') then begin
                repeat
                    LoanApp.CalcFields(LoanApp."Outstanding Insurance");
                    if LoanApp."Outstanding Insurance" > 0 then begin
                        if RunningBalance > 0 then begin
                            AmountToDeduct := 0;
                            AmountToDeduct := ROUND(LoanApp."Outstanding Insurance", 0.05, '>');
                            if RunningBalance <= AmountToDeduct then
                                AmountToDeduct := RunningBalance;
                            ObjReceiptTransactions.Init;
                            ObjReceiptTransactions."Document No" := ObjRcptBuffer.No;
                            ObjReceiptTransactions."Member No" := ObjRcptBuffer."Member No";
                            ObjReceiptTransactions."Account Type" := ObjReceiptTransactions."account type"::Member;
                            ObjReceiptTransactions."Account No" := ObjRcptBuffer."Member No";
                            ObjReceiptTransactions."Loan No." := LoanApp."Loan  No.";
                            ObjReceiptTransactions."Transaction Type" := ObjReceiptTransactions."transaction type"::"Loan Insurance Paid";
                            ObjReceiptTransactions."Global Dimension 1 Code" := 'BOSA';
                            ObjReceiptTransactions."Global Dimension 2 Code" := SURESTEPFactory.FnGetMemberBranch(ObjRcptBuffer."Member No");
                            ObjReceiptTransactions.Amount := AmountToDeduct;
                            if ObjReceiptTransactions.Amount > 0 then
                                ObjReceiptTransactions.Insert(true);
                            RunningBalance := RunningBalance - Abs(ObjReceiptTransactions.Amount);
                        end;
                    end;
                until LoanApp.Next = 0;
            end;
            exit(RunningBalance);
        end;
    end;

    local procedure FnRunInterest(ObjRcptBuffer: Record Transactions; RunningBalance: Decimal): Decimal
    var
        AmountToDeduct: Decimal;
        ObjReceiptTransactions: Record "Receipt Allocation";
    begin
        if RunningBalance > 0 then begin
            LoanApp.Reset;
            LoanApp.SetCurrentkey(Source, "Issued Date", "Loan Product Type", "Client Code", "Staff No", "Employer Code");
            LoanApp.SetRange(LoanApp."Client Code", ObjRcptBuffer."Member No");
            LoanApp.SetFilter(LoanApp."Date filter", Datefilter);
            if LoanApp.Find('-') then begin
                repeat
                    LoanApp.CalcFields(LoanApp."Outstanding Interest", LoanApp."Outstanding Balance");
                    if (LoanApp."Outstanding Balance" * LoanApp.Interest / 1200) > 0 then begin
                        if RunningBalance > 0 then begin
                            AmountToDeduct := 0;
                            AmountToDeduct := ROUND((LoanApp."Outstanding Balance" * LoanApp.Interest / 1200), 0.05, '>');
                            if RunningBalance <= AmountToDeduct then
                                AmountToDeduct := RunningBalance;
                            ObjReceiptTransactions.Init;
                            ObjReceiptTransactions."Document No" := ObjRcptBuffer.No;
                            ObjReceiptTransactions."Member No" := ObjRcptBuffer."Member No";
                            ObjReceiptTransactions."Account No" := ObjRcptBuffer."Member No";
                            ObjReceiptTransactions."Account Type" := ObjReceiptTransactions."account type"::Member;
                            ObjReceiptTransactions."Loan No." := LoanApp."Loan  No.";
                            ObjReceiptTransactions."Transaction Type" := ObjReceiptTransactions."transaction type"::"Interest Paid";
                            ObjReceiptTransactions."Global Dimension 1 Code" := 'BOSA';
                            ObjReceiptTransactions."Global Dimension 2 Code" := SURESTEPFactory.FnGetMemberBranch(ObjRcptBuffer."Member No");
                            ObjReceiptTransactions.Amount := AmountToDeduct;
                            if ObjReceiptTransactions.Amount > 0 then
                                ObjReceiptTransactions.Insert(true);
                            RunningBalance := RunningBalance - Abs(ObjReceiptTransactions.Amount);
                        end;
                    end;
                until LoanApp.Next = 0;
            end;
            exit(RunningBalance);
        end;
    end;

    local procedure FnRunLoanInsurance(ObjRcptBuffer: Record Transactions; RunningBalance: Decimal): Decimal
    var
        INSAmountToDeduct: Decimal;
        ObjReceiptTransactions: Record "Receipt Allocation";
    begin
        if RunningBalance > 0 then begin
            LoanApp.Reset;
            LoanApp.SetCurrentkey(Source, "Issued Date", "Loan Product Type", "Client Code", "Staff No", "Employer Code");
            LoanApp.SetRange(LoanApp."Client Code", ObjRcptBuffer."Member No");
            LoanApp.SetFilter(LoanApp."Date filter", Datefilter);
            if LoanApp.Find('-') then begin
                repeat
                    LoanApp.CalcFields(LoanApp."Outstanding Interest", LoanApp."Outstanding Balance");
                    if (LoanApp."Outstanding Balance") > 0 then begin
                        if RunningBalance > 0 then begin
                            ObjProductCharge.Reset;
                            ObjProductCharge.SetRange(ObjProductCharge."Product Code", LoanApp."Loan Product Type");
                            ObjProductCharge.SetRange(ObjProductCharge."Loan Charge Type", ObjProductCharge."loan charge type"::"Loan Insurance");
                            if ObjProductCharge.FindSet then begin
                                //MESSAGE('Insurance Perc. is %1',ObjProductCharge.Percentage);
                                INSAmountToDeduct := ROUND(((LoanApp."Approved Amount" * ObjProductCharge.Percentage / 100)), 0.05, '>');
                            end;
                            //INSAmountToDeduct:=0;

                            if RunningBalance <= INSAmountToDeduct then
                                INSAmountToDeduct := RunningBalance;
                            ObjReceiptTransactions.Init;
                            ObjReceiptTransactions."Document No" := ObjRcptBuffer.No;
                            ObjReceiptTransactions."Member No" := ObjRcptBuffer."Member No";
                            ObjReceiptTransactions."Account No" := ObjRcptBuffer."Member No";
                            ObjReceiptTransactions."Account Type" := ObjReceiptTransactions."account type"::Member;
                            ObjReceiptTransactions."Loan No." := LoanApp."Loan  No.";
                            ObjReceiptTransactions."Transaction Type" := ObjReceiptTransactions."transaction type"::"Loan Insurance Paid";
                            ObjReceiptTransactions."Global Dimension 1 Code" := 'BOSA';
                            ObjReceiptTransactions."Global Dimension 2 Code" := SURESTEPFactory.FnGetMemberBranch(ObjRcptBuffer."Member No");
                            ObjReceiptTransactions.Amount := INSAmountToDeduct;
                            if ObjReceiptTransactions.Amount > 0 then
                                ObjReceiptTransactions.Insert(true);
                            RunningBalance := RunningBalance - Abs(ObjReceiptTransactions.Amount);
                        end;
                    end;
                until LoanApp.Next = 0;
            end;
            exit(RunningBalance);
        end;
    end;

    local procedure FnRunPrinciple(ObjRcptBuffer: Record Transactions; RunningBalance: Decimal): Decimal
    var
        AmountToDeduct: Decimal;
        ObjReceiptTransactions: Record "Receipt Allocation";
        varTotalRepay: Decimal;
        varMultipleLoan: Decimal;
        varLRepayment: Decimal;
        PRpayment: Decimal;
        INSAmountToDeduct: Decimal;
    begin
        if RunningBalance > 0 then begin
            varTotalRepay := 0;
            varMultipleLoan := 0;

            LoanApp.Reset;
            LoanApp.SetCurrentkey(Source, "Issued Date", "Loan Product Type", "Client Code", "Staff No", "Employer Code");
            LoanApp.SetRange(LoanApp."Client Code", ObjRcptBuffer."Member No");
            LoanApp.SetFilter(LoanApp."Date filter", Datefilter);

            if LoanApp.Find('-') then begin
                repeat

                    if RunningBalance > 0 then begin
                        LoanApp.CalcFields(LoanApp."Outstanding Balance", "Oustanding Interest to Date");
                        if LoanApp."Outstanding Balance" > 0 then begin
                            varLRepayment := 0;
                            PRpayment := 0;
                            PRpayment := LoanApp."Oustanding Interest to Date";
                            VarMonthlyInt := (LoanApp."Outstanding Balance" * LoanApp.Interest / 1200);

                            ObjProductCharge.Reset;
                            ObjProductCharge.SetRange(ObjProductCharge."Product Code", LoanApp."Loan Product Type");
                            ObjProductCharge.SetRange(ObjProductCharge."Loan Charge Type", ObjProductCharge."loan charge type"::"Loan Insurance");
                            if ObjProductCharge.FindSet then begin
                                INSAmountToDeduct := ROUND(((LoanApp."Approved Amount" * ObjProductCharge.Percentage / 100)), 0.05, '>');
                            end;

                            varLRepayment := LoanApp.Repayment - (VarMonthlyInt + INSAmountToDeduct);
                            if LoanApp."Loan Product Type" = 'GUR' then
                                varLRepayment := LoanApp.Repayment;
                            if varLRepayment > 0 then begin
                                if varLRepayment > LoanApp."Outstanding Balance" then
                                    varLRepayment := LoanApp."Outstanding Balance";

                                if RunningBalance > 0 then begin
                                    if RunningBalance > varLRepayment then begin
                                        ObjReceiptTransactions.Amount := varLRepayment;
                                    end
                                    else
                                        ObjReceiptTransactions.Amount := RunningBalance;
                                end;
                                ObjReceiptTransactions.Init;
                                ObjReceiptTransactions."Document No" := ObjRcptBuffer.No;
                                ObjReceiptTransactions."Loan No." := LoanApp."Loan  No.";
                                ObjReceiptTransactions."Member No" := LoanApp."Client Code";
                                ObjReceiptTransactions."Account No" := ObjRcptBuffer."Member No";
                                ObjReceiptTransactions."Account Type" := ObjReceiptTransactions."account type"::Member;
                                ObjReceiptTransactions."Transaction Type" := ObjReceiptTransactions."transaction type"::Repayment;
                                ObjReceiptTransactions."Global Dimension 1 Code" := Format(LoanApp.Source);
                                ObjReceiptTransactions."Global Dimension 2 Code" := SURESTEPFactory.FnGetMemberBranch(ObjRcptBuffer."Member No");
                                if ObjReceiptTransactions.Amount > 0 then
                                    ObjReceiptTransactions.Insert(true);
                                RunningBalance := RunningBalance - Abs(ObjReceiptTransactions.Amount);
                            end;
                        end;
                    end;
                until LoanApp.Next = 0;
            end;
            exit(RunningBalance);
        end;
    end;

    local procedure FnRunEntranceFee(ObjRcptBuffer: Record Transactions; RunningBalance: Decimal): Decimal
    var
        AmountToDeduct: Decimal;
        ObjReceiptTransactions: Record "Receipt Allocation";
        varTotalRepay: Decimal;
        varMultipleLoan: Decimal;
        varLRepayment: Decimal;
        PRpayment: Decimal;
        ObjMember: Record "Members Register";
    begin
        if RunningBalance > 0 then begin
            GenSetup.Get();
            ObjMember.Reset;
            ObjMember.SetRange(ObjMember."No.", ObjRcptBuffer."Member No");
            ObjMember.SetFilter(ObjMember."Registration Date", '>%1', 20171017D); //To Ensure deduction is for New Members Only
            if ObjMember.Find('-') then begin
                ObjMember.CalcFields(ObjMember."Registration Fee Paid");
                if Abs(ObjMember."Registration Fee Paid") < 500 then begin
                    if ObjMember."Registration Date" <> 0D then begin

                        AmountToDeduct := 0;
                        AmountToDeduct := GenSetup."BOSA Registration Fee Amount" - Abs(ObjMember."Registration Fee Paid");
                        if RunningBalance <= AmountToDeduct then
                            AmountToDeduct := RunningBalance;
                        ObjReceiptTransactions.Init;
                        ObjReceiptTransactions."Document No" := ObjRcptBuffer.No;
                        ObjReceiptTransactions."Member No" := ObjRcptBuffer."Member No";
                        ObjReceiptTransactions."Account Type" := ObjReceiptTransactions."account type"::Member;
                        ObjReceiptTransactions."Account No" := ObjRcptBuffer."Member No";
                        ObjReceiptTransactions."Transaction Type" := ObjReceiptTransactions."transaction type"::"Registration Fee";
                        ObjReceiptTransactions."Global Dimension 1 Code" := 'BOSA';
                        ObjReceiptTransactions."Global Dimension 2 Code" := SURESTEPFactory.FnGetMemberBranch(ObjRcptBuffer."Member No");
                        ObjReceiptTransactions.Amount := AmountToDeduct;
                        if ObjReceiptTransactions.Amount <> 0 then
                            ObjReceiptTransactions.Insert(true);
                        RunningBalance := RunningBalance - Abs(ObjReceiptTransactions.Amount);
                    end;
                end;
            end;
            exit(RunningBalance);
        end;
    end;

    local procedure FnRunShareCapital(ObjRcptBuffer: Record Transactions; RunningBalance: Decimal): Decimal
    var
        AmountToDeduct: Decimal;
        ObjReceiptTransactions: Record "Receipt Allocation";
        varTotalRepay: Decimal;
        varMultipleLoan: Decimal;
        varLRepayment: Decimal;
        PRpayment: Decimal;
        ObjMember: Record "Members Register";
        SharesCap: Decimal;
        DIFF: Decimal;
    begin
        if RunningBalance > 0 then begin
            GenSetup.Get();
            ObjMember.Reset;
            ObjMember.SetRange(ObjMember."No.", ObjRcptBuffer."Member No");
            ObjMember.SetRange(ObjMember."Customer Type", ObjMember."customer type"::Member);
            if ObjMember.Find('-') then begin
                //REPEAT Deducted once unless otherwise advised
                ObjMember.CalcFields(ObjMember."Shares Retained");
                if ObjMember."Shares Retained" < GenSetup."Retained Shares" then begin
                    SharesCap := GenSetup."Retained Shares";
                    DIFF := SharesCap - ObjMember."Shares Retained";

                    if DIFF > 1 then begin
                        if RunningBalance > 0 then begin
                            AmountToDeduct := 0;
                            AmountToDeduct := DIFF;
                            if DIFF > 10000 then
                                AmountToDeduct := 10000;
                            if RunningBalance <= AmountToDeduct then
                                AmountToDeduct := RunningBalance;

                            ObjReceiptTransactions.Init;
                            ObjReceiptTransactions."Document No" := ObjRcptBuffer.No;
                            ObjReceiptTransactions."Account Type" := ObjReceiptTransactions."account type"::Member;
                            ObjReceiptTransactions."Member No" := ObjRcptBuffer."Member No";
                            ObjReceiptTransactions."Account No" := ObjRcptBuffer."Member No";
                            ObjReceiptTransactions."Transaction Type" := ObjReceiptTransactions."transaction type"::"Share Capital";
                            ObjReceiptTransactions."Global Dimension 1 Code" := 'BOSA';
                            ObjReceiptTransactions."Global Dimension 2 Code" := SURESTEPFactory.FnGetMemberBranch(ObjRcptBuffer."Member No");
                            ObjReceiptTransactions.Amount := AmountToDeduct;
                            if ObjReceiptTransactions.Amount <> 0 then
                                ObjReceiptTransactions.Insert(true);
                            RunningBalance := RunningBalance - Abs(ObjReceiptTransactions.Amount);
                        end;
                    end;
                end;
                //UNTIL RcptBufLines.NEXT=0;
            end;

            exit(RunningBalance);
        end;
    end;

    local procedure FnRunDepositContribution(ObjRcptBuffer: Record Transactions; RunningBalance: Decimal): Decimal
    var
        AmountToDeduct: Decimal;
        ObjReceiptTransactions: Record "Receipt Allocation";
        varTotalRepay: Decimal;
        varMultipleLoan: Decimal;
        varLRepayment: Decimal;
        PRpayment: Decimal;
        ObjMember: Record "Members Register";
        SharesCap: Decimal;
        DIFF: Decimal;
    begin
        if RunningBalance > 0 then begin
            ObjMember.Reset;
            ObjMember.SetRange(ObjMember."No.", ObjRcptBuffer."Member No");
            ObjMember.SetRange(ObjMember."Customer Type", ObjMember."customer type"::Member);
            if ObjMember.Find('-') then begin
                ObjMember."Monthly Contribution" := SURESTEPFactory.FnGetMemberMonthlyContributionDepositstier(ObjRcptBuffer."Member No");
                ObjMember.Modify;

                AmountToDeduct := 0;
                AmountToDeduct := ROUND(ObjMember."Monthly Contribution", 0.05, '>');
                if RunningBalance <= AmountToDeduct then
                    AmountToDeduct := RunningBalance;

                ObjReceiptTransactions.Init;
                ObjReceiptTransactions."Document No" := ObjRcptBuffer.No;
                ObjReceiptTransactions."Member No" := ObjRcptBuffer."Member No";
                ObjReceiptTransactions."Account No" := ObjRcptBuffer."Member No";
                ObjReceiptTransactions."Account Type" := ObjReceiptTransactions."account type"::Member;
                ObjReceiptTransactions."Transaction Type" := ObjReceiptTransactions."transaction type"::"Deposit Contribution";
                ObjReceiptTransactions."Global Dimension 1 Code" := 'BOSA';
                ObjReceiptTransactions."Global Dimension 2 Code" := SURESTEPFactory.FnGetMemberBranch(ObjRcptBuffer."Member No");
                ObjReceiptTransactions.Amount := AmountToDeduct;
                if ObjReceiptTransactions.Amount <> 0 then
                    ObjReceiptTransactions.Insert(true);
                RunningBalance := RunningBalance - Abs(ObjReceiptTransactions.Amount);
            end;

            exit(RunningBalance);
        end;
    end;

    local procedure FnRunInsuranceContribution(ObjRcptBuffer: Record Transactions; RunningBalance: Decimal): Decimal
    var
        AmountToDeduct: Decimal;
        ObjReceiptTransactions: Record "Receipt Allocation";
        varTotalRepay: Decimal;
        varMultipleLoan: Decimal;
        varLRepayment: Decimal;
        PRpayment: Decimal;
        ObjMember: Record "Members Register";
    begin
        GenSetup.Get();
        if RunningBalance > 0 then begin
            ObjMember.Reset;
            ObjMember.SetRange(ObjMember."No.", ObjRcptBuffer."Member No");
            if ObjMember.Find('-') then begin
                if ObjMember."Registration Date" <> 0D then begin
                    AmountToDeduct := 0;
                    AmountToDeduct := GenSetup."Benevolent Fund Contribution";
                    if RunningBalance <= AmountToDeduct then
                        AmountToDeduct := RunningBalance;
                    ObjReceiptTransactions.Init;
                    ObjReceiptTransactions."Document No" := ObjRcptBuffer.No;
                    ObjReceiptTransactions."Account Type" := ObjReceiptTransactions."account type"::Member;
                    ObjReceiptTransactions."Member No" := ObjRcptBuffer."Member No";
                    ObjReceiptTransactions."Account No" := ObjRcptBuffer."Member No";
                    ObjReceiptTransactions."Transaction Type" := ObjReceiptTransactions."transaction type"::"Loan Insurance Paid";
                    ObjReceiptTransactions."Global Dimension 1 Code" := 'BOSA';
                    ObjReceiptTransactions."Global Dimension 2 Code" := SURESTEPFactory.FnGetMemberBranch(ObjRcptBuffer."Member No");
                    ObjReceiptTransactions.Amount := AmountToDeduct;
                    if ObjReceiptTransactions.Amount <> 0 then
                        ObjReceiptTransactions.Insert(true);
                    RunningBalance := RunningBalance - Abs(ObjReceiptTransactions.Amount);
                end;
            end;
            exit(RunningBalance);
        end;
    end;

    local procedure FnRunBenevolentFund(ObjRcptBuffer: Record Transactions; RunningBalance: Decimal): Decimal
    var
        AmountToDeduct: Decimal;
        ObjReceiptTransactions: Record "Receipt Allocation";
        varTotalRepay: Decimal;
        varMultipleLoan: Decimal;
        varLRepayment: Decimal;
        PRpayment: Decimal;
        ObjMember: Record "Members Register";
    begin
        if RunningBalance > 0 then begin
            GenSetup.Get();
            ObjMember.Reset;
            ObjMember.SetRange(ObjMember."No.", ObjRcptBuffer."Member No");
            if ObjMember.Find('-') then begin
                if ObjMember."Registration Date" <> 0D then begin

                    AmountToDeduct := 0;
                    AmountToDeduct := GenSetup."Risk Fund Amount";
                    if RunningBalance <= AmountToDeduct then
                        AmountToDeduct := RunningBalance;
                    ObjReceiptTransactions.Init;
                    ObjReceiptTransactions."Document No" := ObjRcptBuffer.No;
                    ObjReceiptTransactions."Member No" := ObjRcptBuffer."Member No";
                    ObjReceiptTransactions."Account No" := ObjRcptBuffer."Member No";
                    ObjReceiptTransactions."Account Type" := ObjReceiptTransactions."account type"::Member;
                    ObjReceiptTransactions."Transaction Type" := ObjReceiptTransactions."transaction type"::" ";
                    ObjReceiptTransactions."Global Dimension 1 Code" := 'BOSA';
                    ObjReceiptTransactions."Global Dimension 2 Code" := SURESTEPFactory.FnGetMemberBranch(ObjRcptBuffer."Member No");
                    ObjReceiptTransactions.Amount := AmountToDeduct;
                    if ObjReceiptTransactions.Amount <> 0 then
                        ObjReceiptTransactions.Insert(true);
                    RunningBalance := RunningBalance - Abs(ObjReceiptTransactions.Amount);
                end;
            end;
            exit(RunningBalance);
        end;
    end;

    local procedure FnRunUnallocatedAmount(ObjRcptBuffer: Record Transactions; RunningBalance: Decimal): Decimal
    var
        AmountToDeduct: Decimal;
        ObjReceiptTransactions: Record "Receipt Allocation";
        varTotalRepay: Decimal;
        varMultipleLoan: Decimal;
        varLRepayment: Decimal;
        PRpayment: Decimal;
        ObjMember: Record "Members Register";
    begin
        ObjMember.Reset;
        ObjMember.SetRange(ObjMember."No.", ObjRcptBuffer."Member No");
        if ObjMember.Find('-') then begin
            begin
                AmountToDeduct := 0;
                AmountToDeduct := RunningBalance;
                ObjReceiptTransactions.Init;
                ObjReceiptTransactions."Document No" := ObjRcptBuffer.No;
                ObjReceiptTransactions."Member No" := ObjRcptBuffer."Member No";
                ObjReceiptTransactions."Account No" := ObjRcptBuffer."Member No";
                ObjReceiptTransactions."Account Type" := ObjReceiptTransactions."account type"::Member;
                ObjReceiptTransactions."Transaction Type" := ObjReceiptTransactions."transaction type"::" ";
                ObjReceiptTransactions."Global Dimension 1 Code" := 'BOSA';
                ObjReceiptTransactions."Global Dimension 2 Code" := SURESTEPFactory.FnGetMemberBranch(ObjRcptBuffer."Member No");
                ObjReceiptTransactions.Amount := AmountToDeduct;
                if ObjReceiptTransactions.Amount <> 0 then
                    ObjReceiptTransactions.Insert(true);
            end;
        end;
    end;

    local procedure FnRunDepositContributionFromExcess(ObjRcptBuffer: Record Transactions; RunningBalance: Decimal): Decimal
    var
        AmountToDeduct: Decimal;
        ObjReceiptTransactions: Record "Receipt Allocation";
        varTotalRepay: Decimal;
        varMultipleLoan: Decimal;
        varLRepayment: Decimal;
        PRpayment: Decimal;
        ObjMember: Record "Members Register";
        SharesCap: Decimal;
        DIFF: Decimal;
        TransType: Option " ","Registration Fee","Share Capital","Interest Paid","Loan Repayment","Deposit Contribution","Insurance Contribution","Benevolent Fund",Loan,"Unallocated Funds",Dividend,"FOSA Account";
    begin

        ObjMember.Reset;
        ObjMember.SetRange(ObjMember."No.", ObjRcptBuffer."Member No");
        ObjMember.SetRange(ObjMember."Customer Type", ObjMember."customer type"::Member);
        if ObjMember.Find('-') then begin
            AmountToDeduct := 0;
            AmountToDeduct := RunningBalance + FnReturnAmountToClear(Transtype::"Deposit Contribution");
            ObjReceiptTransactions.Init;
            ObjReceiptTransactions."Document No" := ObjRcptBuffer.No;
            ObjReceiptTransactions."Member No" := ObjRcptBuffer."Member No";
            ObjReceiptTransactions."Account No" := ObjRcptBuffer."Member No";
            ObjReceiptTransactions."Account Type" := ObjReceiptTransactions."account type"::Member;
            ObjReceiptTransactions."Transaction Type" := ObjReceiptTransactions."transaction type"::"Deposit Contribution";
            ObjReceiptTransactions."Global Dimension 1 Code" := 'BOSA';
            ObjReceiptTransactions."Global Dimension 2 Code" := SURESTEPFactory.FnGetMemberBranch(ObjRcptBuffer."Member No");
            ObjReceiptTransactions.Amount := AmountToDeduct;
            if ObjReceiptTransactions.Amount <> 0 then
                ObjReceiptTransactions.Insert(true);
        end;
    end;

    local procedure FnReturnAmountToClear(TransType: Option " ","Registration Fee","Share Capital","Interest Paid","Loan Repayment","Deposit Contribution","Insurance Contribution","Benevolent Fund",Loan,"Unallocated Funds",Dividend,"FOSA Account") AmountReturned: Decimal
    var
        ObjReceiptAllocation: Record "Receipt Allocation";
    begin
        ObjReceiptAllocation.Reset;
        ObjReceiptAllocation.SetRange("Document No", Rec.No);
        ObjReceiptAllocation.SetRange("Transaction Type", TransType);
        if ObjReceiptAllocation.Find('-') then begin
            AmountReturned := ObjReceiptAllocation.Amount;
            ObjReceiptAllocation.Delete;
        end;
        exit;
    end;

    local procedure FnRunSavingsProductExcess(ObjRcptBuffer: Record Transactions; RunningBalance: Decimal; SavingsProduct: Code[100]): Decimal
    var
        AmountToDeduct: Decimal;
        ObjReceiptTransactions: Record "Receipt Allocation";
        varTotalRepay: Decimal;
        varMultipleLoan: Decimal;
        varLRepayment: Decimal;
        PRpayment: Decimal;
        ObjMember: Record "Members Register";
        SharesCap: Decimal;
        DIFF: Decimal;
        TransType: Option " ","Registration Fee","Share Capital","Interest Paid","Loan Repayment","Deposit Contribution","Insurance Contribution","Benevolent Fund",Loan,"Unallocated Funds",Dividend,"FOSA Account";
    begin

        ObjMember.Reset;
        ObjMember.SetRange(ObjMember."No.", ObjRcptBuffer."Account No.");
        ObjMember.SetRange(ObjMember."Customer Type", ObjMember."customer type"::Member);
        if ObjMember.Find('-') then begin
            AmountToDeduct := 0;
            AmountToDeduct := RunningBalance + FnReturnAmountToClear(Transtype::"FOSA Account");
            ObjReceiptTransactions.Init;
            ObjReceiptTransactions."Document No" := ObjRcptBuffer.No;
            ObjReceiptTransactions."Member No" := ObjRcptBuffer."Account No.";
            ObjReceiptTransactions."Account No" := SavingsProduct;
            ObjReceiptTransactions.Validate(ObjReceiptTransactions."Account No");
            ObjReceiptTransactions."Transaction Type" := ObjReceiptTransactions."transaction type"::" ";
            ObjReceiptTransactions."Global Dimension 1 Code" := 'FOSA';
            ObjReceiptTransactions."Global Dimension 2 Code" := SURESTEPFactory.FnGetMemberBranch(ObjRcptBuffer."Account No.");
            ObjReceiptTransactions.Amount := AmountToDeduct;
            if ObjReceiptTransactions.Amount <> 0 then
                ObjReceiptTransactions.Insert(true);
        end;
    end;


    local procedure FnSendCLientSMS(CLientCode: Code[20]; Types: text[200]; Amount: Decimal)
    var
        Cust: Record Customer;
        Sms: Record "SMS Messages";
        smsManagement: Codeunit "Sms Management";
        CreationMessage: text[1000];
        Source: Option NEW_MEMBER,NEW_ACCOUNT,LOAN_ACCOUNT_APPROVAL,DEPOSIT_CONFIRMATION,CASH_WITHDRAWAL_CONFIRM,LOAN_APPLICATION,LOAN_APPRAISAL,LOAN_GUARANTORS,LOAN_REJECTED,LOAN_POSTED,LOAN_DEFAULTED,SALARY_PROCESSING,TELLER_CASH_DEPOSIT,TELLER_CASH_WITHDRAWAL,TELLER_CHEQUE_DEPOSIT,FIXED_DEPOSIT_MATURITY,INTERACCOUNT_TRANSFER,ACCOUNT_STATUS,STATUS_ORDER,EFT_EFFECTED,ATM_APPLICATION_FAILED,ATM_COLLECTION,MBANKING,MEMBER_CHANGES,CASHIER_BELOW_LIMIT,CASHIER_ABOVE_LIMIT,INTERNETBANKING,CRM,MOBILE_PIN;
    begin

        Cust.Reset();
        Cust.SetRange(Cust."No.", CLientCode);
        Cust.SetFilter(Cust."Mobile Phone No", '<>%1', '');
        if Cust.FindFirst() then begin
            CreationMessage := 'Dear ' + Cust."First Name" + ', ' + 'Your' + ' ' + LowerCase(Types) + ' of Ksh:' + Format(Amount) + ' has been processed on ' + format(Today) + ' at ' + Format(Time) + ' RefNo: ' + Rec.No;
            //smsManagement.SendSmsResponse(Cust."Mobile Phone No", CreationMessage);
            if VarTransactionType = VarTransactionType::"Cash Withdrawal" then begin
                smsManagement.SendSmsWithID(Source::CASH_WITHDRAWAL_CONFIRM, Cust."Mobile Phone No", CreationMessage, Cust."FOSA Account No.", Cust."FOSA Account No.", TRUE, 210, TRUE, 'CBS', CreateGuid(), 'CBS');
            end
            else
                if VarTransactionType = VarTransactionType::"Cash Deposit" then begin
                    smsManagement.SendSmsWithID(Source::DEPOSIT_CONFIRMATION, Cust."Mobile Phone No", CreationMessage, Cust."FOSA Account No.", Cust."FOSA Account No.", TRUE, 210, TRUE, 'CBS', CreateGuid(), 'CBS');
                end else
                    if VarTransactionType = VarTransactionType::"Cheque Deposit" then begin
                        smsManagement.SendSmsWithID(Source::TELLER_CHEQUE_DEPOSIT, Cust."Mobile Phone No", CreationMessage, Cust."FOSA Account No.", Cust."FOSA Account No.", TRUE, 210, TRUE, 'CBS', CreateGuid(), 'CBS');
                    end;
        end;
    end;


    // local procedure SetControlAppearance()
    // var
    //     ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    // begin
    //     OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Rec.RecordId);
    //     OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
    //     CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(Rec.RecordId);
    //     if rec. = rec.::Open then begin
    //         canSendApproval := True;
    //         canCreate := false;
    //     end
    //     else if Rec. = Rec.::Approved then begin
    //         canSendApproval := false;
    //         canCreate := true;
    //     end
    //     else begin
    //         canSendApproval := false;
    //         canCreate := false
    //     end;
    // end;
}




