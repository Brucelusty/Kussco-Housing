report 50002 "All Fixed Deposit"
{
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './All Fixed Deposit.rdlc';

    dataset
    {
        dataitem(DataItem1; "Fixed Deposit")
        {
            DataItemTableView = WHERE(Fixed = FILTER(true));
            RequestFilterFields = "Account No", "Fixed Date", "ID NO", Amount, Duration;
            column(FDNo; "FD No")
            {
            }
            column(AccountNo; "Account No")
            {
            }
            column(AccountName; "Account Name")
            {
            }
            column(FdDuration; "Fd Duration")
            {
            }
            column(Amount; Amount)
            {
            }
            column(FixedDate_FixedDeposit; "Fixed Date")
            {
            }
            column(InterestRate; "Interest Rate")
            {
            }
            column(Cretedby; "Created by")
            {
            }
            column(InterestEarned_FixedDeposit; "Interest Earned")
            {
            }
            column(AmountAftermaturity; "Amount After maturity")
            {
            }
            column(FixingDate; Date)
            {
            }
            column(MaturityDate; MaturityDate)
            {
            }
            column(postedfixeddeposits; Posted)
            {
            }
            column(maturedFixedDeposits; matured)
            {
            }
            column(CreditedFixedDeposit; Credited)
            {
            }
            column(IDNO; "ID NO")
            {
            }
            column(PostedDate; "Posted Date")
            {
            }
            column(postedtime; "posted time")
            {
            }
            column(PostedBy; "Posted By")
            {
            }
            column(WithholdingTax; "Withholding Tax")
            {
            }
            column(interestLessTax; interestLessTax)
            {
            }
            column(StaffNumber_FixedDeposit; "Staff Number")
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

            trigger OnPreDataItem()
            begin
                //"Fixed Deposit".SETFILTER("Fixed Deposit".MaturityDate,'<=%1',TODAY);
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
}

