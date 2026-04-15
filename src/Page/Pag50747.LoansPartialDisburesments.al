//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50747 "Loans Partial Disburesments"
{
    ApplicationArea = All;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "Loan Partial Disburesments";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Loan No.";Rec."Loan No.")
                {
                }
                field("Member No";Rec."Member No")
                {
                }
                field("Member Name";Rec."Member Name")
                {
                }
                field("Loan Product";Rec."Loan Product")
                {
                }
                field("Amount to Be Disbursed";Rec."Amount to Be Disbursed")
                {
                }
                field("Amount Due";Rec."Amount Due")
                {
                }
            }
        }
    }

    actions
    {
    }
}






