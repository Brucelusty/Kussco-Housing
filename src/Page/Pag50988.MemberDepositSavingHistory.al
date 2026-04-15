//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50988 "Member Deposit Saving History"
{
    ApplicationArea = All;
    Editable = false;
    PageType = ListPart;
    SourceTable = "Member Deposits Saving History";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Loan No";Rec."Loan No")
                {
                }
                field("Transaction Date";Rec."Transaction Date")
                {
                }
                field("Transaction Description";Rec."Transaction Description")
                {
                }
                field("Amount Out";Rec."Amount Out")
                {
                }
                field("Amount In";Rec."Amount In")
                {
                }
            }
        }
    }

    actions
    {
    }
}






