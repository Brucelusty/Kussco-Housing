namespace TelepostSacco.TelepostSacco;

page 51206 "Staff Recruited Salaries"
{
    ApplicationArea = All;
    PageType = ListPart;
    SourceTable = "Register Salary Accounts";
    SourceTableView = where(Status = filter("Sent To HR"), "Sent To HR" = filter(true));
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Salary Account";Rec."Salary Account")
                {
                }
                field("Salary Account Holder";Rec."Salary Account Holder")
                {
                }
                field("Employer Code";Rec."Employer Code")
                {
                }
                field("Expected Salary";Rec."Expected Salary")
                {
                }
                field("Staff No.";Rec."Staff No.")
                {
                }
                field(Posted;Rec.Posted)
                {
                }
            }
        }
    }
}


