#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
XmlPort 50059 "Import Checkoff Loans"
{
    Format = VariableText;
    //TransactionType = Update;

    schema
    {
        textelement(root)
        {
            tableelement("Checkoff Loans";"Checkoff Loans")
            {
                XmlName = 'Loans';
                fieldelement(CheckoffNo; "Checkoff Loans"."Entry No") { }
                fieldelement(PAYROLL_NO; "Checkoff Loans".Payroll) { }
                fieldelement(Loan_Product;"Checkoff Loans".Amount) { }


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

