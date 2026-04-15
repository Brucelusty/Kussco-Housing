//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50752 "Customer Care Log List"
{
    ApplicationArea = All;
    CardPageID = "Customer Care Log";
    Editable = false;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "Customer Care Logs";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(No; Rec.No)
                {
                }
                field("Member No";Rec."Member No")
                {
                }
                field("Member Name";Rec."Member Name")
                {
                }
                field("Payroll No";Rec."Payroll No")
                {
                }
                field("Loan Balance";Rec."Loan Balance")
                {
                }
                field("Current Deposits";Rec."Current Deposits")
                {
                }
                field("Holiday Savings";Rec."Holiday Savings")
                {
                }
                field(Description; Rec.Description)
                {
                }
                field(Status; Rec.Status)
                {
                }
                field("ID No";Rec."ID No")
                {
                }
            }
        }
    }

    actions
    {
    }
}






