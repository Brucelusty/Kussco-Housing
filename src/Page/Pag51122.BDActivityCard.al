page 51122 "BD Activity Card"
{
    ApplicationArea = All;
    PageType = Card;
    SourceTable = "BD Activity Log";
    Caption = 'BD Activity';

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Activity No."; Rec."Activity No.")
                {
                    Editable = false;
                }
                field("Partner No."; Rec."Partner No.") { }
                field("Activity Type"; Rec."Activity Type") { }
                field("Activity Date"; Rec."Activity Date") { }
            }

            group(Details)
            {
                field("BD Officer"; Rec."BD Officer")
                {
                    Editable = false;
                }
                field(Outcome; Rec.Outcome)
                {
                    MultiLine = true;
                }
                field("Next Follow-Up Date"; Rec."Next Follow-Up Date") { }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(CompleteFollowUp)
            {
                Caption = 'Complete Follow-Up';
                Image = Check;
                Enabled = Rec."Next Follow-Up Date" <> 0D;

                trigger OnAction()
                begin
                    Rec."Next Follow-Up Date" := 0D;
                    Rec.Modify(true);
                end;
            }
        }

        area(navigation)
        {
            action(OpenPartner)
            {
                Caption = 'Partner';
                Image = Customer;

                trigger OnAction()
                var
                    Partner: Record "BD Partner";
                begin
                    Partner.Get(Rec."Partner No.");
                    Page.Run(Page::"BD Partner Card", Partner);
                end;
            }
        }
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Activity Date" := WorkDate();
        Rec."BD Officer" := UserId();
    end;
}


