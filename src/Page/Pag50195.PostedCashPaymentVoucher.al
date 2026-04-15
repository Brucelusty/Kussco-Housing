//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50195 "Posted Cash Payment Vouchers"
{
    ApplicationArea = All;
    CardPageID = "Cash Payment Voucher";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    UsageCategory = Lists;
    PromotedActionCategories = 'New,Process,Reports,Approval,Budgetary Control,Cancellation,Category7_caption,Category8_caption,Category9_caption,Category10_caption';
    SourceTable = "Payments Header";
    SourceTableView = where(
                            Posted = filter(true),
                            "Pay Mode" = const(Cash),
                            Status = filter(Posted),
                            "Expense Type" = filter(<> Director));

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
            action(PrintNew)
            {
                Caption = 'Print/Preview';
                Image = Print;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    //TESTFIELD(Status,Status::Approved);
                    /*IF (Status=Status::Pending) OR  (Status=Status::"Pending Approval") THEN
                       ERROR('You cannot Print until the document is Approved'); */

                    PHeader2.Reset;
                    PHeader2.SetRange(PHeader2."No.", Rec."No.");
                    if PHeader2.FindFirst then
                        Report.run(173052, true, true, PHeader2);

                    /*RESET;
                    SETRANGE("No.","No.");
                    IF "No." = '' THEN
                      REPORT.RUNMODAL(51516000,TRUE,TRUE,Rec)
                    ELSE
                      REPORT.RUNMODAL(51516344,TRUE,TRUE,Rec);
                    RESET;
                    */

                end;
            }
        }
    }

    trigger OnInit()
    begin
        CurrPage.LookupMode := true;
    end;

    trigger OnOpenPage()
    begin
        Rec.SetRange(Cashier, UserId);
    end;

    var
    PHeader2: Record "Payments Header";
}






