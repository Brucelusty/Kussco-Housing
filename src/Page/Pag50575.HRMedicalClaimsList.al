//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50575 "HR Medical Claims List"
{
    ApplicationArea = All;
    CardPageID = "HR Medical Claim Card";
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "HR Medical Claims";
    SourceTableView = where(Posted = filter(false));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Claim No";Rec."Claim No")
                {
                }
                field("Member No";Rec."Member No")
                {
                }
                field("Claim Type";Rec."Claim Type")
                {
                }
                field("Claim Date";Rec."Claim Date")
                {
                }
                field(Dependants; Rec.Dependants)
                {
                }
                field("Patient Name";Rec."Patient Name")
                {
                }
                field("Document Ref";Rec."Document Ref")
                {
                }
                field("Date of Service";Rec."Date of Service")
                {
                }
                field("Attended By";Rec."Attended By")
                {
                }
                field("Amount Charged";Rec."Amount Charged")
                {
                }
                field(Comments; Rec.Comments)
                {
                }
            }
        }
    }

    actions
    {
    }

    var
        Dependants: Record "HR Employee Kin";
}






