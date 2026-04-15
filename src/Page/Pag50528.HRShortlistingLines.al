//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50528 "HR Shortlisting Lines"
{
    ApplicationArea = All;
    Caption = 'Shorlisted Candidates';
    Editable = false;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "HR Shortlisted Applicants";

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field(Qualified; Rec.Qualified)
                {
                    Caption = 'Qualified';

                    trigger OnValidate()
                    begin
                        Rec."Manual Change" := true;
                        Rec.Modify;
                    end;
                }
                field("Job Application No"; Rec."Job Application No")
                {
                }
                field("First Name"; Rec."First Name")
                {
                }
                field("Middle Name"; Rec."Middle Name")
                {
                }
                field("Last Name"; Rec."Last Name")
                {
                }
                field("ID No"; Rec."ID No")
                {
                }
                field("Stage Score"; Rec."Stage Score")
                {
                }
                field(Position; Rec.Position)
                {
                }
                field(Employ; Rec.Employ)
                {
                    Caption = 'Employed';
                }
                field("Reporting Date"; Rec."Reporting Date")
                {
                }
                field("Manual Change"; Rec."Manual Change")
                {
                    Caption = 'Manual Change';
                }
            }
        }
    }

    actions
    {
    }

    var
        MyCount: Integer;


    procedure GetApplicantNo() AppicantNo: Code[20]
    begin
        //AppicantNo:=Applicant;
    end;
}






