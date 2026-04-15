//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50505 "HR Activity Participants SF"
{
    ApplicationArea = All;
    Caption = 'Activity Participants';
    PageType = ListPart;
    SaveValues = true;
    SourceTable = "HR Activity Participants";

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                field(Notified;Rec.Notified)
                {
                }
                field(Participant;Rec.Participant)
                {
                }
                field(Contribution;Rec.Contribution)
                {
                }
                field("Email Message";Rec."Email Message")
                {
                }
            }
        }
    }

    actions
    {
    }
}






