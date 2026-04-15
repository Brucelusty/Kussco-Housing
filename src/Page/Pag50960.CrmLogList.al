//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50960 "Crm Log List"
{
    ApplicationArea = All;
    CardPageID = "Crm log card";
    DeleteAllowed = false;
    Editable = false;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "General Equiries.";
    SourceTableView = where(Send = const(false));

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
        area(factboxes)
        {
            part(Control2;"Member Statistics FactBox")
            {
                Caption = 'BOSA Statistics FactBox';
                SubPageLink = "No." = field("Member No");
            }
            part(Control1;"FOSA Statistics FactBox")
            {
                SubPageLink = "No." = field("Fosa account");
            }
        }
    }

    actions
    {
    }
}






