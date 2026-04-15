//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50478 "HR Job Applications Factbox"
{
    ApplicationArea = All;
    PageType = ListPart;
    SourceTable = "HR Job Applications";

    layout
    {
        area(content)
        {
            field(GeneralInfo; GeneralInfo)
            {
                Style = Strong;
                StyleExpr = true;
            }
            field("Application No";Rec."Application No")
            {
            }
            field("Date Applied";Rec."Date Applied")
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
            field(Qualified; Rec.Qualified)
            {
            }
            field("Interview Invitation Sent";Rec."Interview Invitation Sent")
            {
            }
            field("ID Number";Rec."ID Number")
            {
            }
            field(PersonalInfo; PersonalInfo)
            {
                Style = Strong;
                StyleExpr = true;
            }
            field(Status; Rec.Status)
            {
            }
            field(Age; Rec.Age)
            {
            }
            field("Marital Status";Rec."Marital Status")
            {
            }
            field(CommunicationInfo; CommunicationInfo)
            {
                Style = Strong;
                StyleExpr = true;
            }
            field("Cell Phone Number";Rec."Cell Phone Number")
            {
                ExtendedDatatype = PhoneNo;
            }
            field("E-Mail";Rec."E-Mail")
            {
                ExtendedDatatype = EMail;
            }
            field("Work Phone Number";Rec."Work Phone Number")
            {
                ExtendedDatatype = PhoneNo;
            }
        }
    }

    actions
    {
    }

    var
        GeneralInfo: label 'General Applicant Information';
        PersonalInfo: label 'Personal Infomation';
        CommunicationInfo: label 'Communication Information';
}






