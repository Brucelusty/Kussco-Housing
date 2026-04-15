report 50021 "Dividend Processing Ver1"
{
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    DefaultRenderingLayout = LayoutName;

    dataset
    {
        dataitem(Customer; Customer)
        {

            RequestFilterFields = "No.";
            column(No_; "No.")
            {

            }
            trigger OnAfterGetRecord()
            begin
                ShareCapital := 0;
                TotalDeposit := 0;
                InterestOnDeposit := 0;
                DivProg.Reset();
                DivProg.SetCurrentKey("Member No");
                DivProg.SetRange(DivProg."Member No", Customer."No.");
                DivProg.SetFilter(Date, '>=%1', CalcDate('-1D', StartDate));
                if DivProg.Find('-') then
                    DivProg.DeleteAll();

                Datefilter := '..' + Format(CalcDate('-1D', StartDate));
                IterationFromDate := Customer."Registration Date";
                IterationToDate := CalcDate('-1D', StartDate);

                Cust.Reset();
                Cust.SetCurrentKey("No.");
                Cust.SetRange("No.", Customer."No.");
                Cust.SetRange("Date Filter", 0D, CalcDate('-CY-1D', Today));
                IF Cust.Find('-') then begin

                    GenSetup.Get();
                    Cust.CalcFields("Shares Retained");
                    ShareCapital := Round((GenSetup."Dividend (%)" / 100) * Cust."Shares Retained", 0.01, '<');
                    //Message('%1-%2-%3', Cust."Shares Retained", ShareCapital, GenSetup."Dividend (%)");
                    DivProg.Init();
                    DivProg."Member No" := Cust."No.";
                    DivProg.Date := CalcDate('-CY-1D', Today);
                    DivProg."Gross Dividends" := ShareCapital;
                    DivProg.Shares := Cust."Shares Retained";
                    DivProg."Qualifying Share Capital" := Cust."Shares Retained";
                    DivProg."Witholding Tax" := Round(ShareCapital * (GenSetup."Withholding Tax (%)" / 100), 0.01, '<');
                    DivProg."Net Dividends" := DivProg."Gross Dividends" - DivProg."Witholding Tax";
                    DivProg."Dividend Withholding Tax" := Round(ShareCapital * (GenSetup."Withholding Tax (%)" / 100), 0.01, '<');

                    if DivProg."Qualifying Share Capital" <> 0 then
                        DivProg.Insert(true);
                end;
                if GetWithdrawnMembers() = false then
                    for i := 12 DownTo 1 do begin

                        Cust.Reset();
                        Cust.SetCurrentKey("No.");
                        Cust.SetRange("No.", Customer."No.");
                        Cust.SetFilter(Cust."Date Filter", Datefilter);
                        if Cust.Find('-') then begin
                            GenSetup.Get();
                            Cust.CalcFields(Cust."Current Shares", Cust."Dependant Savings 1", Cust."Dependant Savings 2", Cust."Dependant Savings 3");
                            TotalDeposit := Cust."Current Shares" + Cust."Dependant Savings 1" + Cust."Dependant Savings 2" + Cust."Dependant Savings 3";
                            //Message('%1-iteration Value %2', GenSetup."Interest on Deposits (%)", i);
                            InterestOnDeposit := round(TotalDeposit * (GenSetup."Interest on Deposits (%)" / 100) * i / 12, 0.01, '<');

                            DivProg.Init();
                            DivProg.Date := IterationToDate;
                            DivProg."Gross Interest On Deposit" := InterestOnDeposit;
                            DivProg."Witholding Tax" := Round(InterestOnDeposit * (GenSetup."Withholding Tax (%)" / 100), 0.01, '<');
                            DivProg.Shares := TotalDeposit;
                            DivProg."Qualifying Shares" := Round(TotalDeposit * (i / 12), 0.01, '<');
                            DivProg."Net Interest On Deposit" := DivProg."Gross Interest On Deposit" - DivProg."Witholding Tax";
                            DivProg."IOD withholding Tax" := Round(InterestOnDeposit * (GenSetup."Withholding Tax (%)" / 100), 0.01, '<');
                            if DivProg."Qualifying Shares" <> 0 then
                                DivProg.Insert();

                        end;
                        IterationFromDate := CalcDate('1D', IterationToDate);
                        IterationToDate := CalcDate('CM', IterationFromDate);
                        Datefilter := Format(IterationFromDate) + '..' + Format(IterationToDate);
                    end;
            end;

            trigger OnPreDataItem()
            begin
                if StartDate = 0D then Error('You must define the start date.');
                if StartDate <> CalcDate('-CY', StartDate) then Error('Start date must be the begining of the year.');
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
                }
            }
        }
    }

    rendering
    {
        layout(LayoutName)
        {
            Type = RDLC;
            LayoutFile = 'Layouts/mylayout2.rdl';
        }
    }

    var
        myInt: Integer;
        StartDate: date;

        DivProg: Record "Dividends Progression";

        Cust: Record Customer;

        Datefilter: Text[50];
        IterationFromDate: Date;
        IterationToDate: Date;

        GenSetup: Record "Sacco General Set-Up";

        ShareCapital: Decimal;

        i: Integer;
        TotalDeposit: Decimal;
        InterestOnDeposit: Decimal;

    procedure GetWithdrawnMembers() Withdrawn: Boolean;

    var
        Cust: Record Customer;
    //Withdrawn: Boolean;
    begin
        Withdrawn := false;

        Cust.Reset();
        Cust.SetRange("No.", Customer."No.");
        Cust.SetFilter("Date Filter", '..%1', CalcDate('CY', StartDate));
        Cust.SetAutoCalcFields("Current Shares");
        IF Cust.Find('-') THEN begin
            if Cust."Current Shares" <= 0 then begin
                Withdrawn := true;
            end;
        end;
    end;
}
