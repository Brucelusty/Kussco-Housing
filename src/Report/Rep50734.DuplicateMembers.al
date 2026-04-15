report 50734 "Duplicate Members"
{
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    DefaultRenderingLayout = DuplicateMembers;
    
    dataset
    {
        dataitem(Customer;Customer)
        {
            DataItemTableView = where("No of ID Nos" = filter(>1), "ID No." = filter(<>''));
            column(Payroll_No;"Payroll No")
            {}
            column(No_;"No.")
            {}
            column(Name;Name)
            {}
            column(ID_No_;"ID No.")
            {}

            trigger OnAfterGetRecord() begin
                // cust.Reset();
                // cust.SetRange("Payroll No", Customer."Payroll No");
                // if cust.FindSet() then begin

                // end;
            end;
        }
    }
    
    requestpage
    {
    }
    
    rendering
    {
        layout(DuplicateMembers)
        {
            Type = rdlc;
            LayoutFile = 'Layouts/DuplicateMembers.rdlc';
        }
    }
    
    var
    myInt: Integer;
    cust: Record Customer;

}
