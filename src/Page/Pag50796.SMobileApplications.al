//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50796 "S-Mobile Applications"
{
    ApplicationArea = All;
    DeleteAllowed = false;
    Editable = true;
    InsertAllowed = false;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "Mobile Applications";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Account No"; Rec."Account No")
                {
                }
                field("Account Name"; Rec."Account Name")
                {
                }
                field(Telephone; Rec.Telephone)
                {
                }
                field("ID No"; Rec."ID No")
                {
                }
                field(Sent; Rec.Sent)
                {
                }
                field(Status; Rec.Status)
                {
                }
                field("Date Applied"; Rec."Date Applied")
                {
                }
            }
        }
    }

    actions
    {
    }
}






