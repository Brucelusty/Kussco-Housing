//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50964 "Case Assigned  list"
{
    ApplicationArea = All;
    CardPageID = "Cases Assigned card";
    DeleteAllowed = false;
    Editable = false;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "Cases Management";
    SourceTableView = where(Status = filter(Escalated));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Case Number";Rec."Case Number")
                {
                }
                field("Member No";Rec."Member No")
                {
                }
                field("Member Name";Rec."Member Name")
                {
                }
                field("ID No";Rec."ID No")
                {
                }
                field(Gender; Rec.Gender)
                {
                }
                field("Date of Complaint";Rec."Date of Complaint")
                {
                }
                field("Recommended Action";Rec."Recommended Action")
                {
                }
                field("Case Description";Rec."Case Description")
                {
                }
                field("Action Taken";Rec."Action Taken")
                {
                }
                field("Date To Settle Case";Rec."Date To Settle Case")
                {
                }
                field("Document Link";Rec."Document Link")
                {
                }
                field("Solution Remarks";Rec."Solution Remarks")
                {
                }
                field(Comments; Rec.Comments)
                {
                }
                field("Body Handling The Complaint";Rec."Body Handling The Complaint")
                {
                }
                field(Recomendations; Rec.Recomendations)
                {
                }
                field(Implications; Rec.Implications)
                {
                }
                field("Support Documents";Rec."Support Documents")
                {
                }
                field(Status; Rec.Status)
                {
                }
                field("Resource Assigned";Rec."Resource Assigned")
                {
                }
                field(Selected; Rec.Selected)
                {
                }
                field("Responsibility Center";Rec."Responsibility Center")
                {
                }
                field("Member No.";Rec."Member No.")
                {
                }
                field("FOSA Account.";Rec."FOSA Account.")
                {
                }
                field("Account Name.";Rec."Account Name.")
                {
                }
                field("Loan No";Rec."Loan No")
                {
                }
            }
        }
        area(factboxes)
        {
            part(Control7;"Member Statistics FactBox")
            {
                Caption = 'BOSA Statistics FactBox';
                SubPageLink = "No." = field("Member No");
                Visible=false;
            }
            part(Control6;"FOSA Statistics FactBox")
            {
                SubPageLink = "No." = field("FOSA Account.");
                Visible=false;
            }
            part(Control5;"Loans Sub-Page List")
            {
                Caption = 'Loans Details';
                SubPageLink = "Client Code" = field("Member No");
            }
        }
    }

    actions
    {
        area(creation)
        {
        
        }
    }

    trigger OnInit()
    begin
        Rec.SetRange("Resource Assigned", UserId);
    end;

    trigger OnOpenPage()
    begin
        Rec.SetRange("Resource Assigned", UserId);
    end;
}






