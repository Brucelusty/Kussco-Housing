//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50793 "Mobile PIN Reset"
{
    ApplicationArea = All;
    //CardPageID = "MOBILE PIN Reset Card";
    DelayedInsert = true;
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "MOBILE Applications";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Account No"; Rec."Account No")
                {
                    Editable = false;
                    Enabled = false;
                }
                field("Account Name"; Rec."Account Name")
                {
                    Editable = false;
                }
                field(Telephone; Rec.Telephone)
                {
                    Editable = false;
                }
                field(SentToServer; Rec.SentToServer)
                {
                    Caption = 'Reset PIN';
                }
                field("ID No"; Rec."ID No")
                {
                }
                field("Date Applied"; Rec."Date Applied")
                {
                }
                field("Last PIN Reset"; Rec."Last PIN Reset")
                {
                }
                field("Reset By"; Rec."Reset By")
                {
                }
            }
        }
    }

    actions
    {
    }
}






