report 50691 "Salary loans"
{
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'Layouts\Salary loans.rdlc';

    dataset
    {
        dataitem("Salary Processing Lines";"Salary Processing Lines")
        {
            RequestFilterFields = "Account No.";
            // column(ClientCode;"Salary Processing Lines"."Client Code")
            // {
            // }
            column(ClientCode;"Salary Processing Lines"."Member No")
            {
            }
            column(No;"Salary Processing Lines"."No.")
            {
            }
            column(AccountNo;"Salary Processing Lines"."Account No.")
            {
            }
            column(StaffNo;"Salary Processing Lines"."Staff No.")
            {
            }
            column(Name;"Salary Processing Lines".Name)
            {
            }
            column(Amount;"Salary Processing Lines".Amount)
            {
            }
            column(DateFilter;"Salary Processing Lines"."Date Filter")
            {
            }
            column(Processed;"Salary Processing Lines".Processed)
            {
            }
            column(DocumentNo;"Salary Processing Lines"."Document No.")
            {
            }
            column(Date;"Salary Processing Lines".Date)
            {
            }
            column(NoSeries;"Salary Processing Lines"."No. Series")
            {
            }
            column(OriginalAccountNo;"Salary Processing Lines"."Original Account No.")
            {
            }
            column(MultipleSalary;"Salary Processing Lines"."Multiple Salary")
            {
            }
            column(Reversed;"Salary Processing Lines".Reversed)
            {
            }
            column(BranchReff;"Salary Processing Lines"."Branch Reff.")
            {
            }
            column(AccountName;"Salary Processing Lines"."Account Name")
            {
            }
            column(IDNo;"Salary Processing Lines"."ID No.")
            {
            }
            // column(BlockedAccounts;"Salary Processing Lines"."Blocked Accounts 0")
            // {
            // }
            column(BOSASchedule;"Salary Processing Lines"."BOSA Schedule")
            {
            }
            column(USER;"Salary Processing Lines".USER)
            {
            }
            column(Balances;"Salary Processing Lines"."Balance sl")
            {
            }
            column(LoanType;LoanType)
            {
            }
            column(Outstandingbalance;Outstandingbalance)
            {
            }
            column(TotalRepayment;TotalRepayment)
            {
            }
            column(LoanNo;LoanNo)
            {
            }

            trigger OnAfterGetRecord()
            begin
                Outstandingbalance:=0;
                TotalRepayment:=0;
                //LoanType:=0;
                LoansReg.RESET;
                LoansReg.SETRANGE(LoansReg."Staff No",StaffNo);
                LoansReg.SETRANGE(LoansReg."Loan  No.",LoanNo);
                 IF LoansReg.FIND('-') THEN BEGIN
                   LoansReg.CALCFIELDS(LoansReg."Outstanding Balance to Date");
                   LoanType:=LoansReg."Loan Product Type Name";
                   TotalRepayment:=LoansReg."Current Repayment";
                   LoanNo:=LoansReg."Loan  No.";
                   MESSAGE('%1 loan no',LoanNo);
                  // Outstandingbalance:=LoansReg."Outstanding Balance to Date";
                   //Outstandingbalance:=LoansReg."Amount Disbursed"-LoansReg."Outstanding Balance";
                   Outstandingbalance:=LoansReg."Outstanding Balance to Date";
                   END;
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
        Comp.GET;
        Comp.CALCFIELDS(Picture);
    end;

    var
        Serial: Integer;
        Comp: Record "Company Information";
        Outstandingbalance: Decimal;
        LoanNo: Code[20];
        TotalRepayment: Decimal;
        LoanType: Text;
        LoansReg: Record "Loans Register";
        StaffNo: Code[20];
}

