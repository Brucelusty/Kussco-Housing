page 50287 "RFQ Lines"
{
    ApplicationArea = All;
    PageType = ListPart;
    UsageCategory = Administration;
    SourceTable = "Purchase Line";

    layout
    {
        area(Content)
        {
            repeater(Control1)
            {


                field("Description 2"; Rec."Description 2")
                {
                    Caption = 'Item Description';
                    Visible = false;


                }



            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(SendApprovalWorkflow)
            {

                trigger OnAction()
                begin
                    //ApprovalMgt.OnSendPurchaseDocForApproval(Rec);
                end;
            }
        }
    }

    var
        myInt: Integer;
        ApprovalMgt: Codeunit "Approvals Mgmt.";
}


