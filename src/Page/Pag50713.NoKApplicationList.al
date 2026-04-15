//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50713 "NoK Application List"
{
    ApplicationArea = All;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "NOK Applications";
    CardPageId = "NoK Application Card";
    Editable = false;
    InsertAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Application No";Rec."Application No")
                {
                }
                field("Member No";Rec."Member No")
                {
                }
                field(Identification;Rec.Identification)
                {
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
        }
    }

    actions
    {
        area(Processing)
        {
            
        }
    }

    var
    nokNo: Integer;
    membersNok: Record "Members Next of Kin";
    noks: Record "Members Next of Kin";
    nokApp: Record "NOK Applications";
    nokIDTypes: Record "Portal Identification Types";
}






