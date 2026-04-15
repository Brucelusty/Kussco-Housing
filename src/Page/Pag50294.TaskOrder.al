//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50294 "Task Order"
{
    ApplicationArea = All;
    Caption = 'Purchase Requisitions';
    CardPageID = "Task Order Card";
    Editable = false;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "Purchase Header";
    SourceTableView = where("Document Type" = const(Quote),
                            DocApprovalType = const(Requisition),
                            Status = filter(Open),PR = filter(true));

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("No.";Rec."No.")
                {
                }
                field("Order Address Code";Rec."Order Address Code")
                {
                    Visible = false;
                }
                field("Buy-from Vendor Name";Rec."Buy-from Vendor Name")
                {
                    Visible = false;
                }
                field("Posting Description";Rec."Posting Description")
                {
                }
                field("Vendor Authorization No.";Rec."Vendor Authorization No.")
                {
                    Visible = false;
                }
                field("Buy-from Post Code";Rec."Buy-from Post Code")
                {
                    Visible = false;
                }
                field("Buy-from Country/Region Code";Rec."Buy-from Country/Region Code")
                {
                    Visible = false;
                }
                field("Buy-from Contact";Rec."Buy-from Contact")
                {
                    Visible = false;
                }
                field("Pay-to Vendor No.";Rec."Pay-to Vendor No.")
                {
                    Visible = false;
                }
                field("Pay-to Name";Rec."Pay-to Name")
                {
                    Visible = false;
                }
                field("Pay-to Post Code";Rec."Pay-to Post Code")
                {
                    Visible = false;
                }
                field("Pay-to Country/Region Code";Rec."Pay-to Country/Region Code")
                {
                    Visible = false;
                }
                field("Pay-to Contact";Rec."Pay-to Contact")
                {
                    Visible = false;
                }
                field("Ship-to Code";Rec."Ship-to Code")
                {
                    Visible = false;
                }
                field("Ship-to Name";Rec."Ship-to Name")
                {
                    Visible = false;
                }
                field("Ship-to Post Code";Rec."Ship-to Post Code")
                {
                    Visible = false;
                }
                field("Ship-to Country/Region Code";Rec."Ship-to Country/Region Code")
                {
                    Visible = false;
                }
                field("Ship-to Contact";Rec."Ship-to Contact")
                {
                    Visible = false;
                }
                field("Posting Date";Rec."Posting Date")
                {
                    Visible = false;
                }
                field("Shortcut Dimension 1 Code";Rec."Shortcut Dimension 1 Code")
                {
                    Visible = false;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        DimMgt.LookupDimValueCodeNoUpdate(1);
                    end;
                }
                field("Shortcut Dimension 2 Code";Rec."Shortcut Dimension 2 Code")
                {
                    Visible = false;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        DimMgt.LookupDimValueCodeNoUpdate(2);
                    end;
                }
                field("Location Code";Rec."Location Code")
                {
                    Visible = true;
                }
                field("Purchaser Code";Rec."Purchaser Code")
                {
                    Visible = false;
                }
                // field("Responsible Officer";Rec."Responsible Officer")
                // {
                //     Caption = 'Procurement Officer';
                //     Visible = false;
                // }
                field("Assigned User ID";Rec."Assigned User ID")
                {
                }
                field("Currency Code";Rec."Currency Code")
                {
                    Visible = false;
                }
                field("Document Date";Rec."Document Date")
                {
                }
                field("Campaign No.";Rec."Campaign No.")
                {
                    Visible = false;
                }
                field(Status; Rec.Status)
                {
                    Visible = true;
                }
            }
        }
        area(factboxes)
        {
            part(Control1901138007;"Vendor Details FactBox")
            {
                SubPageLink = "No." = field("Buy-from Vendor No."),
                              "Date Filter" = field("Date Filter");
                Visible = true;
            }
            systempart(Control1900383207; Links)
            {
                Visible = false;
            }
            systempart(Control1905767507; Notes)
            {
                Visible = true;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Quote")
            {
                Caption = '&Quote';
                Image = Quote;
                action(Statistics)
                {
                    Caption = 'Statistics';
                    Image = Statistics;
                    Promoted = true;
                    PromotedCategory = Process;
                    ShortCutKey = 'F7';

                    trigger OnAction()
                    begin
                        Rec.CalcInvDiscForHeader;
                        Commit;
                        Page.RunModal(Page::"Purchase Statistics", Rec);
                    end;
                }
                action("Co&mments")
                {
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page "Purch. Comment Sheet";
                    RunPageLink = "Document Type" = field("Document Type"),
                                  "No." = field("No."),
                                  "Document Line No." = const(0);
                }
                action(Dimensions)
                {
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    ShortCutKey = 'Shift+Ctrl+D';

                    trigger OnAction()
                    begin
                        Rec.ShowDocDim;
                    end;
                }
                action(Approvals)
                {
                    Caption = 'Approvals';
                    Image = Approvals;

                    trigger OnAction()
                    var
                       // ApprovalEntries: Page "Approval Entries";
                    begin
                        // ApprovalEntries.Setfilters(Database::"Purchase Header","Document Type","No.");
                       // ApprovalEntries.Run;
                    end;
                }
            }
        }
        area(processing)
        {
            action("Make &Order")
            {
                Caption = 'Make &Order';
                Image = MakeOrder;
                Promoted = true;
                PromotedCategory = Process;
                Visible = false;

                trigger OnAction()
                var
                    SalesHeader: Record "Sales Header";
                begin
                    //IF ApprovalMgt.PrePostApprovalCheck(SalesHeader,Rec) THEN
                    // CODEUNIT.RUN(CODEUNIT::"Purch.-Quote to Order (Yes/No)",Rec);
                end;
            }
            action("&Print")
            {
                Caption = '&Print';
                Ellipsis = true;
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    if LinesCommitted then
                        Error('All Lines should be committed');
                    Rec.Reset;
                    Rec.SetRange("No.", Rec."No.");
                    Report.run(172100, true, true, Rec);
                    Rec.Reset;
                    //DocPrint.PrintPurchHeader(Rec);
                end;
            }
            group(Release)
            {
                Caption = 'Release';
                Image = ReleaseDoc;
                separator(Action1102601013)
                {
                }
                action("Re&lease")
                {
                    Caption = 'Re&lease';
                    Image = ReleaseDoc;
                    ShortCutKey = 'Ctrl+F9';

                    trigger OnAction()
                    var
                        ReleasePurchDoc: Codeunit "Release Purchase Document";
                    begin
                        ReleasePurchDoc.PerformManualRelease(Rec);
                    end;
                }
                action("Re&open")
                {
                    Caption = 'Re&open';
                    Image = ReOpen;

                    trigger OnAction()
                    var
                        ReleasePurchDoc: Codeunit "Release Purchase Document";
                    begin
                        ReleasePurchDoc.PerformManualReopen(Rec);
                    end;
                }
            }
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Image = "Action";
                action("Send A&pproval Request")
                {
                    Caption = 'Send A&pproval Request';
                    Image = SendApprovalRequest;

                    trigger OnAction()
                    begin
                        //IF ApprovalMgt.SendPurchaseApprovalRequest(Rec) THEN;
                    end;
                }
                action("Cancel Approval Re&quest")
                {
                    Caption = 'Cancel Approval Re&quest';
                    Image = Cancel;

                    trigger OnAction()
                    begin
                        //IF ApprovalMgt.CancelPurchaseApprovalRequest(Rec,TRUE,TRUE) THEN;
                    end;
                }
            }
        }
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Location Code" := 'Nairobi'
    end;

    trigger OnOpenPage()
    begin
        //SetSecurityFilterOnRespCenter;

        HREmp.Reset;
        HREmp.SetRange(HREmp."User ID", UserId);
        if HREmp.Get then
            Rec.SetRange("User ID", HREmp."User ID")
        else
            //user id may not be the creator of the doc
            Rec.SetRange("Assigned User ID", UserId);
    end;

    var
        DimMgt: Codeunit DimensionManagement;
        DocPrint: Codeunit "Document-Print";
        BCSetup: Record "Budgetary Control Setup";
        HREmp: Record "HR Employees";


    procedure LinesCommitted() Exists: Boolean
    var
        PurchLines: Record "Purchase Line";
    begin
        if BCSetup.Get() then begin
            if not BCSetup.Mandatory then begin
                Exists := false;
                exit;
            end;
        end else begin
            Exists := false;
            exit;
        end;
        if BCSetup.Get then begin
            Exists := false;
            PurchLines.Reset;
            PurchLines.SetRange(PurchLines."Document Type", Rec."Document Type");
            PurchLines.SetRange(PurchLines."Document No.", Rec."No.");
            //PurchLines.SetRange(PurchLines.Committed, false);
            if PurchLines.Find('-') then
                Exists := true;
        end else
            Exists := false;
    end;
}






