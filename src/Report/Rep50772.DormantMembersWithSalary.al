report 50772 "Dormant Members With Salary"
{
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    DefaultRenderingLayout = DormantMembersWithSalary;
    
    dataset
    {
        dataitem(Customer;Customer)
        {
            DataItemTableView = where(isNormalMember = filter(true));
            RequestFilterFields = "No.";
            column(No_;"No.")
            {}
            column(Name;Name)
            {}
            column(Current_Shares;"Current Shares")
            {}
            column(Employer_Code;"Employer Code")
            {}
            column(Payroll_No;"Payroll No")
            {}
            // column()
            // {}
            column(companyInfo_Name;companyInfo.Name)
            {}
            column(companyInfo_Picture;companyInfo.Picture)
            {}

            trigger OnAfterGetRecord() begin
                vend.Reset();
                vend.SetRange("BOSA Account No", Customer."No.");
                vend.SetRange("Account Type", '103');
                if vend.Find('-') then begin
                    if (vend."Salary earner") or (vend."Salary Processing") then begin
                        detVend.Reset();
                        detVend.SetRange("Vendor No.", Customer."Deposits Account No");
                        detVend.SetFilter("Posting Date", '%1..%2', CalcDate('<-6M>', Today), Today);
                        detVend.SetFilter("Credit Amount", '>%1', 0);
                        if detVend.Find('-') = false then begin
                            dormant := true;
                        end else CurrReport.Skip();
                    end else CurrReport.Skip();
                end;
            end;
        }
    }
    
    requestpage
    {
        AboutTitle = 'Teaching tip title';
        AboutText = 'Teaching tip content';
        layout
        {
            // area(Content)
            // {
            //     group(GroupName)
            //     {
            //         field(Name; SourceExpression)
            //         {
                        
            //         }
            //     }
            // }
        }
    }
    
    rendering
    {
        layout(DormantMembersWithSalary)
        {
            Type = RDLC;
            LayoutFile = 'Layouts/DormantMembersWithSalary.rdlc';
        }
    }

    trigger OnInitReport() begin
        companyInfo.Get();
        companyInfo.CalcFields(Picture, "CEO Signature");
    end;
    
    var
        myInt: Integer;
        dormant: Boolean;
        companyInfo: Record "Company Information";
        detVend: Record "Detailed Vendor Ledg. Entry";
        detCust: Record "Detailed Cust. Ledg. Entry";
        vend: Record Vendor;
        vendII: Record Vendor;
}


