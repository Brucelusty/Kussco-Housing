page 50023 "Matured Notice Card"
{
    ApplicationArea = All;
    PageType = Card;
    UsageCategory = Administration;
    SourceTable = "Withdrawal Notice";
    Editable = false;
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            group(NoticeDetatils)
            {
                field("No."; Rec."No.")
                {

                }
                field("Member No"; Rec."Member No")
                {

                }
                field(Name; Rec.Name)
                {

                }
                field("Phone No"; Rec."Phone No")
                {

                }

                field("Payroll No"; Rec."Payroll No")
                {

                }
                field("FOSA Account"; Rec."FOSA Account")
                {

                }
                field("Notice Date"; Rec."Notice Date")
                {

                }
                field("Withdrawal Type"; Rec."Withdrawal Type")
                {

                }

                field("Maturity Date"; Rec."Maturity Date")
                {

                }
                field("Approval Status"; Rec."Approval Status")
                {

                }
                field("Notice Status"; Rec."Notice Status")
                {

                }

            }
        }
    }



    var
        myInt: Integer;
}


