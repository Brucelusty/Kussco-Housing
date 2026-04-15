//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50171 "Payroll Posting Group."
{
    ApplicationArea = All;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "Payroll Posting Groups.";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Posting Code";Rec."Posting Code")
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("Salary Account";Rec."Salary Account")
                {
                }
                field("PAYE Account";Rec."PAYE Account")
                {
                }
                field("SSF Employer Account";Rec."SSF Employer Account")
                {
                    Caption = 'NSSF Employer Account';
                }
                field("SSF Employee Account";Rec."SSF Employee Account")
                {
                    Caption = 'NSSF Employee Account';
                }

                                field("Housing Levy Employee Acc";Rec."Housing Levy Employee Acc")
                {
                   // Caption = 'NSSF Employer Account';
                }
                field("Housing Levy Employer Acc";Rec."Housing Levy Employer Acc")
                {
                   /// Caption = 'NSSF Employee Account';
                }
                field("Net Salary Payable";Rec."Net Salary Payable")
                {
                }
                field("Salary Processing Control";Rec."Salary Processing Control")
                {
                }
                field("Operating Overtime";Rec."Operating Overtime")
                {
                }
                field("Tax Relief";Rec."Tax Relief")
                {
                }
                field("Employee Provident Fund Acc.";Rec."Employee Provident Fund Acc.")
                {
                }
                field("Pay Period Filter";Rec."Pay Period Filter")
                {
                }
                field("Pension Employer Acc";Rec."Pension Employer Acc")
                {
                }
                field("Pension Employee Acc";Rec."Pension Employee Acc")
                {
                }
                field("Earnings and deductions";Rec."Earnings and deductions")
                {
                }
                field("Staff Benevolent";Rec."Staff Benevolent")
                {
                }
                field(SalaryExpenseAC; Rec.SalaryExpenseAC)
                {
                }
                field("Directors Fee GL";Rec."Directors Fee GL")
                {
                }
                field("Staff Gratuity";Rec."Staff Gratuity")
                {
                }
                field("NHIF Employee Account";Rec."NHIF Employee Account")
                {
                }
                field("Payroll Code";Rec."Payroll Code")
                {
                }
                field("Upload to Payroll";Rec."Upload to Payroll")
                {
                }
                field("PAYE Benefit A/C";Rec."PAYE Benefit A/C")
                {
                }
            }
        }
    }

    actions
    {
    }
}






