//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50724 "Cheque Clearing Lines"
{
    ApplicationArea = All;
    Editable = true;
    PageType = ListPart;
    SourceTable = "Cheque Clearing Lines";

    layout
    {
        area(content)
        {
            repeater(Control1102760000)
            {
                Editable = true;
                field("Transaction No";Rec."Transaction No")
                {
                    Editable = false;
                }
                field("Account No";Rec."Account No")
                {
                    Editable = false;
                }
                field("Account Name";Rec."Account Name")
                {
                    Editable = false;
                }
                field("Transaction Type";Rec."Transaction Type")
                {
                    Editable = false;
                }
                field(Amount; Rec.Amount)
                {
                    Editable = false;
                }
                field("Cheque No";Rec."Cheque No")
                {
                    Editable = false;
                }
                field("Expected Maturity Date";Rec."Expected Maturity Date")
                {
                    Editable = false;
                }
                field("Cheque Clearing Status";Rec."Cheque Clearing Status")
                {
                    ShowMandatory = true;
                }
                field("Ledger Entry No";Rec."Ledger Entry No")
                {
                    Editable = false;
                }
                field("Ledger Transaction No.";Rec."Ledger Transaction No.")
                {
                    Editable = false;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin

        //SETRANGE(USER,USERID);
    end;
}






