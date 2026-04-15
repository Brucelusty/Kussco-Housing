page 51134 "Auction Subpage"
{
    ApplicationArea = All;
    PageType = ListPart;
    SourceTable = "Auction Entry";

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Auction No."; Rec."Auction No.") { Visible = false; }
                field("Auctioneer"; Rec."Auctioneer") { }
                field("Auction Date"; Rec."Auction Date") { }
                field("Highest Bid"; Rec."Highest Bid") { }
                field("Status"; Rec."Status") { }
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
                    CaseAttachments: Page "Auction Details Attachment";
                begin
                    CaseAttachments.SetLoanNo(Rec."Case No.");
                    CaseAttachments.RunModal();
                end;
            }

        }
    }
}


