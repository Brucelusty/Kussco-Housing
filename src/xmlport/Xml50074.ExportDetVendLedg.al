xmlport 50074 ExportDetVendLedg
{
    Format = VariableText;
    PreserveWhiteSpace = true;
    TextEncoding = WINDOWS;

    schema
    {
        textelement(root)
        {
            tableelement("Detailed Vendor Ledg. Entry"; "Old Det Vendor Ledger Entries")
            {
                XmlName = 'table';
                fieldelement(a; "Detailed Vendor Ledg. Entry"."Entry No.")
                {
                    
                }
                fieldelement(b; "Detailed Vendor Ledg. Entry"."Vendor Ledger Entry No.")
                {
                }
                fieldelement(c; "Detailed Vendor Ledg. Entry"."Entry Type")
                {
                }
                fieldelement(d; "Detailed Vendor Ledg. Entry"."Posting Date")
                {
                }
                fieldelement(e; "Detailed Vendor Ledg. Entry"."Document Type")
                {
                }
                fieldelement(f; "Detailed Vendor Ledg. Entry"."Document No.")
                {
                }
                fieldelement(g; "Detailed Vendor Ledg. Entry".Amount)
                {
                }
                fieldelement(h; "Detailed Vendor Ledg. Entry"."Amount (LCY)")
                {
                }
                fieldelement(i; "Detailed Vendor Ledg. Entry"."Vendor No.")
                {
                }
                fieldelement(k; "Detailed Vendor Ledg. Entry"."User ID")
                {
                }
                fieldelement(p; "Detailed Vendor Ledg. Entry"."Debit Amount")
                {
                }
                fieldelement(q; "Detailed Vendor Ledg. Entry"."Credit Amount")
                {
                }
                fieldelement(r; "Detailed Vendor Ledg. Entry"."Debit Amount (LCY)")
                {
                }
                fieldelement(s; "Detailed Vendor Ledg. Entry"."Credit Amount (LCY)")
                {
                }
                fieldelement(t; "Detailed Vendor Ledg. Entry"."Initial Entry Due Date")
                {
                }
                fieldelement(u; "Detailed Vendor Ledg. Entry"."Initial Entry Global Dim. 1")
                {
                }
                fieldelement(v; "Detailed Vendor Ledg. Entry"."Initial Entry Global Dim. 2")
                {
                }
                fieldelement(ac; "Detailed Vendor Ledg. Entry"."Initial Document Type")
                {
                }
                fieldelement(ak; "Detailed Vendor Ledg. Entry"."Ledger Entry Amount")
                {
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

