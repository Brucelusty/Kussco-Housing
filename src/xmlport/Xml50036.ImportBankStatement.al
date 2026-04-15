#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
XmlPort 50036 "Import Bank Statement"
{
    Format = VariableText;

    schema
    {
        textelement(root)
        {
            tableelement("Imported Bank Statement New";"Imported Bank Statement New")
            {
                AutoReplace = true;
                XmlName = 'Member';
                fieldelement(A; "Imported Bank Statement New"."Bank Statement No")
                {
                }
                fieldelement(B; "Imported Bank Statement New".Date)
                {
                }
                fieldelement(C; "Imported Bank Statement New"."Transaction ID")
                {
                }
                fieldelement(D; "Imported Bank Statement New".Description)
                {
                }
                fieldelement(E; "Imported Bank Statement New".Amount)
                {
                    FieldValidate=no;
                }
                fieldelement(F; "Imported Bank Statement New"."Bank Code")
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

