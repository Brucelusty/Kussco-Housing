//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50614 "Cheque Truncation Card"
{
    ApplicationArea = All;
    PageType = Card;
    SourceTable = "Cheque Issue Lines-Family";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Chq Receipt No";Rec."Chq Receipt No")
                {
                }
                field("Cheque Serial No";Rec."Cheque Serial No")
                {
                }
                field("Account No.";Rec."Account No.")
                {
                }
                field("Account Name";Rec."Account Name")
                {
                }
                field(Amount; Rec.Amount)
                {
                }
                field("Branch Code";Rec."Branch Code")
                {
                }
                field("Transaction Refference";Rec."Transaction Refference")
                {
                }
                field("Cheque No";Rec."Cheque No")
                {
                }
                field("Account Balance";Rec."Account Balance")
                {
                }
                field(FrontImage; Rec.FrontImage)
                {
                }
                field(FrontGrayImage; Rec.FrontGrayImage)
                {
                }
                field(BackImages; Rec.BackImages)
                {
                }
                field("Verification Status";Rec."Verification Status")
                {
                }
            }
            // part(Control1000000015;"Account Signatories Details")
            // {
            //     SubPageLink = "Account No"=field("Account No.");
            // }
        }
    }

    actions
    {
    }
}






