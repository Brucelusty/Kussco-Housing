xmlport 50096 "Import New Vendor"
{
    Direction = Import;
    Format = VariableText;
    TextEncoding = UTF8;

    schema
    {
        textelement(root)
        {
            tableelement("New Vendor List"; "Old Vendor Details")
            {
                XmlName = 'table';
                AutoReplace = true;
                fieldelement(a; "New Vendor List"."Vendor No")
                {
                }
                fieldelement(b; "New Vendor List"."Last Trans Date")
                {
                    AutoCalcField = true;
                }
                fieldelement(c; "New Vendor List"."Last Trans Text")
                {
                    AutoCalcField = true;
                }
            }
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }
}

