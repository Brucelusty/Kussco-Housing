report 50700 "Summary of Salary Deductions"
{
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'Layouts\Summary of Salary Deductions.rdlc';

    dataset
    {
        dataitem("Sacco Employers";"Sacco Employers")
        {
            RequestFilterFields = "Code",Description;
            column(CompanyName;CompanyInformation.Name)
            {
            }
            column(CompanyPic;CompanyInformation.Picture)
            {
            }
            column(Code_SaccoEmployers;"Sacco Employers".Code)
            {
            }
            column(Description_SaccoEmployers;"Sacco Employers".Description)
            {
            }
            column(NoOfFosaSalaryAccounts;NoOfFosaSalaryAccounts)
            {
            }
            column(NetSalaryPayout;NetSalaryPayout)
            {
            }
            column(LoanRepayments;LoanRepayments)
            {
            }
            column(InterestPaid;InterestPaid)
            {
            }
            column(DepositContribution;DepositContribution)
            {
            }
            column(EssShares;EssShares)
            {
            }
            column(BBF;BBF)
            {
            }
            column(StartDate;StartDate)
            {
            }
            column(EndDate;EndDate)
            {
            }

            trigger OnAfterGetRecord()
            var
                FosaAcc: Record "Vendor";
                GenJournalLine: Record "Gen. Journal Line";
            begin
                NoOfFosaSalaryAccounts :=0;NetSalaryPayout:=0;LoanRepayments:=0;InterestPaid:=0;DepositContribution:=0;EssShares:=0;BBF:=0;

                FosaAcc.RESET;
                FosaAcc.SETRANGE(FosaAcc."Territory Code","Sacco Employers".Code);
                FosaAcc.SETRANGE(FosaAcc."Account Type",'ORDINARY');
                FosaAcc.SETRANGE(FosaAcc."Salary Processing",TRUE);
                IF FosaAcc.FINDSET THEN BEGIN
                   NoOfFosaSalaryAccounts := FosaAcc.COUNT;
                   REPEAT
                     NetSalaryPayout += QueryFosa('Salary',FosaAcc."No.");
                     LoanRepayments += QueryFosa('Loan Repayment*',FosaAcc."No.");
                     InterestPaid += QueryFosa('Interest*',FosaAcc."No.");
                     DepositContribution += QueryBosa('*Deposit Contribution*',FosaAcc."BOSA Account No");
                     EssShares += QueryBosa('*SchFee Shares*',FosaAcc."BOSA Account No");
                     BBF += QueryBosa('*Benevolent*',FosaAcc."BOSA Account No");
                     LoanRepayments += QueryBosa(' Loan Repayment*',FosaAcc."BOSA Account No");
                     InterestPaid += QueryBosa(' Interest Paid*',FosaAcc."BOSA Account No");
                  UNTIL FosaAcc.NEXT = 0;
                  END;
            end;

            trigger OnPreDataItem()
            var
                err_date: Label 'Start date and End date must have a value!';
            begin
                IF (StartDate=0D) AND (EndDate=0D) THEN
                  ERROR(err_date);
                CompanyInformation.GET;
                CompanyInformation.CALCFIELDS(CompanyInformation.Picture);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Filters)
                {
                    field("Start Date";StartDate)
                    {
                    ApplicationArea = All;
                    }
                    field("End Date";EndDate)
                    {
                    ApplicationArea = All;
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage()
        begin
            StartDate := CALCDATE('-CM-1M',TODAY);
            EndDate := CALCDATE('CM',StartDate);
        end;
    }

    labels
    {
    }

    var
        DocumentNo: Code[20];
        NoOfFosaSalaryAccounts: Integer;
        NetSalaryPayout: Decimal;
        LoanRepayments: Decimal;
        InterestPaid: Decimal;
        DepositContribution: Decimal;
        StartDate: Date;
        EndDate: Date;
        FosaLedgerEntry: Record "Vendor Ledger Entry";
        EssShares: Decimal;
        BBF: Decimal;
        CompanyInformation: Record "Company Information";

    local procedure QueryFosa(Desc: Text;AccNo: Code[20]) Amt: Decimal
    begin
        Amt := 0;
        FosaLedgerEntry.RESET;
        FosaLedgerEntry.SETRANGE(FosaLedgerEntry."Vendor No.",AccNo);
        FosaLedgerEntry.SETRANGE(FosaLedgerEntry."Posting Date",StartDate,EndDate);
        FosaLedgerEntry.SETRANGE(FosaLedgerEntry."Journal Batch Name",'SALARIES');
        FosaLedgerEntry.SETFILTER(FosaLedgerEntry.Description,Desc);
        FosaLedgerEntry.SETAUTOCALCFIELDS(FosaLedgerEntry.Amount);
        IF FosaLedgerEntry.FINDSET THEN
          REPEAT
           Amt += ABS(FosaLedgerEntry.Amount);
        UNTIL FosaLedgerEntry.NEXT = 0;
        EXIT(Amt);
    end;

    local procedure QueryBosa(Desc: Text;MembaNo: Code[20]) Amt: Decimal
    var
        MemLedger: Record "Member Ledger Entry";
    begin
        Amt := 0;
        MemLedger.RESET;
        MemLedger.SETRANGE(MemLedger."Customer No.",MembaNo);
        MemLedger.SETRANGE(MemLedger."Posting Date",StartDate,EndDate);
        MemLedger.SETRANGE(MemLedger."Journal Batch Name",'SALARIES');
        MemLedger.SETFILTER(MemLedger.Description,Desc);
        IF MemLedger.FINDSET THEN
          REPEAT
              Amt += ABS(MemLedger.Amount);
            UNTIL MemLedger.NEXT = 0;
        EXIT(Amt);
    end;
}




