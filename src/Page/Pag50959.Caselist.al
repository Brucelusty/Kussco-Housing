//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50959 "Case list"
{
    ApplicationArea = All;
    CardPageID = "Cases Card";
    DeleteAllowed = false;
    Editable = false;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "Cases Management";
    SourceTableView = where(Status = filter(Open));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Case Number";Rec."Case Number")
                {
                }
                field("Date of Complaint";Rec."Date of Complaint")
                {
                }
                field("Type of cases";Rec."Type of cases")
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
                field("Recommended Action";Rec."Recommended Action")
                {
                }
                field("Case Description";Rec."Case Description")
                {
                }
                field("Caller Reffered To";Rec."Caller Reffered To")
                {
                    Caption = 'Case Escalated to:';
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
                field("Case Solved";Rec."Case Solved")
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
                field("Mode of Lodging the Complaint";Rec."Mode of Lodging the Complaint")
                {
                }
                field("Resource Assigned";Rec."Resource Assigned")
                {
                }
                field(Selected; Rec.Selected)
                {
                }
                field("Closed By";Rec."Closed By")
                {
                }
                field("Responsibility Center";Rec."Responsibility Center")
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
            }
            part(Control6;"FOSA Statistics FactBox")
            {
                SubPageLink = "No." = field("FOSA Account.");
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Recall Case")
            {
                Image = ReOpen;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    Rec.TestField("Recall Reason");
                    if ObjGenEnquiry.Get(Rec."Initiated Enquiry No") then begin
                        if ObjGenEnquiry."Captured By" <> UserId then begin
                            Error('You can only recall an issue you have initiated');
                        end;
                    end;

                    if Confirm('Confirm you want to recall this case', false) = true then begin
                        ObjCaseManagement.Reset;
                        ObjCaseManagement.SetRange(ObjCaseManagement."Case Number", Rec."Case Number");
                        if ObjCaseManagement.FindSet then begin
                            ObjCaseManagement.Status := ObjCaseManagement.Status::Recalled;
                            ObjCaseManagement.Modify;
                        end;

                        if ObjGenEnquiry.Get(Rec."Initiated Enquiry No") then begin
                            ObjGenEnquiry.Status := ObjGenEnquiry.Status::New;
                            ObjGenEnquiry.Send := false;
                            ObjGenEnquiry.Modify;
                        end;
                    end;
                end;
            }
        }
    }

    var
        ObjCaseManagement: Record "Cases Management";
        ObjGenEnquiry: Record "General Equiries.";
}






