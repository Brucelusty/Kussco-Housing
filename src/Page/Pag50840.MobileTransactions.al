//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50840 "MOBILE Transactions"
{
    ApplicationArea = All;
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "Mobile Banking Transactions";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Entry; Rec.Entry)
                {
                }
                field("Document No"; Rec."Document No")
                {
                }
                field("Document Date"; Rec."Document Date")
                {
                }
                field("Account No"; Rec."Account No")
                {
                }
                field("Acc Name"; Rec."Account Name")
                {
                    Caption = 'Account Name';
                }
                field(Amount; Rec.Amount)
                {
                }
                field("Transaction Time"; Rec."Transaction Time")
                {
                }
                field("Transaction Type"; Rec."Transaction Type")
                {
                }
                field("Telephone Number"; Rec."Telephone Number")
                {
                }
                field(Posted; Rec.Posted)
                {
                }
                field("Date Posted"; Rec."Date Posted")
                {
                }
                field("Account No2"; Rec."Account No2")
                {
                }
                field("Loan No"; Rec."Loan No")
                {
                }
                field(Status; Rec.Status)
                {
                }
                field(Comments; Rec.Comments)
                {
                }
                field(Charge; Rec.Charge)
                {
                }
                field(Description; Rec.Description)
                {
                }
                field(Client; Rec.Client)
                {
                }
                field("Posting Date"; Rec."Posting Date")
                {
                }
                field(ConversationID; Rec.ConversationID)
                {
                }
                field(OriginatorConversationID; Rec.OriginatorConversationID)
                {
                }
                field(ResponseCode; Rec.ResponseCode)
                {
                }
                field(ResponseDescription; Rec.ResponseDescription)
                {
                }
                field(ReceiptNo; Rec.ReceiptNo)
                {
                }
                field(ReceiverPartyPublicName; Rec.ReceiverPartyPublicName)
                {
                }
                field(Response; Rec.Response)
                {
                }
                field(ResultDesc; Rec.ResultDesc)
                {
                }

            }
        }
    }

    actions
    {
    }
}






