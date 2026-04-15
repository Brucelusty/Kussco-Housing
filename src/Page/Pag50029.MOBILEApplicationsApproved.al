//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50029 "MOBILE Applications Approved"
{
    ApplicationArea = All;
    CardPageID = "Approved MOBILE Card";
    PageType = List;
    UsageCategory = Lists;
    Editable=false;
    DeleteAllowed=false;
    SourceTable = "MOBILE Applications";
    Caption = 'Mobile Banking application';
    SourceTableView=WHERE(Status=CONST(Approved));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                }
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
                field(Status; Rec.Status)
                {
                }
                field("Date Applied"; Rec."Date Applied")
                {
                }
                field("Time Applied"; Rec."Time Applied")
                {
                }
                field("Created By"; Rec."Created By")
                {
                }
                field(SentToServer; Rec.SentToServer)
                {
                }
                field(activated; Rec.Activated)
                {
                }
                field(pinrequested; Rec."PIN Requested")
                {
                }
            }
        }
    }

    actions
    {
    }
}






