report 50705 "Salary Deductions"
{
    ApplicationArea = All;
    Caption = 'Salary Deductions';
    UsageCategory = ReportsAndAnalysis;

    RDLCLayout = 'Layouts\SalaryDeductions.rdlc';
    DefaultLayout = RDLC;
    dataset
    {
        dataitem("Checkoff Deductions Data"; "Salary Deductions Data")
        {
            RequestFilterFields="Document No","Member No";
            column(Document_No; "Document No")
            {

            }
            column(Entry_No; "Entry No")
            {
            }

            column(Member_No; "Member No")
            {
            }

            column(Description; Description)
            {
            }

            column(Amount; Amount)
            {
            }
            column(Expected_Amount;"Expected Amount")
            {
            }
            column(Vendor_No; "Vendor No")
            {
            }
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }
}
