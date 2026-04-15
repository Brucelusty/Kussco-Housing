report 50023 "TransferDividend-Prorated"
{
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    DefaultRenderingLayout = LayoutName;

    dataset
    {
        dataitem(Customer; Customer)
        {
            column(No_; "No.")
            {

            }
            trigger OnAfterGetRecord()
            begin
                DivReg.Reset();
                DivReg.SetRange("Member No", Customer."No.");
                if DivReg.Find('-') then begin
                    DivReg.DeleteAll();
                end;
                DividendProg.Reset();
                DividendProg.SetRange("Member No", Customer."No.");
                DividendProg.SetFilter(Date, '>=%1', CalcDate('-1D', StartDate));
                if DividendProg.FindSet() then begin
                    DividendProg.CalcSums("Gross Dividends", "Gross Interest On Deposit", "Witholding Tax", "Net Dividends", "Net Interest On Deposit", "Qualifying Share Capital", "Qualifying Shares", "IOD withholding Tax", "Dividend Withholding Tax");

                    DivReg.Init();
                    DivReg."Member No" := "No.";
                    DivReg."Member Name" := Name;
                    DivReg."Employer Code" := "Employer Code";
                    DivReg."Employer Name" := "Employer Name";
                    DivReg."Dividend Year" := Date2DMY(StartDate, 3);
                    DivReg."Qualifying Share Capital" := DividendProg."Qualifying Share Capital";
                    DivReg."Qualifying Shares" := DividendProg."Qualifying Shares";
                    DivReg."Net Dividends" := DividendProg."Net Dividends";
                    DivReg."Net Interest On Deposit" := DividendProg."Net Interest On Deposit";
                    DivReg."Document No" := 'Div' + '-' + Format(Date2DMY(StartDate, 3));
                    DivReg."Witholding Tax" := DividendProg."Witholding Tax";
                    DivReg."Gross Dividends" := DividendProg."Gross Dividends";
                    DivReg."Gross Interest On Deposit" := DividendProg."Gross Interest On Deposit";
                    DivReg."Total Dividend" := DividendProg."Net Dividends" + DividendProg."Net Interest On Deposit";
                    DivReg."IOD withholding Tax" := DividendProg."IOD withholding Tax";
                    DivReg."Dividend Withholding Tax" := DividendProg."Dividend Withholding Tax";
                    DivReg.Insert(true);

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
                    field(StartDate; StartDate)
                    {
                        ApplicationArea = All;
                    }
                }
            }
        }
    }

    rendering
    {
        layout(LayoutName)
        {
            Type = RDLC;
            LayoutFile = 'mylayout.rdl';
        }
    }

    var
        myInt: Integer;
        StartDate: date;
        DividendProg: Record "Dividends Progression";
        DivReg: Record "Dividends Register";
}


