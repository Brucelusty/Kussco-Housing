page 50884 "Paybill Transactions"
{
    ApplicationArea = All;
    // DeleteAllowed = false;
    InsertAllowed = false;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "Paybill Transactions";
    SourceTableView = where(Status = filter(<> Posted), MSIDN = filter(<> '0124A062563600'));
    layout
    {
        area(Content)
        {
            repeater(Paybill)
            {
                field(TransID;Rec.TransID)
                {
                    Editable=false;
                    
                }
                field(TransactionType;Rec.TransactionType)
                {
                    Editable=false;
                    
                }
                field(TransTime;Rec.TransTime)
                {
                    Editable=false;
                    
                }
                field("Posted Date";Rec."Posted Date")
                {
                    Editable=false;
                }
                field("Posted Time";Rec."Posted Time")
                {
                    Editable=false;
                }
                field(TransAmount;Rec.TransAmount)
                {
                    Editable=false;
                    
                }
                field(BusinessShortCode;Rec.BusinessShortCode)
                {
                    Editable=false;
                    
                }
                field(BillRefNumber;Rec.BillRefNumber)
                {
                    
                }

                field(InvoiceNumber;Rec.InvoiceNumber)
                {
                    Editable=false;
                    
                }
                field(OrgAccountBalance;Rec.OrgAccountBalance)
                {
                    Editable=false;
                    
                }
                field(ThirdPartyTransID;Rec.ThirdPartyTransID)
                {
                    Editable=false;
                    
                }
                field(MSIDN;Rec.MSIDN)
                {
                    Editable=false;
                    
                }
                field(Status;Rec.Status)
                {
                    Editable=false;
                    
                }
                field(FirstName;Rec.FirstName)
                {
                    Editable=false;
                    
                }
                field(TransType;Rec.TransType)
                {
                    ShowMandatory = true;
                    // Editable=false;
                    
                }
                field(IDNo;Rec.IDNo)
                {
                    // Editable=false;
                }
            }
        }
        area(Factboxes)
        {
            
        }
    }
    
    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                Caption = 'Post Pending Transactions';
                Image = PostDocument;
                Promoted = true;
                PromotedCategory = Process;
                
                trigger OnAction();
                begin
                    if users.Get(UserId) then begin
                        if users."Post Pending ABC" = true then begin
                            pendingPost.RunPostPendingPaybillDelayed(Rec.TransID);
                        end else Error('%1 lacks rights post this transaction.', UserId);
                    end;
                end;
            }
            action(Action_Name)
            {
                Caption = 'Post Bulk Payment';
                Image = InsertBalanceAccount;
                Promoted = true;
                PromotedCategory = Process;
                Visible=false;
                trigger OnAction();
                begin
                    if users.Get(UserId) then begin
                        if users."Post Pending ABC" = true then begin
                            cust.Reset();
                            cust.SetRange("ID No.", Rec.IDNo);
                            if cust.Find('-') then begin
                                lineNo := 0;
                                docNo := Rec.TransID;
                                batchTemplate := 'PAYMENTS';
                                batchName := 'BULKPAY';

                                genJournal.Reset();
                                genJournal.SetRange("Journal Template Name", batchTemplate);
                                genJournal.SetRange("Journal Batch Name", batchName);
                                if genJournal.FindSet() then begin
                                    genJournal.DeleteAll();
                                end;

                                genBatches.Reset();
                                genBatches.SetRange("Journal Template Name", batchTemplate);
                                genBatches.SetRange(Name, batchName);
                                if genBatches.Find('-') = false then begin
                                    genBatches.Init();
                                    genBatches."Journal Template Name" := batchTemplate;
                                    genBatches.Name := batchName;
                                    genBatches.Description := 'Paybill Bulk Payments';
                                    genBatches.Insert();
                                end;

                                lineNo += 1000;
                                AUFactory.FnCreateGnlJournalLines(batchTemplate, batchName, docNo, lineNo, genJournal."Transaction Type"::" ", genJournal."Account Type"::"Bank Account",
                                'BNK00003', Today, Rec.TransAmount, 'FOSA', 'Paybill Bulk Payment', '');
                                lineNo += 1000;
                                AUFactory.FnCreateGnlJournalLines(batchTemplate, batchName, docNo, lineNo, genJournal."Transaction Type"::" ", genJournal."Account Type"::Vendor,
                                cust."Ordinary Savings Acc", Today, Rec.TransAmount * -1, 'FOSA', 'Paybill Bulk Payment', '');

                                loansReg.Reset();
                                loansReg.SetAutoCalcFields("Total Outstanding Balance");
                                loansReg.SetRange("Client Code", cust."No.");
                                loansReg.SetFilter("Total Outstanding Balance", '>%1', 0);
                                if loansReg.FindSet() then begin
                                    repeat
                                    loansReg.CalcFields("Outstanding Balance", "Outstanding Interest", "Outstanding Penalty");

                                    loanRepay.Reset();
                                    loanRepay.SetRange("Loan No.", loansReg."Loan  No.");
                                    loanRepay.SetFilter("Repayment Date", '<=%1', Today);
                                    if loanRepay.Find('-') then begin
                                        lineNo += 1000;
                                        AUFactory.FnCreateGnlJournalLine(batchTemplate, batchName, docNo, lineNo, genJournal."Transaction Type"::Repayment, genJournal."Account Type"::Customer,
                                        cust."No.", Today, loanRepay."Principal Repayment" *-1, 'BOSA', loansReg."Loan  No.", loansReg."Loan Product Type Name" + ' - Repayment', loansReg."Loan  No.", genJournal."Application Source"::CBS);
                                        lineNo += 1000;
                                        AUFactory.FnCreateGnlJournalLine(batchTemplate, batchName, docNo, lineNo, genJournal."Transaction Type"::" ", genJournal."Account Type"::Vendor,
                                        cust."Ordinary Savings Acc", Today, loanRepay."Principal Repayment", 'BOSA', loansReg."Loan  No.", loansReg."Loan Product Type Name" + ' - Repayment', loansReg."Loan  No.", genJournal."Application Source"::CBS);
                                        
                                    end;    
                                    lineNo += 1000;
                                    AUFactory.FnCreateGnlJournalLine(batchTemplate, batchName, docNo, lineNo, genJournal."Transaction Type"::"Interest Paid", genJournal."Account Type"::Customer,
                                    cust."No.", Today, loansReg."Outstanding Interest" *-1, 'BOSA', loansReg."Loan  No.", loansReg."Loan Product Type Name" + ' - Interest Repayment', loansReg."Loan  No.", genJournal."Application Source"::CBS);
                                    lineNo += 1000;
                                    AUFactory.FnCreateGnlJournalLine(batchTemplate, batchName, docNo, lineNo, genJournal."Transaction Type"::" ", genJournal."Account Type"::Vendor,
                                    cust."Ordinary Savings Acc", Today, loansReg."Outstanding Interest", 'BOSA', loansReg."Loan  No.", loansReg."Loan Product Type Name" + ' - Interest Repayment', loansReg."Loan  No.", genJournal."Application Source"::CBS);

                                    lineNo += 1000;
                                    AUFactory.FnCreateGnlJournalLine(batchTemplate, batchName, docNo, lineNo, genJournal."Transaction Type"::"Loan Penalty Paid", genJournal."Account Type"::Customer,
                                    cust."No.", Today, loansReg."Outstanding Penalty" *-1, 'BOSA', loansReg."Loan  No.", loansReg."Loan Product Type Name" + ' - Penalty Repayment', loansReg."Loan  No.", genJournal."Application Source"::CBS);
                                    lineNo += 1000;
                                    AUFactory.FnCreateGnlJournalLine(batchTemplate, batchName, docNo, lineNo, genJournal."Transaction Type"::" ", genJournal."Account Type"::Vendor,
                                    cust."Ordinary Savings Acc", Today, loansReg."Outstanding Penalty", 'BOSA', loansReg."Loan  No.", loansReg."Loan Product Type Name" + ' - Penalty Repayment', loansReg."Loan  No.", genJournal."Application Source"::CBS);

                                    until loansReg.Next() = 0;
                                end;

                                vend.Reset();
                                vend.SetRange("BOSA Account No", cust."No.");
                                vend.SetFilter("Account Type", '<>%1|%2', '101', '111');
                                if vend.FindSet() then begin
                                    repeat
                                    lineNo += 1000;
                                    AUFactory.FnCreateGnlJournalLines(batchTemplate, batchName, docNo, lineNo, genJournal."Transaction Type"::" ", genJournal."Account Type"::Vendor,
                                    vend."No.", Today, 2500 *-1, 'BOSA', getAccountType(vend."No.") + ' - Contribution', '');
                                    lineNo += 1000;
                                    AUFactory.FnCreateGnlJournalLines(batchTemplate, batchName, docNo, lineNo, genJournal."Transaction Type"::" ", genJournal."Account Type"::Vendor,
                                    cust."Ordinary Savings Acc", Today, 2500, 'BOSA', getAccountType(vend."No.") + ' - Contribution', '');

                                    until vend.Next() = 0;
                                end;

                                lineNo += 1000;
                                AUFactory.FnCreateGnlJournalLine(batchTemplate, batchName, docNo, lineNo, genJournal."Transaction Type"::" ", genJournal."Account Type"::Customer,
                                cust."No.", Today, 300 *-1, 'BOSA',  Cust."No.", 'Benevolent Fund Contribution', '', genJournal."Application Source"::CBS);
                                lineNo += 1000;
                                AUFactory.FnCreateGnlJournalLine(batchTemplate, batchName, docNo, lineNo, genJournal."Transaction Type"::" ", genJournal."Account Type"::Vendor,
                                cust."Ordinary Savings Acc", Today, 300, 'BOSA', Cust."No.", 'Benevolent Fund Contribution', '', genJournal."Application Source"::CBS);

                                lineNo += 1000;
                                AUFactory.FnCreateGnlJournalLine(batchTemplate, batchName, docNo, lineNo, genJournal."Transaction Type"::"Registration Fee", genJournal."Account Type"::Customer,
                                cust."No.", Today, 1000 *-1, 'BOSA', Cust."No.", 'Registration Fee Payment', '', genJournal."Application Source"::CBS);
                                lineNo += 1000;
                                AUFactory.FnCreateGnlJournalLine(batchTemplate, batchName, docNo, lineNo, genJournal."Transaction Type"::" ", genJournal."Account Type"::Vendor,
                                cust."Ordinary Savings Acc", Today, 1000, 'BOSA', Cust."No.", 'Registration Fee Payment', '', genJournal."Application Source"::CBS);

                                Commit();

                                genJournal.Reset();
                                genJournal.SetRange("Journal Template Name", batchTemplate);
                                genJournal.SetRange("Journal Batch Name", batchName);
                                if genJournal.Find('-') then begin
                                    journal.SetRecord(genJournal);
                                    journal.RunModal();
                                    Clear(journal);
                                end;

                                if Confirm(proceed, true) = false then exit;

                                Rec.Status := Rec.Status::Posted;
                                Rec.Modify;

                                if cust."Mobile Phone No" <> '' then begin
                                    SMSstr := 'Dear ' + Bname.NameStyle(Cust."No.") + ', MPESA deposit of ' + Format(Rec.TransAmount) + ' has been received on ' + Format(CurrentDateTime) + ' ."A penny saved is a penny earned"';
                                    smsManagement.SendSmsWithID(Source::DEPOSIT_CONFIRMATION, Cust."Mobile Phone No", SMSstr, Cust."No.", Cust."FOSA Account No.", TRUE, 200, TRUE, 'CBS', CreateGuid(), 'CBS');
                                end;
                            end else Error('The member with ID No.: %1 was not found', Rec.IDNo);
                        end else Error('%1 lacks rights post this transaction.', UserId);
                    end;
                end;
            }
        }
    }
    var
    lineNo: Integer;
    SMSstr: Text[1500];
    docNo: Code[20];
    batchTemplate: Code[20];
    batchName: Code[20];
    proceed: Label 'Do you wish to mark this transaction as posted and notify the member.';
    journal: Page "Payment Journal";
    Source: Option NEW_MEMBER,NEW_ACCOUNT,LOAN_ACCOUNT_APPROVAL,DEPOSIT_CONFIRMATION,CASH_WITHDRAWAL_CONFIRM,LOAN_APPLICATION,LOAN_APPRAISAL,LOAN_GUARANTORS,LOAN_REJECTED,LOAN_POSTED,LOAN_DEFAULTED,SALARY_PROCESSING,TELLER_CASH_DEPOSIT,TELLER_CASH_WITHDRAWAL,TELLER_CHEQUE_DEPOSIT,FIXED_DEPOSIT_MATURITY,INTERACCOUNT_TRANSFER,ACCOUNT_STATUS,STATUS_ORDER,EFT_EFFECTED,ATM_APPLICATION_FAILED,ATM_COLLECTION,MBANKING,MEMBER_CHANGES,CASHIER_BELOW_LIMIT,CASHIER_ABOVE_LIMIT,INTERNETBANKING,CRM,MOBILE_PIN;
    smsManagement: Codeunit "Sms Management";
    AUFactory: Codeunit "Au Factory";
    pendingPost: Codeunit "Post Pending Paybill Trans";
    Bname: Codeunit "Send Birthday SMS";
    users: Record "User Setup";
    genBatches: Record "Gen. Journal Batch";
    genJournal: Record "Gen. Journal Line";
    loansReg: Record "Loans Register";
    loanRepay: Record "Loan Repayment Schedule";
    vend: Record Vendor;
    cust: Record Customer;
    accTypes: Record "Account Types-Saving Products";

    trigger OnAfterGetRecord()
    var
        myInt: Integer;
        postedDate: Date;
        postedTime: Time;
    begin

        postedDate := DT2Date(Rec.TransTime);
        postedTime := DT2Time(Rec.TransTime);
        Rec."Posted Date" := postedDate;
        Rec."Posted Time" := postedTime;
    end;

    local procedure getAccountType(account: Code[20]) Type: Code[30]
    begin
        Vend.Reset();
        Vend.SetRange("No.", account);
        if Vend.Find('-') then begin
            if accTypes.Get(Vend."Account Type") then begin
                Type := accTypes.Description;
            end;
        end;
    end;
}


