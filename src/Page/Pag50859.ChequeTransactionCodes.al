//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50859 "Cheque Transaction Codes"
{
    ApplicationArea = All;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "Cheque Transaction Codes";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Rec.Code)
                {
                }
                field("Transaction Name"; Rec."Transaction Name")
                {
                }
                field("Is Common"; Rec."Is Common")
                {
                }
                field("Transaction Category"; Rec."Transaction Category")
                {
                }
            }
        }
    }

    actions
    {
    }
}






