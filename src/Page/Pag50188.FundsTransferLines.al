//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50188 "Funds Transfer Lines"
{
    ApplicationArea = All;
    PageType = ListPart;
    SourceTable = "Funds Transfer Line";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Receiving Bank Account";Rec."Receiving Bank Account")
                {
                }
                field("Bank Name";Rec."Bank Name")
                {
                }
                field("Bank Balance";Rec."Bank Balance")
                {
                }
                field("Amount to Receive";Rec."Amount to Receive")
                {
                }
                field("External Doc No.";Rec."External Doc No.")
                {
                }
            }
        }
    }

    actions
    {
    }
}






