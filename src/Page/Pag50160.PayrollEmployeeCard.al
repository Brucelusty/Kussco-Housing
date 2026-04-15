//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50160 "Payroll Employee Card."
{
    ApplicationArea = All;
    DeleteAllowed = false;
    InsertAllowed = true;
    PageType = Card;
    SourceTable = "Payroll Employee.";
    PromotedActionCategories = 'New,Process,Report,Cummulatives,Calculate,Member Details';

    layout
    {
        area(content)
        {
            group(General)
            {
                Editable = canProcessPayroll;
                field("No."; Rec."No.")
                {
                    Caption = 'Staff No';
                }
                field("Payroll No"; Rec."Payroll No")
                {
                    Caption = 'Sacco Member No.';
                }
                field(Surname; Rec.Surname)
                {
                }
                field(Firstname; Rec.Firstname)
                {
                }
                field(Lastname; Rec.Lastname)
                {
                }
                field("Employee Email"; Rec."Employee Email")
                {
                }
                field("Joining Date"; Rec."Joining Date")
                {
                }
                field("Email Period"; Rec."Email Period")
                {
                    ShowMandatory = true;
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    Visible = false;
                }
                field("Global Dimension 1"; Rec."Global Dimension 1")
                {
                }
                field("Global Dimension 2"; Rec."Global Dimension 2")
                {
                }
                field("Posting Group"; Rec."Posting Group")
                {
                }
                field(Status; Rec.Status)
                {
                }
                field("National ID No"; Rec."National ID No")
                {
                }
                field("NSSF No"; Rec."NSSF No")
                {
                }
                field("NHIF No"; Rec."NHIF No")
                {
                }
                field("PIN No"; Rec."PIN No")
                {
                }
                field("Job Group"; Rec."Job Group")
                {
                }
                field(Category; Rec.Category)
                {
                }
                field(Department; Rec.Department)
                {
                }
                field("Managerial Position"; Rec."Managerial Position")
                {
                }
            }
            group("Pay Details")
            {
                Editable = canProcessPayroll;
                field("Basic Pay"; Rec."Basic Pay")
                {
                }
                field("Paid per Hour"; Rec."Paid per Hour")
                {
                }
                field("Pays PAYE"; Rec."Pays PAYE")
                {
                }
                field("Pays NSSF"; Rec."Pays NSSF")
                {
                }
                field("Pays NHIF"; Rec."Pays NHIF")
                {
                }
                field("Payment Mode"; Rec."Payment Mode")
                {
                }
                field("Insurance Premium"; Rec."Insurance Premium")
                {
                }
                field("Pays Pension"; Rec."Pays Pension") { }
                field("Employee Pension %"; Rec."Employee Pension %") { }
                field("Employer Pension %"; Rec."Employer Pension %") { }
            }
            group("Bank Details")
            {
                Editable = canProcessPayroll;
                field("Bank Code"; Rec."Bank Code")
                {
                    Visible = false;
                }
                field("Bank Name"; Rec."Bank Name")
                {
                }
                field("Branch Code"; Rec."Branch Code")
                {
                    Visible = false;
                }
                field("Branch Name"; Rec."Branch Name")
                {
                }
                field("Bank Account No"; Rec."Bank Account No")
                {
                }
                field("Loan Settlement Account"; Rec."Loan Settlement Account")
                {
                }
            }
            group("Other Details")
            {
                Editable = canProcessPayroll;
                field("Value To Calculate";Rec."Value To Calculate")
                {
                }
                field("Payslip Message"; Rec."Payslip Message")
                {
                }
            }
            group("Cummulative Figures")
            {
                Editable = false;
                field("Cummulative Basic Pay"; Rec."Cummulative Basic Pay")
                {
                }
                field("Cummulative Gross Pay"; Rec."Cummulative Gross Pay")
                {
                }
                field("Cummulative Allowances"; Rec."Cummulative Allowances")
                {
                }
                field("Cummulative Deductions"; Rec."Cummulative Deductions")
                {
                }
                field("Cummulative Net Pay"; Rec."Cummulative Net Pay")
                {
                }
                field("Cummulative PAYE"; Rec."Cummulative PAYE")
                {
                }
                field("Cummulative NSSF"; Rec."Cummulative NSSF")
                {
                }
                field("Cummulative Pension"; Rec."Cummulative Pension")
                {
                }
                field("Cummulative HELB"; Rec."Cummulative HELB")
                {
                }
                field("Cummulative NHIF"; Rec."Cummulative NHIF")
                {
                }
            }
            group("Suspension of Payment")
            {
                Editable = canProcessPayroll;
                field("Suspend Pay"; Rec."Suspend Pay")
                {
                }
                field("Suspend Date"; Rec."Suspend Date")
                {
                }
                field("Suspend Reason"; Rec."Suspend Reason")
                {
                }
            }
            group("Staff Existing Details")
            {
                Editable = canProcessPayroll;
                field("Exit Staff"; Rec."Exit Staff")
                {
                }
                field("Date Exited"; Rec."Date Exited")
                {
                    Editable = false;
                }
                field("Exited By"; Rec."Exited By")
                {
                    Editable = false;
                }
                field("Reason For Exiting Staff"; Rec."Reason For Exiting Staff")
                {
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Employee Earnings")
            {
                Image = AllLines;
                Promoted = true;
                PromotedCategory = Process;
                Enabled = canProcessPayroll;
                PromotedIsBig = true;
                PromotedOnly = true;
                RunObject = Page "Payroll Employee Earnings.";
                RunPageLink = "No." = field("No.");
                RunPageView = where("Transaction Type" = filter(Income));
            }
            action("Employee Deductions")
            {
                Image = EntriesList;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                Enabled = canProcessPayroll;
                RunObject = Page "Payroll Employee Deductions.";
                RunPageLink = "No." = field("No.");
                // "Sacco Membership No." = field("Payroll No");
                RunPageView = where("Transaction Type" = filter(Deduction));
            }
            action("Employee Assignments")
            {
                Image = Apply;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                PromotedOnly = true;
                Enabled = canProcessPayroll;
                RunObject = Page "Payroll Employee Assignments.";
                RunPageLink = "No." = field("No.");
            }
            action("Employee Cummulatives")
            {
                Image = History;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                PromotedOnly = true;
                Enabled = canProcessPayroll;
                RunObject = Page "Payroll Employee Cummulatives.";
                RunPageLink = "No." = field("No.");
            }
            action("Calculate PAYE")
            {
                Image = CalculateRemainingUsage;
                Promoted = true;
                PromotedCategory = Category5;
                PromotedIsBig = true;
                PromotedOnly = true;
                Enabled = canProcessPayroll;
                
                trigger OnAction() begin
                    Message('The PAYE of this staff with a Taxable Pay of %1 is %2.', Rec."Value To Calculate", ProcessPayroll.fnGetEmployeePaye(Rec."Value To Calculate"));
                end;
            }
            action("Calculate SHIF")
            {
                Image = CalculateDepreciation;
                Promoted = true;
                PromotedCategory = Category5;
                PromotedIsBig = true;
                PromotedOnly = true;
                Enabled = canProcessPayroll;
                
                trigger OnAction() begin
                    Message('The SHIF of this staff with a Gross Pay of %1 is %2.', Rec."Value To Calculate", ProcessPayroll.fnGetEmployeeNHIF(Rec."Value To Calculate"));
                end;
            }
            action("View PaySlip")
            {
                Image = TaxPayment;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                var
                payslipTrans: Record "prPeriod Transactions.";
                begin
                    payslipTrans.Reset;
                    payslipTrans.SetRange("Employee Code", Rec."No.");
                    if payslipTrans.FindFirst then begin
                        Report.Run(80034, true, false, payslipTrans);
                    end;
                end;
            }
            action("View P9 Slip")
            {
                Image = PaymentHistory;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                begin
                    p9PeriodTrans.Reset;
                    p9PeriodTrans.SetRange("Employee Code", Rec."No.");
                    if p9PeriodTrans.FindFirst then begin
                        Report.Run(80035, true, false, p9PeriodTrans);
                    end;
                end;
            }
            action(Member_Info)
            {
                Caption = 'Member Details';
                Image = Statistics;
                Promoted = true;
                PromotedCategory = Category6;
                PromotedOnly = true;
                RunObject = Page "Members Statistics";
                RunPageLink = "No." = field("Payroll No");
            }
            action("Process Payroll")
            {
                Image = Allocations;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                Enabled = canProcessPayroll;

                trigger OnAction()
                begin

                    //ContrInfo.GET;
                    UserSetup.Get(UserId);
                    if UserSetup."Allow Process Payroll" = false then Error('This user lacks the rights to process the staff payroll.');

                    objPeriod.Reset;
                    objPeriod.SetRange(objPeriod.Closed, false);
                    if objPeriod.Find('-') then;
                    SelectedPeriod := objPeriod."Date Opened";

                    SalCard.Get(Rec."No.");


                    //Delete all Records from the prPeriod Transactions for Reprocessing
                    //Message('%1-%2', PayrollCode, SelectedPeriod);
                    prPeriodTransactions.Reset;
                    prPeriodTransactions.SetRange(prPeriodTransactions."Payroll Code", PayrollCode);
                    prPeriodTransactions.SetRange(prPeriodTransactions."Payroll Period", SelectedPeriod);
                    if prPeriodTransactions.Find('-') then begin
                        prPeriodTransactions.DeleteAll;
                        // Message('home');
                    end;
                    PayrollEmp.Reset;
                    PayrollEmp.SetRange(PayrollEmp.Status, PayrollEmp.Status::Active);
                    PayrollEmp.SetRange(PayrollEmp."Suspend Pay", false);
                    if PayrollEmp.FindSet then begin
                        // ProgressWindow.OPEN('Processing Salary for Employee No. #1#######');
                        repeat
                            PayrollEmp.TestField(PayrollEmp."Posting Group");
                            PayrollEmp.TestField(PayrollEmp."Joining Date");
                            PayrollEmp.TestField(PayrollEmp."Basic Pay");
                            PayrollEmp.TestField(PayrollEmp."PIN No");
                            PayrollEmp.TestField(PayrollEmp."NHIF No");
                            PayrollEmp.TestField(PayrollEmp."NSSF No");

                            //First Remove Any transactions for this Month
                            RemoveTrans(PayrollEmp."No.", "Payroll Period");
                        until PayrollEmp.Next = 0;
                    end;



                    //Delete all Records from prEmployer Deductions
                    prEmployerDeductions.Reset;
                    prEmployerDeductions.SetRange(prEmployerDeductions."Payroll Code", PayrollCode);
                    prEmployerDeductions.SetRange(prEmployerDeductions."Payroll Period", SelectedPeriod);
                    if prEmployerDeductions.Find('-') then
                        prEmployerDeductions.DeleteAll;

                    //Use CODEUNIT
                    HrEmployee.Reset;
                    HrEmployee.SetRange(HrEmployee.Status, HrEmployee.Status::Active);
                    if ContrInfo."Multiple Payroll" then
                        HrEmployee.SetRange(HrEmployee."No.", PayrollCode);

                    if HrEmployee.Find('-') then begin

                        ProgressWindow.Open('Processing Salary for Employee No. #1#######');
                        repeat

                            Sleep(100);
                            SalCard.Reset();
                            SalCard.SetRange(SalCard."No.", Rec."No.");
                            SalCard.SetRange(SalCard."Suspend Pay", false);
                            if SalCard.Find('-') then begin

                                //Message('%1-%2', SalCard."Suspend Pay", SalCard."No.");
                                //Suspended
                                /// IF not SalCard."Suspend Pay" THEN BEGIN

                                ProgressWindow.Update(1, HrEmployee."No." + ':' + HrEmployee.Firstname + ' ' + HrEmployee.Lastname + ' ' + HrEmployee.Surname);
                                if SalCard.Get(HrEmployee."No.") then
                                    ProcessPayroll.fnProcesspayroll(HrEmployee."No.", HrEmployee."Joining Date", SalCard."Basic Pay", SalCard."Pays PAYE"
                                        , SalCard."Pays NSSF", SalCard."Pays NHIF", SelectedPeriod, SelectedPeriod, '', '',
                                       HrEmployee."Date of Leaving", true, HrEmployee."Global Dimension 1", PayrollCode, SalCard."Suspend Pay")//,HrEmployee."Global Dimension 1",HrEmployee."Global Dimension 2 Code");
                            end;
                        until HrEmployee.Next = 0;
                        ////Progress Window
                        ProgressWindow.Close;
                    end;
                    Message('Payroll processing completed successfully.');
                end;
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        
        canProcessPayroll := true;
        if userSetup.Get(UserId) then begin
            if userSetup."Allow Process Payroll" = false then begin
                Employees.Reset();
                Employees.SetRange("User ID", UserId);
                if Employees.Find('-') then begin
                    Rec.SetRange(Rec."No.", Employees."No.");
                    canProcessPayroll := false;
                end;
            end;
        end;
        
    end;
    trigger OnAfterGetRecord()
    begin
        
        canProcessPayroll := true;
        if userSetup.Get(UserId) then begin
            if userSetup."Allow Process Payroll" = false then begin
                Employees.Reset();
                Employees.SetRange("User ID", UserId);
                if Employees.Find('-') then begin
                    Rec.SetRange(Rec."No.", Employees."No.");
                    canProcessPayroll := false;
                end;
            end;
        end;
        
    end;
    trigger OnOpenPage()
    begin
        
        canProcessPayroll := true;
        if userSetup.Get(UserId) then begin
            if userSetup."Allow Process Payroll" = false then begin
                Employees.Reset();
                Employees.SetRange("User ID", UserId);
                if Employees.Find('-') then begin
                    Rec.SetRange(Rec."No.", Employees."No.");
                    canProcessPayroll := false;
                end;
            end;
        end;
        
    end;

    trigger OnInit()
    begin
        //TODO
        /*IF UserSetup.GET(USERID) THEN
        BEGIN
        IF UserSetup."View Payroll"=FALSE THEN ERROR ('You dont have permissions for payroll, Contact your system administrator! ')
        END;*/

    end;

    var
        PayrollEmp: Record "Payroll Employee.";
        // PayrollManager: Codeunit "Payroll Management";
        "Payroll Period": Date;
        PayrollCalender: Record "Payroll Calender.";
        PayrollMonthlyTrans: Record "Payroll Monthly Transactions.";
        PayrollEmployeeDed: Record "Payroll Employee Deductions.";
        PayrollEmployerDed: Record "Payroll Employer Deductions.";
        objEmp: Record "Salary Processing Header";
        SalCard: Record "Payroll Employee.";
        objPeriod: Record "Payroll Calender.";
        SelectedPeriod: Date;
        PeriodName: Text[30];
        PeriodMonth: Integer;
        PeriodYear: Integer;
        ProcessPayroll: Codeunit "AU Payroll Processing";
        HrEmployee: Record "Payroll Employee.";
        ProgressWindow: Dialog;
        prPeriodTransactions: Record "prPeriod Transactions.";
        prEmployerDeductions: Record "Payroll Employer Deductions.";
        p9PeriodTrans: Record "Payroll Employee P9.";
        PayrollType: Record "Payroll Type.";
        Employees: Record "HR Employees";
        Selection: Integer;
        canProcessPayroll: Boolean;
        PayrollDefined: Text[30];
        PayrollCode: Code[10];
        NoofRecords: Integer;
        i: Integer;
        ContrInfo: Record "Control-Information.";
        UserSetup: Record "User Setup";
        ObjPayrollTransactions: Record "prPeriod Transactions.";
        varPeriodMonth: Integer;
        ObjPayrollEmployees: Record "Payroll Employee.";

    local procedure RemoveTrans(EmpNo: Code[20]; PayrollPeriod: Date)
    begin
    end;

    local procedure FnRunCreatePayrollSummary()
    var
        ObjPayrollTranS: Record "prPeriod Transactions Summary";
        ObjPeriodTrans: Record "prPeriod Transactions.";
        ObjPeriodTransII: Record "prPeriod Transactions.";
        VarPeriodAmount: Decimal;
    begin
        objPeriod.Reset;
        objPeriod.SetRange(objPeriod.Closed, false);
        if objPeriod.Find('-') then begin
            SelectedPeriod := objPeriod."Date Opened";
            varPeriodMonth := objPeriod."Period Month";
            SalCard.Get(Rec."No.");
        end;


        ObjPayrollTranS.Reset;
        ObjPayrollTranS.SetRange(ObjPayrollTranS."Payroll Period", objPeriod."Date Opened");
        if ObjPayrollTranS.Find('-') then begin
            ObjPayrollTranS.DeleteAll;
        end;

        VarPeriodAmount := 0;
        ObjPeriodTrans.Reset;
        ObjPeriodTrans.SetRange(ObjPeriodTrans."Employee Code", Rec."No.");
        ObjPeriodTrans.SetRange(ObjPeriodTrans."Payroll Period", SelectedPeriod);
        ObjPeriodTrans.SetFilter(ObjPeriodTrans."Transaction Code", ObjPeriodTransII."Transaction Code");
        if ObjPeriodTrans.Find('-') then begin
            repeat
                ObjPeriodTrans.CalcSums(ObjPeriodTrans.Amount);
                VarPeriodAmount := ObjPeriodTrans.Amount;

                ObjPayrollTranS.Init;
                ObjPayrollTranS."Document Code" := '';
                ObjPayrollTranS."Transaction Code" := ObjPeriodTrans."Transaction Code";
                ObjPayrollTranS."Period Month" := ObjPeriodTrans."Period Month";
                ObjPayrollTranS."Period Year" := ObjPeriodTrans."Period Year";
                ObjPayrollTranS."Reference No" := ObjPeriodTrans."Reference No";
                ObjPayrollTranS."Group Order" := ObjPeriodTrans."Group Order";
                ObjPayrollTranS."Group Text" := ObjPeriodTrans."Group Text";
                ObjPayrollTranS."Transaction Name" := ObjPeriodTrans."Transaction Name";
                ObjPayrollTranS.Amount := VarPeriodAmount;
                ObjPayrollTranS."Sub Group Order" := ObjPeriodTrans."Sub Group Order";
                ObjPayrollTranS."Payroll Period" := ObjPeriodTrans."Payroll Period";
                ObjPayrollTranS."GL Account" := ObjPeriodTrans."GL Account";
                ObjPayrollTranS."Journal Account Code" := ObjPeriodTrans."Journal Account Code";
                ObjPayrollTranS."Journal Account Type" := ObjPeriodTrans."Journal Account Type";
                ObjPayrollTranS."Post As" := ObjPeriodTrans."Post As";
                ObjPayrollTranS."coop parameters" := ObjPeriodTrans."coop parameters";
                ObjPayrollTranS."Payroll Code" := ObjPeriodTrans."Payroll Code";
                ObjPayrollTranS."Fosa Account No." := ObjPeriodTrans."Fosa Account No.";
                ObjPayrollTranS."Sacco Member No" := ObjPeriodTrans."Sacco Member No";
                ObjPayrollTranS.Insert;
            until ObjPeriodTrans.Next = 0;
        end;
    end;
}




