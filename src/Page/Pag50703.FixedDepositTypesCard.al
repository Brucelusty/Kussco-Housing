//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50703 "Fixed Deposit Types Card"
{
    ApplicationArea = All;
    PageType = Card;
    SourceTable = "Fixed Deposit Type";
    DeleteAllowed = false;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Code"; Rec.Code)
                {
                }
                field(Duration; Rec.Duration)
                {
                }
                field("Interest Rate"; Rec."Interest Rate")
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("No. of Months"; Rec."No. of Months")
                {
                }
            }
            part(Control1102755006; "Fixed Deposit Interest Rates")
            {
                Visible=false;
                 //RunObject = page "Fixed Deposit Interest Rates";
                Caption = 'Interest Computation';
                SubPageLink = Code = field(Code);
            }
        }
    }

    actions
    {
    }
}






