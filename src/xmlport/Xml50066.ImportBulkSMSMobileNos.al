#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
XmlPort 50066 "Import Bulk SMS Mobile Nos"
{
    Format = VariableText;

    schema
    {
        textelement(Bulk_MobileNos)
        {
            tableelement("Bulk SMS Lines";"Bulk SMS Lines")
            {
                AutoReplace = true;
                XmlName = 'MobileNosImport';
                fieldelement(a; "Bulk SMS Lines".No)
                {
                }
                fieldelement(b; "Bulk SMS Lines"."Code")
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

