//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50295 "Group Card"
{
    ApplicationArea = All;
    Editable = true;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Reports,Approval,Budgetary Control,Cancellation,Category7_caption,Category8_caption,Category9_caption,Category10_caption';
    SourceTable = "Membership Applications";

    layout
    {
        area(content)
        {
            group("General Info")
            {
                Caption = 'General Info';
                field("No."; Rec."No.")
                {
                    Caption = 'No.';
                    Editable = false;
                }
                field("Account Category"; Rec."Account Category")
                {
                    Editable = EditableField;
                    // OptionCaption = 'Group';

                    trigger OnValidate()
                    // var
                    // Joint2DetailsVisible: Boolean;
                    begin
                        Joint2DetailsVisible := false;

                        if Rec."Account Category" = Rec."account category"::Joint then begin
                            Joint2DetailsVisible := true;
                        end;
                        if Rec."Account Category" <> Rec."account category"::Corporate then begin
                            NumberofMembersEditable := false
                        end else
                            NumberofMembersEditable := true;
                    end;
                }
                field("Group Category"; Rec."Group Category")
                {
                    Editable = EditableField;

                }
                field("Name of the Group/Corporate"; Rec."Name of the Group/Corporate")
                {
                    Editable = EditableField;
                    ShowMandatory = true;
                }
                field("Certificate No"; Rec."Certificate No")
                {
                    Enabled = EditableField;
                    ShowMandatory = true;
                }
                field("KRA PIN"; Rec."KRA PIN")
                {
                    Enabled = EditableField;
                    ShowMandatory = true;
                }
                field("Member Region"; Rec."Member Region")
                {
                    Enabled = EditableField;
                    ShowMandatory = true;
                }
                field("Mobile Phone No"; Rec."Group Mobile Phone No")
                {
                    Editable = EditableField;
                    ShowMandatory = true;
                  
                }
                field(Address; Rec.Address)
                {
                    Caption = 'Address';
                    //Editable = EditableField;
                    ShowMandatory = true;
                     Editable = RefereeEditable;
                }
                field("Postal Code"; Rec."Postal Code")
                {
                    //  Editable = EditableField;
                     Editable = RefereeEditable;
                }
                field(Town; Rec.Town)
                {
                    //  Editable = TownEditable;
                     Editable = RefereeEditable;
                }
                field("Country/Region Code"; Rec."Country/Region Code")
                {
                    // Editable = CountryEditable;
                     Editable = RefereeEditable;
                }
                field(City; Rec.City)
                {
                     Editable = RefereeEditable;
                }
                field(County; Rec.County)
                {
                    LookupPageId = County;
                     Editable = RefereeEditable;
                }
                field(District; Rec.District)
                {
                    Visible = false;
                     Editable = RefereeEditable;
                }
                field(Location; Rec.Location)
                {
                    Visible = false;
                     Editable = RefereeEditable;
                }
                field("Sub-Location"; Rec."Sub-Location")
                {
                    Visible = false;
                     Editable = RefereeEditable;
                }
                field("Date of Registration"; Rec."Date of Registration")
                {
                    Enabled = EditableField;
                    ShowMandatory = true;
                     Editable = RefereeEditable;
                }
                field("No of Members"; Rec."No of Members")
                {
                    Editable = EditableField;
                }
                field("Signing Instructions"; Rec."Signing Instructions")
                {
                    Enabled = EditableField;
                }
                field("Need a Cheque book"; Rec."Need a Cheque book")
                {
                    Enabled = EditableField;
                    Visible = false;
                }
                field("Membership Approval Status"; Rec."Membership Approval Status")
                {
                    Editable = false;
                }
                field("Application Category"; Rec."Application Category")
                {
                    Editable = AppCategoryEditable;
                }
                field("Registration Date"; Rec."Registration Date")
                {
                    Editable = EditableField;
                }
                field("Customer Posting Group"; Rec."Customer Posting Group")
                {
                    Editable = CustPostingGroupEdit;
                }
                field(Status; Rec."Membership Operational Status")
                {
                    Editable = false;
                     
                }
                field("Monthly Contribution"; Rec."Monthly Contribution")
                {
                    Enabled = EditableField;
                    ShowMandatory = true;
                     Editable = RefereeEditable;
                }
                field(Picture; Rec.Picture)
                {
                    Enabled = EditableField;
                    ShowMandatory = true;
                     Editable = RefereeEditable;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    Visible = false;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    Editable = false;
                }
            }
             group("Marketing Information")
            {




                field("How Did you Know us?"; Rec."How Did you Know us?")
                {

                    Editable = IDNoEditable;
                }


                field("Reffered By Member No"; Rec."Reffered By Member No")
                {
                    Editable = IDNoEditable;
                    // Caption = 'Upline Customer No.';
                    Visible = true;
                }
                field("Reffered By Member Name"; Rec."Reffered By Member Name")
                {
                    Editable = false;
                    Visible = true;
                    // Caption = 'Upline Customer Name';
                }
                field("Upline ID"; Rec."Upline ID")
                {
                    Editable = IDNoEditable;
                    Caption = 'Upline ID';
                    Visible = true;
                }
                field("Downline ID"; Rec."Downline ID")
                {
                    Editable = IDNoEditable;
                    Caption = 'Downline ID';
                    Visible = true;
                }

                field("MLM Level"; Rec."MLM Level")
                {
                    Editable = IDNoEditable;

                }
                field("Marketing Campaign ID"; Rec."Marketing Campaign ID")
                {
                    Editable = IDNoEditable;

                }
                field("Marketing Event ID"; Rec."Marketing Event ID")
                {
                    Editable = IDNoEditable;

                }


            }
            group("Referee Details")
            {
                Visible=false;
                field("Referee Member No"; Rec."Referee Member No")
                {
                    Editable = RefereeEditable;
                }
                field("Referee Name"; Rec."Referee Name")
                {
                }
                field("Referee ID No"; Rec."Referee ID No")
                {
                }
                field("Referee Mobile Phone No"; Rec."Referee Mobile Phone No")
                {
                }
            }
            group("Communication Info")
            {
                Caption = 'Communication Info';
                // Editable = EditableField;
                field("Office Telephone No."; Rec."Office Telephone No.")
                {
                    // Enabled = EditableField;
                    Editable = EditableField;
                }
                // field("Office Extension"; Rec."Office Extension")
                // {
                //     Enabled = EditableField;
                // }

                field("E-Mail (Personal)"; Rec."E-Mail (Personal)")
                {
                    Editable = EmailEdiatble;
                    Enabled = EditableField;
                }
                field("Home Address"; Rec."Home Address")
                {
                    Editable = EditableField;
                }
                field("Home Postal Code"; Rec."Home Postal Code")
                {
                    Editable = HomeAddressPostalCodeEditable;
                }
                field("Home Town"; Rec."Home Town")
                {
                    Editable = EditableField;
                }
                field("Contact Person"; Rec."Contact Person")
                {
                    Editable = ContactPEditable;
                    ShowMandatory = true;
                }
                field("Contact Person Phone"; Rec."Contact Person Phone")
                {
                    Editable = ContactPPhoneEditable;
                    ShowMandatory = true;
                }
                field("ContactPerson Relation"; Rec."ContactPerson Relation")
                {
                    Editable = ContactPRelationEditable;
                }
            }
            group("Trade Information")
            {
                Caption = 'Trade Information';
                field("Group/Corporate Trade"; Rec."Group/Corporate Trade")
                {
                    Enabled = EditableField;
                    ShowMandatory = true;
                    LookupPageId = TRADE;
                }
                field(Occupation; Rec.Occupation)
                {
                    Editable = EditableField;
                }
                field("Others Details"; Rec."Others Details")
                {
                    // Editable = OthersEditable;
                    Editable = EditableField;
                }
            }
            group("Member Risk Ratings")
            {
                Visible = false;
                group("Member Risk Rate")
                {
                    field("Individual Category"; Rec."Individual Category")
                    {
                        ShowMandatory = true;
                    }
                    field("Member Residency Status"; Rec."Member Residency Status")
                    {
                        ShowMandatory = true;
                    }
                    field(Entities; Rec.Entities)
                    {
                    }
                    field("Industry Type"; Rec."Industry Type")
                    {
                        ShowMandatory = true;
                    }

                    field("Length Of Relationship"; Rec."Length Of Relationship")
                    {
                        ShowMandatory = true;
                    }
                    field("International Trade"; Rec."International Trade")
                    {
                        ShowMandatory = true;
                    }
                }
                group("Product Risk Rating")
                {
                    field("Electronic Payment"; Rec."Electronic Payment")
                    {
                        ShowMandatory = true;
                    }
                    field("Accounts Type Taken"; Rec."Accounts Type Taken")
                    {
                        ShowMandatory = true;
                    }
                    field("Cards Type Taken"; Rec."Cards Type Taken")
                    {
                        ShowMandatory = true;
                    }
                    field("Others(Channels)"; Rec."Others(Channels)")
                    {
                        ShowMandatory = true;
                    }
                    field("Member Risk Level"; Rec."Member Risk Level")
                    {
                        Caption = 'Risk Level';
                        Editable = false;
                        // Image = Person;
                        StyleExpr = CoveragePercentStyle;
                    }
                    field("Due Diligence Measure"; Rec."Due Diligence Measure")
                    {
                        Editable = false;
                        //  Image = Person;
                        StyleExpr = CoveragePercentStyle;
                    }
                }
                part(Control20; "Member Due Diligence Measure")
                {
                    Caption = 'Due Diligence Measure';
                    SubPageLink = "Member No" = field("No.");
                    SubPageView = sorting("Due Diligence No");
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("Function")
            {
                Caption = 'Function';
                action("Select Products")
                {
                    Image = Accounts;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;
                    RunObject = Page "Membership App Products";
                    RunPageLink = "Membership Applicaton No" = field("No.");

                }
                action("Account Signatories ")
                {
                    Caption = 'Signatories';
                    Image = Group;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;
                    RunObject = Page "Membership App Signatories";
                    RunPageLink = "Account No" = field("No.");
                }
                action("Member Agent Details")
                {
                    Image = Group;
                    Visible = false;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Member Agent App  List";
                    RunPageLink = "Account No" = field("No.");
                }
                action("Member Sanction Information")
                {
                    Image = ErrorLog;
                    Promoted = true;
                    Visible = false;
                    PromotedCategory = Process;
                    RunObject = Page "Membership Application Saction";
                    RunPageLink = "Document No" = field("No.");
                }
                action("Member Risk Rating")
                {
                    Caption = 'Get Member Risk Rating';
                    Image = Reconcile;
                    Promoted = true;
                    Visible = false;
                    PromotedCategory = Process;
                    RunObject = Page "Entities Risk Rating";
                    RunPageLink = "Membership Application No" = field("No.");

                    trigger OnAction()
                    begin
                        SFactory.FnGetEntitiesApplicationAMLRiskRating(Rec."No.");

                        /*ObjEntitiesAMLEntries.RESET;
                        ObjEntitiesAMLEntries.SETRANGE(ObjEntitiesAMLEntries."Membership Application No","No.");
                        IF ObjEntitiesAMLEntries.FINDSET THEN
                          PAGE.RUN(51516619);*/

                    end;
                }
                separator(Action6)
                {
                    Caption = '-';
                }
                action("Send Approval Request")
                {
                    Caption = 'Send Approval Request';
                    // Enabled = (not OpenApprovalEntriesExist) and EnabledApprovalWorkflowsExist;
                    Enabled = canSendApproval;
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedOnly = true;

                    trigger OnAction()
                    var
                        Text001: label 'This request is already pending approval';
                    //ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin

                        // ObjProductsApp.Reset;
                        // ObjProductsApp.SetRange(ObjProductsApp."Membership Applicaton No", "No.");
                        // if ObjProductsApp.FindSet = false then begin
                        //     Error('You must select products for the member');
                        // end;

                        /*
                        IF "ID No."<>'' THEN BEGIN
                        Cust.RESET;
                        Cust.SETRANGE(Cust."ID No.","ID No.");
                        Cust.SETRANGE(Cust."Customer Type",Cust."Customer Type"::Member);
                        IF Cust.FIND('-') THEN BEGIN
                        IF (Cust."No." <> "No.") AND ("Account Category"="Account Category"::Individual) THEN
                           ERROR('Member has already been created');
                        END;
                        END;
                        */
                        //-------------------Check ID Or Passport---------------------------------------
                        // IF ("ID No."='') AND ("Passport No."='') THEN
                        //ERROR('You Must Specify Either ID or Passport No for the Applicant');
                        //-------------------Check ID Or Passport---------------------------------------


                        // if ("Account Category" = "account category"::Individual) then begin
                        //     TestField(Name);
                        //     TestField("ID No.");
                        //     TestField("Mobile Phone No");
                        //     //TESTFIELD("E-Mail (Personal)");
                        //     //TESTFIELD("Employer Code");
                        //     //TESTFIELD("Received 1 Copy Of ID");
                        //     //TESTFIELD("Copy of Current Payslip");
                        //     //TESTFIELD("Member Registration Fee Receiv");
                        //     //TESTFIELD("Copy of KRA Pin");
                        //     TestField("Customer Posting Group");
                        //     //TESTFIELD("Global Dimension 1 Code");
                        //     TestField("Global Dimension 2 Code");
                        // end else

                        if (Rec."Account Category" = Rec."account category"::Corporate) or (Rec."Account Category" = Rec."account category"::Joint) then begin
                            Rec.TestField("Name of the Group/Corporate");
                            Rec.TestField("Signing Instructions");
                            //TESTFIELD("Registration No");
                            Rec.TestField("Contact Person");
                            Rec.TestField("Contact Person Phone");
                            Rec.TestField("Date of Registration");
                            //TESTFIELD("Group/Corporate Trade");
                            Rec.TestField("Customer Posting Group");
                            //TESTFIELD("Global Dimension 1 Code");
                            //Rec.TestField("Global Dimension 2 Code");
                            Rec.TestField("Contact Person Phone");
                            Rec.TestField("Monthly Contribution");

                        end;

                        /*IF ("Account Category"="Account Category"::Single)OR ("Account Category"="Account Category"::Junior)OR ("Account Category"="Account Category"::Joint)  THEN BEGIN
                        NOkApp.RESET;
                        NOkApp.SETRANGE(NOkApp."Account No","No.");
                        IF NOkApp.FIND('-')=FALSE THEN BEGIN
                        ERROR('Please Insert Next 0f kin Information');
                        END;
                        END;*/

                        if (Rec."Account Category" = Rec."account category"::Corporate) or (Rec."Account Category" = Rec."account category"::Joint) then begin
                            ObjAccountSignApp.Reset;
                            ObjAccountSignApp.SetRange(ObjAccountSignApp."Account No", Rec."No.");
                            if ObjAccountSignApp.Find('-') = false then begin
                                Error('Please insert Account Signatories');
                            end;
                        end;

                        if Rec."Membership Approval Status" <> Rec."Membership Approval Status"::Open then
                            Error(Text001);

                        //End allocate batch number
                        Doc_Type := Doc_type::"Account Opening";
                        Table_id := Database::"Membership Applications";
                        //IF Approvalmgt.SendApproval(Table_id,"No.",Doc_Type,Status)THEN;
                        if WkFlwIntegration.CheckMembershipApplicationApprovalsWorkflowEnabled(Rec) then
                            WkFlwIntegration.OnSendMembershipApplicationForApproval(Rec);
                    end;
                }
                action("Cancel Approval Request")
                {
                    Caption = 'Cancel Approval Request';
                    Enabled = CanCancelApprovalForRecord;
                    Image = CancelApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedOnly = true;

                    trigger OnAction()
                    var
                    //Approvalmgt: Codeunit "Approvals Mgmt.";
                    begin
                        // if Confirm('Are you sure you want to cancel this approval request', false) = true then
                        //     WkFlwIntegration.OnCancelMembershipApplicationApprovalRequest(Rec);
                        // Rec."Membership Approval Status" := Rec."Membership Approval Status"::Open;
                        // Rec.Modify;
                        if Rec."Membership Approval Status" = Rec."Membership Approval Status"::Open then
                            Error('The record is already open.');
                        IF Workflowmanagement.CheckMembershipApplicationApprovalsWorkflowEnabled(Rec) THEN
                            Workflowmanagement.OnCancelMembershipApplicationApprovalRequest(Rec);
                    end;
                }
                action(Approval)
                {
                    Caption = 'Approvals';
                    Enabled = OpenApprovalEntriesExist;
                    Image = Approvals;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedOnly = true;

                    trigger OnAction()
                    var
                        ApprovalEntries: Page "Approval entries";
                        approvalDoc: Enum "Approval Document Type";
                    begin
                        // DocumentType := Documenttype::MembershipApplication;
                        ApprovalEntries.SetRecordFilters(DATABASE::"Membership Applications", approvalDoc::"MembershipApplication", Rec."No.");
                        ApprovalEntries.RUN;
                    end;
                }
                separator(Action2)
                {
                    Caption = '       -';
                }
                action("Create Account ")
                {
                    Caption = 'Create Accounts';
                    Enabled = canCreate;
                    Image = Customer;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    PromotedOnly = true;

                    trigger OnAction()
                    var
                        ObjAccountType: Record "Account Types-Saving Products";
                        VarAccounts: Text;
                        SaccoNoSeries: record "Sacco No. Series";
                        AccountTypeCode: Code[20];
                        Zones: Record "Member Delegate Zones";
                        Zonecode: Code[10];
                        MemberNumber: Code[20];
                        ObjAccountTypess: Record "Account Types-Saving Products";
                    begin
                        if Rec."Membership Approval Status" <> Rec."Membership Approval Status"::Approved then
                            Error('This application has not been approved');
                        Rec.TestField("Monthly Contribution");

                        if Confirm('Do you wish to proceed with creating this member?', true) = false then
                            exit
                        else begin
                            ObjSaccosetup.Get();

                            ObjMemberNoseries.Reset;
                            ObjMemberNoseries.SetRange(ObjMemberNoseries."Account Type", ObjProductsApp.Product);
                            ObjMemberNoseries.SetRange(ObjMemberNoseries."Branch Code", Rec."Global Dimension 2 Code");
                            if ObjMemberNoseries.FindSet then begin
                                VarNewMembNo := ObjMemberNoseries."Account No";
                            end;

                            if rec."Account Category" = Rec."Account Category"::Individual then begin
                                AccountTypeCode := '2';
                            end else if rec."Account Category" = Rec."Account Category"::Corporate then begin
                                AccountTypeCode := '1';
                            end else if rec."Account Category" = Rec."Account Category"::Joint then begin
                                AccountTypeCode := '3';
                            end;
                            //Get New Member No



                            SaccoNoSeries.Get();
                            MemberNumber := NoSeriesMgt.GetNextNo(SaccoNoSeries."Members Nos");
                            VarNewMembNo := rec."Member Region" + AccountTypeCode + MemberNumber;

                            //Create BOSA account
                            SaccoNoSeries.Get();
                            // VarNewMembNo := NoSeriesMgt.GetNextNo(SaccoNoSeries."Members Nos", Today, true);
                            ObjCust."No." := Format(VarNewMembNo);
                            ObjCust."Application No." := rec."No.";
                            ObjCust.Name := Rec."Name of the Group/Corporate";//
                            ObjCust."Name of the Group/Corporate" := Rec."Name of the Group/Corporate";
                            ObjCust."Date of Registration" := Rec."Date of Registration";
                            ObjCust."No of Members" := Rec."No of Members";
                            ObjCust."Group/Corporate Trade" := Rec."Group/Corporate Trade";
                            ObjCust."Certificate No" := Rec."Certificate No";
                            ObjCust."Home Address" := Rec."Home Address";
                            ObjCust."Home Postal Code" := Rec."Home Postal Code";
                            ObjCust."Home Town" := Rec."Town";
                            ObjCust.Address := Rec.Address;
                            ObjCust.Location := Rec.Location;
                            ObjCust."Post Code" := Rec."Postal Code";
                            ObjCust.County := Rec.County;
                            ObjCust."Village/Residence" := Rec."Village/Residence";
                            ObjCust.City := Rec.City;
                            ObjCust."Sub-Location" := Rec."Sub-Location";
                            ObjCust.District := Rec.District;
                            ObjCust."Country/Region Code" := Rec."Country/Region Code";
                            ObjCust."Phone No." := Rec."Group Mobile Phone No";//
                            ObjCust."Global Dimension 1 Code" := Rec."Global Dimension 1 Code";
                            ObjCust."Global Dimension 2 Code" := Rec."Global Dimension 2 Code";
                            ObjCust."Customer Posting Group" := Rec."Customer Posting Group";
                            ObjCust."Monthly Contribution" := Rec."Monthly Contribution";
                            ObjCust.Pin := Rec."KRA PIN";
                            ObjCust."Mobile Phone No" := Rec."Group Mobile Phone No";//
                            ObjCust."Group Mobile Phone No" := Rec."Group Mobile Phone No";
                            ObjCust.Status := ObjCust.Status::Active;
                            ObjCust."Employer Code" := Rec."Employer Code";
                            ObjCust.ISNormalMember := true;
                            ObjCust."E-Mail" := Rec."E-Mail (Personal)";
                            ObjCust."Recruited By" := Rec."Recruited By";
                            ObjCust."Contact Person" := Rec."Contact Person";
                            ObjCust."Contact Person Phone" := Rec."Contact Person Phone";
                            ObjCust."ContactPerson Relation" := Rec."ContactPerson Relation";
                            ObjCust."ContactPerson Occupation" := Rec."ContactPerson Occupation";
                            ObjCust."Member Share Class" := Rec."Member Share Class";
                            ObjCust."Member Needs House Group" := Rec."Member Needs House Group";
                            ObjCust."Member's Residence" := Rec."Member's Residence";
                            ObjCust."Member House Group" := Rec."Member House Group";
                            ObjCust."Member House Group Name" := Rec."Member House Group Name";
                            ObjCust."Nature Of Business" := Rec."Nature Of Business";
                            ObjCust.Industry := Rec.Industry;
                            ObjCust."Business Name" := Rec."Business Name";
                            ObjCust."Physical Business Location" := Rec."Physical Business Location";
                            ObjCust."Year of Commence" := Rec."Year of Commence";
                            ObjCust."Identification Document" := Rec."Identification Document";
                            ObjCust."Referee Member No" := Rec."Referee Member No";
                            ObjCust."Referee Name" := Rec."Referee Name";
                            ObjCust."Referee ID No" := Rec."Referee ID No";
                            ObjCust."Referee Mobile Phone No" := Rec."Referee Mobile Phone No";
                            ObjCust."Reffered By Member No" := Rec."Referee Member No";
                            ObjCust."Reffered By Member Name" := Rec."Referee Name";
                            ObjCust."Office Telephone No." := Rec."Office Telephone No.";
                            // ObjCust."Phone No." := Rec."Office Extension";
                            ObjCust."Email Indemnified" := Rec."E-mail Indemnified";
                            ObjCust."Office Branch" := Rec."Office Branch";
                            ObjCust."Bank Code" := Rec."Bank Code";
                            ObjCust."Bank Branch Code" := Rec."Bank Name";
                            ObjCust."Bank Account No." := Rec."Bank Account No";
                            ObjCust."Customer Type" := ObjCust."customer type"::Member;
                            // 
                            if rec."Account Category" = Rec."Account Category"::Corporate then begin
                                ObjCust."Account Category" := ObjCust."Account Category"::Corporate;
                                if rec."Group Category" = rec."Group Category"::Chamaa then begin
                                    ObjCust."Group Category" := ObjCust."Group Category"::Chamaa;
                                end else begin
                                    ObjCust."Group Category" := ObjCust."Group Category"::"Co-operate";
                                end;
                            end;
                            // 
                            //========================================================================Member Risk Rating
                            ObjCust."Individual Category" := Rec."Individual Category";
                            ObjCust.Entities := Rec.Entities;
                            ObjCust."Member Residency Status" := Rec."Member Residency Status";
                            ObjCust."Industry Type" := Rec."Industry Type";
                            ObjCust."Length Of Relationship" := Rec."Length Of Relationship";
                            ObjCust."International Trade" := Rec."International Trade";
                            ObjCust."Electronic Payment" := Rec."Electronic Payment";
                            ObjCust."Accounts Type Taken" := Rec."Accounts Type Taken";
                            ObjCust."Cards Type Taken" := Rec."Cards Type Taken";
                            ObjCust."Others Details" := Rec."Others Details";
                            //========================================================================End Member Risk Rating

                            ObjCust."Registration Date" := Today;
                            ObjCust."Created By" := UserId;
                            ObjCust.Insert(true);

                            ObjAccountSignApp.Reset;
                            ObjAccountSignApp.SetRange(ObjAccountSignApp."Account No", Rec."No.");
                            if ObjAccountSignApp.Find('-') then begin
                                repeat
                                    if ObjNoSeries.Get then begin
                                        ObjNoSeries.TestField(ObjNoSeries."Signatories Document No");
                                        VarDocumentNo := NoSeriesMgt.GetNextNo(ObjNoSeries."Signatories Document No", 0D, true);
                                        if VarDocumentNo <> '' then begin
                                            ObjAccountSign.Init;
                                            ObjAccountSign."Document No" := VarDocumentNo;
                                            ObjAccountSign."Account No" := VarNewMembNo;
                                            ObjAccountSign."BOSA Account" := VarNewMembNo;
                                            ObjAccountSign.Names := ObjAccountSignApp.Names;
                                            ObjAccountSign."Date Of Birth" := ObjAccountSignApp."Date Of Birth";
                                            ObjAccountSign."Staff/Payroll" := ObjAccountSignApp."Staff/Payroll";
                                            ObjAccountSign."ID No." := ObjAccountSignApp."ID No.";
                                            ObjAccountSign."Mobile No" := ObjAccountSignApp."Mobile No.";
                                            ObjAccountSign."Member No." := ObjAccountSignApp."BOSA No.";
                                            ObjAccountSign."Email Address" := ObjAccountSignApp."Email Address";
                                            ObjAccountSign."Withdrawal Limit" := ObjAccountSignApp."Maximum Withdrawal";
                                            ObjAccountSign.Signatory := ObjAccountSignApp.Signatory;
                                            ObjAccountSign."Must Sign" := ObjAccountSignApp."Must Sign";
                                            ObjAccountSign."Must be Present" := ObjAccountSignApp."Must be Present";
                                            ObjAccountSign.Picture := ObjAccountSignApp.Picture;
                                            ObjAccountSign.Signature := ObjAccountSignApp.Signature;
                                            ObjAccountSign."Expiry Date" := ObjAccountSignApp."Expiry Date";
                                            ObjAccountSign.Insert;
                                        end;
                                    end;
                                until ObjAccountSignApp.Next = 0;
                            end;

                            // ObjNextOfKinApp.Reset;
                            // ObjNextOfKinApp.SetRange(ObjNextOfKinApp."Account No", Rec."No.");
                            // if ObjNextOfKinApp.Find('-') then begin
                            //     repeat
                            //         ObjNextOfKin.Init;
                            //         ObjNextOfKin."Account No" := ObjCust."No.";
                            //         ObjNextOfKin.Name := ObjNextOfKinApp.Name;
                            //         ObjNextOfKin.Relationship := ObjNextOfKinApp.Relationship;
                            //         ObjNextOfKin.Beneficiary := ObjNextOfKinApp.Beneficiary;
                            //         ObjNextOfKin."Date of Birth" := ObjNextOfKinApp."Date of Birth";
                            //         ObjNextOfKin.Address := ObjNextOfKinApp.Address;
                            //         ObjNextOfKin.Telephone := ObjNextOfKinApp.Telephone;
                            //         ObjNextOfKin.Email := ObjNextOfKinApp.Email;
                            //         ObjNextOfKin."ID No." := ObjNextOfKinApp."ID No.";
                            //         ObjNextOfKin."%Allocation" := ObjNextOfKinApp."%Allocation";
                            //         ObjNextOfKin.Description := ObjNextOfKinApp.Description;
                            //         ObjNextOfKin."Next Of Kin Type" := ObjNextOfKinApp."Next Of Kin Type";
                            //         ObjNextOfKin.Insert;
                            //     until ObjNextOfKinApp.Next = 0;
                            // end;

                            //==================================================================================Insert Member Agents
                            ObjMemberAppAgent.Reset;
                            ObjMemberAppAgent.SetRange(ObjMemberAppAgent."Account No", Rec."No.");
                            if ObjMemberAppAgent.Find('-') then begin
                                repeat
                                    ObjMemberAgent.Init;
                                    ObjMemberAgent."Account No" := ObjCust."No.";
                                    ;
                                    ObjMemberAgent.Names := ObjMemberAppAgent.Names;
                                    ObjMemberAgent."Date Of Birth" := ObjMemberAppAgent."Date Of Birth";
                                    ObjMemberAgent."Staff/Payroll" := ObjMemberAppAgent."Staff/Payroll";
                                    ObjMemberAgent."ID No." := ObjMemberAppAgent."ID No.";
                                    ObjMemberAgent."Allowed  Correspondence" := ObjMemberAppAgent."Allowed  Correspondence";
                                    ObjMemberAgent."Allowed Balance Enquiry" := ObjMemberAppAgent."Allowed Balance Enquiry";
                                    ObjMemberAgent."Allowed FOSA Withdrawals" := ObjMemberAppAgent."Allowed FOSA Withdrawals";
                                    ObjMemberAgent."Allowed Loan Processing" := ObjMemberAppAgent."Allowed Loan Processing";
                                    ObjMemberAgent."Must Sign" := ObjMemberAppAgent."Must Sign";
                                    ObjMemberAgent."Must be Present" := ObjMemberAppAgent."Must be Present";
                                    ObjMemberAgent.Picture := ObjMemberAppAgent.Picture;
                                    ObjMemberAgent.Signature := ObjMemberAppAgent.Signature;
                                    ObjMemberAgent."Expiry Date" := ObjMemberAppAgent."Expiry Date";
                                    ObjMemberAgent.Insert;
                                until ObjMemberAppAgent.Next = 0;
                            end;
                            //==================================================================================End Insert Member Agents

                            ObjMemberNoseries.Reset;
                            ObjMemberNoseries.SetRange(ObjMemberNoseries."Account Type", ObjProductsApp.Product);
                            ObjMemberNoseries.SetRange(ObjMemberNoseries."Branch Code", Rec."Global Dimension 2 Code");
                            if ObjMemberNoseries.FindSet then begin
                                ObjMemberNoseries."Account No" := IncStr(ObjMemberNoseries."Account No");
                                ObjMemberNoseries.Modify;
                            end;
                            VarBOSAACC := ObjCust."No.";
                            //  until ObjProductsApp.Next = 0;
                            //end;
                            //end;
                            //==================================================================================================End Back Office Account

                            //==================================================================================================Front Office Accounts
                            // ObjProductsApp.Reset;
                            // ObjProductsApp.SetRange(ObjProductsApp."Membership Applicaton No", Rec."No.");
                            // ObjProductsApp.SetFilter(ObjProductsApp.Product, '<>%1&<>%2', 'MEMBERSHIP', '');
                            // if ObjProductsApp.FindSet then begin
                            //     repeat
                            //         ObjMemberNoseries.Reset;
                            //         ObjMemberNoseries.SetRange(ObjMemberNoseries."Account Type", ObjProductsApp.Product);
                            //         ObjMemberNoseries.SetRange(ObjMemberNoseries."Branch Code", Rec."Global Dimension 2 Code");
                            //         if ObjMemberNoseries.FindSet then begin
                            //             VarAcctNo := ObjMemberNoseries."Account No";
                            //         end;
                            ObjProductsApp.Reset;
                            ObjProductsApp.SetRange(ObjProductsApp."Membership Applicaton No", Rec."No.");
                            ObjProductsApp.SetFilter(ObjProductsApp.Product, '<>%1', 'BOSA');
                            //ObjProductsApp.SETFILTER(ObjProductsApp.Product,'<>%1','');
                            if ObjProductsApp.FindSet then begin
                                repeat
                                    ObjAccountTypess.Reset();
                                    ObjAccountTypess.SetRange(ObjAccountTypess.Code, ObjProductsApp.Product);
                                    if ObjAccountTypess.find('-') then begin
                                        VarAcctNo := VarNewMembNo + ObjAccountTypess."Product Code";
                                    end;

                                    //===================================================================Create FOSA account
                                    ObjAccounts.Init;
                                    ObjAccounts."No." := VarAcctNo;
                                    ObjAccounts."BOSA Account No" := ObjCust."No.";
                                    ObjAccounts."Account Type" := ObjProductsApp.Product;
                                    ObjAccounts."Global Dimension 1 Code" := Format(ObjProductsApp."Product Source");
                                    ObjAccounts."Global Dimension 2 Code" := Rec."Global Dimension 2 Code";
                                    ObjAccounts.Status := ObjAccounts.Status::Active;
                                    ObjAccounts."Application No." := rec."No.";
                                    ObjAccounts.Name := Rec."Name of the Group/Corporate";//
                                    ObjAccounts."Name of the Group/Corporate" := Rec."Name of the Group/Corporate";
                                    ObjAccounts."Creditor Type" := ObjAccounts."Creditor type"::"FOSA Account";
                                    if rec."Account Category" = Rec."Account Category"::Corporate then begin
                                        ObjAccounts."Account Category" := ObjAccounts."Account Category"::Corporate;
                                        if rec."Group Category" = rec."Group Category"::Chamaa then begin
                                            ObjAccounts."Group Category" := ObjAccounts."Group Category"::Chamaa;
                                        end else begin
                                            ObjAccounts."Group Category" := ObjAccounts."Group Category"::"Co-operate";
                                        end;
                                    end;
                                    ObjAccounts."Mobile Phone No" := Rec."Group Mobile Phone No";//
                                    ObjAccounts."Group Mobile Phone No" := Rec."Group Mobile Phone No";
                                    ObjAccounts."Phone No." := Rec."Group Mobile Phone No";//
                                    ObjAccounts."Post Code" := Rec."Postal Code";
                                    ObjAccounts."E-Mail" := Rec."E-Mail (Personal)";
                                    ObjAccounts.County := Rec.City;
                                    ObjAccounts.Address := Rec.Address;
                                    ObjAccounts."Home Address" := Rec."Home Address";
                                    ObjAccounts.District := Rec.District;
                                    ObjAccounts.Location := Rec.Location;
                                    ObjAccounts."Sub-Location" := Rec."Sub-Location";
                                    ObjAccounts.Section := Rec.Section;
                                    ObjAccounts."Group/Corporate Trade" := Rec."Group/Corporate Trade";
                                    ObjAccounts."Monthly Contribution" := Rec."Monthly Contribution";
                                    ObjAccounts."Certificate No" := Rec."Certificate No";
                                    ObjAccounts."Referee Member No" := Rec."Referee Member No";
                                    ObjAccounts."Referee Name" := Rec."Referee Name";
                                    ObjAccounts."Referee ID No" := Rec."Referee ID No";
                                    ObjAccounts."Referee Mobile Phone No" := Rec."Referee Mobile Phone No";
                                    ObjAccounts."Reffered By Member No" := Rec."Referee Member No";
                                    ObjAccounts."Reffered By Member Name" := Rec."Referee Name";

                                    if ObjCust."Group Category" = ObjCust."Group category"::"Co-operate" then begin
                                        ObjAccounts."Joint Account Name" := Rec."First Name" + ' &' + Rec."First Name2" + ' &' + Rec."First Name3" + 'JA';
                                    end;
                                    ObjAccounts."Registration Date" := Today;
                                    ObjAccounts."Created By" := UserId;
                                    ObjAccounts.Insert;

                                    ObjAccounts.Reset;
                                    if ObjAccounts.Get(VarAcctNo) then begin
                                        ObjAccounts.Validate(ObjAccounts.Name);
                                        ObjAccounts.Validate(ObjAccounts."Account Type");
                                        ObjAccounts.Modify;

                                        ObjMemberNoseries.Reset;
                                        ObjMemberNoseries.SetRange(ObjMemberNoseries."Account Type", ObjProductsApp.Product);
                                        ObjMemberNoseries.SetRange(ObjMemberNoseries."Branch Code", Rec."Global Dimension 2 Code");
                                        if ObjMemberNoseries.FindSet then begin
                                            ObjMemberNoseries."Account No" := IncStr(ObjMemberNoseries."Account No");
                                            ObjMemberNoseries.Modify;
                                        end;

                                        //Update BOSA with FOSA Account
                                        if ObjCust.Get(VarBOSAACC) then begin
                                            ObjCust."FOSA Account No." := VarAcctNo;
                                            ObjCust.Modify;
                                        end;
                                    end;

                                    // ObjNextOfKinApp.Reset;
                                    // ObjNextOfKinApp.SetRange(ObjNextOfKinApp."Account No", Rec."No.");
                                    // if ObjNextOfKinApp.Find('-') then begin
                                    //     repeat
                                    //         ObjNextofKinFOSA.Init;
                                    //         ObjNextofKinFOSA."Account No" := VarAcctNo;
                                    //         ObjNextofKinFOSA.Name := ObjNextOfKinApp.Name;
                                    //         ObjNextofKinFOSA.Relationship := ObjNextOfKinApp.Relationship;
                                    //         ObjNextofKinFOSA.Beneficiary := ObjNextOfKinApp.Beneficiary;
                                    //         ObjNextofKinFOSA."Date of Birth" := ObjNextOfKinApp."Date of Birth";
                                    //         ObjNextofKinFOSA.Address := ObjNextOfKinApp.Address;
                                    //         ObjNextofKinFOSA.Telephone := ObjNextOfKinApp.Telephone;
                                    //         ObjNextofKinFOSA.Email := ObjNextOfKinApp.Email;
                                    //         ObjNextofKinFOSA."ID No." := ObjNextOfKinApp."ID No.";
                                    //         ObjNextofKinFOSA."%Allocation" := ObjNextOfKinApp."%Allocation";
                                    //         ObjNextofKinFOSA."Next Of Kin Type" := ObjNextOfKinApp."Next Of Kin Type";
                                    //     ///  ObjNextofKinFOSA.Insert;
                                    //     until ObjNextOfKinApp.Next = 0;
                                    // end;

                                    //==================================================================================================Insert Account Agents
                                    ObjMemberAppAgent.Reset;
                                    ObjMemberAppAgent.SetRange(ObjMemberAppAgent."Account No", Rec."No.");
                                    if ObjMemberAppAgent.Find('-') then begin
                                        repeat
                                            ObjAccountAgents.Init;
                                            ObjAccountAgents."Account No" := VarAcctNo;
                                            ObjAccountAgents.Names := ObjMemberAppAgent.Names;
                                            ObjAccountAgents."Date Of Birth" := ObjMemberAppAgent."Date Of Birth";
                                            ObjAccountAgents."Staff/Payroll" := ObjMemberAppAgent."Staff/Payroll";
                                            ObjAccountAgents."ID No." := ObjMemberAppAgent."ID No.";
                                            ObjAccountAgents."BOSA No." := ObjMemberAppAgent."BOSA No.";
                                            ObjAccountAgents."Email Address" := ObjMemberAppAgent."Email Address";
                                            ObjAccountAgents."Allowed  Correspondence" := ObjMemberAppAgent."Allowed  Correspondence";
                                            ObjAccountAgents."Allowed Balance Enquiry" := ObjMemberAppAgent."Allowed Balance Enquiry";
                                            ObjAccountAgents."Allowed FOSA Withdrawals" := ObjMemberAppAgent."Allowed FOSA Withdrawals";
                                            ObjAccountAgents."Allowed Loan Processing" := ObjMemberAppAgent."Allowed Loan Processing";
                                            ObjAccountAgents."Must Sign" := ObjMemberAppAgent."Must Sign";
                                            ObjAccountAgents."Must be Present" := ObjMemberAppAgent."Must be Present";
                                            ObjAccountAgents."Expiry Date" := ObjMemberAppAgent."Expiry Date";
                                        //ObjAccountAgents.Insert;

                                        until ObjMemberAppAgent.Next = 0;
                                    end;
                                    //==================================================================================================End Insert Account Agents

                                    ObjAccountSignApp.Reset;
                                    ObjAccountSignApp.SetRange(ObjAccountSignApp."Account No", Rec."No.");
                                    if ObjAccountSignApp.Find('-') then begin
                                        repeat
                                            if ObjNoSeries.Get then begin
                                                ObjNoSeries.TestField(ObjNoSeries."Signatories Document No");
                                                VarDocumentNo := NoSeriesMgt.GetNextNo(ObjNoSeries."Signatories Document No", 0D, true);
                                                if VarDocumentNo <> '' then begin
                                                    ObjAccountSign.Init;
                                                    ObjAccountSign."Document No" := VarDocumentNo;
                                                    ObjAccountSign."Account No" := VarAcctNo;
                                                    ObjAccountSign.Names := ObjAccountSignApp.Names;
                                                    ObjAccountSign."Date Of Birth" := ObjAccountSignApp."Date Of Birth";
                                                    ObjAccountSign."Staff/Payroll" := ObjAccountSignApp."Staff/Payroll";
                                                    ObjAccountSign."ID No." := ObjAccountSignApp."ID No.";
                                                    ObjAccountSign."Mobile No" := ObjAccountSignApp."Mobile No.";
                                                    ObjAccountSign."Member No." := ObjAccountSignApp."BOSA No.";
                                                    ObjAccountSign."Email Address" := ObjAccountSignApp."Email Address";
                                                    ObjAccountSign.Signatory := ObjAccountSignApp.Signatory;
                                                    ObjAccountSign."Must Sign" := ObjAccountSignApp."Must Sign";
                                                    ObjAccountSign."Must be Present" := ObjAccountSignApp."Must be Present";
                                                    ObjAccountSign.Picture := ObjAccountSignApp.Picture;
                                                    ObjAccountSign.Signature := ObjAccountSignApp.Signature;
                                                    ObjAccountSign."Expiry Date" := ObjAccountSignApp."Expiry Date";
                                                    //ObjAccountSign.Insert;
                                                end;
                                            end;
                                        until ObjAccountSignApp.Next = 0;
                                    end;
                                    //END;
                                    GenJournalLine.Reset;
                                    GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
                                    GenJournalLine.SetRange("Journal Batch Name", 'REGFee');
                                    GenJournalLine.DeleteAll;

                                    ObjGenSetUp.Get();

                                    //Charge Registration Fee
                                    if ObjGenSetUp."Charge FOSA Registration Fee" = true then begin

                                        LineNo := LineNo + 10000;

                                        GenJournalLine.Init;
                                        GenJournalLine."Journal Template Name" := 'GENERAL';
                                        GenJournalLine."Journal Batch Name" := 'REGFee';
                                        GenJournalLine."Document No." := Rec."No.";
                                        GenJournalLine."Line No." := LineNo;
                                        GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                                        GenJournalLine."Account No." := VarAcctNo;
                                        GenJournalLine.Validate(GenJournalLine."Account No.");
                                        GenJournalLine."Posting Date" := Today;
                                        GenJournalLine."External Document No." := 'REGFEE/' + Format(Rec."Payroll No");
                                        GenJournalLine.Description := 'Registration Fee';
                                        GenJournalLine.Amount := ObjGenSetUp."BOSA Registration Fee Amount";
                                        GenJournalLine.Validate(GenJournalLine.Amount);
                                        GenJournalLine."Shortcut Dimension 1 Code" := 'FOSA';
                                        GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                                        GenJournalLine."Bal. Account No." := ObjGenSetUp."FOSA Registration Fee Account";
                                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                        if GenJournalLine.Amount <> 0 then
                                            //GenJournalLine.INSERT;

                                            GenJournalLine.Reset;
                                        GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
                                        GenJournalLine.SetRange("Journal Batch Name", 'REGFee');
                                        if GenJournalLine.Find('-') then begin
                                            Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco", GenJournalLine);
                                        end;
                                    end;
                                    Message('You have successfully created a %1 Product, A/C No.: %2', ObjProductsApp.Product, VarAcctNo);

                                //End Charge Registration Fee
                                until ObjProductsApp.Next = 0;
                            end;
                            Message('You have successfully Registered a New Sacco Member. Membership No.: %1.The Member will be notifed via an SMS', ObjCust."No.");
                            //==========================================================================================================End Front Office Accounts

                            ObjGenSetUp.Get();

                            //=====================================================================================================Send SMS
                            if ObjGenSetUp."Send Membership Reg SMS" = true then begin
                                VarAccounts := '';
                                ObjAccounts.Reset;
                                ObjAccounts.SetRange(ObjAccounts."BOSA Account No", VarBOSAACC);
                                if ObjAccounts.FindSet then begin
                                    repeat
                                        if ObjAccountType.Get(ObjAccounts."Account Type") then begin
                                            VarAccounts := VarAccounts + Format(ObjAccounts."No.") + ' - ' + Format(ObjAccountType."Product Short Name") + '; ';
                                        end;
                                    until ObjAccounts.Next = 0;
                                end;
                                // SFactory.FnSendSMS('MEMBERAPP', 'You member Registration has been completed. Your Member No is ' + VarBOSAACC + ' and your Accounts are: ' + VarAccounts,
                                // VarBOSAACC, Rec."Mobile Phone No");
                                SmsCodeunit.SendSmsWithID(Source::NEW_MEMBER, Rec."Group Mobile Phone No", 'Your Membership Registration has been completed. Your Member No. is ' + VarBOSAACC + ' and your Accounts are: ' + VarAccounts, VarBOSAACC, VarBOSAACC, false, 200, false, 'CBS', CreateGuid(), 'CBS');
                            end;

                            //======================================================================================================Send Email
                            if ObjGenSetUp."Send Membership Reg Email" = true then begin
                                FnSendRegistrationEmail(Rec."No.", Rec."E-Mail (Personal)", Rec."ID No.");
                            end;
                            Rec.Created := true;
                            Rec.CalcFields("Assigned No.");
                            FnRuninsertBOSAAccountNos(VarNewMembNo);//========================================================================Update Membership Account with BOSA Account Nos
                        end;
                    end;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        UpdateControls();
        SetControlAppearance();
        EditableField := true;
        // OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(RecordId);
        // CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(RecordId);
        EnabledApprovalWorkflowsExist := true;
        // if Rec."Membership Approval Status" = Rec."Membership Approval Status"::Approved then begin
        //     OpenApprovalEntriesExist := false;
        //     CanCancelApprovalForRecord := false;
        //     EnabledApprovalWorkflowsExist := false;
        // end;

        if (Rec."Membership Approval Status" = Rec."Membership Approval Status"::Approved) and (Rec."Assigned No." = '') then
            EnableCreateMember := true;
        if Rec."Membership Approval Status" <> Rec."Membership Approval Status"::Open then
            EditableField := false;
    end;

    trigger OnAfterGetRecord()
    begin
        Rec."Self Recruited" := true;
        EmployedEditable := false;
        ContractingEditable := false;
        OthersEditable := false;

        if Rec."Account Category" <> Rec."account category"::Joint then begin
            Joint2DetailsVisible := false;
        end else
            Joint2DetailsVisible := true;

        if Rec."Account Category" <> Rec."account category"::Corporate then begin
            NumberofMembersEditable := false
        end else
            NumberofMembersEditable := true;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    var
        ObjAccountTypes: record "Account Types-Saving Products";
        ObjSelectProduct: record "Membership Reg. Products Appli";
    begin
        Rec."Responsibility Centre" := UserMgt.GetSalesFilter;
        //Insert Default Account Types on Select Product============================
        /*         ObjAccountTypes.Reset;
                ObjAccountTypes.SetRange(ObjAccountTypes."Default Account", true);
                if ObjAccountTypes.FindSet then begin
                    repeat
                        ObjSelectProduct.Init;
                        ObjSelectProduct."Membership Applicaton No" :=Rec."No.";
                        ObjSelectProduct.Product := ObjAccountTypes.Code;
                        ObjSelectProduct."Product Name" := ObjAccountTypes.Description;
                        ObjSelectProduct."Product Source" := ObjAccountTypes."Activity Code";
                        ObjSelectProduct."Show On List" := ObjAccountTypes."Show On List";
                        ObjSelectProduct."Account Category":= ObjSelectProduct."Account Category"::Corporate;
                        ObjSelectProduct.Insert;
                    until ObjAccountTypes.Next = 0;
                end;  */
        //End Insert Default Account Types on Select Product============================
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        GenSetUp.Get();
        Rec."Monthly Contribution" := GenSetUp."Corporate Minimum Monthly Cont";
        Rec."Account Category" := Rec."account category"::Corporate;
    end;

    trigger OnOpenPage()
    begin

        if UserMgt.GetSalesFilter <> '' then begin
            Rec.FilterGroup(2);
            Rec.SetRange("Responsibility Centre", UserMgt.GetSalesFilter);
            Rec.FilterGroup(0);
        end;
    end;

    var
        StatusPermissions: Record "Status Change Permision";
        Cust: Record Customer;
        Accounts: Record Vendor;
        AcctNo: Code[20];
        NextOfKinApp: Record "Member App Nominee";
        MAccountSign: Record "Member Account Signatories";
        PAccountSign: Record "FOSA Account Sign. Details";
        ObjAccountSignApp: Record "Member App Signatories";
        Acc: Record Vendor;
        UsersID: Record User;
        Nok: Record "Member App Nominee";
        NOKBOSA: Record "Members Next of Kin";
        BOSAACC: Code[20];
        NextOfKin: Record "Members Next of Kin";
        PictureExists: Boolean;
        text001: label 'Status must be open';
        UserMgt: Codeunit "User Setup Management";
        NotificationE: Codeunit Mail;
        SmsCodeunit: CodeUnit "Sms Management";
        Source: Option NEW_MEMBER,NEW_ACCOUNT,LOAN_ACCOUNT_APPROVAL,DEPOSIT_CONFIRMATION,CASH_WITHDRAWAL_CONFIRM,LOAN_APPLICATION,LOAN_APPRAISAL,LOAN_GUARANTORS,LOAN_REJECTED,LOAN_POSTED,LOAN_DEFAULTED,SALARY_PROCESSING,TELLER_CASH_DEPOSIT,TELLER_CASH_WITHDRAWAL,TELLER_CHEQUE_DEPOSIT,FIXED_DEPOSIT_MATURITY,INTERACCOUNT_TRANSFER,ACCOUNT_STATUS,STATUS_ORDER,EFT_EFFECTED,ATM_APPLICATION_FAILED,ATM_COLLECTION,MBANKING,MEMBER_CHANGES,CASHIER_BELOW_LIMIT,CASHIER_ABOVE_LIMIT,INTERNETBANKING,CRM,MOBILE_PIN;
        MailBody: Text[250];
        ccEmail: Text[1000];
        toEmail: Text[1000];
        GenSetUp: Record "Sacco General Set-Up";
        ClearingAcctNo: Code[20];
        AdvrAcctNo: Code[20];
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ","Purchase Requisition",RFQ,"Store Requisition","Payment Voucher",MembershipApplication,LoanApplication,LoanDisbursement,ProductApplication,StandingOrder,MembershipWithdrawal,ATMCard,GuarantorRecovery;
        AccountTypes: Record "Account Types-Saving Products";
        DivAcctNo: Code[20];
        NameEditable: Boolean;
        AddressEditable: Boolean;
        NoEditable: Boolean;
        DioceseEditable: Boolean;
        HomeAdressEditable: Boolean;
        GlobalDim1Editable: Boolean;
        GlobalDim2Editable: Boolean;
        CustPostingGroupEdit: Boolean;
        PhoneEditable: Boolean;
        MaritalstatusEditable: Boolean;
        IDNoEditable: Boolean;
        RegistrationDateEdit: Boolean;
        OfficeBranchEditable: Boolean;
        DeptEditable: Boolean;
        SectionEditable: Boolean;
        OccupationEditable: Boolean;
        DesignationEdiatble: Boolean;
        EmployerCodeEditable: Boolean;
        DOBEditable: Boolean;
        EmailEdiatble: Boolean;
        StaffNoEditable: Boolean;
        GenderEditable: Boolean;
        MonthlyContributionEdit: Boolean;
        PostCodeEditable: Boolean;
        CityEditable: Boolean;
        WitnessEditable: Boolean;
        StatusEditable: Boolean;
        BankCodeEditable: Boolean;
        BranchCodeEditable: Boolean;
        BankAccountNoEditable: Boolean;
        VillageResidence: Boolean;
        SignatureExists: Boolean;
        NewMembNo: Code[30];
        Saccosetup: Record "Sacco No. Series";
        NOkApp: Record "Member App Nominee";
        TitleEditable: Boolean;
        PostalCodeEditable: Boolean;
        HomeAddressPostalCodeEditable: Boolean;
        HomeTownEditable: Boolean;
        RecruitedEditable: Boolean;
        ContactPEditable: Boolean;
        ContactPRelationEditable: Boolean;
        ContactPOccupationEditable: Boolean;
        CopyOFIDEditable: Boolean;
        CopyofPassportEditable: Boolean;
        SpecimenEditable: Boolean;
        ContactPPhoneEditable: Boolean;
        PictureEditable: Boolean;
        SignatureEditable: Boolean;
        PayslipEditable: Boolean;
        RegistrationFeeEditable: Boolean;
        CopyofKRAPinEditable: Boolean;
        membertypeEditable: Boolean;
        FistnameEditable: Boolean;
        dateofbirth2: Boolean;
        registrationeditable: Boolean;
        EstablishdateEditable: Boolean;
        RegistrationofficeEditable: Boolean;
        Signature2Editable: Boolean;
        Picture2Editable: Boolean;
        MembApp: Record "Membership Applications";
        title2Editable: Boolean;
        mobile3editable: Boolean;
        emailaddresEditable: Boolean;
        gender2editable: Boolean;
        postal2Editable: Boolean;
        town2Editable: Boolean;
        passpoetEditable: Boolean;
        maritalstatus2Editable: Boolean;
        payrollno2editable: Boolean;
        Employercode2Editable: Boolean;
        address3Editable: Boolean;
        DateOfAppointmentEDitable: Boolean;
        TermsofServiceEditable: Boolean;
        HomePostalCode2Editable: Boolean;
        Employername2Editable: Boolean;
        ageEditable: Boolean;
        CopyofconstitutionEditable: Boolean;
        Table_id: Integer;
        Doc_No: Code[20];
        Doc_Type: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,TransportRequest,Maintenance,Fuel,ImporterExporter,"Import Permit","Export Permit",TR,"Safari Notice","Student Applications","Water Research","Consultancy Requests","Consultancy Proposals","Meals Bookings","General Journal","Student Admissions","Staff Claim",KitchenStoreRequisition,"Leave Application","Account Opening";
        RecruitedByEditable: Boolean;
        RecruiterNameEditable: Boolean;
        RecruiterRelationShipEditable: Boolean;
        AccoutTypes: Record "Account Types-Saving Products";
        NomineeEditable: Boolean;
        TownEditable: Boolean;
        CountryEditable: Boolean;
        MobileEditable: Boolean;
        PassportEditable: Boolean;
        RejoiningDateEditable: Boolean;
        PrevousRegDateEditable: Boolean;
        AppCategoryEditable: Boolean;
        RegistrationDateEditable: Boolean;
        DataSheet: Record "Data Sheet Main";
        SMSMessage: Record "SMS Messages";
        iEntryNo: Integer;
        Cuat: Integer;
        EmployedEditable: Boolean;
        ContractingEditable: Boolean;
        OthersEditable: Boolean;
        Joint2DetailsVisible: Boolean;
        ProductsApp: Record "Membership Reg. Products Appli";
        NextofKinFOSA: Record "FOSA Account NOK Details";
        NumberofMembersEditable: Boolean;
        OpenApprovalEntriesExist: Boolean;
        CanCancelApprovalForRecord: Boolean;
        OpenApprovalEntriesExistForCurrUser: Boolean;
        canSendApproval: Boolean;
        canCreate: Boolean;
        EnabledApprovalWorkflowsExist: Boolean;
        EnableCreateMember: Boolean;
        //ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        WorkflowManagement: Codeunit WorkflowIntegration;
        GenJournalLine: Record "Gen. Journal Line";
        LineNo: Integer;
        SFactory: Codeunit "Au Factory";
        WelcomeMessage: label '<p style="font-family:Verdana,Arial;font-size:10pt">Dear<b> %1,</b></p><p style="font-family:Verdana,Arial;font-size:9pt">Welcome to Kingdom Sacco</p><p style="font-family:Verdana,Arial;font-size:9pt">This is to confirm that your membership Application has been received and Undergoing Approval</p><p style="font-family:Verdana,Arial;font-size:9pt"> </b></p><br>Regards<p>%3</p><p><b>KINGDOM SACCO LTD</b></p>';
        RegistrationMessage: label '<p style="font-family:Verdana,Arial;font-size:10pt">Dear<b> %1,</b></p><p style="font-family:Verdana,Arial;font-size:9pt">Welcome to  Kingdom Sacco</p><p style="font-family:Verdana,Arial;font-size:9pt">This is to confirm that your membership registration has been successfully processed</p><p style="font-family:Verdana,Arial;font-size:9pt">Your membership number is <b>%2</b></p><br>Regards<p>%3</p><p><b>KINGDOM SACCO LTD</b></p>';
        EditableField: Boolean;
        RefereeEditable: Boolean;
        EmailIndemnifiedEditable: Boolean;
        SendEStatementsEditable: Boolean;
        ObjAccountAppAgent: Record "Account Agents App Details";
        ObjAccountAgent: Record "Account Agent Details";
        ObjMemberAppAgent: Record "Member Agents App Details";
        ObjMemberAgent: Record "Member Agent Details";
        IdentificationDocTypeEditable: Boolean;
        PhysicalAddressEditable: Boolean;
        MonthlyIncomeEditable: Boolean;
        WkFlwIntegration: codeunit WorkflowIntegration;
        ObjAccountAgents: Record "Account Agent Details";
        ObjMembers: Record Customer;
        ObjBOSAAccount: Record "BOSA Accounts No Buffer";
        CompInfo: Record "Company Information";
        ObjProductsApp: Record "Membership Reg. Products Appli";
        ObjCust: Record Customer;
        ObjSaccosetup: Record "Sacco General Set-Up";
        ObjMemberNoseries: Record "Member Accounts No Series";
        VarNewMembNo: Code[30];
        ObjNextOfKinApp: Record "Member App Nominee";
        ObjNextOfKin: Record "Members Next of Kin";
        ObjAccountSign: Record "FOSA Account Sign. Details";
        VarAcctNo: Code[30];
        VarBOSAACC: Code[30];
        ObjAccounts: Record Vendor;
        ObjNextofKinFOSA: Record "FOSA Account NOK Details";
        ObjGenSetUp: Record "Sacco General Set-Up";
        VarAccountDescription: Text;
        VarAccountTypes: Code[250];
        ObjAccountType: Record "Account Types-Saving Products";
        VarMemberName: Text;
        SurestepFactory: Codeunit "Au Factory";
        VarTextExtension: Text;
        VarTextExtensionII: Text;
        VarEmailSubject: Text;
        VarEmailBody: Text;
        ObjNoSeries: Record "Sacco No. Series";
        NoSeriesMgt: Codeunit "No. Series";
        VarDocumentNo: Code[30];
        CoveragePercentStyle: Text;
        ObjEntitiesAMLEntries: Record "Entities Customer Risk Rate";


    procedure UpdateControls()
    begin

        if Rec."Membership Approval Status" = Rec."Membership Approval Status"::Approved then begin
            NameEditable := false;
            NoEditable := false;
            AddressEditable := false;
            GlobalDim1Editable := false;
            GlobalDim2Editable := false;
            CustPostingGroupEdit := false;
            PhoneEditable := false;
            MaritalstatusEditable := false;
            IDNoEditable := false;
            PhoneEditable := false;
            RegistrationDateEdit := false;
            OfficeBranchEditable := false;
            DeptEditable := false;
            SectionEditable := false;
            OccupationEditable := false;
            DesignationEdiatble := false;
            EmployerCodeEditable := false;
            DOBEditable := false;
            EmailEdiatble := false;
            StaffNoEditable := false;
            GenderEditable := false;
            MonthlyContributionEdit := false;
            PostCodeEditable := false;
            CityEditable := false;
            WitnessEditable := false;
            BankCodeEditable := false;
            BranchCodeEditable := false;
            BankAccountNoEditable := false;
            VillageResidence := false;
            TitleEditable := false;
            PostalCodeEditable := false;
            HomeAddressPostalCodeEditable := false;
            HomeTownEditable := false;
            RecruitedEditable := false;
            ContactPEditable := false;
            ContactPRelationEditable := false;
            ContactPOccupationEditable := false;
            CopyOFIDEditable := false;
            CopyofPassportEditable := false;
            SpecimenEditable := false;
            ContactPPhoneEditable := false;
            HomeAdressEditable := false;
            PictureEditable := false;
            SignatureEditable := false;
            PayslipEditable := false;
            RegistrationFeeEditable := false;
            title2Editable := false;
            emailaddresEditable := false;
            gender2editable := false;
            HomePostalCode2Editable := false;
            town2Editable := false;
            passpoetEditable := false;
            maritalstatus2Editable := false;
            payrollno2editable := false;
            Employercode2Editable := false;
            address3Editable := false;
            Employername2Editable := false;
            ageEditable := false;
            CopyofconstitutionEditable := false;
            NomineeEditable := false;
            TownEditable := false;
            CountryEditable := false;
            MobileEditable := false;
            PassportEditable := false;
            RejoiningDateEditable := false;
            PrevousRegDateEditable := false;
            AppCategoryEditable := false;
            RegistrationDateEditable := false;
            TermsofServiceEditable := false;
            EmployerCodeEditable := false;
            RecruitedByEditable := false;
            EmailIndemnifiedEditable := false;
            SendEStatementsEditable := false;
            EmailIndemnifiedEditable := false;
            SendEStatementsEditable := false;
            IdentificationDocTypeEditable := false;
            PhysicalAddressEditable := false;
            RefereeEditable := false;
            MonthlyIncomeEditable := false;
        end;

        if Rec."Membership Approval Status" = Rec."Membership Approval Status"::"Pending Approval" then begin
            NameEditable := false;
            NoEditable := false;
            AddressEditable := false;
            GlobalDim1Editable := false;
            GlobalDim2Editable := false;
            CustPostingGroupEdit := false;
            PhoneEditable := false;
            MaritalstatusEditable := false;
            IDNoEditable := false;
            PhoneEditable := false;
            RegistrationDateEdit := false;
            OfficeBranchEditable := false;
            DeptEditable := false;
            SectionEditable := false;
            OccupationEditable := false;
            DesignationEdiatble := false;
            EmployerCodeEditable := false;
            DOBEditable := false;
            EmailEdiatble := false;
            StaffNoEditable := false;
            GenderEditable := false;
            MonthlyContributionEdit := false;
            PostCodeEditable := false;
            CityEditable := false;
            WitnessEditable := false;
            BankCodeEditable := false;
            BranchCodeEditable := false;
            BankAccountNoEditable := false;
            VillageResidence := false;
            TitleEditable := false;
            PostalCodeEditable := false;
            HomeAddressPostalCodeEditable := false;
            HomeTownEditable := false;
            RecruitedEditable := false;
            ContactPEditable := false;
            ContactPRelationEditable := false;
            ContactPOccupationEditable := false;
            CopyOFIDEditable := false;
            CopyofPassportEditable := false;
            SpecimenEditable := false;
            ContactPPhoneEditable := false;
            HomeAdressEditable := false;
            PictureEditable := false;
            SignatureEditable := false;
            PayslipEditable := false;
            RegistrationFeeEditable := false;
            title2Editable := false;
            emailaddresEditable := false;
            gender2editable := false;
            HomePostalCode2Editable := false;
            town2Editable := false;
            passpoetEditable := false;
            maritalstatus2Editable := false;
            payrollno2editable := false;
            Employercode2Editable := false;
            address3Editable := false;
            Employername2Editable := false;
            ageEditable := false;
            CopyofconstitutionEditable := false;
            NomineeEditable := false;
            TownEditable := false;
            CountryEditable := false;
            MobileEditable := false;
            PassportEditable := false;
            RejoiningDateEditable := false;
            PrevousRegDateEditable := false;
            AppCategoryEditable := false;
            RegistrationDateEditable := false;
            TermsofServiceEditable := false;
            EmployerCodeEditable := false;
            RecruitedByEditable := false;
            EmailIndemnifiedEditable := false;
            SendEStatementsEditable := false;
            EmailIndemnifiedEditable := false;
            SendEStatementsEditable := false;
            IdentificationDocTypeEditable := false;
            PhysicalAddressEditable := false;
            RefereeEditable := false;
            MonthlyIncomeEditable := false;
        end;


        if Rec."Membership Approval Status" = Rec."Membership Approval Status"::Open then begin
            NameEditable := true;
            AddressEditable := true;
            GlobalDim1Editable := true;
            GlobalDim2Editable := true;
            CustPostingGroupEdit := true;
            PhoneEditable := true;
            MaritalstatusEditable := true;
            IDNoEditable := true;
            PhoneEditable := true;
            RegistrationDateEdit := true;
            OfficeBranchEditable := true;
            DeptEditable := true;
            SectionEditable := true;
            OccupationEditable := true;
            DesignationEdiatble := true;
            EmployerCodeEditable := true;
            DOBEditable := true;
            EmailEdiatble := true;
            StaffNoEditable := true;
            GenderEditable := true;
            MonthlyContributionEdit := true;
            PostCodeEditable := true;
            CityEditable := true;
            WitnessEditable := true;
            BankCodeEditable := true;
            BranchCodeEditable := true;
            BankAccountNoEditable := true;
            VillageResidence := true;
            TitleEditable := true;
            PostalCodeEditable := true;
            HomeAddressPostalCodeEditable := true;
            HomeTownEditable := true;
            RecruitedEditable := true;
            ContactPEditable := true;
            ContactPRelationEditable := true;
            ContactPOccupationEditable := true;
            CopyOFIDEditable := true;
            CopyofPassportEditable := true;
            SpecimenEditable := true;
            ContactPPhoneEditable := true;
            HomeAdressEditable := true;
            PictureEditable := true;
            SignatureEditable := true;
            PayslipEditable := true;
            RegistrationFeeEditable := true;
            title2Editable := true;
            emailaddresEditable := true;
            gender2editable := true;
            HomePostalCode2Editable := true;
            town2Editable := true;
            passpoetEditable := true;
            maritalstatus2Editable := true;
            payrollno2editable := true;
            Employercode2Editable := true;
            address3Editable := true;
            Employername2Editable := true;
            ageEditable := true;
            mobile3editable := true;
            CopyofconstitutionEditable := true;
            NomineeEditable := true;
            TownEditable := true;
            CountryEditable := true;
            MobileEditable := true;
            PassportEditable := true;
            RejoiningDateEditable := true;
            PrevousRegDateEditable := true;
            AppCategoryEditable := true;
            RegistrationDateEditable := true;
            TermsofServiceEditable := true;
            EmployerCodeEditable := true;
            RecruitedByEditable := true;
            EmailIndemnifiedEditable := true;
            SendEStatementsEditable := true;
            EmailIndemnifiedEditable := true;
            SendEStatementsEditable := true;
            IdentificationDocTypeEditable := true;
            PhysicalAddressEditable := true;
            RefereeEditable := true;
            MonthlyIncomeEditable := true;
        end
    end;

    local procedure SelfRecruitedControl()
    begin
        /*
            IF "Self Recruited"=TRUE THEN BEGIN
             RecruitedByEditable:=FALSE;
             RecruiterNameEditable:=FALSE;
             RecruiterRelationShipEditable:=FALSE;
             END ELSE
            IF "Self Recruited"<>TRUE THEN BEGIN
             RecruitedByEditable:=TRUE;
             RecruiterNameEditable:=TRUE;
             RecruiterRelationShipEditable:=TRUE;
             END;
             */

    end;


    procedure FnSendReceivedApplicationSMS()
    begin

        GenSetUp.Get;
        CompInfo.Get;



        //SMS MESSAGE
        SMSMessage.Reset;
        if SMSMessage.Find('+') then begin
            iEntryNo := SMSMessage."Entry No";
            iEntryNo := iEntryNo + 1;
        end
        else begin
            iEntryNo := 1;
        end;


        SMSMessage.Init;
        SMSMessage."Entry No" := iEntryNo;
        SMSMessage."Batch No" := Rec."No.";
        SMSMessage."Document No" := '';
        SMSMessage."Account No" := BOSAACC;
        SMSMessage."Date Entered" := Today;
        SMSMessage."Time Entered" := Time;
        SMSMessage.Source := 'MEMBAPP';
        SMSMessage."Entered By" := UserId;
        SMSMessage."Sent To Server" := SMSMessage."sent to server"::No;
        SMSMessage."SMS Message" := 'Dear Member your application has been received and going through approval,'
        + ' ' + CompInfo.Name + ' ' + GenSetUp."Customer Care No";
        SMSMessage."Telephone No" := Rec."Mobile Phone No";
        if Rec."Mobile Phone No" <> '' then
            SMSMessage.Insert;
    end;


    procedure FnSendRegistrationSMS()
    begin

        GenSetUp.Get;
        CompInfo.Get;

        //SMS MESSAGE
        SMSMessage.Reset;
        if SMSMessage.Find('+') then begin
            iEntryNo := SMSMessage."Entry No";
            iEntryNo := iEntryNo + 1;
        end
        else begin
            iEntryNo := 1;
        end;

        SMSMessage.Init;
        SMSMessage."Entry No" := iEntryNo;
        SMSMessage."Batch No" := Rec."No.";
        SMSMessage."Document No" := '';
        SMSMessage."Account No" := BOSAACC;
        SMSMessage."Date Entered" := Today;
        SMSMessage."Time Entered" := Time;
        SMSMessage.Source := 'MEMBREG';
        SMSMessage."Entered By" := UserId;
        SMSMessage."Sent To Server" := SMSMessage."sent to server"::No;
        SMSMessage."SMS Message" := 'Dear Member you have been registered successfully, your Membership No is '
        + BOSAACC + ' Name ' + Rec.Name + ' ' + CompInfo.Name + ' ' + GenSetUp."Customer Care No";
        SMSMessage."Telephone No" := Rec."Mobile Phone No";
        if Rec."Mobile Phone No" <> '' then
            SMSMessage.Insert;
    end;

    local procedure UpdateViewLogEntries()
    begin
        /*ViewLog.INIT;
        ViewLog."Entry No.":=ViewLog."Entry No."+1;
        ViewLog."User ID":=USERID;
        ViewLog."Table No.":=51516364;
        ViewLog."Table Caption":='Members Register';
        ViewLog.Date:=TODAY;
        ViewLog.Time:=TIME;
        */

    end;

    local procedure FnCheckfieldrestriction()
    begin
        if (Rec."Account Category" = Rec."account category"::Individual) then begin
            //CALCFIELDS(Picture,Signature);
            Rec.TestField(Name);
            Rec.TestField("ID No.");
            Rec.TestField("Mobile Phone No");
            //TESTFIELD("Employer Code");
            //TESTFIELD("Personal No");
            Rec.TestField("Monthly Contribution");
            Rec.TestField("Member's Residence");
            Rec.TestField(Gender);
            Rec.TestField("Employment Info");
            Rec.TestField("Address 2");

            //TESTFIELD("Copy of Current Payslip");
            //TESTFIELD("Member Registration Fee Receiv");
            Rec.TestField("Customer Posting Group");
            Rec.TestField("Global Dimension 1 Code");
            //TESTFIELD("Global Dimension 2 Code");
            //TESTFIELD("Contact Person");
            //TESTFIELD("Contact Person Phone");
            //IF Picture=0 OR Signature=0 THEN
            //ERROR(Insert )
        end else

            if (Rec."Account Category" = Rec."account category"::Corporate) or (Rec."Account Category" = Rec."account category"::Joint) then begin
                Rec.TestField(Name);
                Rec.TestField("Registration No");
                Rec.TestField("Copy of KRA Pin");
                Rec.TestField("Member Registration Fee Receiv");
                ///TESTFIELD("Account Category");
                Rec.TestField("Customer Posting Group");
                Rec.TestField("Global Dimension 1 Code");
                Rec.TestField("Global Dimension 2 Code");
                //TESTFIELD("Copy of constitution");
                Rec.TestField("Contact Person");
                Rec.TestField("Contact Person Phone");

            end;
    end;

    local procedure FnSendReceivedApplicationEmail(ApplicationNo: Code[20]; Email: Text[50]; IDNo: Code[20])
    var
        Memb: Record "Membership Applications";
        // SMTPMail: Codeunit "SMTP Mail";
        // SMTPSetup: Record "SMTP Mail Setup";
        FileName: Text[100];
        Attachment: Text[250];
        CompanyInfo: Record "Company Information";
        Recipient: list of [Text];
    begin
        //   SMTPSetup.Get();

        Memb.Reset;
        Memb.SetRange(Memb."No.", ApplicationNo);
        if Memb.Find('-') then begin
            if Email = '' then begin
                Error('Email Address Missing for Member Application number' + '-' + Memb."No.");
            end;
            // if Memb."E-Mail (Personal)" <> '' then
            //     Recipient.Add(Email);
            // SMTPMail.CreateMessage(SMTPSetup."Email Sender Name", SMTPSetup."Email Sender Address", Recipient, 'Membership Application', '', true);
            // SMTPMail.AppendBody(StrSubstNo(WelcomeMessage, Memb.Name, IDNo, UserId));
            // SMTPMail.AppendBody(SMTPSetup."Email Sender Name");
            // SMTPMail.AppendBody('<br><br>');
            // SMTPMail.AddAttachment(FileName, Attachment);
            // SMTPMail.Send;
        end;
    end;

    local procedure FnSendRegistrationEmail(ApplicationNo: Code[20]; Email: Text[50]; IDNo: Code[20])
    var
        Memb: Record "Membership Applications";
        //SMTPMail: Codeunit "SMTP Mail";
        //SMTPSetup: Record "SMTP Mail Setup";
        FileName: Text[100];
        Attachment: Text[250];
        CompanyInfo: Record "Company Information";
    begin
        //  SMTPSetup.Get();

        VarAccountDescription := '';
        VarAccountTypes := '<p><ul style="list-style-type:square">';

        ObjAccounts.Reset;
        ObjAccounts.SetRange(ObjAccounts."BOSA Account No", VarBOSAACC);
        if ObjAccounts.FindSet then begin
            repeat

                if ObjAccountType.Get(ObjAccounts."Account Type") then begin
                    VarAccountDescription := ObjAccountType.Description;
                end;

                VarAccountTypes := VarAccountTypes + '<li>' + Format(ObjAccounts."No.") + ' - ' + Format(VarAccountDescription) + '</li>';
            until ObjAccounts.Next = 0;
        end;
        VarAccountTypes := VarAccountTypes + '</ul></p>';


        VarMemberName := SurestepFactory.FnConvertTexttoBeginingWordstostartWithCapital(Rec.Name);
        VarTextExtension := '<p>At Kingdom Sacco, we provide you with a variety of efficient and convenient services that enable you to:</p>' +
               '<p>1. Make Automated Deposit to your account through any Equity Bank Branch to our Account No. 15172262333007 and any Family Bank Branch via Utility Payment. You will provide your Kingdom Sacco 12-digit Account Number.</p>' +
               '<p>2. Make Automated Deposits through MPESA or Equitel/Equity Bank Agents using our Paybill No. 521000 and through Family Bank Agents using Bill Payment Code 020, then provide your Account Number and Amount.</p>' +
               '<p>3. Transact through our Mobile Banking Channels to Apply for Loans, MPESA Withdrawal, Account Transfers, Account Enquiries, Statement Requests etc. You can download Kingdom Sacco Mobile App on Google Play Store</p>';

        VarTextExtensionII := '<p>5. Access funds via Cardless ATM Withdrawal Service with Family Bank accessible to all our registered Mobile Banking Users. For guidelines send the word CARDLESS to 0705270662 or use our Mobile App.</p>' +
               '<p>6. Apply for a Cheque Book and initiate cheque payments from your account at Kingdom Sacco.</p>' +
               '<p>7. Process your salary to your Kingdom Sacco Account and benefit from very affordable salary loans.</p>' +
               '<p>8. Operate an Ufalme Account and save in order to acquire Land/Housing in our upcoming projects.</p>' +
               '<p>Visit our website <a href="http://www.kingdomsacco.com">www.kingdomsacco.com</a> for more information on our service offering.</p>' +
               '<p>Thank you for choosing Kingdom Sacco. Our objective is to empower you economically and socially by promoting a Savings and Investments culture and providing affordable credit.</p>';


        VarEmailSubject := 'WELCOME TO KINGDOM SACCO';
        VarEmailBody := 'Welcome and Thank you for Joining Kingdom Sacco. Your Membership Number is ' + VarBOSAACC + '. Your Account Numbers are: ' + VarAccountTypes + VarTextExtension + VarTextExtensionII;

        //   SurestepFactory.FnSendStatementViaMail(VarMemberName, VarEmailSubject, VarEmailBody, "E-Mail (Personal)", '', '');
    end;

    local procedure FnUpdateMemberSubAccounts()
    begin
        // Saccosetup.Get();

        // //SHARE CAPITAL
        // ProductsApp.Reset;
        // ProductsApp.SetRange(ProductsApp."Membership Applicaton No", Rec."No.");
        // ProductsApp.SetRange(ProductsApp."Product Source", ProductsApp."product source"::BOSA);
        // ProductsApp.SetRange(ProductsApp.Product, '601');
        // if ProductsApp.FindSet then begin
        //     ObjMembers.Reset;
        //     ObjMembers.SetRange(ObjMembers."ID No.", Rec."ID No.");
        //     if ObjMembers.FindSet then begin
        //         if Rec."Global Dimension 2 Code" = 'NAIROBI' then begin
        //             ObjMembers."Share Capital No" := IncStr(Saccosetup."Share Capital Account No(HQ)");
        //             Saccosetup."Share Capital Account No(HQ)" := ObjMembers."Share Capital No";
        //             ObjMembers.Modify;
        //             Saccosetup.Modify;

        //             ObjBOSAAccount.Init;
        //             ObjBOSAAccount."Account No" := ObjMembers."Share Capital No";
        //             ObjBOSAAccount."Transaction Type" := ObjBOSAAccount."transaction type"::"Share Capital";
        //             ObjBOSAAccount."Member No" := ObjMembers."No.";
        //             ObjBOSAAccount."Account Name" := ObjMembers.Name;
        //             ObjBOSAAccount."ID No" := ObjMembers."ID No.";
        //             ObjBOSAAccount."Account Type" := '601';
        //             ObjBOSAAccount.Insert;
        //         end;

        //         if Rec."Global Dimension 2 Code" = 'NAIVASHA' then begin
        //             ObjMembers."Share Capital No" := IncStr(Saccosetup."Share Capital Account No(NAIV)");
        //             Saccosetup."Share Capital Account No(NAIV)" := ObjMembers."Share Capital No";
        //             ObjMembers.Modify;
        //             Saccosetup.Modify;

        //             ObjBOSAAccount.Init;
        //             ObjBOSAAccount."Account No" := ObjMembers."Share Capital No";
        //             ObjBOSAAccount."Transaction Type" := ObjBOSAAccount."transaction type"::"Share Capital";
        //             ObjBOSAAccount."Member No" := ObjMembers."No.";
        //             ObjBOSAAccount."Account Name" := ObjMembers.Name;
        //             ObjBOSAAccount."ID No" := ObjMembers."ID No.";
        //             ObjBOSAAccount."Account Type" := '601';
        //             ObjBOSAAccount.Insert;
        //         end;

        //         if Rec."Global Dimension 2 Code" = 'NAKURU' then begin
        //             ObjMembers."Share Capital No" := IncStr(Saccosetup."Share Capital Account No(NKR)");
        //             Saccosetup."Share Capital Account No(NKR)" := ObjMembers."Share Capital No";
        //             ObjMembers.Modify;
        //             Saccosetup.Modify;

        //             ObjBOSAAccount.Init;
        //             ObjBOSAAccount."Account No" := ObjMembers."Share Capital No";
        //             ObjBOSAAccount."Transaction Type" := ObjBOSAAccount."transaction type"::"Share Capital";
        //             ObjBOSAAccount."Member No" := ObjMembers."No.";
        //             ObjBOSAAccount."Account Name" := ObjMembers.Name;
        //             ObjBOSAAccount."ID No" := ObjMembers."ID No.";
        //             ObjBOSAAccount."Account Type" := '601';
        //             ObjBOSAAccount.Insert;
        //         end;

        //         if Rec."Global Dimension 2 Code" = 'ELDORET' then begin
        //             ObjMembers."Share Capital No" := IncStr(Saccosetup."Share Capital Account No(ELD)");
        //             Saccosetup."Share Capital Account No(ELD)" := ObjMembers."Share Capital No";
        //             ObjMembers.Modify;
        //             Saccosetup.Modify;

        //             ObjBOSAAccount.Init;
        //             ObjBOSAAccount."Account No" := ObjMembers."Share Capital No";
        //             ObjBOSAAccount."Transaction Type" := ObjBOSAAccount."transaction type"::"Share Capital";
        //             ObjBOSAAccount."Member No" := ObjMembers."No.";
        //             ObjBOSAAccount."Account Name" := ObjMembers.Name;
        //             ObjBOSAAccount."ID No" := ObjMembers."ID No.";
        //             ObjBOSAAccount."Account Type" := '601';
        //             ObjBOSAAccount.Insert;
        //         end;

        //         if Rec."Global Dimension 2 Code" = 'MOMBASA' then begin
        //             ObjMembers."Share Capital No" := IncStr(Saccosetup."Share Capital Account No(MSA)");
        //             Saccosetup."Share Capital Account No(MSA)" := ObjMembers."Share Capital No";
        //             ObjMembers.Modify;
        //             Saccosetup.Modify;

        //             ObjBOSAAccount.Init;
        //             ObjBOSAAccount."Account No" := ObjMembers."Share Capital No";
        //             ObjBOSAAccount."Transaction Type" := ObjBOSAAccount."transaction type"::"Share Capital";
        //             ObjBOSAAccount."Member No" := ObjMembers."No.";
        //             ObjBOSAAccount."Account Name" := ObjMembers.Name;
        //             ObjBOSAAccount."ID No" := ObjMembers."ID No.";
        //             ObjBOSAAccount."Account Type" := '601';
        //             ObjBOSAAccount.Insert;
        //         end;
        //     end;
        // end;
        // //END SHARE CAPITAL

        // //DEPOSITS CONTRIBUTION
        // ProductsApp.Reset;
        // ProductsApp.SetRange(ProductsApp."Membership Applicaton No", Rec."No.");
        // ProductsApp.SetRange(ProductsApp."Product Source", ProductsApp."product source"::BOSA);
        // ProductsApp.SetRange(ProductsApp.Product, '602');
        // if ProductsApp.FindSet then begin
        //     ObjMembers.Reset;
        //     ObjMembers.SetRange(ObjMembers."ID No.", Rec."ID No.");
        //     if ObjMembers.FindSet then begin
        //         if Rec."Global Dimension 2 Code" = 'NAIROBI' then begin
        //             ObjMembers."Deposits Account No" := IncStr(Saccosetup."Deposits Account No(HQ)");
        //             Saccosetup."Deposits Account No(HQ)" := ObjMembers."Deposits Account No";
        //             ObjMembers.Modify;
        //             Saccosetup.Modify;

        //             ObjBOSAAccount.Init;
        //             ObjBOSAAccount."Account No" := ObjMembers."Deposits Account No";
        //             ObjBOSAAccount."Transaction Type" := ObjBOSAAccount."transaction type"::"Deposit Contribution";
        //             ObjBOSAAccount."Member No" := ObjMembers."No.";
        //             ObjBOSAAccount."Account Name" := ObjMembers.Name;
        //             ObjBOSAAccount."ID No" := ObjMembers."ID No.";
        //             ObjBOSAAccount."Account Type" := '602';
        //             ObjBOSAAccount.Insert;
        //         end;

        //         if Rec."Global Dimension 2 Code" = 'NAIVASHA' then begin
        //             ObjMembers."Deposits Account No" := IncStr(Saccosetup."Deposits Account No(NAIV)");
        //             Saccosetup."Deposits Account No(NAIV)" := ObjMembers."Deposits Account No";
        //             ObjMembers.Modify;
        //             Saccosetup.Modify;

        //             ObjBOSAAccount.Init;
        //             ObjBOSAAccount."Account No" := ObjMembers."Deposits Account No";
        //             ObjBOSAAccount."Transaction Type" := ObjBOSAAccount."transaction type"::"Deposit Contribution";
        //             ObjBOSAAccount."Member No" := ObjMembers."No.";
        //             ObjBOSAAccount."Account Name" := ObjMembers.Name;
        //             ObjBOSAAccount."ID No" := ObjMembers."ID No.";
        //             ObjBOSAAccount."Account Type" := '602';
        //             ObjBOSAAccount.Insert;
        //         end;

        //         if Rec."Global Dimension 2 Code" = 'NAKURU' then begin
        //             ObjMembers."Deposits Account No" := IncStr(Saccosetup."Deposits Account No(NKR)");
        //             Saccosetup."Deposits Account No(NKR)" := ObjMembers."Deposits Account No";
        //             ObjMembers.Modify;
        //             Saccosetup.Modify;

        //             ObjBOSAAccount.Init;
        //             ObjBOSAAccount."Account No" := ObjMembers."Deposits Account No";
        //             ObjBOSAAccount."Transaction Type" := ObjBOSAAccount."transaction type"::"Deposit Contribution";
        //             ObjBOSAAccount."Member No" := ObjMembers."No.";
        //             ObjBOSAAccount."Account Name" := ObjMembers.Name;
        //             ObjBOSAAccount."ID No" := ObjMembers."ID No.";
        //             ObjBOSAAccount."Account Type" := '602';
        //             ObjBOSAAccount.Insert;
        //         end;
        //         if Rec."Global Dimension 2 Code" = 'ELDORET' then begin
        //             ObjMembers."Deposits Account No" := IncStr(Saccosetup."Deposits Account No(ELD)");
        //             Saccosetup."Deposits Account No(ELD)" := ObjMembers."Deposits Account No";
        //             ObjMembers.Modify;
        //             Saccosetup.Modify;

        //             ObjBOSAAccount.Init;
        //             ObjBOSAAccount."Account No" := ObjMembers."Deposits Account No";
        //             ObjBOSAAccount."Transaction Type" := ObjBOSAAccount."transaction type"::"Deposit Contribution";
        //             ObjBOSAAccount."Member No" := ObjMembers."No.";
        //             ObjBOSAAccount."Account Name" := ObjMembers.Name;
        //             ObjBOSAAccount."ID No" := ObjMembers."ID No.";
        //             ObjBOSAAccount."Account Type" := '602';
        //             ObjBOSAAccount.Insert;
        //         end;
        //         if Rec."Global Dimension 2 Code" = 'MOMBASA' then begin
        //             ObjMembers."Deposits Account No" := IncStr(Saccosetup."Deposits Account No(MSA)");
        //             Saccosetup."Deposits Account No(MSA)" := ObjMembers."Deposits Account No";
        //             ObjMembers.Modify;
        //             Saccosetup.Modify;

        //             ObjBOSAAccount.Init;
        //             ObjBOSAAccount."Account No" := ObjMembers."Deposits Account No";
        //             ObjBOSAAccount."Transaction Type" := ObjBOSAAccount."transaction type"::"Deposit Contribution";
        //             ObjBOSAAccount."Member No" := ObjMembers."No.";
        //             ObjBOSAAccount."Account Name" := ObjMembers.Name;
        //             ObjBOSAAccount."ID No" := ObjMembers."ID No.";
        //             ObjBOSAAccount."Account Type" := '602';
        //             ObjBOSAAccount.Insert;
        //         end;
        //     end;
        // end;

        // //CORPORATE DEPOSITS CONTRIBUTION
        // ProductsApp.Reset;
        // ProductsApp.SetRange(ProductsApp."Membership Applicaton No", Rec."No.");
        // ProductsApp.SetRange(ProductsApp."Product Source", ProductsApp."product source"::BOSA);
        // ProductsApp.SetRange(ProductsApp.Product, '603');
        // if ProductsApp.FindSet then begin
        //     ObjMembers.Reset;
        //     ObjMembers.SetRange(ObjMembers."ID No.", Rec."ID No.");
        //     if ObjMembers.FindSet then begin
        //         if Rec."Global Dimension 2 Code" = 'NAIROBI' then begin
        //             ObjMembers."Deposits Account No" := IncStr(Saccosetup."Deposits Account No(HQ)");
        //             Saccosetup."Deposits Account No(HQ)" := ObjMembers."Deposits Account No";
        //             ObjMembers.Modify;
        //             Saccosetup.Modify;

        //             ObjBOSAAccount.Init;
        //             ObjBOSAAccount."Account No" := ObjMembers."Deposits Account No";
        //             ObjBOSAAccount."Transaction Type" := ObjBOSAAccount."transaction type"::"Deposit Contribution";
        //             ObjBOSAAccount."Member No" := ObjMembers."No.";
        //             ObjBOSAAccount."Account Name" := ObjMembers.Name;
        //             ObjBOSAAccount."ID No" := ObjMembers."ID No.";
        //             ObjBOSAAccount."Account Type" := '603';
        //             ObjBOSAAccount.Insert;
        //         end;

        //         if Rec."Global Dimension 2 Code" = 'NAIVASHA' then begin
        //             ObjMembers."Deposits Account No" := IncStr(Saccosetup."Deposits Account No(NAIV)");
        //             Saccosetup."Deposits Account No(NAIV)" := ObjMembers."Deposits Account No";
        //             ObjMembers.Modify;
        //             Saccosetup.Modify;

        //             ObjBOSAAccount.Init;
        //             ObjBOSAAccount."Account No" := ObjMembers."Deposits Account No";
        //             ObjBOSAAccount."Transaction Type" := ObjBOSAAccount."transaction type"::"Deposit Contribution";
        //             ObjBOSAAccount."Member No" := ObjMembers."No.";
        //             ObjBOSAAccount."Account Name" := ObjMembers.Name;
        //             ObjBOSAAccount."ID No" := ObjMembers."ID No.";
        //             ObjBOSAAccount."Account Type" := '603';
        //             ObjBOSAAccount.Insert;
        //         end;

        //         if Rec."Global Dimension 2 Code" = 'NAKURU' then begin
        //             ObjMembers."Deposits Account No" := IncStr(Saccosetup."Deposits Account No(NKR)");
        //             Saccosetup."Deposits Account No(NKR)" := ObjMembers."Deposits Account No";
        //             ObjMembers.Modify;
        //             Saccosetup.Modify;

        //             ObjBOSAAccount.Init;
        //             ObjBOSAAccount."Account No" := ObjMembers."Deposits Account No";
        //             ObjBOSAAccount."Transaction Type" := ObjBOSAAccount."transaction type"::"Deposit Contribution";
        //             ObjBOSAAccount."Member No" := ObjMembers."No.";
        //             ObjBOSAAccount."Account Name" := ObjMembers.Name;
        //             ObjBOSAAccount."ID No" := ObjMembers."ID No.";
        //             ObjBOSAAccount."Account Type" := '603';
        //             ObjBOSAAccount.Insert;
        //         end;
        //         if Rec."Global Dimension 2 Code" = 'ELDORET' then begin
        //             ObjMembers."Deposits Account No" := IncStr(Saccosetup."Deposits Account No(ELD)");
        //             Saccosetup."Deposits Account No(ELD)" := ObjMembers."Deposits Account No";
        //             ObjMembers.Modify;
        //             Saccosetup.Modify;

        //             ObjBOSAAccount.Init;
        //             ObjBOSAAccount."Account No" := ObjMembers."Deposits Account No";
        //             ObjBOSAAccount."Transaction Type" := ObjBOSAAccount."transaction type"::"Deposit Contribution";
        //             ObjBOSAAccount."Member No" := ObjMembers."No.";
        //             ObjBOSAAccount."Account Name" := ObjMembers.Name;
        //             ObjBOSAAccount."ID No" := ObjMembers."ID No.";
        //             ObjBOSAAccount."Account Type" := '603';
        //             ObjBOSAAccount.Insert;
        //         end;
        //         if Rec."Global Dimension 2 Code" = 'MOMBASA' then begin
        //             ObjMembers."Deposits Account No" := IncStr(Saccosetup."Deposits Account No(MSA)");
        //             Saccosetup."Deposits Account No(MSA)" := ObjMembers."Deposits Account No";
        //             ObjMembers.Modify;
        //             Saccosetup.Modify;

        //             ObjBOSAAccount.Init;
        //             ObjBOSAAccount."Account No" := ObjMembers."Deposits Account No";
        //             ObjBOSAAccount."Transaction Type" := ObjBOSAAccount."transaction type"::"Deposit Contribution";
        //             ObjBOSAAccount."Member No" := ObjMembers."No.";
        //             ObjBOSAAccount."Account Name" := ObjMembers.Name;
        //             ObjBOSAAccount."ID No" := ObjMembers."ID No.";
        //             ObjBOSAAccount."Account Type" := '603';
        //             ObjBOSAAccount.Insert;
        //         end;
        //     end;
        // end;

        // //FOSA SHARES CONTRIBUTION
        // ProductsApp.Reset;
        // ProductsApp.SetRange(ProductsApp."Membership Applicaton No", Rec."No.");
        // ProductsApp.SetRange(ProductsApp."Product Source", ProductsApp."product source"::BOSA);
        // ProductsApp.SetRange(ProductsApp.Product, '605');
        // if ProductsApp.FindSet then begin
        //     ObjMembers.Reset;
        //     ObjMembers.SetRange(ObjMembers."ID No.", Rec."ID No.");
        //     if ObjMembers.FindSet then begin
        //         if Rec."Global Dimension 2 Code" = 'NAIROBI' then begin
        //             ObjMembers."Deposits Account No" := IncStr(Saccosetup."Deposits Account No(HQ)");
        //             Saccosetup."Deposits Account No(HQ)" := ObjMembers."Deposits Account No";
        //             ObjMembers.Modify;
        //             Saccosetup.Modify;

        //             ObjBOSAAccount.Init;
        //             ObjBOSAAccount."Account No" := ObjMembers."Deposits Account No";
        //             ObjBOSAAccount."Transaction Type" := ObjBOSAAccount."transaction type"::"Deposit Contribution";
        //             ObjBOSAAccount."Member No" := ObjMembers."No.";
        //             ObjBOSAAccount."Account Name" := ObjMembers.Name;
        //             ObjBOSAAccount."ID No" := ObjMembers."ID No.";
        //             ObjBOSAAccount."Account Type" := '605';
        //             ObjBOSAAccount.Insert;
        //         end;

        //         if Rec."Global Dimension 2 Code" = 'NAIVASHA' then begin
        //             ObjMembers."Deposits Account No" := IncStr(Saccosetup."Deposits Account No(NAIV)");
        //             Saccosetup."Deposits Account No(NAIV)" := ObjMembers."Deposits Account No";
        //             ObjMembers.Modify;
        //             Saccosetup.Modify;

        //             ObjBOSAAccount.Init;
        //             ObjBOSAAccount."Account No" := ObjMembers."Deposits Account No";
        //             ObjBOSAAccount."Transaction Type" := ObjBOSAAccount."transaction type"::"Deposit Contribution";
        //             ObjBOSAAccount."Member No" := ObjMembers."No.";
        //             ObjBOSAAccount."Account Name" := ObjMembers.Name;
        //             ObjBOSAAccount."ID No" := ObjMembers."ID No.";
        //             ObjBOSAAccount."Account Type" := '605';
        //             ObjBOSAAccount.Insert;
        //         end;

        //         if Rec."Global Dimension 2 Code" = 'NAKURU' then begin
        //             ObjMembers."Deposits Account No" := IncStr(Saccosetup."Deposits Account No(NKR)");
        //             Saccosetup."Deposits Account No(NKR)" := ObjMembers."Deposits Account No";
        //             ObjMembers.Modify;
        //             Saccosetup.Modify;

        //             ObjBOSAAccount.Init;
        //             ObjBOSAAccount."Account No" := ObjMembers."Deposits Account No";
        //             ObjBOSAAccount."Transaction Type" := ObjBOSAAccount."transaction type"::"Deposit Contribution";
        //             ObjBOSAAccount."Member No" := ObjMembers."No.";
        //             ObjBOSAAccount."Account Name" := ObjMembers.Name;
        //             ObjBOSAAccount."ID No" := ObjMembers."ID No.";
        //             ObjBOSAAccount."Account Type" := '605';
        //             ObjBOSAAccount.Insert;
        //         end;
        //         if Rec."Global Dimension 2 Code" = 'ELDORET' then begin
        //             ObjMembers."Deposits Account No" := IncStr(Saccosetup."Deposits Account No(ELD)");
        //             Saccosetup."Deposits Account No(ELD)" := ObjMembers."Deposits Account No";
        //             ObjMembers.Modify;
        //             Saccosetup.Modify;

        //             ObjBOSAAccount.Init;
        //             ObjBOSAAccount."Account No" := ObjMembers."Deposits Account No";
        //             ObjBOSAAccount."Transaction Type" := ObjBOSAAccount."transaction type"::"Deposit Contribution";
        //             ObjBOSAAccount."Member No" := ObjMembers."No.";
        //             ObjBOSAAccount."Account Name" := ObjMembers.Name;
        //             ObjBOSAAccount."ID No" := ObjMembers."ID No.";
        //             ObjBOSAAccount."Account Type" := '605';
        //             ObjBOSAAccount.Insert;
        //         end;
        //         if Rec."Global Dimension 2 Code" = 'MOMBASA' then begin
        //             ObjMembers."Deposits Account No" := IncStr(Saccosetup."Deposits Account No(MSA)");
        //             Saccosetup."Deposits Account No(MSA)" := ObjMembers."Deposits Account No";
        //             ObjMembers.Modify;
        //             Saccosetup.Modify;

        //             ObjBOSAAccount.Init;
        //             ObjBOSAAccount."Account No" := ObjMembers."Deposits Account No";
        //             ObjBOSAAccount."Transaction Type" := ObjBOSAAccount."transaction type"::"Deposit Contribution";
        //             ObjBOSAAccount."Member No" := ObjMembers."No.";
        //             ObjBOSAAccount."Account Name" := ObjMembers.Name;
        //             ObjBOSAAccount."ID No" := ObjMembers."ID No.";
        //             ObjBOSAAccount."Account Type" := '605';
        //             ObjBOSAAccount.Insert;
        //         end;
        //     end;
        // end;

        // //FOSA SHARES CONTRIBUTION
        // ProductsApp.Reset;
        // ProductsApp.SetRange(ProductsApp."Membership Applicaton No", Rec."No.");
        // ProductsApp.SetRange(ProductsApp."Product Source", ProductsApp."product source"::BOSA);
        // ProductsApp.SetRange(ProductsApp.Product, '607');
        // if ProductsApp.FindSet then begin
        //     ObjMembers.Reset;
        //     ObjMembers.SetRange(ObjMembers."ID No.", Rec."ID No.");
        //     if ObjMembers.FindSet then begin
        //         if Rec."Global Dimension 2 Code" = 'NAIROBI' then begin
        //             ObjMembers."Deposits Account No" := IncStr(Saccosetup."Deposits Account No(HQ)");
        //             Saccosetup."Deposits Account No(HQ)" := ObjMembers."Deposits Account No";
        //             ObjMembers.Modify;
        //             Saccosetup.Modify;

        //             ObjBOSAAccount.Init;
        //             ObjBOSAAccount."Account No" := ObjMembers."Deposits Account No";
        //             ObjBOSAAccount."Transaction Type" := ObjBOSAAccount."transaction type"::"Deposit Contribution";
        //             ObjBOSAAccount."Member No" := ObjMembers."No.";
        //             ObjBOSAAccount."Account Name" := ObjMembers.Name;
        //             ObjBOSAAccount."ID No" := ObjMembers."ID No.";
        //             ObjBOSAAccount."Account Type" := '607';
        //             ObjBOSAAccount.Insert;
        //         end;

        //         if Rec."Global Dimension 2 Code" = 'NAIVASHA' then begin
        //             ObjMembers."Deposits Account No" := IncStr(Saccosetup."Deposits Account No(NAIV)");
        //             Saccosetup."Deposits Account No(NAIV)" := ObjMembers."Deposits Account No";
        //             ObjMembers.Modify;
        //             Saccosetup.Modify;

        //             ObjBOSAAccount.Init;
        //             ObjBOSAAccount."Account No" := ObjMembers."Deposits Account No";
        //             ObjBOSAAccount."Transaction Type" := ObjBOSAAccount."transaction type"::"Deposit Contribution";
        //             ObjBOSAAccount."Member No" := ObjMembers."No.";
        //             ObjBOSAAccount."Account Name" := ObjMembers.Name;
        //             ObjBOSAAccount."ID No" := ObjMembers."ID No.";
        //             ObjBOSAAccount."Account Type" := '607';
        //             ObjBOSAAccount.Insert;
        //         end;

        //         if Rec."Global Dimension 2 Code" = 'NAKURU' then begin
        //             ObjMembers."Deposits Account No" := IncStr(Saccosetup."Deposits Account No(NKR)");
        //             Saccosetup."Deposits Account No(NKR)" := ObjMembers."Deposits Account No";
        //             ObjMembers.Modify;
        //             Saccosetup.Modify;

        //             ObjBOSAAccount.Init;
        //             ObjBOSAAccount."Account No" := ObjMembers."Deposits Account No";
        //             ObjBOSAAccount."Transaction Type" := ObjBOSAAccount."transaction type"::"Deposit Contribution";
        //             ObjBOSAAccount."Member No" := ObjMembers."No.";
        //             ObjBOSAAccount."Account Name" := ObjMembers.Name;
        //             ObjBOSAAccount."ID No" := ObjMembers."ID No.";
        //             ObjBOSAAccount."Account Type" := '607';
        //             ObjBOSAAccount.Insert;
        //         end;
        //         if Rec."Global Dimension 2 Code" = 'ELDORET' then begin
        //             ObjMembers."Deposits Account No" := IncStr(Saccosetup."Deposits Account No(ELD)");
        //             Saccosetup."Deposits Account No(ELD)" := ObjMembers."Deposits Account No";
        //             ObjMembers.Modify;
        //             Saccosetup.Modify;

        //             ObjBOSAAccount.Init;
        //             ObjBOSAAccount."Account No" := ObjMembers."Deposits Account No";
        //             ObjBOSAAccount."Transaction Type" := ObjBOSAAccount."transaction type"::"Deposit Contribution";
        //             ObjBOSAAccount."Member No" := ObjMembers."No.";
        //             ObjBOSAAccount."Account Name" := ObjMembers.Name;
        //             ObjBOSAAccount."ID No" := ObjMembers."ID No.";
        //             ObjBOSAAccount."Account Type" := '607';
        //             ObjBOSAAccount.Insert;
        //         end;
        //         if Rec."Global Dimension 2 Code" = 'MOMBASA' then begin
        //             ObjMembers."Deposits Account No" := IncStr(Saccosetup."Deposits Account No(MSA)");
        //             Saccosetup."Deposits Account No(MSA)" := ObjMembers."Deposits Account No";
        //             ObjMembers.Modify;
        //             Saccosetup.Modify;

        //             ObjBOSAAccount.Init;
        //             ObjBOSAAccount."Account No" := ObjMembers."Deposits Account No";
        //             ObjBOSAAccount."Transaction Type" := ObjBOSAAccount."transaction type"::"Deposit Contribution";
        //             ObjBOSAAccount."Member No" := ObjMembers."No.";
        //             ObjBOSAAccount."Account Name" := ObjMembers.Name;
        //             ObjBOSAAccount."ID No" := ObjMembers."ID No.";
        //             ObjBOSAAccount."Account Type" := '607';
        //             ObjBOSAAccount.Insert;
        //         end;
        //     end;
        // end;

        // //BENEVOLENT FUND

        // ProductsApp.Reset;
        // ProductsApp.SetRange(ProductsApp."Membership Applicaton No", Rec."No.");
        // ProductsApp.SetRange(ProductsApp."Product Source", ProductsApp."product source"::BOSA);
        // ProductsApp.SetRange(ProductsApp.Product, '606');
        // if ProductsApp.FindSet then begin
        //     ObjMembers.Reset;
        //     ObjMembers.SetRange(ObjMembers."ID No.", Rec."ID No.");
        //     if ObjMembers.FindSet then begin
        //         if Rec."Global Dimension 2 Code" = 'NAIROBI' then begin
        //             ObjMembers."Benevolent Fund No" := IncStr(Saccosetup."BenFund Account No(HQ)");
        //             Saccosetup."BenFund Account No(HQ)" := ObjMembers."Benevolent Fund No";
        //             ObjMembers.Modify;
        //             Saccosetup.Modify;

        //             ObjBOSAAccount.Init;
        //             ObjBOSAAccount."Account No" := ObjMembers."Benevolent Fund No";
        //             ObjBOSAAccount."Transaction Type" := ObjBOSAAccount."transaction type"::"Benevolent Fund";
        //             ObjBOSAAccount."Member No" := ObjMembers."No.";
        //             ObjBOSAAccount."Account Name" := ObjMembers.Name;
        //             ObjBOSAAccount."ID No" := ObjMembers."ID No.";
        //             ObjBOSAAccount."Account Type" := '606';
        //             ObjBOSAAccount.Insert;

        //         end;
        //         if Rec."Global Dimension 2 Code" = 'NAIVASHA' then begin
        //             ObjMembers."Benevolent Fund No" := IncStr(Saccosetup."BenFund Account No(NAIV)");
        //             Saccosetup."BenFund Account No(NAIV)" := ObjMembers."Benevolent Fund No";
        //             ObjMembers.Modify;
        //             Saccosetup.Modify;

        //             ObjBOSAAccount.Init;
        //             ObjBOSAAccount."Account No" := ObjMembers."Benevolent Fund No";
        //             ObjBOSAAccount."Transaction Type" := ObjBOSAAccount."transaction type"::"Benevolent Fund";
        //             ObjBOSAAccount."Member No" := ObjMembers."No.";
        //             ObjBOSAAccount."Account Name" := ObjMembers.Name;
        //             ObjBOSAAccount."ID No" := ObjMembers."ID No.";
        //             ObjBOSAAccount."Account Type" := '606';
        //             ObjBOSAAccount.Insert;
        //         end;

        //         if Rec."Global Dimension 2 Code" = 'NAKURU' then begin
        //             ObjMembers."Benevolent Fund No" := IncStr(Saccosetup."BenFund Account No(NKR)");
        //             Saccosetup."BenFund Account No(NKR)" := ObjMembers."Benevolent Fund No";
        //             ObjMembers.Modify;
        //             Saccosetup.Modify;

        //             ObjBOSAAccount.Init;
        //             ObjBOSAAccount."Account No" := ObjMembers."Benevolent Fund No";
        //             ObjBOSAAccount."Transaction Type" := ObjBOSAAccount."transaction type"::"Benevolent Fund";
        //             ObjBOSAAccount."Member No" := ObjMembers."No.";
        //             ObjBOSAAccount."Account Name" := ObjMembers.Name;
        //             ObjBOSAAccount."ID No" := ObjMembers."ID No.";
        //             ObjBOSAAccount."Account Type" := '606';
        //             ObjBOSAAccount.Insert;
        //         end;

        //         if Rec."Global Dimension 2 Code" = 'ELDORET' then begin
        //             ObjMembers."Benevolent Fund No" := IncStr(Saccosetup."BenFund Account No(ELD)");
        //             Saccosetup."BenFund Account No(ELD)" := ObjMembers."Benevolent Fund No";
        //             ObjMembers.Modify;
        //             Saccosetup.Modify;


        //             ObjBOSAAccount.Init;
        //             ObjBOSAAccount."Account No" := ObjMembers."Benevolent Fund No";
        //             ObjBOSAAccount."Transaction Type" := ObjBOSAAccount."transaction type"::"Benevolent Fund";
        //             ObjBOSAAccount."Member No" := ObjMembers."No.";
        //             ObjBOSAAccount."Account Name" := ObjMembers.Name;
        //             ObjBOSAAccount."ID No" := ObjMembers."ID No.";
        //             ObjBOSAAccount."Account Type" := '606';
        //             ObjBOSAAccount.Insert;
        //         end;

        //         if Rec."Global Dimension 2 Code" = 'MOMBASA' then begin
        //             ObjMembers."Benevolent Fund No" := IncStr(Saccosetup."BenFund Account No(MSA)");
        //             Saccosetup."BenFund Account No(MSA)" := ObjMembers."Benevolent Fund No";
        //             ObjMembers.Modify;
        //             Saccosetup.Modify;

        //             ObjBOSAAccount.Init;
        //             ObjBOSAAccount."Account No" := ObjMembers."Benevolent Fund No";
        //             ObjBOSAAccount."Transaction Type" := ObjBOSAAccount."transaction type"::"Benevolent Fund";
        //             ObjBOSAAccount."Member No" := ObjMembers."No.";
        //             ObjBOSAAccount."Account Name" := ObjMembers.Name;
        //             ObjBOSAAccount."ID No" := ObjMembers."ID No.";
        //             ObjBOSAAccount."Account Type" := '606';
        //             ObjBOSAAccount.Insert;
        //         end;
        //     end;
        // end;

    end;

    local procedure FnRuninsertBOSAAccountNos(VarMemberNo: Code[30])
    begin

        ObjAccounts.Reset;
        ObjAccounts.SetRange(ObjAccounts."BOSA Account No", VarMemberNo);
        ObjAccounts.SetFilter(ObjAccounts."Account Type", '=%1', '101');
        ObjAccounts.SetRange(ObjAccounts.Status, ObjAccounts.Status::Active);
        if ObjAccounts.FindSet then begin
            if ObjCust.Get(VarMemberNo) then begin
                ObjCust."Share Capital No" := ObjAccounts."No.";
                ObjCust.Modify;
            end;
        end;

        ObjAccounts.Reset;
        ObjAccounts.SetRange(ObjAccounts."BOSA Account No", VarMemberNo);
        ObjAccounts.SetFilter(ObjAccounts."Account Type", '=%1', '102');
        ObjAccounts.SetRange(ObjAccounts.Status, ObjAccounts.Status::Active);
        if ObjAccounts.FindSet then begin
            if ObjCust.Get(VarMemberNo) then begin
                ObjCust."Deposits Account No" := ObjAccounts."No.";
                ObjCust.Modify;
            end;
        end;

        // ObjAccounts.Reset;
        // ObjAccounts.SetRange(ObjAccounts."BOSA Account No", VarMemberNo);
        // ObjAccounts.SetFilter(ObjAccounts."Account Type", '=%1', '104');
        // ObjAccounts.SetRange(ObjAccounts.Status, ObjAccounts.Status::Active);
        // IF ObjAccounts.FindSet THEN BEGIN
        //     IF objCust.Get(VarMemberNo) THEN begin
        //         objCust."School Fees Shares Account" := ObjAccounts."No.";
        //         objCust.Modify;
        //     end;
        // end;

    end;

    local procedure SetStyles()
    begin
        CoveragePercentStyle := 'Strong';
        if Rec."Member Risk Level" <> Rec."member risk level"::"Low Risk" then
            CoveragePercentStyle := 'Unfavorable';
        if Rec."Member Risk Level" = Rec."member risk level"::"Low Risk" then
            CoveragePercentStyle := 'Favorable';
    end;

    local procedure SetControlAppearance()
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    begin
        OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Rec.RecordId);
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(Rec.RecordId);
        if rec."Membership Approval Status" = rec."Membership Approval Status"::Open then begin
            canSendApproval := True;
            canCreate := false;
        end
        else if Rec."Membership Approval Status" = Rec."Membership Approval Status"::Approved then begin
            canSendApproval := false;
            canCreate := true;
        end
        else begin
            canSendApproval := false;
            canCreate := false
        end;
    end;
}






