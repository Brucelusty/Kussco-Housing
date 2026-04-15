//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50166 "HR Employee List"
{
    ApplicationArea = All;
    CardPageID = "HR Employee Card";
    PageType = List;
    UsageCategory = Lists;
    PromotedActionCategories = 'New,Process,Report,Employee';
    SourceTable = "HR Employees";
    SourceTableView = where(Status = const(Active),
                            IsCommette = const(false),
                            IsBoard = const(false));

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                Editable = false;
                field("No.";Rec."No.")
                {
                    StyleExpr = true;
                }
                field("First Name";Rec."First Name")
                {
                    Enabled = false;
                }
                field("Middle Name";Rec."Middle Name")
                {
                    Enabled = false;
                }
                field("Last Name";Rec."Last Name")
                {
                    Enabled = false;
                }
                field("Job Title";Rec."Job Title")
                {
                    Enabled = false;
                }
                field("User ID";Rec."User ID")
                {
                }
                field("Company E-Mail";Rec."Company E-Mail")
                {
                    Enabled = false;
                }
                field("Cellular Phone Number";Rec."Cellular Phone Number")
                {
                }
            }
        }
        area(factboxes)
        {
            // systempart(Control1102755002;"HR Employees Factbox")
            // {
            //     //SubPageLink = "No."=field("No.");
            // }
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
                    RunObject = Page "HR Employee Kin";
                    RunPageLink = "No." = field("No.");
                }
                action("Employee Attachments")
                {
                    Caption = 'Employee Attachments';
                    Image = Attach;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    RunObject = Page "HR Employee Attachments";
                    RunPageLink = "No." = field("No.");
                    Visible = false;
                }
                action("Employement History")
                {
                    Caption = 'Employement History';
                    Image = History;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    RunObject = Page "HR Employment History";
                    RunPageLink = "No." = field("No.");
                }
                action("Employee Qualifications")
                {
                    Caption = 'Employee Qualifications';
                    Image = QualificationOverview;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    RunObject = Page "HR Employee Qualifications";
                    RunPageLink = "No." = field("No.");
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
            }
        }
    }

    trigger OnOpenPage()
    begin
        // HREmp.Reset;
        // HREmp.SetRange(HREmp."User ID", UserId);
        // if HREmp.Get then
        //     Rec.SetRange("User ID", HREmp."User ID")
        // else
        //     //user id may not be the creator of the doc
        //     Rec.SetRange("User ID", UserId);
        if userSetup.Get(UserId) then begin
            // if (userSetup.Leave = false) or then begin
            if (userSetup.Leave = false) then begin
                Rec.SetRange(Rec."User ID", UserId);
            end;
        end;
    end;

    trigger OnAfterGetCurrRecord()
    var
        myInt: Integer;
    begin
        if userSetup.Get(UserId) then begin
            if userSetup.Leave = false then begin
                Rec.SetRange(Rec."User ID", UserId);
            end;
        end;
    end;

    trigger OnAfterGetRecord()
    var
        myInt: Integer;
    begin
        if userSetup.Get(UserId) then begin
            if userSetup.Leave = false then begin
                Rec.SetRange(Rec."User ID", UserId);
            end;
        end;
    end;

    var
        HREmp: Record "HR Employees";
        EmployeeFullName: Text;
        userSetup: Record "User Setup";
}






