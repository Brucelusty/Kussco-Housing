//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50409 "Expense Transfer Lines"
{
    ApplicationArea = All;
    PageType = ListPart;
    SourceTable = "Funds Transfer Line";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Document Type";Rec."Document Type")
                {
                    Caption = 'Expense Type';
                }
                field("Receiving Bank Account";Rec."Receiving Bank Account")
                {
                    Caption = 'Expense Account No.';
                    Editable = false;
                }
                field("Bank Name";Rec."Bank Name")
                {
                    Caption = 'Expense Name';
                }
                field("Bank Balance";Rec."Bank Balance")
                {
                    Visible = false;
                }
                field("Amount to Receive";Rec."Amount to Receive")
                {
                    Caption = 'Amount Expensed';
                }
                field("External Doc No.";Rec."External Doc No.")
                {
                    Caption = 'Rcpt No.';
                }
            }
        }
    }

    actions
    {
    }
}






