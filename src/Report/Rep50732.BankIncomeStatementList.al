report 50732 "Bank Income Statement List"
{
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'Layouts\BankIncomeStatementListConv.rdlc';
    Caption = 'Posted Bank Account Reconciliation Report';

    dataset
    {
        dataitem("Bank Account Statement"; "Bank Account Statement")
        {
            RequestFilterFields = "Bank Account No.", "Statement No.";
            column(BankAccountNo_BankAccountStatement; "Bank Account Statement"."Bank Account No.")
            {
            }
            column(StatementNo_BankAccountStatement; "Bank Account Statement"."Statement No.")
            {
            }
            column(StatementEndingBalance_BankAccountStatement; "Bank Account Statement"."Statement Ending Balance")
            {
            }
            column(StatementDate_BankAccountStatement; "Bank Account Statement"."Statement Date")
            {
            }
            column(BalanceLastStatement_BankAccountStatement; "Bank Account Statement"."Balance Last Statement")
            {
            }
            column(CashBookBalance_BankAccountStatement; "Bank Account Statement"."Cash Book Balance")
            {
            }
            column(BankCode; BankCode)
            {
            }
            column(BankAccountNo; BankAccountNo)
            {
            }
            column(BankName; BankName)
            {
            }
            column(BankAccountBalanceasperCashBook; BankAccountBalanceasperCashBook)
            {
            }
            column(UnpresentedChequesTotal; UnpresentedChequesTotal)
            {
            }
            column(UncreditedBanking; UncreditedBanking)
            {
            }
            column(CompanyName; CompanyInfo.Name)
            {
            }
            column(CompanyAddress; CompanyInfo.Address)
            {
            }
            dataitem("Bank Account Statement Line"; "Bank Account Statement Line")
            {
                DataItemLink = "Bank Account No."=FIELD("Bank Account No."),
                               "Statement No."=FIELD("Statement No.");
                DataItemTableView = WHERE(Reconciled=CONST(False),
                                          "Statement Amount"=FILTER(<0));
                column(BankAccountNo_BankAccountStatementLine;"Bank Account Statement Line"."Bank Account No.")
                {
                }
                column(StatementLineNo_BankAccountStatementLine;"Bank Account Statement Line"."Statement Line No.")
                {
                }
                column(StatementNo_BankAccountStatementLine;"Bank Account Statement Line"."Statement No.")
                {
                }
                column(StatementAmount_BankAccountStatementLine;"Bank Account Statement Line"."Statement Amount")
                {
                }
                column(Description_BankAccountStatementLine;"Bank Account Statement Line".Description)
                {
                }
                column(TransactionDate_BankAccountStatementLine;"Bank Account Statement Line"."Transaction Date")
                {
                }
                column(DocumentNo_BankAccountStatementLine;"Bank Account Statement Line"."Document No.")
                {
                }
                column(Debit_BankAccountStatementLine;"Bank Account Statement Line".Debit)
                {
                }
                column(Credit_BankAccountStatementLine;"Bank Account Statement Line".Credit)
                {
                }
                column(OpenType_BankAccountStatementLine;"Bank Account Statement Line"."Open Type")
                {
                }
            }
            dataitem("<Bank Account Statement Line1>";"Bank Account Statement Line")
            {
                DataItemLink = "Bank Account No."=FIELD("Bank Account No."),
                               "Statement No."=FIELD("Statement No.");
                DataItemTableView = WHERE(Reconciled=CONST(False),
                                          "Statement Amount"=FILTER(>0));
                column(BankAccountNo_BankAccountStatementLine1;"<Bank Account Statement Line1>"."Bank Account No.")
                {
                }
                column(StatementLineNo_BankAccountStatementLine1;"<Bank Account Statement Line1>"."Statement Line No.")
                {
                }
                column(StatementNo_BankAccountStatementLine1;"<Bank Account Statement Line1>"."Statement No.")
                {
                }
                column(StatementAmount_BankAccountStatementLine1;"<Bank Account Statement Line1>"."Statement Amount")
                {
                }
                column(Description_BankAccountStatementLine1;"<Bank Account Statement Line1>".Description)
                {
                }
                column(TransactionDate_BankAccountStatementLine1;"<Bank Account Statement Line1>"."Transaction Date")
                {
                }
                column(DocumentNo_BankAccountStatementLine1;"<Bank Account Statement Line1>"."Document No.")
                {
                }
                column(Debit_BankAccountStatementLine1;"<Bank Account Statement Line1>".Debit)
                {
                }
                column(OpenType_BankAccountStatementLine1;"<Bank Account Statement Line1>"."Open Type")
                {
                }
            }

            trigger OnAfterGetRecord()
            begin
                BankCode:='';
                BankAccountNo:='';
                BankName:='';
                BankAccountBalanceasperCashBook:=0;
                UnpresentedChequesTotal:=0;
                UncreditedBanking:=0;

                Bank.RESET;
                Bank.SETRANGE(Bank."No.","Bank Account No.");
                IF Bank.FIND('-') THEN BEGIN
                  BankCode:=Bank."No.";
                  BankAccountNo:=Bank."Bank Account No.";
                  BankName:=Bank.Name;
                 // Bank.CALCFIELDS(Bank.Balance);
                //  BankAccountBalanceasperCashBook:="Cash Book Balance";
                //    BankAccountBalanceasperCashBook:="Bank Account Statement"."Cash Book Balance";

                    Bank.SETRANGE(Bank."Date Filter",0D,"Statement Date");
                    Bank.CALCFIELDS(Bank."Net Change");
                    BankAccountBalanceasperCashBook:=Bank."Net Change";

                  BankStatementLine.RESET;
                  BankStatementLine.SETRANGE(BankStatementLine."Bank Account No.",Bank."No.");
                  BankStatementLine.SETRANGE(BankStatementLine."Statement No.","Statement No.");
                  BankStatementLine.SETRANGE(BankStatementLine.Reconciled,FALSE);
                  IF BankStatementLine.FIND('-') THEN REPEAT
                    IF BankStatementLine."Statement Amount"<0 THEN
                     UnpresentedChequesTotal:=UnpresentedChequesTotal+BankStatementLine."Statement Amount"
                    ELSE IF BankStatementLine."Statement Amount">0 THEN
                     UncreditedBanking:=UncreditedBanking+BankStatementLine."Statement Amount";
                  UNTIL BankStatementLine.NEXT=0;

                   UnpresentedChequesTotal:=UnpresentedChequesTotal*-1;

                  //BankStatementLine


                END;
            end;

            trigger OnPreDataItem()
            begin
                CompanyInfo.GET;
                CompanyInfo.CALCFIELDS(Picture);
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        Bank: Record 270;
        BankCode: Code[20];
        BankAccountNo: Code[20];
        BankName: Text;
        BankAccountBalanceasperCashBook: Decimal;
        UnpresentedChequesTotal: Decimal;
        UncreditedBanking: Decimal;
        BankStatementLine: Record 276;
        CompanyInfo: Record 79;
}



