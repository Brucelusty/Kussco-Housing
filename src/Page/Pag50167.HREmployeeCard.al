//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50167 "HR Employee Card"
{
    ApplicationArea = All;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Report,Print,Functions,Employee,Attachments,Payment Info';
    SourceTable = "HR Employees";

    layout
    {
        area(content)
        {
            group("General Details")
            {
                Caption = 'General Details';
                field("Contract Type"; Rec."Contract Type")
                {
                    Importance = Promoted;
                    Visible=false;
                }
                field("No."; Rec."No.")
                {
                    AssistEdit = true;
                    Importance = Promoted;

                    trigger OnAssistEdit()
                    begin
                        // IF AssistEdit() THEN
                        CurrPage.Update;
                    end;
                }
                field(Title; Rec.Title)
                {
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
                field("PIN No."; Rec."PIN No.")
                {
                    Importance = Promoted;
                }
                field("NSSF No."; Rec."NSSF No.")
                {
                    Importance = Promoted;
                }
                field("NHIF No."; Rec."NHIF No.")
                {
                    Importance = Promoted;
                }
                field("ID Number"; Rec."ID Number")
                {
                    Importance = Promoted;
                }

                field(Citizenship; Rec.Citizenship)
                {
                }
                field("Citizenship Text"; "Citizenship Text")
                {
                    Caption = 'Country / Region Code';
                    Editable = false;
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ShowMandatory = true;
                    trigger OnValidate()
                    var
                        Responsibilitycenter: Record "Responsibility Center";
                    begin
                        Responsibilitycenter.Reset();
                        Responsibilitycenter.SetRange(Responsibilitycenter.Code, Rec."Responsibility Center");
                        if Responsibilitycenter.FindFirst() then
                            Rec."Responsibility Center name" := Responsibilitycenter.name;
                    end;

                }
                field("Responsibility Center name"; Rec."Responsibility Center name") { Editable = false; }
                field(Office; Rec.Office)
                {
                    Caption = 'Department';
                }
                field("HR Manager";Rec."HR Manager")
                {
                    // Caption = 'Department';
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    Visible = false;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                }
                field("Post Code"; Rec."Post Code")
                {
                }
                field("Postal Address"; Rec."Postal Address")
                {
                }
                field(City; Rec.City)
                {
                }
                field(County; Rec.County)
                {
                }
                field(Picture; Rec.Picture)
                {
                }
                field("Last Date Modified"; Rec."Last Date Modified")
                {
                }
                field("User ID"; Rec."User ID")
                {
                    Importance = Promoted;

                    trigger OnValidate()
                    begin
                        SupervisorNames := GetSupervisor(Rec."User ID");
                    end;
                }

                field(SupervisorNames; SupervisorNames)
                {
                    Caption = 'Supervisor ';
                    Editable = false;
                }
                field("Supervisor ID";Rec."Supervisor ID")
                {
                    Caption = 'Supervisor ID';
                    Editable = false;
                }
                field(Status; Rec.Status)
                {
                    Editable = true;
                    // Importance = Promoted;
                    // Style = Strong;
                    // StyleExpr = true;
                }

                field(Supervisor; Rec.Supervisor)
                {
                    Caption = 'Is Manager';
                }

                field("Posting Group"; Rec."Posting Group")
                {
                }
            }
            group("Communication Details")
            {
                Caption = 'Communication Details';
                field("Cell Phone Number"; Rec."Cell Phone Number")
                {
                    ExtendedDatatype = PhoneNo;
                    Importance = Promoted;
                }
                field("Home Phone Number"; Rec."Home Phone Number")
                {
                    ExtendedDatatype = PhoneNo;
                    Importance = Promoted;
                }

                field("Work Phone Number"; Rec."Work Phone Number")
                {
                    ExtendedDatatype = PhoneNo;
                }

                field("E-Mail"; Rec."E-Mail")
                {
                    Caption = 'Personal E-Mail';
                    ExtendedDatatype = EMail;
                }
                field("Company E-Mail"; Rec."Company E-Mail")
                {
                    ExtendedDatatype = EMail;
                    Importance = Promoted;
                }
            }
            group("Personal Details")
            {
                Caption = 'Personal Details';
                field(Gender; Rec.Gender)
                {
                    Importance = Promoted;
                }
                field("Marital Status"; Rec."Marital Status")
                {
                    Importance = Promoted;
                }
                field(Signature; Rec.Signature)
                {
                }
                field("First Language (R/W/S)"; Rec."First Language (R/W/S)")
                {
                    Importance = Promoted;
                    Visible = false;
                }
                field("First Language Read"; Rec."First Language Read")
                {
                    Visible = false;
                }
                field("First Language Write"; Rec."First Language Write")
                {
                    Visible = false;
                }
                field("First Language Speak"; Rec."First Language Speak")
                {
                    Visible = false;
                }
                field("Second Language (R/W/S)"; Rec."Second Language (R/W/S)")
                {
                    Importance = Promoted;
                    Visible = false;
                }
                field("Second Language Read"; Rec."Second Language Read")
                {
                    Visible = false;
                }
                field("Second Language Write"; Rec."Second Language Write")
                {
                    Visible = false;
                }
                field("Second Language Speak"; Rec."Second Language Speak")
                {
                    Visible = false;
                }
                field("Additional Language"; Rec."Additional Language")
                {
                    Visible = false;
                }
                field("Vehicle Registration Number"; Rec."Vehicle Registration Number")
                {
                    Importance = Promoted;
                }
                field("Number Of Dependants"; Rec."Number Of Dependants")
                {
                }
                field(Disabled; Rec.Disabled)
                {
                }
                field("Health Assesment?"; Rec."Health Assesment?")
                {
                }
                field("Medical Scheme No."; Rec."Medical Scheme No.")
                {
                }
                field("Medical Scheme Head Member"; Rec."Medical Scheme Head Member")
                {
                }
                field("Medical Scheme Name"; Rec."Medical Scheme Name")
                {
                }
                field("Medical Out-Patient Limit"; Rec."Medical Out-Patient Limit")
                {
                }
                field("Medical In-Patient Limit"; Rec."Medical In-Patient Limit")
                {
                }
                field("Medical Maximum Cover"; Rec."Medical Maximum Cover")
                {
                }
                field("Medical No Of Dependants"; Rec."Medical No Of Dependants")
                {
                }
                field("Cause of Inactivity Code"; Rec."Cause of Inactivity Code")
                {
                }
                field("Health Assesment Date"; Rec."Health Assesment Date")
                {
                }
            }
            group("Bank Details")
            {
                Caption = 'Bank Details';
                field("Main Bank"; Rec."Main Bank")
                {
                    Importance = Promoted;
                }
                field("<Bank Code>"; Rec."Bank Code")
                {
                    Caption = 'Bank Code';
                }
                field("Branch Bank"; Rec."Branch Bank")
                {
                    Importance = Promoted;
                }
                field("<Branch Code>"; Rec."Branch Code")
                {
                    Caption = 'Branch Code';
                }
                field("Bank Account Number"; Rec."Bank Account Number")
                {
                    Importance = Promoted;
                }
            }
            group("Important Dates")
            {
                Caption = 'Important Dates';
                field("Date Of Birth"; Rec."Date Of Birth")
                {
                    Importance = Promoted;

                    trigger OnValidate()
                    begin
                        if Rec."Date Of Birth" >= Today then begin
                            Error('Invalid Entry');
                        end;
                        DAge := Dates.DetermineAge(Rec."Date Of Birth", Today);
                    end;
                }
                field(DAge; DAge)
                {
                    Caption = 'Age';
                    Editable = false;
                    Enabled = false;
                    Importance = Promoted;
                }
                field("Date Of Join"; Rec."Date Of Join")
                {
                    Importance = Promoted;
                    Visible = true;

                    trigger OnValidate()
                    begin
                        DService := Dates.DetermineAge(Rec."Date Of Join", Today);
                    end;
                }
                field(DService; DService)
                {
                    Caption = 'Length of Service';
                    Editable = false;
                    Enabled = false;
                }
                field("End Of Probation Date"; Rec."End Of Probation Date")
                {
                }
                field("Pension Scheme Join Date"; Rec."Pension Scheme Join Date")
                {

                    trigger OnValidate()
                    begin
                        DPension := Dates.DetermineAge(Rec."Pension Scheme Join Date", Today);
                    end;
                }
                field("Medical Scheme Join Date"; Rec."Medical Scheme Join Date")
                {

                    trigger OnValidate()
                    begin
                        DMedical := Dates.DetermineAge(Rec."Medical Scheme Join Date", Today);
                    end;
                }
                field(DMedical; DMedical)
                {
                    Caption = 'Time On Medical Aid Scheme';
                    Editable = false;
                    Enabled = false;
                }
                field("Wedding Anniversary"; Rec."Wedding Anniversary")
                {
                }
            }
            group("Job Details")
            {
                Caption = 'Job Details';
                field("Job Specification"; Rec."Job Specification")
                {
                    Importance = Promoted;
                }
                field("Job Title"; Rec."Job Title")
                {
                    Importance = Promoted;
                }
                field(Grade; Rec.Grade)
                {
                    Importance = Promoted;
                }
                field("Contractual Gross Salary";Rec."Contractual Gross Salary")
                {
                    Caption = 'Gross Salary';
                    Importance = Promoted;
                }

            }
            group("Terms of Service")
            {
                Caption = 'Terms of Service';
                field("Secondment Institution"; Rec."Secondment Institution")
                {
                    Caption = 'Seondment';
                }
                field("Contract End Date"; Rec."Contract End Date")
                {
                    Editable = true;
                    Importance = Promoted;
                }
                field("Notice Period"; Rec."Notice Period")
                {
                }
                field("Send Alert to"; Rec."Send Alert to")
                {
                }
                field("Full / Part Time"; Rec."Full / Part Time")
                {
                    Importance = Promoted;
                }
            }

            group("Separation Details")
            {
                Caption = 'Separation Details';
                field("Date Of Leaving the Company"; Rec."Date Of Leaving the Company")
                {
                    Importance = Promoted;

                    trigger OnLookup(var Text: Text): Boolean
                    begin

                        /*
                        FrmCalendar.SetDate("Date Of Leaving the Company");
                        FrmCalendar.RUNMODAL;
                        D := FrmCalendar.GetDate;
                        CLEAR(FrmCalendar);
                        IF D <> 0D THEN
                          "Date Of Leaving the Company":= D;
                        //DAge:= Dates.DetermineAge("Date Of Birth",TODAY);
                        
                        */

                    end;
                }
                field("Termination Grounds"; Rec."Termination Grounds")
                {
                    Importance = Promoted;
                }
                field("Exit Interview Date"; Rec."Exit Interview Date")
                {
                    Importance = Promoted;
                }
                field("Exit Interview Done by"; Rec."Exit Interview Done by")
                {
                    Importance = Promoted;
                }
            }
            group("Leave Details/Medical Claims")
            {
                Caption = 'Leave Details/Medical Claims';
                field("Annual Leave Days";Rec."Annual Leave Days")
                {
                    Importance = Promoted;
                    ShowMandatory = true;
                }
                field("Reimbursed Leave Days"; Rec."Reimbursed Leave Days")
                {
                    Importance = Promoted;
                    Editable = false;
                }
                field("Allocated Leave Days"; Rec."Allocated Leave Days")
                {
                    Importance = Promoted;
                    Editable = false;
                }
                field("Total (Leave Days)"; Rec."Total (Leave Days)")
                {
                    Importance = Promoted;
                }
                field("Total Leave Taken"; Rec."Total Leave Taken")
                {
                    Editable = false;
                    Importance = Promoted;
                }
                field("Leave Balance"; Rec."Leave Balance")
                {
                    Enabled = false;
                    Importance = Promoted;
                }
                field("Acrued Leave Days"; Rec."Acrued Leave Days")
                {
                    Importance = Promoted;
                }
                field("Cash per Leave Day"; Rec."Cash per Leave Day")
                {
                    Importance = Promoted;
                    Visible = false;
                }
                field("Cash - Leave Earned"; Rec."Cash - Leave Earned")
                {
                    Importance = Promoted;
                }
                field("Leave Status"; Rec."Leave Status")
                {
                    Importance = Promoted;
                }
                field("Leave Type Filter"; Rec."Leave Type Filter")
                {
                    Importance = Promoted;
                }
                field("Leave Period Filter"; Rec."Leave Period Filter")
                {
                    Importance = Promoted;
                }
                field("Claim Limit"; Rec."Claim Limit")
                {
                }
                field("Claim Amount Used"; Rec."Claim Amount Used")
                {
                }
                field("Claim Remaining Amount"; Rec."Claim Remaining Amount")
                {
                }
            }
        }
        area(factboxes)
        {
            part(Control1102755004; "HR Employees Factbox")
            {
                SubPageLink = "No." = field("No.");
            }
            systempart(Control1102755002; Outlook)
            {
            }
            systempart(Control1; Links)
            {
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Print")
            {
                Caption = '&Print';
                action("Personal Information File")
                {
                    Caption = 'Personal Information File';
                    Image = PrintReport;
                    Promoted = true;
                    PromotedCategory = Category4;
                    Visible = false;

                    trigger OnAction()
                    begin
                        HREmp.Reset;
                        HREmp.SetRange(HREmp."No.", Rec."No.");
                        if HREmp.Find('-') then
                            Report.Run(55585, true, true, HREmp);
                    end;
                }
                action("Misc. Article Info")
                {
                    Caption = 'Misc. Article Info';
                    Image = PrintReport;
                    Promoted = false;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Category4;

                    trigger OnAction()
                    begin
                        Misc.Reset;
                        Misc.SetRange(Misc."Employee No.", Rec."No.");
                        if Misc.Find('-') then
                            Report.Run(5202, true, true, Misc);
                    end;
                }
                action("Confidential Info")
                {
                    Caption = 'Confidential Info';
                    Image = PrintReport;
                    Promoted = false;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Category4;
                    Visible = false;

                    trigger OnAction()
                    begin
                        Conf.Reset;
                        Conf.SetRange(Conf."Employee No.", Rec."No.");
                        if Conf.Find('-') then
                            Report.Run(5203, true, true, Conf);
                    end;
                }
                action(Label)
                {
                    Caption = 'Label';
                    Image = PrintReport;
                    Promoted = false;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Category4;
                    Visible = false;

                    trigger OnAction()
                    begin
                        HREmp.Reset;
                        HREmp.SetRange(HREmp."No.", Rec."No.");
                        if HREmp.Find('-') then
                            Report.Run(5200, true, true, HREmp);
                    end;
                }
                action(Addresses)
                {
                    Caption = 'Addresses';
                    Image = PrintReport;
                    Promoted = false;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Category4;

                    trigger OnAction()
                    begin
                        HREmp.Reset;
                        HREmp.SetRange(HREmp."No.", Rec."No.");
                        if HREmp.Find('-') then
                            Report.Run(5207, true, true, HREmp);
                    end;
                }
                action("Alt. Addresses")
                {
                    Caption = 'Alt. Addresses';
                    Image = PrintReport;
                    Promoted = false;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Category4;

                    trigger OnAction()
                    begin
                        HREmp.Reset;
                        HREmp.SetRange(HREmp."No.", Rec."No.");
                        if HREmp.Find('-') then
                            Report.Run(5213, true, true, HREmp);
                    end;
                }
                action("Phone Nos")
                {
                    Caption = 'Phone Nos';
                    Image = PrintReport;
                    Promoted = false;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Category4;

                    trigger OnAction()
                    begin
                        HREmp.Reset;
                        HREmp.SetRange(HREmp."No.", Rec."No.");
                        if HREmp.Find('-') then
                            Report.Run(5210, true, true, HREmp);
                    end;
                }
            }
            action("View PaySlip")
            {
                Image = PaymentHistory;
                Promoted = true;
                PromotedCategory = Category8;
                PromotedOnly = true;

                trigger OnAction()
                var
                    payslipTrans: Record "prPeriod Transactions.";
                begin
                    payslipTrans.Reset;
                    payslipTrans.SetRange("Employee Code", Rec."No.");
                    if payslipTrans.FindFirst then begin
                        Report.Run(80034, true, false, payslipTrans);
                    end;
                end;
            }
            action("View P9 Slip")
            {
                Image = PaymentHistory;
                Promoted = true;
                PromotedCategory = Category8;
                PromotedOnly = true;

                trigger OnAction()
                var
                    p9PeriodTrans: Record "Payroll Employee P9.";
                begin
                    p9PeriodTrans.Reset;
                    p9PeriodTrans.SetRange("Employee Code", Rec."No.");
                    if p9PeriodTrans.FindFirst then begin
                        Report.Run(80035, true, false, p9PeriodTrans);
                    end;
                end;
            }
            group("&Employee")
            {
                Caption = '&Employee';
                action("Next of Kin")
                {
                    Caption = 'Next of Kin';
                    Image = Relatives;
                    Promoted = true;
                    PromotedCategory = Category6;
                    RunObject = Page "HR Employee Kin SF";
                    RunPageLink = "Employee Code" = field("No.");
                    RunPageView = where(Type = filter("Next of Kin"));
                }
                action(Beneficiaries)
                {
                    Caption = 'Beneficiaries';
                    Image = Opportunity;
                    Promoted = true;
                    PromotedCategory = Category6;
                    RunObject = Page "HR Employee Kin SF";
                    RunPageLink = "Employee Code" = field("No.");
                    RunPageView = where(Type = filter(Beneficiary));
                }
                action("Co&mments")
                {
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    Promoted = false;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Category6;
                    RunObject = Page "Human Resource Comment Sheet";
                    RunPageLink = "Table Name" = const(Employee),
                                  "No." = field("No.");
                }
                action(Qualifications)
                {
                    Caption = 'Qualifications';
                    Image = QualificationOverview;
                    Promoted = true;
                    PromotedCategory = Category6;
                    RunObject = Page "HR Employee Qualification Line";
                    RunPageLink = "Employee No." = field("No.");
                }
                action("Employment History")
                {
                    Caption = 'Employment History';
                    Image = History;
                    Promoted = true;
                    PromotedCategory = Category6;
                    RunObject = Page "HR Employment History Lines";
                    RunPageLink = "Employee No." = field("No.");
                }
                action("Alternative Addresses")
                {
                    Caption = 'Alternative Addresses';
                    Image = AlternativeAddress;
                    Promoted = false;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Category6;
                    RunObject = Page "Alternative Address Card";
                    RunPageLink = "Employee No." = field("No.");
                }
                action("Misc. Articles")
                {
                    Caption = 'Misc. Articles';
                    Image = ExternalDocument;
                    Promoted = true;
                    PromotedCategory = Category6;
                    RunObject = Page "Misc. Article Information";
                    RunPageLink = "Employee No." = field("No.");
                }
                action("Misc. Articles Overview")
                {
                    Caption = 'Misc. Articles Overview';
                    Image = ViewSourceDocumentLine;
                    Promoted = true;
                    PromotedCategory = Category6;
                    RunObject = Page "Misc. Articles Overview";
                }
                action("&Confidential Information")
                {
                    Caption = '&Confidential Information';
                    Image = SNInfo;
                    Promoted = false;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Category6;
                    RunObject = Page "Confidential Information";
                    RunPageLink = "Employee No." = field("No.");
                }
                action("Co&nfidential Info. Overview")
                {
                    Caption = 'Co&nfidential Info. Overview';
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Category6;
                    RunObject = Page "Confidential Info. Overview";
                }
                action("A&bsences")
                {
                    Caption = 'A&bsences';
                    Image = AbsenceCalendar;
                    Promoted = false;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Category6;
                    RunObject = Page "Employee Absences";
                    RunPageLink = "Employee No." = field("No.");
                }
                action(Dimensions)
                {
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    Promoted = false;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Category6;
                    RunObject = Page "Default Dimensions";
                    RunPageLink = "Table ID" = const(5200),
                                  "No." = field("No.");
                }
                action("Education Sponsor")
                {
                    Caption = 'Education Sponsor';
                    RunObject = Page "HR Education Assistance List";
                    RunPageLink = "Employee No." = field("No.");
                }
                action("Leave Family Employees List")
                {
                    Caption = 'Leave Family Employees List';
                    RunObject = Page "HR Leave Family Employees List";
                    RunPageLink = "Employee No" = field("No.");
                }
                action(Grievances)
                {
                    Caption = 'Grievances';
                    RunObject = Page "HR Leave Period List";
                    //   RunPageLink = "Starting Date"=field("No.");
                }
                action(Supervisees)
                {
                    Caption = 'Supervisees';
                    RunObject = Page "HR Employees Supervisee";
                }
            }
        }
        area(processing)
        {
            action(Attachments)
            {
                Caption = 'Employee Attachments';//
                Image = Attach;
                ToolTip = 'Add a file as an attachment. You can attach images as well as documents.';

                trigger OnAction()
                var
                    DocumentAttachmentDetails: Page "Document Attachment Details";
                    RecRef: RecordRef;
                begin
                    RecRef.GetTable(Rec);
                    DocumentAttachmentDetails.OpenForRecRef(RecRef);
                    DocumentAttachmentDetails.Run();
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        DAge := '';
        DService := '';
        DPension := '';
        DMedical := '';

        // //Recalculate Important Dates
        // if (Rec."Date Of Leaving the Company" = 0D) then begin
        //     if (Rec."Date Of Birth" <> 0D) then
        //         DAge := Dates.DetermineAge(Rec."Date Of Birth", Today);
        //     if (Rec."Date Of Joining the Company" <> 0D) then
        //         DService := Dates.DetermineAge(Rec."Date Of Joining the Company", Today);
        //     if (Rec."Pension Scheme Join Date" <> 0D) then
        //         DPension := Dates.DetermineAge(Rec."Pension Scheme Join Date", Today);
        //     if (Rec."Medical Scheme Join Date" <> 0D) then
        //         DMedical := Dates.DetermineAge(Rec."Medical Scheme Join Date", Today);
        //     //MODIFY;
        // end else begin
        //     if (Rec."Date Of Birth" <> 0D) then
        //         DAge := Dates.DetermineAge(Rec."Date Of Birth", Rec."Date Of Leaving the Company");
        //     if (Rec."Date Of Joining the Company" <> 0D) then
        //         DService := Dates.DetermineAge(Rec."Date Of Joining the Company", Rec."Date Of Leaving the Company");
        //     if (Rec."Pension Scheme Join Date" <> 0D) then
        //         DPension := Dates.DetermineAge(Rec."Pension Scheme Join Date", Rec."Date Of Leaving the Company");
        //     if (Rec."Medical Scheme Join Date" <> 0D) then
        //         DMedical := Dates.DetermineAge(Rec."Medical Scheme Join Date", Rec."Date Of Leaving the Company");
        //     //MODIFY;
        // end;

        // //Recalculate Leave Days
        // Rec.Validate("Allocated Leave Days");
        // SupervisorNames := GetSupervisor(Rec."User ID");
    end;

    trigger OnClosePage()
    begin
        /* TESTFIELD("First Name");
         TESTFIELD("Middle Name");
         TESTFIELD("Last Name");
         TESTFIELD("ID Number");
         TESTFIELD("Cellular Phone Number");
        */

    end;

    trigger OnQueryClosePage(CloseAction: action): Boolean
    begin
        // if Rec."First Name" = '' then Error('Error First Name is not specified');
        // if Rec."Last Name" = '' then Error('Error Last Name is not specified');
        //IF  THEN ERROR('Error General posting group is not specified');
    end;

    var
        PictureExists: Boolean;
        Text001: label 'Do you want to replace the existing picture of %1 %2?';
        Text002: label 'Do you want to delete the picture of %1 %2?';
        Dates: Codeunit "HR Datess";
        DAge: Text[100];
        DService: Text[100];
        DPension: Text[100];
        DMedical: Text[100];
        D: Date;
        DoclLink: Record "HR Employee Attachments";
        "Filter": Boolean;
        prEmployees: Record "HR Employees";
        prPayrollType: Record "prPayroll Type";
        Mail: Codeunit Mail;
        HREmp: Record "HR Employees";
        SupervisorNames: Text[60];
        Misc: Record "Misc. Article Information";
        Conf: Record "Confidential Information";
        HRValueChange: Record "HR Value Change";
        //SMTP: Codeunit "SMTP Mail";
        CompInfo: Record "Company Information";
        Body: Text[1024];
        Text003: label 'Welcome to Lotus Capital Limited';
        Filename: Text;
        Recordlink: Record "Record Link";
        Text004a: label 'It is a great pleasure to welcome you to Moi Teaching and Referral Hospital. You are now part of an organization that has its own culture and set of values. On your resumption and during your on-boarding process,  to help you to understand and adapt quickly and easily to the LOTUS CAPITAL culture and values, HR Unit shall provide you with various important documents that you are encouraged to read and understand.';
        Text004b: label 'On behalf of the Managing Director, I congratulate you for your success in the interview process and I look forward to welcoming you on board LOTUS CAPITAL Limited.';
        Text004c: label 'Adebola SAMSON-FATOKUN';
        Text004d: label 'Strategy & Corporate Services';
        NL: Char;
        LF: Char;
        objpostingGroup: Record "prEmployee Posting Group";
        objDimVal: Record "Dimension Value";
        "Citizenship Text": Text[200];


    procedure GetSupervisor(var sUserID: Code[50]) SupervisorName: Text[200]
    var
        UserSetup: Record "User Setup";
        supervisorId: Code[20];
    begin
        if sUserID <> '' then begin
            UserSetup.Reset;
            if UserSetup.Get(sUserID) then begin
                SupervisorName := UserSetup."Approver ID";
                supervisorId := UserSetup."Approver ID";
                if SupervisorName <> '' then begin
                    HREmp.SetRange(HREmp."User ID", SupervisorName);
                    if HREmp.Find('-') then
                        SupervisorName := HREmp.FullName;
                        Rec."Supervisor ID":= supervisorId;
                        rec.modify;
                end else begin
                    SupervisorName := '';
                end;
            end else begin
                Error('User' + ' ' + sUserID + ' ' + 'does not exist in the user setup table');
                SupervisorName := '';
            end;
        end;
    end;

    procedure GetSupervisorID(var EmpUserID: Code[50]) SID: Text[200]
    var
        UserSetup: Record "User Setup";
        SupervisorID: Code[20];
    begin
        if EmpUserID <> '' then begin
            SupervisorID := '';

            UserSetup.Reset;
            if UserSetup.Get(EmpUserID) then begin
                SupervisorID := UserSetup."Approver ID";
                if SupervisorID <> '' then begin
                    SID := SupervisorID;
                end else begin
                    SID := '';
                end;
            end else begin
                Error('User' + ' ' + EmpUserID + ' ' + 'does not exist in the user setup table');
            end;
        end;
    end;
}






