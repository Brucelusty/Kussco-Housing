page 50094 "Bosa Receipt line-Checkoffs"
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
                field("Receipt Line No"; Rec."Receipt Line No")
                {
                }
                field("Trans Type"; Rec."Trans Type")
                {
                }
                field("Member No"; Rec."Member No")
                {
                }
                field("Staff/Payroll No"; Rec."Staff/Payroll No")
                {
                }
                field(Name; Rec.Name)
                {
                }
                field("Employer Code"; Rec."Employer Code")
                {
                }
                field("ID No."; Rec."ID No.")
                {
                }
                field("Receipt Header No"; Rec."Receipt Header No")
                {
                }
                field("Loan No"; Rec."Loan No")
                {
                }
                field(Amount; Rec.Amount)
                {
                }
                field("Staff Not Found"; Rec."Staff Not Found")
                {
                }
                field("Member Found"; Rec."Member Found")
                {
                }
                field("Search Index"; Rec."Search Index")
                {
                }
                field("Transaction Type"; Rec."Transaction Type")
                {
                    Editable = false;
                }
                field("Loan Code"; Rec."Loan Code")
                {
                }
                field("Loan Product Type"; Rec."Loan Product Type")
                {
                }
                field("Loan type Code"; Rec."Loan type Code")
                {
                }
                field("Posting Date"; Rec."Posting Date")
                {
                }
                field("Deposit Amount"; Rec."Deposit Amount")
                {
                }
            }
        }
    }

    actions
    {
    }
}




