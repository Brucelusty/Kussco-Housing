//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50711 "Loan Guarantors FOSA"
{
    ApplicationArea = All;
    PageType = ListPart;
    SourceTable = "Loan GuarantorsFOSA";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Account No.";Rec."Account No.")
                {
                }
                field(Names; Rec.Names)
                {
                }
                field("Staff/Payroll No.";Rec."Staff/Payroll No.")
                {
                }
                field("Current Shares";Rec."Current Shares")
                {
                    Editable = false;
                }
                field("Amount Guaranted";Rec."Amount Guaranted")
                {
                }
                field(Substituted; Rec.Substituted)
                {
                }
                field("Line No";Rec."Line No")
                {
                }
                field(Date; Rec.Date)
                {
                }
                field("Self Guarantee";Rec."Self Guarantee")
                {
                }
                field("Loan No";Rec."Loan No")
                {
                }
                field(Salaried; Rec.Salaried)
                {
                }
            }
        }
    }

    actions
    {
    }
}






