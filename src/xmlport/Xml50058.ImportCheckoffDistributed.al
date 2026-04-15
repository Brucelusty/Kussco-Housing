#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
XmlPort 50058 "Import Checkoff Distributed"
{
    Format = VariableText;
    //TransactionType = Update;

    schema
    {
        textelement(root)
        {
            tableelement("Checkoff Lines-Distributed"; "Checkoff Lines-Distributed-NT")

            {
                XmlName = 'Paybill';
                fieldelement(CheckoffNo; "Checkoff Lines-Distributed"."Checkoff No") { }
                fieldelement(PAYROLL_NO; "Checkoff Lines-Distributed"."Payroll No") { }
                fieldelement(Amount; "Checkoff Lines-Distributed".amount) { }

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

