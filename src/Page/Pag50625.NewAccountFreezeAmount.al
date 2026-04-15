//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50625 "New Account Freeze Amount"
{
    ApplicationArea = All;
    //CardPageID = "Account Freeze Amount Card";
    Editable = true;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "Member Account Freeze Details";
    DeleteAllowed = false;
    

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Document No";Rec."Document No")
                {
                }
                field("Member No";Rec."Member No")
                {
                }
                field("Member Name";Rec."Member Name")
                {
                }
                field("Account No";Rec."Account No")
                {
                    Editable = not rec.Frozen;
                }
                field("Amount to Freeze";Rec."Amount to Freeze")
                {
                    Editable = not rec.Frozen;
                }
                field("Reason For Freezing";Rec."Reason For Freezing")
                {
                    ShowMandatory = true;
                    Editable = not rec.Frozen;
                }
                field(Frozen; Rec.Frozen)
                {
                }
                field("Frozen On";Rec."Frozen On")
                {
                }
                field("Frozen By";Rec."Frozen By")
                {
                }
                field("Reason For UnFreezing";Rec."Reason For UnFreezing")
                {
                    ShowMandatory = true;
                    Editable = rec.Frozen;
                }
                field(Unfrozen; Rec.Unfrozen)
                {
                    Editable = rec.Frozen;
                }
                field("Unfrozen On";Rec."Unfrozen On")
                {
                }
                field("Unfrozen By";Rec."Unfrozen By")
                {
                }
                field("Captured On";Rec."Captured On")
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
    }
}






