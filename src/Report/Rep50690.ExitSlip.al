report 50690 "Exit Slip"
{
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = 'Layouts\exitslip.rdlc';    

    
    dataset
    {
        dataitem("Membership Exist";"Membership Exist")
        {
            column(Member_No_;"Member No."){}
            column(Member_Name;"Member Name"){}
            column(ID_Number;"ID Number"){}
            column(Payroll_StaffNo;"Payroll/StaffNo")  {} 
            column(Member_Deposits;"Member Deposits"){}
            column(Share_Capital;"Share Capital"){}
            column(Unpaid_Dividends;"Unpaid Dividends"){}
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
            column(Total_Loan;"Total Loan"){}
            column(Total_Interest;"Total Interest"){}
            column(Total_Oustanding_Int_FOSA;"Total Oustanding Int FOSA"){}
            column(Total_FOSA_Account;"Total FOSA Account"){}
            column(MemberStatus;MemberStatus){} 
            column(AmountToDisburse; "Amount To Disburse"){}
            column(Application_Date;"Application Date"){}
            column(funeral; funeral){}
            column(SchoolFeesShares;SchoolFeesShares){}
            column(Withdrawal_Fee;"Withdrawal Fee"){}
            column(Exit_Notice_Date;"Exit Notice Date"){}
            column(Notice_Date;"Notice Date"){}
            column(Reason_For_Exit;"Reason For Exit"){}

            trigger OnAfterGetRecord()
            var
            sacco: Record "Sacco General Set-Up";
            begin
                sacco.Get();
                "Withdrawal Fee" := Sacco."Withdrawal Fee";
            end;
        }
    }
    

    trigger OnPreReport();															
    begin															
    CompanyInfo.Get();															
    CompanyInfo.CalcFields(CompanyInfo.Picture);
    end;
        
    var
        CompanyInfo: Record "Company Information";
        funeral: decimal;

}


