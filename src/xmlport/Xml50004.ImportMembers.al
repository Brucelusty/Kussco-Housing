#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
XmlPort 50004 "Import Members"
{
    Format = VariableText;

    schema
    {
        textelement(root)
        {
            tableelement(Customer;Customer)
            {
                AutoReplace = true;
                XmlName = 'Member';
                fieldelement(A; Customer."No.")
                {
                }
                fieldelement(B; Customer.ISNormalMember)
                {
                }
                fieldelement(C; Customer."Allow Multiple Posting Groups")
                {
                }
                fieldelement(D; Customer."Customer Posting Group")
                {
                }
                fieldelement(E; Customer.Name)
                {
                    FieldValidate=no;
                }
                fieldelement(F; Customer."First Name")
                {FieldValidate=no;
                }
                fieldelement(G; Customer."Middle Name")
                {FieldValidate=no;
                }



                fieldelement(h; Customer."Last Name")
                {
                    FieldValidate=no;
                }
                fieldelement(i; Customer.Contact)
                {FieldValidate=no;
                }
                fieldelement(j; Customer.Address)
                {FieldValidate=no;
                }
                fieldelement(k; Customer.City)
                {
                    FieldValidate=no;
                }
                fieldelement(l; Customer."Address 2")
                {FieldValidate=no;
                }
                fieldelement(m; Customer."Phone No.")
                {FieldValidate=no;
                }
                fieldelement(n; Customer."Post Code")
                {
                    FieldValidate=no;
                }
                fieldelement(o; Customer.City)
                {FieldValidate=no;
                }
                fieldelement(p; Customer."E-Mail")
                {FieldValidate=no;
                }
                

                fieldelement(q; Customer."Home Page")
                {
                    FieldValidate=no;
                }
                fieldelement(r; Customer."Registration Date")
                {FieldValidate=no;
                }
                fieldelement(s; Customer.Status)
                {FieldValidate=no;
                }
                 fieldelement(tT; Customer."Old Ordinary Account NAV2016")
                {
                    FieldValidate=no;
                }
                fieldelement(t; Customer."FOSA Account No.")
                {
                    FieldValidate=no;
                }
                fieldelement(u; Customer."Old Account No")
                {FieldValidate=no;
                }
                fieldelement(v; Customer."Date Of Birth")
                {FieldValidate=no;
                }
                fieldelement(w; Customer."E-Mail (Personal)")
                {
                    FieldValidate=no;
                }
                fieldelement(x; Customer."Payroll No")
                {FieldValidate=no;
                }
                fieldelement(y; Customer."ID No.")
                {FieldValidate=no;
                }



                fieldelement(z; Customer."Mobile Phone No")
                {
                    FieldValidate=no;
                }
                fieldelement(aa; Customer."Marital Status")
                {FieldValidate=no;
                }
                fieldelement(ab; Customer."Passport No")
                {FieldValidate=no;
                }
                fieldelement(ac; Customer.Gender)
                {
                    FieldValidate=no;
                }
                fieldelement(ad; Customer."Current Status")
                {FieldValidate=no;
                }
                fieldelement(ae; Customer."MPESA Mobile No")
                {FieldValidate=no;
                }
                fieldelement(af; Customer.Pin)
                {
                    FieldValidate=no;
                }
                fieldelement(ag; Customer."Contact Person")
                {FieldValidate=no;
                }
                fieldelement(ah; Customer."Contact Person Phone")
                {FieldValidate=no;
                }

                fieldelement(ai; Customer."Employer Name")
                {
                    FieldValidate=no;
                }
                fieldelement(aj; Customer."BOSA Account No.")
                {FieldValidate=no;
                }
                fieldelement(ak; Customer."Membership Status")
                {FieldValidate=no;
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

