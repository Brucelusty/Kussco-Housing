//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50516 "HR Disciplinary Cases SF"
{
    ApplicationArea = All;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "HR Disciplinary Cases";

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field("Case Number";Rec."Case Number")
                {
                }
                field("Date of Complaint";Rec."Date of Complaint")
                {
                }
                field(Status; Rec.Status)
                {
                }
                field(Selected; Rec.Selected)
                {
                }
                field("Type of Disciplinary Case";Rec."Type of Disciplinary Case")
                {
                }
                field("Case Description";Rec."Case Description")
                {
                }
                field("Case Discussion";Rec."Case Discussion")
                {
                }
                field("Mode of Lodging the Complaint";Rec."Mode of Lodging the Complaint")
                {
                }
                field(Accuser; Rec.Accuser)
                {
                }
                field("Witness #1";Rec."Witness #1")
                {
                }
                field("Witness #2";Rec."Witness #2")
                {
                }
                field("Recommended Action";Rec."Recommended Action")
                {
                }
                field("Action Taken";Rec."Action Taken")
                {
                }
                field("Support Documents";Rec."Support Documents")
                {
                }
                field("Policy Guidlines In Effect";Rec."Policy Guidlines In Effect")
                {
                }
                field(Recomendations; Rec.Recomendations)
                {
                }
                field("HR/Payroll Implications";Rec."HR/Payroll Implications")
                {
                }
                field("Disciplinary Remarks";Rec."Disciplinary Remarks")
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
}






