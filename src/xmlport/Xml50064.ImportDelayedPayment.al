#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
XmlPort 50064 "Import Delayed Payment"
{
    Format = VariableText;

    schema
    {
        textelement(Delayed_Payment )
        {
            tableelement("Delayed Payment lines"; "Delayed Payment lines")
            {
                AutoReplace = true;
                XmlName = 'SalaryImport';
                fieldelement(Header; "Delayed Payment lines"."Payment Header No.")
                {
                }
                fieldelement(AccountNo; "Delayed Payment lines"."Staff No.")
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

