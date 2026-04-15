//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50734 "BOSA Transfer Sched"
{
    ApplicationArea = All;
    PageType = ListPart;
    SourceTable = "BOSA TransferS Schedule";
    Caption = 'Account Transfer Schedule';

    layout
    {
        area(content)
        {
            repeater(Control1102760000)
            {
                field("Source Type";Rec."Source Type")
                {
                    Caption = 'Account Type';
                }
                field("Source Account No.";Rec."Source Account No.")
                {
                    Caption = 'Account to Debit(BOSA)';
                }
                field("Source Account Name";Rec."Source Account Name")
                {
                }
                field("Transaction Type";Rec."Transaction Type")
                {
                }
                field(Loan; Rec.Loan)
                {
                }
                field(Amount; Rec.Amount)
                {
                }
                field("Destination Account Type";Rec."Destination Account Type")
                {
                }
                field("Destination Account No.";Rec."Destination Account No.")
                {
                }
                field("Destination Account Name";Rec."Destination Account Name")
                {
                }
                field("Destination Loan";Rec."Destination Loan")
                {
                }
                field("Destination Type";Rec."Destination Type")
                {
                }
            }
        }
    }

    actions
    {
    }
}






