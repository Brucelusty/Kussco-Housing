//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50165 "Payroll Employee Assignments."
{
    ApplicationArea = All;
    DeleteAllowed = false;
    InsertAllowed = false;
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
                    Editable = false;
                }
                field(Firstname; Rec.Firstname)
                {
                    Editable = false;
                }
                field(Lastname; Rec.Lastname)
                {
                    Editable = false;
                }
                field("Pays PAYE";Rec."Pays PAYE")
                {
                }
                field("Pays NSSF";Rec."Pays NSSF")
                {
                }
                field("Pays NHIF";Rec."Pays NHIF")
                {
                }
                field(Secondary; Rec.Secondary)
                {
                }
            }
            group(Numbers)
            {
                field("National ID No";Rec."National ID No")
                {
                }
                field("PIN No";Rec."PIN No")
                {
                }
                field("NHIF No";Rec."NHIF No")
                {
                }
                field("NSSF No";Rec."NSSF No")
                {
                }
            }
            group("PAYE Relief and Benefit")
            {
                field(GetsPayeRelief; Rec.GetsPayeRelief)
                {
                }
                field(GetsPayeBenefit; Rec.GetsPayeBenefit)
                {
                }
                field(PayeBenefitPercent; Rec.PayeBenefitPercent)
                {
                }
            }
            group("Employee Company")
            {
                field(Company; Rec.Company)
                {
                }
            }
        }
    }

    actions
    {
    }
}






