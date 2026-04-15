//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50522 "HR Applicant Qualifications"
{
    ApplicationArea = All;
    Caption = 'Applicant Qualifications';
    PageType = List;
    UsageCategory = Lists;
    SaveValues = true;
    ShowFilter = true;
    SourceTable = "HR Applicant Qualifications";

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field("Qualification Type";Rec."Qualification Type")
                {
                    Importance = Promoted;
                }
                field("Qualification Code";Rec."Qualification Code")
                {
                }
                field("Qualification Description";Rec."Qualification Description")
                {
                    Importance = Promoted;
                }
                field("From Date";Rec."From Date")
                {
                }
                field("To Date";Rec."To Date")
                {
                }
                field(Type; Rec.Type)
                {
                }
                field("Institution/Company";Rec."Institution/Company")
                {
                    Importance = Promoted;
                }
                field("Score ID";Rec."Score ID")
                {
                    Importance = Promoted;
                }
            }
        }
    }

    actions
    {
    }
}






