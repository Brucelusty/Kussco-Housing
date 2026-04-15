//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50920 "Loans Recovery Logs History"
{
    ApplicationArea = All;
    PageType = ListPart;
    SourceTable = "Loan Recovery Logs";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Loan No"; Rec."Loan No")
                {
                }
                field("Loan Product Type"; Rec."Loan Product Type")
                {
                }
                field("Loan Product Name"; Rec."Loan Product Name")
                {
                }
                field("Loan Balance"; Rec."Loan Balance")
                {
                }
                field("Loan Amount In Arrears"; Rec."Loan Amount In Arrears")
                {
                    Editable = false;
                    Importance = Promoted;
                    Style = Attention;
                    StyleExpr = true;
                }
                field("Loan Arrears Days"; Rec."Loan Arrears Days")
                {
                    Editable = false;
                    Importance = Promoted;
                    Style = Attention;
                    StyleExpr = true;
                }
                field("Log Date"; Rec."Log Date")
                {
                }
                field("User ID"; Rec."User ID")
                {
                }
                field("Log Description"; Rec."Log Description")
                {
                }
            }
        }
    }

    actions
    {
    }
}






