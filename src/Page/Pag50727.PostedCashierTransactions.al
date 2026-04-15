//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50727 "Posted Cashier Transactions"
{
    ApplicationArea = All;
    CardPageID = "Posted Cashier Transactions V1";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = Transactions;
    SourceTableView = where(Posted = filter(true));

    layout
    {
        area(content)
        {
            repeater(Control1102760000)
            {
                Editable = false;
                field(No; Rec.No)
                {
                }
                field("Account No";Rec."Account No")
                {
                }
                field("Account Name";Rec."Account Name")
                {
                }
                field("Transaction Type";Rec."Transaction Type")
                {
                }
                field(Amount; Rec.Amount)
                {
                }
                field("Account Balance";Rec."Account Balance")
                {
                }
                field("Expected Maturity Date";Rec."Expected Maturity Date")
                {
                }
                field(Cashier; Rec.Cashier)
                {
                }
                field("Transaction Date";Rec."Transaction Date")
                {
                }
                field("Amount Discounted";Rec."Amount Discounted")
                {
                    Editable = false;
                }
                field(Posted; Rec.Posted)
                {
                    Editable = true;
                }
                field("Clear Cheque";Rec."Clear Cheque")
                {
                }
                field("Bounce Cheque";Rec."Bounce Cheque")
                {
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Reports)
            {
                Caption = 'Reports';
                action("Daily Cashier Transactions")
                {
                    Caption = 'Transactions Report';
                    RunObject = report "Transactions Report";
                }
                action("Deposits Above 200k")
                {
                    Caption = 'Deposits Above 200k';
                    RunObject = report "Deposits Above 200k Report";
                }
                action("Withdrawals Above 100k")
                {
                    Caption = 'Withdrawals Above 100k';
                    RunObject = report "Withdrawals Above 100k Report";
                }
                action("Overdrawn Transactions")
                {
                    Caption = 'Overdrawn Over the Counter Transactions';
                    RunObject = report OverdrawnOTCTransactionsReport;
                }
                action("Teller Excess & Shortage Accounts")
                {
                    Caption = 'Teller Excess & Shortage Accounts';
                    RunObject = report "Teller Excess&Shortage Report";
                }
                action("Teller Closing Summary")
                {
                    Caption = 'Teller Closing Summary';
                    RunObject = report "Teller Closing Summary";
                }
            }
        }
    }

    var
        GenJournalLine: Record "Gen. Journal Line";
        GLPosting: Codeunit "Gen. Jnl.-Post Line";
        Account: Record Vendor;
        AccountType: Record "Account Types-Saving Products";
        LineNo: Integer;
        ChequeType: Record "Cheque Types";
        DimensionV: Record "Dimension Value";
        ChargeAmount: Decimal;
        DiscountingAmount: Decimal;
        Loans: Record "Loans Register";
        DActivity: Code[20];
        DBranch: Code[20];
        UsersID: Record User;
        Vend: Record Vendor;
        LoanType: Record "Loan Products Setup";
        BOSABank: Code[20];
        ReceiptAllocations: Record "Receipt Allocation";
        StatusPermissions: Record "Status Change Permision";


    procedure PostBOSAEntries()
    var
        ReceiptAllocation: Record "Receipt Allocation";
    begin
     


        LineNo := LineNo + 10000;

        GenJournalLine.Init;
        GenJournalLine."Journal Template Name" := 'PURCHASES';
        GenJournalLine."Journal Batch Name" := 'FTRANS';
        GenJournalLine."Document No." := Rec.No;
        GenJournalLine."External Document No." := Rec."Cheque No";
        GenJournalLine."Line No." := LineNo;
        GenJournalLine."Account Type" := GenJournalLine."account type"::"Bank Account";
        GenJournalLine."Account No." := BOSABank;
        GenJournalLine.Validate(GenJournalLine."Account No.");
        GenJournalLine."Posting Date" := Rec."Transaction Date";
        GenJournalLine.Description := Rec.Payee;
        GenJournalLine.Validate(GenJournalLine."Currency Code");
        GenJournalLine.Amount := -Rec.Amount;
        GenJournalLine.Validate(GenJournalLine.Amount);
        if GenJournalLine.Amount <> 0 then
            GenJournalLine.Insert;

        ReceiptAllocations.Reset;
        ReceiptAllocations.SetRange(ReceiptAllocations."Document No", Rec.No);
        if ReceiptAllocations.Find('-') then begin
            repeat

                LineNo := LineNo + 10000;

                GenJournalLine.Init;
                GenJournalLine."Journal Template Name" := 'PURCHASES';
                GenJournalLine."Journal Batch Name" := 'FTRANS';
                GenJournalLine."Line No." := LineNo;
                GenJournalLine."Document No." := Rec.No;
                GenJournalLine."External Document No." := Rec."Cheque No";
                GenJournalLine."Posting Date" := Rec."Transaction Date";
                if ReceiptAllocations."Transaction Type" = ReceiptAllocations."transaction type"::"Interest Paid" then begin
                    GenJournalLine."Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                    if Rec."Account No" = '502-00-000303-00' then
                        GenJournalLine."Account No." := '080023'
                    else
                        GenJournalLine."Account No." := '045003';
                    GenJournalLine.Validate(GenJournalLine."Account No.");
                    GenJournalLine.Description := Rec.Payee;
                end else begin
                    GenJournalLine."Account Type" := GenJournalLine."bal. account type"::Customer;
                    GenJournalLine."Account No." := ReceiptAllocations."Member No";
                    GenJournalLine.Validate(GenJournalLine."Account No.");
                    GenJournalLine.Description := Format(ReceiptAllocations."Transaction Type");
                end;
                GenJournalLine.Amount := ReceiptAllocations.Amount;
                GenJournalLine.Validate(GenJournalLine.Amount);
                if ReceiptAllocations."Transaction Type" = ReceiptAllocations."transaction type"::"Deposit Contribution" then
                    GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Deposit Contribution"
                else
                    if ReceiptAllocations."Transaction Type" = ReceiptAllocations."transaction type"::"Share Capital" then
                        GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Share Capital"
                    else
                       // if ReceiptAllocations."Transaction Type" = ReceiptAllocations."transaction type"::"Benevolent Fund" then
                          //  GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Loan Insurance Paid"
                        //else
                            if ReceiptAllocations."Transaction Type" = ReceiptAllocations."transaction type"::"Registration Fee" then
                                GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Registration Fee"
                            else
                                if ReceiptAllocations."Transaction Type" = ReceiptAllocations."Transaction Type"::Repayment then
                                    GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::Repayment;
                GenJournalLine."Loan No" := ReceiptAllocations."Loan No.";
                if GenJournalLine.Amount <> 0 then
                    GenJournalLine.Insert;

                if (ReceiptAllocations."Transaction Type" = ReceiptAllocations."transaction type"::"Registration Fee") and
                   (ReceiptAllocations."Interest Amount" > 0) then begin
                    LineNo := LineNo + 10000;

                    GenJournalLine.Init;
                    GenJournalLine."Journal Template Name" := 'PURCHASES';
                    GenJournalLine."Journal Batch Name" := 'FTRANS';
                    GenJournalLine."Line No." := LineNo;
                    GenJournalLine."Document No." := Rec.No;
                    GenJournalLine."External Document No." := Rec."Cheque No";
                    GenJournalLine."Posting Date" := Rec."Transaction Date";
                    GenJournalLine."Account Type" := GenJournalLine."bal. account type"::Customer;
                    GenJournalLine."Account No." := ReceiptAllocations."Member No";
                    GenJournalLine.Validate(GenJournalLine."Account No.");
                    GenJournalLine.Description := 'Interest Paid';
                    GenJournalLine.Amount := ReceiptAllocations."Interest Amount";
                    GenJournalLine.Validate(GenJournalLine.Amount);
                    GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Loan Insurance Paid";
                    GenJournalLine."Loan No" := ReceiptAllocations."Loan No.";
                    if GenJournalLine.Amount <> 0 then
                        GenJournalLine.Insert;

                end;

            until ReceiptAllocations.Next = 0;
        end;
    end;
}






