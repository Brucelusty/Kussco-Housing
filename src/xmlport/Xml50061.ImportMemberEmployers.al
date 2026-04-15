#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
XmlPort 50061 "Import Member Employers"
{
    Format = VariableText;

    schema
    {
        textelement(Salaries_Processing)
        {
            tableelement("Employer Members";"Employer Members")
            {
                AutoReplace = true;
                XmlName = 'EmployerImport';
                fieldelement(Header; "Employer Members"."Member No")
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

