report 50022 "Dividend Slip"
{
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'Layouts/Dividend Slip.rdlc';

    dataset
    {
        dataitem(Members; Customer)
        {
            column(Picture; CompanyInformation.Picture)
            {
            }
            column(Name; CompanyInformation.Name)
            {
            }
            column(No_Members; Members."No.")
            {
            }
            column(Name_Members; Members.Name)
            {
            }
            column(GrossDividends; GrossDividends)
            {
            }
            column(WithholdingTax; WithholdingTax)
            {
            }
            column(NetDividends; NetDividends)
            {
            }
            column(QualifyingShares; QualifyingShares * -1)
            {
            }
            column(IntCapitalizingAmount; IntCapitalizingAmount)
            {
            }
            column(Year; Year)
            {
            }
            column(CapitalInt; CapitalInt)
            {
            }
            column(GrossDividends_Members; -GrossDividends)
            {
            }
            column(WtaxDividends_Members; -WithholdingTaxDividends)
            {
            }
            column(NetDividends_Members; -NetDividends)
            {
            }
            column(GrossInterest_Members; -GrossInterestOnDeposits)
            {
            }
            column(WtaxInterest_Members; -WithholdingTaxIntOnDeposit)
            {
            }
            column(NetInterest_Members; -NetInterestOnDeposits)
            {
            }
            column(TotalDividends_Members; -"TotalDividends")
            {
            }
            // column()
            // {
            // }


            trigger OnAfterGetRecord()
            begin
                GrossDividends := 0;
                QualifyingShares := 0;
                WithholdingTax := 0;
                NetDividends := 0;
                IntCapitalizingAmount := 0;
                Members.CALCFIELDS(Members."Shares Retained");

                GenSetup.GET();

                // Year := '';
                Year := 0;
                CDate := 0D;
                DivProg.RESET;
                DivProg.SETRANGE(DivProg."Member No", Members."No.");
                IF DivProg.FINDLAST THEN BEGIN
                    // Year := DivProg.Year;
                    CDate := DivProg.Date;
                END;


                GrossDividends := 0;
                DivHist.Reset();
                DivHist.SetRange(DivHist."Member No", Members."No.");
                DivHist.SetRange(DivHist.Year, Year);
                DivHist.SetRange(DivHist."Deposit Type", DivHist."Deposit Type"::"Share Capital");
                if DivHist.FindSet() then begin
                    DivHist.CalcSums(DivHist."Gross Dividends");
                    GrossDividends := DivHist."Gross Dividends";
                end;


                WithholdingTaxDividends := 0;
                DivHist.Reset();
                DivHist.SetRange(DivHist."Member No", Members."No.");
                DivHist.SetRange(DivHist.Year, Year);
                DivHist.SetRange(DivHist."Deposit Type", DivHist."Deposit Type"::"Share Capital");
                if DivHist.FindSet() then begin
                    DivHist.CalcSums(DivHist."Witholding Tax");
                    WithholdingTaxDividends := DivHist."Witholding Tax";
                end;


                NetDividends := 0;
                DivHist.Reset();
                DivHist.SetRange(DivHist."Member No", Members."No.");
                DivHist.SetRange(DivHist.Year, Year);
                DivHist.SetRange(DivHist."Deposit Type", DivHist."Deposit Type"::"Share Capital");
                if DivHist.FindSet() then begin
                    DivHist.CalcSums(DivHist."Net Dividends");
                    NetDividends := DivHist."Net Dividends";
                end;


                GrossInterestOnDeposits := 0;
                DivHist.Reset();
                DivHist.SetRange(DivHist."Member No", Members."No.");
                DivHist.SetRange(DivHist.Year, Year);
                DivHist.SetRange(DivHist."Deposit Type", DivHist."Deposit Type"::Deposits);
                if DivHist.FindSet() then begin
                    DivHist.CalcSums(DivHist."Gross Dividends");
                    GrossInterestOnDeposits := DivHist."Gross Dividends";
                end;


                WithholdingTaxIntOnDeposit := 0;
                DivHist.Reset();
                DivHist.SetRange(DivHist."Member No", Members."No.");
                DivHist.SetRange(DivHist.Year, Year);
                DivHist.SetRange(DivHist."Deposit Type", DivHist."Deposit Type"::Deposits);
                if DivHist.FindSet() then begin
                    DivHist.CalcSums(DivHist."Witholding Tax");
                    WithholdingTaxIntOnDeposit := DivHist."Witholding Tax";
                end;


                NetInterestOnDeposits := 0;
                DivHist.Reset();
                DivHist.SetRange(DivHist."Member No", Members."No.");
                DivHist.SetRange(DivHist.Year, Year);
                DivHist.SetRange(DivHist."Deposit Type", DivHist."Deposit Type"::Deposits);
                if DivHist.FindSet() then begin
                    DivHist.CalcSums(DivHist."Net Dividends");
                    NetInterestOnDeposits := DivHist."Net Dividends";
                end;

                TotalDividends := 0;
                DivHist.Reset();
                DivHist.SetRange(DivHist."Member No", Members."No.");
                DivHist.SetRange(DivHist.Year, Year);
                DivHist.SetFilter(DivHist."Deposit Type", '%1|%2', DivHist."Deposit Type"::Deposits, DivHist."Deposit Type"::"Share Capital");
                if DivHist.FindSet() then begin
                    DivHist.CalcSums(DivHist."Net Dividends");
                    TotalDividends := DivHist."Net Dividends";
                end;


            end;
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
                    field(Year; Year)
                    {
                        ApplicationArea = All;
                    }

                }
            }
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
        CompanyInformation.GET;
        CompanyInformation.CALCFIELDS(CompanyInformation.Picture);
    end;

    var
        CompanyInformation: Record "Company Information";

        WithholdingTax: Decimal;

        QualifyingShares: Decimal;
        IntCapitalizingAmount: Decimal;

        DivProg: Record "Dividends Progression Hist";

        // Year: Code[60];
        Year: Integer;

        // DivHist: Record "Dividends Progression Hist";
        DivHist: Record "Dividends Progression";
        SharesDiff: Decimal;
        GenSetup: Record "Sacco General Set-Up";
        CapitalInt: Decimal;
        DivStart: Date;
        DivEnd: Date;

        CDate: Date;
        QualifyingSharess: Decimal;
        SharesX: Decimal;

        TotalDividends: Decimal;

        GrossDividends: Decimal;

        WithholdingTaxDividends: Decimal;

        NetDividends: Decimal;

        GrossInterestOnDeposits: Decimal;

        WithholdingTaxIntOnDeposit: Decimal;

        NetInterestOnDeposits: Decimal;
}



