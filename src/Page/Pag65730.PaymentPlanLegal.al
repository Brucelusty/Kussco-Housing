page 65730 "Payment Plan(Legal)"
{
    ApplicationArea = All;
    PageType = ListPart;
    SourceTable = "Recovery Payment Plan(Legal)";

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Plan No."; Rec."Plan No.") { Visible=false;}
                field("Proposed Amount"; Rec."Proposed Amount") { }
                field("Duration (Months)"; Rec."Duration (Months)") { }
                field("Status"; Rec."Status") { }
                field("Committee Decision Date"; Rec."Committee Decision Date") { }

                field("Start Date"; Rec."Start Date") {}
                field("Payment Method"; Rec."Payment Method") {}

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
                    CaseAttachments: Page "Pay Plan Att(lgl)";
                begin
                    CaseAttachments.SetLoanNo(Rec."Case No.");
                    CaseAttachments.RunModal();
                end;
            }

        }
    }
}


