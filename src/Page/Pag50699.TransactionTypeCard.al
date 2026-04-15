//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50699 "Transaction Type Card"
{
    ApplicationArea = All;
    PageType = Card;
    SourceTable = "Transaction Types";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Code"; Rec.Code)
                {
                }
                field(Description; Rec.Description)
                {
                }
                field(Type; Rec.Type)
                {
                }
                field("Account Type"; Rec."Account Type")
                {
                }
                field("Has Schedule"; Rec."Has Schedule")
                {
                }
                field("Transaction Category"; Rec."Transaction Category")
                {
                }
                field("Transaction Span"; Rec."Transaction Span")
                {
                }
                field("Default Mode"; Rec."Default Mode")
                {
                }
                field("Lower Limit"; Rec."Lower Limit")
                {
                }
                field("Upper Limit"; Rec."Upper Limit")
                {
                }
                field("Mobile Transaction Type"; Rec."Mobile Transaction Type")
                {
                }
                field("Use Graduated Charge"; Rec."Use Graduated Charge")
                {
                }
                field("MPESA Transaction"; Rec."MPESA Transaction")
                {
                }
            }
            part(Control1; "Transaction Charges")
            {
                SubPageLink = "Transaction Type" = field(Code),
                              "Account Type" = field("Account Type");
            }
        }
    }

    actions
    {
    }
}






