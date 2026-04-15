#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
XmlPort 50011 "Import MembersM"
{
    Format = VariableText;

    schema
    {
        textelement(root)
        {
            tableelement("Members Register"; Customer)
            {
                XmlName = 'Member';
                
                fieldelement(A; "Members Register"."No.")
                {
                }
                fieldelement(B; "Members Register".Name)
                {
                }
                fieldelement(C; "Members Register"."Search Name")
                {
                }
                fieldelement(D; "Members Register"."Phone No.")
                {
                    FieldValidate=No;
                }
                fieldelement(E; "Members Register"."E-Mail")
                {
                    FieldValidate=No;
                }
                fieldelement(F; "Members Register"."Mobile Phone No.")
                {
                    FieldValidate=No;
                }
                fieldelement(G; "Members Register".Gender)
                {
                     FieldValidate=No;
                }
                fieldelement(H; "Members Register"."Date Of Birth")
                {
                     FieldValidate=No;
                }
                fieldelement(I; "Members Register"."Registration Date")
                {
                     FieldValidate=No;
                }
                fieldelement(J; "Members Register"."FOSA Account No.")
                {
                     FieldValidate=No;
                }
                fieldelement(K; "Members Register"."Employer Code")
                {
                     FieldValidate=No;
                }
                fieldelement(L; "Members Register"."Payroll No")
                {
                     FieldValidate=No;
                }
                fieldelement(M; "Members Register"."ID No.")
                {
                     FieldValidate=No;
                }
                fieldelement(N; "Members Register"."Mobile Phone No")
                {
                     FieldValidate=No;
                }
                fieldelement(O; "Members Register"."Withdrawal Date")
                {
                     FieldValidate=No;
                }
                fieldelement(P; "Members Register"."Old Account No")
                {
                     FieldValidate=No;
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

