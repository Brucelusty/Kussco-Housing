report 50024 "Dividends Register"
{
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'Layouts\Dividends Register.rdlc';

    dataset
    {
        dataitem(Members; Customer)
        {
            DataItemTableView = WHERE("Gross Dividends" = FILTER(<> 0), isnormalmember = filter(true));
            RequestFilterFields = "No.", "Date Filter";
            CalcFields = "Dividend Gross Interest Amount", "Dividend WHT Amount", "Deposits Gross Interest Amount", "Deposits WHT Amount";
            column(No_Members; Members."No.")
            {
            }
            column(Name_Members; Members.Name)
            {
            }
            column(Shares_Retained; "Shares Retained")
            {
            }
            column(Current_Shares; "Current Shares")
            {
            }
            column(GrossDividends_Members; Members."Dividend Gross Interest Amount")
            {
            }
            column(WtaxDividends_Members; Members."Dividend WHT Amount")
            {
            }
            column(NetDividends_Members; (Members."Dividend Gross Interest Amount" - "Dividend WHT Amount"))
            {
            }
            column(GrossInterest_Members; Members."Deposits Gross Interest Amount")
            {
            }
            column(WtaxInterest_Members; Members."Deposits WHT Amount")
            {
            }
            column(NetInterest_Members; (Members."Deposits Gross Interest Amount" - Members."Deposits WHT Amount"))
            {
            }
            column(No; Serial)
            {
            }
            column(CompName; CompanyInf.Name)
            {
            }
            column(CompCity; CompanyInf.City)
            {
            }
            column(CompPicture; CompanyInf.Picture)
            {
            }
            column(CompanyAddress; CompanyInf.Address)
            {
            }
            column(TotalDividends_Members; Members."Gross Dividends")
            {
            }

            trigger OnAfterGetRecord()
            begin
                Serial := Serial + 1;
            end;

            trigger OnPreDataItem()
            begin
                Serial := 0;
            end;
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

    labels
    {
    }

    trigger OnPreReport()
    begin
        CompanyInf.GET;
        CompanyInf.CALCFIELDS(Picture);
    end;

    var
        Serial: Integer;
        CompanyInf: Record 79;
}

