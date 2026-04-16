report 50775 "Dividend Prorated New"
{
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;

    dataset
    {
        dataitem(Customer;Customer)
        {
            DataItemTableView = SORTING ("No.")where(IsNormalMember = filter(true));
            RequestFilterFields = Status, "No.";
            trigger OnAfterGetRecord()
            begin
                if skip = true then begin
                    CurrReport.Skip();
                end;
                FromDateCalc := FromDate;
                PCKESSDate := DMY2Date(31, 12, 2021);
                loanCutoffDate := DMY2Date(30, 9, 2024);
                GenSetUp.Get();

                for month := 12 downto 0 do begin
                    // FromDateCalc := CalcDate('<-1M>', FromDateCalc);
                    ToDateCalc := CalcDate('<CM>', FromDateCalc);

                    if (month = 12) then begin
                        if "Deposit Type" = "Deposit Type"::Deposits then begin
                            DivTotal := 0;
                            cust.Reset();
                            cust.SetRange("No.", Customer."No.");
                            cust.SetFilter("Employer Code", '%1|%2', 'KENYA POSTAL', 'POSTAL CORP');
                            if Cust.Find('-') then begin
                                checkOffLines.Reset();
                                checkOffLines.SetRange("Member No", Customer."No.");
                                if checkOffLines.Find('-') then begin
                                    salaryEarner.Reset();
                                    salaryEarner.SetRange("Member No", Customer."No.");
                                    salaryEarner.SetFilter("Salary Type", '%1|%2', salaryEarner."Salary Type"::Salary, salaryEarner."Salary Type"::Pension);
                                    salaryEarner.SetFilter("Posting Date", '<=%1', loanCutoffDate);
                                    if salaryEarner.Find('-') then begin
                                        cust.Reset();
                                        cust.SetRange("No.", Customer."No.");
                                        cust.SetFilter("Date Filter", '..%1', ToDatecalc);
                                        if Cust.Find('-') then begin
                                            cust.CalcFields("Old Deposit Balance");
                                            
                                            CDiv := ((GenSetUp."Interest on Deposits (%)"/ 100) * ((Cust."Old Deposit Balance" + 0) * -1)) * (month / 12);
                                            DivTotal := DivTotal + CDiv;

                                            DivProg.Init();
                                            DivProg."Member No" := Cust."No.";
                                            DivProg.Date := ToDateCalc;
                                            DivProg."Gross Dividends" := CDiv;
                                            DivProg."Witholding Tax" := CDiv * (GenSetUp."Withholding Tax on Deposits" / 100);
                                            DivProg."Net Dividends" := DivProg."Gross Dividends" - DivProg."Witholding Tax";
                                            DivProg."Qualifying Shares" := ((Cust."Old Deposit Balance" + 0) * -1) * (month / 12);
                                            DivProg.Shares := ((Cust."Old Deposit Balance" + 0) * -1);
                                            DivProg."Deposit Type" := DivProg."Deposit Type"::Deposits;
                                            DivProg.Year := "Calculation Year";
                                            divProg.Insert();
                                        end
                                    end else begin
                                        cust.Reset();
                                        cust.SetRange("No.", Customer."No.");
                                        cust.SetFilter("Date Filter", '..%1', PCKESSDate);
                                        if Cust.Find('-') then begin
                                            cust.CalcFields("Old Deposit Balance");
                                            
                                            CDiv := ((GenSetUp."Interest on Deposits (%)" / 100) * ((Cust."Old Deposit Balance" + 0) * -1)) * (month / 12);
                                            DivTotal := DivTotal + CDiv;

                                            DivProg.Init();
                                            DivProg."Member No" := Cust."No.";
                                            DivProg.Date := ToDateCalc;
                                            DivProg."Gross Dividends" := CDiv;
                                            DivProg."Witholding Tax" := CDiv * (GenSetUp."Withholding Tax on Deposits" / 100);
                                            DivProg."Net Dividends" := DivProg."Gross Dividends" - DivProg."Witholding Tax";
                                            DivProg."Qualifying Shares" := ((Cust."Old Deposit Balance" + 0) * -1) * (month / 12);
                                            DivProg.Shares := ((Cust."Old Deposit Balance" + 0) * -1);
                                            DivProg."Deposit Type" := DivProg."Deposit Type"::Deposits;
                                            DivProg.Year := "Calculation Year";
                                            divProg.Insert();
                                        end
                                    end;
                                end else begin
                                    salaryEarner.Reset();
                                    salaryEarner.SetRange("Member No", Customer."No.");
                                    salaryEarner.SetFilter("Salary Type", '%1|%2', salaryEarner."Salary Type"::Salary, salaryEarner."Salary Type"::Pension);
                                    salaryEarner.SetFilter("Posting Date", '<=%1', loanCutoffDate);
                                    if salaryEarner.Find('-') then begin
                                        cust.Reset();
                                        cust.SetRange("No.", Customer."No.");
                                        cust.SetFilter("Date Filter", '..%1', ToDatecalc);
                                        if Cust.Find('-') then begin
                                            cust.CalcFields("Old Deposit Balance");
                                            
                                            CDiv := ((GenSetUp."Interest on Deposits (%)" / 100) * ((Cust."Old Deposit Balance" + 0) * -1)) * (month / 12);
                                            DivTotal := DivTotal + CDiv;

                                            DivProg.Init();
                                            DivProg."Member No" := Cust."No.";
                                            DivProg.Date := ToDateCalc;
                                            DivProg."Gross Dividends" := CDiv;
                                            DivProg."Witholding Tax" := CDiv * (GenSetUp."Withholding Tax on Deposits" / 100);
                                            DivProg."Net Dividends" := DivProg."Gross Dividends" - DivProg."Witholding Tax";
                                            DivProg."Qualifying Shares" := ((Cust."Old Deposit Balance" + 0) * -1) * (month / 12);
                                            DivProg.Shares := ((Cust."Old Deposit Balance" + 0) * -1);
                                            DivProg."Deposit Type" := DivProg."Deposit Type"::Deposits;
                                            DivProg.Year := "Calculation Year";
                                            divProg.Insert();
                                        end
                                    end;
                                end;
                            end else begin
                                cust.Reset();
                                Cust.SetRange("No.", Customer."No.");
                                cust.SetFilter("Date Filter", '..%1', ToDatecalc);
                                if Cust.Find('-') then begin
                                    cust.CalcFields("Old Deposit Balance");
                                    
                                    CDiv := ((GenSetUp."Interest on Deposits (%)" / 100) * ((Cust."Old Deposit Balance" + 0) * -1)) * (month / 12);
                                    DivTotal := DivTotal + CDiv;

                                    DivProg.Init();
                                    DivProg."Member No" := Cust."No.";
                                    DivProg.Date := ToDateCalc;
                                    DivProg."Gross Dividends" := CDiv;
                                    DivProg."Witholding Tax" := CDiv * (GenSetUp."Withholding Tax on Deposits" / 100);
                                    DivProg."Net Dividends" := DivProg."Gross Dividends" - DivProg."Witholding Tax";
                                    DivProg."Qualifying Shares" := ((Cust."Old Deposit Balance" + 0) * -1) * (month / 12);
                                    DivProg.Shares := ((Cust."Old Deposit Balance" + 0) * -1);
                                    DivProg."Deposit Type" := DivProg."Deposit Type"::Deposits;
                                    DivProg.Year := "Calculation Year";
                                    divProg.Insert();
                                end;
                            end;
                        end;
                        if "Deposit Type" = "Deposit Type"::ESS then begin
                            DivTotal := 0;
                            cust.Reset();
                            cust.SetRange("No.", Customer."No.");
                            cust.SetFilter("Employer Code", '%1|%2', 'KENYA POSTAL', 'POSTAL CORP');
                            if Cust.Find('-') then begin
                                checkOffLines.Reset();
                                checkOffLines.SetRange("Member No", Customer."No.");
                                if checkOffLines.Find('-') then begin
                                    salaryEarner.Reset();
                                    salaryEarner.SetRange("Member No", Customer."No.");
                                    salaryEarner.SetFilter("Salary Type", '%1|%2', salaryEarner."Salary Type"::Salary, salaryEarner."Salary Type"::Pension);
                                    salaryEarner.SetFilter("Posting Date", '<=%1', loanCutoffDate);
                                    if salaryEarner.Find('-') then begin
                                        cust.Reset();
                                        cust.SetRange("No.", Customer."No.");
                                        cust.SetFilter("Date Filter", '..%1', ToDatecalc);
                                        if Cust.Find('-') then begin
                                            cust.CalcFields("Old ESS Balance");
                                            
                                            CDiv := ((GenSetUp."Ess Interest%" / 100) * ((Cust."Old ESS Balance" + 0) * -1)) * (month / 12);
                                            DivTotal := DivTotal + CDiv;

                                            DivProg.Init();
                                            DivProg."Member No" := Cust."No.";
                                            DivProg.Date := ToDateCalc;
                                            DivProg."Gross Dividends" := CDiv;
                                            DivProg."Witholding Tax" := CDiv * (GenSetUp."Withholding Tax on Deposits" / 100);
                                            DivProg."Net Dividends" := DivProg."Gross Dividends" - DivProg."Witholding Tax";
                                            DivProg."Qualifying Shares" := ((Cust."Old ESS Balance" + 0) * -1) * (month / 12);
                                            DivProg.Shares := ((Cust."Old ESS Balance" + 0) * -1);
                                            DivProg."Deposit Type" := DivProg."Deposit Type"::ESS;
                                            DivProg.Year := "Calculation Year";
                                            divProg.Insert();
                                        end
                                    end else begin
                                        cust.Reset();
                                        cust.SetRange("No.", Customer."No.");
                                        cust.SetFilter("Date Filter", '..%1', PCKESSDate);
                                        if Cust.Find('-') then begin
                                            cust.CalcFields("Old ESS Balance");
                                            
                                            CDiv := ((GenSetUp."Ess Interest%" / 100) * ((Cust."Old ESS Balance" + 0) * -1)) * (month / 12);
                                            DivTotal := DivTotal + CDiv;

                                            DivProg.Init();
                                            DivProg."Member No" := Cust."No.";
                                            DivProg.Date := ToDateCalc;
                                            DivProg."Gross Dividends" := CDiv;
                                            DivProg."Witholding Tax" := CDiv * (GenSetUp."Withholding Tax on Deposits" / 100);
                                            DivProg."Net Dividends" := DivProg."Gross Dividends" - DivProg."Witholding Tax";
                                            DivProg."Qualifying Shares" := ((Cust."Old ESS Balance" + 0) * -1) * (month / 12);
                                            DivProg.Shares := ((Cust."Old ESS Balance" + 0) * -1);
                                            DivProg."Deposit Type" := DivProg."Deposit Type"::ESS;
                                            DivProg.Year := "Calculation Year";
                                            divProg.Insert();
                                        end
                                    end;
                                end else begin
                                    salaryEarner.Reset();
                                    salaryEarner.SetRange("Member No", Customer."No.");
                                    salaryEarner.SetFilter("Salary Type", '%1|%2', salaryEarner."Salary Type"::Salary, salaryEarner."Salary Type"::Pension);
                                    salaryEarner.SetFilter("Posting Date", '<=%1', loanCutoffDate);
                                    if salaryEarner.Find('-') then begin
                                        cust.Reset();
                                        cust.SetRange("No.", Customer."No.");
                                        cust.SetFilter("Date Filter", '..%1', ToDatecalc);
                                        if Cust.Find('-') then begin
                                            cust.CalcFields("Old ESS Balance");
                                            
                                            CDiv := ((GenSetUp."Ess Interest%" / 100) * ((Cust."Old ESS Balance" + 0) * -1)) * (month / 12);
                                            DivTotal := DivTotal + CDiv;

                                            DivProg.Init();
                                            DivProg."Member No" := Cust."No.";
                                            DivProg.Date := ToDateCalc;
                                            DivProg."Gross Dividends" := CDiv;
                                            DivProg."Witholding Tax" := CDiv * (GenSetUp."Withholding Tax on Deposits" / 100);
                                            DivProg."Net Dividends" := DivProg."Gross Dividends" - DivProg."Witholding Tax";
                                            DivProg."Qualifying Shares" := ((Cust."Old ESS Balance" + 0) * -1) * (month / 12);
                                            DivProg.Shares := ((Cust."Old ESS Balance" + 0) * -1);
                                            DivProg."Deposit Type" := DivProg."Deposit Type"::ESS;
                                            DivProg.Year := "Calculation Year";
                                            divProg.Insert();
                                        end
                                    end;
                                end;
                            end else begin
                                cust.Reset();
                                Cust.SetRange("No.", Customer."No.");
                                cust.SetFilter("Date Filter", '..%1', ToDatecalc);
                                if Cust.Find('-') then begin
                                    cust.CalcFields("Old ESS Balance");
                                    
                                    CDiv := ((GenSetUp."Ess Interest%" / 100) * ((Cust."Old ESS Balance" + 0) * -1)) * (month / 12);
                                    DivTotal := DivTotal + CDiv;

                                    DivProg.Init();
                                    DivProg."Member No" := Cust."No.";
                                    DivProg.Date := ToDateCalc;
                                    DivProg."Gross Dividends" := CDiv;
                                    DivProg."Witholding Tax" := CDiv * (GenSetUp."Withholding Tax on Deposits" / 100);
                                    DivProg."Net Dividends" := DivProg."Gross Dividends" - DivProg."Witholding Tax";
                                    DivProg."Qualifying Shares" := ((Cust."Old ESS Balance" + 0) * -1) * (month / 12);
                                    DivProg.Shares := ((Cust."Old ESS Balance" + 0) * -1);
                                    DivProg."Deposit Type" := DivProg."Deposit Type"::ESS;
                                    DivProg.Year := "Calculation Year";
                                    divProg.Insert();
                                end;
                            end;
                        end;
                        if "Deposit Type" = "Deposit Type"::"Share Capital" then begin
                            DivTotal := 0;
                            cust.Reset();
                            cust.SetRange("No.", Customer."No.");
                            cust.SetFilter("Date Filter", '..%1', ToDatecalc);
                            if Cust.Find('-') then begin
                                cust.CalcFields("Old Share Capital Balance");
                                
                                CDiv := ((GenSetUp."Dividend (%)" / 100) * ((Cust."Old Share Capital Balance" + 0) * -1)) * (month / 12);
                                DivTotal := DivTotal + CDiv;

                                DivProg.Init();
                                DivProg."Member No" := Cust."No.";
                                DivProg.Date := ToDateCalc;
                                DivProg."Gross Dividends" := CDiv;
                                DivProg."Witholding Tax" := CDiv * (GenSetUp."Withholding Tax on Dividends" / 100);
                                DivProg."Net Dividends" := DivProg."Gross Dividends" - DivProg."Witholding Tax";
                                DivProg."Qualifying Shares" := ((Cust."Old Share Capital Balance" + 0) * -1) * (month / 12);
                                DivProg.Shares := ((Cust."Old Share Capital Balance" + 0) * -1);
                                DivProg."Deposit Type" := DivProg."Deposit Type"::"Share Capital";
                                DivProg.Year := "Calculation Year";
                                divProg.Insert();
                            end;
                        end;
                    end else if (month = 11) or (month = 10) or (month = 9) then begin
                        if "Deposit Type" = "Deposit Type"::Deposits then begin
                            DivTotal := 0;

                            cust.Reset();
                            cust.SetRange("No.", Customer."No.");
                            cust.SetFilter("Employer Code", '%1|%2', 'KENYA POSTAL', 'POSTAL CORP');
                            if Cust.Find('-') then begin
                                checkOffLines.Reset();
                                checkOffLines.SetRange("Member No", Customer."No.");
                                if checkOffLines.Find('-') then begin
                                    salaryEarner.Reset();
                                    salaryEarner.SetRange("Member No", Customer."No.");
                                    salaryEarner.SetFilter("Salary Type", '%1|%2', salaryEarner."Salary Type"::Salary, salaryEarner."Salary Type"::Pension);
                                    salaryEarner.SetFilter("Posting Date", '<=%1', loanCutoffDate);
                                    if salaryEarner.Find('-') then begin
                                        cust.Reset();
                                        cust.SetRange("No.", Customer."No.");
                                        cust.SetFilter("Date Filter", '%1..%2', FromDateCalc, ToDatecalc);
                                        if Cust.Find('-') then begin
                                            cust.CalcFields("Old Deposit Balance", "Current Shares");
                                            
                                            CDiv := ((GenSetUp."Interest on Deposits (%)" / 100) * ((Cust."Old Deposit Balance" + Cust."Current Shares" + 0) * -1)) * (month / 12);
                                            DivTotal := DivTotal + CDiv;

                                            DivProg.Init();
                                            DivProg."Member No" := Cust."No.";
                                            DivProg.Date := ToDateCalc;
                                            DivProg."Gross Dividends" := CDiv;
                                            DivProg."Witholding Tax" := CDiv * (GenSetUp."Withholding Tax on Deposits" / 100);
                                            DivProg."Net Dividends" := DivProg."Gross Dividends" - DivProg."Witholding Tax";
                                            DivProg."Qualifying Shares" := ((Cust."Old Deposit Balance" + Cust."Current Shares" + 0) * -1) * (month / 12);
                                            DivProg.Shares := ((Cust."Old Deposit Balance" + Cust."Current Shares" + 0) * -1);
                                            DivProg."Deposit Type" := DivProg."Deposit Type"::Deposits;
                                            DivProg.Year := "Calculation Year";
                                            divProg.Insert();
                                        end;
                                    end else begin
                                        cust.Reset();
                                        cust.SetRange("No.", Customer."No.");
                                        if Cust.Find('-') then begin
                                            cust.CalcFields("Old Deposit Balance", "Current Shares");
                                            
                                            CDiv := 0;
                                            DivTotal := DivTotal + CDiv;

                                            DivProg.Init();
                                            DivProg."Member No" := Cust."No.";
                                            DivProg.Date := ToDateCalc;
                                            DivProg."Gross Dividends" := CDiv;
                                            DivProg."Witholding Tax" := 0;
                                            DivProg."Net Dividends" := 0;
                                            DivProg."Qualifying Shares" := 0;
                                            DivProg.Shares := 0;
                                            DivProg."Deposit Type" := DivProg."Deposit Type"::Deposits;
                                            DivProg.Year := "Calculation Year";
                                            divProg.Insert();
                                        end;
                                    end;
                                end else begin
                                    salaryEarner.Reset();
                                    salaryEarner.SetRange("Member No", Customer."No.");
                                    salaryEarner.SetFilter("Salary Type", '%1|%2', salaryEarner."Salary Type"::Salary, salaryEarner."Salary Type"::Pension);
                                    salaryEarner.SetFilter("Posting Date", '<=%1', loanCutoffDate);
                                    if salaryEarner.Find('-') then begin
                                        cust.Reset();
                                        cust.SetRange("No.", Customer."No.");
                                        cust.SetFilter("Date Filter", '%1..%2', FromDateCalc, ToDatecalc);
                                        if Cust.Find('-') then begin
                                            cust.CalcFields("Old Deposit Balance", "Current Shares");
                                            
                                            CDiv := ((GenSetUp."Interest on Deposits (%)" / 100) * ((Cust."Old Deposit Balance" + Cust."Current Shares" + 0) * -1)) * (month / 12);
                                            DivTotal := DivTotal + CDiv;

                                            DivProg.Init();
                                            DivProg."Member No" := Cust."No.";
                                            DivProg.Date := ToDateCalc;
                                            DivProg."Gross Dividends" := CDiv;
                                            DivProg."Witholding Tax" := CDiv * (GenSetUp."Withholding Tax on Deposits" / 100);
                                            DivProg."Net Dividends" := DivProg."Gross Dividends" - DivProg."Witholding Tax";
                                            DivProg."Qualifying Shares" := ((Cust."Old Deposit Balance" + Cust."Current Shares" + 0) * -1) * (month / 12);
                                            DivProg.Shares := ((Cust."Old Deposit Balance" + Cust."Current Shares" + 0) * -1);
                                            DivProg."Deposit Type" := DivProg."Deposit Type"::Deposits;
                                            DivProg.Year := "Calculation Year";
                                            divProg.Insert();
                                        end;
                                    end;
                                end;
                            end else begin
                                cust.Reset();
                                cust.SetRange("No.", Customer."No.");
                                cust.SetFilter("Date Filter", '%1..%2', FromDateCalc, ToDatecalc);
                                if Cust.Find('-') then begin
                                    cust.CalcFields("Old Deposit Balance", "Current Shares");
                                    
                                    CDiv := ((GenSetUp."Interest on Deposits (%)" / 100) * ((Cust."Old Deposit Balance" + Cust."Current Shares" + 0) * -1)) * (month / 12);
                                    DivTotal := DivTotal + CDiv;

                                    DivProg.Init();
                                    DivProg."Member No" := Cust."No.";
                                    DivProg.Date := ToDateCalc;
                                    DivProg."Gross Dividends" := CDiv;
                                    DivProg."Witholding Tax" := CDiv * (GenSetUp."Withholding Tax on Deposits" / 100);
                                    DivProg."Net Dividends" := DivProg."Gross Dividends" - DivProg."Witholding Tax";
                                    DivProg."Qualifying Shares" := ((Cust."Old Deposit Balance" + Cust."Current Shares" + 0) * -1) * (month / 12);
                                    DivProg.Shares := ((Cust."Old Deposit Balance" + Cust."School Fees Shares" + 0) * -1);
                                    DivProg."Deposit Type" := DivProg."Deposit Type"::Deposits;
                                    DivProg.Year := "Calculation Year";
                                    divProg.Insert();
                                end;
                            end;
                        end;
                        if "Deposit Type" = "Deposit Type"::ESS then begin
                            DivTotal := 0;

                            cust.Reset();
                            cust.SetRange("No.", Customer."No.");
                            cust.SetFilter("Employer Code", '%1|%2', 'KENYA POSTAL', 'POSTAL CORP');
                            if Cust.Find('-') then begin
                                checkOffLines.Reset();
                                checkOffLines.SetRange("Member No", Customer."No.");
                                if checkOffLines.Find('-') then begin
                                    salaryEarner.Reset();
                                    salaryEarner.SetRange("Member No", Customer."No.");
                                    salaryEarner.SetFilter("Salary Type", '%1|%2', salaryEarner."Salary Type"::Salary, salaryEarner."Salary Type"::Pension);
                                    salaryEarner.SetFilter("Posting Date", '<=%1', loanCutoffDate);
                                    if salaryEarner.Find('-') then begin
                                        cust.Reset();
                                        cust.SetRange("No.", Customer."No.");
                                        cust.SetFilter("Date Filter", '%1..%2', FromDateCalc, ToDatecalc);
                                        if Cust.Find('-') then begin
                                            cust.CalcFields("Old ESS Balance", "School Fees Shares");
                                            
                                            CDiv := ((GenSetUp."Ess Interest%" / 100) * ((Cust."Old ESS Balance" + Cust."School Fees Shares" + 0) * -1)) * (month / 12);
                                            DivTotal := DivTotal + CDiv;

                                            DivProg.Init();
                                            DivProg."Member No" := Cust."No.";
                                            DivProg.Date := ToDateCalc;
                                            DivProg."Gross Dividends" := CDiv;
                                            DivProg."Witholding Tax" := CDiv * (GenSetUp."Withholding Tax on Deposits" / 100);
                                            DivProg."Net Dividends" := DivProg."Gross Dividends" - DivProg."Witholding Tax";
                                            DivProg."Qualifying Shares" := ((Cust."Old ESS Balance" + Cust."School Fees Shares" + 0) * -1) * (month / 12);
                                            DivProg.Shares := ((Cust."Old ESS Balance" + Cust."School Fees Shares" + 0) * -1);
                                            DivProg."Deposit Type" := DivProg."Deposit Type"::ESS;
                                            DivProg.Year := "Calculation Year";
                                            divProg.Insert();
                                        end;
                                    end else begin
                                        cust.Reset();
                                        cust.SetRange("No.", Customer."No.");
                                        if Cust.Find('-') then begin
                                            cust.CalcFields("Old ESS Balance", "School Fees Shares");
                                            
                                            CDiv := 0;
                                            DivTotal := DivTotal + CDiv;

                                            DivProg.Init();
                                            DivProg."Member No" := Cust."No.";
                                            DivProg.Date := ToDateCalc;
                                            DivProg."Gross Dividends" := CDiv;
                                            DivProg."Witholding Tax" := 0;
                                            DivProg."Net Dividends" := 0;
                                            DivProg."Qualifying Shares" := 0;
                                            DivProg.Shares := 0;
                                            DivProg."Deposit Type" := DivProg."Deposit Type"::ESS;
                                            DivProg.Year := "Calculation Year";
                                            divProg.Insert();
                                        end;
                                    end;
                                end else begin
                                    salaryEarner.Reset();
                                    salaryEarner.SetRange("Member No", Customer."No.");
                                    salaryEarner.SetFilter("Salary Type", '%1|%2', salaryEarner."Salary Type"::Salary, salaryEarner."Salary Type"::Pension);
                                    salaryEarner.SetFilter("Posting Date", '<=%1', loanCutoffDate);
                                    if salaryEarner.Find('-') then begin
                                        cust.Reset();
                                        cust.SetRange("No.", Customer."No.");
                                        cust.SetFilter("Date Filter", '%1..%2', FromDateCalc, ToDatecalc);
                                        if Cust.Find('-') then begin
                                            cust.CalcFields("Old ESS Balance", "School Fees Shares");
                                            
                                            CDiv := ((GenSetUp."Ess Interest%" / 100) * ((Cust."Old ESS Balance" + Cust."School Fees Shares" + 0) * -1)) * (month / 12);
                                            DivTotal := DivTotal + CDiv;

                                            DivProg.Init();
                                            DivProg."Member No" := Cust."No.";
                                            DivProg.Date := ToDateCalc;
                                            DivProg."Gross Dividends" := CDiv;
                                            DivProg."Witholding Tax" := CDiv * (GenSetUp."Withholding Tax on Deposits" / 100);
                                            DivProg."Net Dividends" := DivProg."Gross Dividends" - DivProg."Witholding Tax";
                                            DivProg."Qualifying Shares" := ((Cust."Old ESS Balance" + Cust."School Fees Shares" + 0) * -1) * (month / 12);
                                            DivProg.Shares := ((Cust."Old ESS Balance" + Cust."School Fees Shares" + 0) * -1);
                                            DivProg."Deposit Type" := DivProg."Deposit Type"::ESS;
                                            DivProg.Year := "Calculation Year";
                                            divProg.Insert();
                                        end;
                                    end;
                                end;
                            end else begin
                                cust.Reset();
                                cust.SetRange("No.", Customer."No.");
                                cust.SetFilter("Date Filter", '%1..%2', FromDateCalc, ToDatecalc);
                                if Cust.Find('-') then begin
                                    cust.CalcFields("Old ESS Balance", "School Fees Shares");
                                    
                                    CDiv := ((GenSetUp."Ess Interest%" / 100) * ((Cust."Old ESS Balance" + Cust."School Fees Shares" + 0) * -1)) * (month / 12);
                                    DivTotal := DivTotal + CDiv;

                                    DivProg.Init();
                                    DivProg."Member No" := Cust."No.";
                                    DivProg.Date := ToDateCalc;
                                    DivProg."Gross Dividends" := CDiv;
                                    DivProg."Witholding Tax" := CDiv * (GenSetUp."Withholding Tax on Deposits" / 100);
                                    DivProg."Net Dividends" := DivProg."Gross Dividends" - DivProg."Witholding Tax";
                                    DivProg."Qualifying Shares" := ((Cust."Old ESS Balance" + Cust."School Fees Shares" + 0) * -1) * (month / 12);
                                    DivProg.Shares := ((Cust."Old ESS Balance" + Cust."School Fees Shares" + 0) * -1);
                                    DivProg."Deposit Type" := DivProg."Deposit Type"::ESS;
                                    DivProg.Year := "Calculation Year";
                                    divProg.Insert();
                                end;
                            end;
                        end;
                        if "Deposit Type" = "Deposit Type"::"Share Capital" then begin
                            DivTotal := 0;
                            cust.Reset();
                            cust.SetRange("No.", Customer."No.");
                            cust.SetFilter("Date Filter", '%1..%2', FromDateCalc, ToDatecalc);
                            if Cust.Find('-') then begin
                                cust.CalcFields("Old Share Capital Balance");
                                
                                CDiv := ((GenSetUp."Dividend (%)" / 100) * ((Cust."Old Share Capital Balance" + 0) * -1)) * (month / 12);
                                DivTotal := DivTotal + CDiv;

                                DivProg.Init();
                                DivProg."Member No" := Cust."No.";
                                DivProg.Date := ToDateCalc;
                                DivProg."Gross Dividends" := CDiv;
                                DivProg."Witholding Tax" := CDiv * (GenSetUp."Withholding Tax on Dividends" / 100);
                                DivProg."Net Dividends" := DivProg."Gross Dividends" - DivProg."Witholding Tax";
                                DivProg."Qualifying Shares" := ((Cust."Old Share Capital Balance" + 0) * -1) * (month / 12);
                                DivProg.Shares := ((Cust."Old Share Capital Balance" + 0) * -1);
                                DivProg."Deposit Type" := DivProg."Deposit Type"::"Share Capital";
                                DivProg.Year := "Calculation Year";
                                divProg.Insert();
                            end;
                        end;
                    end else begin
                        if "Deposit Type" = "Deposit Type"::Deposits then begin
                            
                            DivTotal := 0;
                            cust.Reset();
                            cust.SetRange("No.", Customer."No.");
                            cust.SetFilter("Employer Code", '%1|%2', 'KENYA POSTAL', 'POSTAL CORP');
                            if Cust.Find('-') then begin
                                checkOffLines.Reset();
                                checkOffLines.SetRange("Member No", Customer."No.");
                                if checkOffLines.Find('-') then begin
                                    salaryEarner.Reset();
                                    salaryEarner.SetRange("Member No", Customer."No.");
                                    salaryEarner.SetFilter("Salary Type", '%1|%2', salaryEarner."Salary Type"::Salary, salaryEarner."Salary Type"::Pension);
                                    salaryEarner.SetFilter("Posting Date", '<=%1', loanCutoffDate);
                                    if salaryEarner.Find('-') then begin
                                        if month < 3 then begin
                                            cust.Reset();
                                            cust.SetRange("No.", Customer."No.");
                                            if Cust.Find('-') then begin
                                                CDiv := 0;
                                                DivTotal := DivTotal + CDiv;

                                                DivProg.Init();
                                                DivProg."Member No" := Cust."No.";
                                                DivProg.Date := ToDateCalc;
                                                DivProg."Gross Dividends" := CDiv;
                                                DivProg."Witholding Tax" := 0;
                                                DivProg."Net Dividends" := 0;
                                                DivProg."Qualifying Shares" := 0;
                                                DivProg.Shares := 0;
                                                DivProg."Deposit Type" := DivProg."Deposit Type"::Deposits;
                                                DivProg.Year := "Calculation Year";
                                                divProg.Insert();
                                            end;
                                        end else begin
                                            cust.Reset();
                                            cust.SetRange("No.", Customer."No.");
                                            cust.SetFilter("Date Filter", '%1..%2', FromDateCalc, ToDatecalc);
                                            if Cust.Find('-') then begin
                                                cust.CalcFields("Current Shares");
                                                
                                                CDiv := ((GenSetUp."Interest on Deposits (%)" / 100) * ((Cust."Current Shares" + 0) * -1)) * (month / 12);
                                                DivTotal := DivTotal + CDiv;

                                                DivProg.Init();
                                                DivProg."Member No" := Cust."No.";
                                                DivProg.Date := ToDateCalc;
                                                DivProg."Gross Dividends" := CDiv;
                                                DivProg."Witholding Tax" := CDiv * (GenSetUp."Withholding Tax on Deposits" / 100);
                                                DivProg."Net Dividends" := DivProg."Gross Dividends" - DivProg."Witholding Tax";
                                                DivProg."Qualifying Shares" := ((Cust."Current Shares" + 0) * -1) * (month / 12);
                                                DivProg.Shares := ((Cust."Current Shares" + 0) * -1);
                                                DivProg."Deposit Type" := DivProg."Deposit Type"::Deposits;
                                                DivProg.Year := "Calculation Year";
                                                divProg.Insert();
                                            end;
                                        end;
                                    end else begin
                                        cust.Reset();
                                        cust.SetRange("No.", Customer."No.");
                                        if Cust.Find('-') then begin
                                            CDiv := 0;
                                            DivTotal := DivTotal + CDiv;

                                            DivProg.Init();
                                            DivProg."Member No" := Cust."No.";
                                            DivProg.Date := ToDateCalc;
                                            DivProg."Gross Dividends" := CDiv;
                                            DivProg."Witholding Tax" := 0;
                                            DivProg."Net Dividends" := 0;
                                            DivProg."Qualifying Shares" := 0;
                                            DivProg.Shares := 0;
                                            DivProg."Deposit Type" := DivProg."Deposit Type"::Deposits;
                                            DivProg.Year := "Calculation Year";
                                            divProg.Insert();
                                        end;
                                    end;
                                end else begin
                                    salaryEarner.Reset();
                                    salaryEarner.SetRange("Member No", Customer."No.");
                                    salaryEarner.SetFilter("Salary Type", '%1|%2', salaryEarner."Salary Type"::Salary, salaryEarner."Salary Type"::Pension);
                                    salaryEarner.SetFilter("Posting Date", '<=%1', loanCutoffDate);
                                    if salaryEarner.Find('-') then begin
                                        if month < 3 then begin
                                            cust.Reset();
                                            cust.SetRange("No.", Customer."No.");
                                            if Cust.Find('-') then begin
                                                CDiv := 0;
                                                DivTotal := DivTotal + CDiv;

                                                DivProg.Init();
                                                DivProg."Member No" := Cust."No.";
                                                DivProg.Date := ToDateCalc;
                                                DivProg."Gross Dividends" := CDiv;
                                                DivProg."Witholding Tax" := 0;
                                                DivProg."Net Dividends" := 0;
                                                DivProg."Qualifying Shares" := 0;
                                                DivProg.Shares := 0;
                                                DivProg."Deposit Type" := DivProg."Deposit Type"::Deposits;
                                                DivProg.Year := "Calculation Year";
                                                divProg.Insert();
                                            end;
                                        end else begin
                                            cust.Reset();
                                            cust.SetRange("No.", Customer."No.");
                                            cust.SetFilter("Date Filter", '%1..%2', FromDateCalc, ToDatecalc);
                                            if Cust.Find('-') then begin
                                                cust.CalcFields("Current Shares");
                                                
                                                CDiv := ((GenSetUp."Interest on Deposits (%)" / 100) * ((Cust."Current Shares" + 0) * -1)) * (month / 12);
                                                DivTotal := DivTotal + CDiv;

                                                DivProg.Init();
                                                DivProg."Member No" := Cust."No.";
                                                DivProg.Date := ToDateCalc;
                                                DivProg."Gross Dividends" := CDiv;
                                                DivProg."Witholding Tax" := CDiv * (GenSetUp."Withholding Tax on Deposits" / 100);
                                                DivProg."Net Dividends" := DivProg."Gross Dividends" - DivProg."Witholding Tax";
                                                DivProg."Qualifying Shares" := ((Cust."Current Shares" + 0) * -1) * (month / 12);
                                                DivProg.Shares := ((Cust."Current Shares" + 0) * -1);
                                                DivProg."Deposit Type" := DivProg."Deposit Type"::Deposits;
                                                DivProg.Year := "Calculation Year";
                                                divProg.Insert();
                                            end;
                                        end;
                                    end;
                                end;
                            end else begin
                                cust.Reset();
                                cust.SetRange("No.", Customer."No.");
                                cust.SetFilter("Date Filter", '%1..%2', FromDateCalc, ToDatecalc);
                                if Cust.Find('-') then begin
                                    cust.CalcFields("Current Shares");
                                    
                                    CDiv := ((GenSetUp."Interest on Deposits (%)" / 100) * ((Cust."Current Shares" + 0) * -1)) * (month / 12);
                                    DivTotal := DivTotal + CDiv;

                                    DivProg.Init();
                                    DivProg."Member No" := Cust."No.";
                                    DivProg.Date := ToDateCalc;
                                    DivProg."Gross Dividends" := CDiv;
                                    DivProg."Witholding Tax" := CDiv * (GenSetUp."Withholding Tax on Deposits" / 100);
                                    DivProg."Net Dividends" := DivProg."Gross Dividends" - DivProg."Witholding Tax";
                                    DivProg."Qualifying Shares" := ((Cust."Current Shares" + 0) * -1) * (month / 12);
                                    DivProg.Shares := ((Cust."Current Shares" + 0) * -1);
                                    DivProg."Deposit Type" := DivProg."Deposit Type"::Deposits;
                                    DivProg.Year := "Calculation Year";
                                    divProg.Insert();
                                end;
                            end;
                        end;
                        if "Deposit Type" = "Deposit Type"::ESS then begin

                            //3
                            DivTotal := 0;
                            cust.Reset();
                            cust.SetRange("No.", Customer."No.");
                            cust.SetFilter("Employer Code", '%1|%2', 'KENYA POSTAL', 'POSTAL CORP');
                            if Cust.Find('-') then begin
                                checkOffLines.Reset();
                                checkOffLines.SetRange("Member No", Customer."No.");
                                if checkOffLines.Find('-') then begin
                                    salaryEarner.Reset();
                                    salaryEarner.SetRange("Member No", Customer."No.");
                                    salaryEarner.SetFilter("Salary Type", '%1|%2', salaryEarner."Salary Type"::Salary, salaryEarner."Salary Type"::Pension);
                                    salaryEarner.SetFilter("Posting Date", '<=%1', loanCutoffDate);
                                    if salaryEarner.Find('-') then begin
                                        if month < 3 then begin
                                            cust.Reset();
                                            cust.SetRange("No.", Customer."No.");
                                            if Cust.Find('-') then begin
                                                CDiv := 0;
                                                DivTotal := DivTotal + CDiv;

                                                DivProg.Init();
                                                DivProg."Member No" := Cust."No.";
                                                DivProg.Date := ToDateCalc;
                                                DivProg."Gross Dividends" := CDiv;
                                                DivProg."Witholding Tax" := 0;
                                                DivProg."Net Dividends" := 0;
                                                DivProg."Qualifying Shares" := 0;
                                                DivProg.Shares := 0;
                                                DivProg."Deposit Type" := DivProg."Deposit Type"::ESS;
                                                DivProg.Year := "Calculation Year";
                                                divProg.Insert();
                                            end;
                                        end else begin
                                            cust.Reset();
                                            cust.SetRange("No.", Customer."No.");
                                            cust.SetFilter("Date Filter", '%1..%2', FromDateCalc, ToDatecalc);
                                            if Cust.Find('-') then begin
                                                cust.CalcFields("School Fees Shares");
                                                
                                                CDiv := ((GenSetUp."Ess Interest%" / 100) * ((Cust."School Fees Shares" + 0) * -1)) * (month / 12);
                                                DivTotal := DivTotal + CDiv;

                                                DivProg.Init();
                                                DivProg."Member No" := Cust."No.";
                                                DivProg.Date := ToDateCalc;
                                                DivProg."Gross Dividends" := CDiv;
                                                DivProg."Witholding Tax" := CDiv * (GenSetUp."Withholding Tax on Deposits" / 100);
                                                DivProg."Net Dividends" := DivProg."Gross Dividends" - DivProg."Witholding Tax";
                                                DivProg."Qualifying Shares" := ((Cust."School Fees Shares" + 0) * -1) * (month / 12);
                                                DivProg.Shares := ((Cust."School Fees Shares" + 0) * -1);
                                                DivProg."Deposit Type" := DivProg."Deposit Type"::ESS;
                                                DivProg.Year := "Calculation Year";
                                                divProg.Insert();
                                            end;
                                        end;
                                    end else begin
                                        cust.Reset();
                                        cust.SetRange("No.", Customer."No.");
                                        if Cust.Find('-') then begin
                                            CDiv := 0;
                                            DivTotal := DivTotal + CDiv;

                                            DivProg.Init();
                                            DivProg."Member No" := Cust."No.";
                                            DivProg.Date := ToDateCalc;
                                            DivProg."Gross Dividends" := CDiv;
                                            DivProg."Witholding Tax" := 0;
                                            DivProg."Net Dividends" := 0;
                                            DivProg."Qualifying Shares" := 0;
                                            DivProg.Shares := 0;
                                            DivProg."Deposit Type" := DivProg."Deposit Type"::ESS;
                                            DivProg.Year := "Calculation Year";
                                            divProg.Insert();
                                        end;
                                    end;
                                end else begin
                                    salaryEarner.Reset();
                                    salaryEarner.SetRange("Member No", Customer."No.");
                                    salaryEarner.SetFilter("Salary Type", '%1|%2', salaryEarner."Salary Type"::Salary, salaryEarner."Salary Type"::Pension);
                                    salaryEarner.SetFilter("Posting Date", '<=%1', loanCutoffDate);
                                    if salaryEarner.Find('-') then begin
                                        if month < 3 then begin
                                            cust.Reset();
                                            cust.SetRange("No.", Customer."No.");
                                            if Cust.Find('-') then begin
                                                CDiv := 0;
                                                DivTotal := DivTotal + CDiv;

                                                DivProg.Init();
                                                DivProg."Member No" := Cust."No.";
                                                DivProg.Date := ToDateCalc;
                                                DivProg."Gross Dividends" := CDiv;
                                                DivProg."Witholding Tax" := 0;
                                                DivProg."Net Dividends" := 0;
                                                DivProg."Qualifying Shares" := 0;
                                                DivProg.Shares := 0;
                                                DivProg."Deposit Type" := DivProg."Deposit Type"::ESS;
                                                DivProg.Year := "Calculation Year";
                                                divProg.Insert();
                                            end;
                                        end else begin
                                            cust.Reset();
                                            cust.SetRange("No.", Customer."No.");
                                            cust.SetFilter("Date Filter", '%1..%2', FromDateCalc, ToDatecalc);
                                            if Cust.Find('-') then begin
                                                cust.CalcFields("School Fees Shares");
                                                
                                                CDiv := ((GenSetUp."Ess Interest%" / 100) * ((Cust."School Fees Shares" + 0) * -1)) * (month / 12);
                                                DivTotal := DivTotal + CDiv;

                                                DivProg.Init();
                                                DivProg."Member No" := Cust."No.";
                                                DivProg.Date := ToDateCalc;
                                                DivProg."Gross Dividends" := CDiv;
                                                DivProg."Witholding Tax" := CDiv * (GenSetUp."Withholding Tax on Deposits" / 100);
                                                DivProg."Net Dividends" := DivProg."Gross Dividends" - DivProg."Witholding Tax";
                                                DivProg."Qualifying Shares" := ((Cust."School Fees Shares" + 0) * -1) * (month / 12);
                                                DivProg.Shares := ((Cust."School Fees Shares" + 0) * -1);
                                                DivProg."Deposit Type" := DivProg."Deposit Type"::ESS;
                                                DivProg.Year := "Calculation Year";
                                                divProg.Insert();
                                            end;
                                        end;
                                    end;
                                end;
                            end else begin
                                cust.Reset();
                                cust.SetRange("No.", Customer."No.");
                                cust.SetFilter("Date Filter", '%1..%2', FromDateCalc, ToDatecalc);
                                if Cust.Find('-') then begin
                                    cust.CalcFields("School Fees Shares");
                                    
                                    CDiv := ((GenSetUp."Ess Interest%" / 100) * ((Cust."School Fees Shares" + 0) * -1)) * (month / 12);
                                    DivTotal := DivTotal + CDiv;

                                    DivProg.Init();
                                    DivProg."Member No" := Cust."No.";
                                    DivProg.Date := ToDateCalc;
                                    DivProg."Gross Dividends" := CDiv;
                                    DivProg."Witholding Tax" := CDiv * (GenSetUp."Withholding Tax on Deposits" / 100);
                                    DivProg."Net Dividends" := DivProg."Gross Dividends" - DivProg."Witholding Tax";
                                    DivProg."Qualifying Shares" := ((Cust."School Fees Shares" + 0) * -1) * (month / 12);
                                    DivProg.Shares := ((Cust."School Fees Shares" + 0) * -1);
                                    DivProg."Deposit Type" := DivProg."Deposit Type"::ESS;
                                    DivProg.Year := "Calculation Year";
                                    divProg.Insert();
                                end;
                            end;
                        end;
                        if "Deposit Type" = "Deposit Type"::"Share Capital" then begin
                            DivTotal := 0;
                            cust.Reset();
                            cust.SetRange("No.", Customer."No.");
                            cust.SetFilter("Date Filter", '%1..%2', FromDateCalc, ToDatecalc);
                            if Cust.Find('-') then begin
                                cust.CalcFields("Shares Retained");
                                
                                CDiv := ((GenSetUp."Dividend (%)" / 100) * ((Cust."Shares Retained" + 0) * -1)) * (month / 12);
                                DivTotal := DivTotal + CDiv;

                                DivProg.Init();
                                DivProg."Member No" := Cust."No.";
                                DivProg.Date := ToDateCalc;
                                DivProg."Gross Dividends" := CDiv;
                                DivProg."Witholding Tax" := CDiv * (GenSetUp."Withholding Tax on Dividends" / 100);
                                DivProg."Net Dividends" := DivProg."Gross Dividends" - DivProg."Witholding Tax";
                                DivProg."Qualifying Shares" := ((Cust."Shares Retained" + 0) * -1) * (month / 12);
                                DivProg.Shares := ((Cust."Shares Retained" + 0) * -1);
                                DivProg."Deposit Type" := DivProg."Deposit Type"::"Share Capital";
                                DivProg.Year := "Calculation Year";
                                divProg.Insert();
                            end;
                        end;
                    end;

                    FromDateCalc := CalcDate('<1D>', ToDateCalc);
                end;
            end;

            trigger OnPreDataItem()
            begin
                userSetup.Reset();
                userSetup.Get(UserId);
                if userSetup."Can Edit Chart Of Accounts" = false then begin
                    Error('The user %1 does not have permissions to process dividends.', UserId);
                end;

                if "Calculation Year" = 0 then Error('Kindly select a year for the dividend calculation');
                if "Deposit Type" = "Deposit Type"::" " then Error('Kindly select which account type to calculate.');

                msg := 'You are calculating %1 for the Period of %2, starting %3 to %4 through Prorated Calculation. Do you wish to continue?';
                skip := false;
                IF "Deposit Type" = "Deposit Type"::Deposits THEN BEGIN
                    confirmationMsg := StrSubstNo(msg, 'Interest on Deposits', "Calculation Year", FromDate, ToDate);
                    if Confirm(confirmationMsg, false) = true then begin
                        DivProg.RESET;
                        DivProg.SetRange(Posted, false);
                        DivProg.SETRANGE(DivProg."Deposit Type", DivProg."Deposit Type"::Deposits);
                        IF DivProg.FINDSET THEN begin
                            DivProg.DELETEALL;
                        end;
                        Cust.RESET;
                        Cust.MODIFYALL(Cust."Deposits Interest Amount", 0);
                    end else skip := true;
                END;

                IF "Deposit Type" = "Deposit Type"::ESS THEN BEGIN
                    confirmationMsg := StrSubstNo(msg, 'Interest on ESS', "Calculation Year", FromDate, ToDate);
                    if Confirm(confirmationMsg, false) = true then begin
                        DivProg.RESET;
                        DivProg.SetRange(Posted, false);
                        DivProg.SETRANGE(DivProg."Deposit Type", DivProg."Deposit Type"::ESS);
                        IF DivProg.FINDSET THEN begin
                            DivProg.DELETEALL;
                        end;
                        Cust.RESET;
                        Cust.MODIFYALL(Cust."ESS Interest Amount", 0);
                    end else skip := true;
                END;

                IF "Deposit Type" = "Deposit Type"::"Share Capital" THEN BEGIN
                    confirmationMsg := StrSubstNo(msg, 'Dividends', "Calculation Year", FromDate, ToDate);
                    if Confirm(confirmationMsg, false) = true then begin
                        DivProg.RESET;
                        DivProg.SetRange(Posted, false);
                        DivProg.SETRANGE(DivProg."Deposit Type", DivProg."Deposit Type"::"Share Capital");
                        IF DivProg.FINDSET THEN begin
                            DivProg.DELETEALL;
                        end;
                        Cust.RESET;
                        Cust.MODIFYALL(Cust."Dividend Amount", 0);
                    end else skip := true;
                END;
                month := 0;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field("Calculation Year";"Calculation Year")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;

                    trigger OnValidate() begin
                        FromDate :=  DMY2Date(1,12,("Calculation Year" - 1));
                        ToDate :=  DMY2Date(31,12,"Calculation Year");
                    end;
                }
                field("Deposit  Type"; "Deposit Type")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
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

    var
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        skip: Boolean;
        Cust: Record Customer;
        dates: Record Date;
        userSetup: Record "User Setup";
        StartDate: Date;
        DateFilter: Text[100];
        "Calculation Year": Integer;
        month: Integer;
        count: Integer;
        FromDate: Date;
        ToDate: Date;
        FromDateCalc: Date;
        ToDateCalc: Date;
        PCKESSDate: Date;
        loanCutoffDate: Date;
        DivTotal: Decimal;
        GenSetUp: Record "Sacco General Set-Up";
        CDeposits: Decimal;
        CustDiv: Record Customer;
        DivProg: Record "Dividends Progression";
        CDiv: Decimal;
        BDate: Date;
        CustR: Record Customer;
        checkOffLines: Record "Checkoff Lines-Distributed-NT";
        salaryEarner: Record "Salary Details";
        CustomerCaptionLbl: Label 'Customer';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        confirmationMsg: Text;
        msg: Text;
        Endyear: Date;
        "Deposit Type": Option " ","Share Capital",Deposits,ESS;
        DividendsProgressionHist: Record "Dividends Progression Hist";
        Members: Record Customer;
        SharesC: Decimal;
        GrossDivs: Decimal;

    local procedure FnCheckIfWithdrawn(MemberNo: Code[40]; StartDate: Date; EndDate: Date): Decimal
    var
        MemberL: Record "Member Ledger Entry";
        Withdrawal: Decimal;
    begin
        Withdrawal := 0;
        MemberL.RESET;
        MemberL.SETRANGE(MemberL."Customer No.", MemberNo);
        MemberL.SETRANGE(MemberL.Reversed, FALSE);
        MemberL.SETFILTER(MemberL.Amount, '>%1', 0);
        MemberL.SETFILTER(MemberL."Transaction Type", '%1', MemberL."Transaction Type"::"Dividend");
        MemberL.SETFILTER(MemberL."Posting Date", '%1..%2', StartDate, EndDate);
        IF MemberL.FINDSET THEN BEGIN
            Withdrawal := MemberL.Amount;
        END;
        EXIT(Withdrawal);
    end;

    local procedure CalculateMonthlyDividends(fromDate: Date; toDate: Date; memberNo: Code[20]) MonthlyDividend: Decimal
    var
        myInt: Integer;
    begin
        
    end;
}




