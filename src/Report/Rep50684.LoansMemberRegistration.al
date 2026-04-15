report 50684 "Loans Member Registration"
{
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = 'Layouts\loansmemberregister.rdlc';

    dataset
    {
        dataitem("Loans Register";"Loans Register")
        {
            DataItemTableView = WHERE(Posted=CONST(True), Reversed = filter(false));
            RequestFilterFields = "Application Date","Loan  No.","Client Code","Date Approved";
            column(LoanNo_LoansRegister;"Loans Register"."Loan  No.")
            {
            }
            column(ApplicationDate_LoansRegister;"Loans Register"."Application Date")
            {
            }
            column(LoanProductType_LoansRegister;"Loans Register"."Loan Product Type")
            {
            }
            column(ClientCode_LoansRegister;"Loans Register"."Client Code")
            {
            }
            column(ApprovedAmount_LoansRegister;"Loans Register"."Approved Amount")
            {
            }
            column(ApprovedBy_LoansRegister;"Loans Register"."Approved By")
            {
            }
            column(AppraisedBy_LoansRegister;"Loans Register"."Appraised By")
            {
            }
            column(CapturedBy_LoansRegister;"Loans Register"."Captured By")
            {
            }
            column(DisbursedBy_LoansRegister;"Loans Register"."Disbursed By")
            {
            }
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
            column(No;Serial)
            {
            }
            column(ClientName_LoansRegister;"Loans Register"."Client Name")
            {
            }
            column(LoanProductTypeName_LoansRegister;"Loans Register"."Loan Product Type Name")
            {
            }
            column(RegistrationTime_LoansRegister;"Loans Register"."Registration Time")
            {
            }
            column(AppraisedTime_LoansRegister;"Loans Register"."Appraised Time")
            {
            }
            column(DisbursedTime_LoansRegister;"Loans Register"."Disbursed Time")
            {
            }
            column(ExpectedDisbursementTime_LoansRegister;"Loans Register"."Expected Disbursement Time")
            {
            }
            column(ApprovedTime_LoansRegister;"Loans Register"."Approved Time")
            {
            }
            column(Employer_Code;"Employer Code")
            {

            }
            column(Staff_No;"Staff No")
            {
            }
            column(Requested_Amount;"Requested Amount")
            {}
            column(Top_Up_Amount;"Top Up Amount")
            {}
            column(Outstanding_Balance;"Outstanding Balance")
            {}
            column(Loan_Status;"Loan Status")
            {}
            trigger OnAfterGetRecord()
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
        
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                    field(CurrentDate;CurrentDate)
                    {
                    ApplicationArea = All;
                    }
                }
            }
        }
    }
       trigger OnPreReport();															
            begin															
                CompanyInfo.Get();															
                CompanyInfo.CalcFields(CompanyInfo.Picture);


                if CurrentDate = 0D then
                    CurrentDate := Today;
                DateFilter := '..' + format(CurrentDate);														
            end;

    var
       CompanyInfo: Record "Company Information";
        CurrentDate: Date;
        DateFilter: Text[30];
        Serial: Integer;

}




