#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
XmlPort 50087 "Update Member Data"
{
    Format = VariableText;

    schema
    {
        textelement(root)
        {
            tableelement("Member Ledger Entry";"Member Ledger Entry")
            {
                AutoReplace = true;
                XmlName = 'Member';
                fieldelement(A; "Member Ledger Entry"."Entry No.")
                {
                }
                fieldelement(B; "Member Ledger Entry"."Customer No.")
                {
                }
                fieldelement(C; "Member Ledger Entry"."Posting Date")
                {
                }
                fieldelement(D; "Member Ledger Entry"."Document Type")
                {
                }
                fieldelement(E;"Member Ledger Entry"."Document No.")
                {
                    FieldValidate=no;
                }
                fieldelement(F; "Member Ledger Entry".Description)
                {FieldValidate=no;
                }
                fieldelement(G; "Member Ledger Entry".Amount)
                {FieldValidate=no;
                }



                fieldelement(h; "Member Ledger Entry"."Amount (LCY)")
                {
                    FieldValidate=no;
                }
                fieldelement(i;"Member Ledger Entry"."Customer Posting Group")
                {FieldValidate=no;
                }
                fieldelement(j; "Member Ledger Entry"."Global Dimension 1 Code")
                {FieldValidate=no;
                }
                fieldelement(k; "Member Ledger Entry"."Global Dimension 2 Code")
                {
                    FieldValidate=no;
                }
                fieldelement(l; "Member Ledger Entry"."User ID")
                {FieldValidate=no;
                }
                fieldelement(m; "Member Ledger Entry"."Transaction Type")
                {FieldValidate=no;
                }
                fieldelement(n; "Member Ledger Entry"."Loan No")
                {
                    FieldValidate=no;
                }
                fieldelement(o; "Member Ledger Entry"."Debit Amount")
                {FieldValidate=no;
                }
                fieldelement(p; "Member Ledger Entry"."Credit Amount")
                {FieldValidate=no;
                }
                

                fieldelement(q; "Member Ledger Entry"."Debit Amount (LCY)")
                {
                    FieldValidate=no;
                }
                fieldelement(r; "Member Ledger Entry"."Credit Amount (LCY)")
                {FieldValidate=no;
                }
                fieldelement(s; "Member Ledger Entry"."Document Date")
                {FieldValidate=no;
                }
                fieldelement(t; "Member Ledger Entry".Reversed)
                {
                    FieldValidate=no;
                }
                fieldelement(u; "Member Ledger Entry"."Reversed Entry No.")
                {FieldValidate=no;
                }
                fieldelement(v; "Member Ledger Entry"."Reversed by Entry No.")
                {FieldValidate=no;
                }
                fieldelement(w;"Member Ledger Entry"."Loan Type")
                {
                    FieldValidate=no;
                }
              /*   fieldelement(x; "Member Data Update"."Payroll No")
                {FieldValidate=no;
                }
                fieldelement(y; "Member Data Update"."ID No.")
                {FieldValidate=no;
                }



                fieldelement(z; "Member Data Update"."Mobile Phone No")
                {
                    FieldValidate=no;
                }
                fieldelement(aa; "Member Data Update"."Marital Status")
                {FieldValidate=no;
                }
                fieldelement(ab; "Member Data Update"."Passport No")
                {FieldValidate=no;
                }
                fieldelement(ac; "Member Data Update".Gender)
                {
                    FieldValidate=no;
                }
                fieldelement(ad; "Member Data Update"."Current Status")
                {FieldValidate=no;
                }
                fieldelement(ae; "Member Data Update"."MPESA Mobile No")
                {FieldValidate=no;
                }
                fieldelement(af; "Member Data Update".Pin)
                {
                    FieldValidate=no;
                }
                fieldelement(ag; "Member Data Update"."Contact Person")
                {FieldValidate=no;
                }
                fieldelement(ah; "Member Data Update"."Contact Person Phone")
                {FieldValidate=no;
                }

                fieldelement(ai; "Member Data Update"."Employer Name")
                {
                    FieldValidate=no;
                }
                fieldelement(aj; "Member Data Update"."BOSA Account No.")
                {FieldValidate=no;
                }
                fieldelement(ak; "Member Data Update"."Membership Status")
                {FieldValidate=no;
                } */
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

