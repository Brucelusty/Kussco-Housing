report 50093 "Payroll Payslip Emails"
{
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'Layouts/Payroll Payslip..rdlc';

    dataset
    {
        dataitem("Payroll Employee."; "Payroll Employee.")
        {
            RequestFilterFields = "No.";
            column(No; "No.")
            {
            }
            column(Surname; Surname)
            {
            }
            column(FirstName; Firstname)
            {
            }
            column(Lastname; Lastname)
            {
            }
            column(CName; CompanyInfo.Name)
            {
            }
            column(CAddress; CompanyInfo.Address)
            {
            }
            column(CPic; CompanyInfo.Picture)
            {
            }
            column(DEP; "Payroll Employee.".Department)
            {
            }
            column(PINNo; "PIN No")
            {
            }
            column(NSSFNo; "NSSF No")
            {
            }
            column(NHIFNo; "NHIF No")
            {
            }
            column(BankName; "Bank Name")
            {
            }
            column(BranchName; "Branch Name")
            {
            }
            column(BankAccNo; "Bank Account No")
            {
            }
            dataitem("prPeriod Transactions."; "prPeriod Transactions.")
            {
                DataItemLink = "Employee Code" = FIELD("No.");
                column(TCode; "Transaction Code")
                {
                }
                column(TName; "Transaction Name")
                {
                }
                column(Amount; Amount)
                {
                }
                column(Grouping; "prPeriod Transactions."."Group Order")
                {
                }
                column(PeriodName; PeriodName)
                {
                }

                trigger OnAfterGetRecord()
                begin

                    PayrollCalender.RESET;
                    PayrollCalender.SETRANGE(PayrollCalender."Date Opened", "Payroll Employee."."Email Period");
                    IF PayrollCalender.FINDFIRST THEN BEGIN
                        PeriodName := PayrollCalender."Period Name";

                    END;
                end;

                trigger OnPreDataItem()
                begin
                    "prPeriod Transactions.".SETRANGE("prPeriod Transactions."."Payroll Period", "Payroll Employee."."Email Period");
                end;
            }
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field("Payroll Period"; Period)
                {
                    ApplicationArea = All;
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

    trigger OnInitReport()
    begin
        //Period:=CALCDATE('-CM -1D',TODAY);
        Period := CALCDATE('-CM', TODAY);
    end;

    trigger OnPreReport()
    begin
        CompanyInfo.GET;
        CompanyInfo.CALCFIELDS(CompanyInfo.Picture);

        /*PayrollCalender.RESET;
        PayrollCalender.SETRANGE(PayrollCalender.Closed,FALSE);
        IF PayrollCalender.FINDFIRST THEN BEGIN
          //"Payroll Period":=PayrollCalender."Date Opened";
          PayrollCalender.COPYFILTER(PayrollCalender."Date Opened",Period);
          //PeriodName:=PayrollCalender."Period Name";
        END;*/

        IF UserSetup.GET(USERID) THEN BEGIN
            IF UserSetup."View Payroll" = FALSE THEN ERROR('You dont have permissions for payroll, Contact your system administrator! ')
        END;

    end;

    var
        CompanyInfo: Record 79;
        PayrollCalender: Record "Payroll Calender.";
        "Payroll Period": Date;
        PeriodName: Text;
        PayrollEmp: Record "Payroll Employee.";
        UserSetup: Record 91;
        Datee: Date;
        Period: Date;
}




