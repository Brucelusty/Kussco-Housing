//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50602 "prSalary CardXX"
{
    ApplicationArea = All;
    DeleteAllowed = false;
    PageType = ListPart;
    SourceTable = "prSalary Card";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                Caption = 'Payment Info';
                field("Basic Pay";Rec."Basic Pay")
                {
                }
                field("Payment Mode";Rec."Payment Mode")
                {
                }
                field(Currency; Rec.Currency)
                {
                }
                field("Pays NSSF";Rec."Pays NSSF")
                {
                }
                field("Pays NHIF";Rec."Pays NHIF")
                {
                }
                field("Pays PAYE";Rec."Pays PAYE")
                {
                }
                field("Pays Pension";Rec."Pays Pension")
                {
                }
                field("Payslip Message";Rec."Payslip Message")
                {
                }
                field("Cumm BasicPay";Rec."Cumm BasicPay")
                {
                }
                field("Cumm GrossPay";Rec."Cumm GrossPay")
                {
                }
                field("Cumm NetPay";Rec."Cumm NetPay")
                {
                }
                field("Cumm Allowances";Rec."Cumm Allowances")
                {
                }
                field("Cumm Deductions";Rec."Cumm Deductions")
                {
                }
                field("Period Filter";Rec."Period Filter")
                {
                }
                field("Cumm PAYE";Rec."Cumm PAYE")
                {
                }
                field("Cumm NSSF";Rec."Cumm NSSF")
                {
                }
                field("Cumm Pension";Rec."Cumm Pension")
                {
                }
                field("Cumm HELB";Rec."Cumm HELB")
                {
                }
                field("Cumm NHIF";Rec."Cumm NHIF")
                {
                }
                field("Cumm Employer Pension";Rec."Cumm Employer Pension")
                {
                }
                field("Suspend Pay";Rec."Suspend Pay")
                {
                }
                field("Suspension Date";Rec."Suspension Date")
                {
                }
                field("Suspension Reasons";Rec."Suspension Reasons")
                {
                }
                field("Fosa Accounts";Rec."Fosa Accounts")
                {
                }
            }
        }
    }

    actions
    {
    }
}






