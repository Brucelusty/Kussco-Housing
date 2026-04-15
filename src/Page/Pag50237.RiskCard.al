page 50237 "Risk Card"
{
    ApplicationArea = All;
    PageType = Card;
    SourceTable = "Risk Register";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Risk ID"; Rec."Risk ID") { Editable = false; }
                field("Risk Description"; Rec."Risk Description") { }
                field("Risk Category"; Rec."Risk Category") { }
                field(Likelihood; Rec.Likelihood) { }
                field(Impact; Rec.Impact) { }
                field("Risk Score"; Rec."Risk Score")
                {
                    Editable = false;
                    Style = Strong;
                }
                field(Status; Rec.Status) { }
                field(Escalated; Rec.Escalated) { Editable = false; }
            }

            group("Ownership & Dates")
            {
                field("Owner ID"; Rec."Owner ID") { }
                field("Department Code"; Rec."Department Code") { }
                field("Date Identified"; Rec."Date Identified") { Editable = false; }
                field("Due Date"; Rec."Due Date") { }
                field("Closed Date"; Rec."Closed Date") { Editable = false; }
                field("Last Updated"; Rec."Last Updated") { Editable = false; }
            }

            group("Mitigation Plan.")
            {
                field("Mitigation Plan"; Rec."Mitigation Plan")
                {
                    MultiLine = true;
                }
            }

            part(Incidents; "Risk Incident Subpage")
            {
                SubPageLink = "Risk ID" = field("Risk ID");
            }
        }

        area(factboxes)
        {
            part(RiskFactBox; "Risk FactBox")
            {
                SubPageLink = "Risk ID" = field("Risk ID");
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Escalate)
            {
                Caption = 'Escalate Risk';
                Image = Alert;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    Rec.Status := Rec.Status::Escalated;
                    Rec.Escalated := true;
                    Rec.Modify();
                end;
            }

            action(CloseRisk)
            {
                Caption = 'Close Risk';
                Image = Complete;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    Rec.Status := Rec.Status::Closed;
                    Rec."Closed Date" := Today;
                    Rec.Modify();
                end;
            }

            action(Reassess)
            {
                Caption = 'Reassess Risk';
                Image = Calculate;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    if Rec.Status = Rec.Status::Closed then
                        Error('Closed risks cannot be reassessed.');

                    // Recalculate score
                    Rec.Validate(Likelihood);
                    Rec.Validate(Impact);

                    // If previously escalated and score is now lower, normalize
                    if Rec."Risk Score" < 10 then begin
                        Rec.Escalated := false;
                        Rec.Status := Rec.Status::Open;
                    end;

                    Rec.Modify(true);

                    Message('Risk %1 has been successfully reassessed.', Rec."Risk ID");
                end;
            }

        }
    }
}


