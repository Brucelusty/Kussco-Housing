page 51121 "BD Opportunity Card"
{
    ApplicationArea = All;
    PageType = Card;
    SourceTable = "BD Opportunity";
    Caption = 'BD Opportunity';

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Opportunity No."; Rec."Opportunity No.")
                {
                    Editable = false;
                }
                field("Partner No."; Rec."Partner No.") { }
                field("Opportunity Type"; Rec."Opportunity Type") { }
                field(Stage; Rec.Stage) { }
            }

            group(Values)
            {
                field("Estimated Value"; Rec."Estimated Value") { }
                field(Probability; Rec.Probability) { }
                field("Expected Start Date"; Rec."Expected Start Date") { }
            }

            group(Status)
            {
                field(Converted; Rec.Converted)
                {
                    Editable = false;
                }
                field("Created By"; Rec."Created By")
                {
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(ApproveOpportunity)
            {
                Caption = 'Approve';
                Image = Approve;
                Enabled = Rec.Stage <> Rec.Stage::Approved;

                trigger OnAction()
                begin
                    Rec.Stage := Rec.Stage::Approved;
                    Rec.Modify(true);
                end;
            }

            action(ConvertOpportunity)
            {
                Caption = 'Convert';
                Image = Post;
                Enabled = Rec.Stage = Rec.Stage::Approved;

                trigger OnAction()
                var
                    //MembershipApp: Record "Membership Applications";
                    MembershipApp: Record "Membership Applications";
                    Membership: Record "Membership Applications";
                    SaccoNoSeries: Record "Sacco No. Series";
                    VarNewMembNo: Code[80];
                    NoSeriesMgt: Codeunit "No. Series";
                    BDPartner: Record "BD Partner";
                begin
                    if Confirm('Do you want to convert this contact to Prospect?', true, false) = true then begin
                        SaccoNoSeries.Get();
                        VarNewMembNo := NoSeriesMgt.GetNextNo(SaccoNoSeries."Member Application Nos", Today, true);//
                        BDPartner.Get(Rec."Partner No.");
                        MembershipApp.Init();
                        // Basic Information
                        MembershipApp."No." := VarNewMembNo;
                        MembershipApp.Name := BDPartner."Partner Name";
                        MembershipApp."Name of the Group/Corporate":=BDPartner."Partner Name";
                        MembershipApp."Account Category" := MembershipApp."Account Category"::Corporate;
                        //   MembershipApp.reffe:= Rec."Referred By";
                        // Contact Information
                        //   MembershipApp."Phone No." := Rec."Mobile Phone No";
                        // MembershipApp."Mobile Phone No" := Rec."Mobile Phone No";
                        // Reference Information
                        MembershipApp."Lead No" := Rec."Partner No.";
                        //MembershipApp."Marketing Campaign ID" := Rec."Marketing Campaign ID";
                        //MembershipApp."Marketing Event ID" := Rec."Marketing Event ID";


                        // Dimension Codes
                        // MembershipApp."Global Dimension 1 Code" := Rec."Global Dimension 1 Code";
                        // MembershipApp."Global Dimension 2 Code" := Rec."Global Dimension 2 Code";


                        MembershipApp.Insert(true);
                        Message('Prospect application #%1 has been created.', VarNewMembNo);
                        Rec.Converted := true;
                        Rec.Modify(true);
                    end;
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
        Rec."Created By" := UserId();
        Rec.Stage := Rec.Stage::Identified;
    end;
}


