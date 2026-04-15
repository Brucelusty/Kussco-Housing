//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50790 "Cheque Receipt Line-Family"
{
    ApplicationArea = All;
    Editable = true;
    PageType = ListPart;
    SourceTable = "Cheque Issue Lines-Family";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Cheque Serial No";Rec."Cheque Serial No")
                {
                    Editable = false;
                }
                field("Cheque No";Rec."Cheque No")
                {
                    Editable = false;
                }
                field("Account No.";Rec."Account No.")
                {
                    Editable = false;
                }
                field("Account Name";Rec."Account Name")
                {
                    Editable = false;
                }
                field(Amount; Rec.Amount)
                {
                    Editable = false;
                    Style = Favorable;
                    StyleExpr = true;
                }
                field("Account Balance";Rec."Account Balance")
                {
                    Editable = false;
                }
                field("Charge Amount";Rec."Charge Amount")
                {
                    Style = AttentionAccent;
                    StyleExpr = true;
                }
                field("Un pay Code";Rec."Un pay Code")
                {
                }
                field(Interpretation; Rec.Interpretation)
                {
                }
                field("Verification Status";Rec."Verification Status")
                {
                    Style = Attention;
                    StyleExpr = true;

                    trigger OnValidate()
                    begin
                        Rec.Modify;
                    end;
                }
                field("Transaction Date";Rec."Transaction Date")
                {
                }
                field("Un Pay Charge Amount";Rec."Un Pay Charge Amount")
                {
                }
                field("Family Account No.";Rec."Family Account No.")
                {
                }
                field("Transaction Code";Rec."Transaction Code")
                {
                }
                field("Transaction Refference";Rec."Transaction Refference")
                {
                }
                field("Unpay Date";Rec."Unpay Date")
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
                field("Un pay User Id";Rec."Un pay User Id")
                {
                }
            }
        }
    }

    actions
    {
    }
}






