page 50044 "Registered ESS Refund Card"
{
    ApplicationArea = All;
    PageType = Card;
    UsageCategory = Lists;
    SourceTable = "ESS Refund";
    DeleteAllowed = false;
    
    layout
    {
        area(Content)
        {
            Group(GroupName)
            {
                field("ESSRef No.";Rec."ESSRef No.")
                {
                    
                }
                field("Member No";Rec."Member No")
                {
                    Editable = false;
                    
                }
                field("Member Name";Rec."Member Name")
                {
                    
                }
                field("PF No";Rec."PF No")
                {
                    
                }
                field("Has Active ESS Loan";Rec."Has Active ESS Loan")
                {
                    
                }
                field("ESS Refund";Rec."ESS Refund")
                {
                    // Editable = not rec.Matured;
                    // Editable = false;
                }
                field("Refund Batch No";Rec."Refund Batch No")
                {
                    Editable = not rec.Refunded;
                }
                field("Captured On";Rec."Captured On")
                {
                    
                }
                field("Registered On";Rec."Registered On")
                {
                    
                }
                field("Maturing On";Rec."Maturing On")
                {
                    
                }
            }
        }
        area(Factboxes)
        {
            
        }
    }
    
    actions
    {
        area(Processing)
        {
            action(Proceed)
            {
                Caption = 'Proceed';
                Promoted = true;
                PromotedCategory = Process;
                Enabled = not rec.Matured;

                trigger OnAction() begin
                    if rec."Maturing On" > Today then Error('The notice has not reached its maturity date of %1.', rec."Maturing On");

                    Rec.TestField("ESS Refund");
                    rec.Matured:= true;
                    rec.modify;
                    Message('The ESS refund has successfully matured.');
                end;
            }
            action(Return)
            {
                Caption = 'Return to Registration';
                Promoted = true;
                PromotedCategory = Process;
                Enabled = not rec.Matured;

                trigger OnAction() begin
                    rec.Registered:= false;
                    rec.modify;
                    Message('The ESS refund has been returned to registration.');
                end;
            }
        }
        area(Reporting)
        {
            action(ESSRefundSlip)
            {
                Caption = 'Exit Refund Slip';
                Promoted = true;
                PromotedCategory = Report;
                PromotedOnly = true;
                trigger OnAction() begin
                    essRefund.Reset();
                    essRefund.SetRange("ESSRef No.", rec."ESSRef No.");
                    if essRefund.Find('-') then begin
                        Report.Run(175084, true, false, essRefund);
                    end;
                end;
            }
        }
    }
    var
    essRefund: Record "ESS Refund";
}


