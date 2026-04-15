//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50791 "MOBILE Paybill Tran Card"
{
    ApplicationArea = All;
    PageType = Card;
    SourceTable = "MOBILE MPESA Trans";
    Caption = 'Paybill Transactions Card';

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Document No"; Rec."Document No")
                {
                    Editable = false;
                }
                field("Transaction Date"; Rec."Transaction Date")
                {
                    Editable = false;
                }
                field("Account No"; Rec."Account No")
                {
                }
                field(Description; Rec.Description)
                {
                    Editable = false;
                }
                field(Amount; Rec.Amount)
                {
                    Editable = false;
                }
                field(Posted; Rec.Posted)
                {
                    Editable = false;
                }
                field("Key Word"; Rec."Key Word")
                {
                }
                field(Telephone; Rec.Telephone)
                {
                    Editable = false;
                }
                field("Account Name"; Rec."Account Name")
                {
                    Editable = false;
                }
                field("Needs Manual Posting"; Rec."Needs Manual Posting")
                {
                }
                field("Document Date"; Rec."Document Date")
                {
                    Editable = false;
                }
            }
        }
    }

    actions
    {
    }
}






