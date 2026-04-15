//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50700 "Supervisor Approvals Levels"
{
    ApplicationArea = All;
    PageType = Card;
    SourceTable = "Supervisors Approval Levels";

    layout
    {
        area(content)
        {
            repeater(Control4)
            {
                field("Supervisor ID";Rec."Supervisor ID")
                {
                    Caption = 'User ID';
                }
                field("Supervisor Name";Rec."Supervisor Name")
                {
                    Editable = false;
                }
                field("Transaction Type";Rec."Transaction Type")
                {
                }
                field("Maximum Approval Amount";Rec."Maximum Approval Amount")
                {
                }
            }
        }
    }

    actions
    {
    }
}






