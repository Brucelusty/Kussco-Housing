//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50429 "Store Requisitions(Pending)"
{
    ApplicationArea = All;
    CardPageID = "Store Requisition Header";
    PageType = List;
    UsageCategory = Lists;
    PromotedActionCategories = 'New,Process,Reports,Approvals,Cancellation,Category6_caption,Category7_caption,Category8_caption,Category9_caption,Category10_caption';
    SourceTable = "Store Requistion Header";
    SourceTableView = where(Status = filter("Pending Approval"));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No.";Rec."No.")
                {
                }
                field("Request date";Rec."Request date")
                {
                }
                field("Request Description";Rec."Request Description")
                {
                }
                field("Requester ID";Rec."Requester ID")
                {
                }
                field(Status; Rec.Status)
                {
                }
                field(TotalAmount; Rec.TotalAmount)
                {
                }
                field("User ID";Rec."User ID")
                {
                }
                field("Issuing Store";Rec."Issuing Store")
                {
                }
            }
        }
        area(factboxes)
        {
            systempart(Control1102755010; Notes)
            {
            }
            systempart(Control1102755011; MyNotes)
            {
            }
            systempart(Control1102755012; Links)
            {
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("<Action1102755026>")
            {
                Caption = '&Functions';
            }
        }
    }

    trigger OnOpenPage()
    begin

        if UserMgt.GetPurchasesFilter() <> '' then begin
            Rec.FilterGroup(2);
            Rec.SetRange("Responsibility Center", UserMgt.GetPurchasesFilter());
            Rec.FilterGroup(0);
        end;
        /*
        IF UserMgt.GetSetDimensions(USERID,2) <> '' THEN BEGIN
          FILTERGROUP(2);
          SETRANGE("Shortcut Dimension 2 Code",UserMgt.GetSetDimensions(USERID,2));
          FILTERGROUP(0);
        END;
        */

    end;

    var
        UserMgt: Codeunit "User Setup Management BRr";
        ReqLine: Record "Store Requistion Lines";
        InventorySetup: Record "Inventory Setup";
        GenJnline: Record "Item Journal Line";
        LineNo: Integer;
        Post: Boolean;
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition;
        HasLines: Boolean;
        AllKeyFieldsEntered: Boolean;


    procedure LinesExists(): Boolean
    var
        PayLines: Record "Store Requistion Lines";
    begin
        HasLines := false;
        PayLines.Reset;
        PayLines.SetRange(PayLines."Requistion No", Rec."No.");
        if PayLines.Find('-') then begin
            HasLines := true;
            exit(HasLines);
        end;
    end;
}






