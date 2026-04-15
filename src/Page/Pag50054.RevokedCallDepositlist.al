page 50054 "Revoked Call Deposit list"
{
    ApplicationArea = All;
    CardPageID = "Call Deposit card";
    DeleteAllowed = false;
    Editable = false;
    PageType = List;
    SourceTable = "Fixed Deposit";
    SourceTableView = WHERE(Call = filter(True), Revoked = FILTER(true));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("FD No"; rec."FD No")
                {
                    Caption = 'Call No.';
                }
                field("Account No"; rec."Account No")
                {
                }
                field("Account Name"; rec."Account Name")
                {
                }
                field("Fd Duration"; rec."Fd Duration")
                {
                }
                field(Amount; rec.Amount)
                {
                }
                field(InterestRate; InterestRate)
                {
                }
                field("ID NO"; rec."ID NO")
                {
                    Editable = false;
                }
                field("Creted by"; rec."Created by")
                {
                }
                field(interestLessTax; rec.interestLessTax)
                {
                    Caption = '<interest Less Tax>';
                }
                field("Amount After maturity"; rec."Amount After maturity")
                {

                }
                field(Date; rec.Date)
                {
                    
                }
                field(MaturityDate; rec.MaturityDate)
                {
                }
                field(matured; rec.matured)
                {
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
        }
        area(processing)
        {
            action("Credit fixed deposit ")
            {
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = false;

                trigger OnAction()
                begin
                    //credit savings

                    IF rec.Credited = TRUE THEN
                        ERROR('This account has already been credited');

                    GenJournalLine.RESET;
                    GenJournalLine.SETRANGE("Journal Template Name", 'GENERAL');
                    GenJournalLine.SETRANGE("Journal Batch Name", 'FTRANS');
                    GenJournalLine.DELETEALL;

                    //MESSAGE('amount is %1',Amount);
                    AccP.RESET;
                    AccP.SETRANGE(AccP."ID No.", rec."ID NO");
                    IF AccP.FIND('-') THEN
                        REPEAT

                            IF AccP."Vendor Posting Group" = 'FIXED' THEN
                                fixedno := AccP."No.";
                            // IF fixedno='' THEN
                            //ERROR('open a fixed deposit account');
                            MESSAGE('debit fixed deposit %1', fixedno);

                        UNTIL AccP.NEXT = 0;

                    LineNo := LineNo + 10000;
                    GenJournalLine.INIT;
                    GenJournalLine."Journal Template Name" := 'GENERAL';
                    GenJournalLine."Journal Batch Name" := 'FTRANS';
                    GenJournalLine."Line No." := LineNo;
                    GenJournalLine."Account Type" := GenJournalLine."Account Type"::Vendor;
                    GenJournalLine."Account No." := fixedno;
                    GenJournalLine."Document No." := 'fixed deposit';
                    //IF "Account No"='00-0000000000' THEN
                    GenJournalLine.VALIDATE(GenJournalLine."Account No.");
                    GenJournalLine."Posting Date" := TODAY;
                    GenJournalLine.Description := 'Fixed deposit ';
                    GenJournalLine.VALIDATE(GenJournalLine."Currency Code");
                    GenJournalLine.Amount := -rec.Amount;
                    GenJournalLine.VALIDATE(GenJournalLine.Amount);
                    //GenJournalLine."Bal. Account Type":=GenJournalLine."Bal. Account Type"::Vendor;
                    //GenJournalLine."Bal. Account No.":=fixedno;
                    GenJournalLine.VALIDATE(GenJournalLine."Bal. Account No.");
                    GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                    GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                    GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 1 Code");
                    GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 2 Code");
                    //IF GenJournalLine.Amount<>0 THEN
                    GenJournalLine.INSERT;

                    //END credit fixed deposit


                    //Debit ordinary
                    LineNo := LineNo + 10000;
                    GenJournalLine.INIT;
                    GenJournalLine."Journal Template Name" := 'GENERAL';
                    GenJournalLine."Journal Batch Name" := 'FTRANS';
                    GenJournalLine."Line No." := LineNo;
                    GenJournalLine."Account Type" := GenJournalLine."Account Type"::Vendor;
                    GenJournalLine."Account No." := rec."Account No";
                    GenJournalLine."Document No." := Acc.Name;
                    //IF "Account No"='00-0000000000' THEN
                    GenJournalLine.VALIDATE(GenJournalLine."Account No.");
                    GenJournalLine."Posting Date" := TODAY;
                    GenJournalLine."Document No." := 'fixed deposit';
                    GenJournalLine.Description := 'Fixed deposit ';
                    GenJournalLine.VALIDATE(GenJournalLine."Currency Code");
                    GenJournalLine.Amount := rec.Amount;
                    GenJournalLine.VALIDATE(GenJournalLine.Amount);
                    //GenJournalLine."Bal. Account Type":=GenJournalLine."Bal. Account Type"::Vendor;
                    //GenJournalLine."Bal. Account No.":=fixedno;
                    GenJournalLine.VALIDATE(GenJournalLine."Bal. Account No.");
                    GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                    GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                    GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 1 Code");
                    GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 2 Code");
                    //IF GenJournalLine.Amount<>0 THEN
                    GenJournalLine.INSERT;
                    //end debit ordinary savings

                    //Post New
                    GenJournalLine.RESET;
                    GenJournalLine.SETRANGE("Journal Template Name", 'GENERAL');
                    GenJournalLine.SETRANGE("Journal Batch Name", 'FTRANS');
                    IF GenJournalLine.FIND('-') THEN BEGIN
                        CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post Sacco", GenJournalLine);
                    END;
                    rec.Credited := TRUE;
                    rec.MODIFY;
                    //END;
                end;
            }
        }
    }

    var
        GenJournalLine: Record 81;
        TCharges: Decimal;
        LineNo: Integer;
        AccountTypes: Record "Account Types-Saving Products";
        chqtransactions: Record "Transactions";
        Trans: Record "Transactions";
        TotalUnprocessed: Decimal;
        CustAcc: Record "Members Register";
        AmtAfterWithdrawal: Decimal;
        TransactionsRec: Record "Transactions";
        LoansTotal: Decimal;
        Interest: Decimal;
        InterestRate: Decimal;
        OBal: Decimal;
        Principal: Decimal;
        ATMTrans: Decimal;
        ATMBalance: Decimal;
        TotalBal: Decimal;
        DenominationsRec: Record "Denominations";
        TillNo: Code[20];
        FOSASetup: Record 312;
        Acc: Record 23;
        DValue: Record 349;
        AccP: Record 23;
        LoansR: Record "Loans Register";
        [InDataSet]
        "Transaction DateEditable": Boolean;
        Excise: Decimal;
        Echarge: Decimal;
        BankLedger: Record 271;
        SMSMessage: Record "SMS Messages";
        iEntryNo: Integer;
        Vend1: Record 23;
        TransDesc: Text;
        TransTypes: Record "Transaction Types";
        fixedno: Code[30];
        fixeddeposit: Record "Fixed Deposit";
        DActivity: Code[30];
        DBranch: Code[30];
}




