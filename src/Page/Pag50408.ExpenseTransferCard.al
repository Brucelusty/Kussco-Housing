//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50408 "Expense Transfer Card"
{
    ApplicationArea = All;
    PageType = Card;
    SourceTable = "Funds Transfer Header";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                }
                /*                 field("Pay Mode";Rec."Pay Mode")
                                {
                                } */
                field("Document Date"; Rec."Document Date")
                {
                    Visible = false;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                }
                field("Paying Bank Account"; Rec."Paying Bank Account")
                {
                }
                field("Paying Bank Name"; Rec."Paying Bank Name")
                {
                }
                field("Bank Balance"; Rec."Bank Balance")
                {
                }
                field("Bank Account No."; Rec."Bank Account No.")
                {
                    Visible = false;
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    Visible = false;
                }
                // field("Amount to Transfer";Rec."Amount to Transfer")
                // {
                // }
                // field("Amount to Transfer(LCY)";Rec."Amount to Transfer(LCY)")
                // {
                // }
                // field("Total Line Amount";Rec."Total Line Amount")
                // {
                // }
                // field("Total Line Amount(LCY)";Rec."Total Line Amount(LCY)")
                // {
                // }
                // field(Description; Rec.Description)
                // {
                // }
                // field("Cheque/Doc. No";Rec."Cheque/Doc. No")
                // {
                // }
                // field("Created By";Rec."Created By")
                // {
                // }
                // field("Date Created";Rec."Date Created")
                // {
                // }
                // field("Time Created";Rec."Time Created")
                // {
                // }
                // field(Status; Rec.Status)
                // {
                // }
            }
            part(Control24; "Expense Transfer Lines")
            {
                SubPageLink = "Document No" = field("No.");
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Post Transfer")
            {
                Image = Payment;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    CheckRequiredItems;
                    // Rec.CalcFields(Rec."Total Line Amount");
                    // Rec.TestField(Rec."Amount to Transfer", Rec."Total Line Amount");

                    if FundsUser.Get(UserId) then begin
                        FundsUser.TestField(FundsUser."FundsTransfer Template Name");
                        FundsUser.TestField(FundsUser."FundsTransfer Batch Name");
                        JTemplate := FundsUser."FundsTransfer Template Name";
                        JBatch := FundsUser."FundsTransfer Batch Name";
                        //Post Transfer
                        FundsManager.PostFundsTransfer(Rec, JTemplate, JBatch);
                    end else begin
                        Error('User Account Not Setup, Contact the System Administrator');
                    end
                end;
            }
            action(Print)
            {
                Image = Print;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    /*FHeader.RESET;
                    FHeader.SETRANGE(FHeader."No.","No.");
                    IF FHeader.FINDFIRST THEN BEGIN
                      REPORT.RUNMODAL(REPORT::"Funds Transfer Voucher",TRUE,FALSE,FHeader);
                    END;
                    */

                    // FHeader.Reset;
                    // FHeader.SetRange(FHeader."No.","No.");
                    // if FHeader.FindFirst then
                    //    Report.run(172011,true,true,FHeader);

                end;
            }
        }
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        //"Pay Mode":="Pay Mode"::Cash;
        //Rec."Transfer Type" := Rec."transfer type"::InterBank;
    end;

    var
        FundsManager: Codeunit "Funds Management";
        FundsUser: Record "Funds User Setup";
        JTemplate: Code[50];
        JBatch: Code[50];
        FHeader: Record "Mobile Tariffs";
        FLine: Record "Expense Transfer Line";

    local procedure CheckRequiredItems()
    begin
        Rec.TestField("Posting Date");
        Rec.TestField("Paying Bank Account");
        // Rec.TestField("Amount to Transfer");
        //if Rec."Pay Mode" = Rec."pay mode"::Cheque then
        // Rec.TestField("Cheque/Doc. No");
        //Rec.TestField(Description);
        //TESTFIELD("Transfer To");

        FLine.Reset;
        FLine.SetRange(FLine."Document No", Rec."No.");
        FLine.SetFilter(FLine."Amount to Receive", '<>%1', 0);
        if FLine.FindSet then begin
            repeat
                FLine.TestField(FLine."Receiving Bank Account");
            until FLine.Next = 0;
        end;
    end;
}






