//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Codeunit 50052 "Leave Year-Close"
{
    TableNo = "HR Leave Periods";

    trigger OnRun()
    begin
        AccountingPeriod.Copy(Rec);
        Code;
        Rec := AccountingPeriod;
    end;

    var
        Text001: label 'You must create a new fiscal year before you can close the old year.';
        Text010: label 'You are HERE.';
        Text002: label 'This function closes the fiscal year from %1 to %2. ';
        Text003: label 'Once the fiscal year is closed it cannot be opened again, and the periods in the fiscal year cannot be changed.\\';
        Text004: label 'Do you want to close the fiscal year?';
        dates: Codeunit "Dates Calculation";
        hrSetup: Record "HR Setup";
        hrLeavePeriods: Record "HR Leave Periods";
        AccountingPeriod: Record "HR Leave Periods";
        AccountingPeriod1: Record "HR Leave Periods";
        AccountingPeriod2: Record "HR Leave Periods";
        AccountingPeriod3: Record "HR Leave Periods";
        FiscalYearStartDate: Date;
        FiscalYearEndDate: Date;
        previousPeriod: Code[20];

    local procedure "Code"()
    begin
        with AccountingPeriod do begin
            AccountingPeriod2.SetRange(Closed, false);
            AccountingPeriod2.Find('-');
            
            previousPeriod := AccountingPeriod2."Period Code";

            FiscalYearStartDate := AccountingPeriod2."Starting Date";
            AccountingPeriod := AccountingPeriod2;
            TestField("New Fiscal Year", true);

            AccountingPeriod2.SetRange("New Fiscal Year", true);
            if AccountingPeriod2.Find('>') then begin
                Message(Text010);

                FiscalYearEndDate := CalcDate('<-1D>', AccountingPeriod2."Starting Date");

                AccountingPeriod3 := AccountingPeriod2;
                AccountingPeriod2.SetRange("New Fiscal Year");
                AccountingPeriod2.Find('<');
            end else begin
                // Error(Text001);
                AccountingPeriod1.Init;
                AccountingPeriod1."Starting Date" := CalcDate('<-CY>', Today);
                AccountingPeriod1."Period Code" := Format(Date2DMY(Today, 3));
                AccountingPeriod1."Period Description" := dates.GetMonth(CalcDate('<-CY>', Today)) + ' ' + Format(Date2DMY(Today, 3));
                AccountingPeriod1.Name := 'Leave Period - ' + Format(Date2DMY(Today, 3));
                AccountingPeriod1."New Fiscal Year" := true;
                AccountingPeriod1.Insert;

                FiscalYearEndDate := CalcDate('<-1D>', AccountingPeriod1."Starting Date");

                // AccountingPeriod2 := AccountingPeriod1;
                AccountingPeriod3 := AccountingPeriod1;
                AccountingPeriod1.SetRange("New Fiscal Year");
                AccountingPeriod1.Find('<');
            end;

            if not
               Confirm(Text002 + Text003 + Text004, false,FiscalYearStartDate, FiscalYearEndDate)
            then
                exit;
            Reset;

            SetRange("Starting Date", FiscalYearStartDate, AccountingPeriod2."Starting Date");
            ModifyAll(Closed, true);

            SetRange("Starting Date", FiscalYearStartDate, AccountingPeriod3."Starting Date");
            ModifyAll("Date Locked", true);

            Reset;

            hrLeavePeriods.Reset();
            hrLeavePeriods.SetRange("Date Locked", true);
            hrLeavePeriods.SetRange(Closed, false);
            if hrLeavePeriods.Find('-') then begin
                hrSetup.Get();
                hrSetup."Leave Posting Period[FROM]" := hrLeavePeriods."Starting Date";
                hrSetup."Leave Posting Period[TO]" := CalcDate('<CY>', hrLeavePeriods."Starting Date");
                hrSetup.Modify;

                fnLeavebalance();
            end;
        end;
    end;


    procedure fnLeavebalance()
    var
        lvLeavebalance: Record "HR Employees";
        employees: Record "HR Employees";
        HRLeaveTypes: Record "HR Leave Types";
        leaveJournal: Record "HR Journal Line";
        hrLeavePeriods: Record "HR Leave Periods";
        carryForward: Decimal;
        renewalDays: Decimal;
        lineNo: Integer;
        entryType: Option Positive,Negative,Reimbursement;
        template: Code[20];
        batchName: Code[20];
        periodCode: Code[20];
        docNo: Code[20];
        postingfrom: Date;
        postingto: Date;
    begin
        hrSetup.Get();
        hrSetup.TestField("Leave Template");
        hrSetup.TestField("Leave Batch");
        hrSetup.TestField("Leave Posting Period[FROM]");
        hrSetup.TestField("Leave Posting Period[TO]");

        template := hrSetup."Leave Template";
        batchName := hrSetup."Leave Batch";
        postingfrom := hrSetup."Leave Posting Period[FROM]";
        postingto := hrSetup."Leave Posting Period[TO]";

        hrLeavePeriods.Reset();
        hrLeavePeriods.SetRange("Date Locked", true);
        hrLeavePeriods.SetRange(Closed, false);
        if hrLeavePeriods.Find('-') then begin
            periodCode := hrLeavePeriods."Period Code";
        end;
        docNo := 'INIT-'+ periodCode;

        leaveJournal.Reset();
        leaveJournal.SetRange("Journal Template Name", hrSetup."Leave Template");
        leaveJournal.SetRange("Journal Batch Name", hrSetup."Leave Batch");
        if leaveJournal.FindSet() then begin
            leaveJournal.DeleteAll();
        end;

        HRLeaveTypes.Reset();
        if HRLeaveTypes.Find('-') then begin
            repeat
            if HRLeaveTypes.Balance = HRLeaveTypes.Balance::"Carry Forward Per Employee" then begin
                employees.Reset();
                if employees.Find('-') then begin
                    repeat
                    carryForward := 0;
                    employees.CalcFields("Annual Leave Account");
                    carryForward := employees."Annual Leave Account";
                    lineNo := lineNo + 1000;
                    InsertLeaveLedgerEntries(template, batchName, lineNo, periodCode, '', true, docNo, employees."No.", postingfrom, entryType::Negative, postingfrom, 'Closing Period - ' + previousPeriod, HRLeaveTypes.Code, postingfrom, postingto, (carryForward)*-1);
                    lineNo := lineNo + 1000;
                    InsertLeaveLedgerEntries(template, batchName, lineNo, periodCode, '', true, docNo, employees."No.", postingfrom, entryType::Positive, postingfrom, previousPeriod + ' - Carry Forward Balances', HRLeaveTypes.Code, postingfrom, postingto, carryForward);
                    lineNo := lineNo + 1000;
                    InsertLeaveLedgerEntries(template, batchName, lineNo, periodCode, '', true, docNo, employees."No.", postingfrom, entryType::Positive, postingfrom, periodCode + ' - Opening Balances', HRLeaveTypes.Code, postingfrom, postingto, employees."Annual Leave Days");
                    until employees.Next() = 0;
                end;
            end else if HRLeaveTypes.Balance = HRLeaveTypes.Balance::"Carry Forward" then begin
                employees.Reset();
                if employees.Find('-') then begin
                    repeat
                    carryForward := 0;
                    employees.CalcFields("Annual Leave Account");
                    carryForward := employees."Annual Leave Account";
                    if carryForward >= HRLeaveTypes."Max Carry Forward Days" then begin
                        employees."Reimbursed Leave Days" := HRLeaveTypes."Max Carry Forward Days";
                    end else if carryForward < HRLeaveTypes."Max Carry Forward Days" then begin
                        lvLeavebalance."Reimbursed Leave Days" := carryForward;
                        lvLeavebalance.Modify;
                    end;
                    lineNo := lineNo + 1000;
                    InsertLeaveLedgerEntries(template, batchName, lineNo, periodCode, '', true, docNo, employees."No.", postingfrom, entryType::Negative, postingfrom, 'Closing Period - ' + previousPeriod, HRLeaveTypes.Code, postingfrom, postingto, (carryForward)*-1);
                    lineNo := lineNo + 1000;
                    InsertLeaveLedgerEntries(template, batchName, lineNo, periodCode, '', true, docNo, employees."No.", postingfrom, entryType::Positive, postingfrom, previousPeriod + ' - Carry Forward Balances', HRLeaveTypes.Code, postingfrom, postingto, carryForward);
                    lineNo := lineNo + 1000;
                    InsertLeaveLedgerEntries(template, batchName, lineNo, periodCode, '', true, docNo, employees."No.", postingfrom, entryType::Positive, postingfrom, periodCode + ' - Opening Balances', HRLeaveTypes.Code, postingfrom, postingto, employees."Annual Leave Days");
                    until employees.Next() = 0;
                end;
            end else if HRLeaveTypes.Balance = HRLeaveTypes.Balance::Ignore then begin
                employees.Reset();
                if employees.Find('-') then begin
                    repeat
                    if HRLeaveTypes.Gender = HRLeaveTypes.Gender::Both then begin
                        case HRLeaveTypes.Code of
                            'COMPASSIONATE':
                                begin
                                    carryForward := 0;
                                    employees.CalcFields("Compassionate Leave Acc.");
                                    carryForward := employees."Compassionate Leave Acc.";
                                    renewalDays := 0;
                                    renewalDays := HRLeaveTypes.Days;
                                end;
                            'SICK':
                                begin
                                    carryForward := 0;
                                    employees.CalcFields("Sick Leave Acc.");
                                    carryForward := employees."Sick Leave Acc.";
                                    renewalDays := 0;
                                    renewalDays := HRLeaveTypes.Days;
                                end;
                        end;
                    end else begin
                        if employees.Gender = employees.Gender::Female then begin
                            carryForward := 0;
                            employees.CalcFields("Maternity Leave Acc.");
                            carryForward := employees."Maternity Leave Acc.";
                            renewalDays := 0;
                            renewalDays := HRLeaveTypes.Days;
                        end else if employees.Gender = employees.Gender::Male then begin
                            carryForward := 0;
                            employees.CalcFields("Paternity Leave Acc.");
                            carryForward := employees."Paternity Leave Acc.";
                            renewalDays := 0;
                            renewalDays := HRLeaveTypes.Days;
                        end;
                    end;

                    lineNo := lineNo + 1000;
                    InsertLeaveLedgerEntries(template, batchName, lineNo, periodCode, '', true, docNo, employees."No.", postingfrom, entryType::Negative, postingfrom, 'Closing Period - ' + previousPeriod, HRLeaveTypes.Code, postingfrom, postingto, (carryForward)*-1);
                    lineNo := lineNo + 1000;
                    InsertLeaveLedgerEntries(template, batchName, lineNo, periodCode, '', true, docNo, employees."No.", postingfrom, entryType::Positive, postingfrom, periodCode + ' - Opening Balances', HRLeaveTypes.Code, postingfrom, postingto, renewalDays);
                    until employees.Next() = 0;
                end;
            end;
            until HRLeaveTypes.Next() = 0;
            
            LeaveJournal.Reset;
            LeaveJournal.SetRange("Journal Template Name", template);
            LeaveJournal.SetRange("Journal Batch Name", batchName);
            if LeaveJournal.Find('-') then begin
                Codeunit.Run(Codeunit::"HR Leave Jnl.-Post", LeaveJournal);
            end;
        end;
    end;

    procedure InsertLeaveLedgerEntries(template: Code[20]; batch: Code[20]; lineNo: Integer; period: Code[20]; leaveApp: Code[20]; initial: Boolean; docNo: Code[20]; staff: Code[20]; postingDate: Date; entryType: Option Positive,Negative,Reimbursement; approvalDate: Date; description: Text[500]; leaveType: Code[20]; startDate: Date; endDate: Date; days: Decimal)
    var
        leaveJournal: Record "HR Journal Line";
    begin
        LeaveJournal.Init;
        LeaveJournal."Journal Template Name" := template;
        LeaveJournal."Journal Batch Name" := batch;
        LeaveJournal."Line No." := lineNo;
        LeaveJournal."Leave Period" := period;
        LeaveJournal."Leave Application No." := leaveApp;
        leaveJournal."Initial Posting" := initial;
        LeaveJournal."Document No." := docNo;
        LeaveJournal."Staff No." := staff;
        LeaveJournal.Validate("Staff No.");
        LeaveJournal."Posting Date" := postingDate;
        LeaveJournal."Leave Entry Type" := entryType;
        LeaveJournal."Leave Approval Date" := approvalDate;
        LeaveJournal.Description := description;
        LeaveJournal."Leave Type" := leaveType;
        LeaveJournal."Leave Period Start Date" := startDate;
        LeaveJournal."Leave Period End Date" := endDate;
        LeaveJournal."No. of Days" := days;
        if LeaveJournal."No. of Days" <> 0 then LeaveJournal.Insert(true);
    end;
}
