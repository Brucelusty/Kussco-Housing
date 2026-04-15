//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50548 "HR Leave Application Comments"
{
    ApplicationArea = All;
    PageType = Card;
    SourceTable = "Approval Comment Line";

    layout
    {
        area(content)
        {
            field(DocType; DocType)
            {
                Editable = false;
                OptionCaption = 'Quote,Order,Invoice,Credit Memo,Blanket Order,Return Order,None,Payment Voucher,Petty Cash,Imprest,Requisition,ImprestSurrender,Interbank,Receipt,Staff Claim,Staff Advance,AdvanceSurrender,Bank Slip,Grant,Grant Surrender,Employee Requisition,Leave Application,Training Application,Transport Requisition';
            }
            field(DocNo; DocNo)
            {
                Editable = false;
            }
            repeater(Control1102755000)
            {
                field("User ID";Rec."User ID")
                {
                }
                field("Date and Time";Rec."Date and Time")
                {
                }
                field(Comment; Rec.Comment)
                {
                }
                field("Approved Days";Rec."Approved Days")
                {
                }
                // field("Approved Start Date";appl)
                // {
                // }
                // field("Approved Return Date";"Approved Return Date")
                // {
                // }
                // field(Reason;Reason)
                // {
                // }
                // field("Leave Allowance Granted";"Leave Allowance Granted")
                // {
                // }
            }
        }
    }

    actions
    {
    }

    var
        NewTableId: Integer;
        NewDocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,Receipt,"Staff Claim","Staff Advance",AdvanceSurrender,"Bank Slip",Grant,"Grant Surrender","Employee Requisition","Leave Application","Training Application";
        NewDocumentNo: Code[20];
        DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,Receipt,"Staff Claim","Staff Advance",AdvanceSurrender,"Bank Slip",Grant,"Grant Surrender","Employee Requisition","Leave Application","Training Application";
        DocNo: Code[20];


    procedure SetUpLine(TableId: Integer; DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,Receipt,"Staff Claim","Staff Advance",AdvanceSurrender,"Bank Slip",Grant,"Grant Surrender","Employee Requisition","Leave Application","Training Application"; DocumentNo: Code[20])
    begin
        NewTableId := TableId;
        NewDocumentType := DocumentType;
        NewDocumentNo := DocumentNo;
    end;


    procedure Setfilters(TableId: Integer; DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,Receipt,"Staff Claim","Staff Advance",AdvanceSurrender,"Bank Slip",Grant,"Grant Surrender","Employee Requisition","Leave Application","Training Application"; DocumentNo: Code[20])
    begin
        if TableId <> 0 then begin
            Rec.FilterGroup(2);
            Rec.SetCurrentkey("Table ID", "Document Type", "Document No.");
            Rec.SetRange("Table ID", TableId);
            Rec.SetRange("Document Type", DocumentType);
            if DocumentNo <> '' then
                Rec.SetRange("Document No.", DocumentNo);
            Rec.FilterGroup(0);
        end;

        DocType := DocumentType;
        DocNo := DocumentNo;
    end;
}






