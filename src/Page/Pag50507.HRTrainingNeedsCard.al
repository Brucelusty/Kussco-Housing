//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50507 "HR Training Needs Card"
{
    ApplicationArea = All;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Reports,Functions';
    SourceTable = "HR Training Needs";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Code"; Rec.Code)
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("Start Date"; Rec."Start Date")
                {
                }
                field(Duration; Rec.Duration)
                {
                }
                field("Duration Units"; Rec."Duration Units")
                {
                }
                field("Cost Of Training"; Rec."Cost Of Training")
                {
                }
                field(Location; Rec.Location)
                {
                }
                field(Provider; Rec.Provider)
                {
                }
                field("Provider Name"; Rec."Provider Name")
                {
                    Editable = false;
                }
                field("End Date"; Rec."End Date")
                {
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                }
                field(Posted; Rec.Posted)
                {
                }
                field(Closed; Rec.Closed)
                {
                }
                field("Job id"; Rec."Job id")
                {
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Functions")
            {
                Caption = '&Functions';
                action("&Mark as Closed/Open")
                {
                    Caption = '&Mark as Closed/Open';
                    Image = CloseDocument;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    begin
                        if Rec.Closed then begin
                            Rec.Closed := false;
                            Message('Training need :: %1 :: has been Re-Opened', Rec.Description);
                        end
                        else begin
                            Rec.Closed := true;
                            Message('Training need :: %1 :: has been closed', Rec.Description);
                            Rec.Modify;
                        end;
                    end;
                }
            }
        }
    }

    var
        D: Date;
}






