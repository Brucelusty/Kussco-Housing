report 50742 "ESS Batch Report"
{
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    DefaultRenderingLayout = ESSRefundBatch;
    
    dataset
    {
        dataitem("ESS Refund Batch";"ESS Refund Batch")
        {
            column(ESSRef_Batch_No_;"ESSRef Batch No.")
            {}
            column(Captured_On;"Captured On")
            {}
            column(Captured_By;"Captured By")
            {}
            column(Approved_By;"Approved By")
            {}
            column(Approved_On;"Approved On")
            {}
            column(Posted_By;"Posted By")
            {}
            column(Posted_On;"Posted On")
            {}
            column(Total_Disbursed;"Total Disbursed")
            {}
            column(Description;Description)
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
            dataitem("ESS Refund";"ESS Refund")
            {
                DataItemLink = "Refund Batch No" = field("ESSRef Batch No.");
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
                column(ESSRef_No_;"ESSRef No.")
                {}
                // column()
                // {}
            }
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
        layout(ESSRefundBatch)
        {
            Type = RDLC;
            LayoutFile = 'Layouts/ESSRefundBatch.rdlc';
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


