namespace KUSCCOHOUSING.KUSCCOHOUSING;

page 51186 "Risk List"
{
    ApplicationArea = All;
    PageType = List;
    SourceTable = "Risk Register";
    UsageCategory = Lists;
    CardPageId = "Risk Card";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Risk ID"; Rec."Risk ID") { }
                field("Risk Description"; Rec."Risk Description") { }
                field("Risk Category"; Rec."Risk Category") { }
                field(Likelihood; Rec.Likelihood) { }
                field(Impact; Rec.Impact) { }
                field("Risk Score"; Rec."Risk Score") { Style = Strong; }
                field(Status; Rec.Status) { }
                field("Owner ID"; Rec."Owner ID") { }
                field("Due Date"; Rec."Due Date") { }
                field(Escalated; Rec.Escalated) { }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(NewRisk)
            {
                Caption = 'New Risk';
                Image = New;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Risk Card";
                RunPageMode = Create;
            }

            action(ShowHighRisk)
            {
                Caption = 'High Risks';
                Image = Warning;
                Promoted = true;
                PromotedCategory = Category4;

                trigger OnAction()
                begin
                    Rec.SetFilter("Risk Score", '>=10');
                end;
            }

            action(ShowEscalated)
            {
                Caption = 'Escalated Risks';
                Image = Alert;
                Promoted = true;
                PromotedCategory = Category4;

                trigger OnAction()
                begin
                    Rec.SetRange(Status, Rec.Status::Escalated);
                end;
            }
        }
    }
}



