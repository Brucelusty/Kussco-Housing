report 50706 "Loans Repayment"
{
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = 'Layouts\LoanRepay.rdlc';
    dataset
    {
        dataitem("Loans Register";"Loans Register")
        {
            RequestFilterFields = "Client Code";
            DataItemTableView = sorting("Loan Product Type") where("Outstanding Balance" = filter(>0));
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
            column(Loan_Product_Type_Name;"Loan Product Type Name")
            {}
            column(Mode_Of_Application;"Mode Of Application")
            {}
            column(Application_Date;"Application Date")
            {}
            column(Repayment_Start_Date;"Repayment Start Date")
            {}
            column(Issued_Date;"Issued Date")
            {}
            column(Requested_Amount;"Requested Amount")
            {}
            column(Approved_Amount;"Approved Amount")
            {}
            column(Repayment;Repayment)
            {}
            column(Outstanding_Balance;"Outstanding Balance")
            {}
            column(Staff_No;"Staff No")
            {}
            column(Loan__No_;"Loan  No.")
            {}
            column(shareCap;shareCap)
            {}
            column(BOSADep;BOSADep)
            {}
            column(lastRepayment;lastRepayment)
            {}
            trigger OnAfterGetRecord() begin
                shareCap:= 0;
                BOSADep:= 0;

                vend.Reset();
                vend.SetRange("BOSA Account No", "Loans Register"."Client Code");
                if vend.Find('-') then begin
                    repeat
                        if vend."Account Type" = '101' then begin
                            vend.CalcFields(Balance);
                            shareCap:= vend.Balance;
                        end;
                        if vend."Account Type" = '102' then begin
                            vend.CalcFields(Balance);
                            BOSADep:= vend.Balance;
                        end;
                    until vend.next() = 0;
                end;

                lastRepayment:= 0D;
                detailedCust.Reset();
                detailedCust.SetRange("Loan No", "Loans Register"."Loan  No.");
                detailedCust.SetRange("Transaction Type", detailedCust."Transaction Type"::"Interest Paid");
                if detailedCust.FindLast() then begin
                    lastRepayment:= detailedCust."Posting Date";
                end;
            end;
        }
    }
    

    
   trigger OnPreReport();															
    begin															
    CompanyInfo.Get();															
    CompanyInfo.CalcFields(CompanyInfo.Picture);

    end;
    
    var
    myInt: Integer;
    shareCap: Decimal;
    BOSADep: Decimal;
    lastRepayment: Date;
    CompanyInfo: Record "Company Information";
    vend: Record Vendor;
    detailedCust: Record "Detailed Cust. Ledg. Entry";

}


