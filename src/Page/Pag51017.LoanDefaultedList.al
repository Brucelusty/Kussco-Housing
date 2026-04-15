//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51017 "Loan Defaulted List"

{
    ApplicationArea = All;
    CardPageID = "Defauter Card";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    // ModifyAllowed = false;
    PageType = List;
    UsageCategory = Lists;
    PromotedActionCategories = 'New,Process,Reports,Approval,Budgetary Control,Cancellation,Category7_caption,Category8_caption,Category9_caption,Category10_caption';
    SourceTable = "Loans Register";
    SourceTableView = sorting("Client Name") where(Posted = const(true), "Total Outstanding Balance" = filter(>0) /*,"Loans Category"=Filter(Substandard | Watch | Doubtful | Loss)*/);


    layout
    {
        area(content)
        {
            repeater(Control1000000008)
            {
                field("Loan  No."; Rec."Loan  No.")
                {
                    StyleExpr = StyleExprTxt;
                }
                field("Client Code"; Rec."Client Code")
                {
                    Caption = 'Member No';
                    StyleExpr = StyleExprTxt;
                }
               
                field("Client Name"; Rec."Client Name")
                {
                    Caption = 'Member Name';
                    StyleExpr = StyleExprTxt;
                }
                 field("Staff No";Rec."Staff No")
                {
                }
                field("ID NO"; Rec."ID NO")
                {
                    StyleExpr = StyleExprTxt;
                }
                field("Loan Product Type Name"; Rec."Loan Product Type Name")
                {
                    Caption = 'Loan Product';
                    StyleExpr = StyleExprTxt;
                }
                field("Loans Category"; Rec."Loans Category")
                {
                    StyleExpr = StyleExprTxt;
                }
                field("Requested Amount"; Rec."Requested Amount")
                {
                    StyleExpr = StyleExprTxt;
                }
                field("Approved Amount"; Rec."Approved Amount")
                {
                    StyleExpr = StyleExprTxt;
                }
                field(Interest; Rec.Interest)
                {
                    StyleExpr = StyleExprTxt;
                }
                 field("Outstanding Balance"; Rec."Outstanding Balance")
                {
                    StyleExpr = StyleExprTxt;

                }
                field("Outstanding Interest"; Rec."Outstanding Interest")
                {
                    StyleExpr = StyleExprTxt;
                }
                field("Debt Collectors"; Rec."Debt Collector Name")
                {
                }
                // field("Staff No"; Rec."Staff No")
                // {
                //     StyleExpr = StyleExprTxt;
                // }
                // field("Debtor Collection Status";Rec."Debtor Collection Status")
                // {
                // }
                field("Loan Status"; Rec."Loan Status")
                {
                    Editable = true;
                    StyleExpr = StyleExprTxt;
                }
                field("Loan Principle Repayment"; Rec."Loan Principle Repayment")
                {
                    StyleExpr = StyleExprTxt;
                }
                field(Installments; Rec.Installments)
                {
                    StyleExpr = StyleExprTxt;
                }
                field("Disbursed By"; Rec."Disbursed By")
                {
                    StyleExpr = StyleExprTxt;
                }
                field("Loan Disbursement Date"; Rec."Loan Disbursement Date")
                {
                    StyleExpr = StyleExprTxt;
                }
                
                field("Principal In Arrears"; Rec."Principal In Arrears")
                {
                    StyleExpr = StyleExprTxt;
                }
                field("Interest In Arrears"; Rec."Interest In Arrears")
                {
                    StyleExpr = StyleExprTxt;
                }
                field("Days In Arrears"; Rec."Days In Arrears")
                {
                    StyleExpr = StyleExprTxt;
                }
                field(Reversed; Rec.Reversed)
                {
                    StyleExpr = StyleExprTxt;
                    Visible = false;
                }
                field("Loan Offset Amount"; Rec."Loan Offset Amount")
                {
                    StyleExpr = StyleExprTxt;
                }
                field("Loan Principal Offset"; Rec."Loan Principal Offset")
                {
                    StyleExpr = StyleExprTxt;
                }
                field("Captured By"; Rec."Captured By")
                {
                    StyleExpr = StyleExprTxt;
                }
                field("Batch No."; Rec."Batch No.")
                {
                    StyleExpr = StyleExprTxt;
                    visible =  false;
                }
                field("1st Notice";Rec."1st Notice")
                {
                    visible =  false;
                }
                field("2nd Notice";Rec."2nd Notice")
                {
                    visible =  false;
                }
                field("Final Notice";Rec."Final Notice")
                {
                    visible =  false;
                }
            }
        }
        area(factboxes)
        {
            part(Control14; "Member Statistics FactBox")
            {
                Caption = 'Member Statistics FactBox';
                SubPageLink = "No." = field("Client Code");
            }
            part(Control13; "Member Picture-Uploaded")
            {
                Caption = 'Picture';
                Editable = false;
                Enabled = false;
                ShowFilter = false;
                SubPageLink = "No." = field("Client Code");
            }
            part(Control12; "Member Signature-Uploaded")
            {
                Caption = 'Signature';
                Editable = false;
                Enabled = false;
                SubPageLink = "No." = field("Client Code");
            }
            part(Control555; "Member FrontID-Uploaded")
            {
                Caption = 'Front ID';
                Editable = false;
                Enabled = false;
                SubPageLink = "No." = field("Client Code");
            }
            part(Control556; "Member BackID-Uploaded")
            {
                Caption = 'Back ID';
                Editable = false;
                Enabled = false;
                SubPageLink = "No." = field("Client Code");
            }
        }
    }

    // actions
    // {
    //     area(navigation)
    //     {
    //         group(Loan)
    //         {
    //             Caption = 'Loan';
    //             Image = AnalysisView;
    //             action("Loan Appraisal")
    //             {
    //                 Caption = 'Loan Appraisal';
    //                 Enabled = true;
    //                 Image = GanttChart;
    //                 Promoted = true;
    //                 PromotedCategory = "Report";
    //                 PromotedOnly = true;

    //                 trigger OnAction()
    //                 begin
    //                     LoanApp.Reset;
    //                     LoanApp.SetRange(LoanApp."Loan  No.", Rec."Loan  No.");
    //                     if LoanApp.Find('-') then begin
    //                         Report.run(172355, true, false, LoanApp);
    //                     end;
    //                 end;
    //             }
    //             action("Member Ledger Entries")
    //             {
    //                 Caption = 'Ledger Entries';
    //                 Image = CustomerLedger;
    //                 Promoted = true;
    //                 PromotedCategory = "Report";
    //                 PromotedOnly = true;
    //                 RunObject = Page "Member Ledger Entries";
    //                 RunPageLink = "Loan No" = field("Loan  No.");
    //                 RunPageView = sorting("Customer No.");
    //             }
    //             action("Loan Statement")
    //             {
    //                 Image = SelectReport;
    //                 Promoted = true;
    //                 PromotedCategory = "Report";
    //                 PromotedOnly = true;

    //                 trigger OnAction()
    //                 begin
    //                     Cust.Reset;
    //                     Cust.SetRange(Cust."No.", Rec."Client Code");
    //                     Cust.SetFilter("Loan No. Filter", Rec."Loan  No.");
    //                     Cust.SetFilter("Loan Product Filter", Rec."Loan Product Type");
    //                     if Cust.Find('-') then
    //                         Report.run(172531, true, false, Cust);
    //                 end;
    //             }
    //             action("Member Accounts")
    //             {
    //                 Caption = 'Member Accounts';
    //                 Image = List;
    //                 Promoted = true;
    //                 PromotedCategory = Process;
    //                 RunObject = Page "Member Accounts List";
    //                 RunPageLink = "BOSA Account No" = field("Client Code");
    //             }
    //             action("Guarantors' Report")
    //             {
    //                 Image = SelectReport;
    //                 Promoted = true;
    //                 PromotedCategory = "Report";
    //                 PromotedOnly = true;

    //                 trigger OnAction()
    //                 begin
    //                     Cust.Reset;
    //                     Cust.SetRange(Cust."No.", Rec."Client Code");
    //                     Cust.SetFilter("Loan No. Filter", Rec."Loan  No.");
    //                     Cust.SetFilter("Loan Product Filter", Rec."Loan Product Type");
    //                     if Cust.Find('-') then
    //                         Report.run(172504, true, false, Cust);
    //                 end;
    //             }
    //             action("Member Statement")
    //             {
    //                 Promoted = true;
    //                 PromotedCategory = "Report";
    //                 PromotedOnly = true;

    //                 trigger OnAction()
    //                 begin
    //                     Cust.Reset;
    //                     Cust.SetRange(Cust."No.", Rec."Client Code");
    //                     Report.run(172886, true, false, Cust);
    //                 end;
    //             }
    //             action("Members Statistics")
    //             {
    //                 Caption = 'Member Statistics';
    //                 Image = Statistics;
    //                 Promoted = true;
    //                 PromotedCategory = Process;
    //                 PromotedOnly = true;
    //                 RunObject = Page "Members Statistics";
    //                 RunPageLink = "No." = field("Client Code");
    //             }
    //             action("View ScheduleNew")
    //             {
    //                 Caption = 'Loan Repayment Schedule';
    //                 Image = "Table";
    //                 Promoted = true;
    //                 PromotedCategory = "Report";
    //                 PromotedOnly = true;
    //                 ShortCutKey = 'Ctrl+F7';

    //                 trigger OnAction()
    //                 begin
    //                     //SFactory.FnRunLoanAmountDue("Loan  No.");
    //                     //SFactory.FnGenerateLoanRepaymentSchedule("Loan  No.");
    //                     //COMMIT;

    //                     LoanApp.Reset;
    //                     LoanApp.SetRange(LoanApp."Loan  No.", Rec."Loan  No.");
    //                     if LoanApp.Find('-') then
    //                         Report.run(172949, true, false, LoanApp);
    //                 end;
    //             }
    //             action("View ScheduleNew1")
    //             {
    //                 Caption = 'Rescheduled Schedule';
    //                 Image = "Table";
    //                 Promoted = true;
    //                 PromotedCategory = "Report";
    //                 PromotedOnly = true;
    //                 ShortCutKey = 'Ctrl+F7';

    //                 trigger OnAction()
    //                 begin
    //                     //SFactory.FnRunLoanAmountDue("Loan  No.");
    //                     SFactory.FnGenerateLoanRepaymentSchedule(Rec."Loan  No.");
    //                     COMMIT;

    //                     LoanApp.Reset;
    //                     LoanApp.SetRange(LoanApp."Loan  No.", Rec."Loan  No.");
    //                     if LoanApp.Find('-') then
    //                         Report.Run(172477, true, false, LoanApp);
    //                 end;
    //             }
    //             action("Loans to Offset")
    //             {
    //                 Caption = 'Loans to Offset';
    //                 Image = AddAction;
    //                 Promoted = true;
    //                 PromotedCategory = Process;
    //                 PromotedOnly = true;
    //                 RunObject = Page "Loan Offset Detail List-P";
    //                 RunPageLink = "Loan No." = field("Loan  No."),
    //                               "Client Code" = field("Client Code");

    //                 trigger OnAction()
    //                 begin
    //                     //172477
    //                 end;
    //             }
    //             action("Reschedule Repayment Date")
    //             {
    //                 Caption = 'Reschedule Loan Repayment Date';
    //                 Image = Form;
    //                 Promoted = true;
    //                 PromotedCategory = Process;

    //                 trigger OnAction()
    //                 var
    //                     VarScheduleDay: Integer;
    //                     VarScheduleMonth: Integer;
    //                     VarScheduleYear: Integer;
    //                 begin
    //                     Rec.TestField("New Repayment Start Date");
    //                     if Confirm('Confirm you Want to Change Repayment Dates for  this Loan?', false) = true then begin

    //                         VarNewInstalmentDate := Rec."New Repayment Start Date";
    //                         //=======================================================================Loan Repayment Schedule
    //                         ObjLoanRepaymentSchedule.Reset;
    //                         ObjLoanRepaymentSchedule.SetCurrentkey(ObjLoanRepaymentSchedule."Repayment Date");
    //                         ObjLoanRepaymentSchedule.SetRange(ObjLoanRepaymentSchedule."Loan No.", Rec."Loan  No.");
    //                         ObjLoanRepaymentSchedule.SetFilter(ObjLoanRepaymentSchedule."Repayment Date", '>=%1', Rec."Reschedule Effective Date");
    //                         if ObjLoanRepaymentSchedule.FindSet then begin
    //                             repeat
    //                                 ObjLoanRepaymentSchedule."Repayment Date" := VarNewInstalmentDate;
    //                                 ObjLoanRepaymentSchedule.Modify;
    //                                 VarNewInstalmentDate := CalcDate('1M', VarNewInstalmentDate);
    //                             until ObjLoanRepaymentSchedule.Next = 0;
    //                         end;
    //                         //=======================================================================Loan Repayment Schedule  Temp
    //                         ObjLoanRepaymentScheduleTemp.Reset;
    //                         ObjLoanRepaymentScheduleTemp.SetCurrentkey(ObjLoanRepaymentScheduleTemp."Repayment Date");
    //                         ObjLoanRepaymentScheduleTemp.SetRange(ObjLoanRepaymentScheduleTemp."Loan No.", Rec."Loan  No.");
    //                         ObjLoanRepaymentScheduleTemp.SetFilter(ObjLoanRepaymentScheduleTemp."Repayment Date", '>=%1', Rec."Reschedule Effective Date");
    //                         if ObjLoanRepaymentScheduleTemp.FindSet then begin
    //                             repeat
    //                                 ObjLoanRepaymentScheduleTemp."Repayment Date" := VarNewInstalmentDate;
    //                                 ObjLoanRepaymentScheduleTemp.Modify;
    //                                 VarNewInstalmentDate := CalcDate('1M', VarNewInstalmentDate);
    //                             until ObjLoanRepaymentScheduleTemp.Next = 0;
    //                         end;
    //                         Rec."Repayment Dates Rescheduled" := true;
    //                         Rec."Repayment Dates Rescheduled By" := UserId;
    //                         Rec."Repayment Dates Rescheduled On" := Today;
    //                         Message('Loan Repayment Date Changed Succesfully');
    //                     end;
    //                 end;
    //             }
    //             action("Generate Repayment Schedule")
    //             {
    //                 Caption = 'Generate Repayment Schedule';
    //                 Image = "Table";
    //                 Promoted = true;
    //                 PromotedCategory = "Report";
    //                 PromotedOnly = true;
    //                 ShortCutKey = 'Ctrl+F7';
    //                 Visible = false;

    //                 trigger OnAction()
    //                 begin
    //                     //SFactory.FnGenerateLoanRepaymentSchedule("Loan  No.");
    //                     SFactory.FnGenerateLoanRepaymentSchedule(Rec."Loan  No.");

    //                     Commit;

    //                     LoanApp.Reset;
    //                     LoanApp.SetRange(LoanApp."Loan  No.", Rec."Loan  No.");
    //                     if LoanApp.Find('-') then
    //                         SFactory.FnGenerateLoanRepaymentSchedule(Rec."Loan  No.");
    //                     if LoanApp."Loan Product Type" <> 'INST' then begin
    //                         Report.Run(172477, true, false, LoanApp);
    //                     end else begin
    //                         Report.Run(172477, true, false, LoanApp);
    //                     end;
    //                 end;
    //             }
    //             action("Payoff Loan")
    //             {
    //                 Image = Calculate;
    //                 Promoted = true;
    //                 PromotedCategory = Process;
    //                 RunObject = Page "Loan PayOff Card";
    //             }
    //             action(Allocation)
    //             {
    //                 Promoted = true;
    //                 PromotedCategory = Process;
    //                 Caption = 'Allocation';

    //                 trigger OnAction()
    //                 var
    //                    selected: Record "Loans Register";
    //                    newDebtCollectorName: Text;
    //                    confirmresult: integer;
    //                 begin
    //                     // confirmresult := Confirm('Enter the Debt Collector Name: ', newDebtCollectorName);
    //                     selected.setRange("Debt Collector Name", '');
    //                     selected.CalcFields("Schedule Repayment");

                        
    //                 end;                
    //             }
    //             action("Loan Recovery Logs")
    //             {
    //                 Image = Form;
    //                 Promoted = true;
    //                 RunObject = Page "Loan Recovery Logs List";
    //                 RunPageLink = "Member No" = field("No. Series"),
    //                               "Member Name" = field("Name of Chief/ Assistant");
    //             }
    //             action("Loan Recovery Log Report")
    //             {
    //                 Promoted = true;
    //                 PromotedCategory = "Report";
    //                 PromotedOnly = true;

    //                 trigger OnAction()
    //                 begin
    //                     ObjCust.Reset;
    //                     ObjCust.SetRange(ObjCust."No.", Rec."Client Code");
    //                     if ObjCust.Find('-') then
    //                         Report.run(172963, true, false, ObjCust);
    //                 end;
    //             }
    //         }
    //     }
    // }


    actions
    {
        area(creation)
        {
            action("Send 1st Defaulter Notice")
            {
                Caption = 'Send 1st Defaulter Notice';
                Image = Alerts;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                msg: Text;
                begin
                    i := 0;
                    selected:= Dialog.StrMenu(text001, 1, text002);
                    if selected = 1 then begin
                        Cust.Reset();
                        Cust.SetRange("No.", Rec."Client Code");
                        if Cust.Find('-') then begin
                            Vend.Reset();
                            Vend.SetRange("BOSA Account No", Cust."No.");
                            Vend.SetRange("Account Type", '103');
                            if Vend.Find('-') then begin
                                Rec.CalcFields("Total Outstanding Balance");
                                smsMessage:= 'This is to inform that your defauted loan '+rec."Loan  No."+', loan product type '+rec."Loan Product Type Name"+', has a balance of KSHs '+Format(rec."Total Outstanding Balance")+' that was Issued on '+Format(rec."Loan Disbursement Date")+', and the expected date of completion is '+Format(rec."Expected Date of Completion")+'. Consequently you are expected to clear the said arrears within the next 30 days or present a reasonable payment plan. You can make payments through MPESA Paybill number 822221, Account Number '+rec."Loan  No."+'. Our bank details are as below: Account Number: 01120062563602 Co-operative Bank,University Way Branch.';
                                msg:= 'The SMS will read as follows: %1. Do you wish to proceed?';
                                msg:= StrSubstNo(msg, smsMessage);
                                if Confirm(msg, true) = false then exit;
                                smsManagement.SendSmsWithID(Source::LOAN_DEFAULTED, Cust."Mobile Phone No", smsMessage, Vend."No.", Vend."No.", true, 240, true, 'CBS', CreateGuid(), 'CBS');
                            end;
                        end;
                    end else if selected = 2 then begin
                        LoanApp.Reset();
                        LoanApp.SetRange("Loan  No.", Rec."Loan  No.");
                        if LoanApp.Find('-') then begin
                            Report.Run(173011, true, false, LoanApp);
                        end;

                        Rec."1st Notice" := Today;
                        Rec.Modify;
                    end;
                end;
            }
            action("Send 2nd Defaulter Notice")
            {
                Caption = 'Send 2nd Defaulter Notice';
                Image = Alerts;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    currLiability := 0;
                    i := 0;
                    selected:= Dialog.StrMenu(text001, 1, text002);
                    if selected = 1 then begin
                        Rec.CalcFields("Total Outstanding Balance");
                        Cust.Reset();
                        Cust.SetRange("No.", Rec."Client Code");
                        if Cust.Find('-') then begin
                            Vend.Reset();
                            Vend.SetRange("BOSA Account No", Cust."No.");
                            Vend.SetRange("Account Type", '103');
                            if Vend.Find('-') then begin
                                Rec.CalcFields("Total Outstanding Balance");
                                smsMessage:= 'This is to confirm that your '+rec."Loan  No."+', Loan Product Type '+rec."Loan Product Type Name"+' loans totaling to Ksh.'+Format(rec."Total Outstanding Balance")+'. The Sacco depends on prompt repayment of loans to run it daily business operations. Your default is impacting our business negatively and we therefore give you 30 days’ notice to clear the arrears and restore monthly payments failure to which you will be listed with Metropol CRB and the loan recovered from your guarantors without any further reference to you.';
                                msg:= 'The SMS will read as follows: %1. Do you wish to proceed?';
                                msg:= StrSubstNo(msg, smsMessage);
                                if Confirm(msg, true) = false then exit;
                                smsManagement.SendSmsWithID(Source::LOAN_DEFAULTED, Cust."Mobile Phone No", smsMessage, Vend."No.", Vend."No.", true, 240, true, 'CBS', CreateGuid(), 'CBS');
                            end;
                        end;

                        smsMessage := '';
                        msg := '';
                        LoanG.Reset();
                        LoanG.SetRange("Loan No", Rec."Loan  No.");
                        if LoanG.FindSet() then begin
                            repeat
                            currLiability := Round(((Rec."Total Outstanding Balance" / Rec."Approved Amount") * LoanG."Amont Guaranteed"), 0.1, '=');
                            Cust.Reset();
                            if Cust.Get(LoanG."Member No") then begin
                                Vend.Reset();
                                Vend.SetRange("BOSA Account No", Cust."No.");
                                Vend.SetRange("Account Type", '103');
                                if Vend.Find('-') then begin
                                    smsMessage := 'This is to confirm that your guaranteed loan '+rec."Loan  No."+', Loan Product Type '+rec."Loan Product Type Name"+' totaling to Ksh.'+Format(rec."Total Outstanding Balance")+' has fallen into default. Thus follow up with the loanee or Kshs.'+Format(currLiability)+' will be recovered from your deposits.';
                                    msg:= 'The SMS will read as follows: %1. Do you wish to proceed?';
                                    msg:= StrSubstNo(msg, smsMessage);
                                    if Confirm(msg, true) = false then exit;
                                    smsManagement.SendSmsWithID(Source::LOAN_DEFAULTED, Cust."Mobile Phone No", smsMessage, Vend."No.", Vend."No.", true, 240, true, 'CBS', CreateGuid(), 'CBS');
                                end;
                            end;
                            until LoanG.Next() = 0;
                        end;
                    end else if selected = 2 then begin
                        LoanApp.Reset();
                        LoanApp.SetRange("Loan  No.", Rec."Loan  No.");
                        if LoanApp.Find('-') then begin
                            Report.Run(173012, true, false, LoanApp);
                        end;

                        Rec."2nd Notice" := Today;
                        Rec.Modify;
                    end;
                end;
            }
            action("Send 3rd Defaulter Notice")
            {
                Caption = 'Send Final Defaulter Notice';
                Image = Alerts;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    recoveryDate := CalcDate('<1M>', Today);
                    Rec.CalcFields("Outstanding Balance", "Outstanding Interest", "Outstanding Penalty", "Total Outstanding Balance");

                    selected:= Dialog.StrMenu(text101, 1, text002);
                    if selected = 1 then begin
                        Rec.CalcFields("Total Outstanding Balance");
                        Cust.Reset();
                        Cust.SetRange("No.", Rec."Client Code");
                        if Cust.Find('-') then begin
                            Vend.Reset();
                            Vend.SetRange("BOSA Account No", Cust."No.");
                            Vend.SetRange("Account Type", '103');
                            if Vend.Find('-') then begin
                                smsMessage:= 'Kindly note that this letter serves as a final notice for your defaulted loan '+rec."Loan Product Type Name"+' with a total outstanding balance of '+Format(rec."Total Outstanding Balance")+' which will be recovered proportionally from your guarantors'' deposits if the loan remains unpaid.';
                                msg:= 'The SMS will read as follows: %1. Do you wish to proceed?';
                                msg:= StrSubstNo(msg, smsMessage);
                                if Confirm(msg, true) = false then exit;
                                smsManagement.SendSmsWithID(Source::LOAN_DEFAULTED, Cust."Mobile Phone No", smsMessage, Vend."No.", Vend."No.", true, 240, true, 'CBS', CreateGuid(), 'CBS');
                            end;
                        end;
                        
                        smsMessage := '';
                        msg := '';
                        LoanG.Reset();
                        LoanG.SetRange("Loan No", Rec."Loan  No.");
                        if LoanG.FindSet() then begin
                            repeat
                            Rec.CalcFields("Outstanding Balance", "Outstanding Interest", "Outstanding Penalty", "Total Outstanding Balance");
                            amountToRecover := Round(((Rec."Total Outstanding Balance"/Rec."Approved Amount")* LoanG."Amont Guaranteed"), 1, '>');
                            Cust.Reset();
                            if Cust.Get(LoanG."Member No") then begin
                                Vend.Reset();
                                Vend.SetRange("BOSA Account No", Cust."No.");
                                Vend.SetRange("Account Type", '103');
                                if Vend.Find('-') then begin
                                    smsMessage:= 'Kindly note that this letter serves as a final notice for the defaulted loan '+rec."Loan Product Type Name"+' of '+rec."Client Name"+' which you had guaranteed Kshs.'+Format(LoanG."Amont Guaranteed")+'. A total of Kshs.'+Format(amountToRecover)+' will be recovered from your deposits by '+Format(recoveryDate)+' if the loan remains unpaid. The Sacco will continue to pursue the defaulter and restore your deposits once the outstanding balance is cleared.';
                                    msg:= 'The SMS will read as follows: %1. Do you wish to proceed?';
                                    msg:= StrSubstNo(msg, smsMessage);
                                    if Confirm(msg, true) = false then exit;
                                    smsManagement.SendSmsWithID(Source::LOAN_DEFAULTED, Cust."Mobile Phone No", smsMessage, Vend."No.", Vend."No.", true, 240, true, 'CBS', CreateGuid(), 'CBS');
                                end;
                            end;
                            until LoanG.Next() = 0;
                        end;
                    end else if selected = 2 then begin
                        LoanG.Reset();
                        LoanG.SetRange("Loan No", Rec."Loan  No.");
                        if LoanG.Find('-') then begin
                            Report.Run(173013, true, false, LoanG);
                        end;
                    end else if selected = 3 then begin
                        LoanG.Reset();
                        LoanG.SetRange("Loan No", Rec."Loan  No.");
                        if LoanG.Find('-') then begin
                            Report.Run(172998, true, false, LoanG);
                        end;

                        Rec."Final Notice" := Today;
                        Rec.Modify;
                    end;
                end;
            }
            action(Statement2)
            {
                Caption = 'Detailed Statement';
                Image = Customer;
                Promoted = true;
                PromotedCategory = "Report";
                Visible = false;


                trigger OnAction()
                begin
                    Cust.RESET;
                    Cust.SETRANGE(Cust."No.",Rec."BOSA No");
                    IF Cust.FIND('-') THEN
                    REPORT.RUN(173014,TRUE,FALSE,Cust);
                end;
            }
            action("FOSA Statement")
            {
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                Visible = false;


                trigger OnAction()
                begin
                    Cust.RESET;
                    Cust.SETRANGE(Cust."No.",Rec."BOSA No");
                    IF Cust.FIND('-') THEN BEGIN
                    Vend.RESET;
                    Vend.SETRANGE(Vend."No.",Cust."FOSA Account");
                    IF Vend.FINDFIRST THEN
                      BEGIN
                        CatchStaff();
                        REPORT.RUN(50004,TRUE,FALSE,Vend);;
                      END;
                    END;
                end;
            }
        }
    }

    trigger OnOpenPage()
    var
      showRecord: Boolean;
    begin
        // Rec.Reset;
        // Rec.SetFilter("Loans Category", '<>%1', Rec."Loans Category"::Perfoming);
        // if Rec.Find('-') then
        // begin
        //     repeat
        //     showRecord := false;
        //     until Rec.Next = 0;
        // end;
    end;

    trigger OnAfterGetRecord()
    var
        myInt: Integer;
        users: Record "User Setup";
        debtCollectors: Record "Debt Collectors Table";
    begin
        users.Reset();
        users.SetRange("User ID", UserId);
        if users.Find('-') then begin
            if (users."Debt Collector") and (users."Loan Porfolio Manager" = false) then begin
                debtCollectors.Reset();
                debtCollectors.SetRange(UserID, UserId);
                if debtCollectors.Find('-') then begin
                    Rec.SetRange("Loan Debt Collector", debtCollectors."Debtors Code");
                end;
            end;

            if (users."Debt Collector" = false) then begin
                Error('You do not have permissions to view this list');
            end;
        end;

        Overdue := Overdue::" ";
        if FormatField(Rec) then
            Overdue := Overdue::Yes;
        If Rec."Loans Category" = Rec."Loans Category"::Perfoming then
            StyleExprTxt := 'Favorable'
            
        else
            If Rec."Loans Category" = Rec."Loans Category"::Watch then begin
                StyleExprTxt := 'Ambiguous'
            end else
                If Rec."Loans Category" = Rec."Loans Category"::Substandard then begin
                    StyleExprTxt := 'AttentionAccent'
                end else
                    If Rec."Loans Category" = Rec."Loans Category"::Doubtful then begin
                        StyleExprTxt := 'Unfavorable'

                    end
                    else
                        If Rec."Loans Category" = Rec."Loans Category"::Loss then begin
                            StyleExprTxt := 'Attention';
                        end

    end;

    //  trigger OnAfterGetCurrRecord()
    // var
    //    UserSetup: Record "User Setup";
    //    DebtCollT: Record "Debt Collectors Table";
    //    LoansReg: Record "Loans Register";
    // begin
    //     UserSetup.Get(USERID);
    //     if UserSetup."Loan Porfolio Manager" = false then begin
    //         DebtCollT.SetRange(DebtCollT.UserID, UserId);
    //         if DebtCollT.FindFirst() then begin
    //             Rec.SetFilter(Rec."Debt Collector Name",DebtCollT."Debt Collectors");
    //         end
    //         else
    //         Error('You do not have permission to view this list');
    //     end;
    // end;


   
    var
        text001: Label 'SMS Notice, Email Notice';
        text101: Label 'SMS Notice, Preview Notice, Email Notice';
        text002: Label 'Kindly select a means of sending the defaulter notice.';
        selected: Integer;
        smsManagement: Codeunit "Sms Management";
        smsMessage: Text[1250];
        msg: Text;
        Source: Option NEW_MEMBER,NEW_ACCOUNT,LOAN_ACCOUNT_APPROVAL,DEPOSIT_CONFIRMATION,CASH_WITHDRAWAL_CONFIRM,LOAN_APPLICATION,LOAN_APPRAISAL,LOAN_GUARANTORS,LOAN_REJECTED,LOAN_POSTED,LOAN_DEFAULTED,SALARY_PROCESSING,TELLER_CASH_DEPOSIT,TELLER_CASH_WITHDRAWAL,TELLER_CHEQUE_DEPOSIT,FIXED_DEPOSIT_MATURITY,INTERACCOUNT_TRANSFER,ACCOUNT_STATUS,STATUS_ORDER,EFT_EFFECTED,ATM_APPLICATION_FAILED,ATM_COLLECTION,MBANKING,MEMBER_CHANGES,CASHIER_BELOW_LIMIT,CASHIER_ABOVE_LIMIT,INTERNETBANKING,CRM,MOBILE_PIN,WITHDRAWAL,LOAN_REMINDER,PIGGY_BANK,MEMBER_EXIT,ESS_REFUND,FIXED_DEPOSIT,BOD_HONORARIA,LOAN_RECOVERY,MEMBER_ALLOWANCES;
        filters: Text;
        Filename: Text[200];
        defaulterName: Text;
        defaulterEmail: Text;
        EmailSubject: Text;
        EmailBody: Text;
        FinalEmailBody: Text;
        RecRef: RecordRef;
        Outstrm: OutStream;
        TempBlob: Codeunit "Temp Blob";
        EmailSend: Codeunit Email;
        EmailMessage: Codeunit "Email Message";
        EmailScenario: Enum "Email Scenario";
        Recipients: List of [text];
        CCList: List of [Text];
        BccList: List of [Text];
        ConvertedFile: Text;
        Base64Conversion: Codeunit "Base64 Convert";
        InStrm: InStream;
        ChildElements: Code[20];
        emailRecep: Enum "Email Recipient Type";
        i: Integer;
        StyleExprTxt: text[500];
        LoanType: Record "Loan Products Setup";
        PeriodDueDate: Date;
        ScheduleRep: Record "Loan Repayment Schedule";
        RunningDate: Date;
        G: Integer;
        currLiability: Decimal;
        IssuedDate: Date;
        GracePeiodEndDate: Date;
        InstalmentEnddate: Date;
        GracePerodDays: Integer;
        InstalmentDays: Integer;
        NoOfGracePeriod: Integer;
        NewSchedule: Record "Loan Repayment Schedule";
        RSchedule: Record "Loan Repayment Schedule";
        GP: Text[30];
        ScheduleCode: Code[20];
        PreviewShedule: Record "Loan Repayment Schedule";
        PeriodInterval: Code[10];
        CustomerRecord: Record Customer;
        Gnljnline: Record "Gen. Journal Line";
        Jnlinepost: Codeunit "Gen. Jnl.-Post Line";
        CumInterest: Decimal;
        NewPrincipal: Decimal;
        PeriodPrRepayment: Decimal;
        GenBatch: Record "Gen. Journal Batch";
        LineNo: Integer;
        GnljnlineCopy: Record "Gen. Journal Line";
        NewLNApplicNo: Code[10];
        Cust: Record Customer;
        LoanApp: Record "Loans Register";
        TestAmt: Decimal;
        CustRec: Record Customer;
        CustPostingGroup: Record "Customer Posting Group";
        GenSetUp: Record "Sales & Receivables Setup";
        PCharges: Record "Loan Product Charges";
        TCharges: Decimal;
        LAppCharges: Record "Loan Applicaton Charges";
        LoansR: Record "Loans Register";
        LoanAmount: Decimal;
        InterestRate: Decimal;
        RepayPeriod: Integer;
        LBalance: Decimal;
        RunDate: Date;
        InstalNo: Decimal;
        amountToRecover: Decimal;
        recoveryDate: Date;
        RepayInterval: DateFormula;
        TotalMRepay: Decimal;
        LInterest: Decimal;
        LPrincipal: Decimal;
        RepayCode: Code[40];
        GrPrinciple: Integer;
        GrInterest: Integer;
        QPrinciple: Decimal;
        QCounter: Integer;
        InPeriod: DateFormula;
        InitialInstal: Integer;
        InitialGraceInt: Integer;
        GenJournalLine: Record "Gen. Journal Line";
        FOSAComm: Decimal;
        BOSAComm: Decimal;
        GLPosting: Codeunit "Gen. Jnl.-Post Line";
        LoanTopUp: Record "Loan Offset Details";
        Vend: Record Vendor;
        BOSAInt: Decimal;
        TopUpComm: Decimal;
        DActivity: Code[20];
        DBranch: Code[20];
        TotalTopupComm: Decimal;
        CustE: Record Customer;
        DocN: Text[50];
        DocM: Text[100];
        DNar: Text[250];
        DocF: Text[50];
        LoanG: Record "Loans Guarantee Details";
        SpecialComm: Decimal;
        FOSAName: Text[150];
        IDNo: Code[50];
        MovementTracker: Record "Movement Tracker";
        DiscountingAmount: Decimal;
        StatusPermissions: Record "Status Change Permision";
        BridgedLoans: Record "Loan Special Clearance";
        InstallNo2: Integer;
        currency: Record "Currency Exchange Rate";
        CURRENCYFACTOR: Decimal;
        LoanApps: Record "Loans Register";
        LoanDisbAmount: Decimal;
        BatchTopUpAmount: Decimal;
        BatchTopUpComm: Decimal;
        Disbursement: Record "Loan Disburesment-Batching";
        SchDate: Date;
        DisbDate: Date;
        WhichDay: Integer;
        LBatches: Record "Loans Register";
        SalDetails: Record "Loan Appraisal Salary Details";
        LGuarantors: Record "Loans Guarantee Details";
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None",JV,"Member Closure","Account Opening",Batches,"Payment Voucher","Petty Cash",Requisition,Loan,Imprest,ImprestSurrender,Interbank;
        CurrpageEditable: Boolean;
        LoanStatusEditable: Boolean;
        MNoEditable: Boolean;
        ApplcDateEditable: Boolean;
        LProdTypeEditable: Boolean;
        InstallmentEditable: Boolean;
        AppliedAmountEditable: Boolean;
        ApprovedAmountEditable: Boolean;
        RepayMethodEditable: Boolean;
        RepaymentEditable: Boolean;
        BatchNoEditable: Boolean;
        RepayFrequencyEditable: Boolean;
        ModeofDisburesmentEdit: Boolean;
        DisbursementDateEditable: Boolean;
        AccountNoEditable: Boolean;
        LNBalance: Decimal;
        ApprovalEntries: Record "Approval Entry";
        RejectionRemarkEditable: Boolean;
        ApprovalEntry: Record "Approval Entry";
        Overdue: Option Yes," ";
        ScheduleBal: Decimal;
        ObjProductCharge: Record "Loan Product Charges";
        LInsurance: Decimal;
        VarNewInstalmentDate: Date;
        ObjLoanRepaymentSchedule: Record "Loan Repayment Schedule";
        ObjLoanRepaymentScheduleTemp: Record "Loan Repayment Schedule Temp";
        SFactory: Codeunit "Au Factory";
        ObjCust: Record Customer;
        DebtTab: Record "Debt Collectors Table";


    procedure GetVariables(var LoanNo: Code[20]; var LoanProductType: Code[20])
    begin
        LoanNo := Rec."Loan  No.";
        LoanProductType := Rec."Loan Product Type";
    end;


    procedure FormatField(Rec: Record "Loans Register") OK: Boolean
    begin
        if Rec."Outstanding Balance" > 0 then begin
            if (Rec."Expected Date of Completion" < Today) then
                exit(true)
            else
                exit(false);
        end;
    end;


    procedure CalledFrom()
    begin
        Overdue := Overdue::" ";
    end;



    procedure CatchStaff()
    begin
    end;

    local procedure CheckDebtCollector()
    var
        myInt: Integer;
        users: Record "User Setup";
        debtCollectors: Record "Debt Collectors Table";
    begin
        users.Reset();
        users.SetRange("User ID", UserId);
        if users.Find('-') then begin
            if (users."Debt Collector") and (users."Loan Porfolio Manager" = false) then begin
                debtCollectors.Reset();
                debtCollectors.SetRange(UserID, UserId);
                if debtCollectors.Find('-') then begin
                    Rec.SetRange("Loan Debt Collector", debtCollectors."Debtors Code");
                end;
            end;

            if (users."Debt Collector" = false) then begin
                Error('You do not have permissions to view this list');
            end;
        end;
    end;

}






