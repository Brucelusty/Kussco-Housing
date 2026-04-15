report 50743 "ESS Refund Slip"
{
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    DefaultRenderingLayout = ESSRefundSlip;
    
    dataset
    {
        dataitem("ESS Refund";"ESS Refund")
        {
            column(ESSRef_No_;"ESSRef No.")
            {}
            column(Member_No;"Member No")
            {}
            column(Member_Name;"Member Name")
            {}
            column(ESS_Account;"ESS Account")
            {}
            column(ESS_Refund;"ESS Refund")
            {}
            column(Early_Refund;"Early Refund")
            {}
            column(PF_No;"PF No")
            {}
            column(Refunded;Refunded)
            {}
            column(Captured_On;"Captured On")
            {}
            column(Registered_On;"Registered On")
            {}
            column(Maturing_On;"Maturing On")
            {}
            // column()
            // {}
        
            column(company_Pic; company.Picture)
            { }
            column(company_Name; company.Name)
            { }
            column(company_Address; company.Address)
            { }
            column(company_Phone; company."Phone No.")
            { }
            column(company_Email; company."E-Mail")
            { }
            column(company_Motto; company.Motto)
            { }
            
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

                }
            }
        }
    }
    
    rendering
    {
        layout(ESSRefundSlip)
        {
            Type = RDLC;
            LayoutFile = 'Layouts/ESSRefundSlip.rdlc';
        }
    }
    trigger OnInitReport() begin
        company.Get();
        company.CalcFields(Picture);
        earlyCharge:= 0;
        saccoGen.Get();
        earlyCharge:= saccoGen."ESS Refund-Early Charges";
    end;
    
    var
    myInt: Integer;
    earlyCharge: Decimal;
    cust: Record Customer;
    vend: Record Vendor;
    essBatch: Record "ESS Refund Batch";
    essRefund: Record "ESS Refund";
    company: Record "Company Information";
    saccoGen: Record "Sacco General Set-Up";
}
