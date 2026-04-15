#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
XmlPort 50088 "Import FOSA"
{
    Format = VariableText;

    schema
    {
        textelement(root)
        {
            tableelement(Vendor;Vendor)
            {
                AutoReplace = true;
                XmlName = 'Member';
                fieldelement(AAA; Vendor."Old FOSA Account NAV2016")
                {
                }
                fieldelement(A; Vendor."No.")
                {
                }
                fieldelement(B; Vendor.Name)
                {
                }
                fieldelement(C; Vendor.Address)
                {
                }
                fieldelement(D; Vendor."Address 2")
                {
                }
                fieldelement(E; Vendor.City)
                {
                    FieldValidate=no;
                }
                fieldelement(F; Vendor.Contact)
                {FieldValidate=no;
                }
                fieldelement(G; Vendor."Phone No.")
                {FieldValidate=no;
                }



                fieldelement(h; Vendor."Vendor Posting Group")
                {
                    FieldValidate=no;
                }
                fieldelement(i; Vendor.Blocked)
                {FieldValidate=no;
                }
                fieldelement(j; Vendor."ZIP Code")
                {FieldValidate=no;
                }
                fieldelement(k; Vendor."E-Mail")
                {
                    FieldValidate=no;
                }
                fieldelement(l; Vendor."Creditor Type")
                {FieldValidate=no;
                }


                
                fieldelement(m; Vendor."Personal No.")
                {FieldValidate=no;
                }
                fieldelement(n; Vendor."ID No.")
                {
                    FieldValidate=no;
                }
                fieldelement(o; Vendor."Mobile Phone No")
                {FieldValidate=no;
                }
                fieldelement(p; Vendor."Marital Status")
                {FieldValidate=no;
                }
                

                // fieldelement(q; Vendor."Registration Date")
                // {
                //     FieldValidate=no;
                // }
                fieldelement(r; Vendor."Registration Date")
                {FieldValidate=no;
                }
                fieldelement(s; Vendor."BOSA Account No")
                {FieldValidate=no;
                }
                 fieldelement(tT; Vendor."Passport No.")
                {
                    FieldValidate=no;
                }
                fieldelement(t; Vendor.Status)
                {
                    FieldValidate=no;
                }
                fieldelement(u; Vendor."Account Type")
                {FieldValidate=no;
                }
                fieldelement(v; Vendor."Date Of Birth")
                {FieldValidate=no;
                }
                fieldelement(w; Vendor."E-Mail (Personal)")
                {
                    FieldValidate=no;
                }
                fieldelement(x; Vendor."Sub-Location")
                {FieldValidate=no;
                }
                fieldelement(y; Vendor.District)
                {FieldValidate=no;
                }



                fieldelement(z; Vendor."Fixed Deposit Type")
                {
                    FieldValidate=no;
                }
                // fieldelement(aa; Vendor."Marital Status")
                // {FieldValidate=no;
                // }
                fieldelement(ab; Vendor."FD Maturity Date")
                {FieldValidate=no;
                }
                fieldelement(ac; Vendor.Gender)
                {
                    FieldValidate=no;
                }
                fieldelement(ad; Vendor."MPESA Mobile No")
                {FieldValidate=no;
                }
                fieldelement(ae; Vendor."Income Type")
                {FieldValidate=no;
                }
                fieldelement(af; Vendor."Employer Code")
                {
                    FieldValidate=no;
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

