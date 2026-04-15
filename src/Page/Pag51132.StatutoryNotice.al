page 51132 "Statutory Notice"
{
    ApplicationArea = All;
    PageType = ListPart;
    SourceTable = "Statutory Notice Entry";

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Notice Type"; Rec."Notice Type") { }
                field("Issue Date"; Rec."Issue Date") { }
                field("Expiry Date"; Rec."Expiry Date") { }
                field("Served"; Rec."Served") { }
                field("Proof of Service"; Rec."Proof of Service") { }
            }
        }
    }
        actions
    {
        area(Processing)
        {



            action(Attachments)
            {
                Caption = 'Attachments';
                Image = Attach;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    CaseAttachments: Page "Internal Recovery Att";
                begin
                    CaseAttachments.SetLoanNo(Rec."Case No.");
                    CaseAttachments.RunModal();
                end;
            }

        }
    }
}


