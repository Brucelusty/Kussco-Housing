report 50727 "New Member Deposit Stmt"
{
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    DefaultRenderingLayout = MemberSavingsStmt;
    
    dataset
    {
        dataitem(Vendor;Vendor)
        {
            RequestFilterFields = "BOSA Account No", "Account Type";
            column(No_;"No.")
            {}
            column(Name;Name)
            {}
            column(Personal_No_;"Personal No.")
            {}
            column(ID_No_;"ID No.")
            {}
            column(BOSA_Account_No;"BOSA Account No")
            {}
            column(accType;accType)
            {}
            // column()
            // {}
            
            column(company_Pic;company.Picture)
            {}
            column(company_Name;company.Name)
            {}
            column(company_Add;company.Address)
            {}
            column(company_Phone;company."Phone No.")
            {}
            column(company_Email;company."E-Mail")
            {}
            dataitem("Detailed Vendor Ledg. Entry";"Detailed Vendor Ledg. Entry"){
                DataItemLink = "Vendor No." = field("No.");
                DataItemTableView = sorting("Vendor Ledger Entry No.", "Posting Date") where(Reversed = const(False));
                column(Posting_Date;"Posting Date")
                {}
                column(Vendor_No_;"Vendor No.")
                {}
                column(Document_No_;"Document No.")
                {}
                column(Description;Description)
                {}
                column(Credit_Amount;"Credit Amount")
                {}
                column(Debit_Amount;"Debit Amount")
                {}
                column(Amount;Amount)
                {}
                column(sumTotal;sumTotal)
                {}
                trigger OnPreDataItem() begin
                    sumTotal:= 0;
                end;
                trigger OnAfterGetRecord() begin
                    sumTotal:= sumTotal + ("Detailed Vendor Ledg. Entry".Amount*-1);
                end;
            }

            trigger OnAfterGetRecord() begin
                accountType.Reset();
                accountType.SetRange(Code, Vendor."Account Type");
                if accountType.Find('-') then begin
                    accType := accountType.Description;
                end;
            end;
        }
    }
    
    
    rendering
    {
        layout(MemberSavingsStmt)
        {
            Type = RDLC;
            LayoutFile = 'Layouts/MemberNewDepositStatement.rdlc';
        }
    }
    trigger OnInitReport() begin
        company.Get();
        company.CalcFields(Picture);
    end;
    
    var
    myInt: Integer;
    sumTotal: Decimal;
    accType: Code[50];
    company: Record "Company Information";
    accountType: Record "Account Types-Saving Products";
}
