//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50362 "Post Cheque Rcpts List-Family"
{
    ApplicationArea = All;
    CardPageID = "Posted Cheque Rcpt H-Family";
    DeleteAllowed = false;
    Editable = false;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "Cheque Receipts-Family";
    SourceTableView = where(Closed = filter(true));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No.";Rec."No.")
                {
                }
                field("Transaction Date";Rec."Transaction Date")
                {
                }
                field("Refference Document";Rec."Refference Document")
                {
                }
                field("Transaction Time";Rec."Transaction Time")
                {
                }
                field("Created By";Rec."Created By")
                {
                }
                field("Posted By";Rec."Posted By")
                {
                }
                field(Posted; Rec.Posted)
                {
                }
                field("No. Series";Rec."No. Series")
                {
                }
                field("Unpaid By";Rec."Unpaid By")
                {
                }
                field(Unpaid; Rec.Unpaid)
                {
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Inward Cheques Report")
            {
                Image = Form;
                Promoted = true;
                PromotedCategory = "Report";

                trigger OnAction()
                begin
                    ObjInwardHeader.Reset;
                    ObjInwardHeader.SetRange(ObjInwardHeader."No.", Rec."No.");
                    if ObjInwardHeader.FindSet then
                        Report.run(172877, true, true, ObjInwardHeader)
                end;
            }
        }
    }

    var
        ObjInwardHeader: Record "Cheque Receipts-Family";
}






