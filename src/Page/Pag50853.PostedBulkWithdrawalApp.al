//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50853 "Posted Bulk Withdrawal App"
{
    ApplicationArea = All;
    CardPageID = "Poste Bulk Withdrawal card";
    Editable = false;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "Bulk Withdrawal Application";
    SourceTableView = where("Noticed Updated" = filter(true));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Transaction No";Rec."Transaction No")
                {
                }
                field("Created By";Rec."Created By")
                {
                }
                field("Date Created";Rec."Date Created")
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
                field("Account Name";Rec."Account Name")
                {
                }
                field("Savings Product";Rec."Savings Product")
                {
                }
                field(Status; Rec.Status)
                {
                }
            }
        }
    }

    actions
    {
    }
}






