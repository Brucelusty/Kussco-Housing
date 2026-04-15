page 50092 "Inactive Employees"
{
    ApplicationArea = All;
    Caption = 'Inactive Employees';
    CardPageID = "HR Employee Card";
    PageType = List;
    PromotedActionCategories = 'New,Process,Report,Employee';
    SourceTable = "HR Employees";
    SourceTableView = where(Status = filter(<> Active));

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                Editable = false;
                field("No."; Rec."No.")
                {
                    StyleExpr = true;
                }
                field("First Name"; Rec."First Name")
                {
                    Enabled = false;
                }
                field("Middle Name"; Rec."Middle Name")
                {
                    Enabled = false;
                }
                field("Last Name"; Rec."Last Name")
                {
                    Enabled = false;
                }
                field("Employee UserID"; Rec."Employee UserID")
                {
                }
                field("Job Title"; Rec."Job Title")
                {
                    Enabled = false;
                }
                field(Travelaccountno; Rec.Travelaccountno)
                {
                    Caption = 'Imprest Account No';
                }
                field("Portal Password"; Rec."Portal Password")
                {
                    Visible = false;
                }
                field("Company E-Mail"; Rec."Company E-Mail")
                {
                    Enabled = false;
                }
                field("Cellular Phone Number"; Rec."Cellular Phone Number")
                {
                }
                field(Status; Rec.Status)
                {
                }
            }
        }
        area(factboxes)
        {
            part(Control1102755002; "HR Employees Factbox")
            {
                SubPageLink = "No." = field("No.");
            }
            systempart(Control1102755003; Outlook)
            {
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Employee)
            {
                Caption = 'Employee';
                action(Card)
                {
                    Caption = 'Card';
                    Image = Card;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    RunObject = Page "HR Employee Card";
                    RunPageLink = "No." = field("No.");
                }
                action("Kin/Beneficiaries")
                {
                    Caption = 'Kin/Beneficiaries';
                    Image = Relatives;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    RunObject = Page "HR Employee Kin SF";
                    RunPageLink = "Employee Code" = field("No.");
                }
                action("Assigned Assets")
                {
                    Caption = 'Assigned Assets';
                    Image = ResourceJournal;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    RunObject = Page "Fixed Asset List";
                    RunPageLink = "Responsible Employee" = field("No.");
                }
                action("HR Leave Allocation")
                {
                    Caption = 'HR Leave Allocation';
                    Image = ChangeDates;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    RunObject = Report "HR Leave Adjustment";
                }
                action("HR Leave Journal Lines")
                {
                    Caption = 'HR Leave Journal Lines';
                    Image = Journals;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    RunObject = Page "HR Leave Journal Lines";
                }
                action("HR Job Vacancy Report")
                {
                    Caption = 'HR Job Vacancy Report';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    RunObject = Report "HR Job Vacancy Report";
                }
                action("HR Employee List")
                {
                    Caption = 'HR Employee List';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    RunObject = Report "HR Employee List";
                }
                action("HR Employee PIF")
                {
                    Caption = 'HR Employee PIF';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    RunObject = Report "HR Employee PIF";
                }
                action(" HR Leave Applications ")
                {
                    Caption = ' HR Leave Applications ';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    RunObject = Report "HR Leave Applications List";
                }
                action("HR Leave Liability Report")
                {
                    Caption = 'HR Leave Liability Report';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    RunObject = Report "HR Leave Balance Report";
                }
                action("Leave Planner")
                {
                    Caption = 'Leave Planner';
                    Image = ResourceJournal;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    RunObject = Page "Leave Planner";
                }
                action("Timesheet List")
                {
                    Caption = 'Timesheet List';
                    Image = ResourceJournal;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    RunObject = Page "Timesheet List";
                }
            }
        }
    }
    trigger OnOpenPage()
    begin
        /*HREmp.RESET;
        HREmp.SETRANGE(HREmp."User ID",USERID);
        IF HREmp.GET THEN*/
        //SETRANGE("User ID",USERID)
        //ELSE
        //user id may not be the creator of the doc
        //rec.SETRANGE(rec."Employee UserID", USERID);

    end;

    var
        HREmp: Record "HR Employees";
        EmployeeFullName: Text;
}



