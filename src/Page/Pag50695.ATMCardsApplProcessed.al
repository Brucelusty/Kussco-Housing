//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50695 "ATM Cards Appl. - Processed"
{
    ApplicationArea = All;
    CardPageID = "ATM Applications Cards";
    Editable = false;
    PageType = List;
    UsageCategory = Lists;
    DeleteAllowed=false;
    SourceTable = "ATM Card Applications";
    SourceTableView = where("ATM Card Linked" = filter(true),Posted=filter(false), "Request Type" = filter(New|Replacement|Renewal|"Card Reissue"));//

    layout
    {
        area(content)
        {
            repeater(Control15)
            {
                Editable = false;
                field("No.";Rec."No.")
                {
                }
                field("Request Type";Rec."Request Type")
                {
                }
                field("Account No";Rec."Account No")
                {
                }
                field("Account Name";Rec."Account Name")
                {
                }
                field("Branch Code";Rec."Branch Code")
                {
                    Caption = 'Branch';
                }
                field("Card No";Rec."Card No")
                {
                }
                field("Phone No.";Rec."Phone No.")
                {
                }
                field("ID No";Rec."ID No")
                {
                }
                field("Application Date";Rec."Application Date")
                {
                }
                field("Captured By";Rec."Captured By")
                {
                }
                field("Order ATM Card";Rec."Order ATM Card")
                {
                    Caption = 'Ordered';
                }
                field("Ordered On";Rec."Ordered On")
                {
                }
                field("Ordered By";Rec."Ordered By")
                {
                }
                field("Card Received";Rec."Card Received")
                {
                }
                field("Card Received On";Rec."Card Received On")
                {
                }
                field("Card Received By";Rec."Card Received By")
                {
                }
                field("Pin Received";Rec."Pin Received")
                {
                    Caption = 'PIN Received';
                }
                field("Pin Received On";Rec."Pin Received On")
                {
                    Caption = 'PIN Received On';
                }
                field("Pin Received By";Rec."Pin Received By")
                {
                    Caption = 'PIN Received By';
                }
                field("ATM Card Linked";Rec."ATM Card Linked")
                {
                }
                field("ATM Card Linked By";Rec."ATM Card Linked By")
                {
                }
                field("ATM Card Linked On";Rec."ATM Card Linked On")
                {
                }
                field(Collected; Rec.Collected)
                {
                }
                field("Date Collected";Rec."Date Collected")
                {
                }
                field("Card Issued By";Rec."Card Issued By")
                {
                }
                field("ATM Delinked";Rec."ATM Delinked")
                {
                }
                field("ATM Delinked By";Rec."ATM Delinked By")
                {
                }
                field("ATM Delinked On";Rec."ATM Delinked On")
                {
                }
                field(Destroyed; Rec.Destroyed)
                {
                }
                field("Destroyed On";Rec."Destroyed On")
                {
                }
                field("Destroyed By";Rec."Destroyed By")
                {
                }
            }
        }
    }

    actions
    {
    }
}






