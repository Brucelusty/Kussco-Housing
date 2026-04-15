//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50649 "Bosa Receipt line-Checkoff"
{
    ApplicationArea = All;
    PageType = ListPart;
    SourceTable = "ReceiptsProcessing_L-Checkoff";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Receipt Line No";Rec."Receipt Line No")
                {
                }
                field("Trans Type";Rec."Trans Type")
                {
                }
                field("Member No";Rec."Member No")
                {
                }
                field("Staff/Payroll No";Rec."Staff/Payroll No")
                {
                }
                field(Name; Rec.Name)
                {
                }
                field("Employer Code";Rec."Employer Code")
                {
                }
                field("ID No.";Rec."ID No.")
                {
                }
                field("Loan No";Rec."Loan No")
                {
                }
                field(Amount; Rec.Amount)
                {
                }
                field("Staff Not Found";Rec."Staff Not Found")
                {
                }
                field("Member Found";Rec."Member Found")
                {
                }
                field("Search Index";Rec."Search Index")
                {
                }
            }
        }
    }

    actions
    {
    }
}






