#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
XmlPort 50094 "Import Recruitment"
{
    Format = VariableText;

    schema
    {
        textelement(Salaries_Processing)
        {
            tableelement("Recruitment Lines";"Recruitment Lines")
            {
                AutoReplace = true;
                XmlName = 'SalaryImport';
                fieldelement(Header; "Recruitment Lines"."Salary Header No.")
                {
                }
                fieldelement(AccountNo; "Recruitment Lines"."Staff No.")
                {
                }
                fieldelement(Amount; "Recruitment Lines".Amount)
                {
                }
                fieldelement(recruit; "Recruitment Lines"."Person Recruited")
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

