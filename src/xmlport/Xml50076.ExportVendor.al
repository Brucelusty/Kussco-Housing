xmlport 50076 ExportVendor
{
    // Direction = Export;
    Format = VariableText;
    TextEncoding = WINDOWS;

    schema
    {
        textelement(root)
        {
            tableelement(Vendor; "Old Vendor")
            {
                XmlName = 'table';
                fieldelement(a; Vendor."No.")
                {
                }
                fieldelement(b; Vendor.Name)
                {
                }
                fieldelement(c; Vendor."Creditor Type")
                {
                }
                fieldelement(d; Vendor."Staff No")
                {
                }
                fieldelement(e; Vendor."BOSA Account No")
                {
                }
                fieldelement(f; Vendor."Account Type")
                {
                }
                fieldelement(g; Vendor."Uncleared Cheques")
                {
                }
                fieldelement(h; Vendor."Balance (LCY)")
                {
                }
                // fieldelement(i; Vendor."Date Filter")
                // {
                // }
                // fieldelement(j; Vendor."Global Dimension 1 Filter")
                // {
                // }
                // fieldelement(k; Vendor."Global Dimension 2 Filter")
                // {
                // }
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

