report 50762 "Deposits and Savings Report"
{
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    //DefaultRenderingLayout = LayoutName;

    DefaultLayout = RDLC;
    RDLCLayout = 'Layouts/DepositsandSavingsReport.rdlc';

    dataset
    {
       dataitem("Salary Details";"Salary Details")
        {
            DataItemTableView = sorting("Document Number") WHERE(Posted=CONST(True),"Posted"=FILTER(>0));
            RequestFilterFields = "Posting Date","Document Number","Entry No","FOSA Account No","Salary Type";

            column(PayrollNo_SalaryDetails; "Salary Details"."Payroll No")															
            {															
            }
            column(MemberNo_SalaryDetails; "Salary Details"."Member No")															
            {															
            }
            column(MemberName_SalaryDetails;"Salary Details"."Member Name")															
            {															
            }
            column(DocumentNo_SalaryDetails; "Salary Details"."Document Number")															
            {															
            }
            
        dataitem("Loans Register";"Loans Register")
        {
            DataItemTableView = sorting("Employer Code") WHERE(Posted=CONST(True), Reversed = const(false), "Loan Status" = filter(Disbursed | Issued));
            column(EmployerCode_LoansRegister; "Loans Register"."Employer Code")															
            {															
            }
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
            column(USERID;UserId)
            {
            }
            trigger OnAfterGetRecord()
            begin


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
    loanOffset: Record "Loan Offset Details";
    loans: Record "Loans Register";
    loanProduct: Record "Loan Products Setup";
    loanProductcharges: Record "Loan Product Charges";
    CurrentDate: Date;
    DateFilter: Text[30];
    Serial: Integer;netDisbursed: Decimal;
    loanProductchargesCode: Code[50];
    totalTopupPrincipal: Decimal;
    totalTopupInterest: Decimal;
    topupPrincipal: Decimal;
    topupInterest: Decimal;
    loanProcessingfee: Decimal;
    loanRefinancingcharge: Decimal;
    exciseDuty: Decimal;
    mainLoanprocessingFee: Decimal;
    mainLoanrefinancingCharge: Decimal;
    mainExciseduty: Decimal;
    loanProductType: Text[250];
    totalTopupdeductions: Decimal;
    topupDeductions: Decimal;
    totalshortterm: Decimal;
    totallongterm: Decimal;
    employercode: Record "Employers Register";
    
}




