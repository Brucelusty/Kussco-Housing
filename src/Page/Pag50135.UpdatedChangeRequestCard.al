//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50135 "Updated Change Request Card"
{
    ApplicationArea = All;
    Editable = false;
    PageType = Card;
    SourceTable = "Change Request";
    DeleteAllowed = false;

    layout
    {
        area(content)
        {
            group(General)
            {
                field(No; rec.No)
                {
                }
                field(Type; rec.Type)
                {
                    Editable = TypeEditable;

                    trigger OnValidate()
                    begin
                        AccountVisible := false;
                        MobileVisible := false;
                        AtmVisible := false;
                        nxkinvisible := false;

                        if rec.Type = rec.Type::"Mobile Change" then begin
                            MobileVisible := true;
                        end;

                        if rec.Type = rec.Type::"ATM Change" then begin
                            AtmVisible := true;
                        end;

                        if rec.Type = rec.Type::"Backoffice Change" then begin
                            AccountVisible := true;
                            nxkinvisible := true;
                        end;

                        if rec.Type = rec.Type::"Agile Change" then begin
                            AccountVisible := true;
                            nxkinvisible := true;
                        end;
                    end;
                }
                field("Account No";Rec."Account No")
                {
                    Editable = AccountNoEditable;
                }
                field("Captured by";Rec."Captured by")
                {
                }
                field("Capture Date";Rec."Capture Date")
                {
                }
                field("Approved by";Rec."Approved by")
                {
                }
                field("Approval Date";Rec."Approval Date")
                {
                }
                field(Status; rec.Status)
                {
                }
            }
            group(Mobile)
            {
                Caption = 'Phone No Details';
                Visible = Mobilevisible;
                field("Mobile No";Rec."Mobile No")
                {
                    Editable = false;
                    visible=false;
                }
                field("Mobile No(New Value)";Rec."Mobile No(New Value)")
                {
                    Caption = 'Mobile No(New Value)';
                    Editable = MobileNoEditable;
                    visible=false;
                }
                field("S-Mobile No";Rec."S-Mobile No")
                {
                    Editable = false;
                }
                field("S-Mobile No(New Value)";Rec."S-Mobile No(New Value)")
                {
                    Caption = 'S-Mobile No(New Value)';
                    Editable = SMobileNoEditable;
                }
            }
            group(s)
            {
                Caption = 'ATM Card Details';
                Visible = Atmvisible;
                field("ATM Approve";Rec."ATM Approve")
                {
                    Editable = ATMApproveEditable;
                }
                field("Card Expiry Date";Rec."Card Expiry Date")
                {
                    Editable = CardExpiryDateEditable;
                }
                field("Card Valid From";Rec."Card Valid From")
                {
                    Editable = CardValidFromEditable;
                }
                field("Card Valid To";Rec."Card Valid To")
                {
                    Editable = CardValidToEditable;
                }
                field("Date ATM Linked";Rec."Date ATM Linked")
                {
                }
                field("ATM No.";Rec."ATM No.")
                {
                    Editable = ATMNOEditable;
                }
                field("ATM Issued";Rec."ATM Issued")
                {
                    Editable = ATMIssuedEditable;
                }
                field("ATM Self Picked";Rec."ATM Self Picked")
                {
                    Editable = ATMSelfPickedEditable;
                }
                field("ATM Collector Name";Rec."ATM Collector Name")
                {
                    Editable = ATMCollectorNameEditable;
                }
                field("ATM Collectors ID";Rec."ATM Collectors ID")
                {
                    Editable = ATMCollectorIDEditable;
                }
                field("Atm Collectors Moile";Rec."Atm Collectors Moile")
                {
                    Editable = ATMCollectorMobileEditable;
                }
                field("Responsibility Centers";Rec."Responsibility Centers")
                {
                    Editable = ResponsibilityCentreEditable;
                }
            }
            group("Account Info")
            {
                Caption = 'Account Details';
                Visible = Accountvisible;
                field(Name; rec.Name)
                {
                    Editable = false;
                }
                field("Name(New Value)";Rec."Name(New Value)")
                {
                    Caption = 'Name(New Value)';
                    Editable = NameEditable;
                }
                field(Picture; rec.Picture)
                {
                    Editable = PictureEditable;
                }
                field(signinature; rec.signinature)
                {
                    Editable = SignatureEditable;
                }
                field(Address; rec.Address)
                {
                    Editable = false;
                }
                field("Address(New Value)";Rec."Address(New Value)")
                {
                    Caption = 'Address(New Value)';
                    Editable = AddressEditable;
                }
                field(City; rec.City)
                {
                    Editable = false;
                }
                field("City(New Value)";Rec."City(New Value)")
                {
                    Caption = 'City(New Value)';
                    Editable = CityEditable;
                }
                field("E-mail";Rec."E-mail")
                {
                    Editable = false;
                }
                field("Email(New Value)";Rec."Email(New Value)")
                {
                    Caption = 'Email(New Value)';
                    Editable = EmailEditable;
                }
                field("Personal No";Rec."Personal No")
                {
                    Editable = false;
                }
                field("Personal No(New Value)";Rec."Personal No(New Value)")
                {
                    Caption = 'Personal No(New Value)';
                    Editable = PersonalNoEditable;
                }
                field("ID No";Rec."ID No")
                {
                    Editable = false;
                }
                field("ID No(New Value)";Rec."ID No(New Value)")
                {
                    Caption = 'ID No(New Value)';
                    Editable = IDNoEditable;
                }
                field("Marital Status";Rec."Marital Status")
                {
                    Editable = false;
                }
                field("Marital Status(New Value)";Rec."Marital Status(New Value)")
                {
                    Caption = 'Marital Status(New Value)';
                    Editable = MaritalStatusEditable;
                }
                field("Passport No.";Rec."Passport No.")
                {
                    Editable = false;
                }
                field("Passport No.(New Value)";Rec."Passport No.(New Value)")
                {
                    Caption = 'Passport No.(New Value)';
                    Editable = PassPortNoEditbale;
                }
                field("Account Type";Rec."Account Type")
                {
                    Editable = false;
                }
                field("Account Type(New Value)";Rec."Account Type(New Value)")
                {
                    Caption = 'Account Type(New Value)';
                    Editable = AccountTypeEditible;
                }
                field("Account Category";Rec."Account Category")
                {
                    Editable = false;
                }
                field("Account Category(New Value)";Rec."Account Category(New Value)")
                {
                    Caption = 'Account Category(New Value)';
                    Editable = AccountCategoryEditable;
                }
                field(Section; rec.Section)
                {
                    Editable = false;
                }
                field("Section(New Value)";Rec."Section(New Value)")
                {
                    Caption = 'Section(New Value)';
                    Editable = SectionEditable;
                }
                field("Card No";Rec."Card No")
                {
                    Editable = false;
                }
                field("Card No(New Value)";Rec."Card No(New Value)")
                {
                    Caption = 'Card No(New Value)';
                    Editable = CardNoEditable;
                }
                field("Home Address";Rec."Home Address")
                {
                    Editable = false;
                }
                field("Home Address(New Value)";Rec."Home Address(New Value)")
                {
                    Caption = 'Home Address(New Value)';
                    Editable = HomeAddressEditable;
                }
                field(Loaction; rec.Loaction)
                {
                    Editable = false;
                }
                field("Loaction(New Value)";Rec."Loaction(New Value)")
                {
                    Caption = 'Loaction(New Value)';
                    Editable = LocationEditable;
                }
                field("Sub-Location";Rec."Sub-Location")
                {
                    Editable = false;
                }
                field("Sub-Location(New Value)";Rec."Sub-Location(New Value)")
                {
                    Caption = 'Sub-Location(New Value)';
                    Editable = SubLocationEditable;
                }
                field(District; rec.District)
                {
                    Editable = false;
                }
                field("District(New Value)";Rec."District(New Value)")
                {
                    Caption = 'District(New Value)';
                    Editable = DistrictEditable;
                }
                field("Member Account Status";Rec."Member Account Status")
                {
                    Editable = false;
                }
                field("Member Account Status(NewValu)";Rec."Member Account Status(NewValu)")
                {
                    Caption = 'Member Account Status(New Value)';
                    Editable = MemberStatusEditable;
                }
                field("Charge Reactivation Fee";Rec."Charge Reactivation Fee")
                {
                    Editable = ReactivationFeeEditable;
                }
                field("Reason for change";Rec."Reason for change")
                {
                    Editable = ReasonForChangeEditable;
                }
                field("Signing Instructions";Rec."Signing Instructions")
                {
                    Editable = false;
                }
                field("Signing Instructions(NewValue)";Rec."Signing Instructions(NewValue)")
                {
                    Caption = 'Signing Instructions(New Value)';
                    Editable = SigningInstructionEditable;
                }
                field("Monthly Contributions";Rec."Monthly Contributions")
                {
                    Editable = false;
                }
                field("Monthly Contributions(NewValu)";Rec."Monthly Contributions(NewValu)")
                {
                    Caption = 'Monthly Contributions(New Value)';
                    Editable = MonthlyContributionEditable;
                }
                field("Member Cell Group";Rec."Member Cell Group")
                {
                    Editable = MemberCellEditable;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Approvals)
            {
                Caption = 'Approvals';
                Image = Approval;
                Promoted = true;
                PromotedCategory = Category4;

                trigger OnAction()
                var
                    //ApprovalEntries: Page "Approval Entries";
                begin
                    DocumentType := Documenttype::ChangeRequest;

                   // ApprovalEntries.Setfilters(Database::"Change Request", DocumentType, rec.No);
                   // ApprovalEntries.Run;
                end;
            }
            action("Send Approval Request")
            {
                Caption = 'Send A&pproval Request';
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Category4;

                trigger OnAction()
                var
                    text001: label 'This batch is already pending approval';
                    //ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                begin
                    if rec.Status <> rec.Status::Open then
                        Error(text001);

                    //IF ApprovalsMgmt.CheckChangeRequestApprovalsWorkflowEnabled(Rec) THEN
                    // ApprovalsMgmt.OnSendChangeRequestForApproval(Rec);
                end;
            }
            action("Cancel Approval Request")
            {
                Caption = 'Cancel A&pproval Request';
                Image = Cancel;
                Promoted = true;
                PromotedCategory = Category4;

                trigger OnAction()
                var
                    text001: label 'This batch is already pending approval';
                    //ApprovalMgt: Codeunit "Approvals Mgmt.";
                begin
                    if rec.Status <> rec.Status::Open then
                        Error(text001);

                    //End allocate batch number
                    //ApprovalMgt.CancelClosureApprovalRequest(Rec);
                end;
            }
            separator(Action1000000047)
            {
            }
            action(Populate)
            {
                Caption = 'Populate';
                Image = GetLines;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    /*IF ("No. Series"="No. Series"::"1") OR ("No. Series"="No. Series"::"2") THEN BEGIN
                     ERROR('Only Backoffice change or Agile Change allows you to Populate Next of Kin');
                    END;
                    IF ("No. Series"="No. Series"::"3") THEN BEGIN

                    END;

                  IF ("No. Series"="No. Series"::"4") THEN BEGIN
                    ProductNxK.RESET;
                    ProductNxK.SETRANGE(ProductNxK."Account No",Posted);
                    IF ProductNxK.FIND('-') THEN
                      MESSAGE(FORMAT(Posted));
                      REPEAT;
                        Kinchangedetails.INIT;
                        Kinchangedetails."Member No":=Posted;
                        Kinchangedetails."Dividend year":=ProductNxK.Name;
                        Kinchangedetails.Amount:=ProductNxK.Relationship;
                        Kinchangedetails."Member Name":=ProductNxK.Beneficiary;
                        Kinchangedetails.Message:=ProductNxK."Date of Birth";
                        Kinchangedetails."Message Sent":=ProductNxK.Address;
                        Kinchangedetails."Account No.":=ProductNxK.Telephone;
                        Kinchangedetails.Fax:=ProductNxK.Fax;
                        Kinchangedetails.Email:=ProductNxK.Email;
                        Kinchangedetails."ID No.":=ProductNxK."ID No.";
                        Kinchangedetails."%Allocation":=ProductNxK."%Allocation";
                        Kinchangedetails.INSERT;

                      UNTIL ProductNxK.NEXT=0;
                      MESSAGE('Next of Kin Details Populated Successfully');
                    END;
                    */

                end;
            }
            separator(Action1000000055)
            {
            }
            action("Next of Kin")
            {
                Caption = 'Next of Kin';
                Image = View;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Next of Kin-Change";
                RunPageLink = "Account No" = field("Account No");
            }
            action("Update Changes")
            {
                Caption = 'Update Changes';
                Image = UpdateShipment;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    if (rec.Status <> rec.Status::Approved) then begin
                        Error('Change Request Must be Approved First');
                    end;

                    if ((rec.Type = rec.Type::"Mobile Change") or (rec.Type = rec.Type::"ATM Change") or (rec.Type = rec.Type::"Agile Change")) then begin
                        vend.Reset;
                        vend.SetRange(vend."No.", rec."Account No");
                        if vend.Find('-') then
                            vend.CalcFields(vend.image, vend.Signature);
                        vend.Name := rec.Name;
                        vend."Global Dimension 2 Code" := rec.Branch;
                        vend.Address := rec."Address(New Value)";
                        //vend.image:=Picture;
                        vend.Signature := rec.signinature;
                        vend."E-Mail" := rec."Email(New Value)";
                        vend."Mobile Phone No" := rec."Mobile No(New Value)";
                        vend."S-Mobile No" := rec."S-Mobile No(New Value)";
                        vend."ATM Collector Name" := rec."ATM Collector Name";
                        vend."ID No." := rec."ID No(New Value)";
                        vend."Personal No." := rec."Personal No(New Value)";
                        vend."Account Type" := rec."Account Type(New Value)";
                        vend.City := rec."City(New Value)";
                        vend.Section := rec."Section(New Value)";
                        vend."Card Expiry Date" := rec."Card Expiry Date";
                        vend."Card No." := rec."Card No(New Value)";
                        vend."Card Valid From" := rec."Card Valid From";
                        vend."Card Valid To" := rec."Card Valid To";
                        vend."Marital Status" := rec."Marital Status(New Value)";
                        vend."Responsibility Center" := rec."Responsibility Centers";
                        vend.Modify;

                        if (rec.Type = rec.Type::"Agile Change") then begin
                            ProductNxK.Reset;
                            ProductNxK.SetRange(ProductNxK."Account No", rec."Account No");
                            if ProductNxK.Find('-') then
                                repeat
                                    ;

                                    ProductNxK.Name := Kinchangedetails.Name;
                                    ProductNxK.Relationship := Kinchangedetails.Relationship;
                                    ProductNxK.Beneficiary := Kinchangedetails.Beneficiary;
                                    ProductNxK."Date of Birth" := Kinchangedetails."Date of Birth";
                                    ProductNxK.Address := Kinchangedetails.Address;
                                    ProductNxK.Telephone := Kinchangedetails.Telephone;
                                    //ProductNxK.Fax:=Kinchangedetails.Fax;
                                    ProductNxK.Email := Kinchangedetails.Email;
                                    ProductNxK."ID No." := Kinchangedetails."ID No.";
                                    ProductNxK."%Allocation" := Kinchangedetails."%Allocation";
                                    ProductNxK.Modify;

                                until ProductNxK.Next = 0;

                        end

                    end;


                    if rec.Type = rec.Type::"Backoffice Change" then begin
                        Memb.Reset;
                        Memb.SetRange(Memb."No.", rec."Account No");
                        if Memb.Find('-') then begin

                            Memb.CalcFields(Memb.Signature);
                            Memb.Name := rec.Name;
                            Memb."Global Dimension 2 Code" := rec.Branch;
                            Memb.Address := rec."Address(New Value)";
                            //Memb.Picture:=Picture;
                            //Memb.Signature:=signinature;
                            Memb."E-Mail" := rec."Email(New Value)";
                            Memb."Mobile Phone No" := rec."Mobile No(New Value)";
                            Memb."ID No." := rec."ID No(New Value)";
                            Memb."Payroll No" := rec."Personal No(New Value)";
                            Memb.City := rec."City(New Value)";
                            Memb.Section := rec."Section(New Value)";
                            Memb."Marital Status" := rec."Marital Status(New Value)";
                            Memb."Responsibility Center" := rec."Responsibility Centers";
                            Memb.Status := rec."Member Account Status(NewValu)";
                            //Memb."Account Category":="Account Category(New Value)";
                            Memb.Modify;


                            MemberNxK.Reset;
                            MemberNxK.SetRange(MemberNxK."Account No", rec."Account No");
                            if MemberNxK.Find('-') then
                                repeat
                                    ;

                                    MemberNxK.Name := Kinchangedetails.Name;
                                    MemberNxK.Relationship := Kinchangedetails.Relationship;
                                    MemberNxK.Beneficiary := Kinchangedetails.Beneficiary;
                                    MemberNxK."Date of Birth" := Kinchangedetails."Date of Birth";
                                    MemberNxK.Address := Kinchangedetails.Address;
                                    MemberNxK.Telephone := Kinchangedetails.Telephone;
                                    MemberNxK.Email := Kinchangedetails.Email;
                                    MemberNxK."ID No." := Kinchangedetails."ID No.";
                                    MemberNxK."%Allocation" := Kinchangedetails."%Allocation";
                                    MemberNxK.Modify;

                                until MemberNxK.Next = 0;

                            if rec."Charge Reactivation Fee" = true then begin
                                if Confirm('The System Is going to Charge Reactivation Fee', false) = true then begin
                                    GenSetUp.Get();
                                    GenJournalLine.Reset;
                                    GenJournalLine.SetRange(GenJournalLine."Journal Template Name", 'PURCHASES');
                                    GenJournalLine.SetRange(GenJournalLine."Journal Batch Name", 'FTRANS');
                                    if GenJournalLine.FindSet then begin
                                        GenJournalLine.DeleteAll;
                                    end;

                                    LineNo := LineNo + 10000;
                                    GenJournalLine.Reset;
                                    GenJournalLine.SetRange("Journal Template Name", 'PURCHASES');
                                    GenJournalLine.SetRange("Journal Batch Name", 'FTRANS');
                                    GenJournalLine.DeleteAll;

                                    GenJournalLine.Init;
                                    GenJournalLine."Journal Template Name" := 'PURCHASES';
                                    GenJournalLine."Journal Batch Name" := 'FTRANS';
                                    GenJournalLine."Line No." := GenJournalLine."Line No." + 1000;
                                    GenJournalLine."Account Type" := GenJournalLine."account type"::"IC Partner";
                                    GenJournalLine."Account No." := rec."Account No";
                                    GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Registration Fee";
                                    GenJournalLine."Posting Date" := Today;
                                    GenJournalLine."Document No." := rec.No;
                                    GenJournalLine.Description := 'Account Reactivation Fee' + ' ' + rec.No;
                                    GenJournalLine.Amount := GenSetUp."Rejoining Fee";
                                    GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                                    GenJournalLine."Bal. Account No." := GenSetUp."Rejoining Fees Account";
                                    GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                    if GenJournalLine.Amount <> 0 then
                                        GenJournalLine.Insert;

                                    GenJournalLine.Reset;
                                    GenJournalLine.SetRange(GenJournalLine."Journal Template Name", 'PURCHASES');
                                    GenJournalLine.SetRange(GenJournalLine."Journal Batch Name", 'FTRANS');
                                    if GenJournalLine.FindSet then begin
                                        Codeunit.Run(Codeunit::"Gen. Jnl.-Post", GenJournalLine);
                                    end;
                                    Message('Reactivation Fee Charged Successfuly');
                                end;
                            end;



                        end;

                    end;

                    rec.Changed := true;
                    rec.Modify;
                    Message('Changes have been updated Successfully');
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        AccountVisible := false;
        MobileVisible := false;
        AtmVisible := false;
        nxkinvisible := false;

        if rec.Type = rec.Type::"Mobile Change" then begin
            MobileVisible := true;
        end;

        if rec.Type = rec.Type::"ATM Change" then begin
            AtmVisible := true;
        end;

        if rec.Type = rec.Type::"Backoffice Change" then begin
            AccountVisible := true;
            nxkinvisible := true;
        end;

        if rec.Type = rec.Type::"Agile Change" then begin
            AccountVisible := true;
            nxkinvisible := true;
        end;

        UpdateControl();
    end;

    trigger OnOpenPage()
    begin
        AccountVisible := false;
        MobileVisible := false;
        AtmVisible := false;
        nxkinvisible := false;

        if rec.Type = rec.Type::"Mobile Change" then begin
            MobileVisible := true;
        end;

        if rec.Type =rec. Type::"ATM Change" then begin
            AtmVisible := true;
        end;

        if rec.Type = rec.Type::"Backoffice Change" then begin
            AccountVisible := true;
            nxkinvisible := true;
        end;

        if rec.Type = rec.Type::"Agile Change" then begin
            AccountVisible := true;
            nxkinvisible := true;
        end;

        UpdateControl();
    end;

    var
        vend: Record Vendor;
        Memb: Record Customer;
        MobileVisible: Boolean;
        AtmVisible: Boolean;
        AccountVisible: Boolean;
        ProductNxK: Record "FOSA Account NOK Details";
        MembNxK: Record "Members Next of Kin";
        cloudRequest: Record "Change Request";
        nxkinvisible: Boolean;
        Kinchangedetails: Record "Members Next of Kin";
        DocumentType: Option " ",Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None",JV,"Member Withdrawal","Membership Reg","Loan Batches","Payment Voucher","Petty Cash",Loan,Interbank,Checkoff,"Savings Product Opening","Standing Order",ChangeRequest;
        MemberNxK: Record "Members Next of Kin";
        GenSetUp: Record "Sacco General Set-Up";
        GenJournalLine: Record "Gen. Journal Line";
        LineNo: Integer;
        NameEditable: Boolean;
        PictureEditable: Boolean;
        SignatureEditable: Boolean;
        AddressEditable: Boolean;
        CityEditable: Boolean;
        EmailEditable: Boolean;
        PersonalNoEditable: Boolean;
        IDNoEditable: Boolean;
        MaritalStatusEditable: Boolean;
        PassPortNoEditbale: Boolean;
        AccountTypeEditible: Boolean;
        SectionEditable: Boolean;
        CardNoEditable: Boolean;
        HomeAddressEditable: Boolean;
        LocationEditable: Boolean;
        SubLocationEditable: Boolean;
        DistrictEditable: Boolean;
        MemberStatusEditable: Boolean;
        ReasonForChangeEditable: Boolean;
        SigningInstructionEditable: Boolean;
        MonthlyContributionEditable: Boolean;
        MemberCellEditable: Boolean;
        ATMApproveEditable: Boolean;
        CardExpiryDateEditable: Boolean;
        CardValidFromEditable: Boolean;
        CardValidToEditable: Boolean;
        ATMNOEditable: Boolean;
        ATMIssuedEditable: Boolean;
        ATMSelfPickedEditable: Boolean;
        ATMCollectorNameEditable: Boolean;
        ATMCollectorIDEditable: Boolean;
        ATMCollectorMobileEditable: Boolean;
        ResponsibilityCentreEditable: Boolean;
        MobileNoEditable: Boolean;
        SMobileNoEditable: Boolean;
        TypeEditable: Boolean;
        AccountNoEditable: Boolean;
        AccountCategoryEditable: Boolean;
        ReactivationFeeEditable: Boolean;

    local procedure UpdateControl()
    begin
        if rec.Status = rec.Status::Open then begin
            NameEditable := true;
            PictureEditable := true;
            SignatureEditable := true;
            AddressEditable := true;
            CityEditable := true;
            EmailEditable := true;
            PersonalNoEditable := true;
            IDNoEditable := true;
            MaritalStatusEditable := true;
            PassPortNoEditbale := true;
            AccountTypeEditible := true;
            EmailEditable := true;
            SectionEditable := true;
            CardNoEditable := true;
            HomeAddressEditable := true;
            LocationEditable := true;
            SubLocationEditable := true;
            DistrictEditable := true;
            MemberStatusEditable := true;
            ReasonForChangeEditable := true;
            SigningInstructionEditable := true;
            MonthlyContributionEditable := true;
            MemberCellEditable := true;
            ATMApproveEditable := true;
            CardExpiryDateEditable := true;
            CardValidFromEditable := true;
            CardValidToEditable := true;
            ATMNOEditable := true;
            ATMIssuedEditable := true;
            ATMSelfPickedEditable := true;
            ATMCollectorNameEditable := true;
            ATMCollectorIDEditable := true;
            ATMCollectorMobileEditable := true;
            ResponsibilityCentreEditable := true;
            MobileNoEditable := true;
            SMobileNoEditable := true;
            AccountNoEditable := true;
            ReactivationFeeEditable := true;
            TypeEditable := true;
            AccountCategoryEditable := true
        end else
            if rec.Status = rec.Status::Pending then begin
                NameEditable := false;
                PictureEditable := false;
                SignatureEditable := false;
                AddressEditable := false;
                CityEditable := false;
                EmailEditable := false;
                PersonalNoEditable := false;
                IDNoEditable := false;
                MaritalStatusEditable := false;
                PassPortNoEditbale := false;
                AccountTypeEditible := false;
                EmailEditable := false;
                SectionEditable := false;
                CardNoEditable := false;
                HomeAddressEditable := false;
                LocationEditable := false;
                SubLocationEditable := false;
                DistrictEditable := false;
                MemberStatusEditable := false;
                ReasonForChangeEditable := false;
                SigningInstructionEditable := false;
                MonthlyContributionEditable := false;
                MemberCellEditable := false;
                ATMApproveEditable := false;
                CardExpiryDateEditable := false;
                CardValidFromEditable := false;
                CardValidToEditable := false;
                ATMNOEditable := false;
                ATMIssuedEditable := false;
                ATMSelfPickedEditable := false;
                ATMCollectorNameEditable := false;
                ATMCollectorIDEditable := false;
                ATMCollectorMobileEditable := false;
                ResponsibilityCentreEditable := false;
                MobileNoEditable := false;
                SMobileNoEditable := false;
                AccountNoEditable := false;
                TypeEditable := false;
                ReactivationFeeEditable := false;
                AccountCategoryEditable := false
            end else
                if rec.Status = rec.Status::Approved then begin
                    NameEditable := false;
                    PictureEditable := false;
                    SignatureEditable := false;
                    AddressEditable := false;
                    CityEditable := false;
                    EmailEditable := false;
                    PersonalNoEditable := false;
                    IDNoEditable := false;
                    MaritalStatusEditable := false;
                    PassPortNoEditbale := false;
                    AccountTypeEditible := false;
                    EmailEditable := false;
                    SectionEditable := false;
                    CardNoEditable := false;
                    HomeAddressEditable := false;
                    LocationEditable := false;
                    SubLocationEditable := false;
                    DistrictEditable := false;
                    MemberStatusEditable := false;
                    ReasonForChangeEditable := false;
                    SigningInstructionEditable := false;
                    MonthlyContributionEditable := false;
                    MemberCellEditable := false;
                    ATMApproveEditable := false;
                    CardExpiryDateEditable := false;
                    CardValidFromEditable := false;
                    CardValidToEditable := false;
                    ATMNOEditable := false;
                    ATMIssuedEditable := false;
                    ATMSelfPickedEditable := false;
                    ATMCollectorNameEditable := false;
                    ATMCollectorIDEditable := false;
                    ATMCollectorMobileEditable := false;
                    ResponsibilityCentreEditable := false;
                    MobileNoEditable := false;
                    SMobileNoEditable := false;
                    AccountNoEditable := false;
                    ReactivationFeeEditable := false;
                    TypeEditable := false;
                    AccountCategoryEditable := false
                end;
    end;
}






