report 50740 "Fixed Deposit Receipts"
{
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'Layouts/FixedDepositReceipts.rdlc';

    dataset
    {
        dataitem(FixedDep; "Fixed Deposit")
        {
            RequestFilterFields = "FD No";
            column(FDNo_FixedDep; FixedDep."FD No")
            {
            }
            column(AccountNo_FixedDep; FixedDep."Account No")
            {
            }
            column(AccountName_FixedDep; FixedDep."Account Name")
            {
            }
            column(FdDuration_FixedDep; FixedDep."Fd Duration")
            {
            }
            column(Duration_FixedDep; FixedDep.Duration)
            {
            }
            column(Amount_FixedDep; FixedDep.Amount)
            {
            }
            column(InterestRate_FixedDep; FixedDep."Interest Rate")
            {
            }
            column(AmountAftermaturity_FixedDep; FixedDep."Amount After maturity")
            {
            }
            column(MaturityDate_FixedDep; FixedDep.MaturityDate)
            {
            }
            column(IDNO_FixedDep; FixedDep."ID NO")
            {
            }
            column(PostedDate_FixedDep; FixedDep."Posted Date")
            {
            }
            column(postedtime_FixedDep; FixedDep."posted time")
            {
            }
            column(WithholdingTax_FixedDep; FixedDep."Withholding Tax")
            {
            }
            column(interestLessTax_FixedDep; FixedDep.interestLessTax)
            {
            }
            column(InterestEarned_FixedDep; FixedDep."Interest Earned")
            {
            }
            column(Instructions_FixedDep; FixedDep."Upon Maturity")
            {
            }
            column(FDAcc;FDAcc)
            {
            }
            column(CompName; CompInf.Name)
            {
            }
            column(CompAddress; CompInf.Address)
            {
            }
            column(CompCity; CompInf.City)
            {
            }
            column(CompPicture; CompInf.Picture)
            {
            }
            column(FixedDate_FixedDep; FixedDep."Fixed Date")
            {
            }
            column(FixedBy_FixedDep; FixedDep."Fixed By")
            {
            }
            column(NumberText; NumberText[1])
            {
            }

            trigger OnAfterGetRecord()
            begin
                CheckReport.InitTextVariable();
                CheckReport.FormatNoText(NumberText, FixedDep.Amount, ' ');

                vend.Reset();
                vend.SetRange("ID No.", FixedDep."ID NO");
                vend.SetRange("Account Type", '108');
                if vend.Find('-') then begin
                    FDAcc := vend."No.";
                end;
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

    trigger OnPreReport()
    begin
        CompInf.GET();
        CompInf.CALCFIELDS(CompInf.Picture);
    end;

    var
        CompInf: Record 79;
        NumberText: array[2] of Text[80];
        LastFieldNo: Integer;
        FDAcc: Code[20];
        CheckReport: Report 1401;
        vend: Record Vendor;
}

