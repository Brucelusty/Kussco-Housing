codeunit 50080 "Post New ATM Transactions"
{
    var
        GenJournalLine: Record "Gen. Journal Line";
        ATMTrans: Record "ATM Transactions";
        LineNo: Integer;
        Acct: Record Vendor;
        ATMCharges: Decimal;
        BankCharges: Decimal;
        ExciseGLAcc: Code[20];
        ExciseFee: Decimal;
        GenBatches: Record "Gen. Journal Batch";
        GLPosting: Codeunit "Gen. Jnl.-Post Line";
        ATM_CHARGES: Record "ATM Charges";
        DocNo: Code[20];
        BankAccount: Code[20];
        GLAccount: Code[20];
        Reversals2: Record "ATM Transactions";
        iEntryNo: Integer;
        SMSMessage: Record "SMS Messages";
        Vend1: Record Vendor;
        VendL: Record "Vendor Ledger Entry";
        Pos: Record "POS Commissions";
        AccountCharges: Decimal;
        SFactory: Codeunit "Au Factory";
        GenSetUp: Record "Sacco General Set-Up";
        ATMMessages: Text;
        BATCH_TEMPLATE: Code[100];
        BATCH_NAME: Code[100];
        DOCUMENT_NO: Code[100];
        Vendor: Record Vendor;
        AccountTypes: Record "Account Types-Saving Products";
        miniBalance: Decimal;
        acctFrozen: Code[10];
        ProdID: Code[10];
        DormantAccount: Code[10];
        accountBal: Decimal;
        closureDate: Date;
        ProductAppSignatories: Record "Product App Signatories";
        "Count": Integer;
        atmNos: Record "ATM Card Nos Buffer";
        processed: Boolean;
        Pesalink: Record "Pesalink Commisions";
        time_processed: Time;
        ExiceBank: Decimal;
        ExiceSacco: Decimal;
        varTranschannel: Code[100];
        Channel: Code[100];
        Reversal3: Record "ATM Transactions";
        Reversal2: Record "ATM Transactions";
        AtmLog: Record "ATM Log Entries3";
        SaccoCharge: Decimal;

    trigger OnRun()
    begin

    end;



    procedure PostTrans(referenceNo: Code[50]): Boolean
    begin
        BATCH_TEMPLATE := 'GENERAL';
        BATCH_NAME := 'ATMTRANS';
        processed := FALSE;
        GenJournalLine.RESET;
        GenJournalLine.SETRANGE("Journal Template Name", BATCH_TEMPLATE);
        GenJournalLine.SETRANGE("Journal Batch Name", BATCH_NAME);
        GenJournalLine.DELETEALL;
        //end of deletion

        GenBatches.RESET;
        GenBatches.SETRANGE(GenBatches."Journal Template Name", BATCH_TEMPLATE);
        GenBatches.SETRANGE(GenBatches.Name, BATCH_NAME);
        IF GenBatches.FIND('-') = FALSE THEN BEGIN
            GenBatches.INIT;
            GenBatches."Journal Template Name" := BATCH_TEMPLATE;
            GenBatches.Name := BATCH_NAME;
            GenBatches.Description := 'ATM Transactions';
            GenBatches.VALIDATE(GenBatches."Journal Template Name");
            GenBatches.VALIDATE(GenBatches.Name);
            GenBatches.INSERT;
        END;

        ATMTrans.LOCKTABLE;
        ATMTrans.RESET;
        ATMTrans.SETRANGE(ATMTrans."Reference No", referenceNo);
        ATMTrans.SETRANGE(ATMTrans.Posted, FALSE);
        IF ATMTrans.FIND('-') THEN BEGIN
            //REPEAT
            IF (STRLEN(ATMTrans."Reference No")) > 16 THEN
                DOCUMENT_NO := COPYSTR(ATMTrans."Reference No", 1, 12)
            ELSE
                DOCUMENT_NO := ATMTrans."Reference No";


            //BankAccount:='B0022';
            //GLAccount:=  '400313';
            ExciseGLAcc := '300201';

            ATMCharges := 0;
            BankCharges := 0;
            ExciseFee := 0;

            ATM_CHARGES.RESET;
            ATM_CHARGES.SETRANGE(ATM_CHARGES.Channel, COPYSTR(ATMTrans."Card Acceptor Terminal ID", 1, 3));
            ATM_CHARGES.SETRANGE(ATM_CHARGES.Code, ATMTrans."Transaction Type");
            IF (ATM_CHARGES.FIND('-')) THEN BEGIN
                ATMCharges := ATM_CHARGES."Total Amount";
                SaccoCharge := ATM_CHARGES."Sacco Amount";
                ExiceSacco := (SaccoCharge) * 0.2;
                BankCharges := ATMCharges - (SaccoCharge + ExiceSacco);
                ExciseFee := 0;// ATMCharges * 0.2;
                ExciseGLAcc := ATM_CHARGES."Excise Duty";
                BankAccount := ATM_CHARGES."Atm Bank Settlement A/C";
                GLAccount := ATM_CHARGES."Atm Income A/c";
                ExiceBank := 0;// ((BankCharges) * -1) * 0.2;

            END ELSE BEGIN
                ATM_CHARGES.RESET;
                ATM_CHARGES.SETRANGE(ATM_CHARGES."Transaction Type", ATMTrans."Transaction Type Charges");
                IF (ATM_CHARGES.FIND('-')) THEN BEGIN
                    ATMCharges := ATM_CHARGES."Total Amount";
                    SaccoCharge := ATM_CHARGES."Sacco Amount";
                    ExiceSacco := (SaccoCharge) * 0.2;
                    BankCharges := ATMCharges - (SaccoCharge + ExiceSacco);
                    ExciseFee := 0;// ATMCharges * 0.2;
                    ExciseGLAcc := ATM_CHARGES."Excise Duty";
                    BankAccount := ATM_CHARGES."Atm Bank Settlement A/C";
                    GLAccount := ATM_CHARGES."Atm Income A/c";
                    ExiceBank := 0;// ((BankCharges) * -1) * 0.2;
                END;
            END;



            //**************************IF REVERSAL, THEN REVERSE THE SIGN*******************************
            IF ATMTrans."Transaction Type" = '1420' THEN BEGIN
                Reversals2.RESET;
                Reversals2.SETRANGE(Reversals2."Trace ID", ATMTrans."Reversal Trace ID");
                Reversals2.SETRANGE(Reversals2."Account No", ATMTrans."Account No");
                Reversals2.SETRANGE(Reversals2.Reversed, FALSE);
                IF (Reversals2.FIND('-')) THEN BEGIN
                    ATM_CHARGES.RESET;
                    ATM_CHARGES.SETRANGE(ATM_CHARGES.Channel, COPYSTR(Reversals2."Card Acceptor Terminal ID", 1, 3));
                    ATM_CHARGES.SETRANGE(ATM_CHARGES.Code, Reversals2."Transaction Type");
                    IF (ATM_CHARGES.FIND('-')) THEN BEGIN
                        ATMCharges := ATM_CHARGES."Total Amount" * -1;
                        SaccoCharge := ATM_CHARGES."Sacco Amount" * -1;
                        ExiceSacco := (SaccoCharge) * -0.2;
                        BankCharges := (ATMCharges - (SaccoCharge + ExiceSacco)) * -1;
                        ExciseFee := 0;// ATMCharges * 0.2;
                        ExciseGLAcc := ATM_CHARGES."Excise Duty";
                        BankAccount := ATM_CHARGES."Atm Bank Settlement A/C";
                        GLAccount := ATM_CHARGES."Atm Income A/c";
                        ExiceBank := 0;// ((BankCharges) * -1) * 0.2;

                    END ELSE BEGIN
                        ATM_CHARGES.RESET;
                        ATM_CHARGES.SETRANGE(ATM_CHARGES."Transaction Type", Reversals2."Transaction Type Charges");
                        IF (ATM_CHARGES.FIND('-')) THEN BEGIN
                            ATMCharges := ATM_CHARGES."Total Amount" * -1;
                            SaccoCharge := ATM_CHARGES."Sacco Amount" * -1;
                            ExiceSacco := (SaccoCharge) * 0.2 * -1;
                            BankCharges := (ATMCharges - (SaccoCharge + ExiceSacco)) * -1;
                            ExciseFee := 0;// ATMCharges * 0.2;
                            ExciseGLAcc := ATM_CHARGES."Excise Duty";
                            BankAccount := ATM_CHARGES."Atm Bank Settlement A/C";
                            GLAccount := ATM_CHARGES."Atm Income A/c";
                            ExiceBank := 0;// ((BankCharges) * -1) * 0.2;
                        END;
                    END;

                    IF ((COPYSTR(Reversals2.Channel, 1, 5) = 'POSAG') OR (COPYSTR(Reversals2.Channel, 1, 5) = 'POSBR')) AND (Reversals2."Transaction Type" = '0011') THEN BEGIN
                        Pos.RESET;
                        Pos.SETFILTER(Pos."Lower Limit", '<=%1', Reversals2.Amount);
                        Pos.SETFILTER(Pos."Upper Limit", '>=%1', Reversals2.Amount);
                        IF Pos.FINDFIRST THEN BEGIN
                            ATMCharges := Pos."Charge Amount" * -1;
                            BankCharges := Pos."Bank charge" * -1;
                            ExiceSacco := Pos."Sacco charge" * 0.2 * -1;
                            SaccoCharge := Pos."Sacco charge" * -1;
                            ExiceBank := 0;// (((BankCharges) * -1) * 0.2) + ((ATMCharges - BankCharges) * -1) * 0.2;
                        END;
                    END;
                    IF (Reversals2."Transaction Type" = '0009') THEN BEGIN
                        Pesalink.RESET;
                        Pesalink.SETFILTER(Pesalink."Lower Limit", '<=%1', Reversals2.Amount);
                        Pesalink.SETFILTER(Pesalink."Upper Limit", '>=%1', Reversals2.Amount);
                        IF Pesalink.FINDFIRST THEN BEGIN
                            ATMCharges := Pesalink."Charge Amount" * -1;
                            BankCharges := Pesalink."Bank charge" * -1;
                            ExiceSacco := Pesalink."Sacco charge" * 0.2 * -1;
                            SaccoCharge := Pesalink."Sacco charge" * -1;
                            ExiceBank := 0;// ((BankCharges) * -1) * 0.2;
                            ExciseGLAcc := ATM_CHARGES."Excise Duty";

                        END;
                    END;
                    ATMTrans.Amount := Reversals2.Amount * -1;
                END;
                Reversals2.RESET;
                Reversals2.SETRANGE(Reversals2."Trace ID", ATMTrans."Reversal Trace ID");
                Reversals2.SETRANGE(Reversals2."Account No", ATMTrans."Account No");
                Reversals2.SETRANGE(Reversals2.Reversed, TRUE);
                IF (Reversals2.FIND('-')) THEN BEGIN
                    ATMTrans.Posted := TRUE;
                    ATMTrans.Reversed := TRUE;
                    ATMTrans."Reversed Posted" := TRUE;
                    ATMTrans.MODIFY;
                    EXIT;
                END;


            END;

            IF ((COPYSTR(ATMTrans.Channel, 1, 5) = 'POSAG') OR (COPYSTR(ATMTrans.Channel, 1, 5) = 'POSMR') OR (COPYSTR(ATMTrans.Channel, 1, 5) = 'POSBR')) AND (ATMTrans."Transaction Type" = '0011') THEN BEGIN
                Pos.RESET;
                Pos.SETFILTER(Pos."Lower Limit", '<=%1', ATMTrans.Amount);
                Pos.SETFILTER(Pos."Upper Limit", '>=%1', ATMTrans.Amount);
                IF Pos.FINDFIRST THEN BEGIN
                    ATMCharges := Pos."Charge Amount";
                    BankCharges := Pos."Bank charge";
                    ExiceSacco := Pos."Sacco charge" * 0.2;
                    SaccoCharge := Pos."Sacco charge";
                    ExiceBank := 0;// (((BankCharges) * -1) * 0.2) + ((ATMCharges - BankCharges) * -1) * 0.2;
                END;
            END;

            IF (ATMTrans."Transaction Type" = '0009') THEN BEGIN
                Pesalink.RESET;
                Pesalink.SETFILTER(Pesalink."Lower Limit", '<=%1', ATMTrans.Amount);
                Pesalink.SETFILTER(Pesalink."Upper Limit", '>=%1', ATMTrans.Amount);
                IF Pesalink.FINDFIRST THEN BEGIN
                    ATMCharges := Pesalink."Charge Amount";
                    BankCharges := Pesalink."Bank charge";
                    ExiceSacco := Pesalink."Sacco charge" * 0.2;
                    SaccoCharge := Pesalink."Sacco charge";
                    ExiceBank := 0;// ((BankCharges) * -1) * 0.2;
                    ExciseGLAcc := ATM_CHARGES."Excise Duty";
                END;
            END;


            IF Acct.GET(ATMTrans."Account No") THEN BEGIN

                //-----------------------1. Debit FOSA A/C(Amount Transacted)---------------------------------------------------------------------------
                LineNo := LineNo + 10000;
                SFactory.FnCreateGnlJournalLineAtm(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                GenJournalLine."Account Type"::Vendor, ATMTrans."Account No", ATMTrans."Posting Date", ATMTrans.Amount, 'FOSA', '',
                FORMAT(ATMTrans."Transaction Type Charges"), '', COPYSTR(DOCUMENT_NO, 1, 10));

                //-----------------------2. Credit Bank(Amount Transacted)--------------------------------------------------------------------------------
                LineNo := LineNo + 10000;
                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                GenJournalLine."Account Type"::"Bank Account", BankAccount, ATMTrans."Posting Date", ATMTrans.Amount * -1, 'FOSA', ATMTrans."Account No", Acct.Name, '', GenJournalLine."Transaction Type"::" ");

                //-----------------------3. Debit FOSA (Transaction Charge)--------------------------------------------------------------------------------
                LineNo := LineNo + 10000;
                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                GenJournalLine."Account Type"::Vendor, ATMTrans."Account No", ATMTrans."Posting Date", ATMCharges, 'FOSA', '', FORMAT(ATMTrans."Transaction Type Charges") + ' Charges', '', GenJournalLine."Transaction Type"::" ");

                //-----------------------4. Debit FOSA (10% Excise Duty sacco)------------------------------------------------------------------------------------
                //LineNo := LineNo + 10000;
                //SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                //GenJournalLine."Account Type"::Vendor, ATMTrans."Account No", ATMTrans."Posting Date", (ExiceSacco), 'FOSA', '', FORMAT(ATMTrans."Transaction Type Charges") + ' Excise Duty Charges', '', GenJournalLine."Transaction Type"::" ");

                //-----------------------5. Credit Excise G/L(10% Excise Duty sacco)------------------------------------------------------------------------------------    
                LineNo := LineNo + 10000;
                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                GenJournalLine."Account Type"::"G/L Account", ExciseGLAcc, ATMTrans."Posting Date", ExiceSacco * -1, 'FOSA', ATMTrans."Account No", Acct.Name + '-Excise', '', GenJournalLine."Transaction Type"::" ");
                //-----------------------5. Credit Excise G/L(10% Excise Duty bank)------------------------------------------------------------------------------------
                LineNo := LineNo + 10000;
                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                GenJournalLine."Account Type"::"Bank Account", BankAccount, ATMTrans."Posting Date", ExiceBank, 'FOSA', ATMTrans."Account No", Acct.Name + '-Excise', '', GenJournalLine."Transaction Type"::" ");

                //-----------------------6. Credit Bank(Bank Charges)------------------------------------------------------------------------------------
                LineNo := LineNo + 10000;
                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                GenJournalLine."Account Type"::"Bank Account", BankAccount, ATMTrans."Posting Date", BankCharges * -1, 'FOSA', ATMTrans."Account No", FORMAT(ATMTrans."Transaction Type Charges") + ' Charges', '', GenJournalLine."Transaction Type"::" ");

                //-----------------------7. Credit Settlement G/L(Sacco Charges)------------------------------------------------------------------------------------
                LineNo := LineNo + 10000;
                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                GenJournalLine."Account Type"::"G/L Account", GLAccount, ATMTrans."Posting Date", (SaccoCharge) * -1, 'FOSA', ATMTrans."Account No", FORMAT(ATMTrans."Transaction Type Charges"), '', GenJournalLine."Transaction Type"::" ");

                //-----------------------8. Charge  &Earn SMS Fee (From Sacco General Setup)------------------------------------------------------------------------------------
                GenSetUp.GET();
                IF ((GenSetUp."SMS Fee Account" <> '') AND (GenSetUp."SMS Fee Amount" > 0)) THEN BEGIN
                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                    GenJournalLine."Account Type"::Vendor, ATMTrans."Account No", ATMTrans."Posting Date", GenSetUp."SMS Fee Amount", 'FOSA', '', FORMAT(ATMTrans."Transaction Type Charges") + ' SMS Charge', '', GenJournalLine."Transaction Type"::" ");

                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                    GenJournalLine."Account Type"::"G/L Account", GenSetUp."SMS Fee Account", ATMTrans."Posting Date", GenSetUp."SMS Fee Amount" * -1, 'FOSA', ATMTrans."Account No", FORMAT(ATMTrans."Transaction Type Charges") + ' SMS Charge', '', GenJournalLine."Transaction Type"::" ");
                END;


                // ATMTrans.Reversed:=TRUE;
                // ATMTrans."Reversed Posted":=TRUE;
            END;


            IF ATMTrans."Transaction Type" = '1420' THEN BEGIN
                ATMTrans.Reversed := TRUE;
                ATMTrans."Reversed Posted" := TRUE;
            END;
            ATMTrans.Posted := TRUE;
            ATMTrans.MODIFY;
            processed := TRUE;
            time_processed := DT2TIME(CURRENTDATETIME);
            GenSetUp.GET();

        END ELSE BEGIN
            //ERROR('%1','Account No. %1 not found.',ATMTrans."Account No");
        END;

        GenJournalLine.RESET;
        GenJournalLine.SETRANGE("Journal Template Name", BATCH_TEMPLATE);
        GenJournalLine.SETRANGE("Journal Batch Name", BATCH_NAME);
        IF GenJournalLine.FIND('-') THEN BEGIN
            REPEAT
                GLPosting.RUN(GenJournalLine);
            UNTIL GenJournalLine.NEXT = 0;

            processed := TRUE;
            //-----------------------------Send SMS---------------------------------------------------------------
            // IF GenSetUp."Send Membership Reg SMS"=TRUE THEN BEGIN  

            IF ATMTrans.Amount <> 0 THEN BEGIN

                IF ATMTrans."Transaction Type" <> '1420' THEN
                    ATMMessages := 'Dear ' + SplitString(ATMTrans."Customer Names", ' ') + ' You have done ' + FORMAT(ATMTrans."Transaction Type Charges") + ' of KSHs.' + FORMAT(ABS(ATMTrans.Amount)) + ' from A/C: ' + ATMTrans."Account No" + ' on '
                   + FORMAT(ATMTrans."Transaction Date") + ' ' + FORMAT(ATMTrans."Transaction Time");

                IF ATMTrans."Transaction Type" = '1420' THEN
                    ATMMessages := 'Dear ' + SplitString(ATMTrans."Customer Names", ' ') + ' Your ' + FORMAT(Reversals2."Transaction Type Charges") + ' of KSHs.' + FORMAT(ABS(Reversals2.Amount)) + ' from A/C: ' + Reversals2."Account No" + ' on '
                    + FORMAT(Reversals2."Transaction Date") + ' ' + FORMAT(Reversals2."Transaction Time") + ' has been reversed successfully.';

                SFactory.FnSendSMS('ATMTRANS', ATMMessages, ATMTrans."Account No", Acct."Phone No.");

            END;
            // END;
        END;


        GenJournalLine.RESET;
        GenJournalLine.SETRANGE("Journal Template Name", BATCH_TEMPLATE);
        GenJournalLine.SETRANGE("Journal Batch Name", BATCH_NAME);
        GenJournalLine.DELETEALL;
        //END;

        EXIT(processed);
    end;

    procedure SplitString(sText: Text; separator: Text) Token: Text
    var
        Pos: Integer;
    begin
        Pos := STRPOS(sText, separator);
        IF Pos > 0 THEN BEGIN
            Token := COPYSTR(sText, 1, Pos - 1);
            IF Pos + 1 <= STRLEN(sText) THEN
                sText := COPYSTR(sText, Pos + 1)
            ELSE
                sText := '';
        END ELSE BEGIN
            Token := sText;
            sText := '';
        END;

    end;


    procedure fnTotalUnposted() unposted: Integer
    begin
        ATMTrans.LOCKTABLE;
        ATMTrans.RESET;
        ATMTrans.SETFILTER(ATMTrans.Posted, '%1', FALSE);
        IF ATMTrans.FIND('-') THEN BEGIN
            unposted := ATMTrans.COUNT;
        END;
        EXIT(unposted);
    end;

    procedure InsertAtmtransaction(messageType: Text[50]; accountID: Code[50]; mobile: Code[20]; authCode: Text; amount: Decimal; reference: Code[250]; terminalID: Code[50]; terminalLocation: Code[50]; requestDate: Date; responseCode: Code[10]; posted: Boolean; reversalTraceID: Code[250];
    "atm No": Code[100]; narration1: Text; narration2: Text; channel: Code[250])
    begin

        ATMTrans.RESET;
        ATMTrans.INIT;
        ATMTrans."Account No" := AccountID;
        IF MessageType = '0010' THEN
            ATMTrans.Amount := Amount * -1
        ELSE
            IF MessageType = '0009' THEN
                ATMTrans.Amount := Amount - 11.6
            ELSE
                ATMTrans.Amount := Amount;

        Vendor.RESET;
        Vendor.GET(AccountID);
        varTranschannel := COPYSTR(Channel, 1, 5);
        IF (varTranschannel = 'POSAG') OR (varTranschannel = 'POSMR') THEN
            ATMTrans."POS Vendor" := ATMTrans."POS Vendor"::"Agent Banking";

        IF (varTranschannel = 'POSSA') THEN
            ATMTrans."POS Vendor" := ATMTrans."POS Vendor"::"Sacco POS";

        IF (varTranschannel = 'POSBR') THEN BEGIN
            ATMTrans."POS Vendor" := ATMTrans."POS Vendor"::"Coop Branch POS";
            ATMTrans."Is Coop Bank" := TRUE;
        END;
        ATMTrans."Trace ID" := Reference;
        ATMTrans."Card Acceptor Terminal ID" := TerminalID;
        ATMTrans.Description := TerminalLocation;
        ATMTrans."Posting Date" := TODAY;
        ATMTrans."Process Code" := '200';
        IF Reference = '' THEN BEGIN
            ATMTrans.Posted := TRUE;
        END;
        ATMTrans."Reference No" := Reference;
        ATMTrans."Reversal Trace ID" := '';
        //ATMTrans."Transaction Type Charges" := ATMTrans."Transaction Type Charges"::Invalid;
        ATMTrans."Transaction Type" := MessageType;
        ATMTrans.Description := MessageType;
        ATMTrans."Transaction Date" := RequestDate;
        ATMTrans."Trans Time":=Format(time);
        ATMTrans."Transaction Time":=time;
        ATMTrans."Transaction Description" := TerminalLocation;
        ATMTrans."Withdrawal Location" := TerminalLocation;
        ATMTrans."Reversal Trace ID" := ReversalTraceID;
        ATMTrans.Narrative1 := Narration1;
        ATMTrans."Narrative 2" := Narration2;
        ATMTrans."Customer Names" := Vendor.Name;
        ATMTrans."ATM Card No" := "Atm No";
        ATMTrans.Source := ATMTrans.Source::"ATM API";
        ATMTrans.Channel := Channel;
        ATM_CHARGES.RESET;
        ATM_CHARGES.SETRANGE(ATM_CHARGES.Channel, COPYSTR(TerminalID, 1, 3));
        ATM_CHARGES.SETRANGE(ATM_CHARGES.Code, MessageType);
        IF (ATM_CHARGES.FIND('-')) THEN BEGIN
            ATMTrans."Transaction Type Charges" := ATM_CHARGES."Transaction Type";
            ATMTrans.Description := FORMAT(ATM_CHARGES."Transaction Type");
        END ELSE BEGIN
            IF MessageType = '0014' THEN BEGIN //check if it is reversal
                ATMTrans."Transaction Type Charges" := ATM_CHARGES."Transaction Type"::Reversal;
                ATMTrans.Description := FORMAT(ATM_CHARGES."Transaction Type"::Reversal);
                ATMTrans."Transaction Type" := Format(ATM_CHARGES."Transaction Type");
            END ELSE
                IF MessageType = '0011' THEN BEGIN   //check if it is visa withdrawal
                    ATM_CHARGES.RESET;
                    ATM_CHARGES.SETRANGE(ATM_CHARGES.Code, MessageType);
                    ATM_CHARGES.SETRANGE(ATM_CHARGES.Channel, COPYSTR(TerminalID, 1, 3));
                    IF (ATM_CHARGES.FIND('-') = FALSE) THEN BEGIN
                        // ATMTrans."Transaction Type" := Format(ATM_CHARGES."Transaction Type");
                        ATMTrans."Transaction Type Charges" := ATM_CHARGES."Transaction Type"::"VISA Cash withdrawal";
                        ATMTrans.Description := FORMAT(ATM_CHARGES."Transaction Type"::"VISA Cash withdrawal");
                    END;
                END ELSE BEGIN
                    ATM_CHARGES.RESET;
                    ATM_CHARGES.SETRANGE(ATM_CHARGES.Code, MessageType);
                    IF (ATM_CHARGES.FIND('-')) THEN BEGIN
                        // ATMTrans."Transaction Type Charges" := ATM_CHARGES."Transaction Type";
                        ATMTrans."Transaction Type" := Format(ATM_CHARGES."Transaction Type");
                        ATMTrans.Description := FORMAT(ATM_CHARGES."Transaction Type");
                    END;
                END;
        END;
        //END;

        IF MessageType = '1420' THEN BEGIN

            Reversals2.RESET;
            Reversals2.SETRANGE(Reversals2."Trace ID", ReversalTraceID);
            IF (Reversals2.FIND('-')) THEN BEGIN

                Reversal3.RESET;
                Reversal3.SETRANGE(Reversal3."Trace ID", ReversalTraceID);
                Reversal3.SETRANGE(Reversal3."Account No", AccountID);
                Reversal3.SETRANGE(Reversal3.Reversed, TRUE);

                IF (Reversal3.FIND('-')) THEN BEGIN

                END ELSE BEGIN
                    ATMTrans.INSERT;

                END;
            END;
        END ELSE BEGIN

            ATMTrans.INSERT;
        END;
        ATMTrans.RESET;
        ATMTrans.SETRANGE(ATMTrans."Reference No", Reference);
        IF ATMTrans.Find('-') THEN BEGIN
            PostTrans(ATMTrans."Reference No");

        END
        ELSE BEGIN

        END;


    end;

    procedure FnBalanceAtmCharges(atmName: Code[1024]; transactionType: Code[50]; chargeAmount: Decimal; channel: Code[50]) result: Decimal
    begin
        varTranschannel := COPYSTR(Channel, 1, 5);
        IF ((varTranschannel = 'POSAG') OR (varTranschannel = 'POSMR')) AND (TransactionType = '0011') THEN BEGIN
            Pos.RESET;
            Pos.SETFILTER(Pos."Lower Limit", '<=%1', ATMTrans.Amount);
            Pos.SETFILTER(Pos."Upper Limit", '>=%1', ATMTrans.Amount);
            IF Pos.FINDFIRST THEN BEGIN
                ATMCharges := Pos."Charge Amount";
                BankCharges := Pos."Bank charge";
                result := ATMCharges + 0.2 * ATMCharges;
            END;
        END ELSE
            IF (TransactionType = '0011') THEN BEGIN

                Pesalink.RESET;
                Pesalink.SETFILTER(Pesalink."Lower Limit", '<=%1', ATMTrans.Amount);
                Pesalink.SETFILTER(Pesalink."Upper Limit", '>=%1', ATMTrans.Amount);
                IF Pesalink.FINDFIRST THEN BEGIN
                    ATMCharges := Pesalink."Charge Amount";
                    BankCharges := Pesalink."Bank charge";
                    result := ATMCharges + 0.2 * ATMCharges;
                END;
            END ELSE BEGIN
                ATM_CHARGES.RESET;
                ATM_CHARGES.SETRANGE(ATM_CHARGES.Channel, COPYSTR(varTranschannel, 1, 3));
                ATM_CHARGES.SETRANGE(ATM_CHARGES.Code, TransactionType);
                IF (ATM_CHARGES.FIND('-')) THEN BEGIN
                    ATMCharges := ATM_CHARGES."Total Amount";
                    BankCharges := ATMCharges - ATM_CHARGES."Sacco Amount";
                    ExciseFee := ATM_CHARGES."Total Amount" * 20 / 100;
                    result := ATMCharges + ExciseFee + ChargeAmount;
                END;
            END;
    end;

    procedure getAvailableBalance(acc: Code[30]) Bal: Decimal
    BEGIN
        Vendor.RESET;
        Vendor.SETRANGE(Vendor."No.", Acc);
        Vendor.SETRANGE(Vendor.Status, Vendor.Status::Active);
        Vendor.SETRANGE(Vendor.Blocked, Vendor.Blocked::" ");
        IF Vendor.FIND('-') THEN BEGIN
            AccountTypes.RESET;
            AccountTypes.SETRANGE(AccountTypes.Code, Vendor."Account Type");
            IF AccountTypes.FIND('-') THEN BEGIN
                miniBalance := AccountTypes."Minimum Balance";
            END;
            Vendor.CALCFIELDS(Vendor."Balance (LCY)");
            Vendor.CALCFIELDS(Vendor."ATM Transactions");
            Vendor.CALCFIELDS(Vendor."Uncleared Cheques");
            Vendor.CALCFIELDS(Vendor."EFT Transactions");
            accountBal := Vendor."Balance (LCY)" - (Vendor."ATM Transactions" + Vendor."Uncleared Cheques" + Vendor."EFT Transactions" + miniBalance);
            Bal := accountBal;
        END;
    END;

    procedure getBookBalance(acc: Code[30]) Bal: Decimal
    BEGIN
        Vendor.RESET;
        Vendor.SETRANGE(Vendor."No.", acc);
        Vendor.SETRANGE(Vendor.Status, Vendor.Status::Active);
        Vendor.SETRANGE(Vendor.Blocked, Vendor.Blocked::" ");
        IF Vendor.FIND('-') THEN BEGIN
            AccountTypes.RESET;
            AccountTypes.SETRANGE(AccountTypes.Code, Vendor."Account Type");
            IF AccountTypes.FIND('-') THEN BEGIN
                miniBalance := AccountTypes."Minimum Balance";
            END;
            Vendor.CALCFIELDS(Vendor."Balance (LCY)");
            Vendor.CALCFIELDS(Vendor."ATM Transactions");
            Vendor.CALCFIELDS(Vendor."Uncleared Cheques");
            Vendor.CALCFIELDS(Vendor."EFT Transactions");
            accountBal := Vendor."Balance (LCY)" - (Vendor."ATM Transactions" + Vendor."Uncleared Cheques" + Vendor."EFT Transactions");
            Bal := accountBal;
        END;
    END;

    procedure getTransactionsLimit(AccountNo: Code[50]; Amount: Decimal) Limit: Decimal
    var
        DefaultLimit: Decimal;
        DailyLimit: Decimal;
    begin
        DefaultLimit := 50000;
        ATMTrans.RESET;
        ATMTrans.SETRANGE(ATMTrans."ATM Card No", AccountNo);
        ATMTrans.SETRANGE(ATMTrans."Posting Date", TODAY);
        IF ATMTrans.FIND('-') THEN BEGIN
            REPEAT
                DailyLimit := DailyLimit + ATMTrans.Amount;
            UNTIL ATMTrans.NEXT = 0;
        END;
        Limit := DefaultLimit - DailyLimit;

        IF Limit >= Amount THEN BEGIN
            Limit := Amount;
        END
        ELSE BEGIN
            Limit := 0;
        END;
    end;

    procedure getVendorAccount(atmno: Code[100]) acc: Code[50]
    BEGIN
        Vendor.RESET;
        Vendor.SETRANGE(Vendor."ATM No.", atmno);
        //Vendor.SETRANGE(Vendor.Status,Vendor.Status::Active);
        //Vendor.SETRANGE(Vendor.Blocked,Vendor.Blocked::" ");
        IF Vendor.FIND('-') THEN BEGIN
            acc := Vendor."No." + ':::' + Vendor.Name;
        END ELSE BEGIN
            acc := 'None';
        END;
    END;

    procedure FnMinistatementCharges(atmName: Code[1024]; TransactionType: Code[50]; ChargeAmount: Decimal; Channel: Code[50]) result: Decimal
    begin
        ATM_CHARGES.RESET;
        ATM_CHARGES.SETRANGE(ATM_CHARGES.Channel, Channel);
        ATM_CHARGES.SETRANGE(ATM_CHARGES.Code, TransactionType);
        IF (ATM_CHARGES.FIND('-')) THEN BEGIN
            ATMCharges := ATM_CHARGES."Total Amount";
            BankCharges := ATMCharges - ATM_CHARGES."Sacco Amount";
            ExciseFee := ATM_CHARGES."Total Amount" * 20 / 100;
            result := ATMCharges + ExciseFee + ChargeAmount;
        END;
    end;

    procedure FnTransactionAtmCharges(atmName: Code[1024]; TransactionType: Code[50]; ChargeAmount: Decimal; Channel: Code[50]) result: Decimal
    begin
        result := 0;
        IF (Channel = 'POS') AND (TransactionType = 'Cash withdrawal') THEN BEGIN
            Pos.RESET;
            Pos.SETFILTER(Pos."Lower Limit", '<=%1', ATMTrans.Amount);
            Pos.SETFILTER(Pos."Upper Limit", '>=%1', ATMTrans.Amount);
            IF Pos.FINDFIRST THEN BEGIN
                ATMCharges := Pos."Charge Amount";
                BankCharges := Pos."Bank charge";
                result := ATMCharges + 0.2 * ATMCharges;
            END;
        END ELSE BEGIN
            ATM_CHARGES.RESET;
            ATM_CHARGES.SETRANGE(ATM_CHARGES.Channel, Channel);
            ATM_CHARGES.SETRANGE(ATM_CHARGES.Code, TransactionType);
            IF (ATM_CHARGES.FIND('-')) THEN BEGIN
                ATMCharges := ATM_CHARGES."Total Amount";
                BankCharges := ATMCharges - ATM_CHARGES."Sacco Amount";
                ExciseFee := ATM_CHARGES."Total Amount" * 20 / 100;
                result := ATMCharges + ExciseFee + ChargeAmount;
            END;

        END;
    end;

    procedure FnCheckTransExist(tranId: Code[250]) result: Boolean
    begin
        ATMTrans.RESET;
        ATMTrans.SETRANGE(ATMTrans."Reference No", TranId);
        IF ATMTrans.FIND('-') THEN BEGIN
            result := TRUE;

        END
        ELSE BEGIN
            result := FALSE;
        END;
    end;

    procedure fnInsertatmlogentries(messageType: Text[50]; accountID: Code[50]; atmNo: Code[20]; authCode: Code[50]; amount: Decimal; reference: Code[50]; terminalID: Code[50]; TerminalLocation: Code[50]; RequestDate: Date; ResponseCode: Code[10]; Posted: Boolean;
        AccountN: Code[250]; MessageID: Text[500]; Code: Code[10]; Description: Text[250]; institutionname: Text[100]; institutioncode: Text[100]; channel: Code[50]; connectionmode: Code[100]; Narration1: Text[250]; Narration2: Text[250]) result: Boolean


    begin
        AtmLog.RESET;
        AtmLog.SETRANGE(AtmLog."Reference No", Reference);
        IF AtmLog.FIND('-') = FALSE THEN BEGIN
            AtmLog.INIT;
            AtmLog."Date Time" := CURRENTDATETIME;
            AtmLog."Account No" := AccountID;
            AtmLog."ATM No" := AtmNo;
            AtmLog.Amount := Amount;
            AtmLog."ATM Amount" := Amount;
            AtmLog."ATM Location" := TerminalID;
            AtmLog."Card No." := AtmNo;
            AtmLog."Reference No" := Reference;
            AtmLog."Trace ID" := Reference;
            AtmLog."Withdrawal Location" := TerminalLocation;
            AtmLog."Return Code" := Code;
            AtmLog."Code Description" := Description;
            AtmLog."Transaction Type" := AtmLog."Transaction Type"::"Cash Withdrawal";
            AtmLog."institution Name" := institutionname;
            AtmLog."Institutional code" := institutioncode;
            AtmLog.Channel := channel;
            AtmLog."Connection Mode" := MessageType;
            AtmLog.Narrative1 := Narration1;
            AtmLog."Narrative2" := Narration2;
            ATM_CHARGES.RESET;
            ATM_CHARGES.SETRANGE(ATM_CHARGES.Channel, COPYSTR(TerminalID, 1, 3));
            ATM_CHARGES.SETRANGE(ATM_CHARGES.Code, MessageType);
            IF (ATM_CHARGES.FIND('-')) THEN BEGIN
                AtmLog."Transaction Type" := ATM_CHARGES."Transaction Type";
                AtmLog."Code Description" := FORMAT(ATM_CHARGES."Transaction Type");
            END ELSE BEGIN
                IF MessageType = '0014' THEN BEGIN
                    AtmLog."Transaction Type" := ATM_CHARGES."Transaction Type"::Reversal;
                    AtmLog."Code Description" := FORMAT(ATM_CHARGES."Transaction Type"::Reversal);
                END;
            END;
            AtmLog.INSERT;
        END;
    end;

    procedure Ministatement(Maxno: Integer; accountno: Code[50]) result: Text
    var
        VendorLedgEntry: Record "Vendor Ledger Entry";
        amount: Decimal;
        minimunCount: Integer;
        MiniStmt: Text;
        DR: Code[30];
        varDescript: text;
        varpostingdate: Text;
    begin
        VendorLedgEntry.RESET;
        minimunCount := 0;
        VendorLedgEntry.SETCURRENTKEY(VendorLedgEntry."Entry No.");
        VendorLedgEntry.SETASCENDING(VendorLedgEntry."Entry No.", FALSE);
        // VendorLedgEntry.SETFILTER(VendorLedgEntry.Description,'<>%1','*Charge*');
        VendorLedgEntry.SETRANGE(VendorLedgEntry."Vendor No.", accountno);
        VendorLedgEntry.SETRANGE(VendorLedgEntry.Reversed, false);
        IF VendorLedgEntry.FINDSET THEN BEGIN
            MiniStmt := '';
            REPEAT
                VendorLedgEntry.CALCFIELDS(VendorLedgEntry.Amount);
                amount := VendorLedgEntry.Amount;
                IF amount < 0 THEN BEGIN
                    amount := amount * -1;
                    DR := 'CR';
                END ELSE BEGIN
                    DR := 'DR';
                END;
                if VendorLedgEntry.Description = '' then
                    varDescript := 'N/A'
                ELSE
                    varDescript := VendorLedgEntry.Description;

                varpostingdate := '<Year4>-<Month,2>-<Day,2>T<Hours12,2>:<Minutes,2>:<Seconds,2>';

                result := result + DR + ':::' + FORMAT(ABS(amount)) + ':::' + COPYSTR(varDescript, 1, 25) + ':::' + FORMAT(VendorLedgEntry."Posting Date") + ':::' + FORMAT(VendorLedgEntry."Posting Date") + '::::';
                minimunCount := minimunCount + 1;
                IF minimunCount > Maxno THEN
                    EXIT
              UNTIL VendorLedgEntry.NEXT = 0;
            result := MiniStmt;
        END;


    end;
}
