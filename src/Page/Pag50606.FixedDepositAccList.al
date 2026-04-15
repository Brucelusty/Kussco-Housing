//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50606 "Fixed Deposit Acc. List"
{
    ApplicationArea = All;
    CardPageID = "Fixed Account Card";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = Vendor;
    SourceTableView = where("Debtor Type" = const("FOSA Account"),
                            "Account Type" = const('108'),"Amount Transfered?"=filter(false),Revoked=filter(false));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    Caption = 'Fixed Deposit No';
                }
                field(Name; Rec.Name)
                {
                }
                field("BOSA Account No"; Rec."BOSA Account No")
                {
                }
                field("Account Type"; Rec."Account Type")
                {
                }
                field("Vendor Account No"; Rec."Vendor Account No")
                {
                    Caption = 'Jipange Account No';
                }


                /* ObjAccounts."Vendor Posting Group" := Rec."Vendor Posting Group";
                        ObjAccounts."FD Interest Rate" := Rec."FD Interest Rate";
                        ObjAccounts."Fixed Deposit Type" := Rec."Fixed Deposit Type";
                        ObjAccounts."Vendor Account No" := Rec."Vendor Account No"; */
                field("Fixed Deposit Type"; Rec."Fixed Deposit Type") { }
                field("Fixed Duration"; Rec."Fixed Duration") { }
                field("FD Interest Rate"; Rec."FD Interest Rate") { }
                field("Fixed Deposit Start Date"; Rec."Fixed Deposit Start Date") { }

                field("FD Maturity Date"; Rec."FD Maturity Date")
                {
                }

                field("Interest Earned"; Rec."Interest Earned")
                {
                    Caption = 'Interest Earned';
                }
                field("Fixed Deposit Status"; Rec."Fixed Deposit Status")
                {
                }
                field("Vendor Posting Group"; Rec."Vendor Posting Group")
                {
                }

                field("Date Renewed"; Rec."Date Renewed")
                {
                }
                field("FD Duration"; Rec."FD Duration")
                {
                    Caption = 'FD Duration';
                }
                field("ID No."; Rec."ID No.")
                {
                }
                field(Balance; Rec.Balance)
                {
                }
                field("Interest rate"; Rec."Interest rate")
                {
                }
                field("Phone No."; Rec."Phone No.")
                {
                }
                field("Savings Account No."; Rec."Savings Account No.")
                {
                    Caption = 'Current Account No.';
                }
                field("Amount Transfered?"; Rec."Amount Transfered?")
                {

                }
                field("Date Transfered"; Rec."Date Transfered")
                {

                }
                field("Transferred By"; Rec."Transferred By")
                {

                }
            }
        }
        area(factboxes)
        {
            part(Control1000000001; "FOSA Statistics FactBox")
            {
                SubPageLink = "No." = field("No.");
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Account)
            {
                Caption = 'Account';
                action("Ledger E&ntries")
                {
                    Caption = 'Ledger E&ntries';
                    Image = VendorLedger;
                    RunObject = Page "Vendor Ledger Entries";
                    RunPageLink = "Vendor No." = field("No.");
                    RunPageView = sorting("Vendor No.");
                    ShortCutKey = 'Ctrl+F7';
                }
                action("Co&mments")
                {
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page "Comment Sheet";
                    RunPageLink = "Table Name" = const(Vendor),
                                  "No." = field("No.");
                }
                action(Dimensions)
                {
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    RunObject = Page "Default Dimensions";
                    RunPageLink = "Table ID" = const(23),
                                  "No." = field("No.");
                    ShortCutKey = 'Shift+Ctrl+D';
                }
                separator(Action1102755228)
                {
                }
                separator(Action1102755226)
                {
                }
                separator(Action1102755225)
                {
                }
                action("Member Card")
                {
                    Caption = 'Member Card';
                    Image = Planning;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Member Account Card";
                    RunPageLink = "No." = field("BOSA Account No");
                }
                action("<Action11027600800>")
                {
                    Caption = 'Loans Statements';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";

                    trigger OnAction()
                    begin
                        /*Cust.RESET;
                        Cust.SETRANGE(Cust."No.","No.");
                        IF Cust.FIND('-') THEN
                        REPORT.RUN(,TRUE,TRUE,Cust)
                        */

                    end;
                }
                separator(Action1102755222)
                {
                }
            }
            group(ActionGroup1102755220)
            {
                action("Nominee Details")
                {
                    Caption = 'Nominee Details';
                    Image = Relationship;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "FOSA Account  NOK Details";
                    RunPageLink = "Account No" = field("No.");
                }
                separator(Action1102755217)
                {
                }
                action("Page Vendor Statement")
                {
                    Caption = 'Statement';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";

                    trigger OnAction()
                    begin

                        Vend.Reset;
                        Vend.SetRange(Vend."No.", Rec."No.");
                        if Vend.Find('-') then
                            Report.run(172476, true, false, Vend)
                    end;
                }
                action("Page Vendor Statistics")
                {
                    Caption = 'Statistics';
                    Image = Statistics;
                    Promoted = true;
                    PromotedCategory = "Report";
                    RunObject = Page "Vendor Statistics";
                    RunPageLink = "No." = field("No."),
                                  "Global Dimension 1 Filter" = field("Global Dimension 1 Filter"),
                                  "Global Dimension 2 Filter" = field("Global Dimension 2 Filter");
                    ShortCutKey = 'F7';
                }
            }
        }
    }

    var
        Cust: Record "Members Register";
        Vend: Record Vendor;
}






