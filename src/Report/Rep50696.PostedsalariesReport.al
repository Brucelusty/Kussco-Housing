report 50696 "Postedsalaries Report"
{
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'Layouts\Posted salaries NEW.rdlc';

    dataset
    {
        dataitem("Salary Processing Lines";"Salary Processing Lines")
        {
            DataItemTableView = WHERE(Processed=CONST(True),
                                      Reversed=CONST(False));
            RequestFilterFields = "No.",Date,"Employer Code";
            column(No_SalaryProcessingLines;"Salary Processing Lines"."No.")
            {
            }
            column(StaffNo_SalaryProcessingLines;"Salary Processing Lines"."Staff No.")
            {
            }
            column(EmployerCode_SalaryProcessingLines;"Salary Processing Lines"."Employer Code")
            {
            }
            column(Name_SalaryProcessingLines;"Salary Processing Lines".Name)
            {
            }
            column(AccountNo_SalaryProcessingLines;"Salary Processing Lines"."Account No.")
            {
            }
            column(Amount_SalaryProcessingLines;"Salary Processing Lines".Amount)
            {
            }
            column(AccountName_SalaryProcessingLines;"Salary Processing Lines"."Account Name")
            {
            }
            column(Date_SalaryProcessingLines;"Salary Processing Lines".Date)
            {
            }
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }
}

