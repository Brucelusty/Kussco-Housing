//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50818 "Agent Transactions"
{
    ApplicationArea = All;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "Agent Transactions";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Document No.";Rec."Document No.")
                {
                }
                field("Transaction Date";Rec."Transaction Date")
                {
                }
                field("Account No.";Rec."Account No.")
                {
                }
                field(Description; Rec.Description)
                {
                }
                field(Amount; Rec.Amount)
                {
                }
                field(Posted; Rec.Posted)
                {
                }
                field("Transaction Type";Rec."Transaction Type")
                {
                }
                field("Transaction Time";Rec."Transaction Time")
                {
                }
                field("Bal. Account No.";Rec."Bal. Account No.")
                {
                }
                field("Document Date";Rec."Document Date")
                {
                }
                field("Date Posted";Rec."Date Posted")
                {
                }
                field("Time Posted";Rec."Time Posted")
                {
                }
                field("Account Status";Rec."Account Status")
                {
                }
                field(Messages; Rec.Messages)
                {
                }
                field("Needs Change";Rec."Needs Change")
                {
                }
                field("Old Account No";Rec."Old Account No")
                {
                }
                field(Changed; Rec.Changed)
                {
                }
                field("Date Changed";Rec."Date Changed")
                {
                }
                field("Time Changed";Rec."Time Changed")
                {
                }
                field("Changed By";Rec."Changed By")
                {
                }
                field("Approved By";Rec."Approved By")
                {
                }
                field("Original Account No";Rec."Original Account No")
                {
                }
                field("Account Balance";Rec."Account Balance")
                {
                }
                field("Branch Code";Rec."Branch Code")
                {
                }
                field("Activity Code";Rec."Activity Code")
                {
                }
                field("Global Dimension 1 Filter";Rec."Global Dimension 1 Filter")
                {
                }
                field("Global Dimension 2 Filter";Rec."Global Dimension 2 Filter")
                {
                }
                field("Account No 2";Rec."Account No 2")
                {
                }
                field(CCODE; Rec.CCODE)
                {
                }
                field("Transaction Location";Rec."Transaction Location")
                {
                }
                field("Transaction By";Rec."Transaction By")
                {
                }
                field("Agent Code";Rec."Agent Code")
                {
                }
                field("Loan No";Rec."Loan No")
                {
                }
                field("Account Name";Rec."Account Name")
                {
                }
                field(Telephone; Rec.Telephone)
                {
                }
                field("Id No";Rec."Id No")
                {
                }
                field(Branch; Rec.Branch)
                {
                }
                field("Member No";Rec."Member No")
                {
                }
            }
        }
    }

    actions
    {
    }
}






