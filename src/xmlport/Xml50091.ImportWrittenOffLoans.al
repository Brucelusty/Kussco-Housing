xmlport 50091 "Import Written Off Loans"
{
    Direction = Import;
    Format = VariableText;
    
    schema
    {
        textelement(Root)
        {
            tableelement("Ledger_Buffer";"Import Buffer")
            {
                fieldattribute(a; Ledger_Buffer."Payroll No")
                {}
                fieldattribute(b; Ledger_Buffer."Employee Name")
                {}
                fieldattribute(c; Ledger_Buffer.Region)
                {}
                fieldattribute(d; Ledger_Buffer."Mobile Phone No")
                {}
                fieldattribute(e; Ledger_Buffer.Town)
                {}
                fieldattribute(f; Ledger_Buffer.Workstation)
                {}
            }
        }
    }
    
    requestpage
    {
        layout
        {
            area(content)
            {
            }
        }
    }
    
    var
        myInt: Integer;
}
