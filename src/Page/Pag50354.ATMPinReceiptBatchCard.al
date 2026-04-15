//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50354 "ATM Pin Receipt Batch Card"
{
    ApplicationArea = All;
    PageType = Card;
    SourceTable = "ATM Pin Receipt Batch";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Batch No.";Rec."Batch No.")
                {
                    Editable = false;
                }
                field("Description/Remarks";Rec."Description/Remarks")
                {
                    Editable = EnableLoad;
                }
                field("Bank Batch No";Rec."Bank Batch No")
                {
                    Editable = EnableLoad;
                }
                field(Requested; Rec.Requested)
                {
                    Editable = false;
                }
                field(Status; Rec.Status)
                {
                    Visible = false;
                }
                field("Date Created";Rec."Date Created")
                {
                }
                field("Date Requested";Rec."Date Requested")
                {
                    Editable = false;
                }
                field("Requested By";Rec."Requested By")
                {
                    Editable = false;
                }
                field("Prepared By";Rec."Prepared By")
                {
                    Editable = false;
                }
            }
            part(Control11;"ATM Pin Receipt SubPage")
            {
                SubPageLink = "Batch No." = field("Batch No.");
            }
        }
    }

    actions
    {
        area(creation)
        {
            action(LoadPinNotReceivedApplications)
            {
                Caption = 'Load Ordered ATM Cards & Pin Not Received';
                Enabled = EnableLoad;
                Image = Allocate;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    ObjCardsApplied.Reset;
                    ObjCardsApplied.SetRange(ObjCardsApplied."Order ATM Card", true);
                    ObjCardsApplied.SetRange(ObjCardsApplied."Pin Received", false);
                    if ObjCardsApplied.FindSet then begin
                        repeat
                            ObjCardsReceipts.Init;
                            ObjCardsReceipts."Batch No." := Rec."Batch No.";
                            ObjCardsReceipts."ATM Application No" := ObjCardsApplied."No.";
                            ObjCardsReceipts."ATM Card Account No" := ObjCardsApplied."Account No";
                            ObjCardsReceipts."Account Name" := ObjCardsApplied."Account Name";
                            ObjCardsReceipts."ATM Card Application Date" := ObjCardsApplied."Application Date";
                            ObjCardsReceipts.Insert;
                        until ObjCardsApplied.Next = 0;
                        EnableAction := true;
                        EnableLoad := false;
                    end;
                end;
            }
            action(ReceivePINBatch)
            {
                Caption = 'Receive PIN Batch';
                Enabled = EnableAction;
                Image = Export;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    ObjCardsReceipts.Reset;
                    ObjCardsReceipts.SetRange(ObjCardsReceipts."Batch No.", Rec."Batch No.");
                    ObjCardsReceipts.SetRange(ObjCardsReceipts."Pin Received", true);
                    if ObjCardsReceipts.FindSet then begin
                        Rec.Requested := true;
                        Rec."Requested By" := UserId;

                        ObjCardsReceipts.Reset;
                        ObjCardsReceipts.SetRange(ObjCardsReceipts."Batch No.", Rec."Batch No.");
                        ObjCardsReceipts.SetRange(ObjCardsReceipts."Pin Received", false);
                        if ObjCardsReceipts.FindSet then begin
                            ObjCardsReceipts.DeleteAll;
                        end;
                        EnableAction := false;
                        EnableLoad := false;
                        Message('The ATM PIN Batch has successully been Received');
                    end else
                        Message('There are no ATM Cards PINs selected to be received');
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        if Rec.Requested = false then
            EnableLoad := true;
        if Rec.Requested = true then
            EnableLoad := false;

        EnableAction := false;

        ObjCardsReceipts.Reset;
        ObjCardsReceipts.SetRange(ObjCardsReceipts."Batch No.", Rec."Batch No.");
        ObjCardsReceipts.SetRange(ObjCardsReceipts."Pin Received", true);
        if ObjCardsReceipts.FindSet then begin
            if Rec.Requested = false then
                EnableAction := true;
        end;
    end;

    var
        ObjCardsReceipts: Record "ATM Pin Receipt Lines";
        ObjCardsApplied: Record "ATM Card Applications";
        EnableAction: Boolean;
        EnableLoad: Boolean;
}






