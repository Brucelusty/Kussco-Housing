//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50797 "MOBILE Paybill Trans"
{
    ApplicationArea = All;
    CardPageID = "MOBILE Paybill Tran Card";
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "MOBILE MPESA Trans";
    Caption = 'Paybill Transactions';

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Document No"; Rec."Document No")
                {
                }
                field("Transaction Date"; Rec."Transaction Date")
                {
                }
                field("Account No"; Rec."Account No")
                {
                }
                field(Description; Rec.Description)
                {
                }
                field(Amount; Rec.Amount)
                {
                }
                field(Posted; Rec.Posted)
                {
                }
                field("Transaction Time"; Rec."Transaction Time")
                {
                }
                field("Paybill Acc Balance"; Rec."Paybill Acc Balance")
                {
                }
                field("Document Date"; Rec."Document Date")
                {
                }
                field("Date Posted"; Rec."Date Posted")
                {
                }
                field("Time Posted"; Rec."Time Posted")
                {
                }
                field("Approved By"; Rec."Approved By")
                {
                }
                field("Key Word"; Rec."Key Word")
                {
                }
                field(Telephone; Rec.Telephone)
                {
                }
                field("Account Name"; Rec."Account Name")
                {
                }
                field("Needs Manual Posting"; Rec."Needs Manual Posting")
                {
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action(ImportTran)
            {

                trigger OnAction()
                begin
                    Xmlport.Run(51516501);
                end;
            }
        }
    }
}






