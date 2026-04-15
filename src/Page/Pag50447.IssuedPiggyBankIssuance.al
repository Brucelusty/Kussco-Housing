//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50447 "Issued Piggy Bank Issuance"
{
    ApplicationArea = All;
    CardPageID = "Piggy Bank Issuance Card";
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "Piggy Bank Issuance";
    SourceTableView = where(Issued = filter(true));
    DeleteAllowed = false;
    Editable = false;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Document No";Rec."Document No")
                {
                }
                field("Member Account No";Rec."Member No")
                {
                }
                field("Member Name";Rec."Member Name")
                {
                }
                field("Piggy Bank Account";Rec."Piggy Bank Account")
                {
                }
            }
        }
    }

    actions
    {
    }
}






