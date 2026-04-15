//<---------------------------------------------------------------------->															
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings															
Report 50258 "Create Leave Year"															
{															
    ApplicationArea = All;
    Caption = 'Create Leave Year';															
    ProcessingOnly = true;															
															
    dataset															
    {															
    }															
															
    requestpage															
    {															
        SaveValues = true;															
															
        layout															
        {															
            area(content)															
            {															
                group(Options)															
                {															
                    Caption = 'Options';															
                    field(PeriodCode; PeriodCode)															
                    {															
                        Caption = 'Period Code';
                    ApplicationArea = All;															
                    }															
                    field(PeriodDesc; PeriodDesc)															
                    {															
                        Caption = 'Period Description';
                    ApplicationArea = All;															
                    }															
                    field(FiscalYearStartDate; FiscalYearStartDate)															
                    {															
                        Caption = 'Starting Date';
                    ApplicationArea = All;															
                    }															
                    field(NoOfPeriods; NoOfPeriods)															
                    {															
                        Caption = 'No. of Periods';
                    ApplicationArea = All;															
                    }															
                    field(PeriodLength; PeriodLength)															
                    {															
                        Caption = 'Period Length';
                    ApplicationArea = All;															
                    }															
                }															
            }															
        }															
															
        actions															
        {															
        }															
															
        trigger OnOpenPage()															
        begin															
            if NoOfPeriods = 0 then begin															
                NoOfPeriods := 12;															
                Evaluate(PeriodLength, '<1M>');															
            end;															
															
            if HRLeavePeriods.Find('+') then															
                FiscalYearStartDate := HRLeavePeriods."Starting Date";															
        end;															
    }															
															
    labels															
    {															
    }															
															
    trigger OnPreReport()															
    begin															
        //Added															
        HRLeavePeriods."Period Code" := PeriodCode;															
        HRLeavePeriods."Period Description" := PeriodDesc;															
															
        HRLeavePeriods."Starting Date" := FiscalYearStartDate;															
        HRLeavePeriods.TestField("Starting Date");															
															
        //Added															
        HRLeavePeriods.TestField(HRLeavePeriods."Period Code");															
        HRLeavePeriods.TestField(HRLeavePeriods."Period Description");															
															
															
        if HRLeavePeriods.Find('-') then begin															
            FirstPeriodStartDate := HRLeavePeriods."Starting Date";															
            FirstPeriodLocked := HRLeavePeriods."Date Locked";															
            if (FiscalYearStartDate < FirstPeriodStartDate) and FirstPeriodLocked then															
                if not															
                   Confirm(															
                     Text000 +															
                     Text001)															
                then															
                    exit;															
            if HRLeavePeriods.Find('+') then															
                LastPeriodStartDate := HRLeavePeriods."Starting Date";															
        end else															
            if not															
               Confirm(															
                 Text002 +															
                 Text003)															
            then															
                exit;															
															
        FiscalYearStartDate2 := FiscalYearStartDate;															
															
        for i := 1 to NoOfPeriods + 1 do begin															
            if (FiscalYearStartDate <= FirstPeriodStartDate) and (i = NoOfPeriods + 1) then															
                exit;															
															
            if (FirstPeriodStartDate <> 0D) then															
                if (FiscalYearStartDate >= FirstPeriodStartDate) and (FiscalYearStartDate < LastPeriodStartDate) then															
                    Error(Text004);															
															
            HRLeavePeriods.Init;															
															
            //Added															
            HRLeavePeriods."Period Code" := PeriodCode;															
            HRLeavePeriods."Period Description" := PeriodDesc;															
															
            HRLeavePeriods."Starting Date" := FiscalYearStartDate;															
            HRLeavePeriods.Validate("Starting Date");															
            if (i = 1) or (i = NoOfPeriods + 1) then begin															
                HRLeavePeriods."New Fiscal Year" := true;															
            end;															
            if (FirstPeriodStartDate = 0D) and (i = 1) then															
                HRLeavePeriods."Date Locked" := true;															
            if (HRLeavePeriods."Starting Date" < FirstPeriodStartDate) and FirstPeriodLocked then begin															
                HRLeavePeriods.Closed := true;															
                HRLeavePeriods."Date Locked" := true;															
            end;															
            if not HRLeavePeriods.Find('=') then															
                HRLeavePeriods.Insert;															
            FiscalYearStartDate := CalcDate(PeriodLength, FiscalYearStartDate);															
        end;															
															
        HRLeavePeriods.Get(FiscalYearStartDate2);															
        //HRLeavePeriods.UpdateAvgItems(0);															
    end;															
															
    var															
        Text000: label 'The new fiscal year begins before an existing fiscal year, so the new year will be closed automatically.\\';															
        Text001: label 'Do you want to create and close the fiscal year?';															
        Text002: label 'Once you create the new fiscal year you cannot change its starting date.\\';															
        Text003: label 'Do you want to create the fiscal year?';															
        Text004: label 'It is only possible to create new fiscal years before or after the existing ones.';															
        HRLeavePeriods: Record "HR Leave Periods";															
        InvtSetup: Record "Inventory Setup";															
        NoOfPeriods: Integer;															
        PeriodLength: DateFormula;															
        FiscalYearStartDate: Date;															
        FiscalYearStartDate2: Date;															
        FirstPeriodStartDate: Date;															
        LastPeriodStartDate: Date;															
        FirstPeriodLocked: Boolean;															
        i: Integer;															
        PeriodCode: Code[10];															
        PeriodDesc: Text[150];															
}															
															
															
															
															



