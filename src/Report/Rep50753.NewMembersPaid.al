report 50753 "New Members Paid"
{
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    DefaultRenderingLayout = NewMembersPaid;
    
    dataset
    {
        dataitem(Customer;Customer)
        {
            DataItemTableView = where("Registration Fee Paid" = filter(>0));
            RequestFilterFields = "Registration Date";
            column(No_;"No.")
            {}
            column(Name;Name)
            {}
            column(Payroll_No;"Payroll No")
            {}
            column(ID_No_;"ID No.")
            {}
            column(Mobile_Phone_No;"Mobile Phone No")
            {}
            column(Registration_Date;"Registration Date")
            {}
            column(Registration_Fee_Paid;("Registration Fee Paid")*-1)
            {}
            column(fullyPaid;fullyPaid)
            {}
            column(company_Name;company.Name)
            {}
            column(company_Pic;company.Picture)
            {}
            column(company_Address;company.Address)
            {}
            column(company_Phone;company."Phone No.")
            {}
            column(company_Email;company."E-Mail")
            {}
            trigger OnAfterGetRecord() begin
                detailedCust.Reset();
                detailedCust.SetRange("Customer No.", Customer."No.");
                detailedCust.SetRange("Transaction Type", detailedCust."Transaction Type"::"Registration Fee");
                if detailedCust.Find('-') then begin
                    fullyPaid:= false;
                    Customer.CalcFields("Registration Fee Paid");
                    if (Customer."Registration Fee Paid")*-1 >= saccoGen."Registration Fee" then begin
                        fullyPaid := true;
                    end else begin
                        fullyPaid:= false;
                    end;
                end else begin
                    fullyPaid:= false;
                end;
            end;
        }
    }
    
    requestpage
    {
        AboutTitle = 'Paid Members';
        AboutText = 'New members.';
        layout
        {
            area(Content)
            {
                // group(GroupName)
                // {
                //     field(Name; SourceExpression)
                //     {
                        
                //     }
                // }
            }
        }
    
        actions
        {
            // area(processing)
            // {
            //     action(LayoutName)
            //     {
                    
            //     }
            // }
        }
    }
    
    rendering
    {
        layout(NewMembersPaid)
        {
            Type = RDLC;
            LayoutFile = 'Layouts/NewMembersPaidregFee.rdlc';
        }
    }
    trigger OnInitReport() begin
        saccoGen.Get();
        company.Get();
        company.CalcFields(Picture);
    end;
    
    var
    myInt: Integer;
    fullyPaid: Boolean;
    company: Record "Company Information";
    detailedCust: Record "Detailed Cust. Ledg. Entry";
    saccoGen: Record "Sacco General Set-Up";
}


