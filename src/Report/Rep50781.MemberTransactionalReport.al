report 50781 "Member Transactional Report"
{
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    DefaultRenderingLayout = MemberStatement;
    
    dataset
    {
        dataitem(Customer;Customer)
        {
            DataItemTableView = where(IsNormalMember = filter(true));
            RequestFilterFields = "No.", "Payroll No", "ID No.", "Date Filter";
            PrintOnlyIfDetail = true;
            column(No_;"No.")
            {}
            column(Name;Name)
            {}
            column(ID_No_;"ID No.")
            {}
            column(Payroll_No;"Payroll No")
            {}
            column(Employer_Code;"Employer Code")
            {}
            column(Registration_Date;"Registration Date")
            {}
            // column()
            // {}
            column(companyInfo_Name;companyInfo.Name)
            {}
            column(companyInfo_Pic;companyInfo.Picture)
            {}
            column(companyInfo_Address;companyInfo.Address)
            {}
            column(companyInfo_Phone;companyInfo."Phone No.")
            {}

            dataitem(Vendor;Vendor)
            {
                DataItemLink = "BOSA Account No" = field("No."), "Date Filter" = field("Date Filter");
                column(Vendor_No_;"No.")
                {}
                column(Account_Type_Name;"Account Type Name")
                {}
                column(Balance;"Balance Filterable")
                {}
                column(totalSavingsCredits;totalSavingsCredits)
                {}
                column(totalSavingsDebits;totalSavingsDebits)
                {}

                trigger OnAfterGetRecord() begin
                    totalSavingsCredits := 0;
                    totalSavingsDebits := 0;

                    detVend.Reset();
                    detVend.SetRange("Vendor No.", Vendor."No.");
                    detVend.SetRange(Reversed, false);
                    detVend.SetFilter("Credit Amount", '>%1', 0);
                    detVend.SetFilter("Posting Date", datefilter);
                    if detVend.FindSet() then begin
                        detVend.CalcSums("Credit Amount");
                        totalSavingsCredits := detVend."Credit Amount";
                    end;

                    detVend.Reset();
                    detVend.SetRange("Vendor No.", Vendor."No.");
                    detVend.SetRange(Reversed, false);
                    detVend.SetFilter("Debit Amount", '>%1', 0);
                    detVend.SetFilter("Posting Date", datefilter);
                    if detVend.FindSet() then begin
                        detVend.CalcSums("Debit Amount");
                        totalSavingsDebits := detVend."Debit Amount";
                    end;
                end;

            }
            dataitem("Loan Products Setup";"Loan Products Setup")
            {
                DataItemTableView = where(InActive = filter(false));
                column(Code;Code)
                {}
                column(Product_Description;"Product Description")
                {}
                column(totalPenaltyPaid;totalPenaltyPaid)
                {}
                column(totalInterestPaid;totalInterestPaid)
                {}
                column(totalPrincipalPaid;totalPrincipalPaid)
                {}
                column(totalLoans;totalLoans)
                {}
                trigger OnAfterGetRecord() begin
                    totalLoans := 0;
                    totalPrincipalPaid := 0;
                    totalInterestPaid := 0;

                    // detCust.Reset();
                    // detCust.SetRange("Customer No.", Customer."No.");
                    // detCust.SetRange("Loan Type", "Loan Products Setup".Code);
                    // detCust.SetRange(Reversed, false);
                    // detCust.SetRange("Transaction Type", detCust."Transaction Type"::Loan);
                    // detCust.SetFilter("Posting Date", datefilter);
                    // if detcust.FindSet then begin
                    //     detCust.CalcSums("Debit Amount");
                    //     totalLoans := detCust."Debit Amount";
                    // end;
                    detCust.Reset();
                    detCust.SetRange("Customer No.", Customer."No.");
                    detCust.SetRange("Loan Type", "Loan Products Setup".Code);
                    detCust.SetRange(Reversed, false);
                    detCust.SetRange("Transaction Type", detCust."Transaction Type"::Repayment);
                    detCust.SetFilter("Posting Date", datefilter);
                    if detcust.FindSet then begin
                        detCust.CalcSums("Credit Amount");
                        totalPrincipalPaid := detCust."Credit Amount";
                    end;
                    detCust.Reset();
                    detCust.SetRange("Customer No.", Customer."No.");
                    detCust.SetRange("Loan Type", "Loan Products Setup".Code);
                    detCust.SetRange(Reversed, false);
                    detCust.SetRange("Transaction Type", detCust."Transaction Type"::"Interest Paid");
                    detCust.SetFilter("Posting Date", datefilter);
                    if detcust.FindSet then begin
                        detCust.CalcSums("Credit Amount");
                        totalInterestPaid := detCust."Credit Amount";
                    end;

                    if totalInterestPaid  + totalPrincipalPaid = 0 then CurrReport.Skip();
                end;
            }

            trigger OnAfterGetRecord() begin
                // Get Filters
                datefilter := Customer.GetFilter("Date Filter");

                if datefilter = '' then datefilter := '..'+Format(Today);
            end;
        }
    }
    
    requestpage
    {
        AboutTitle = 'Report Options';
        AboutText = 'Select the various options for adjusting how the display of the report will be.';
        layout
        {
            area(Content)
            {
                group(Options)
                {
                    Visible = false;
                    field(viewLoans;viewLoans)
                    {
                        Caption = 'View Individual Loans';
                    ApplicationArea = All;
                    }
                    field(viewSavings;viewSavings)
                    {
                        Caption = 'View Savings Accounts';
                    ApplicationArea = All;
                    }
                    field(viewDetails;viewDetails)
                    {
                        Caption = 'View A Detailed Preview';
                    ApplicationArea = All;
                    }
                }
            }
        }
    }
    
    rendering
    {
        layout(MemberStatement)
        {
            Type = RDLC;
            LayoutFile = 'Layouts\MemberTransactionalStatement.rdlc';
        }
    }
    
    trigger OnInitReport()
    begin
        companyInfo.Get();
        companyInfo.CalcFields(Picture);
    end;
    
    var
    myInt: Integer;
    viewDetails: Boolean;
    viewLoans: Boolean;
    viewSavings: Boolean;
    totalSavingsCredits: Decimal;
    totalSavingsDebits: Decimal;
    totalPrincipalPaid: Decimal;
    totalInterestPaid: Decimal;
    totalPenaltyPaid: Decimal;
    totalLoans: Decimal;
    datefilter: Text;
    detVend: Record "Detailed Vendor Ledg. Entry";
    detCust: Record "Detailed Cust. Ledg. Entry";
    loans: Record "Loans Register";
    vend: Record Vendor;
    employers: Record "Employers Register";
    saccoGen: Record "Sacco General Set-Up";
    accTypes: Record "Account Types-Saving Products";
    loanProducts: Record "Loan Products Setup";
    companyInfo: Record "Company Information";

}



