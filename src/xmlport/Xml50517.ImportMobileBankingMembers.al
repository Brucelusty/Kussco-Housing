namespace TelepostSacco.TelepostSacco;

xmlport 50517 "Import Mobile Banking Members"
{
    Direction = Import;
    Format = VariableText;
    Caption = 'Import Mobile Banking Members';
    schema
    {
        textelement(RootNodeName)
        {
            tableelement(ImportMobileBankingMember; "Import Mobile Banking Member")
            {
                fieldelement(PhoneNo; ImportMobileBankingMember."Phone No.")
                {
                }
                fieldelement(IDNo; ImportMobileBankingMember."ID No.")
                {
                }
                // fieldelement(Mobile; ImportMobileBankingMember.Mobile)
                // {
                // }
                // fieldelement(Internet; ImportMobileBankingMember.Internet)
                // {
                // }
                // fieldelement(Status; ImportMobileBankingMember.Status)
                // {
                // }
            }
        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(Processing)
            {
            }
        }
    }
}
