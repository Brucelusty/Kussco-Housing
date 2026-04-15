//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50465 "MOBILE PIN Reset Logs"
{
    ApplicationArea = All;
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    UsageCategory = Lists;
    Caption = 'Mobile Logs';
    SourceTable = "MOBILE Pin Reset Logs";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Entry No"; Rec."Entry No")
                {
                }
                field(No; Rec.No)
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
                field(Date; Rec.Date)
                {
                }
                field("ResetBy"; Rec."Reset By")
                {
                }
                field("OTP Code"; Rec."OTP Code")
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






