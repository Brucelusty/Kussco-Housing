//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50549 "HR Job Applications Card"
{
    ApplicationArea = All;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Reports,Functions,Other Details';
    SourceTable = "HR Job Applications";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Application No"; Rec."Application No")
                {
                    Editable = false;
                    Importance = Promoted;
                }
                field("Date Applied"; Rec."Date Applied")
                {
                    Editable = false;
                    Importance = Promoted;
                }
                field("First Name"; Rec."First Name")
                {
                    Importance = Promoted;
                }
                field("Middle Name"; Rec."Middle Name")
                {
                    Importance = Promoted;
                }
                field("Last Name"; Rec."Last Name")
                {
                    Importance = Promoted;
                }
                field(Initials; Rec.Initials)
                {
                }
                field("First Language (R/W/S)"; Rec."First Language (R/W/S)")
                {
                    Caption = '1st Language (R/W/S)';
                    Importance = Promoted;
                }
                field("First Language Read"; Rec."First Language Read")
                {
                    Caption = '1st Language Read';
                }
                field("First Language Write"; Rec."First Language Write")
                {
                    Caption = '1st Language Write';
                }
                field("First Language Speak"; Rec."First Language Speak")
                {
                    Caption = '1st Language Speak';
                }
                field("Second Language (R/W/S)"; Rec."Second Language (R/W/S)")
                {
                    Caption = '2nd Language (R/W/S)';
                    Importance = Promoted;
                }
                field("Second Language Read"; Rec."Second Language Read")
                {
                }
                field("Second Language Write"; Rec."Second Language Write")
                {
                }
                field("Second Language Speak"; Rec."Second Language Speak")
                {
                }
                field("Additional Language"; Rec."Additional Language")
                {
                }
                field("Applicant Type"; Rec."Applicant Type")
                {
                    Editable = true;
                    Enabled = true;
                    Style = Strong;
                    StyleExpr = true;
                }
                field("Employee No"; Rec."Employee No")
                {
                    Caption = 'Internal';
                    Editable = true;
                }
                field("ID Number"; Rec."ID Number")
                {
                }
                field(Gender; Rec.Gender)
                {
                    Importance = Promoted;
                }
                field(Citizenship; Rec.Citizenship)
                {
                }
                field("Country Details"; Rec."Citizenship Details")
                {
                    Editable = false;
                }
                field("Employee Requisition No"; Rec."Employee Requisition No")
                {
                    Caption = 'Application Reff No.';
                    Importance = Promoted;
                }
                field("Job Applied For"; Rec."Job Applied For")
                {
                    Caption = 'Position Applied For';
                    Editable = true;
                    Enabled = true;
                    Importance = Promoted;
                }
                field(Expatriate; Rec.Expatriate)
                {
                }
                field("Interview Invitation Sent"; Rec."Interview Invitation Sent")
                {
                    Editable = false;
                    Style = StrongAccent;
                    StyleExpr = true;
                }
            }
            group(Personal)
            {
                Caption = 'Personal';
                field(Status; Rec.Status)
                {
                    Importance = Promoted;
                }
                field("Marital Status"; Rec."Marital Status")
                {
                    Importance = Promoted;
                }
                field("Ethnic Origin"; Rec."Ethnic Origin")
                {
                }
                field(Disabled; Rec.Disabled)
                {
                }
                field("Health Assesment?"; Rec."Health Assesment?")
                {
                }
                field("Health Assesment Date"; Rec."Health Assesment Date")
                {
                }
                field("Date Of Birth"; Rec."Date Of Birth")
                {

                    trigger OnValidate()
                    begin

                        if Rec."Date Of Birth" >= Today then begin
                            Error('Invalid Entry');
                        end;
                        DAge := Dates.DetermineAge(Rec."Date Of Birth", Today);
                        Rec.Age := DAge;
                    end;
                }
                field(Age; Rec.Age)
                {
                    Editable = false;
                    Importance = Promoted;
                }
            }
            group(Communication)
            {
                Caption = 'Communication';
                field("Home Phone Number"; Rec."Home Phone Number")
                {
                    Importance = Promoted;
                }
                field("Postal Address"; Rec."Postal Address")
                {
                    Importance = Promoted;
                }
                field("Postal Address2"; Rec."Postal Address2")
                {
                    Caption = 'Postal Address 2';
                }
                field("Postal Address3"; Rec."Postal Address3")
                {
                    Caption = 'Postal Address 3';
                }
                field("Post Code"; Rec."Post Code")
                {
                }
                field("Residential Address"; Rec."Residential Address")
                {
                }
                field("Residential Address2"; Rec."Residential Address2")
                {
                }
                field("Residential Address3"; Rec."Residential Address3")
                {
                }
                field("Post Code2"; Rec."Post Code2")
                {
                    Caption = 'Post Code 2';
                }
                field("Cell Phone Number"; Rec."Cell Phone Number")
                {
                    Importance = Promoted;
                }
                field("Work Phone Number"; Rec."Work Phone Number")
                {
                }
                field("Ext."; Rec."Ext.")
                {
                }
                field("E-Mail"; Rec."E-Mail")
                {
                    Importance = Promoted;
                }
                field("Fax Number"; Rec."Fax Number")
                {
                }
            }
        }
        area(factboxes)
        {
            part(Control1102755009; "HR Job Applications Factbox")
            {
                SubPageLink = "Application No" = field("Application No");
            }
            systempart(Control1102755008; Outlook)
            {
            }
            systempart(Control3; Links)
            {
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("Other Details")
            {
                Caption = 'Other Details';
                action(Qualifications)
                {
                    Caption = 'Qualifications';
                    Image = QualificationOverview;
                    Promoted = true;
                    PromotedCategory = Category5;
                    RunObject = Page "HR Applicant Qualifications";
                    RunPageLink = "Application No" = field("Application No");
                }
                action("Page HR Training Needs Card")
                {
                    Caption = 'Training Need';
                    Promoted = true;
                    PromotedCategory = Category5;
                    RunObject = Page "HR Training Needs Card";
                }
                action(Referees)
                {
                    Caption = 'Referees';
                    Image = ContactReference;
                    Promoted = true;
                    PromotedCategory = Category5;
                    RunObject = Page "HR Applicant Referees";
                    RunPageLink = "Job Application No" = field("Application No");
                }
                action(Hobbies)
                {
                    Caption = 'Hobbies';
                    Image = Holiday;
                    Promoted = true;
                    PromotedCategory = Category5;
                    RunObject = Page "HR Applicant Hobbies";
                    RunPageLink = "Bank Code" = field("Application No");
                }
                action("Generate Offer Letter")
                {
                    Caption = 'Generate Offer Letter';
                    Promoted = true;
                    //  RunObject = Report UnknownReport51516640;
                }
                action("Upload Attachments")
                {
                    Caption = 'Upload Attachments';
                    Image = Attachments;
                    Promoted = true;
                    PromotedCategory = Category6;
                    RunObject = Page "HR Employee Attachments SF";
                    RunPageLink = "Employee No" = field("Application No");
                    Visible = false;
                }

            }
            group("&Functions")
            {
                Caption = '&Functions';
                action("Qualify Applicant?")
                {
                    Caption = 'Qualify Applicant?';
                    Image = SendMail;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    begin
                        Rec.TestField("Job Applied For");
                        if Confirm('Mark Applicant as qualified?', true, false) = true then begin
                            Rec.Qualified := true;
                            Rec."Qualification Status":=Rec."Qualification Status"::Qualified;
                            Rec.Modify();
                        end;
                    end;
                }
                action("&Send Interview Invitation")
                {
                    Caption = '&Send Interview Invitation';
                    Image = SendMail;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    begin
                        Rec.TestField(Qualified);


                        HRJobApplications.SetFilter(HRJobApplications."Application No", Rec."Application No");
                       // Report.run(172639, false, false, HRJobApplications);
                       Message('Intereview invitation sent.');
                    end;
                }
                action("&Upload to Employee Card")
                {
                    Caption = '&Upload to Employee Card';
                    Image = ImportDatabase;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    begin
                        if Rec."Employee No" = '' then begin
                            //IF NOT CONFIRM('Are you sure you want to Upload Applicants information to the Employee Card',FALSE) THEN EXIT;
                            HRJobApplications.SetFilter(HRJobApplications."Application No", Rec."Application No");
                            Report.Run(55600, true, false, HRJobApplications);
                        end else begin
                            Message('This applicants information already exists in the employee card');
                        end;
                    end;
                }
                action("&Print")
                {
                    Caption = '&Print';
                    Image = PrintReport;
                    Promoted = true;
                    PromotedCategory = Category4;
                    Visible = false;

                    trigger OnAction()
                    begin
                        HRJobApplications.Reset;
                        HRJobApplications.SetRange(HRJobApplications."Application No", Rec."Application No");
                        if HRJobApplications.Find('-') then
                            Report.Run(55523, true, true, HRJobApplications);
                    end;
                }
            }
        }
    }

    var
        HRJobApplications: Record "HR Job Applications";
        // SMTP: Codeunit "SMTP Mail";
        HREmailParameters: Record "HR E-Mail Parameters";
        Employee: Record "HR Employees";
        Text19064672: label 'Shortlisting Summary';
        Dates: Codeunit "HR Datess";
        DAge: Text[100];
}






