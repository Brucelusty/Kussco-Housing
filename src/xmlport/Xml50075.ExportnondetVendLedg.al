xmlport 50075 ExportnondetVendLedg
{
    // Direction = Export;
    Format = VariableText;
    TextEncoding = WINDOWS;

    schema
    {
        textelement(root)
        {
            tableelement("Vendor Ledger Entry"; "Old Vendor Ledger")
            {
                XmlName = 'table';
                fieldelement(a; "Vendor Ledger Entry"."Entry No.")
                {
                }
                fieldelement(b; "Vendor Ledger Entry"."Vendor No.")
                {
                }
                fieldelement(c; "Vendor Ledger Entry"."Posting Date")
                {
                }
                fieldelement(d; "Vendor Ledger Entry"."Document Type")
                {
                }
                fieldelement(e; "Vendor Ledger Entry"."Document No.")
                {
                }
                fieldelement(f; "Vendor Ledger Entry".Description)
                {
                }
                fieldelement(g; "Vendor Ledger Entry".Amount)
                {
                }
                fieldelement(h; "Vendor Ledger Entry"."Amount (LCY)")
                {
                }
                fieldelement(i; "Vendor Ledger Entry"."Remaining Amt. (LCY)")
                {
                }
                fieldelement(j; "Vendor Ledger Entry"."Due Date")
                {
                }
                fieldelement(k; "Vendor Ledger Entry"."Date Filter")
                {
                }
                fieldelement(l; "Vendor Ledger Entry"."External Document No.")
                {
                }
                fieldelement(m; "Vendor Ledger Entry"."Debit Amount")
                {
                }
                fieldelement(n; "Vendor Ledger Entry"."Credit Amount")
                {
                }
                fieldelement(o; "Vendor Ledger Entry"."Global Dimension 1 Code")
                {
                }
                fieldelement(p; "Vendor Ledger Entry"."Global Dimension 2 Code")
                {
                }
                fieldelement(q; "Vendor Ledger Entry"."User ID")
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

