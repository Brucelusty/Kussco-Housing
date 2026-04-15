report 50663 "Accounts Balances"
{
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'Layouts/Accounts Balances.rdlc';

    dataset
    {
        dataitem(Vendor;Vendor)
        {
            DataItemTableView = sorting("No.")where("Creditor Type"=const("FOSA Account"),Balance=FILTER(>0));
            RequestFilterFields = "Account Type",Status,"Date Filter";
            column(FORMAT_TODAY_0_4_;FORMAT(TODAY,0,4))
            {
            }
            column(COMPANYNAME;COMPANYNAME)
            {
            }
            column(StaffNo_Vendor;Vendor."Payroll/Staff No2")
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

            trigger OnAfterGetRecord()
            begin
                Vendr.RESET;
                Vendr.SETRANGE(Vendr."No.", Vendor."No.");
                //Vendr.SETRANGE(Vendr."Account Type", Vendr."Account Type");
                IF AccountType.GET(Vendor."Account Type") THEN BEGIN
                ordinary := AccountType.Description;
                IF Vendr.Balance >0 THEN BEGIN
                Vendr.SETFILTER(Vendr.Balance, '>0');
                //IF Vendor.FIND('-') THEN BEGIN
                  Vendr.Balance := Vendor.Balance;
                  //Vendr."Account Type" := ordinary;
                    END;
                      END;

                // IF AccountType.GET(Vendor."Account Type") THEN BEGIN
                // ordinary := AccountType.Description;
                //       END;
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
        ordinary: Text;
        Datefilter: Date;
        CompanyInfo: Record "Company Information";
        Vendr: Record "Vendor";
        BalanceAmt: Decimal;
        Date: Date;
}

