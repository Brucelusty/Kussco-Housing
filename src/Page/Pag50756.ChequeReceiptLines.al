//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50756 "Cheque Receipt Lines"
{
    ApplicationArea = All;
    PageType = ListPart;
    SourceTable = "Cheque Issue Lines";

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
                field("Account No.";Rec."Account No.")
                {
                    Editable = false;
                }
                field("Account Name";Rec."Account Name")
                {
                    Editable = false;
                }
                field("Un pay Code";Rec."Un pay Code")
                {
                }
                field(Interpretation; Rec.Interpretation)
                {
                    Editable = false;
                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                }
                field("Unpay Date";Rec."Unpay Date")
                {
                    Editable = false;
                }
                field("Un Pay Charge Amount";Rec."Un Pay Charge Amount")
                {
                    Editable = false;
                }
                field("Family Account No.";Rec."Family Account No.")
                {
                    Caption = 'Co-op Account No';
                    Editable = false;
                }
                field("Date _Refference No.";Rec."Date _Refference No.")
                {
                    Editable = false;
                }
                field("Transaction Code";Rec."Transaction Code")
                {
                    Editable = false;
                }
                field("Branch Code";Rec."Branch Code")
                {
                    Editable = false;
                }
                field(Currency; Rec.Currency)
                {
                    Editable = false;
                }
                field(Amount; Rec.Amount)
                {
                    Editable = false;
                }
                field("Date-1";Rec."Date-1")
                {
                    Editable = false;
                }
                field("Date-2";Rec."Date-2")
                {
                    Editable = false;
                }
                field("Coop  Routing No.";Rec."Coop  Routing No.")
                {
                    Editable = false;
                }
                field(Fillers; Rec.Fillers)
                {
                    Editable = false;
                }
                field("Transaction Refference";Rec."Transaction Refference")
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






