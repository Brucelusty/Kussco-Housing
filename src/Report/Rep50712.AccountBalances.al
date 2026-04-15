report 50712 "Account Balances"
{
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = 'Layouts\AccountBalances.rdlc';
    
    dataset
    {
        dataitem(Customer;Customer)
        {
            RequestFilterFields = "No.", "Date Filter";
            DataItemTableView = SORTING("No.") where(isNormalMember = filter(true));
            column(companyPicture; CompanyInfo.Picture)
            {}
            column(CompanyName; CompanyInfo.Name)
            {}
            column(CompanyAddress2; CompanyInfo."Address 2")
            {}
            column(CompanyAddress; CompanyInfo.Address)
            {}
            column(CompanyPhoneNo;CompanyInfo."Phone No.")
            {}
            column(CompanyEmail; CompanyInfo."E-Mail")
            {}

            column(Personal_No_;"Payroll No")
            {
                
            }
            column(No_;"No.")
            {
            }
            // column(Account_Type_Name;"Account Type Name"){}
            column(Name;Name)
            {}
            column(BOSA_Account_No;"No.")
            {}
            column(ID_No_;"ID No.")
            {}
            column(Employer_Code;"Employer Code"){}
            column(Mobile_Phone_No_;"Mobile Phone No"){}
            // column(Balance_Check;"Balance Check"){}
            column(Serial;Serial){}
            column(Share;"Shares Retained"){}
            column(Bosa;"Current Shares"){}
            column(OrdinarySavings;"FOSA  Account Bal"){}
            column(School_Fees_Shares;"School Fees Shares"){}
            column(Chamaa_Savings;"Chamaa Savings"){}
            column(Jibambe_Savings;"Jibambe Savings"){}
            column(Wezesha_Savings;"Wezesha Savings"){}
            column(Fixed_Deposit;"Fixed Deposit"){}
            column(Mdosi_Junior_Bal;"Total Mdosi Jr"){}
            column(Mdosi_Junior;"Mdosi Junior"){}
            column(Pension_Akiba;"Pension Akiba"){}
            column(Business_Account;"Business Account"){}

            trigger OnAfterGetRecord()
            var
                ObjCust: Record Customer;
                ObjAccounts: Record Vendor;
            begin
                Serial:=Serial+1;
            end;
            trigger OnPreDataItem()
            begin
                Serial:=0;
            end;
           
        }
    }
    
    requestpage
    {
        AboutTitle = 'Teaching tip title';
        AboutText = 'Teaching tip content';
        layout
        {
            area(Content)
            {
                group(General)
                {
                    // field(ASAT;ASAT)
                    // {
                    //     ShowMandatory = true;
                    // }
                }
            }
        }
    }
    trigger OnPreReport()
    begin
        CompanyInfo.GET();
        CompanyInfo.CALCFIELDS(CompanyInfo.Picture);
    end;
    
    var
    CompanyInfo: Record "Company Information";
    ledger: Record "Detailed Vendor Ledg. Entry";
    Cust:Record Customer;
    Vend: Record vendor;
    Serial: integer;
    mdosiJr: Decimal;
    ASAT: Date;
}


