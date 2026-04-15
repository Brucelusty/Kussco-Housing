report 50664 "The Overdrawn Accounts"
{
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'Layouts/TheOverdrawnAccounts.rdlc';

    dataset
    {
        dataitem(Vendor;Vendor)
        {
            DataItemTableView = sorting("No.")where("Creditor Type"=const("FOSA Account"));
            RequestFilterFields = "Account Type",Status,"Date Filter","Last Transaction Date";
        
            column(FORMAT_TODAY_0_4_;FORMAT(TODAY,0,4))
            {
            }
            column(COMPANYNAME;COMPANYNAME)
            {
            }
            column(PayrollNo; Cust."Payroll No")
            {
            }
            column(Payroll_Staff_No2;"Payroll/Staff No2")
            {
                
            }
            column(Employer_Code;Vendor."Employer Code")
            {

            }
            column(USERID;USERID)
            {
            }
            column(Vendor__No__;"No.")
            {
            }
            column(Vendor_Name;Name)
            {
            }
            column(Vendor__Account_Type_;AccountType.Description)
            {
            }
            column(Vendor_Status;Status)
            {
            }
            column(Vendor__Balance__LCY__;"Balance (LCY)")
            {
            }
            column(Vendor__ID_No__;"ID No.")
            {
            }
            column(Rno;Rno)
            {
            }
            column(Vendor__Staff_No_;"Payroll/Staff No2")
            {
            }
            column(Vendor__Balance__LCY___Control1102760019;"Balance (LCY)")
            {
            }
            column(Accounts_BalancesCaption;Accounts_BalancesCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption;CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Account_No_Caption;Account_No_CaptionLbl)
            {
            }
            column(Vendor_NameCaption;FIELDCAPTION(Name))
            {
            }
            column(Vendor__Account_Type_Caption;FIELDCAPTION("Account Type"))
            {
            }
            column(Vendor_StatusCaption;FIELDCAPTION(Status))
            {
            }
            column(Vendor__Balance__LCY__Caption;FIELDCAPTION("Balance (LCY)"))
            {
            }
            column(Vendor__ID_No__Caption;FIELDCAPTION("ID No."))
            {
            }
            column(Vendor__Staff_No_Caption;FIELDCAPTION("Payroll/Staff No2"))
            {
            }
            column(No_Caption;No_CaptionLbl)
            {
            }
            column(DepositContribution_Vendor;Vendor."Deposit Contribution")
            {
            }
            column(SharesCapital_Vendor;Vendor."Shares Capital")
            {
            }
            column(Salaryearner_Vendor;Vendor."Salary earner")
            {
            }
            column(SalaryProcessing_Vendor;Vendor."Salary Processing")
            {
            }
            column(FOSALoans_Vendor;Vendor."FOSA Loans")
            {
            }
            column(Balance_Vendor;Vendor.Balance)
            {
            }
            column(CompanyPicture;CompanyInfo.Picture)
            {
            }
            column(Date;Date)
            {
            }
            column(Last_Transaction_Date;"Last Transaction Date")
            {

            }

            trigger OnAfterGetRecord()
            begin
            
                Rno := Rno+1;
            end;

            trigger OnPreDataItem()
            begin
                Rno := 0;
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
        CompanyInfo.GET();
        CompanyInfo.CALCFIELDS(CompanyInfo.Picture);
    end;

    var
        AccountType: Record "Account Types-Saving Products";
        UsersID: Record "User";
        RCount: Integer;
        Rno: Integer;
        Accounts_BalancesCaptionLbl: Label 'Accounts Balances';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        Account_No_CaptionLbl: Label 'Account No.';
        No_CaptionLbl: Label 'No.';
        Datefilter: Date;
        CompanyInfo: Record "Company Information";
        Vendr: Record "Vendor";
        BalanceAmt: Decimal;
        Date: Date;
        Cust: Record Customer;
}

