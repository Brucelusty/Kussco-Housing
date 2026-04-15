xmlport 50090 "Import Member Register Fee"
{
    Direction = Import;
    Format = VariableText;
    
    schema
    {
        textelement(Root)
        {
            tableelement("Ledger_Buffer";"Member Ledger Entries Buffer")
            {
                fieldattribute(a; Ledger_Buffer."Entry No")
                {}
                fieldattribute(b; Ledger_Buffer."Member No")
                {}
                fieldattribute(c; Ledger_Buffer."Document No")
                {}
                fieldattribute(d; Ledger_Buffer.Amount)
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
