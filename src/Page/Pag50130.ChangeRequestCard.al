//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50130 "Change Request Card"
{
    ApplicationArea = All;
    PageType = Card;
    SourceTable = "Change Request";

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
                    ValuesAllowed = "Backoffice Change", "Agile Change", "Mobile Change","Next Of Kin Change";
                    trigger OnValidate()
                    begin
                        AccountVisible := false;
                        MobileVisible := false;
                        nxkinvisible := false;
                        Atmvisible := false;
                        FOSAVisible := false;
                        NOKVisible := False;

                        if rec.Type = rec.Type::"Mobile Change" then begin
                            MobileVisible := true;
                        end;

                        if rec.Type = rec.Type::"ATM Change" then begin
                            // AccountVisible := true;
                            //nxkinvisible := true;
                            Atmvisible := true;
                        end;

                        if rec.Type = rec.Type::"Backoffice Change" then begin
                            AccountVisible := true;
                            //  nxkinvisible := true;
                        end;

                        if rec.Type = rec.Type::"Agile Change" then begin
                            FOSAVisible := true;
                            //nxkinvisible := true;
                        end;
                        if rec.Type = rec.Type::"Next Of Kin Change" then begin
                            NOKVisible := true;
                            //  nxkinvisible := true;
                        end;
                    end;
                }
                field("Account No"; Rec."Account No")
                {
                    Editable = AccountNoEditable;
                }
                field("FOSA Account No"; Rec."FOSA Account No")
                {
                    Editable = false;
                    Visible=false;
                }
                field("Captured by"; Rec."Captured by")
                {
                }
                field("Capture Date"; Rec."Capture Date")
                {
                }
                field("Approved by"; Rec."Approved by")
                {
                    Visible = false;
                }
                field("Approval Date"; Rec."Approval Date")
                {
                    Visible = false;
                }
                field(Status; rec.Status)
                {
                    Editable = false;
                }
                field("Reason for change"; Rec."Reason for change")
                {
                    ShowMandatory = true;
                    //Visible = false;
                }
            }
             group(NOK)
            {
                Caption = 'Next Of Kin Details';
                Visible = NOKVisible;
                field("Kin Name"; Rec."Kin Name")
                {
                    Caption = 'Name';
                    Editable = false;
                }
                field("Kin Name(new)"; Rec."Kin Name(new)")
                {
                    Caption = 'Name (new)';
                    Editable = not (rec.Status = rec.Status::Approved);
                }
                field("Kin ID No."; Rec."Kin ID No.")
                {
                    Caption = 'ID No.';
                    Editable = false;
                }
                field("Kin ID No(new)"; Rec."Kin ID No.(New)")
                {
                    Caption = 'ID No.(New)';
                    Editable = not (rec.Status = rec.Status::Approved);
                }
                field(Relationship; Rec.Relationship)
                {
                    Editable = false;
                }
                field("Relationship (New)"; Rec."Relationship (New)")
                {
                    Editable = not (rec.Status = rec.Status::Approved);
                }
                field("Kin Date of Birth"; Rec."Kin Date of Birth")
                {
                    Editable = false;
                    Caption = 'Date Of Birth';
                }
                field("Kin Date of Birth (new)"; Rec."Kin Date of Birth (new)")
                {
                    caption = 'Date of Birth (new)';
                    Editable = not (rec.Status = rec.Status::Approved);
                }
                field("Kin Telephone"; Rec."Kin Telephone")
                {
                    Editable = false;
                    Caption = 'Telephone';
                }
                Field("Kin Telephone(New)"; Rec."Kin Telephone(New)")
                {
                    Editable = not (rec.Status = rec.Status::Approved);
                    Caption = 'Telephone (New)';
                }
                field("Kin Email"; Rec."Kin Email")
                {
                    Editable = false;
                    Caption = 'Email';
                }
                field("Kin Email(New)"; Rec."Kin Email(New)")
                {
                    Caption = 'Email (New)';
                    Editable = not (rec.Status = rec.Status::Approved);
                }
                field("Next Of Kin Type"; Rec."Next Of Kin Type")
                {
                    Editable = false;
                }
                field("Next Of Kin Type (new)"; Rec."Next Of Kin Type (new)")
                {
                    Editable = not (rec.Status = rec.Status::Approved);
                }
                field("%Allocation";Rec."%Allocation")
                {
                }
                field("%Allocation (New)";Rec."%Allocation (New)")
                {
                    // Editable = not (rec.Status = rec.Status::Approved);
                }
            }
            group(Mobile)
            {
                Caption = 'Phone No Details';
                Visible = Mobilevisible;
                field("S-Mobile No"; Rec."S-Mobile No")
                {
                    Editable = false;
                }
                field("S-Mobile No(New Value)"; Rec."S-Mobile No(New Value)")
                {
                    Caption = 'S-Mobile No(New Value)';
                    Editable = SMobileNoEditable;
                }
                field("ID Number"; Rec."ID No")
                {
                    Editable = false;
                }
                field("ID Number(New Value)"; Rec."ID No(New Value)")
                {
                    Caption = 'ID No(New Value)';
                    Editable = IDNoEditable;
                }
            }
            group(FOSA)
            {
                Caption = 'Saving Account';
                Visible = FOSAVisible;
                field(MemberName; rec.Name)
                {
                    Editable = false;
                }
                field("MemberName(New Value)"; Rec."Name(New Value)")
                {
                    Caption = 'Name(New Value)';
                    Editable = NameEditable;
                    visible = false;
                }
                field("Member Account Status"; rec."Status.")
                {
                    Editable = false;
                }
                field("Member Account Status(NewValu)"; Rec."Status.(New)")
                {
                }
                field("ID No."; Rec."ID No")
                {
                    Editable = false;
                }
                field("ID No.(New Value)"; Rec."ID No(New Value)")
                {
                    Caption = 'ID No(New Value)';
                    Editable = IDNoEditable;
                }
                field("Mobile No."; Rec."Mobile No")
                {
                    Editable = false;
                }
                field("Mobile No.(New Value)"; Rec."Mobile No(New Value)")
                {
                    Caption = 'Mobile No(New Value)';
                    Editable = MobileNoEditable;
                }
                field("Mode Of Remmittance F"; Rec."Mode Of Remmittance F")
                {
                    Editable = false;
                    Caption = 'Mode Of Remmitance Old';
                    Visible = false;
                }
                field("Mode Of Remmittance F(New Value)"; Rec."Mode Of Remmittance F(New)")
                {

                    Caption = 'Mode Of Remmitance New';
                    Visible = false;
                }
                field("Amount Of Remmitance Old"; Rec."Amount Of Remmitance New")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Amount Of Remmitance New"; Rec."Amount Of Remmitance New")
                {

                    Editable = SMobileNoEditable;
                    Visible = false;
                }

                field("Child Name Old"; Rec."Child Name Old")
                {
                    Editable = false;
                    Visible = false;

                }
                field("Child Name New"; Rec."Child Name New")
                {

                    Editable = SMobileNoEditable;
                    Visible = false;

                }
                field("Child DOB Old"; Rec."Child DOB Old")
                {
                    Editable = false;
                    Visible = false;

                }
                field("Child DOB New"; Rec."Child DOB New")
                {

                    Editable = SMobileNoEditable;
                    Visible = false;

                }
                field("Childs Gender Old"; Rec."Childs Gender Old")
                {
                    Editable = false;
                    Visible = false;

                }
                field("Childs Gender New"; Rec."Childs Gender New")
                {

                    Editable = SMobileNoEditable;
                    Visible = false;

                }

            }
            group("Atm Details")
            {
                Caption = 'ATM Card Details';
                Visible = Atmvisible;
                field("ATM Approve"; Rec."ATM Approve")
                {
                    Editable = ATMApproveEditable;
                    Visible = false;
                }
                field("Card Expiry Date"; Rec."Card Expiry Date")
                {
                    Editable = CardExpiryDateEditable;
                    Visible = false;
                }
                field("Card Valid From"; Rec."Card Valid From")
                {
                    Editable = CardValidFromEditable;
                    Visible = false;
                }
                field("Card Valid To"; Rec."Card Valid To")
                {
                    Editable = CardValidToEditable;
                    Visible = false;
                }
                field("Date ATM Linked"; Rec."Date ATM Linked")
                {
                    Visible = false;
                }
                field("ATM No."; Rec."ATM No.")
                {
                    Editable = ATMNOEditable;

                }
                field("ATM Issued"; Rec."ATM Issued")
                {
                    Editable = ATMIssuedEditable;
                    Visible = false;
                }
                field("ATM Self Picked"; Rec."ATM Self Picked")
                {
                    Editable = ATMSelfPickedEditable;
                    Visible = false;
                }
                field("ATM Collector Name"; Rec."ATM Collector Name")
                {
                    Editable = ATMCollectorNameEditable;
                    Visible = false;
                }
                field("ATM Collectors ID"; Rec."ATM Collectors ID")
                {
                    Editable = ATMCollectorIDEditable;
                    Visible = false;
                }
                field("Atm Collectors Moile"; Rec."Atm Collectors Moile")
                {
                    Editable = ATMCollectorMobileEditable;
                    Visible = false;
                }
                field("Responsibility Centers"; Rec."Responsibility Centers")
                {
                    Editable = ResponsibilityCentreEditable;
                    Visible = false;
                }
            }
            group("Bank Details")
            {
                Caption = 'Bank Details';
                Visible = false;
                field("Bank Code(Old)"; Rec."Bank Code(Old)")
                {
                    Editable = true;
                    Visible = false;
                }
                field("Bank Code(New)"; Rec."Bank Code(New)")
                {
                    Visible = false;
                }
                field("Bank Account No(Old)"; Rec."Bank Account No(Old)")
                {
                    Editable = false;
                }
                field("Bank Account No(New)"; Rec."Bank Account No(New)")
                {
                }
                field("Bank Name"; Rec."Bank Name")
                {
                    Editable = false;
                }
                field("Bank Name (New)"; Rec."Bank Name (New)")
                {
                }
                field("Bank Branch Name"; Rec."Bank Branch Name")
                {
                    Editable = false;
                }
                field("Bank Branch Name(New)"; Rec."Bank Branch Name(New)")
                {
                }
            }
            group("Store Details")
            {
                Visible = storeVisible;
                field("Business Name"; Rec."Business Name(Store)")
                {
                    Editable = false;
                }
                field("Business Name(Store) New";Rec."Business Name(Store) New")
                {
                    Editable = true;
                }
                field("Business Short Code"; Rec."Business Short Code(Store)")
                {
                    Editable = false;
                }
                field("Business Short Code(Store) New";Rec."Business Short Code(Store) New")
                {
                    Editable = false;
                }
                field("Business Type"; Rec."Business Type(Store)")
                {
                    Editable = false;
                }
                field("Business Type(Store) New";Rec."Business Type(Store) New")
                {
                    Editable = true;
                }
                field("Business Status"; Rec."Business Status(Store)")
                {
                    Editable = false;
                }
                field("Business Status(Store) New";Rec."Business Status(Store) New")
                {
                    Editable = true;
                }
                field("Business Location"; Rec."Business Location(Store)")
                {
                    Editable = false;
                }
                field("Business Location(Store) New";Rec."Business Location(Store) New")
                {
                    Editable = true;
                }
                field("Business Contact"; Rec."Business Contact(Store)")
                {
                    Editable = false;
                }
                field("Business Contact(Store) New";Rec."Business Contact(Store) New")
                {
                    Editable = true;
                }
                field("Business Email"; Rec."Business Email(Store)")
                {
                    Editable = false;
                }
                field("Business Email(Store) New";Rec."Business Email(Store) New")
                {
                    Editable = true;
                }
                field("Business Phone"; Rec."Business Phone(Store)")
                {
                    Editable = false;
                }
                field("Business Phone(Store) New";Rec."Business Phone(Store) New")
                {
                    Editable = true;
                }
                field("Business Website"; Rec."Business Website(Store)")
                {
                    Editable = false;
                }
                field("Business Website(Store) New";Rec."Business Website(Store) New")
                {
                    Editable = true;
                }
                field("Business Description"; Rec."Business Description(Store)")
                {
                    Editable = false;
                }
                field("Business Description New";Rec."Business Description New")
                {
                    Editable = true;
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
                field("Name(New Value)"; Rec."Name(New Value)")
                {
                    Caption = 'Name(New Value)';
                    // Editable = NameEditable;
                }
                field("Membership Status";Rec."Membership Status")
                {
                    Editable = false;
                }
                field("Member Status";Rec."Membership Status(New)")
                {
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
                    Visible = false;
                }
                field("Address(New Value)"; Rec."Address(New Value)")
                {
                    Caption = 'Address(New Value)';
                    Editable = AddressEditable;
                    Visible = false;
                }
                field("Post Code"; Rec."Post Code")
                {
                    Editable = false;
                }
                field("Post Code (New)"; Rec."Post Code (New)")
                {
                }
                field(City; rec.City)
                {
                    Editable = false;
                }
                field("City(New Value)"; Rec."City(New Value)")
                {
                    Caption = 'City(New Value)';
                }
                field("Phone No.(New)"; Rec."Phone No.(New)")
                {
                    Editable = true;
                    Visible = false;
                }
                field("E-mail"; Rec."E-mail")
                {
                    Editable = false;
                }
                field("Email(New Value)"; Rec."Email(New Value)")
                {
                    Caption = 'Email(New Value)';
                    Editable = true;
                }
                field("Personal No"; Rec."Personal No")
                {
                    Caption = 'PF No';
                    Editable = false;
                }
                field("Personal No(New Value)"; Rec."Personal No(New Value)")
                {
                    Caption = 'PF No (New Value)';
                    // Editable = PersonalNoEditable;
                }
                field("ID No"; Rec."ID No")
                {
                    Editable = false;
                }
                field("ID No(New Value)"; Rec."ID No(New Value)")
                {
                    Caption = 'ID No(New Value)';
                    // Editable = IDNoEditable;
                }
                field("Marital Status"; Rec."Marital Status")
                {
                    Editable = false;
                }
                field("Date Of Birth"; Rec."Date Of Birth")
                {
                }
                field(Age; rec.Age)
                {
                    Editable = false;
                    Visible = false;

                }
                field(Gender; rec.Gender)
                {
                    Visible = false;
                }
                field("Marital Status(New Value)"; Rec."Marital Status(New Value)")
                {
                    Caption = 'Marital Status(New Value)';
                    // Editable = MaritalStatusEditable;
                    ToolTip = 'Please enter your marital status';

                }
                field("Passport No."; Rec."Passport No.")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Passport No.(New Value)"; Rec."Passport No.(New Value)")
                {
                    Caption = 'Passport No.(New Value)';
                    Editable = PassPortNoEditbale;
                    Visible = false;
                }
                field("Account Type"; Rec."Account Type")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Account Type(New Value)"; Rec."Account Type(New Value)")
                {
                    Caption = 'Account Type(New Value)';
                    Editable = AccountTypeEditible;
                    Visible = false;
                }
                field("Account Category"; Rec."Account Category")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Account Category(New Value)"; Rec."Account Category(New Value)")
                {
                    Visible = false;
                }
                field("Card No"; Rec."Card No")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Card No(New Value)"; Rec."Card No(New Value)")
                {
                    Caption = 'Card No(New Value)';
                    Editable = CardNoEditable;
                    Visible = false;
                }
                field("Home Address"; Rec."Home Address")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Home Address(New Value)"; Rec."Home Address(New Value)")
                {
                    Caption = 'Home Address(New Value)';
                    Editable = HomeAddressEditable;
                    Visible = false;
                }
                field(County; Rec.County)
                {
                    Visible = false;
                }
                field("County(New Value)"; Rec."County(New Value)")
                {
                    Visible = false;
                }


                field("Sub-county"; Rec."Sub-county")
                {
                    Visible = false;
                }
                field("Sub-county(New Value)"; Rec."Sub-county(New Value)")
                {
                    Visible = false;
                }

                field("Area"; Rec."Area")
                {
                    Visible = false;
                }
                field("Area(New Value)"; Rec."Area(New Value)")
                {
                    Visible = false;
                }


                field(Loaction; rec.Loaction)
                {
                    Caption = '<Location>';
                    Editable = false;
                    Visible = false;
                }
                field("Loaction(New Value)"; Rec."Loaction(New Value)")
                {
                    Caption = 'Location(New Value)';
                    Editable = LocationEditable;
                    Visible = false;
                }
                field("Sub-Location"; Rec."Sub-Location")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Sub-Location(New Value)"; Rec."Sub-Location(New Value)")
                {
                    Caption = 'Sub-Location(New Value)';
                    Editable = SubLocationEditable;
                    Visible = false;
                }
                field(District; rec.District)
                {
                    Editable = false;
                    Visible = false;
                }
                field("District(New Value)"; Rec."District(New Value)")
                {
                    Caption = 'District(New Value)';
                    Editable = DistrictEditable;
                    Visible = false;
                }
                field(Designation; Rec.Designation)
                {
                    Editable = false;
                }
                field("Designation Code(New)"; Rec."Designation Code(New)")
                {

                    // Editable = DesignationEditable;
                }
                field(Workstation; Rec.Workstation)
                {
                    Editable = false;
                }
                field("Workstation Code(New)"; Rec."Workstation Code(New)")
                {

                    // Editable = WorkstationEditable;
                }
                field("Status."; Rec."Status.")
                {
                    Editable = false;
                }
                field("Status.(New)"; Rec."Status.(New)")
                {
                }
                field(Occupation; rec.Occupation)
                {
                    Editable = false;
                }
                field("Occupation(New)"; Rec."Occupation(New)")
                {
                    Caption = 'Occupation(New Value)';
                }
                field("KRA Pin(Old)"; Rec."KRA Pin(Old)")
                {
                    Editable = false;
                }
                field("KRA Pin(New)"; Rec."KRA Pin(New)")
                {
                }
                field(Disabled; rec.Disabled)
                {
                    Editable = true;
                }
                field(Blocked; rec.Blocked)
                {
                    Editable = false;
                }
                field("Blocked (New)"; Rec."Blocked (New)")
                {
                }
                field("Employer Code"; Rec."Employer Code")
                {
                    Editable = false;
                }
                field("Employer Code(New)"; Rec."Employer Code(New)")
                {
                }
                field("Charge Reactivation Fee"; Rec."Charge Reactivation Fee")
                {
                    Editable = ReactivationFeeEditable;
                    Visible = false;
                }
                field("Signing Instructions"; Rec."Signing Instructions")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Retirement Date"; Rec."Retirement Date")
                {
                    Editable = RetirementDateEditable;
                }
                field("Retirement Date(New)"; Rec."Retirement Date(New)")
                {
                }
                field("Signing Instructions(NewValue)"; Rec."Signing Instructions(NewValue)")
                {
                    Caption = 'Signing Instructions(New Value)';
                    Editable = SigningInstructionEditable;
                    Visible = false;
                }
                field("Monthly Contributions"; Rec."Monthly Contributions")
                {
                    Editable = false;
                }
                field("Monthly Contributions(NewValu)"; Rec."Monthly Contributions(NewValu)")
                {
                    Caption = 'Monthly Contributions(New Value)';
                    // Editable = MonthlyContributionEditable;
                }
                field("Mobile No"; Rec."Mobile No")
                {
                    Editable = false;
                }
                field("Mobile No(New Value)"; Rec."Mobile No(New Value)")
                {
                    Caption = 'Mobile No(New Value)';
                    // Editable = MobileNoEditable;
                }
                field("Member Cell Group"; Rec."Member Cell Group")
                {
                    Editable = MemberCellEditable;
                    Visible = false;
                }
                field("Group Account No"; Rec."Group Account No")
                {
                    Visible = false;
                }
                field("Group Account Name"; Rec."Group Account Name")
                {
                    Visible = false;
                }
                field("Phone No.(Old)"; Rec."Phone No.(Old)")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Member Type"; Rec."Member Type")
                {
                    Editable = false;
                }
                field("Member Type(New Value)"; Rec."Member Type(New Value)")
                {
                }
                field("Insider Status";Rec."Insider Status")
                {
                    Editable = false;
                }
                field("Insider Status (New)";Rec."Insider Status (New)")
                {
                }
                field("Sales Rep";Rec."Sales Rep")
                {
                    Caption = 'Relationship Manager';
                }
                field("New Sales Rep";Rec."New Sales Rep")
                {
                    Caption = 'Relationship Manager (New)';
                }
                field("Customer Service Rep";Rec."Customer Service Rep")
                {
                }
                field("New Customer Service Rep";Rec."New Customer Service Rep")
                {
                }

                field("Mode Of Remmittance"; Rec."Mode Of Remmittance")
                {
                    Visible = false;
                }
                field("Mode Of Remmittance(New Value)"; Rec."Mode Of Remmittance(New Value)")
                {
                    Visible = false;
                }

                field("Nearest Landmark"; Rec."Nearest Landmark")
                {
                    Visible = false;
                }
                field("Nearest Landmark(New Value)"; Rec."Nearest Landmark(New Value)")
                {
                    Visible = false;
                }

            }
        }

        area(factboxes)
        {
            part(Control35; "Change Picture-App")

            {
                Caption = 'Picture';
                Visible = Accountvisible;
                SubPageLink = "No" = field("No");
               // Visible=false;
            }
            part(Control36; "Change Signature-App")
            {
                Caption = 'Signature';
                Visible = Accountvisible;
                SubPageLink = "No" = field("No");
             //   Visible=false;
            }

            part(Control36778; "Change FrontID-App")
            {
                Caption = 'Front ID';
                Visible = Accountvisible;
                SubPageLink = "No" = field("No");
            }

            part(Control36779; "Change BackID-App")
            {
                Caption = 'Back ID';
                Visible = Accountvisible;
                SubPageLink = "No" = field("No");
            }
        }

    }

    actions
    {
        area(processing)
        {
            action("Update Changes")
            {
                Caption = 'Update Changes';
                Image = UserInterface;
                Enabled = canCreate;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedOnly = true;

                trigger OnAction()
                var
                    FieldRef: Guid;
                    PictureRef: Guid;
                    SignatureRef: guid;
                    FrontIDRef: Guid;
                    BackIDRef: Guid;
                    Vendors: Record Vendor;

                begin
                    if (rec.Status <> rec.Status::Approved) then begin
                        Error('Change Request Must be Approved First');
                    end;
                    PictureRef := Rec.Picture.MediaId;
                    SignatureRef := Rec.signinature.MediaId;//
                    FrontIDRef := Rec."ID Front".MediaId;
                    BackIDRef := Rec."ID Back".MediaId;
                    if (rec.Type = rec.Type::"Agile Change") then begin

                        vend.Reset();
                        vend.SetRange("No.", rec."Account No");
                        if vend.Find('-') then begin
                            if Memb.Get(vend."BOSA Account No") then begin
                                Memb.Status := rec."Status.(New)";
                                if rec."Name(New Value)" <> '' then
                                    Memb.Name := rec."Name(New Value)";
                                if rec."Mobile No(New Value)" <> '' then
                                    Memb."Mobile Phone No" := rec."Mobile No(New Value)";
                                if rec."ID No(New Value)" <> '' then
                                    Memb."ID No." := rec."ID No(New Value)";

                                Memb.Modify();
                                vend.Status := rec."Status.(New)";
                                if rec."Mobile No(New Value)" <> '' then begin
                                    vend."Mobile Phone No" := rec."Mobile No(New Value)";
                                    vend."Mobile Phone No" := rec."Mobile No(New Value)";
                                    vend."Phone No." := rec."Mobile No(New Value)";
                                end;
                                if rec."ID No(New Value)" <> '' then
                                    vend."ID No." := rec."ID No(New Value)";
                                vend."Mode Of Remmittance" := Rec."Mode Of Remmittance F(New)";
                                vend."Child Name" := Rec."Child Name New";
                                vend."Child Birth certificate" := Rec."Birth Certificate No New";
                                vend."Child DOB" := Rec."Child DOB New";
                                vend."Childs Gender" := Rec."Childs Gender New";

                                if rec."Account Type" = '111' then begin
                                    if rec."Business Name(Store) New" <> '' then begin
                                        vend."Business Name(Store)" := rec."Business Name(Store) New";
                                    end;
                                    if rec."Business Contact(Store) New" <> '' then begin
                                        vend."Business Contact(Store)" := rec."Business Contact(Store) New";
                                    end;
                                    if rec."Business Description New" <> '' then begin
                                        vend."Business Description(Store)" := rec."Business Description New";
                                    end;
                                end;
                                vend.Modify();
                            end
                        end;
                    end;

                    if (rec.Type = rec.Type::"ATM Change") then begin
                        vend.Reset;
                        vend.SetRange(vend."No.", rec."Account No");
                        if vend.Find('-') then begin
                            if rec."ATM No." <> '' then
                                vend."Card No." := rec."ATM No.";
                            if rec."ATM No." <> '' then
                                vend."ATM No." := rec."ATM No.";


                            vend.Modify;

                        end;
                    end;
                    if (rec.Type = rec.Type::"Mobile Change") then begin

                        vend.Reset;
                        vend.SetRange(vend."No.", rec."Account No");
                        if vend.Find('-') then begin

                            if rec."S-Mobile No(New Value)" <> '' then
                                vend."S-Mobile No" := rec."S-Mobile No(New Value)";
                            vend."Mobile Phone No" := rec."S-Mobile No(New Value)";
                            vend."Phone No." := rec."S-Mobile No(New Value)";
                            if rec."ID No(New Value)" <> '' then
                                vend."ID No." := rec."ID No(New Value)";
                            vend.Modify;

                            Memb.Reset;
                            Memb.SetRange(Memb."FOSA Account No.", rec."Account No");
                            if Memb.find('-') then begin

                                Memb."Mobile Phone No" := rec."S-Mobile No(New Value)";
                                Memb."Secondary Mobile No" := rec."S-Mobile No(New Value)";
                                if rec."ID No(New Value)" <> '' then
                                    Memb."ID No." := rec."ID No(New Value)";
                                Memb.modify;
                            end;


                            Vendors.Reset();
                            Vendors.SetRange(Vendors."BOSA Account No", vend."BOSA Account No");
                            if Vendors.FindSet then begin
                                repeat
                                    if rec."S-Mobile No(New Value)" <> '' then
                                        Vendors."S-Mobile No" := rec."S-Mobile No(New Value)";
                                    Vendors."Mobile Phone No" := rec."S-Mobile No(New Value)";
                                    Vendors."Phone No." := rec."S-Mobile No(New Value)";
                                    if rec."ID No(New Value)" <> '' then
                                        Vendors."ID No." := rec."ID No(New Value)";

                                    Vendors.Modify();
                                until Vendors.Next() = 0;
                            end;

                        end;
                    end;

                    if rec.type = rec.type::"Next Of Kin Change" then begin
                        if rec."Kin Option" = 4 then begin
                            Nok.Reset();
                            Nok.SetRange(Nok."Account No", Rec."Account No");
                            Nok.SetRange(nok."NoK No.", Rec."Kin No.");
                            if Nok.Find('-') then begin
                                nok.Delete();
                            end;
                        end else if rec."Kin Option" = 3 then begin
                            Nok.Reset();
                            Nok.SetRange(Nok."Account No", Rec."Account No");
                            Nok.SetRange(nok."NoK No.", Rec."Kin No.");
                            if Nok.Find('-') then begin
                                nok.Delete();
                            end;
                            if cust.Get(Rec."Account No") then begin
                                cust.CalcFields("No of Next of Kin");
                                if cust."No of Next of Kin" < 1 then begin
                                    nokNo:= 1;
                                    NoK.init;
                                    NoK."Account No" := cust."No.";
                                    NoK.Name := Rec."Kin Name(new)";
                                    NoK."Next Of Kin Type" := rec."Next Of Kin Type (new)";
                                    NoK."Date of Birth" := rec."Kin Date of Birth (new)";
                                    NoK.Telephone := rec."Kin Telephone(New)";
                                    NoK."ID No." := rec."Kin ID No.(New)";
                                    NoK.Relationship := rec."Relationship (New)";
                                    NoK.Email := rec."Kin Email(New)";
                                    NoK."%Allocation" := rec."%Allocation (New)";
                                    NoK."NoK No." := nokNo;
                                    NoK.Insert;
                                    nokNo := nokNo +1;
                                end else if cust."No of Next of Kin" >= 1 then begin
                                    NoK.Reset();
                                    NoK.SetRange("Account No", Rec."Account No");
                                    if NoK.FindLast() then begin
                                        newNokno:= NoK."NoK No." + 1;
                                    end;
                                    nokNo:= newNokno;
                                    NoK.init;
                                    NoK."Account No" := cust."No.";
                                    NoK.Name := Rec."Kin Name(new)";
                                    NoK."Next Of Kin Type" := rec."Next Of Kin Type (new)";
                                    NoK."Date of Birth" := rec."Kin Date of Birth (new)";
                                    NoK.Telephone := rec."Kin Telephone(New)";
                                    NoK."ID No." := rec."Kin ID No.(New)";
                                    NoK.Relationship := rec."Relationship (New)";
                                    NoK.Email := rec."Kin Email(New)";
                                    NoK."%Allocation" := rec."%Allocation (New)";
                                    NoK."NoK No." := nokNo;
                                    NoK.Insert;
                                    nokNo := nokNo +1;
                                end;
                            end;
                        end else if rec."Kin Option" = 2 then begin
                            Nok.Reset();
                            Nok.SetRange(Nok."Account No", Rec."Account No");
                            Nok.SetRange(nok."NoK No.", Rec."Kin No.");
                            if Nok.Find('-') then begin
                                // Nok.CalcFields("Total Allocation");
                                // if (Nok."Total Allocation" - rec."%Allocation (New)") < 100 then begin
                                //     Message('%1', (Nok."Total Allocation" - rec."%Allocation (New)"));
                                // end;
                                // repeat
                                
                                if //(rec."%Allocation (New)" <> 0) or 
                                (rec."%Allocation (New)" <> rec."%Allocation") then
                                    Nok."%Allocation" := rec."%Allocation (New)";
                                // Nok.Modify;
                                // Nok.CalcFields("Total Allocation");
                                // if (Nok."Total Allocation") <> 100 then begin
                                //     Nok."%Allocation" := rec."%Allocation";
                                //     Nok.modify;
                                //     Error('Total % allocation is equal to: %1. Change the % allocation.', Nok."Total Allocation");
                                // end else begin
                                //     // Message('Total: %1', nok."Total Allocation");
                                // end;

                                // if rec."Kin Name(new)" <> '' then
                                    // Nok.Name := rec."Kin Name(new)";
                                if rec."Kin ID No.(New)" <> '' then
                                    Nok."ID No." := rec."Kin ID No.(New)";
                                if rec."Relationship (New)" <> '' then
                                    Nok.Relationship := rec."Relationship (New)";
                                if rec."Kin Date of Birth (new)" <> 0D then
                                    Nok."Date of Birth" := rec."Kin Date of Birth (new)";
                                // if rec."KinAge(New)" <> '' then
                                //     Nok.
                                // if rec."Next Of Kin Type (new)" <> rec."Next Of Kin Type (new)"::" " then
                                Nok."Next Of Kin Type" := rec."Next Of Kin Type (new)";
                                if rec."Kin Telephone(New)" <> '' then
                                    Nok.Telephone := rec."Kin Telephone(New)";
                                if rec."Description (new)" <> '' then
                                    Nok.Description := Rec."Description (new)";
                                if rec."Kin Email(New)" <> '' then
                                    Nok.Email := Rec."Kin Email(New)";
                                Nok.Modify;
                            end;
                        end else if rec."Kin Option" = 1 then begin
                            if cust.Get(Rec."Account No") then begin
                                cust.CalcFields("No of Next of Kin");
                                if cust."No of Next of Kin" < 1 then begin
                                    if rec."%Allocation (New)" > 100 then Error('The % Allocation cannot be greater than 100%.');
                                    nokNo:= 1;
                                    NoK.init;
                                    NoK."Account No" := cust."No.";
                                    NoK.Name := Rec."Kin Name(new)";
                                    NoK."Next Of Kin Type" := rec."Next Of Kin Type (new)";
                                    NoK."Date of Birth" := rec."Kin Date of Birth (new)";
                                    NoK.Telephone := rec."Kin Telephone(New)";
                                    NoK."ID No." := rec."Kin ID No.(New)";
                                    NoK.Relationship := rec."Relationship (New)";
                                    NoK.Email := rec."Kin Email(New)";
                                    NoK."%Allocation" := rec."%Allocation (New)";
                                    NoK."NoK No." := nokNo;
                                    NoK.Insert;
                                    // nokNo := nokNo +1;
                                end else if cust."No of Next of Kin" >= 1 then begin
                                    NoK.Reset();
                                    NoK.SetRange("Account No", Rec."Account No");
                                    if NoK.FindLast() then begin
                                        newNokno:= NoK."NoK No." + 1;
                                    end;
                                    NoK.Reset();
                                    NoK.SetRange("Account No", Rec."Account No");
                                    if NoK.FindSet() then begin
                                        nok.CalcSums("%Allocation");
                                        Message('Current % Allocation: %1.', nok."%Allocation");
                                        nokAllocation := 100 - Nok."%Allocation";
                                        if nokAllocation < rec."%Allocation (New)" then Error('This NoK''s % allocation cannot be greater than %1.', nokAllocation);
                                    end;
                                    nokNo:= newNokno;
                                    NoK.init;
                                    NoK."Account No" := cust."No.";
                                    NoK.Name := Rec."Kin Name(new)";
                                    NoK."Next Of Kin Type" := rec."Next Of Kin Type (new)";
                                    NoK."Date of Birth" := rec."Kin Date of Birth (new)";
                                    NoK.Telephone := rec."Kin Telephone(New)";
                                    NoK."ID No." := rec."Kin ID No.(New)";
                                    NoK.Relationship := rec."Relationship (New)";
                                    NoK.Email := rec."Kin Email(New)";
                                    NoK."%Allocation" := rec."%Allocation (New)";
                                    NoK."NoK No." := nokNo;
                                    NoK.Insert;
                                end;
                            end;
                        end;
                    end;

                    if rec.Type = rec.Type::"Backoffice Change" then begin
                        Memb.Reset;
                        Memb.SetRange(Memb."No.", rec."Account No");
                        if Memb.Find('-') then begin
                            if rec."Name(New Value)" <> '' then
                                Memb.Name := rec."Name(New Value)";
                            Memb."Global Dimension 2 Code" := rec.Branch;
                            if rec."Address(New Value)" <> '' then
                                Memb.Address := rec."Address(New Value)";
                            if rec."Post Code (New)" <> '' then
                                Memb."Post Code" := rec."Post Code (New)";
                            if rec."Email(New Value)" <> '' then begin
                                Memb."E-Mail" := rec."Email(New Value)";
                                Memb."E-Mail (Personal)" := rec."Email(New Value)";
                            end;

                            if Rec."Membership Status(New)" <> rec."Membership Status" then begin
                                Memb."Membership Status":= rec."Membership Status(New)";
                            end;

                            if rec."Mobile No(New Value)" <> '' then
                                Memb."Mobile Phone No" := rec."Mobile No(New Value)";
                            if rec."Designation Code(New)" <> '' then
                                Memb.Designation := rec."Designation Code(New)";
                            Memb.Modify;

                            if Rec."Workstation Code(New)" <> '' then
                                Memb.Workstation := Rec."Workstation Code(New)";
                            Memb.Modify;
                            if rec."ATM No.(New Value)" <> '' then
                                Memb."ATM No" := rec."ATM No.(New Value)";

                            if rec."Phone No.(New)" <> '' then
                                Memb."Mobile Phone No" := rec."Phone No.(New)";
                            Memb."Phone No." := rec."Phone No.(New)";
                            if rec."ID No(New Value)" <> '' then
                                Memb."ID No." := rec."ID No(New Value)";
                            if rec."Personal No(New Value)" <> '' then begin
                                Memb."Payroll No" := rec."Personal No(New Value)";
                                Memb.Validate("Payroll No");
                                loans.Reset;
                                loans.SetRange(loans."Client Code", rec."Account No");
                                if loans.Find('-') then begin
                                    repeat
                                        loans."Staff No" := rec."Personal No(New Value)";
                                        loans.Modify;
                                    until loans.Next = 0;
                                end;
                            end;
                            if rec."City(New Value)" <> '' then begin
                                Memb.City := rec."City(New Value)";
                                Memb.Status := rec."Status(New Value)";
                            end;

                            if rec."Section(New Value)" <> '' then begin
                                Memb.Section := rec."Section(New Value)";
                                Memb.Blocked := rec."Blocked (New)";
                            end;
                            if rec."Marital Status(New Value)" <> rec."marital status(new value)"::" " then
                                Memb."Marital Status" := rec."Marital Status(New Value)";
                            if rec."Responsibility Centers" <> '' then
                                Memb."Responsibility Center" := rec."Responsibility Centers";
                            if rec."Occupation(New)" <> '' then
                                Memb.Occupation := rec."Occupation(New)";
                            if Rec."Monthly Contributions(NewValu)" > 0 then
                                Memb."Monthly Contribution" := Rec."Monthly Contributions(NewValu)";

                            if rec."Bank Code(New)" <> '' then
                                Memb."Bank Code" := rec."Bank Code(New)";
                            if rec."Bank Name (New)" <> '' then
                                if rec."Bank Account No(New)" <> '' then
                                    Memb."Bank Account No." := rec."Bank Account No(New)";

                            if rec."Bank Branch Code(New)" <> '' then
                                Memb."Bank Branch Code" := rec."Bank Branch Code(New)";

                            if rec."KRA Pin(New)" <> '' then
                                Memb.Pin := rec."KRA Pin(New)";

                            Memb."Last Date Modified" := rec."Capture Date";
                            if rec."County(New Value)" <> '' then
                                Memb.County := rec."County(New Value)";
                            if Rec."Sub-county(New Value)" <> '' then
                                Memb."Sub-county" := Rec."Sub-county(New Value)";
                            if Rec."Area(New Value)" <> '' then
                                Memb."Area" := Rec."Area(New Value)";

                            if rec."Group Account Name" <> '' then
                                Memb."Group Account Name" := rec."Group Account Name";
                            if rec."Employer Code(New)" <> '' then
                                Memb."Employer Code" := rec."Employer Code(New)";
                            if PictureRef <> '00000000-0000-0000-0000-000000000000' then
                                Memb.Piccture := Rec.Picture;
                            if SignatureRef <> '00000000-0000-0000-0000-000000000000' then
                                Memb.Signature := Rec.signinature;
                            if BackIDRef <> '00000000-0000-0000-0000-000000000000' then
                                Memb."ID Back" := Rec."ID Back";
                            if FrontIDRef <> '00000000-0000-0000-0000-000000000000' then begin
                                Memb."ID Front" := Rec."ID Front";
                            end;

                            Memb."Member Type" := rec."Member Type(New Value)";
                            Memb."Insider Status" := rec."Insider Status (New)";

                            Memb."Date of Birth" := rec."Date Of Birth";

                            Memb.Gender := rec.Gender;
                            Memb.Status := rec."Status.(New)";
                            Memb."Account Category" := rec."Account Category(New Value)";
                            Memb.Modify;

                            vend.Reset;
                            vend.SetRange(vend."BOSA Account No", rec."Account No");
                            if vend.Find('-') then begin
                                repeat
                                    if rec."Name(New Value)" <> '' then
                                        vend.Name := rec."Name(New Value)";
                                    vend."Global Dimension 2 Code" := rec.Branch;
                                    if rec."Address(New Value)" <> '' then
                                        vend.Address := rec."Address(New Value)";

                                    if rec."Email(New Value)" <> '' then
                                        vend."E-Mail" := rec."Email(New Value)";
                                    vend."E-Mail (Personal)" := rec."Email(New Value)";
                                    vend.Status := rec."Status (New Value)";
                                    if rec."Mobile No(New Value)" <> '' then begin

                                        vend."Mobile Phone No" := rec."Mobile No(New Value)";
                                        vend."Mobile Phone No" := rec."Mobile No(New Value)";
                                        vend."Phone No." := rec."Mobile No(New Value)";


                                    end;

                                    if PictureRef <> '00000000-0000-0000-0000-000000000000' then
                                        vend.Piccture := Rec.Picture;
                                    if SignatureRef <> '00000000-0000-0000-0000-000000000000' then
                                        vend.Signature := Rec.signinature;
                                    if BackIDRef <> '00000000-0000-0000-0000-000000000000' then
                                        vend."ID Back" := Rec."ID Back";
                                    if FrontIDRef <> '00000000-0000-0000-0000-000000000000' then
                                        vend."ID Front" := Rec."ID Front";


                                    if rec."S-Mobile No(New Value)" <> '' then
                                        vend."S-Mobile No" := rec."S-Mobile No(New Value)";
                                    if rec."ATM Collector Name" <> '' then
                                        vend."ATM Collector Name" := rec."ATM Collector Name";
                                    if rec."ID No(New Value)" <> '' then
                                        vend."ID No." := rec."ID No(New Value)";
                                    if rec."KRA Pin(New)" <> '' then
                                        vend."KRA Pin" := rec."KRA Pin(New)";
                                    if rec."Personal No(New Value)" <> '' then
                                        vend."Personal No." := rec."Personal No(New Value)";
                                    if rec."City(New Value)" <> '' then
                                        vend.City := rec."City(New Value)";
                                    if rec."Section(New Value)" <> '' then
                                        vend.Section := rec."Section(New Value)";
                                    if rec."Date Of Birth" <> 0D then
                                        vend."Date of Birth" := rec."Date Of Birth";
                                    if rec."Marital Status(New Value)" <> rec."marital status(new value)"::" " then
                                        vend."Marital Status" := rec."Marital Status(New Value)";
                                    if rec."Responsibility Centers" <> '' then
                                        vend."Responsibility Center" := rec."Responsibility Centers";
                                    if rec."Phone No.(New)" <> '' then
                                        vend."Phone No." := rec."Phone No.(New)";
                                    if rec."ATM No.(New Value)" <> '' then
                                        vend."ATM No." := rec."ATM No.(New Value)";
                                    vend."Phone No." := rec."Mobile No(New Value)";
                                    vend.Blocked := rec."Blocked (New)";
                                    vend.Status := rec."Status.(New)";
                                    vend.Modify;
                                until vend.Next() = 0;
                            end;

                        end;

                    end;
                    Audit.FnInsertAuditRecords(UserId, 'Change Request', 0, Rec.No, today, time, '', Rec.No, Rec."Account No", '');
                    rec.Changed := true;
                    rec.Modify;
                    Message('Changes have been updated Successfully');
                end;
            }
            action("Send Approval Request")
            {
                Caption = 'Send A&pproval Request';
                Image = SendApprovalRequest;
                Enabled = canSendApproval;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedOnly = true;

                trigger OnAction()
                var
                    text001: label 'The record should be open to send an approval request';
                    Workflowintegration: Codeunit WorkflowIntegration;
                begin

                    if rec.Status <> rec.Status::Open then
                        Error(text001);
                    rec.TestField("Reason for change");
                    if Workflowintegration.CheckChangeRequestApprovalsWorkflowEnabled(Rec) then
                        Workflowintegration.OnSendChangeRequestForApproval(Rec);
                end;
            }
            action("Cancel Approval Request")
            {
                Caption = 'Cancel A&pproval Request';
                Image = CancelApprovalRequest;
                Enabled = CanCancelApprovalForRecord;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedOnly = true;

                trigger OnAction()
                var
                    text001: label 'This batch is already pending approval';
                    notPending: Label 'The record should be pending approval to cancel an approval request';
                    Workflowintegration: Codeunit WorkflowIntegration;
                begin
                    if rec.Status = rec.Status::Pending then begin
                        Workflowintegration.OnCancelChangeRequestApprovalRequest(Rec);
                    end else begin
                        Error(notPending);
                    end;
                end;
            }
            action(Approvals)
            {
                Caption = 'Approvals';
                Image = Approvals;
                Enabled = OpenApprovalEntriesExistForCurrUser;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedOnly = true;

                trigger OnAction()
                var
                    ApprovalEntries: Page "Approval Entries";
                    approvalDoc: Enum "Approval Document Type";
                begin
                    // DocumentType := Documenttype::ChangeRequest;
                    ApprovalEntries.SetRecordFilters(Database::"Change Request", approvalDoc::ChangeRequest, Rec.No);
                    ApprovalEntries.Run;
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
                PromotedOnly = true;
                Visible = false;

                trigger OnAction()
                begin

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
                PromotedOnly = true;
                RunObject = Page "Next of Kin-Change";
                RunPageLink = "Account No" = field("Account No");
                Visible = false;
            }
        }
    }
    trigger OnAfterGetCurrRecord() begin
        SetControlAppearance();
    end;

    trigger OnAfterGetRecord()
    begin
        AccountVisible := false;
        MobileVisible := false;
        nxkinvisible := false;
        Atmvisible := false;


        if rec.Type = rec.Type::"Mobile Change" then begin
            MobileVisible := true;
        end;

        if rec.Type = rec.Type::"ATM Change" then begin
            // AccountVisible := true;
            // nxkinvisible := true;
            Atmvisible := true;
        end;
        if rec.Type = rec.Type::"Next Of Kin Change" then begin
            NOKVisible := true;
            // nxkinvisible := true;
        end;

        if rec.Type = rec.Type::"Backoffice Change" then begin
            AccountVisible := true;
            nxkinvisible := true;
        end;
        FOSAVisible := false;

        if rec.Type = rec.Type::"Agile Change" then begin
            FOSAVisible := true;
            // nxkinvisible := true;
        end;
        
        storeVisible := false;
        if rec."Account Type" = '111' then begin
            storeVisible:= true;
        end;
        UpdateControl();
    end;

    trigger OnOpenPage()
    begin
        AccountVisible := false;
        MobileVisible := false;
        nxkinvisible := false;
        Atmvisible := false;

        if rec.Type = rec.Type::"Mobile Change" then begin
            MobileVisible := true;
        end;

        if rec.Type = rec.Type::"ATM Change" then begin
            // AccountVisible := true;
            // nxkinvisible := false;
            Atmvisible := true;
        end;

        if rec.Type = rec.Type::"Backoffice Change" then begin
            AccountVisible := true;
            nxkinvisible := true;
        end;
        FOSAVisible := false;

        if rec.Type = rec.Type::"Agile Change" then begin
            FOSAVisible := true;
            // nxkinvisible := true;
        end;
        if rec.Type = rec.Type::"Next Of Kin Change" then begin
            NOKVisible := true;
            // nxkinvisible := true;
        end;
        
        storeVisible := false;
        if rec."Account Type" = '111' then begin
            storeVisible:= true;
        end;
        UpdateControl();
    end;

    var
        vend: Record Vendor;
        Memb: Record Customer;
        MobileVisible: Boolean;
        AtmVisible: Boolean;
        AccountVisible: Boolean;
        storeVisible: Boolean;
        NOKVisible: Boolean;
        FOSAVisible: Boolean;
        ProductNxK: Record "FOSA Account NOK Details";
        MembNxK: Record "Members Next of Kin";
        cloudRequest: Record "Change Request";
        cust: Record "Customer";
        nokNo: Integer;
        nokAllocation: Decimal;
        newNokno: Integer;
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
        WorkstationEditable: Boolean;
        DesignationEditable: Boolean;

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
        Audit: Codeunit "AU Audit Management";
        AccountNoEditable: Boolean;
        AccountCategoryEditable: Boolean;
        ReactivationFeeEditable: Boolean;
        loans: Record "Loans Register";
        RetirementDateEditable: Boolean;
        Nok: record "Members Next of Kin";
        insider: record InsiderLending;
        ObjCust: Record Customer;
        OpenApprovalEntriesExist: Boolean;
        CanCancelApprovalForRecord: Boolean;
        EnabledApprovalWorkflowsExist: Boolean;
        EnableCreateMember: Boolean;
        OpenApprovalEntriesExistForCurrUser: Boolean;
        canSendApproval: Boolean;
        canCreate: Boolean;


    local procedure UpdateControl()
    begin
        if rec.status = rec.Status::Open then begin
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
            WorkstationEditable := true;
            DesignationEditable := true;
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
                WorkstationEditable := false;
                DesignationEditable := false;
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
                    WorkstationEditable := false;
                    DesignationEditable := false;

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

    local procedure SetControlAppearance()
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    begin
        OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Rec.RecordId);
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(Rec.RecordId);
        if rec.Status = rec.Status::Open then begin
            canSendApproval := True;
            canCreate := false;
        end
        else if Rec.Status = Rec.Status::Approved then begin
            canSendApproval := false;
            canCreate := true;
        end
        else begin
            canSendApproval := false;
            canCreate := false
        end;
    end;
}






