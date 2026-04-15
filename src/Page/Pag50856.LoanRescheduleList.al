//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50856 "Loan Reschedule List"
{
    ApplicationArea = All;
    CardPageID = "Loan Reschedule Card";
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "Loan Rescheduling";
    SourceTableView = where(Rescheduled = filter(false));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Document No";Rec."Document No")
                {
                }
                field("Member No";Rec."Member No")
                {
                }
                field("Loan No";Rec."Loan No")
                {
                }
                field("Rescheduled By";Rec."Rescheduled By")
                {
                }
                field("Rescheduled Date";Rec."Rescheduled Date")
                {
                }
                field("Repayment Amount";Rec."Repayment Amount")
                {
                }
                field("Loan Principle Repayment";Rec."Loan Principle Repayment")
                {
                }
                field("Loan Interest Repayment";Rec."Loan Interest Repayment")
                {
                }
            }
        }
    }

    actions
    {
    }
}






