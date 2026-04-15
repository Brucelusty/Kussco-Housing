// #pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
// XmlPort 50009 "Import Salaries"
// {
//     Format = VariableText;

//     schema
//     {
//         textelement(Salaries_Processing)
//         {
//             tableelement("Salary Processing Lines"; "Salary Processing Lines")
//             {
//                 AutoReplace = true;
//                 XmlName = 'SalaryImport';
//                 fieldelement(Header; "Salary Processing Lines"."Salary Header No.")
//                 {
//                 }
//                 fieldelement(AccountNo; "Salary Processing Lines"."Staff No.")
//                 {
//                 }
//                 fieldelement(Amount; "Salary Processing Lines".Amount)
//                 {
//                 }
//                 fieldelement(Region; "Salary Processing Lines".Region)
//                 {
//                 }
//                 fieldelement(Grade; "Salary Processing Lines".Grade)
//                 {
//                 }
//             }
//         }
//     }

//     requestpage
//     {

//         layout
//         {
//         }

//         actions
//         {
//         }
//     }
// }

#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
XmlPort 50009 "Import Salaries"
{
    Format = VariableText;

    schema
    {
        textelement(Salaries_Processing)
        {
            tableelement("Salary Processing Lines"; "Salary Processing Lines")
            {
                AutoReplace = true;
                XmlName = 'SalaryImport';
                fieldelement(Header; "Salary Processing Lines"."Salary Header No.")
                {
                }
                fieldelement(AccountNo; "Salary Processing Lines"."Staff No.")
                {
                }
                fieldelement("MdosiNo"; "Salary Processing Lines"."Account No.")
                {
                }
                fieldelement(Amount; "Salary Processing Lines".Amount)
                {
                }
                // fieldelement(Region; "Salary Processing Lines".Region)
                // {
                // }
                // fieldelement(Grade; "Salary Processing Lines".Grade)
                // {
                // }
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

