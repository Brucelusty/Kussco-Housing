//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50627 "Member Account Freeze Subpage"
{
    ApplicationArea = All;
    CardPageID = "Account Freeze Amount Card";
    Editable = false;
    PageType = ListPart;
    SourceTable = "Member Account Freeze Details";

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
                }
                field("Amount to Freeze";Rec."Amount to Freeze")
                {
                }
                field("Reason For Freezing";Rec."Reason For Freezing")
                {
                }
                field("Captured On";Rec."Captured On")
                {
                }
                field("Captured By";Rec."Captured By")
                {
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
                field(Unfrozen; Rec.Unfrozen)
                {
                }
                field("Unfrozen On";Rec."Unfrozen On")
                {
                }
                field("Unfrozen By";Rec."Unfrozen By")
                {
                }
            }
        }
    }

    actions
    {
    }
}






