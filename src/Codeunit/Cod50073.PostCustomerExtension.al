//************************************************************************
codeunit 50073 "PostCustomerExtension"
{
    trigger OnRun()
    begin

    end;



    [EventSubscriber(ObjectType::Codeunit, 12, 'OnBeforePostGenJnlLine', '', false, false)]
    procedure ModifyReceivablesAccount(var GenJournalLine: Record "Gen. Journal Line")
    var
        Cust: Record Customer;
        TransactionTypestable: record "Transaction Types Table";
        LoanApp: Record "Loans Register";
        LoanTypes: record "Loan Products Setup";
        CustPostingGroupBuffer: record "Customer Posting Group";
        saccoGen: Record "Sacco General Set-Up";
    begin
        if (GenJournalLine."Account Type" <> GenJournalLine."Account Type"::"Fixed Asset") and (GenJournalLine."Account Type" <> GenJournalLine."Account Type"::Vendor)  then begin
            if cust.Get(GenJournalLine."Account No.") then begin
                if cust.ISNormalMember then begin
                    if GenJournalLine."Transaction Type" = GenJournalLine."Transaction Type"::" " then
                        Error('Cannot post with missing transaction type.');
                    TransactionTypestable.reset;
                    TransactionTypestable.SetRange(TransactionTypestable."Transaction Type", GenJournalLine."Transaction Type");
                    if TransactionTypestable.Find('-') then begin
                        GenJournalLine."Posting Group" := TransactionTypestable."Posting Group Code";
                        GenJournalLine.Modify();
                    end else
                        Error('The transaction setup for transaction %1 is missing', GenJournalLine."Transaction Type");
                end;
            end;
        end;

        if (GenJournalLine."Transaction Type" = GenJournalLine."transaction type"::Repayment) then begin
            if GenJournalLine."Loan No" = '' then
                Error('Loan No must be specified for Loan, Repayment or Interest transactions');

            LoanApp.Reset;
            LoanApp.SetCurrentkey(LoanApp."Loan  No.");
            LoanApp.SetRange(LoanApp."Loan  No.", GenJournalLine."Loan No");
            if LoanApp.Find('-') then begin
                if LoanTypes.Get(LoanApp."Loan Product Type") then begin
                    LoanTypes.TestField(LoanTypes."Loan Account");
                    if cust.get(GenJournalLine."Account No.") then
                        if Cust.ISNormalMember = true then
                            if GenJournalLine."Transaction Type" = GenJournalLine."Transaction Type"::" " then
                                Error('Cannot post with missing transaction type.');
                    TransactionTypestable.reset;
                    TransactionTypestable.SetRange(TransactionTypestable."Transaction Type", GenJournalLine."Transaction Type");
                    if TransactionTypestable.Find('-') then begin
                        CustPostingGroupBuffer.Reset();
                        CustPostingGroupBuffer.SetRange(Code, TransactionTypestable."Posting Group Code");
                        if CustPostingGroupBuffer.FindFirst() then begin
                            CustPostingGroupBuffer."Receivables Account" := LoanTypes."Loan Account";
                            CustPostingGroupBuffer.Modify();
                            GenJournalLine."Posting Group" := CustPostingGroupBuffer.code;
                            GenJournalLine.Modify();

                        end;

                    end else
                        Error('The transaction setup for transaction %1 is missing', GenJournalLine."Transaction Type");
                end;
            end;
        end;




        if (GenJournalLine."Transaction Type" = GenJournalLine."transaction type"::"Interest Due") then begin
            if GenJournalLine."Loan No" = '' then
                Error('Loan No must be specified for Loan, Repayment or Interest transactions :- %1', GenJournalLine."Account No.");

            LoanApp.Reset;
            LoanApp.SetCurrentkey(LoanApp."Loan  No.");
            LoanApp.SetRange(LoanApp."Loan  No.", GenJournalLine."Loan No");
            if LoanApp.Find('-') then begin
                if LoanTypes.Get(LoanApp."Loan Product Type") then begin
                    LoanTypes.TestField(LoanTypes."Receivable Interest Account");
                    if cust.get(GenJournalLine."Account No.") then
                        if Cust.ISNormalMember = true then
                            if GenJournalLine."Transaction Type" = GenJournalLine."Transaction Type"::" " then
                                Error('Cannot post with missing transaction type.');
                    TransactionTypestable.reset;
                    TransactionTypestable.SetRange(TransactionTypestable."Transaction Type", GenJournalLine."Transaction Type");
                    if TransactionTypestable.Find('-') then begin
                        CustPostingGroupBuffer.Reset();
                        CustPostingGroupBuffer.SetRange(Code, TransactionTypestable."Posting Group Code");
                        if CustPostingGroupBuffer.FindFirst() then begin
                            CustPostingGroupBuffer."Receivables Account" := LoanTypes."Receivable Interest Account";
                            CustPostingGroupBuffer.Modify();
                            GenJournalLine."Posting Group" := CustPostingGroupBuffer.code;
                            GenJournalLine.Modify();
                        end;
                    end else
                        Error('The transaction setup for transaction %1 is missing', GenJournalLine."Transaction Type");

                end;
            end;
        end;

        if (GenJournalLine."Transaction Type" = GenJournalLine."transaction type"::"Interest Paid") then begin
            if GenJournalLine."Loan No" = '' then
                Error('Loan No must be specified for Loan, Repayment or Interest transactions :- %1', GenJournalLine."Account No.");

            LoanApp.Reset;
            LoanApp.SetCurrentkey(LoanApp."Loan  No.");
            LoanApp.SetRange(LoanApp."Loan  No.", GenJournalLine."Loan No");
            if LoanApp.Find('-') then begin
                if LoanTypes.Get(LoanApp."Loan Product Type") then begin
                    LoanTypes.TestField(LoanTypes."Receivable Interest Account");
                    if cust.get(GenJournalLine."Account No.") then
                        if Cust.ISNormalMember = true then
                            if GenJournalLine."Transaction Type" = GenJournalLine."Transaction Type"::" " then
                                Error('Cannot post with missing transaction type.');
                    TransactionTypestable.reset;
                    TransactionTypestable.SetRange(TransactionTypestable."Transaction Type", GenJournalLine."Transaction Type");
                    if TransactionTypestable.Find('-') then begin
                        CustPostingGroupBuffer.Reset();
                        CustPostingGroupBuffer.SetRange(Code, TransactionTypestable."Posting Group Code");
                        if CustPostingGroupBuffer.FindFirst() then begin
                            CustPostingGroupBuffer."Receivables Account" := LoanTypes."Receivable Interest Account";
                            CustPostingGroupBuffer.Modify();
                            GenJournalLine."Posting Group" := CustPostingGroupBuffer.code;
                            GenJournalLine.Modify();
                        end;
                    end else
                        Error('The transaction setup for transaction %1 is missing', GenJournalLine."Transaction Type");
                end;
            end;
        end;

        if (GenJournalLine."Transaction Type" = GenJournalLine."transaction type"::Loan) then begin
            if GenJournalLine."Loan No" = '' then
                Error('Loan No must be specified for Loan, Repayment or Interest transactions :- %1', GenJournalLine."Account No.");
            //Message('firsst%1', Cust.ISNormalMember);
            LoanApp.Reset;
            LoanApp.SetCurrentkey(LoanApp."Loan  No.");
            LoanApp.SetRange(LoanApp."Loan  No.", GenJournalLine."Loan No");
            if LoanApp.Find('-') then begin
                //Message('kweli%1', LoanApp."Loan Product Type");
                if LoanTypes.Get(LoanApp."Loan Product Type") then begin
                    LoanTypes.TestField(LoanTypes."Loan Account");
                    if cust.get(GenJournalLine."Account No.") then
                        if Cust.ISNormalMember = true then
                            // Message('kabisa%1', LoanTypes.Code);
                            if GenJournalLine."Transaction Type" = GenJournalLine."Transaction Type"::" " then
                                Error('Cannot post with missing transaction type.');
                    TransactionTypestable.reset;
                    TransactionTypestable.SetRange(TransactionTypestable."Transaction Type", GenJournalLine."Transaction Type");
                    if TransactionTypestable.Find('-') then begin
                        //Message('home %1', TransactionTypestable."Transaction Type");
                        CustPostingGroupBuffer.Reset();
                        CustPostingGroupBuffer.SetRange(Code, TransactionTypestable."Posting Group Code");
                        if CustPostingGroupBuffer.FindFirst() then begin
                            CustPostingGroupBuffer."Receivables Account" := LoanTypes."Loan Account";
                            CustPostingGroupBuffer.Modify();
                            GenJournalLine."Posting Group" := CustPostingGroupBuffer.code;
                            GenJournalLine.Modify();
                        end;
                    end else
                        Error('The transaction setup for transaction %1 is missing', GenJournalLine."Transaction Type");
                end;
            end;

        end;

        if (GenJournalLine."Transaction Type" = GenJournalLine."transaction type"::"Loan Insurance Charged") then begin
            if GenJournalLine."Loan No" = '' then
                Error('Loan No must be specified for Loan, Repayment,Loan Insurance or Interest transactions :- %1', GenJournalLine."Account No.");

            LoanApp.Reset;
            LoanApp.SetCurrentkey(LoanApp."Loan  No.");
            LoanApp.SetRange(LoanApp."Loan  No.", GenJournalLine."Loan No");
            if LoanApp.Find('-') then begin
                if LoanTypes.Get(LoanApp."Loan Product Type") then begin
                    LoanTypes.TestField(LoanTypes."Insurance Fee Charged Account");
                    if cust.get(GenJournalLine."Account No.") then
                        if Cust.ISNormalMember = true then
                            if GenJournalLine."Transaction Type" = GenJournalLine."Transaction Type"::" " then
                                Error('Cannot post with missing transaction type.');
                    TransactionTypestable.reset;
                    TransactionTypestable.SetRange(TransactionTypestable."Transaction Type", GenJournalLine."Transaction Type");
                    if TransactionTypestable.Find('-') then begin
                        CustPostingGroupBuffer.Reset();
                        CustPostingGroupBuffer.SetRange(Code, TransactionTypestable."Posting Group Code");
                        if CustPostingGroupBuffer.FindFirst() then begin
                            CustPostingGroupBuffer."Receivables Account" := LoanTypes."Insurance Fee Charged Account";
                            CustPostingGroupBuffer.Modify();
                            GenJournalLine."Posting Group" := CustPostingGroupBuffer.code;
                            GenJournalLine.Modify();
                        end;
                    end else
                        Error('The transaction setup for transaction %1 is missing', GenJournalLine."Transaction Type");

                end;
            end;

        end;

        if (GenJournalLine."Transaction Type" = GenJournalLine."transaction type"::"Loan Insurance Paid") then begin
            if GenJournalLine."Loan No" = '' then
                Error('Loan No must be specified for Loan, Repayment,Loan Insurance or Interest transactions :- %1', GenJournalLine."Account No.");

            LoanApp.Reset;
            LoanApp.SetCurrentkey(LoanApp."Loan  No.");
            LoanApp.SetRange(LoanApp."Loan  No.", GenJournalLine."Loan No");
            if LoanApp.Find('-') then begin
                if LoanTypes.Get(LoanApp."Loan Product Type") then begin
                    LoanTypes.TestField(LoanTypes."Loan Insurance Accounts");
                    if cust.get(GenJournalLine."Account No.") then
                        if Cust.ISNormalMember = true then
                            if GenJournalLine."Transaction Type" = GenJournalLine."Transaction Type"::" " then
                                Error('Cannot post with missing transaction type.');
                    TransactionTypestable.reset;
                    TransactionTypestable.SetRange(TransactionTypestable."Transaction Type", GenJournalLine."Transaction Type");
                    if TransactionTypestable.Find('-') then begin
                        CustPostingGroupBuffer.Reset();
                        CustPostingGroupBuffer.SetRange(Code, TransactionTypestable."Posting Group Code");
                        if CustPostingGroupBuffer.FindFirst() then begin
                            CustPostingGroupBuffer."Receivables Account" := LoanTypes."Receivable Insurance Accounts";
                            CustPostingGroupBuffer.Modify();
                            GenJournalLine."Posting Group" := CustPostingGroupBuffer.code;
                            GenJournalLine.Modify();
                        end;
                    end else
                        Error('The transaction setup for transaction %1 is missing', GenJournalLine."Transaction Type");

                end;
            end;

        end;

        if (GenJournalLine."Transaction Type" = GenJournalLine."transaction type"::"Loan Penalty Charged") then begin
            if GenJournalLine."Loan No" = '' then
                Error('Loan No must be specified for Loan, Repayment,Loan Insurance or Interest transactions :- %1', GenJournalLine."Account No.");

            LoanApp.Reset;
            LoanApp.SetCurrentkey(LoanApp."Loan  No.");
            LoanApp.SetRange(LoanApp."Loan  No.", GenJournalLine."Loan No");
            if LoanApp.Find('-') then begin
                if LoanTypes.Get(LoanApp."Loan Product Type") then begin
                    LoanTypes.TestField(LoanTypes."Penalty Paid Account");
                    if cust.get(GenJournalLine."Account No.") then
                        if Cust.ISNormalMember = true then
                            if GenJournalLine."Transaction Type" = GenJournalLine."Transaction Type"::" " then
                                Error('Cannot post with missing transaction type.');
                    TransactionTypestable.reset;
                    TransactionTypestable.SetRange(TransactionTypestable."Transaction Type", GenJournalLine."Transaction Type");
                    if TransactionTypestable.Find('-') then begin
                        CustPostingGroupBuffer.Reset();
                        CustPostingGroupBuffer.SetRange(Code, TransactionTypestable."Posting Group Code");
                        if CustPostingGroupBuffer.FindFirst() then begin
                            CustPostingGroupBuffer."Receivables Account" := LoanTypes."Penalty Paid Account";
                            CustPostingGroupBuffer.Modify();
                            GenJournalLine."Posting Group" := CustPostingGroupBuffer.code;
                            GenJournalLine.Modify();
                        end;
                    end else
                        Error('The transaction setup for transaction %1 is missing', GenJournalLine."Transaction Type");

                end;
            end;

        end;

        if (GenJournalLine."Transaction Type" = GenJournalLine."transaction type"::"Loan Penalty Paid") then begin
            if GenJournalLine."Loan No" = '' then
                Error('Loan No must be specified for Loan, Repayment,Loan Insurance or Interest transactions :- %1', GenJournalLine."Account No.");

            LoanApp.Reset;
            LoanApp.SetCurrentkey(LoanApp."Loan  No.");
            LoanApp.SetRange(LoanApp."Loan  No.", GenJournalLine."Loan No");
            if LoanApp.Find('-') then begin
                if LoanTypes.Get(LoanApp."Loan Product Type") then begin
                    LoanTypes.TestField(LoanTypes."Penalty Charged Account");
                    if cust.get(GenJournalLine."Account No.") then
                        if Cust.ISNormalMember = true then
                            if GenJournalLine."Transaction Type" = GenJournalLine."Transaction Type"::" " then
                                Error('Cannot post with missing transaction type.');
                    TransactionTypestable.reset;
                    TransactionTypestable.SetRange(TransactionTypestable."Transaction Type", GenJournalLine."Transaction Type");
                    if TransactionTypestable.Find('-') then begin
                        CustPostingGroupBuffer.Reset();
                        CustPostingGroupBuffer.SetRange(Code, TransactionTypestable."Posting Group Code");
                        if CustPostingGroupBuffer.FindFirst() then begin
                            CustPostingGroupBuffer."Receivables Account" := LoanTypes."Penalty Paid Account";
                            CustPostingGroupBuffer.Modify();
                            GenJournalLine."Posting Group" := CustPostingGroupBuffer.code;
                            GenJournalLine.Modify();
                        end;
                    end else
                        Error('The transaction setup for transaction %1 is missing', GenJournalLine."Transaction Type");

                end;
            end;

        end;
        //Appraisal Fee
        if (GenJournalLine."Transaction Type" = GenJournalLine."transaction type"::"Appraisal Fee Charged") then begin
            if GenJournalLine."Loan No" = '' then
                Error('Loan No must be specified for Loan, Repayment,Appraissal,Loan Insurance or Interest transactions :- %1', GenJournalLine."Account No.");

            LoanApp.Reset;
            LoanApp.SetCurrentkey(LoanApp."Loan  No.");
            LoanApp.SetRange(LoanApp."Loan  No.", GenJournalLine."Loan No");
            if LoanApp.Find('-') then begin
                if LoanTypes.Get(LoanApp."Loan Product Type") then begin
                    LoanTypes.TestField(LoanTypes."Appraisal Fee Charged Account");
                    if cust.get(GenJournalLine."Account No.") then
                        if Cust.ISNormalMember = true then
                            if GenJournalLine."Transaction Type" = GenJournalLine."Transaction Type"::" " then
                                Error('Cannot post with missing transaction type.');
                    TransactionTypestable.reset;
                    TransactionTypestable.SetRange(TransactionTypestable."Transaction Type", GenJournalLine."Transaction Type");
                    if TransactionTypestable.Find('-') then begin
                        CustPostingGroupBuffer.Reset();
                        CustPostingGroupBuffer.SetRange(Code, TransactionTypestable."Posting Group Code");
                        if CustPostingGroupBuffer.FindFirst() then begin
                            CustPostingGroupBuffer."Receivables Account" := LoanTypes."Appraisal Fee Charged Account";
                            CustPostingGroupBuffer.Modify();
                            GenJournalLine."Posting Group" := CustPostingGroupBuffer.code;
                            GenJournalLine.Modify();
                        end;
                    end else
                        Error('The transaction setup for transaction %1 is missing', GenJournalLine."Transaction Type");

                end;
            end;

        end;

        if (GenJournalLine."Transaction Type" = GenJournalLine."transaction type"::"Appraisal Fee Paid") then begin
            if GenJournalLine."Loan No" = '' then
                Error('Loan No must be specified for Loan, Repayment,Loan Insurance or Interest transactions :- %1', GenJournalLine."Account No.");

            LoanApp.Reset;
            LoanApp.SetCurrentkey(LoanApp."Loan  No.");
            LoanApp.SetRange(LoanApp."Loan  No.", GenJournalLine."Loan No");
            if LoanApp.Find('-') then begin
                if LoanTypes.Get(LoanApp."Loan Product Type") then begin
                    LoanTypes.TestField(LoanTypes."Appraisal Fee Paid Account");
                    if cust.get(GenJournalLine."Account No.") then
                        if Cust.ISNormalMember = true then
                            if GenJournalLine."Transaction Type" = GenJournalLine."Transaction Type"::" " then
                                Error('Cannot post with missing transaction type.');
                    TransactionTypestable.reset;
                    TransactionTypestable.SetRange(TransactionTypestable."Transaction Type", GenJournalLine."Transaction Type");
                    if TransactionTypestable.Find('-') then begin
                        CustPostingGroupBuffer.Reset();
                        CustPostingGroupBuffer.SetRange(Code, TransactionTypestable."Posting Group Code");
                        if CustPostingGroupBuffer.FindFirst() then begin
                            CustPostingGroupBuffer."Receivables Account" := LoanTypes."Appraisal Fee Paid Account";
                            CustPostingGroupBuffer.Modify();
                            GenJournalLine."Posting Group" := CustPostingGroupBuffer.code;
                            GenJournalLine.Modify();
                        end;
                    end else
                        Error('The transaction setup for transaction %1 is missing', GenJournalLine."Transaction Type");

                end;
            end;

        end;


        //End Appraisal Fee


        //Legal Fee
        if (GenJournalLine."Transaction Type" = GenJournalLine."transaction type"::"Legal Fee Charged") then begin
            if GenJournalLine."Loan No" = '' then
                Error('Loan No must be specified for Loan, Repayment,Appraissal,Loan Insurance or Interest transactions :- %1', GenJournalLine."Account No.");

            LoanApp.Reset;
            LoanApp.SetCurrentkey(LoanApp."Loan  No.");
            LoanApp.SetRange(LoanApp."Loan  No.", GenJournalLine."Loan No");
            if LoanApp.Find('-') then begin
                if LoanTypes.Get(LoanApp."Loan Product Type") then begin
                    LoanTypes.TestField(LoanTypes."Legal Fee Charged Account");
                    if cust.get(GenJournalLine."Account No.") then
                        if Cust.ISNormalMember = true then
                            if GenJournalLine."Transaction Type" = GenJournalLine."Transaction Type"::" " then
                                Error('Cannot post with missing transaction type.');
                    TransactionTypestable.reset;
                    TransactionTypestable.SetRange(TransactionTypestable."Transaction Type", GenJournalLine."Transaction Type");
                    if TransactionTypestable.Find('-') then begin
                        CustPostingGroupBuffer.Reset();
                        CustPostingGroupBuffer.SetRange(Code, TransactionTypestable."Posting Group Code");
                        if CustPostingGroupBuffer.FindFirst() then begin
                            CustPostingGroupBuffer."Receivables Account" := LoanTypes."Legal Fee Charged Account";
                            CustPostingGroupBuffer.Modify();
                            GenJournalLine."Posting Group" := CustPostingGroupBuffer.code;
                            GenJournalLine.Modify();
                        end;
                    end else
                        Error('The transaction setup for transaction %1 is missing', GenJournalLine."Transaction Type");

                end;
            end;

        end;

        if (GenJournalLine."Transaction Type" = GenJournalLine."transaction type"::"Legal Fee Paid") then begin
            if GenJournalLine."Loan No" = '' then
                Error('Loan No must be specified for Loan, Repayment,Loan Insurance or Interest transactions :- %1', GenJournalLine."Account No.");

            LoanApp.Reset;
            LoanApp.SetCurrentkey(LoanApp."Loan  No.");
            LoanApp.SetRange(LoanApp."Loan  No.", GenJournalLine."Loan No");
            if LoanApp.Find('-') then begin
                if LoanTypes.Get(LoanApp."Loan Product Type") then begin
                    LoanTypes.TestField(LoanTypes."Legal Fee Paid Account");
                    if cust.get(GenJournalLine."Account No.") then
                        if Cust.ISNormalMember = true then
                            if GenJournalLine."Transaction Type" = GenJournalLine."Transaction Type"::" " then
                                Error('Cannot post with missing transaction type.');
                    TransactionTypestable.reset;
                    TransactionTypestable.SetRange(TransactionTypestable."Transaction Type", GenJournalLine."Transaction Type");
                    if TransactionTypestable.Find('-') then begin
                        CustPostingGroupBuffer.Reset();
                        CustPostingGroupBuffer.SetRange(Code, TransactionTypestable."Posting Group Code");
                        if CustPostingGroupBuffer.FindFirst() then begin
                            CustPostingGroupBuffer."Receivables Account" := LoanTypes."Legal Fee Paid Account";
                            CustPostingGroupBuffer.Modify();
                            GenJournalLine."Posting Group" := CustPostingGroupBuffer.code;
                            GenJournalLine.Modify();
                        end;
                    end else
                        Error('The transaction setup for transaction %1 is missing', GenJournalLine."Transaction Type");

                end;
            end;

        end;
        //End Legal Fee


        //Valuation Fee
        if (GenJournalLine."Transaction Type" = GenJournalLine."transaction type"::"Valuation Fee Charged") then begin
            if GenJournalLine."Loan No" = '' then
                Error('Loan No must be specified for Loan, Repayment,Appraissal,Loan Insurance or Interest transactions :- %1', GenJournalLine."Account No.");

            LoanApp.Reset;
            LoanApp.SetCurrentkey(LoanApp."Loan  No.");
            LoanApp.SetRange(LoanApp."Loan  No.", GenJournalLine."Loan No");
            if LoanApp.Find('-') then begin
                if LoanTypes.Get(LoanApp."Loan Product Type") then begin
                    LoanTypes.TestField(LoanTypes."Valuation Fee Charged Account");
                    if cust.get(GenJournalLine."Account No.") then
                        if Cust.ISNormalMember = true then
                            if GenJournalLine."Transaction Type" = GenJournalLine."Transaction Type"::" " then
                                Error('Cannot post with missing transaction type.');
                    TransactionTypestable.reset;
                    TransactionTypestable.SetRange(TransactionTypestable."Transaction Type", GenJournalLine."Transaction Type");
                    if TransactionTypestable.Find('-') then begin
                        CustPostingGroupBuffer.Reset();
                        CustPostingGroupBuffer.SetRange(Code, TransactionTypestable."Posting Group Code");
                        if CustPostingGroupBuffer.FindFirst() then begin
                            CustPostingGroupBuffer."Receivables Account" := LoanTypes."Valuation Fee Charged Account";
                            CustPostingGroupBuffer.Modify();
                            GenJournalLine."Posting Group" := CustPostingGroupBuffer.code;
                            GenJournalLine.Modify();
                        end;
                    end else
                        Error('The transaction setup for transaction %1 is missing', GenJournalLine."Transaction Type");

                end;
            end;

        end;

        if (GenJournalLine."Transaction Type" = GenJournalLine."transaction type"::"Valuation Fee Paid") then begin
            if GenJournalLine."Loan No" = '' then
                Error('Loan No must be specified for Loan, Repayment,Loan Insurance or Interest transactions :- %1', GenJournalLine."Account No.");

            LoanApp.Reset;
            LoanApp.SetCurrentkey(LoanApp."Loan  No.");
            LoanApp.SetRange(LoanApp."Loan  No.", GenJournalLine."Loan No");//
            if LoanApp.Find('-') then begin
                if LoanTypes.Get(LoanApp."Loan Product Type") then begin
                    LoanTypes.TestField(LoanTypes."Valuation Fee Paid Account");
                    if cust.get(GenJournalLine."Account No.") then
                        if Cust.ISNormalMember = true then
                            if GenJournalLine."Transaction Type" = GenJournalLine."Transaction Type"::" " then
                                Error('Cannot post with missing transaction type.');
                    TransactionTypestable.reset;
                    TransactionTypestable.SetRange(TransactionTypestable."Transaction Type", GenJournalLine."Transaction Type");
                    if TransactionTypestable.Find('-') then begin
                        CustPostingGroupBuffer.Reset();
                        CustPostingGroupBuffer.SetRange(Code, TransactionTypestable."Posting Group Code");
                        if CustPostingGroupBuffer.FindFirst() then begin
                            CustPostingGroupBuffer."Receivables Account" := LoanTypes."Valuation Fee Paid Account";
                            CustPostingGroupBuffer.Modify();
                            GenJournalLine."Posting Group" := CustPostingGroupBuffer.code;
                            GenJournalLine.Modify();
                        end;
                    end else
                        Error('The transaction setup for transaction %1 is missing', GenJournalLine."Transaction Type");

                end;
            end;

        end;
        //End Valuation Fee

        if (GenJournalLine."Transaction Type" = GenJournalLine."transaction type"::"Registration Fee") then begin
            if GenJournalLine."Account Type" <> GenJournalLine."Account Type"::Customer then Error('Account Type must be Customer for registration fee transactions. Line No:- %1', GenJournalLine."Line No.");
            if GenJournalLine."Account No." = '' then Error('Member No must be specified for registration fee transactions. Line No:- %1', GenJournalLine."Line No.");

            if cust.get(GenJournalLine."Account No.") then
                if Cust.ISNormalMember = true then
                    if GenJournalLine."Transaction Type" = GenJournalLine."Transaction Type"::" " then
                        Error('Cannot post with missing transaction type.');
            TransactionTypestable.reset;
            TransactionTypestable.SetRange(TransactionTypestable."Transaction Type", GenJournalLine."Transaction Type");
            if TransactionTypestable.Find('-') then begin
                CustPostingGroupBuffer.Reset();
                CustPostingGroupBuffer.SetRange(Code, TransactionTypestable."Posting Group Code");
                if CustPostingGroupBuffer.FindFirst() then begin
                    CustPostingGroupBuffer."Receivables Account" := CustPostingGroupBuffer."Registration Fees Account";
                    CustPostingGroupBuffer.Modify();
                    GenJournalLine."Posting Group" := CustPostingGroupBuffer.code;
                    GenJournalLine.Modify();
                end;
            end else
                Error('The transaction setup for transaction %1 is missing', GenJournalLine."Transaction Type");
        end;

        if (GenJournalLine."Transaction Type" = GenJournalLine."transaction type"::"Share Capital") then begin
            if GenJournalLine."Account Type" <> GenJournalLine."Account Type"::Customer then Error('Account Type must be Customer for Share Capital transactions. Line No:- %1', GenJournalLine."Line No.");
            if GenJournalLine."Account No." = '' then Error('Member No must be specified for Share capital transactions. Line No:- %1', GenJournalLine."Line No.");

            if cust.get(GenJournalLine."Account No.") then
                if Cust.ISNormalMember = true then
                    if GenJournalLine."Transaction Type" = GenJournalLine."Transaction Type"::" " then
                        Error('Cannot post with missing transaction type.');
            TransactionTypestable.reset;
            TransactionTypestable.SetRange(TransactionTypestable."Transaction Type", GenJournalLine."Transaction Type");
            if TransactionTypestable.Find('-') then begin
                CustPostingGroupBuffer.Reset();
                CustPostingGroupBuffer.SetRange(Code, TransactionTypestable."Posting Group Code");
                if CustPostingGroupBuffer.FindFirst() then begin
                    CustPostingGroupBuffer.TestField(CustPostingGroupBuffer."Shares Capital Account");
                    CustPostingGroupBuffer."Receivables Account" := CustPostingGroupBuffer."Shares Capital Account";
                    CustPostingGroupBuffer.Modify();
                    GenJournalLine."Posting Group" := CustPostingGroupBuffer.code;
                    GenJournalLine.Modify();
                end;
            end else
                Error('The transaction setup for transaction %1 is missing', GenJournalLine."Transaction Type");
        end;

        if (GenJournalLine."Transaction Type" = GenJournalLine."transaction type"::"Deposit Contribution") then begin
            if GenJournalLine."Account Type" <> GenJournalLine."Account Type"::Customer then Error('Account Type must be Customer for Savings transactions. Line No:- %1', GenJournalLine."Line No.");
            if GenJournalLine."Account No." = '' then Error('Member No must be specified for Savings transactions. Line No:- %1', GenJournalLine."Line No.");

            if cust.get(GenJournalLine."Account No.") then
                if Cust.ISNormalMember = true then
                    if GenJournalLine."Transaction Type" = GenJournalLine."Transaction Type"::" " then
                        Error('Cannot post with missing transaction type.');
            TransactionTypestable.reset;
            TransactionTypestable.SetRange(TransactionTypestable."Transaction Type", GenJournalLine."Transaction Type");
            if TransactionTypestable.Find('-') then begin
                CustPostingGroupBuffer.Reset();
                CustPostingGroupBuffer.SetRange(Code, TransactionTypestable."Posting Group Code");
                if CustPostingGroupBuffer.FindFirst() then begin
                    CustPostingGroupBuffer.TestField(CustPostingGroupBuffer."Savings Account");
                    CustPostingGroupBuffer."Receivables Account" := CustPostingGroupBuffer."Savings Account";
                    CustPostingGroupBuffer.Modify();
                    GenJournalLine."Posting Group" := CustPostingGroupBuffer.code;
                    GenJournalLine.Modify();
                end;
            end else
                Error('The transaction setup for transaction %1 is missing', GenJournalLine."Transaction Type");
        end;


    end;


    [EventSubscriber(ObjectType::Codeunit, codeunit::"Gen. Jnl.-Post Line", 'OnAfterInitCustLedgEntry', '', false, false)]
    procedure InsertCustomTransactionFields(GenJournalLine: Record "Gen. Journal Line"; var CustLedgerEntry: Record "Cust. Ledger Entry")
    var
        cust: Record Customer;
    begin

        CustLedgerEntry."Transaction Type" := GenJournalLine."Transaction Type";
        CustLedgerEntry."Loan No" := GenJournalLine."Loan No";
        CustLedgerEntry."Loan Type" := GenJournalLine."Loan Product Type";
        CustLedgerEntry."Recoverd Loan" := GenJournalLine."Recoverd Loan";
        CustLedgerEntry."Recovery Transaction Type" := GenJournalLine."Recovery Transaction Type";
        CustLedgerEntry."Transaction Date" := WorkDate();
        CustLedgerEntry."Application Source" := GenJournalLine."Application Source";
        CustLedgerEntry."Created On" := CurrentDateTime;
        CustLedgerEntry.CalcFields(Amount);
        CustLedgerEntry."Transaction Amount" := GenJournalLine.Amount;
    end;

    [EventSubscriber(ObjectType::codeunit, codeunit::"Gen. Jnl.-Post Line", 'OnBeforeInsertDtldCustLedgEntry', '', false, false)]
    procedure InsertCustomfieldstodetailedcustledgerentry2(GenJournalLine: Record "Gen. Journal Line"; var DtldCustLedgEntry: Record "Detailed Cust. Ledg. Entry")
    begin

        DtldCustLedgEntry."Transaction Type" := GenJournalLine."Transaction Type";
        DtldCustLedgEntry."Loan No" := GenJournalLine."Loan No";
        DtldCustLedgEntry."Loan Type" := GenJournalLine."Loan Product Type";
        DtldCustLedgEntry."Recoverd Loan" := GenJournalLine."Recoverd Loan";
        DtldCustLedgEntry."Recovery Transaction Type" := GenJournalLine."Recovery Transaction Type";
        DtldCustLedgEntry."Transaction Date" := WorkDate();
        DtldCustLedgEntry."Application Source" := GenJournalLine."Application Source";
        DtldCustLedgEntry."Created On" := CurrentDateTime;
        DtldCustLedgEntry.Description := GenJournalLine.Description;
        // DtldCustLedgEntry.Insert(true);
        // Message('%1-%2-%3', DtldCustLedgEntry."Transaction Type", DtldCustLedgEntry."Loan No", DtldCustLedgEntry."Transaction Date");

    end;

    // [EventSubscriber(ObjectType::Table, 179, 'OnAfterReverseEntries', '', false, false)]
    // procedure modifyreversedCustLedger(Number: Integer)
    // var
    //     Custledger: Record "Cust. Ledger Entry";
    //     CustledgeentPage: page "Customer Ledger Entries";
    //     ReversalEntry: Record "Reversal Entry";
    //     DetailedCustLedgerEntry: Record "Detailed Cust. Ledg. Entry";
    // begin
    //     Custledger.reset;
    //     if Custledger.Findlast then begin
    //         Custledger.CalcFields(Amount);
    //         if Custledger.Reversed then
    //             Custledger."Transaction Amount" := Custledger.amount;
    //         Custledger.Modify();
    //     end;
    //     Custledger.Reset();
    //     //Custledger.SetRange(Custledger."Entry No.", DetailedCustLedgerEntry."Cust. Ledger Entry No.");
    //     Custledger.SetRange(Reversed, true);
    //     if Custledger.FindSet(true) then begin
    //         repeat
    //             //Message('here');
    //             DetailedCustLedgerEntry.Reset();
    //             DetailedCustLedgerEntry.SetRange(DetailedCustLedgerEntry."Cust. Ledger Entry No.", Custledger."Entry No.");
    //             if DetailedCustLedgerEntry.FindSet(true, true) then begin
    //                 DetailedCustLedgerEntry.Reversed := true;
    //                 DetailedCustLedgerEntry."Reversal Date" := Today;
    //                 DetailedCustLedgerEntry.Modify(true);
    //                 //Message('here2');
    //             end;
    //         until Custledger.Next = 0;
    //     end;
    // end;

    [EventSubscriber(ObjectType::Table, 179, 'OnAfterReverseEntries', '', false, false)]
    procedure modifyreversedCustLedger(Number: Integer)
    var
        Custledger: Record "Cust. Ledger Entry";
        CustledgeentPage: page "Customer Ledger Entries";
        ReversalEntry: Record "Reversal Entry";
        DetailedCustLedgerEntry: Record "Detailed Cust. Ledg. Entry";
    begin
        Custledger.reset;
        if Custledger.Findlast then begin
            // Custledger.CalcFields(Amount);
            if Custledger.Reversed then begin
                //     Custledger."Transaction Amount" := Custledger.amount;
                // Custledger.Modify();
                // //Message('here');
                DetailedCustLedgerEntry.Reset();
                // DetailedCustLedgerEntry.SetRange("Document No.", Custledger."Document No.");
                DetailedCustLedgerEntry.SetRange("Cust. Ledger Entry No.", Custledger."Entry No.");
                if DetailedCustLedgerEntry.FindSet() then begin
                    repeat
                        DetailedCustLedgerEntry.Reversed := true;
                        DetailedCustLedgerEntry."Reversal Date" := Today;
                        DetailedCustLedgerEntry."Reversed Cust Entry" := Format(Custledger."Entry No.");
                        DetailedCustLedgerEntry.Modify(true);
                    until DetailedCustLedgerEntry.Next() = 0;
                    //Message('here2');
                end;
            end;
        end;
    end;


}


