//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50676 "Treasury Card"
{
    ApplicationArea = All;
    Caption = 'Treasury Card';
    Editable = false;
    PageType = Card;
    SourceTable = "Bank Account";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; Rec."No.")
                {

                    trigger OnAssistEdit()
                    begin
                        if Rec.AssistEdit(xRec) then
                            CurrPage.Update;
                    end;
                }
                field(Name; Rec.Name)
                {
                }
                field(Address; Rec.Address)
                {
                }
                field("Address 2"; Rec."Address 2")
                {
                }
                field("Post Code";Rec."Post Code")
                {
                    Caption = 'Post Code/City';
                }
                field(City; Rec.City)
                {
                }
                field("Country/Region Code";Rec."Country/Region Code")
                {
                }
                field("Phone No.";Rec."Phone No.")
                {
                }
                field(Contact; Rec.Contact)
                {
                }
                field("Bank Branch No.";Rec."Bank Branch No.")
                {
                }
                field("Bank Account No.";Rec."Bank Account No.")
                {
                }
                field("Search Name";Rec."Search Name")
                {
                }
                field(Control22; Rec.Balance)
                {
                }
                field("Balance (LCY)";Rec."Balance (LCY)")
                {
                }
                field("Min. Balance";Rec."Min. Balance")
                {
                }
                field("Our Contact Code";Rec."Our Contact Code")
                {
                }
                field(Blocked; Rec.Blocked)
                {
                }
                field("Last Date Modified";Rec."Last Date Modified")
                {
                }
                field(CashierID; Rec.CashierID)
                {
                }
                field("Maximum Teller Withholding";Rec."Maximum Teller Withholding")
                {
                }
            }
            group(Communication)
            {
                Caption = 'Communication';
                field("Fax No.";Rec."Fax No.")
                {
                }
                field("E-Mail";Rec."E-Mail")
                {
                }
                field("Home Page";Rec."Home Page")
                {
                }
            }
            group(Posting)
            {
                Caption = 'Posting';
                field("Currency Code";Rec."Currency Code")
                {
                }
                field("Last Check No.";Rec."Last Check No.")
                {
                }
                field("Transit No.";Rec."Transit No.")
                {
                }
                field("Last Statement No.";Rec."Last Statement No.")
                {
                }
                field("Balance Last Statement";Rec."Balance Last Statement")
                {
                }
                field("Bank Acc. Posting Group";Rec."Bank Acc. Posting Group")
                {
                }
            }
            group(Transfer)
            {
                Caption = 'Transfer';
                field("SWIFT Code";Rec."SWIFT Code")
                {
                }
                field(Iban; Rec.Iban)
                {
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Bank Acc.")
            {
                Caption = '&Bank Acc.';
                action(Statistics)
                {
                    Caption = 'Statistics';
                    Image = Statistics;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Bank Account Statistics";
                    RunPageLink = "No." = field("No."),
                                  "Date Filter" = field("Date Filter"),
                                  "Global Dimension 1 Filter" = field("Global Dimension 1 Filter"),
                                  "Global Dimension 2 Filter" = field("Global Dimension 2 Filter");
                    ShortCutKey = 'F7';
                }
                action("Co&mments")
                {
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page "Comment Sheet";
                    RunPageLink = "Table Name" = const("Bank Account"),
                                  "No." = field("No.");
                }
                action(Dimensions)
                {
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    RunObject = Page "Default Dimensions";
                    RunPageLink = "Table ID" = const(270),
                                  "No." = field("No.");
                    ShortCutKey = 'Shift+Ctrl+D';
                }
                action(Balance)
                {
                    Caption = 'Balance';
                    Image = Balance;
                    RunObject = Page "Bank Account Balance";
                    RunPageLink = "No." = field("No."),
                                  "Global Dimension 1 Filter" = field("Global Dimension 1 Filter"),
                                  "Global Dimension 2 Filter" = field("Global Dimension 2 Filter");
                }
                action("St&atements")
                {
                    Caption = 'St&atements';
                    RunObject = Page "Bank Account Statement";
                    RunPageLink = "Bank Account No." = field("No.");
                }
                action("Ledger E&ntries")
                {
                    Caption = 'Ledger E&ntries';
                    RunObject = Page "Bank Account Ledger Entries";
                    RunPageLink = "Bank Account No." = field("No.");
                    RunPageView = sorting("Bank Account No.");
                    ShortCutKey = 'Ctrl+F7';
                }
                action("Chec&k Ledger Entries")
                {
                    Caption = 'Chec&k Ledger Entries';
                    Image = CheckLedger;
                    RunObject = Page "Check Ledger Entries";
                    RunPageLink = "Bank Account No." = field("No.");
                    RunPageView = sorting("Bank Account No.");
                }
                action("C&ontact")
                {
                    Caption = 'C&ontact';

                    trigger OnAction()
                    begin
                        Rec.ShowContact;
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        Rec.CalcFields("Check Report Name");
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec."Account Type" := Rec."account type"::Treasury;
    end;

    var
        UsersID: Record User;
}






