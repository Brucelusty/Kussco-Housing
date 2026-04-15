//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50619 "Effected Sweeping Instructions"
{
    ApplicationArea = All;
    CardPageID = "Effected Sweeping Instruc Card";
    Editable = false;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "Member Sweeping Instructions";
    SourceTableView = where(Effected = filter(true));

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
                field("Monitor Account";Rec."Monitor Account")
                {
                }
                field("Monitor Account Type Desc";Rec."Monitor Account Type Desc")
                {
                }
                field("Minimum Account Threshold";Rec."Minimum Account Threshold")
                {
                    Caption = 'Minimum  Threshold';
                }
                field("Maximum Account Threshold";Rec."Maximum Account Threshold")
                {
                    Caption = 'Maximum  Threshold';
                }
                field("Investment Account";Rec."Investment Account")
                {
                }
                field("Investment Account Type Desc";Rec."Investment Account Type Desc")
                {
                }
            }
        }
    }

    actions
    {
    }
}






