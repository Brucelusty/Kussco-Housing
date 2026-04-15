//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50301 "Employers List"
{
    ApplicationArea = All;
    CardPageID = "Employer Card";
    Editable = false;
    DeleteAllowed = false;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "Employers Register";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Employer Code";Rec."Employer Code")
                {
                }
                field("Employer Name";Rec."Employer Name")
                {
                }
                field(Employees;Rec.Employees)
                {
                }
                field("Employer Address";Rec."Employer Address")
                {
                }
                field("Employer Email";Rec."Employer Email")
                {
                }
                field("Employer Phone No";Rec."Employer Phone No")
                {
                }
                field("Contact Person";Rec."Contact Person")
                {
                }
                field("Payment Type";Rec."Payment Type")
                {
                }
            }
        }
    }

    actions
    {
    }
}






