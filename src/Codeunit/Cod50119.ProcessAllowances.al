codeunit 50119 "Process Allowances"
{
    trigger OnRun()
    begin

    end;

    local procedure FnInitializePosting()
    var
        myInt: Integer;
    begin
        batchTemplate := 'PAYMENTS';
        batchName := 'ALLOWANCES';

        genJournalline.Reset();
        genJournalline.SetRange("Journal Template Name", batchTemplate);
        genJournalline.SetRange("Journal Batch Name", batchName);
        if genJournalline.FindSet() then begin
            genJournalline.DeleteAll();
        end;

        genBatches.Reset();
        genBatches.SetRange("Journal Template Name", batchTemplate);
        genBatches.SetRange(Name, batchName);
        if not genBatches.Find('-') then begin
            genBatches.Init();
            genBatches."Journal Template Name" := batchTemplate;
            genBatches.Name := batchName;
            genBatches.Description := 'Member (Board/Delegate) allowances payments';
            genBatches.Insert();
        end;
    end;

    procedure FnProcessDelegateMemberAllowances(refNo: Code[20]) found: Boolean
    var
        myInt: Integer;
    begin
        found := false;
        meetingMonth := 0;
        lineNo := 0;
        type := 0;
        totalPaye := 0;
        totalHousing := 0;
        totalAllowance := 0;
        totalSitting := 0;
        totalTravel := 0;
        payeHousing := 0;
        payeSitting := 0;
        housing := 0;
        sittingAllow := 0;
        sittingAllowtotal := 0;
        travelAllow := 0;

        FnInitializePosting();

        fundsSetup.Get();
        saccoMeeting.Reset();
        saccoMeeting.SetRange("Meeting No", refNo);
        saccoMeeting.SetRange(Uploaded, true);
        if saccoMeeting.Find('-') then begin
            meetingMonth := Date2DMY(saccoMeeting."Meeting Date", 2);
            meetingYear := Date2DMY(saccoMeeting."Meeting Date", 3);
            meetingMonthname := dateCalc.DetermineMonthText(saccoMeeting."Meeting Date");
            memberType := 'DELEGATE';

            meetingAttendees.Reset();
            meetingAttendees.SetRange("Doc No.", saccoMeeting."Meeting No");
            meetingAttendees.SetRange("Member Present", true);
            if meetingAttendees.FindSet() then begin
                repeat
                    allowanceNo := noSeries.GetNextNo(fundsSetup."Allowance Doc Nos", Today, true);

                    cust.Reset();
                    cust.SetRange("No.", meetingAttendees."Member No");
                    if cust.Find('-') then begin
                        if meetingAttendees.Allowance > 0 then begin

                            docNo := refNo;
                            lineNo := lineNo + 1000;
                            AUFactory.FnCreateGnlJournalLines(batchTemplate, batchName, docNo, lineNo, genJournalline."Transaction Type"::" ",
                            genJournalline."Account Type"::Vendor, cust."FOSA Account No.", Today, (meetingAttendees.Allowance) * -1, 'FOSA',
                            memberType + '-' + meetingMonthname + '-Allowance', '');

                            totalAllowance := totalAllowance + meetingAttendees.Allowance;

                            allowancesInsert.Init();
                            allowancesInsert.Doc_No := allowanceNo;
                            allowancesInsert."No Series" := fundsSetup."Allowance Doc Nos";
                            allowancesInsert."Member No" := meetingAttendees."Member No";
                            allowancesInsert.Defaulter := false;
                            allowancesInsert."Already Paid" := false;
                            allowancesInsert.Dormant := false;
                            allowancesInsert."Amount Paid" := meetingAttendees.Allowance;
                            allowancesInsert."Meeting No" := meetingAttendees."Doc No.";
                            allowancesInsert."Member Type" := allowancesInsert."Member Type"::Delegate;
                            allowancesInsert."Month Paid" := meetingMonthname;
                            allowancesInsert."Month No" := meetingMonth;
                            allowancesInsert.Year := Format(meetingYear);
                            allowancesInsert."Posting Date" := Today;
                            allowancesInsert.Insert();
                        end else begin
                            allowancesInsert.Init();
                            allowancesInsert.Doc_No := allowanceNo;
                            allowancesInsert."No Series" := fundsSetup."Allowance Doc Nos";
                            allowancesInsert."Member No" := meetingAttendees."Member No";
                            allowancesInsert.Defaulter := meetingAttendees.Defaulter;
                            allowancesInsert."Already Paid" := meetingAttendees."Already Paid";
                            allowancesInsert.Dormant := meetingAttendees.Dormant;
                            allowancesInsert."Amount Paid" := meetingAttendees.Allowance;
                            allowancesInsert."Meeting No" := meetingAttendees."Doc No.";
                            allowancesInsert."Member Type" := allowancesInsert."Member Type"::Delegate;
                            allowancesInsert."Month Paid" := meetingMonthname;
                            allowancesInsert."Month No" := meetingMonth;
                            allowancesInsert.Year := Format(meetingYear);
                            allowancesInsert."Posting Date" := Today;
                            allowancesInsert.Insert();
                        end;
                    end;
                until meetingAttendees.Next() = 0;
                fundsSetup.Get();

                lineNo := lineNo + 1000;
                AUFactory.FnCreateGnlJournalLines(batchTemplate, batchName, docNo, lineNo, genJournalline."Transaction Type"::" ",
                genJournalline."Account Type"::"G/L Account", fundsSetup."Delegate Allowance Acc", Today, totalAllowance, 'FOSA',
                memberType + '-' + meetingMonthname + '-Allowances', '');

                genJournalline.Reset();
                genJournalline.SetRange("Journal Batch Name", batchName);
                genJournalline.SetRange("Journal Template Name", batchTemplate);
                if genJournalline.Find('-') then begin
                    Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco", genJournalline);
                end;
            end;
            found := true;
        end;
    end;


    procedure FnProcessBoardMemberAllowances(refNo: Code[20]) found: Boolean
    var
        myInt: Integer;
    begin
        found := false;
        meetingMonth := 0;
        lineNo := 0;
        type := 0;
        totalPaye := 0;
        totalHousing := 0;
        totalAllowance := 0;
        totalSitting := 0;
        totalTravel := 0;
        payeSitting := 0;
        payeHousing := 0;
        housing := 0;
        sittingAllow := 0;
        sittingAllowtotal := 0;
        travelAllow := 0;

        FnInitializePosting();

        fundsSetup.Get();
        saccoMeeting.Reset();
        saccoMeeting.SetRange("Meeting No", refNo);
        saccoMeeting.SetRange(Uploaded, true);
        if saccoMeeting.Find('-') then begin
            meetingMonth := Date2DMY(saccoMeeting."Meeting Date", 2);
            meetingYear := Date2DMY(saccoMeeting."Meeting Date", 3);
            meetingMonthname := dateCalc.DetermineMonthText(saccoMeeting."Meeting Date");
            memberType := saccoMeeting."Committee Name";

            meetingAttendees.Reset();
            meetingAttendees.SetRange("Doc No.", saccoMeeting."Meeting No");
            meetingAttendees.SetRange("Member Present", true);
            if meetingAttendees.FindSet() then begin
                repeat
                    allowanceNo := noSeries.GetNextNo(fundsSetup."Allowance Doc Nos", Today, true);

                    cust.Reset();
                    cust.SetRange("No.", meetingAttendees."Member No");
                    if cust.Find('-') then begin
                        committees.Reset();
                        committees.SetRange("Committee", saccoMeeting."Committee No");
                        committees.SetRange("Member No", cust."No.");
                        if committees.Find('-') then begin
                            if saccoMeeting."Special Meeting" then begin
                                travelAllow := committees."Transport Allowance Special";
                                payeSitting := Round((committees."Sitting Allowance Special" * (fundsSetup."PAYE Percentage" / 100)), 1, '=');
                                sittingAllow := committees."Sitting Allowance Special" - payeSitting;
                                sittingAllowtotal := committees."Sitting Allowance Special";
                                payeHousing := Round((committees."Transport Allowance Special" * (fundsSetup."PAYE Percentage" / 100)), 1, '=');
                                // travelAllow := committees."Transport Allowance Special" - payeHousing;
                                housing := Round(((committees."Sitting Allowance Special" + committees."Transport Allowance Special") * 0.03), 0.01, '=');
                            end else begin
                                travelAllow := committees."Transport Allowance";
                                payeSitting := Round((committees."Sitting Allowance" * (fundsSetup."PAYE Percentage" / 100)), 1, '=');
                                sittingAllow := committees."Sitting Allowance" - payeSitting;
                                sittingAllowtotal := committees."Sitting Allowance";
                                payeHousing := Round((committees."Transport Allowance" * (fundsSetup."PAYE Percentage" / 100)), 1, '=');
                                // travelAllow := committees."Transport Allowance" - payeHousing;
                                housing := Round(((committees."Sitting Allowance" + committees."Transport Allowance") * 0.03), 0.01, '=');
                            end;
                        end;

                        if meetingAttendees.Allowance > 0 then begin

                            docNo := refNo;
                            lineNo := lineNo + 1000;
                            AUFactory.FnCreateGnlJournalLines(batchTemplate, batchName, docNo, lineNo, genJournalline."Transaction Type"::" ",
                            genJournalline."Account Type"::Vendor, cust."Ordinary Savings Acc", Today, ((sittingAllowtotal) * -1), 'FOSA',
                            memberType + '-' + meetingMonthname + '-Sitting Allowance', '');
                            lineNo := lineNo + 1000;
                            AUFactory.FnCreateGnlJournalLines(batchTemplate, batchName, docNo, lineNo, genJournalline."Transaction Type"::" ",
                            genJournalline."Account Type"::Vendor, cust."Ordinary Savings Acc", Today, (payeSitting), 'FOSA',
                            memberType + '-' + meetingMonthname + '-PAYE on Sitting Allowance', '');
                            lineNo := lineNo + 1000;
                            AUFactory.FnCreateGnlJournalLines(batchTemplate, batchName, docNo, lineNo, genJournalline."Transaction Type"::" ",
                            genJournalline."Account Type"::Vendor, cust."Ordinary Savings Acc", Today, ((travelAllow) * -1), 'FOSA',
                            memberType + '-' + meetingMonthname + '-Travel Allowance', '');
                            lineNo := lineNo + 1000;
                            AUFactory.FnCreateGnlJournalLines(batchTemplate, batchName, docNo, lineNo, genJournalline."Transaction Type"::" ",
                            genJournalline."Account Type"::Vendor, cust."Ordinary Savings Acc", Today, (payeHousing), 'FOSA',
                            memberType + '-' + meetingMonthname + '-PAYE on Travel Allowance', '');
                            lineNo := lineNo + 1000;
                            AUFactory.FnCreateGnlJournalLines(batchTemplate, batchName, docNo, lineNo, genJournalline."Transaction Type"::" ",
                            genJournalline."Account Type"::Vendor, cust."Ordinary Savings Acc", Today, (housing), 'FOSA',
                            memberType + '-' + meetingMonthname + '- Housing Levy', '');

                            totalSitting := totalSitting + sittingAllowtotal;
                            totalTravel := totalTravel + travelAllow;
                            totalHousing := totalHousing + housing;
                            totalPaye := totalPaye + payeHousing + payeSitting;

                            allowancesInsert.Init();
                            allowancesInsert.Doc_No := allowanceNo;
                            allowancesInsert."No Series" := fundsSetup."Allowance Doc Nos";
                            allowancesInsert."Member No" := meetingAttendees."Member No";
                            allowancesInsert.Defaulter := false;
                            allowancesInsert."Already Paid" := false;
                            allowancesInsert.Dormant := false;
                            allowancesInsert."Amount Paid" := meetingAttendees.Allowance;
                            allowancesInsert."Meeting No" := meetingAttendees."Doc No.";
                            allowancesInsert."Member Type" := allowancesInsert."Member Type"::Board;
                            allowancesInsert."Month Paid" := meetingMonthname;
                            allowancesInsert."Month No" := meetingMonth;
                            allowancesInsert.Year := Format(meetingYear);
                            allowancesInsert."Posting Date" := Today;
                            allowancesInsert.Insert();
                        end else begin
                            allowancesInsert.Init();
                            allowancesInsert.Doc_No := allowanceNo;
                            allowancesInsert."No Series" := fundsSetup."Allowance Doc Nos";
                            allowancesInsert."Member No" := meetingAttendees."Member No";
                            allowancesInsert.Defaulter := meetingAttendees.Defaulter;
                            allowancesInsert."Already Paid" := meetingAttendees."Already Paid";
                            allowancesInsert.Dormant := meetingAttendees.Dormant;
                            allowancesInsert."Amount Paid" := meetingAttendees.Allowance;
                            allowancesInsert."Meeting No" := meetingAttendees."Doc No.";
                            allowancesInsert."Member Type" := allowancesInsert."Member Type"::Board;
                            allowancesInsert."Month Paid" := meetingMonthname;
                            allowancesInsert."Month No" := meetingMonth;
                            allowancesInsert.Year := Format(meetingYear);
                            allowancesInsert."Posting Date" := Today;
                            allowancesInsert.Insert();
                        end;
                    end;
                until meetingAttendees.Next() = 0;

                fundsSetup.Get();

                lineNo := lineNo + 1000;
                AUFactory.FnCreateGnlJournalLines(batchTemplate, batchName, docNo, lineNo, genJournalline."Transaction Type"::" ",
                genJournalline."Account Type"::"G/L Account", fundsSetup."Sitting Allowance Acc", Today, totalSitting, 'FOSA',
                memberType + '-' + meetingMonthname + '-Sitting Allowances', '');
                lineNo := lineNo + 1000;
                AUFactory.FnCreateGnlJournalLines(batchTemplate, batchName, docNo, lineNo, genJournalline."Transaction Type"::" ",
                genJournalline."Account Type"::"G/L Account", fundsSetup."Travel Allowance Acc", Today, totalTravel, 'FOSA',
                memberType + '-' + meetingMonthname + '-Travel Allowances', '');
                lineNo := lineNo + 1000;
                AUFactory.FnCreateGnlJournalLines(batchTemplate, batchName, docNo, lineNo, genJournalline."Transaction Type"::" ",
                genJournalline."Account Type"::"G/L Account", fundsSetup."Committee Commissions", Today, totalHousing * -1, 'FOSA',
                memberType + '-' + meetingMonthname + '- Housing Levy', '');
                lineNo := lineNo + 1000;
                AUFactory.FnCreateGnlJournalLines(batchTemplate, batchName, docNo, lineNo, genJournalline."Transaction Type"::" ",
                genJournalline."Account Type"::"G/L Account", '400-000-110', Today, totalPaye * -1, 'FOSA',
                memberType + '-' + meetingMonthname + '- PAYE', '');

                genJournalline.Reset();
                genJournalline.SetRange("Journal Batch Name", batchName);
                genJournalline.SetRange("Journal Template Name", batchTemplate);
                if genJournalline.Find('-') then begin
                    Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco", genJournalline);
                end;
            end;
            found := true;
        end;
    end;

    var
        myInt: Integer;
        lineNo: Integer;
        meetingMonth: Integer;
        meetingYear: Integer;
        type: Integer;
        totalSitting: Decimal;
        totalTravel: Decimal;
        totalAllowance: Decimal;
        totalHousing: Decimal;
        totalPaye: Decimal;
        payeSitting: Decimal;
        payeHousing: Decimal;
        housing: Decimal;
        sittingAllow: Decimal;
        sittingAllowtotal: Decimal;
        travelAllow: Decimal;
        allowanceNo: Code[20];
        batchName: Code[20];
        batchTemplate: Code[20];
        docNo: Code[20];
        memberType: Code[50];
        meetingMonthname: Code[20];
        AUFactory: Codeunit "Au Factory";
        dateCalc: Codeunit "Dates Calculation";
        noSeries: Codeunit "No. Series";
        genBatches: Record "Gen. Journal Batch";
        genJournalline: Record "Gen. Journal Line";
        saccoSetup: Record "Sacco General Set-Up";
        fundsSetup: Record "Funds General Setup";
        saccoMeeting: Record "Sacco Meetings";
        meetingAttendees: Record "Meeting Lines";
        allowances: Record "Meeting Allowances";
        allowancesInsert: Record "Meeting Allowances";
        cust: Record Customer;
        vend: Record Vendor;
        committees: Record "Sacco Committee Members";
}
