//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50164 "Payroll Employee Cummulatives."
{
    ApplicationArea = All;
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    SourceTable = "Payroll Employee.";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No.";Rec."No.")
                {
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
            }
            group(Cummulatives)
            {
                field("Cummulative Basic Pay";Rec."Cummulative Basic Pay")
                {
                }
                field("Cummulative Gross Pay";Rec."Cummulative Gross Pay")
                {
                }
                field("Cummulative Allowances";Rec."Cummulative Allowances")
                {
                }
                field("Cummulative Deductions";Rec."Cummulative Deductions")
                {
                }
                field("Cummulative Net Pay";Rec."Cummulative Net Pay")
                {
                }
                field("Cummulative PAYE";Rec."Cummulative PAYE")
                {
                }
                field("Cummulative NSSF";Rec."Cummulative NSSF")
                {
                }
                field("Cummulative Pension";Rec."Cummulative Pension")
                {
                }
                field("Cummulative HELB";Rec."Cummulative HELB")
                {
                }
                field("Cummulative NHIF";Rec."Cummulative NHIF")
                {
                }
                field("Cummulative Employer Pension";Rec."Cummulative Employer Pension")
                {
                }
                field("Cummulative TopUp";Rec."Cummulative TopUp")
                {
                }
                field("Cummulative Basic Pay(LCY)";Rec."Cummulative Basic Pay(LCY)")
                {
                }
                field("Cummulative Gross Pay(LCY)";Rec."Cummulative Gross Pay(LCY)")
                {
                }
                field("Cummulative Allowances(LCY)";Rec."Cummulative Allowances(LCY)")
                {
                }
                field("Cummulative Deductions(LCY)";Rec."Cummulative Deductions(LCY)")
                {
                }
                field("Cummulative Net Pay(LCY)";Rec."Cummulative Net Pay(LCY)")
                {
                }
                field("Cummulative PAYE(LCY)";Rec."Cummulative PAYE(LCY)")
                {
                }
                field("Cummulative NSSF(LCY)";Rec."Cummulative NSSF(LCY)")
                {
                }
                field("Cummulative Pension(LCY)";Rec."Cummulative Pension(LCY)")
                {
                }
                field("Cummulative HELB(LCY)";Rec."Cummulative HELB(LCY)")
                {
                }
                field("Cummulative NHIF(LCY)";Rec."Cummulative NHIF(LCY)")
                {
                }
                field("Cumm Employer Pension(LCY)";Rec."Cumm Employer Pension(LCY)")
                {
                }
                field("Cummulative TopUp(LCY)";Rec."Cummulative TopUp(LCY)")
                {
                }
                field("Cummulative Gratuity";Rec."Cummulative Gratuity")
                {
                }
                field("Cummulative Gratuity(LCY)";Rec."Cummulative Gratuity(LCY)")
                {
                }
            }
        }
    }

    actions
    {
    }
}






