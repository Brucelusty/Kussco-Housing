namespace TelepostSacco.TelepostSacco;
using Microsoft.Sales.History;
using Microsoft.Foundation.NoSeries;
using Microsoft.Sales.Document;
using Microsoft.Sales.Setup;

page 51205 "Insurance Claim Card"
{
    ApplicationArea = All;
    Caption = 'Insurance Claim Card';
    PageType = Card;
    SourceTable = "Insurance Claims";
    PromotedActionCategories = 'New,Report,Process,Approvals,Invoice,Receipt';

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field("Claim No."; Rec."Claim No.")
                {
                    ToolTip = 'Specifies the value of the Claim No. field.', Comment = '%';
                }
                field("Member BOSA No."; Rec."Member BOSA No.")
                {
                    Caption = 'Member No';
                    ToolTip = 'Specifies the value of the Member BOSA No. field.', Comment = '%';
                }
                field("Member Name"; Rec."Member Name")
                {
                    ToolTip = 'Specifies the value of the Member Name field.', Comment = '%';
                }
                field("ID No."; Rec."ID No.")
                {
                    ToolTip = 'Specifies the value of the ID No. field.', Comment = '%';
                }
                field("Reason For Claim"; Rec."Reason For Claim")
                {
                    ToolTip = 'Specifies the value of the Reason For Claim field.', Comment = '%';
                }
                field("Claim Description"; Rec."Claim Description")
                {
                    ToolTip = 'Specifies the value of the Claim Description field.', Comment = '%';
                }
                field("Claim Date"; Rec."Claim Date")
                {
                    ToolTip = 'Specifies the value of the Claim Date field.', Comment = '%';
                }
                field("Expected Amount"; Rec."Expected Amount")
                {
                    ToolTip = 'Specifies the value of the Expected Amount field.', Comment = '%';
                }
                field(Insurer; Rec.Insurer)
                {
                }
                field("Initiated On"; Rec."Initiated On")
                {
                    ToolTip = 'Specifies the value of the Initiated On field.', Comment = '%';
                }
                field("Initiated By"; Rec."Initiated By")
                {
                    ToolTip = 'Specifies the value of the Initiated By field.', Comment = '%';
                }
                field("Bank No."; Rec."Bank No.")
                {
                    ToolTip = 'Specifies the value of the Bank No. field.', Comment = '%';
                }
                field(Status; Rec.Status)
                {
                    Style = StrongAccent;
                    ToolTip = 'Specifies the value of the Cheque No field.', Comment = '%';
                }
                field("Cheque No"; Rec."Cheque No")
                {
                    ToolTip = 'Specifies the value of the Cheque No field.', Comment = '%';
                }
            }
        }
    }
    actions
    {
        area(Reporting)
        { }
        area(Processing)
        {
            action(Invoice)
            {
                Caption = 'Invoice Insurer';
                Image = Invoice;
                Promoted = true;
                PromotedCategory = Category5;
                PromotedOnly = true;
                Visible = approved;

                trigger OnAction()
                begin
                    Rec.TestField(Insurer);
                    Rec.TestField("Member BOSA No.");
                    Rec.TestField("Bank No.");
                    Rec.TestField("Expected Amount");
                    Rec.TestField(Status, Rec.Status::Approved);

                    salesReceivables.Get();
                    fundsGen.Get();

                    claimInvoice.Init();
                    claimNo := noSeries.GetNextNo(salesReceivables."Claim Nos", Today, true);
                    claimInvoice.Init;
                    claimInvoice."No." := claimNo;
                    claimInvoice."No. Series" := salesReceivables."Claim Nos";
                    claimInvoice."Document Type" := claimInvoice."Document Type"::Invoice;
                    claimInvoice."Sell-to Customer No." := Rec.Insurer;
                    claimInvoice.Validate("Sell-to Customer No.");
                    claimInvoice."Bill-to Customer No." := Rec.Insurer;
                    claimInvoice.Validate("Bill-to Customer No.");
                    claimInvoice."Claim No" := Rec."Claim No.";
                    claimInvoice."External Document No." := Rec."Claim No.";
                    claimInvoice."Insurance Claim" := true;
                    claimInvoice."Document Date" := Today;
                    claimInvoice."Due Date" := CalcDate('<1M>', Today);
                    claimInvoice."Posting Description" := claimInvoice."Bill-to Name" + '-' + Format(Rec."Reason For Claim");
                    claimInvoice.Insert();

                    invoiceLines.Init();
                    invoiceLines."Line No." := 1000;
                    invoiceLines."Document Type" := invoiceLines."Document Type"::Invoice;
                    invoiceLines."Document No." := claimNo;
                    invoiceLines.Type := invoiceLines.Type::"G/L Account";
                    invoiceLines."No." := fundsGen."Insurance Claim Control Acc";
                    invoiceLines.Quantity := 1;
                    invoiceLines.Amount := Rec."Expected Amount";
                    invoiceLines."Line Amount" := Rec."Expected Amount";
                    invoiceLines.Description := Format(Rec."Reason For Claim") + '-' + Rec."Member BOSA No.";
                    invoiceLines.Insert();


                    Rec.Status := Rec.Status::Invoiced;
                    Rec.Modify;
                    Message('An Invoice has been generated successfully, No: %1', claimNo);
                end;
            }

            action(Pay)
            {
                Caption = 'Reciept Invoice';
                Image = Receipt;
                Promoted = true;
                PromotedCategory = Category6;
                PromotedOnly = true;
                Visible = canRecieve;

                trigger OnAction()
                begin
                    Rec.TestField(Insurer);
                    Rec.TestField("Member BOSA No.");
                    Rec.TestField("Bank No.");
                    Rec.TestField("Expected Amount");
                    Rec.TestField(Status, Rec.Status::Invoiced);


                    Rec.Status := Rec.Status::Paid;
                    Rec.Modify;
                    Message('Pending Development');
                end;
            }
        }
        area(Navigation)
        {
            action(SendApproval)
            {
                Caption = 'Send Approval Request';
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedOnly = true;
                Enabled = (Rec.Status = Rec.Status::Open);

                trigger OnAction()
                begin
                    Rec.Status := Rec.Status::Approved;
                    Rec.Modify;
                    Message('The record has been approved');
                end;
            }
            action(CancelApproval)
            {
                Caption = 'Cancel Approval Request';
                Image = CancelApprovalRequest;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedOnly = true;
                Enabled = (Rec.Status = Rec.Status::"Pending Approval");

                trigger OnAction()
                begin
                    Rec.Status := Rec.Status::Open;
                    Rec.Modify;
                    Message('The approval request has been canceled');
                end;
            }
            action(Approvals)
            {
                Caption = 'Approval Entries';
                Image = Approvals;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedOnly = true;

                trigger OnAction()
                begin
                    Message('There exists no ongoing approval instances for this record.');
                end;
            }
        }
    }

    var
        approved: Boolean;
        canRecieve: Boolean;
        claimNo: Code[20];
        noSeries: Codeunit "No. Series";
        salesReceivables: Record "Sales & Receivables Setup";
        claimInvoice: Record "Sales Header";
        invoiceLines: Record "Sales Line";
        fundsGen: Record "Funds General Setup";


    trigger OnAfterGetCurrRecord()
    begin
        approved := false;
        canRecieve := false;
        if Rec.Status = Rec.Status::Approved then begin
            approved := true;
        end;

        if Rec.Status = Rec.Status::Invoiced then begin
            canRecieve := true;
        end;
    end;

    trigger OnAfterGetRecord()
    begin
        approved := false;
        canRecieve := false;
        if Rec.Status = Rec.Status::Approved then begin
            approved := true;
        end;

        if Rec.Status = Rec.Status::Invoiced then begin
            canRecieve := true;
        end;
    end;
}


