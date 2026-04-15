namespace TelepostSacco.TelepostSacco;
using Microsoft.Sales.Customer;

page 51181 "Staff Recuited Members"
{
    ApplicationArea = All;
    PageType = ListPart;
    SourceTable = Customer;
    UsageCategory = Lists;
    
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No.";Rec."No.")
                {
                }
                field(Name;Rec.Name)
                {
                }
                field("Payroll No";Rec."Payroll No")
                {
                }
                field("Mobile Phone No";Rec."Mobile Phone No")
                {
                }
                field("Employer Code";Rec."Employer Code")
                {
                }
                field("Membership Status";Rec."Membership Status")
                {
                }
                field("Registration Date";Rec."Registration Date")
                {
                }
            }
        }
    }
}


