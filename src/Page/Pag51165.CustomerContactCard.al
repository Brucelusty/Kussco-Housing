namespace PROGRESSIVE.PROGRESSIVE;
using Microsoft.Foundation.NoSeries;
using System.Automation;

page 51165 "Customer Contact Card"
{
    ApplicationArea = All;
    Caption = 'Leads Card';
    PageType = Card;
    SourceTable = "Customer Contact";
    DeleteAllowed = false;
    PromotedActionCategories = 'New,Process,Report,Functions,Comments';


    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the contact number';
                    Importance = Promoted;
                }
                field(Title; Rec.Title)
                {
                    ToolTip = 'Specifies the Title';
                    Importance = Promoted;
                }
                field(Surname; Rec.Surname)
                {
                    ToolTip = 'Specifies the contact name';
                    Importance = Promoted;
                    Caption = 'Surname';

                    trigger OnValidate()
                    begin
                        // Rec.Name := Rec."Surname";

                    end;

                }

                field("First Name"; Rec."First Name")
                {
                    ToolTip = 'Specifies the contact name';
                    Importance = Promoted;
                    trigger OnValidate()
                    begin
                        // Rec.Name := Rec."Surname" + ' ' + Rec."First Name";

                    end;

                }
                field("Other Name"; Rec."Other Name")
                {
                    ToolTip = 'Specifies the contact name';
                    Importance = Promoted;
                    trigger OnValidate()
                    begin


                    end;

                }
                field("Marketing Campaign ID"; Rec."Marketing Campaign ID")
                {
                    ToolTip = 'Specifies the contact name';
                    Importance = Promoted;

                }
                field("Marketing Event ID"; Rec."Marketing Event ID")
                {
                    ToolTip = 'Specifies the contact name';
                    Importance = Promoted;

                }
                field(Name; Rec.Name)
                {
                    ToolTip = 'Specifies the contact name';
                    Importance = Promoted;
                    Visible = false;
                }


                field("Consent Signed"; Rec."Consent Signed")
                {
                    ToolTip = 'Specifies if the contact has signed consent.';
                }


                field("Mobile Phone No"; Rec."Mobile Phone No")
                {
                    ToolTip = 'Specifies the contact phone number';
                }
                field("E-Mail Address"; Rec."E-Mail Address")
                {
                    ToolTip = 'Specifies the contact email address';
                }
                field("Lead Type"; Rec."Lead Type")
                {
                    ToolTip = 'Specifies the lead type';
                }
                field("Live Location"; Rec."Live Location")
                {
                    ToolTip = 'Specifies the Live Location';
                }
                field("Lead Status"; Rec."Lead Status")
                {
                    Editable = false;
                    //  Visible = false;
                }

                field(Status; Rec.Status)
                {
                    Editable = false;
                    Visible = false;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    Editable = false;
                    Visible = false;

                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    Editable = false;
                    Visible = false;

                }
                field("Shortcut Dimension 3 Code"; Rec."Shortcut Dimension 3 Code")
                {
                    Editable = true;
                    Visible = false;
                }
                field("Shortcut Dimension 4 Code"; Rec."Shortcut Dimension 4 Code")
                {
                    Editable = false;
                    Visible = false;

                }
                field("Shortcut Dimension 5 Code"; Rec."Shortcut Dimension 5 Code")
                {
                    Editable = false;
                    Visible = false;

                }
                field("Application Date"; Rec."Application Date")
                {
                    Editable = false;
                    Visible = false;
                }



            }

            group("Marketing Information")
            {
                Caption = 'Marketing Information';

                field("Marketing Channel"; Rec."Marketing Channel")
                {
                    ToolTip = 'Specifies how the contact was acquired';
                    trigger OnValidate()
                    begin
                        /*                         STLVisible := false;
                                                SalesAgentVisible := false;
                                                SalesExecutiveVisible := False;
                                                HOReferralVisible := false;



                                                case Rec."Marketing Channel" of
                                                    Rec."Marketing Channel"::"Sales Executive":
                                                        SalesExecutiveVisible := true;


                                                end; */
                    end;
                }

                field("Marketing Activity"; Rec."Marketing Activity")
                {
                    ToolTip = 'Specifies the marketing activity type';
                }
                field("Referred By"; Rec."Referred By")
                {
                    ToolTip = 'Specifies who referred the contact';
                }
                field("Sales Agent Code"; Rec."Sales Agent Code")
                {
                    ToolTip = 'Specifies the sales agent';
                    Caption = 'Marketing Officer';
                }
            }


            part(LoansSubForm; "Leads Comments")
            {
                SubPageLink = "Document No." = field("No.");
                // DELETEALLOWED = false;
                Caption = 'Interaction Tracking';
            }




        }
    }
    actions
    {
        area(navigation)
        {
            group(Approvals)
            {
                Caption = '&Show';
                action("Convert Lead")
                {
                    Caption = 'Convert To Prospect';
                    Image = Action;
                    Promoted = true;
                    PromotedCategory = Process;
                    trigger OnAction()
                    var
                        MembershipApp: Record "Membership Applications";
                    begin
                        MembershipApp.Reset();
                        MembershipApp.SetRange(MembershipApp."Mobile Phone No", Rec."Mobile Phone No");
                        if MembershipApp.FindFirst() then begin
                            Error('Mobile Phone Number #%1 has already been created.');
                        end;
                        if Rec.Converted = true then Error('This lead has already been converted.');
                        if Confirm('Do you want to convert this contact to Prospect?', true, false) = true then begin
                            SaccoNoSeries.Get();
                            VarNewMembNo := NoSeriesMgt.GetNextNo(SaccoNoSeries."Member Application Nos", Today, true);//
                            MembershipApp.Init();
                            // Basic Information
                            MembershipApp."No." := VarNewMembNo;
                            MembershipApp.Title := Rec.Title;
                            MembershipApp."Last Name" := Rec.Surname;
                            MembershipApp."First Name" := Rec."First Name";
                            MembershipApp."Middle Name" := Rec."Other Name";
                            MembershipApp.Name := Rec.Surname + ' ' + Rec."First Name" + ' ' + Rec."Other Name";
                            MembershipApp."Account Category" := Rec."Lead Type";
                            MembershipApp."Reffered By Member No" := Rec."Referred By";
                            // Contact Information
                            MembershipApp."Phone No." := Rec."Mobile Phone No";
                            MembershipApp."Mobile Phone No" := Rec."Mobile Phone No";
                            // Reference Information
                            MembershipApp."Lead No" := Rec."No.";
                            MembershipApp."Marketing Campaign ID":=Rec."Marketing Campaign ID";
                            MembershipApp."Marketing Event ID":=Rec."Marketing Event ID";


                            // Dimension Codes
                            MembershipApp."Global Dimension 1 Code" := Rec."Global Dimension 1 Code";
                            MembershipApp."Global Dimension 2 Code" := Rec."Global Dimension 2 Code";


                            MembershipApp.Insert(true);
                            /*                             ObjAccountTypes.Reset;
                                                        ObjAccountTypes.SetRange(ObjAccountTypes."Default Account", true);
                                                        if ObjAccountTypes.FindSet() then begin
                                                            repeat
                                                                Message('Here%1App%2', ObjAccountTypes.Code, VarNewMembNo);
                                                                ObjSelectProduct.Init;
                                                                ObjSelectProduct."Membership Applicaton No" := VarNewMembNo;
                                                                ObjSelectProduct.Product := ObjAccountTypes.Code;
                                                                ObjSelectProduct."Product Source" := ObjAccountTypes."Activity Code";
                                                                ObjSelectProduct."Product Name" := ObjAccountTypes.Description;
                                                                ObjSelectProduct."Product Source" := ObjAccountTypes."Activity Code";
                                                                ObjSelectProduct."Show On List" := ObjAccountTypes."Show On List";
                                                                ObjSelectProduct."Account Category" := Format(MembershipApp."Account Category");
                                                                // ObjSelectProduct.Validate(Product);
                                                                if ObjSelectProduct."Membership Applicaton No" <> '' then
                                                                    ObjSelectProduct.Insert(true);
                                                            until ObjAccountTypes.Next = 0;
                                                        end; */
                            Message('Prospect application #%1 has been created.', VarNewMembNo);


                            Rec.Converted := true;
                            Rec.Modify();
                        end;
                    end;
                }
            }
        }

        area(processing)
        {
            group("Approval Actions")
            {
                action("Send Approval Request")
                {
                    Caption = 'Send Approval Request';
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedOnly = true;
                    Visible = false;

                    trigger OnAction()
                    var
                        Text001: Label 'This request is already pending approval';
                        ApprovalsMgmt: Codeunit 1535;
                        WorkflowMgt: Codeunit 50071;
                    begin
                        if Confirm('Are you sure you want to send Approval request for this record?', true) = false then
                            exit;

                        // Add any required field validations here
                        Rec.TestField("Mobile Phone No");
                        Rec.TestField(Surname);
                        Rec.TestField("First Name");

                        varrvariant := Rec;
                        //  if CustomApprovalsCodeunit.CheckApprovalsWorkflowEnabled(varrvariant) then
                        //   CustomApprovalsCodeunit.OnSendDocForApproval(varrvariant);
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
                    Visible = false;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit 1535;
                        WorkflowMgt: Codeunit 50071;
                    begin
                        if Confirm('Are you sure you want cancel Approval request for this record?', true) = false then
                            exit;
                        ApprovalEntry.RESET;
                        ApprovalEntry.SETRANGE("Document No.", Rec."No.");
                        IF ApprovalEntry.FINDSET THEN BEGIN
                            REPEAT
                                ApprovalEntry.Status := ApprovalEntry.Status::Canceled;
                                ApprovalEntry.MODIFY;
                            UNTIL ApprovalEntry.NEXT = 0;
                        END;
                        Rec.Status := Rec.Status::Open;
                        Rec.MODIFY;
                    end;
                }

                action(Approval)
                {
                    Caption = 'Approvals';
                    Image = Approvals;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedOnly = true;
                    Visible = false;

                    trigger OnAction()
                    var
                        ApprovalEntries: Page 658;
                    begin
                        ApprovalEntry.RESET;
                        ApprovalEntry.SETRANGE("Document No.", Rec."No.");
                        ApprovalEntry.SETRANGE(Status, ApprovalEntry.Status::Open);
                        PAGE.RUN(658, ApprovalEntry);
                    end;
                }
            }
        }
    }

    var
        MembershipApp: Record "Membership Applications";
        Membership: Record "Membership Applications";
        SaccoNoSeries: Record "Sacco No. Series";
        VarNewMembNo: Code[80];
        NoSeriesMgt: Codeunit "No. Series";
        STLVisible: Boolean;
        SalesAgentVisible: Boolean;
        SalesExecutiveVisible: Boolean;
        HOReferralVisible: Boolean;

        CustomApprovalsCodeunit: Codeunit "Approvals Mgmt.";
        CanCancelApprovalForRecord: Boolean;
        varrvariant: Variant;
        ApprovalEntry: Record 454;
        ObjAccountTypes: Record "Account Types-Saving Products";
        ObjSelectProduct: Record "Membership Reg. Products Appli";
}


