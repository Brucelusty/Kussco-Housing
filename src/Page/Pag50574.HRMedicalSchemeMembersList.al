//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50574 "HR Medical Scheme Members List"
{
    ApplicationArea = All;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "HR Insurance Scheme Members";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Scheme No";Rec."Scheme No")
                {
                }
                field("Employee No";Rec."Employee No")
                {
                }
                field("First Name";Rec."First Name")
                {
                }
                field("Last Name";Rec."Last Name")
                {
                }
                field(Designation; Rec.Designation)
                {
                }
                field(Department; Rec.Department)
                {
                    Visible = false;
                }
                field("Scheme Join Date";Rec."Scheme Join Date")
                {
                }
                field("Out-Patient Limit";Rec."Out-Patient Limit")
                {
                }
                field("In-patient Limit";Rec."In-patient Limit")
                {
                }
                field("Maximum Cover";Rec."Maximum Cover")
                {
                }
                field("Cumm.Amount Spent";Rec."Cumm.Amount Spent")
                {
                }
                field("No Of Dependants";Rec."No Of Dependants")
                {
                }
            }
        }
    }

    actions
    {
        area(reporting)
        {
            action(Dependants)
            {
                Caption = 'Dependants';
                Image = Relatives;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                RunObject = Page "HR Employee Kin";
                RunPageLink = "No." = field("Employee No");
            }
        }
    }
}






