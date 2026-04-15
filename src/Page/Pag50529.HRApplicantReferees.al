//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50529 "HR Applicant Referees"
{
    ApplicationArea = All;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "HR Applicant Referees";

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field(Names;Rec.Names)
                {
                }
                field(Designation;Rec.Designation)
                {
                }
                field(Institution;Rec.Institution)
                {
                }
                field(Address;Rec.Address)
                {
                }
                field("Telephone No";Rec."Telephone No")
                {
                }
                field("E-Mail";Rec."E-Mail")
                {
                }
            }
        }
    }

    actions
    {
    }
}






