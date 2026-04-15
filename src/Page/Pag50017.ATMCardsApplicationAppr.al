//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50017 "ATM Cards Application Appr"
{
    ApplicationArea = All;
    CardPageID = "ATM Applications Card Appr";
    Editable = false;
    PageType = List;
    UsageCategory = Lists;
    DeleteAllowed=false;
    SourceTable = "ATM Card Applications";
    SourceTableView = where("ATM Card Linked" = filter(false),Status=filter(Approved),"Order ATM Card"=filter(false), "Request Type" = filter(New|Replacement|Renewal));
    InsertAllowed=false;
    layout
    {
        area(content)
        {
            repeater(Control15)
            {
                Editable = false;
                field("No."; Rec."No.")
                {
                }
                field("Request Type"; Rec."Request Type")
                {
                }
                field("Account No"; Rec."Account No")
                {
                }
                field("Account Name"; Rec."Account Name")
                {
                }
                field("Branch Code"; Rec."Branch Code")
                {
                    Caption = 'Branch';
                }
                field("Card No"; Rec."Card No")
                {
                }
                field("Phone No."; Rec."Phone No.")
                {
                }
                field("ID No"; Rec."ID No")
                {
                }
                field("Application Date"; Rec."Application Date")
                {
                }
                field("Captured By"; Rec."Captured By")
                {
                }

                field(Status; Rec.Status)
                {
                }
                field("ATM Card Fee Charged"; Rec."ATM Card Fee Charged")
                {
                }
                field("ATM Card Fee Charged On"; Rec."ATM Card Fee Charged On")
                {
                }
                field("ATM Card Fee Charged By"; Rec."ATM Card Fee Charged By")
                {
                }
            }
        }
    }

    actions
    {
    }
}






