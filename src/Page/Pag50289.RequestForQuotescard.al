page 50289 "Request For Quotes card"
{
    ApplicationArea = All;
    PageType = Card;
    DeleteAllowed = false;
    UsageCategory = Administration;
    SourceTable = "Purchase Header";
    SourceTableView = where("AU Form Type" = filter('RFQ'));

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    Enabled = false;

                }
                field("Purcahse Requisition No"; Rec."No.")
                {
                    trigger OnValidate()
                    var
                        PurchaseLine: Record "Purchase Line";
                        NewPurchaseline: Record "Purchase Line";
                        PurchaseHeader: Record "Purchase Header";
                        NewHeader: Record "Purchase Header";

                    begin

                        PurchaseHeader.Reset();
                        PurchaseHeader.SetRange("No.", Rec."No.");
                        if PurchaseHeader.FindFirst() then begin

                            //Rec."Payee Naration" := PurchaseHeader."Payee Naration";
                            //Rec."Shortcut Dimension 1 Code" := PurchaseHeader."Shortcut Dimension 1 Code";
                            //Rec."Due Date" := PurchaseHeader."Due Date";
                            //Rec.fromDate := PurchaseHeader.fromDate;
                            Rec."Currency Factor" := PurchaseHeader."Currency Factor";
                            Rec."Currency Code" := PurchaseHeader."Currency Code";

                            Rec.Modify(true);


                        end;
                        PurchaseHeader.Reset();
                        PurchaseHeader.SetRange("No.", Rec."No.");
                        if PurchaseHeader.FindFirst() then begin
                            PurchaseLine.Reset();
                            PurchaseLine.SetRange("Document No.", PurchaseHeader."No.");
                            if PurchaseLine.Find('-') then begin
                                repeat
                                    NewPurchaseline.Init();
                                    NewPurchaseline."Document No." := Rec."No.";

                                    NewPurchaseline.Reset();
                                    NewPurchaseline.SetRange("Document Type", Rec."Document Type");
                                    NewPurchaseline.SetRange("Document No.", NewPurchaseline."Document No.");
                                    if NewPurchaseline.FindLast() then
                                        NewPurchaseline."Line No." := NewPurchaseline."Line No." + 1
                                    else
                                        NewPurchaseline."Line No." := 0;
                                    NewPurchaseline.Type := PurchaseLine.Type;
                                    NewPurchaseline."No." := PurchaseLine."No.";
                                    //NewPurchaseline."Document No.":=Rec."No.";

                                    NewPurchaseline.Description := PurchaseLine.Description;

                                    NewPurchaseline."Description 2" := PurchaseLine."Description 2";
                                    NewPurchaseline.remarks := PurchaseLine.remarks;
                                    NewPurchaseline.Quantity := PurchaseLine.Quantity;
                                    NewPurchaseline."Currency Code" := PurchaseLine."Currency Code";
                                    //NewPurchaseline.Amount := PurchaseLine.Amount;
                                    NewPurchaseline.Insert(true);
                                until PurchaseLine.Next() = 0;
                            end;
                        end;

                    end;
                }


            }
            part(RequestFormLines; "Request Form Lines")
            {
                Caption = 'Request Form Lines';
                SubPageLink = "Document No." = field("No.");
                Visible = false;
            }
            part(RFQLines; "RFQ Lines")
            {
                SubPageLink = "Document No." = field("No.");
                Caption = 'RFQ  Lines';
            }

        }
    }

    actions
    {
        area(Processing)
        {
            action("Send Approval Request")
            {
                Caption = 'Send A&pproval Request';
                Image = SendApprovalRequest;
                Promoted = true;
                Visible = false;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    // ApprovalMgt.OnSendPurchaseDocForApproval(Rec);
                end;
            }

            action("Cancel Approval Request")
            {
                Caption = 'Cancel Approval Re&quest';
                Image = Cancel;
                Promoted = true;
                Visible = false;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    // ApprovalMgt.OnCancelPurchaseApprovalRequest(Rec);
                end;
            }
            action("Attachment Document")
            {
                Ellipsis = true;
                Image = Attachments;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page Documents;
                RunPageLink = "Doc No." = field("No.");
            }
            action("RFQ Vendors")
            {
                Ellipsis = true;
                Image = Attachments;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "RFQ Vendors";
                RunPageLink = No = field("No.");
            }

            action("Bid Analysis Committee")
            {
                Ellipsis = true;
                Image = Attachments;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Bid Analysis Committee";
                RunPageLink = No = field("No.");
            }
            action("Bid Analysis Comment")
            {
                Ellipsis = true;
                Image = Attachments;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Bid Analysis Comment";
                RunPageLink = No = field("No.");
            }
            action("&Print")
            {
                Caption = 'Bid Analysis Matrix';
                Ellipsis = true;
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin

                    //Message('%1|%2', Rec."RFQ No", Rec."No.");
                    Purchheader.Reset();
                    Purchheader.SetRange(Purchheader."No.", Rec."No.");

                    Report.Run(80037, true, true, Purchheader);

                end;
            }
        }
    }
    trigger OnNewRecord(BelowxRec: Boolean)
    var
        "No. Series": Codeunit "No. Series";
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
        usersetup3: Record "User Setup";
        Customer: Record Customer;
    begin
        PurchasesPayablesSetup.Get();
        Rec."AU Form Type" := Rec."AU Form Type"::RFQ;
        Rec."Assigned User ID" := UserId;
        Rec.Status := Rec.Status::Open;
        PurchasesPayablesSetup.Get();
        Rec."User ID" := UserId;

        Rec."No." := "No. Series".GetNextNo(PurchasesPayablesSetup."Quotation Request No", Today, true);
        // Rec."Buy-from Vendor No." := PurchasesPayablesSetup."Vendor Nos.";
        // Rec."Vendor Posting Group" := PurchasesPayablesSetup."Vendor Posting Group";

    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    var
        "No. Series": Codeunit "No. Series";
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
        usersetup3: Record "User Setup";
        Customer: Record Customer;
    //PayablesSetup: Record payable
    begin
        PurchasesPayablesSetup.Get();
        Rec."AU Form Type" := Rec."AU Form Type"::RFQ;
        Rec."Assigned User ID" := UserId;
        Rec.Status := Rec.Status::Open;
        PurchasesPayablesSetup.Get();
        Rec."User ID" := UserId;

        Rec."No." := "No. Series".GetNextNo(PurchasesPayablesSetup."Quotation Request No", Today, true);
        // Rec."Buy-from Vendor No." := PurchasesPayablesSetup."Vendor Nos.";
        // Rec."Vendor Posting Group" := PurchasesPayablesSetup."Vendor Posting Group";

    end;

    trigger OnOpenPage()
    begin
        // Rec.SetRange("User ID", UserId);
    end;

    var
        myInt: Integer;
        //ApprovalMgt: Codeunit "Approvals Mgmt.";
        Purchheader: Record "Purchase Header";
}


