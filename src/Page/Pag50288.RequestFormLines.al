page 50288 "Request Form Lines"
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


