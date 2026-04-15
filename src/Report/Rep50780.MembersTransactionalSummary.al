report 50780 "Members Transactional Summary"
{
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    DefaultRenderingLayout = MemberSummary;
    
    dataset
    {
        dataitem(Customer;Customer)
        {
            DataItemTableView = where(IsNormalMember = filter(true));
            RequestFilterFields = "No.", "Employer Code", "Payroll No", "ID No.", "Date Filter";
            // PrintOnlyIfDetail = true;
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
            column(totalPenaltyPaid;totalPenaltyPaid)
            {}
            column(totalInterestPaid;totalInterestPaid)
            {}
            column(totalPrincipalPaid;totalPrincipalPaid)
            {}
            column(totalLoans;totalLoans)
            {}
            column(accType;accType)
            {}
            column(totalShareCapCredits;totalShareCapCredits)
            {}
            column(totalShareCapDebits;totalShareCapDebits)
            {}
            column(totalDepositsCredits;totalDepositsCredits)
            {}
            column(totalDepositsDebits;totalDepositsDebits)
            {}
            column(totalSavingsCredits;totalSavingsCredits)
            {}
            column(totalSavingsDebits;totalSavingsDebits)
            {}
            column(totalESSCredits;totalESSCredits)
            {}
            column(totalESSDebits;totalESSDebits)
            {}
            column(totalWezeshaCredits;totalWezeshaCredits)
            {}
            column(totalWezeshaDebits;totalWezeshaDebits)
            {}
            column(totalJibambeCredits;totalJibambeCredits)
            {}
            column(totalJibambeDebits;totalJibambeDebits)
            {}
            column(totalPensionCredits;totalPensionCredits)
            {}
            column(totalPensionDebits;totalPensionDebits)
            {}
            column(totalMdosiJrCredits;totalMdosiJrCredits)
            {}
            column(totalMdosiJrDebits;totalMdosiJrDebits)
            {}
            column(totalBusinessCredits;totalBusinessCredits)
            {}
            column(totalBusinessDebits;totalBusinessDebits)
            {}
            column(totalFDCredits;totalFDCredits)
            {}
            column(totalFDDebits;totalFDDebits)
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
            trigger OnAfterGetRecord() begin
                // Get Filters
                datefilter := Customer.GetFilter("Date Filter");

                if datefilter = '' then datefilter := '..'+Format(Today);

                totalShareCapCredits := 0;
                totalDepositsCredits := 0;
                totalESSCredits := 0;
                totalWezeshaCredits := 0;
                totalJibambeCredits := 0;
                totalMdosiJrCredits := 0;
                totalFDCredits := 0;
                totalPensionCredits := 0;
                totalBusinessCredits := 0;
                totalShareCapDebits := 0;
                totalDepositsDebits := 0;
                totalESSDebits := 0;
                totalWezeshaDebits := 0;
                totalJibambeDebits := 0;
                totalMdosiJrDebits := 0;
                totalFDDebits := 0;
                totalPensionDebits := 0;
                totalBusinessDebits := 0;

                totalLoans := 0;
                totalPrincipalPaid := 0;
                totalInterestPaid := 0;

                vend.Reset();
                vend.SetRange("BOSA Account No", Customer."No.");
                vend.SetRange("Account Type", '101');
                if vend.Find('-') then begin
                    
                    detVend.Reset();
                    detVend.SetRange("Vendor No.", vend."No.");
                    detVend.SetRange(Reversed, false);
                    detVend.SetFilter("Credit Amount", '>%1', 0);
                    detVend.SetFilter("Posting Date", datefilter);
                    if detVend.FindSet() then begin
                        detVend.CalcSums("Credit Amount");
                        totalShareCapCredits := detVend."Credit Amount";
                    end;

                    detVend.Reset();
                    detVend.SetRange("Vendor No.", vend."No.");
                    detVend.SetRange(Reversed, false);
                    detVend.SetFilter("Debit Amount", '>%1', 0);
                    detVend.SetFilter("Posting Date", datefilter);
                    if detVend.FindSet() then begin
                        detVend.CalcSums("Debit Amount");
                        totalShareCapDebits := detVend."Debit Amount";
                    end;
                end;

                vend.Reset();
                vend.SetRange("BOSA Account No", Customer."No.");
                vend.SetRange("Account Type", '102');
                if vend.Find('-') then begin
                    
                    detVend.Reset();
                    detVend.SetRange("Vendor No.", vend."No.");
                    detVend.SetRange(Reversed, false);
                    detVend.SetFilter("Credit Amount", '>%1', 0);
                    detVend.SetFilter("Posting Date", datefilter);
                    if detVend.FindSet() then begin
                        detVend.CalcSums("Credit Amount");
                        totalDepositsCredits := detVend."Credit Amount";
                    end;

                    detVend.Reset();
                    detVend.SetRange("Vendor No.", vend."No.");
                    detVend.SetRange(Reversed, false);
                    detVend.SetFilter("Debit Amount", '>%1', 0);
                    detVend.SetFilter("Posting Date", datefilter);
                    if detVend.FindSet() then begin
                        detVend.CalcSums("Debit Amount");
                        totalDepositsDebits := detVend."Debit Amount";
                    end;
                end;

                vend.Reset();
                vend.SetRange("BOSA Account No", Customer."No.");
                vend.SetRange("Account Type", '103');
                if vend.Find('-') then begin
                    
                    detVend.Reset();
                    detVend.SetRange("Vendor No.", vend."No.");
                    detVend.SetRange(Reversed, false);
                    detVend.SetFilter("Credit Amount", '>%1', 0);
                    detVend.SetFilter("Posting Date", datefilter);
                    if detVend.FindSet() then begin
                        detVend.CalcSums("Credit Amount");
                        totalSavingsCredits := detVend."Credit Amount";
                    end;

                    detVend.Reset();
                    detVend.SetRange("Vendor No.", vend."No.");
                    detVend.SetRange(Reversed, false);
                    detVend.SetFilter("Debit Amount", '>%1', 0);
                    detVend.SetFilter("Posting Date", datefilter);
                    if detVend.FindSet() then begin
                        detVend.CalcSums("Debit Amount");
                        totalSavingsDebits := detVend."Debit Amount";
                    end;
                end;

                vend.Reset();
                vend.SetRange("BOSA Account No", Customer."No.");
                vend.SetRange("Account Type", '104');
                if vend.Find('-') then begin
                    
                    detVend.Reset();
                    detVend.SetRange("Vendor No.", vend."No.");
                    detVend.SetRange(Reversed, false);
                    detVend.SetFilter("Credit Amount", '>%1', 0);
                    detVend.SetFilter("Posting Date", datefilter);
                    if detVend.FindSet() then begin
                        detVend.CalcSums("Credit Amount");
                        totalESSCredits := detVend."Credit Amount";
                    end;

                    detVend.Reset();
                    detVend.SetRange("Vendor No.", vend."No.");
                    detVend.SetRange(Reversed, false);
                    detVend.SetFilter("Debit Amount", '>%1', 0);
                    detVend.SetFilter("Posting Date", datefilter);
                    if detVend.FindSet() then begin
                        detVend.CalcSums("Debit Amount");
                        totalESSDebits := detVend."Debit Amount";
                    end;
                end;
                vend.Reset();
                vend.SetRange("BOSA Account No", Customer."No.");
                vend.SetRange("Account Type", '106');
                if vend.Find('-') then begin
                    
                    detVend.Reset();
                    detVend.SetRange("Vendor No.", vend."No.");
                    detVend.SetRange(Reversed, false);
                    detVend.SetFilter("Credit Amount", '>%1', 0);
                    detVend.SetFilter("Posting Date", datefilter);
                    if detVend.FindSet() then begin
                        detVend.CalcSums("Credit Amount");
                        totalJibambeCredits := detVend."Credit Amount";
                    end;

                    detVend.Reset();
                    detVend.SetRange("Vendor No.", vend."No.");
                    detVend.SetRange(Reversed, false);
                    detVend.SetFilter("Debit Amount", '>%1', 0);
                    detVend.SetFilter("Posting Date", datefilter);
                    if detVend.FindSet() then begin
                        detVend.CalcSums("Debit Amount");
                        totalJibambeDebits := detVend."Debit Amount";
                    end;
                end;
                vend.Reset();
                vend.SetRange("BOSA Account No", Customer."No.");
                vend.SetRange("Account Type", '107');
                if vend.Find('-') then begin
                    
                    detVend.Reset();
                    detVend.SetRange("Vendor No.", vend."No.");
                    detVend.SetRange(Reversed, false);
                    detVend.SetFilter("Credit Amount", '>%1', 0);
                    detVend.SetFilter("Posting Date", datefilter);
                    if detVend.FindSet() then begin
                        detVend.CalcSums("Credit Amount");
                        totalWezeshaCredits := detVend."Credit Amount";
                    end;

                    detVend.Reset();
                    detVend.SetRange("Vendor No.", vend."No.");
                    detVend.SetRange(Reversed, false);
                    detVend.SetFilter("Debit Amount", '>%1', 0);
                    detVend.SetFilter("Posting Date", datefilter);
                    if detVend.FindSet() then begin
                        detVend.CalcSums("Debit Amount");
                        totalWezeshaDebits := detVend."Debit Amount";
                    end;
                end;
                vend.Reset();
                vend.SetRange("BOSA Account No", Customer."No.");
                vend.SetRange("Account Type", '108');
                if vend.Find('-') then begin
                    
                    detVend.Reset();
                    detVend.SetRange("Vendor No.", vend."No.");
                    detVend.SetRange(Reversed, false);
                    detVend.SetFilter("Credit Amount", '>%1', 0);
                    detVend.SetFilter("Posting Date", datefilter);
                    if detVend.FindSet() then begin
                        detVend.CalcSums("Credit Amount");
                        totalFDCredits := detVend."Credit Amount";
                    end;

                    detVend.Reset();
                    detVend.SetRange("Vendor No.", vend."No.");
                    detVend.SetRange(Reversed, false);
                    detVend.SetFilter("Debit Amount", '>%1', 0);
                    detVend.SetFilter("Posting Date", datefilter);
                    if detVend.FindSet() then begin
                        detVend.CalcSums("Debit Amount");
                        totalFDDebits := detVend."Debit Amount";
                    end;
                end;
                vend.Reset();
                vend.SetRange("BOSA Account No", Customer."No.");
                vend.SetRange("Account Type", '109');
                if vend.Find('-') then begin
                    
                    detVend.Reset();
                    detVend.SetRange("Vendor No.", vend."No.");
                    detVend.SetRange(Reversed, false);
                    detVend.SetFilter("Credit Amount", '>%1', 0);
                    detVend.SetFilter("Posting Date", datefilter);
                    if detVend.FindSet() then begin
                        detVend.CalcSums("Credit Amount");
                        totalMdosiJrCredits := detVend."Credit Amount";
                    end;

                    detVend.Reset();
                    detVend.SetRange("Vendor No.", vend."No.");
                    detVend.SetRange(Reversed, false);
                    detVend.SetFilter("Debit Amount", '>%1', 0);
                    detVend.SetFilter("Posting Date", datefilter);
                    if detVend.FindSet() then begin
                        detVend.CalcSums("Debit Amount");
                        totalMdosiJrDebits := detVend."Debit Amount";
                    end;
                end;
                vend.Reset();
                vend.SetRange("BOSA Account No", Customer."No.");
                vend.SetRange("Account Type", '110');
                if vend.Find('-') then begin
                    
                    detVend.Reset();
                    detVend.SetRange("Vendor No.", vend."No.");
                    detVend.SetRange(Reversed, false);
                    detVend.SetFilter("Credit Amount", '>%1', 0);
                    detVend.SetFilter("Posting Date", datefilter);
                    if detVend.FindSet() then begin
                        detVend.CalcSums("Credit Amount");
                        totalMdosiJrCredits := detVend."Credit Amount";
                    end;

                    detVend.Reset();
                    detVend.SetRange("Vendor No.", vend."No.");
                    detVend.SetRange(Reversed, false);
                    detVend.SetFilter("Debit Amount", '>%1', 0);
                    detVend.SetFilter("Posting Date", datefilter);
                    if detVend.FindSet() then begin
                        detVend.CalcSums("Debit Amount");
                        totalMdosiJrDebits := detVend."Debit Amount";
                    end;
                end;
                vend.Reset();
                vend.SetRange("BOSA Account No", Customer."No.");
                vend.SetRange("Account Type", '111');
                if vend.Find('-') then begin
                    
                    detVend.Reset();
                    detVend.SetRange("Vendor No.", vend."No.");
                    detVend.SetRange(Reversed, false);
                    detVend.SetFilter("Credit Amount", '>%1', 0);
                    detVend.SetFilter("Posting Date", datefilter);
                    if detVend.FindSet() then begin
                        detVend.CalcSums("Credit Amount");
                        totalBusinessCredits := detVend."Credit Amount";
                    end;

                    detVend.Reset();
                    detVend.SetRange("Vendor No.", vend."No.");
                    detVend.SetRange(Reversed, false);
                    detVend.SetFilter("Debit Amount", '>%1', 0);
                    detVend.SetFilter("Posting Date", datefilter);
                    if detVend.FindSet() then begin
                        detVend.CalcSums("Debit Amount");
                        totalBusinessDebits := detVend."Debit Amount";
                    end;
                end;

                detCust.Reset();
                detCust.SetRange("Customer No.", Customer."No.");
                detCust.SetRange(Reversed, false);
                detCust.SetRange("Transaction Type", detCust."Transaction Type"::Repayment);
                detCust.SetFilter("Posting Date", datefilter);
                if detcust.FindSet then begin
                    detCust.CalcSums("Credit Amount");
                    totalPrincipalPaid := detCust."Credit Amount";
                end;
                detCust.Reset();
                detCust.SetRange("Customer No.", Customer."No.");
                detCust.SetRange(Reversed, false);
                detCust.SetRange("Transaction Type", detCust."Transaction Type"::"Interest Paid");
                detCust.SetFilter("Posting Date", datefilter);
                if detcust.FindSet then begin
                    detCust.CalcSums("Credit Amount");
                    totalInterestPaid := detCust."Credit Amount";
                end;

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
        layout(MemberSummary)
        {
            Type = RDLC;
            LayoutFile = 'Layouts\MembersTransactionalSummary.rdlc';
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
    totalShareCapCredits: Decimal;
    totalDepositsCredits: Decimal;
    totalESSCredits: Decimal;
    totalWezeshaCredits: Decimal;
    totalJibambeCredits: Decimal;
    totalMdosiJrCredits: Decimal;
    totalFDCredits: Decimal;
    totalPensionCredits: Decimal;
    totalBusinessCredits: Decimal;
    totalShareCapDebits: Decimal;
    totalDepositsDebits: Decimal;
    totalESSDebits: Decimal;
    totalWezeshaDebits: Decimal;
    totalJibambeDebits: Decimal;
    totalMdosiJrDebits: Decimal;
    totalFDDebits: Decimal;
    totalPensionDebits: Decimal;
    totalBusinessDebits: Decimal;
    totalSavingsCredits: Decimal;
    totalSavingsDebits: Decimal;
    totalPrincipalPaid: Decimal;
    totalInterestPaid: Decimal;
    totalPenaltyPaid: Decimal;
    totalLoans: Decimal;
    accType: Text;
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



