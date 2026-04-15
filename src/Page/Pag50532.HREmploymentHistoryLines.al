//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50532 "HR Employment History Lines"
{
    ApplicationArea = All;
    Caption = 'Employment History Lines';
    PageType = ListPart;
    SourceTable = "HR Employment History";

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field("Company Name";Rec."Company Name")
                {
                }
                field(From; Rec.From)
                {
                }
                field("To Date";Rec."To Date")
                {
                }
                field("Job Title";Rec."Job Title")
                {
                }
                field("Key Experience";Rec."Key Experience")
                {
                }
                field("Salary On Leaving";Rec."Salary On Leaving")
                {
                }
                field("Postal Address";Rec."Postal Address")
                {
                }
                field("Address 2";Rec."Address 2")
                {
                }
                field("Reason For Leaving";Rec."Reason For Leaving")
                {
                }
                field(Comment; Rec.Comment)
                {
                }
            }
        }
    }

    actions
    {
    }
}






