//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50589 "HR Applicants UnQualified Card"
{
    ApplicationArea = All;
    PageType = Card;
    SourceTable = "HR Job Applications";
    SourceTableView = where(Qualified = const(true));

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Application No";Rec."Application No")
                {
                }
                field("First Name";Rec."First Name")
                {
                }
                field("Middle Name";Rec."Middle Name")
                {
                }
                field("Last Name";Rec."Last Name")
                {
                }
                field("Job Applied For";Rec."Job Applied For")
                {
                }
                field(Qualified; Rec.Qualified)
                {
                }
                field("Date of Interview";Rec."Date of Interview")
                {
                }
                field("From Time";Rec."From Time")
                {
                }
                field("To Time";Rec."To Time")
                {
                }
                field(Venue; Rec.Venue)
                {
                }
                field("Interview Type";Rec."Interview Type")
                {
                }
            }
        }
    }

    actions
    {
    }
}






