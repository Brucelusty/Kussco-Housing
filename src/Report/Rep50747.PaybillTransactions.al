report 50747 "Paybill Transactions"
{
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    DefaultRenderingLayout = Paybill;
    
    dataset
    {
        dataitem("Paybill Transactions";"Paybill Transactions")
        {
            DataItemTableView = where(MSIDN = filter(<>'0124A062563600'));
            RequestFilterFields = TransID, Status, MSIDN, BillRefNumber, TransTime, TransAmount, IDNo;
            column(TransID;TransID)
            {}
            column(BillRefNumber;BillRefNumber)
            {}
            column(MSIDN;MSIDN)
            {}
            column(TransactionType;TransactionType)
            {}
            column(TransDate;TransTime)
            {}
            column(TransAmount;TransAmount)
            {}
            column(BusinessShortCode;BusinessShortCode)
            {}
            column(Status;Status)
            {}
            column(IDNo;IDNo)
            {}
            column(TransTime;TransTime)
            {}
            // column()
            // {}
            column(company_Pic;company.Picture)
            {}
            column(company_Name;company.Name)
            {}
            column(company_Address;company.Address)
            {}
            column(company_Phone;company."Phone No.")
            {}
            column(company_Email;company."E-Mail")
            {}
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
                group(GroupName)
                {
                    field(asAt;asAt)
                    {
                    ApplicationArea = All;
                        
                    }
                }
            }
        }
    }
    
    rendering
    {
        layout(Paybill)
        {
            Type = RDLC;
            LayoutFile = 'Layouts/PaybillTransactions.rdlc';
        }
    }

    trigger OnInitReport() begin
        company.Get();
        company.CalcFields(Picture);
        saccoGen.Get();
    end;
    
    var
    myInt: Integer;
    asAt: Date;
    company: Record "Company Information";
    saccoGen: Record "Sacco General Set-Up";
    paybillTrans: Record "Paybill Transactions";
}



