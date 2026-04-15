page 50104 "Posting Group"
{
    ApplicationArea = All;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "Payroll Posting Groups.";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Posting Code"; Rec."Posting Code")
                {

                }
                field(Description; Rec.Description)
                {

                }
                field("Salary Account"; Rec."Salary Account")
                {

                }
                field(SalaryExpenseAC; Rec.SalaryExpenseAC)
                {

                }
                field("Payroll Code"; Rec."Payroll Code")
                {

                }
                field("NHIF Employee Account"; Rec."NHIF Employee Account")
                {

                }
                field("Pension Employee Acc"; Rec."Pension Employee Acc")
                {

                }
                field("Pension Employer Acc"; Rec."Pension Employer Acc")
                {

                }
                field("Employee Provident Fund Acc."; Rec."Employee Provident Fund Acc.")
                {

                }
                field("Tax Relief"; Rec."Tax Relief")
                {

                }
                field("Net Salary Payable"; Rec."Net Salary Payable")
                {

                }
                field("SSF Employee Account"; Rec."SSF Employee Account")
                {

                }
                field("SSF Employer Account"; Rec."SSF Employer Account")
                {

                }
                field("PAYE Account"; Rec."PAYE Account")
                {

                }
            }
        }
        area(Factboxes)
        {

        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {

                trigger OnAction();
                begin

                end;
            }
        }
    }
}


