//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50628 "Payroll Posting Setup Ver1"
{
    ApplicationArea = All;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "Payroll Posting Setup Ver1";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Transaction Code";Rec."Transaction Code")
                {
                }
                field("Transaction Description";Rec."Transaction Description")
                {
                }
                field("Debit G/L Account";Rec."Debit G/L Account")
                {
                }
                field("Debit G/L Account Name";Rec."Debit G/L Account Name")
                {
                }
                field("Credit G/L Account";Rec."Credit G/L Account")
                {
                }
                field("Credit G/L Account Name";Rec."Credit G/L Account Name")
                {
                }
                field("Sacco Deduction Type";Rec."Sacco Deduction Type")
                {
                }
            }
        }
    }

    actions
    {
    }
}






