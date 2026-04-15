//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50445 "Posted Payment Voucher List"
{
    ApplicationArea = All;
    //CardPageID = "Payment Voucher";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    UsageCategory = Lists;
    PromotedActionCategories = 'New,Process,Reports,Approval,Budgetary Control,Cancellation,Category7_caption,Category8_caption,Category9_caption,Category10_caption';
    SourceTable = "Payments Header";

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                field("No."; Rec."No.")
                {
                }
                field(Cashier; Rec.Cashier)
                {
                }
                field(Date; Rec.Date)
                {
                }
                field("Pay Mode"; Rec."Pay Mode")
                {
                }
                field("Cheque No."; Rec."Cheque No.")
                {
                }
                field(Status; Rec.Status)
                {
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                }
                field(Payee; Rec.Payee)
                {
                }
                field("Payment Narration"; Rec."Payment Narration")
                {
                }
                field("On Behalf Of"; Rec."On Behalf Of")
                {
                }
                field("Currency Code"; Rec."Currency Code")
                {
                }
                field("Total Payment Amount"; Rec."Total Payment Amount")
                {
                }
                field("Current Status"; Rec."Current Status")
                {
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Print)
            {
                Caption = 'Reprint Voucher';
                Image = Print;
                Promoted = true;
                PromotedCategory = "Report";

                trigger OnAction()
                begin
                    Rec.Reset;
                    Rec.SetFilter("No.", Rec."No.");
                    Report.run(50022, true, true, Rec);

                end;
            }
        }
    }

    trigger OnInit()
    begin
        //CurrPage.LOOKUPMODE := TRUE;
    end;
}






