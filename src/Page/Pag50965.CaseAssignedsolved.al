//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50965 "Case Assigned  solved"
{
    ApplicationArea = All;
    CardPageID = "Cases solved card";
    DeleteAllowed = false;
    Editable = false;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "Cases Management";
    SourceTableView = where(Status = filter(Resolved));

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
                field("Date of Complaint";Rec."Date of Complaint")
                {
                }
                field("Recommended Action";Rec."Recommended Action")
                {
                }
                field("Case Description";Rec."Case Description")
                {
                }
                field("Case Resolution Details";Rec."Case Resolution Details")
                {
                }
                field("Date To Settle Case";Rec."Date To Settle Case")
                {
                }
                field(Recomendations; Rec.Recomendations)
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
            }
        }
        area(factboxes)
        {
            part(Control6;"Member Statistics FactBox")
            {
                Caption = 'BOSA Statistics FactBox';
                SubPageLink = "No." = field("Member No");
            }
            part(Control5;"FOSA Statistics FactBox")
            {
                SubPageLink = "No." = field("FOSA Account.");
            }
            part(Control4;"Loans Sub-Page List")
            {
                Caption = 'Loans Details';
                SubPageLink = "Client Code" = field("Member No");
            }
        }
    }

    actions
    {
    }

    trigger OnInit()
    begin
        //SETRANGE("Resource Assigned",USERID);
    end;

    trigger OnOpenPage()
    begin
        //SETRANGE("Resource Assigned",USERID);
    end;
}






