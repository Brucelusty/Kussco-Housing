//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50714 "NoK Application Card"
{
    ApplicationArea = All;
    PageType = Card;
    UsageCategory = Lists;
    SourceTable = "NOK Applications";
    Editable = false;
    InsertAllowed = false;
    DeleteAllowed = false;
    PromotedActionCategories = 'New,Process,Report,NoK';

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Application No";Rec."Application No")
                {
                }
                field("Member No";Rec."Member No")
                {
                }
                field("Member % Allocation";Rec."Member % Allocation")
                {
                    Style = StandardAccent;
                }
                field(Status;Rec.Status)
                {
                    Style = StrongAccent;
                }
                field("Application Type";Rec."Application Type")
                {
                    Style = Subordinate;
                }
                field("Date Applied";Rec."Date Applied")
                {
                }
                field("Time Applied";Rec."Time Applied")
                {
                }
                field("Captured By";Rec."Captured By")
                {
                }
            }
            group("Old Next of Kin Info")
            {
                field("Old Identification";Rec."Old Identification")
                {
                    Style = Subordinate;
                }
                field("Old Identification Value";Rec."Old Identification Value")
                {
                }
                field("Old Full Names";Rec."Old Full Names")
                {
                }
                field("Old Relationship";Rec."Old Relationship")
                {
                    Style = AttentionAccent;
                }
                field("Old Date of Birth";Rec."Old Date of Birth")
                {
                }
                field("Old Mobile Phone No";Rec."Old Mobile Phone No")
                {
                }
                field("Old Email Address";Rec."Old Email Address")
                {
                }
                field("Old Address";Rec."Old Address")
                {
                }
                field("Old Is Next of Kin";Rec."Old Is Next of Kin")
                {
                }
                field("Old Is Beneficiary";Rec."Old Is Beneficiary")
                {
                }
                field("Old Is Nominee";Rec."Old Is Nominee")
                {
                }
                field("Old Is Contact Person";Rec."Old Is Contact Person")
                {
                }
                field("Old % Allocation";Rec."Old % Allocation")
                {
                }
            }
            group("New Next of Kin Info")
            {
                field(Identification;Rec.Identification)
                {
                    Style = Subordinate;
                }
                field("Identification Value";Rec."Identification Value")
                {
                }
                field("Full Names";Rec."Full Names")
                {
                }
                field(Relationship;Rec.Relationship)
                {
                    Style = AttentionAccent;
                }
                field("Date of Birth";Rec."Date of Birth")
                {
                }
                field("Mobile Phone No";Rec."Mobile Phone No")
                {
                }
                field("Email Address";Rec."Email Address")
                {
                }
                field(Address;Rec.Address)
                {
                }
                field("Is Next of Kin";Rec."Is Next of Kin")
                {
                }
                field("Is Beneficiary";Rec."Is Beneficiary")
                {
                }
                field("Is Nominee";Rec."Is Nominee")
                {
                }
                field("Is Contact Person";Rec."Is Contact Person")
                {
                }
                field("% Allocation";Rec."% Allocation")
                {
                }
            }
        }
    }

    actions
    {
        area(Navigation)
        {
            action("Members NoK")
            {
                Caption = 'Member''s Next of Kin';
                Image = CustomerList;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedOnly = true;
                RunObject = Page "Member Next of Kin List";
                RunPageLink = "Account No" = field("Member No");
                RunPageMode = View;
            }
        }
        area(Processing)
        {
            action(Approve)
            {
                Caption = 'Approve Application';
                Image = NewCustomer;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;

                trigger OnAction() begin
                    Rec.TestField(Status, Rec.Status::Open);
                    if Confirm('Approving this application will create the applied next of kin. Do you wish to proceed?', true) = false then exit;

                    membersNok.Reset();
                    membersNok.SetRange("Account No", Rec."Member No");
                    membersNok.SetCurrentKey("NoK No.");
                    membersNok.SetAscending("NoK No.", true);
                    if membersNok.Find('+') then begin
                        nokNo := membersNok."NoK No." + 1;
                    end;

                    case Rec."Application Type" of
                        Rec."Application Type"::New:
                            begin
                                noks.Init();
                                noks."Account No" := Rec."Member No";
                                noks.Name := Rec."Full Names";
                                noks."New Upload" := true;
                                noks."Member No" := Rec."Member No";
                                noks.Relationship := Rec.Relationship;
                                noks."ID No." := Rec."Identification Value";
                                nokIDTypes.Reset();
                                nokIDTypes.SetRange(Description, Rec.Identification);
                                if nokIDTypes.Find('-') then begin
                                    noks."ID Type" := Rec.Identification;
                                end;
                                noks."Date of Birth" := Rec."Date of Birth";
                                noks.Address := Rec.Address;
                                noks.Telephone := Rec."Mobile Phone No";
                                noks.Email := Rec."Email Address";
                                noks."Is NoK" := Rec."Is Next of Kin";
                                noks.Beneficiary := Rec."Is Beneficiary";
                                noks."Is Contact Person" := Rec."Is Contact Person";
                                noks."Is Nominee" := Rec."Is Nominee";
                                noks."%Allocation" := Rec."% Allocation";
                                noks."Date Created" := Today;
                                noks."Created By" := UserId;
                                noks."NoK No." := nokNo;
                                noks.Insert;
                            end;
                        Rec."Application Type"::Update:
                            begin
                                noks.Reset();
                                noks.SetRange("Account No", Rec."Member No");
                                noks.SetRange("NoK No.", Rec."NoK No");
                                if noks.Find('-') then begin
                                    noks."Account No" := Rec."Member No";
                                    noks.Name := Rec."Full Names";
                                    noks."Member No" := Rec."Member No";
                                    noks.Relationship := Rec.Relationship;
                                    noks."ID No." := Rec."Identification Value";
                                    nokIDTypes.Reset();
                                    nokIDTypes.SetRange(Description, Rec.Identification);
                                    if nokIDTypes.Find('-') then begin
                                        noks."ID Type" := Rec.Identification;
                                    end;
                                    noks."Date of Birth" := Rec."Date of Birth";
                                    noks.Address := Rec.Address;
                                    noks.Telephone := Rec."Mobile Phone No";
                                    noks.Email := Rec."Email Address";
                                    noks."Is NoK" := Rec."Is Next of Kin";
                                    noks.Beneficiary := Rec."Is Beneficiary";
                                    noks."Is Contact Person" := Rec."Is Contact Person";
                                    noks."Is Nominee" := Rec."Is Nominee";
                                    noks."%Allocation" := Rec."% Allocation";
                                    noks."Last date Modified" := Today;
                                    noks."Modified by":= UserId;
                                    noks.Modify;
                                end;
                            end;
                    end;

                    Rec.Status := Rec.Status::Updated;
                    Rec.Modify;
                    
                    Message('The application has been approved and created successfully.');
                end;
            }
            action(Cancel)
            {
                Caption = 'Reject Application';
                Image = DeleteExpiredComponents;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;

                trigger OnAction() begin
                    Rec.TestField(Status, Rec.Status::Open);
                    if Confirm('Do you wish to proceed with rejecting this application?', true) = false then exit;

                    Rec.Status := Rec.Status::Cancelled;
                    Rec.Modify;

                    Message('The application has been rejected successfully.');
                end;
            }
        }
    }

    var
    nokNo: Integer;
    membersNok: Record "Members Next of Kin";
    noks: Record "Members Next of Kin";
    nokApp: Record "NOK Applications";
    nokIDTypes: Record "Portal Identification Types";
}






