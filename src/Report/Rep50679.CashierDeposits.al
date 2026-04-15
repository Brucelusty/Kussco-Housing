report 50679 "Cashier Deposits"
{
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'Layouts\CashierDeposits.rdlc';


    dataset
    {
        dataitem(Transactions; Transactions)
        {
            DataItemTableView = sorting(No);
            RequestFilterFields = No;
            column(No; No)
            {
            }
            column(Account_No_; "Account No")
            { }
            column(Account_Name; "Account Name")
            { }
            column(Amount; Amount)
            {
            }
            column(NumberText_1_; NumberText[1])
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
            column(DepositerName; DepositerName)
            {

            }
            column(SourceofFunds; SourceofFunds)
            {

            }
            column(Purpose; Purpose)
            {

            }
            column(served; served)
            {

            }

            trigger OnPreDataItem();
            begin
                CompanyInfo.Get();
                CompanyInfo.CalcFields(CompanyInfo.Picture);
            end;

            trigger OnAfterGetRecord()
            var
                myInt: Integer;
            begin
                CheckReport.InitTextVariable();
                CheckReport.FormatNoText(NumberText, Amount, ' ');
            end;

        }
    }


    var
        CompanyInfo: Record "Company Information";
        CheckReport: Report Check;
        NumberText: array[2] of Text[80];

        DepositerName: Text[80];

        SourceofFunds: Text[30];

        Purpose: Text[70];

        Signature: Text[20];

        served: label 'You were served by :';

}


