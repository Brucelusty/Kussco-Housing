report 50065 "TransferBufferInterest"
{
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    // DefaultRenderingLayout = LayoutName;
    ProcessingOnly = true;

    dataset
    {
        dataitem("Loans Register"; "Loans Register")
        {
            RequestFilterFields = "Loan  No.", "Loan Disbursement Date", "Employer Code", "Recovery Mode";
            // DataItemTableView= where("Loan Product Type"=filter(<>'M_OD'|'M-BANKING ADVANCE'|'SALARY IN ADVANCE'));
            column(Client_Code; "Client Code")
            {

            }
            column(Exempt_Interest_Charging; "Exempt Interest Charging")
            {

            }
            trigger OnPreDataItem()
            var
                myInt: Integer;
            begin

                GenJournalLine.Reset();
                GenJournalLine.SetRange(GenJournalLine."Journal Template Name", 'GENERAL');
                GenJournalLine.SetRange(GenJournalLine."Journal Batch Name", 'INTDUE');
                if GenJournalLine.FindSet() then begin
                    GenJournalLine.DeleteAll();
                end;
            end;

            trigger OnAfterGetRecord()

            begin
                LoansRegister.Reset();//
                LoansRegister.SetRange(LoansRegister."Loan  No.", "Loans Register"."Loan  No.");
                LoansRegister.SetRange(Posted, true);
                LoansRegister.SetFilter(LoansRegister."Loans Category", '<>%1', LoansRegister."Loans Category"::Loss);
                LoansRegister.SetAutoCalcFields("Outstanding Balance");
                LoansRegister.SetFilter(LoansRegister."Outstanding Balance", '>%1', 0);
                if LoansRegister.Find('-') then begin
                    if LoanType.Get(LoansRegister."Loan Product Type") then begin
                        if LoanType."Non Recurring Interest" = false then begin
                            InterestAmount := 0;
                            if LoansRegister."Repayment Method" = LoansRegister."repayment method"::Amortised then begin
                                InterestAmount := ROUND(LoansRegister."Outstanding Balance" / 100 / 12 * LoanType."Interest rate", 1, '>');
                            end;
                            if LoansRegister."Repayment Method" = LoansRegister."repayment method"::"Reducing Balance" then begin
                                InterestAmount := ROUND(LoansRegister."Outstanding Balance" * LoanType."Interest rate" / 1200, 1, '>');
                            end;
                            if LoansRegister."Repayment Method" = LoansRegister."repayment method"::"Straight Line" then begin
                                InterestAmount := Round((LoanType."Interest rate" / 12 / 100) * LoansRegister."Approved Amount", 1, '>');
                            end;

                            DOCUMENT_NO := PadStr(DOCUMENT_NO, 5);

                            LineNo := LineNo + 10000;
                            AuFactory.FnCreateGnlJournalLineBalanced('GENERAL', 'INTDUE', DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::"Interest Due",
                            GenJournalLine."Account Type"::Customer, LoansRegister."Client Code", PostingDate, (InterestAmount), FORMAT(LoansRegister.Source), LoansRegister."Loan  No.",
                            'Interest Charged', LoansRegister."Loan  No.", GenJournalLine."Application Source"::" ", GenJournalLine."Account Type"::"G/L Account", LoanType."Loan Interest Account");
                            //credit income account
                            /*                         LineNo := LineNo + 10000;
                                                    AuFactory.FnCreateGnlJournalLine('GENERAL', 'INT', DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                                                   GenJournalLine."Account Type"::"G/L Account", LoanType."Receivable Interest Account", PostingDate, (((InterestAmount)) * -1), FORMAT(LoansRegister.Source), LoansRegister."Loan  No.",
                                                   'Interest Charged', LoansRegister."Loan  No.", GenJournalLine."Application Source"::" "); */

                        end;
                    end;
                end;


                LoansRegister.Reset();//
                LoansRegister.SetRange(LoansRegister."Loan  No.", "Loans Register"."Loan  No.");
                LoansRegister.SetRange(Posted, true);
                LoansRegister.SetRange(LoansRegister."Loans Category", LoansRegister."Loans Category"::Loss);
                LoansRegister.SetFilter("Employer Code", '%1|%2', 'KENYA POSTAL', 'POSTAL CORP');
                LoansRegister.SetFilter("Recovery Mode", '%1', "Loans Register"."Recovery Mode"::Salary);
                LoansRegister.SetAutoCalcFields("Outstanding Balance");
                LoansRegister.SetFilter(LoansRegister."Outstanding Balance", '>%1', 0);
                if LoansRegister.Find('-') then begin
                    if LoanType.Get(LoansRegister."Loan Product Type") then begin
                        if LoanType."Non Recurring Interest" = false then begin
                            InterestAmount := 0;
                            if LoansRegister."Repayment Method" = LoansRegister."repayment method"::Amortised then begin
                                InterestAmount := ROUND(LoansRegister."Outstanding Balance" / 100 / 12 * LoanType."Interest rate", 1, '>');
                            end;
                            if LoansRegister."Repayment Method" = LoansRegister."repayment method"::"Reducing Balance" then begin
                                InterestAmount := ROUND(LoansRegister."Outstanding Balance" * LoanType."Interest rate" / 1200, 1, '>');
                            end;
                            if LoansRegister."Repayment Method" = LoansRegister."repayment method"::"Straight Line" then begin
                                InterestAmount := Round((LoanType."Interest rate" / 12 / 100) * LoansRegister."Approved Amount", 1, '>');
                            end;

                            DOCUMENT_NO := PadStr(DOCUMENT_NO, 5);

                            LineNo := LineNo + 10000;
                            AuFactory.FnCreateGnlJournalLineBalanced('GENERAL', 'INTDUE', DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::"Interest Due",
                            GenJournalLine."Account Type"::Customer, LoansRegister."Client Code", PostingDate, (InterestAmount), FORMAT(LoansRegister.Source), LoansRegister."Loan  No.",
                            'Interest Charged', LoansRegister."Loan  No.", GenJournalLine."Application Source"::" ", GenJournalLine."Account Type"::"G/L Account", LoanType."Loan Interest Account");
                            //credit income account
                            /*                         LineNo := LineNo + 10000;
                                                    AuFactory.FnCreateGnlJournalLine('GENERAL', 'INT', DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                                                   GenJournalLine."Account Type"::"G/L Account", LoanType."Receivable Interest Account", PostingDate, (((InterestAmount)) * -1), FORMAT(LoansRegister.Source), LoansRegister."Loan  No.",
                                                   'Interest Charged', LoansRegister."Loan  No.", GenJournalLine."Application Source"::" "); */

                        end;
                    end;
                end;
            end;
        }

    }

    requestpage
    {
        SaveValues = false;
        layout
        {
            area(content)
            {
                field(PostingDate; PostingDate)
                {
                    ApplicationArea = All;
                }
                field(DOCUMENT_NO; DOCUMENT_NO)
                {
                    ApplicationArea = All;
                }

            }
        }
    }

    // rendering
    // {
    //     layout(LayoutName)
    //     {
    //         Type = RDLC;
    //         LayoutFile = 'mylayout.rdl';
    //     }
    // }

    var
        myInt: Integer;
        PostingDate: Date;
        LoansRegister: Record "Loans Register";
        AuFactory: Codeunit "Au Factory";
        LineNo: Integer;
        GenJournalLine: Record "Gen. Journal Line";
        DOCUMENT_NO: Code[100];
        generline: Record "Gen. Journal Line";
        InterestAmount: Decimal;

        LoanType: Record "Loan Products Setup";

    trigger OnPreReport()
    var
        myInt: Integer;
    begin
        GenJournalLine.Reset();
        GenJournalLine.SetRange(GenJournalLine."Journal Batch Name", 'INT');
        GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
        IF GenJournalLine.Find('-') THEN begin
            GenJournalLine.DeleteAll();
        end;
    end;
}


