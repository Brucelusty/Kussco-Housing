//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50178 "Payroll Periods."
{
    ApplicationArea = All;
    DeleteAllowed = true;
    Editable = true;
    PageType = Card;
    SourceTable = "Payroll Calender.";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                field("Period Month"; Rec."Period Month")
                {
                    Editable = true;
                }
                field("Period Year"; Rec."Period Year")
                {
                    Editable = true;
                }
                field("Period Name"; Rec."Period Name")
                {
                    Editable = true;
                }
                field("Date Opened"; Rec."Date Opened")
                {
                    Editable = true;
                }
                field("Date Closed"; Rec."Date Closed")
                {
                    Editable = true;
                }
                field(Closed; Rec.Closed)
                {
                    Editable = true;
                }
                field("Payroll Code"; Rec."Payroll Code")
                {
                    Editable = true;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Close Period")
            {
                Caption = 'Close Period';
                Image = ClosePeriod;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    /*
                    Warn user about the consequence of closure - operation is not reversible.
                    Ask if he is sure about the closure.
                    */
                    fnGetOpenPeriod;

                    Question := 'Once a period has been closed it can NOT be opened.\It is assumed that you have PAID out salaries.\'
                    + 'Do still want to close [' + strPeriodName + ']';

                    //For Multiple Payroll
                    //ContrInfo.Get();
                    ContrInfo.Reset();
                    if ContrInfo.Find('-') then
                        if ContrInfo."Multiple Payroll" then begin
                            if ContrInfo.find('-') then begin

                                // Message('%1|%2', ContrInfo."Primary Key", ContrInfo.Name);
                                PayrollDefined := '';
                                PayrollType.SetCurrentkey(EntryNo);
                                if PayrollType.FindFirst then begin
                                    NoofRecords := PayrollType.Count;
                                    repeat
                                        i += 1;
                                        PayrollDefined := PayrollDefined + '&' + PayrollType."Payroll Code";
                                        if i < NoofRecords then
                                            PayrollDefined := PayrollDefined + ','
                                    until PayrollType.Next = 0;
                                end;


                                Selection := StrMenu(PayrollDefined, 3);
                                PayrollType.Reset;
                                PayrollType.SetRange(PayrollType.EntryNo, Selection);
                                if PayrollType.Find('-') then begin
                                    PayrollCode := PayrollType."Payroll Code";
                                end;
                            end;
                        end;
                    //End Multiple Payroll



                    Answer := Dialog.Confirm(Question, false);
                    if Answer = true then begin
                        Clear(objOcx);
                        if dtOpenPeriod = 0D then dtOpenPeriod := 20230701D;
                        objOcx.fnClosePayrollPeriod(dtOpenPeriod, PayrollCode);
                        Message('Process Complete');
                    end else begin
                        Message('You have selected NOT to Close the period');
                    end

                end;
            }

            action("Reverse Period Closure")
            {
                Image = ReverseLines;
                Promoted = true;
                PromotedCategory = Process;
                Visible = false;

                trigger OnAction()
                var
                prPeriodTransactions: Record "prPeriod Transactions.";
                prEmployeeTransactions: Record "Payroll Employee Transactions.";
                prEmployeeP9Info: Record "Payroll Employee P9.";
                prNewPayrollPeriods: Record "Payroll Calender.";
                begin
                    if Confirm('Do you wish to delete entries for '+Format(Rec."Date Opened")+' thus reversing the done closure?',true) = false then exit;

                    // prEmployeeTransactions.Reset();
                    // prEmployeeTransactions.SetRange("Payroll Period", Rec."Date Opened");
                    // if prEmployeeTransactions.FindSet() then begin
                    //     repeat
                    //     prEmployeeTransactions.Delete();
                    //     until prEmployeeTransactions.Next() = 0;
                    // end;

                    prNewPayrollPeriods.Reset();
                    prNewPayrollPeriods.SetRange(Closed, true);
                    if prNewPayrollPeriods.Find('+') then begin
                        prNewPayrollPeriods.Closed := false;
                        prNewPayrollPeriods."Date Closed" := 0D;
                        prNewPayrollPeriods.Modify;
                    end;
                    // prNewPayrollPeriods.Reset();
                    // prNewPayrollPeriods.SetRange("Date Opened", Rec."Date Opened");
                    // if prNewPayrollPeriods.Find('-') then begin
                    //     prNewPayrollPeriods.Delete();
                    // end;
                end;
            }
        }
    }

    var
        PayPeriod: Record "Payroll Calender.";
        strPeriodName: Text[30];
        Text000: label '''Leave without saving changes?''';
        Text001: label '''You selected %1.''';
        Question: Text[250];
        Answer: Boolean;
        objOcx: Codeunit "AU Payroll Processing";
        dtOpenPeriod: Date;
        PayrollType: Record "Payroll Type.";
        Selection: Integer;
        PayrollDefined: Text[30];
        PayrollCode: Code[10];
        NoofRecords: Integer;
        i: Integer;
        ContrInfo: Record "Control-Information.";


    procedure fnGetOpenPeriod()
    begin

        //Get the open/current period
        PayPeriod.SetRange(PayPeriod.Closed, false);
        if PayPeriod.Find('-') then begin
            strPeriodName := PayPeriod."Period Name";
            dtOpenPeriod := PayPeriod."Date Opened";
        end;
    end;
}






