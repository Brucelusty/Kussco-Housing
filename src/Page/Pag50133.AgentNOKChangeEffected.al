//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50133 "Agent/NOK Change - Effected"
{
    ApplicationArea = All;
    CardPageID = "Agent/NOK/Sign. Change Card";
    Editable = false;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "Member Agent/Next Of Kin Chang";
    SourceTableView = where("Change Effected" = filter(true));

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
                field("Account Type";Rec."Account Type")
                {
                }
                field("Account No";Rec."Account No")
                {
                }
                field("Change Type";Rec."Change Type")
                {
                }
                field("Captured By";Rec."Captured By")
                {
                }
                field("Captured On";Rec."Captured On")
                {
                }
                field("Change Effected";Rec."Change Effected")
                {
                }
                field(Status; rec.Status)
                {
                }
                field("Change Effected On";Rec."Change Effected On")
                {
                }
                field("Change Effected By";Rec."Change Effected By")
                {
                }
            }
        }
    }

    actions
    {
    }
}






