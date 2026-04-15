report 50678 "Cheque Deposits"
{
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'Layouts\ChequeDeposits.rdlc';

    dataset
    {
        dataitem(Transactions; Transactions)
        {
            DataItemTableView = sorting(No);
            RequestFilterFields = No;
            column(No; No)
            {
            }
            column(Account_No; "Account No")
            {
            }
            column(Account_Name; "Account Name")
            {
            }
            column(BOSA_Account_No; "BOSA Account No")
            { }
            column(companyPicture; CompanyInfo.Picture)
            { }
            column(CompanyName; CompanyInfo.Name)
            { }
            column(CompanyAddress2; CompanyInfo."Address 2")
            { }
            column(CompanyAddress; CompanyInfo.Address)
            { }
            column(CompanyPhoneNo; CompanyInfo."Phone No.")
            { }
            column(CompanyEmail; CompanyInfo."E-Mail")
            { }
            column(Cheque_Clearing_Bank; "Cheque Clearing Bank")
            {
            }
            column(Amount; Amount)
            {
            }
            column(NumberText_1_; NumberText[1])
            {
            }
            column(Cheque_No; "Cheque No")
            { }
            column(Bank_Branch_Name; "Bank Branch Name")
            { }
            column(Bank_Name; "Bank Name")
            { }

            trigger OnPreDataItem();
            begin
                CompanyInfo.Get();
                CompanyInfo.CalcFields(CompanyInfo.Picture);
            end;

            trigger OnAfterGetRecord()
            begin
                CheckReport.InitTextVariable();
                CheckReport.FormatNoText(NumberText, Amount, ' ');
            end;
        }
    }

    var
        CompanyInfo: Record "Company Information";
        NumberText: array[2] of Text[80];
        CheckReport: Report Check;

}


