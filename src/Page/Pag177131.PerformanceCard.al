namespace KUSCCOHOUSING.KUSCCOHOUSING;

page 51201 "Performance Card"
{
    ApplicationArea = All;
    PageType = Card;
    SourceTable = "Performance Header";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.") { }
                field("Period"; Rec."Period") { }
                field("Scope"; Rec."Scope") { }
                field("Officer ID"; Rec."Officer ID") { }
                field("Total Score"; Rec."Total Score") { Editable = false; }
                field("Rating"; Rec."Rating") { Editable = false; }
            }

            part(Lines; "Performance Lines Subpage")
            {
                SubPageLink = "Document No." = field("No.");
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Calculate)
            {
                Caption = 'Calculate KPI';
                Image = Calculate;

                trigger OnAction()
                var
                    KPI: Codeunit "KPI Management";
                begin
                    KPI.CalculatePerformance(Rec."No.");
                    CurrPage.Update();
                end;
            }
        }
    }
}




