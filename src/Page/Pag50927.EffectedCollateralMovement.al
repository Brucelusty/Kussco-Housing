//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50927 "Effected Collateral Movement"
{
    ApplicationArea = All;
    CardPageID = "Effected Collateral Move. Card";
    Editable = false;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "Collateral Movement  Register";
    SourceTableView = where("Action Effected" = filter(true));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Document No";Rec."Document No")
                {
                }
                field("Collateral ID";Rec."Collateral ID")
                {
                }
                field("Collateral Description";Rec."Collateral Description")
                {
                }
                field("Registered Owner";Rec."Registered Owner")
                {
                }
                field("Member No.";Rec."Member No.")
                {
                }
                field("Member Name";Rec."Member Name")
                {
                }
                field("Collateral Type";Rec."Collateral Type")
                {
                }
                field("Action Type";Rec."Action Type")
                {
                }
            }
        }
    }

    actions
    {
    }
}






