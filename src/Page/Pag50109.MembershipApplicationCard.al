//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50109 "Membership Application Card"
{
    ApplicationArea = All;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Reports,Approval,Budgetary Control,Cancellation,Category7_caption,Category8_caption,Category9_caption,Category10_caption';
    SourceTable = "Membership Applications";
    //Editable=MembershipEditable;
    layout
    {
        area(content)
        {
            group("General Info")
            {
                Caption = 'Personal Information';
                field("No."; Rec."No.")
                {
                    Caption = 'Application Number';
                    Editable = NoEditable;
                }
                field("Assigned No."; Rec."Assigned No.")
                {
                    Editable = IDNoEditable;

                    Visible = true;
                    Caption = 'Member Number';
                }
                field("Mode Of Application"; Rec."Mode Of Application")
                {
                    ShowMandatory = true;
                    Editable = IDNoEditable;
                    Caption = 'Mode Of Application';
                    Visible = false;

                }
                field("Account Category"; Rec."Account Category")

                {
                    Caption = 'Member Type';
                    Editable = IDNoEditable;
                    ShowMandatory = true;
                    trigger OnValidate()

                    begin
                        Joint2DetailsVisible := false;
                        Joint3DetailsVisible := false;

                        if Rec."Account Category" = Rec."account category"::Joint then begin
                            Joint2DetailsVisible := true;
                            Joint3DetailsVisible := true;
                        end;
                        if Rec."Account Category" = Rec."account category"::Individual then begin
                            Joint2DetailsVisible := false;
                            Joint3DetailsVisible := false;
                        end;
                    end;
                }
                group("Joint Account Details")
                {
                    Visible = Joint2DetailsVisible;
                    field("How Many"; Rec."How Many")
                    {
                    }
                    field("Joint Account Name"; Rec."Joint Account Name")
                    {
                        Enabled = FirstNameEditable;
                        // Visible = Joint2DetailsVisible;
                        Editable = IDNoEditable;
                    }
                    field("Signing Instructions"; Rec."Signing Instructions")
                    {
                        Enabled = FirstNameEditable;
                        // Visible = Joint2DetailsVisible;
                        OptionCaption = ' ,Any to Sign,Two to Sign,Three to Sign,Sole Signatory';
                        Editable = IDNoEditable;
                    }
                }
                field("ID No."; Rec."ID No.")
                {
                    Editable = IDNoEditable;
                    ShowMandatory = true;


                    trigger OnValidate()

                    begin
                        RejoiningDetailsVisible := false;
                        if Rec."New/Rejoining" = Rec."New/Rejoining"::Rejoining then begin
                            RejoiningDetailsVisible := true;
                        end

                    end;
                }
                field("New/Rejoining"; Rec."New/Rejoining")
                {
                    Editable = IDNoEditable;
                    ShowMandatory = true;
                    Visible = false;
                }
                field(Religion; Rec.Religion)
                {
                    Editable = IDNoEditable;
                    ShowMandatory = true;
                }
                field(Title; Rec.Title)
                {
                    Editable = IDNoEditable;
                    ShowMandatory = true;
                    Caption = 'Title';

                    trigger OnValidate()
                    begin
                        Rec.Name := Rec."Last Name";
                    end;
                }
                field("Last Name"; Rec."Last Name")
                {
                    Editable = IDNoEditable;
                    ShowMandatory = true;
                    Caption = 'Last Name';

                    trigger OnValidate()
                    begin
                        Rec.Name := Rec."Last Name";
                    end;
                }
                field("First Name"; Rec."First Name")
                {
                    Editable = IDNoEditable;
                    ShowMandatory = true;

                    trigger OnValidate()
                    begin
                        Rec.Name := Rec."Last Name" + ' ' + Rec."First Name";
                    end;
                }
                field("Middle Name"; Rec."Middle Name")
                {
                    Editable = IDNoEditable;
                    Caption = 'Other Name';
                    trigger OnValidate()
                    begin
                        Rec.Name := Rec."Last Name" + ' ' + Rec."First Name" + ' ' + Rec."Middle Name";
                    end;
                }

                field(Name; Rec.Name)
                {
                    Editable = false;
                    ShowMandatory = true;
                    Caption = 'Full Name';
                }

                field(Gender; Rec.Gender)
                {
                    Editable = IDNoEditable;
                    ShowMandatory = true;
                }
                field("Identification Document"; Rec."Identification Document")
                {
                    Editable = IDNoEditable;

                    trigger OnValidate()
                    var
                        PassportEditable: Boolean;
                        IDNoEditable: Boolean;
                    begin
                        if rec."Identification Document" = Rec."identification document"::"Nation ID Card" then begin
                            PassportEditable := false;
                            IDNoEditable := true
                        end else
                            if rec."Identification Document" = Rec."identification document"::"Passport Card" then begin
                                PassportEditable := true;
                                IDNoEditable := false
                            end else
                                if rec."Identification Document" = Rec."identification document"::"Aliens Card" then begin
                                    PassportEditable := true;
                                    IDNoEditable := true;
                                end;
                    end;
                }
                field("KRA PIN"; Rec."KRA PIN")
                {
                    Caption = 'KRA PIN No';
                    Editable = IDNoEditable;
                    trigger OnValidate()
                    begin
                        IF (StrLen(Rec."KRA PIN") <> 11) then begin
                            Error('Kra Pin should have 11 characters.');
                        end;
                    end;
                    //Editable = KRAPinEditable;
                    //ShowMandatory = false;
                }
                field("Payroll No"; Rec."Payroll No")
                {
                    Editable = IDNoEditable;
                }

                field("NHIF No"; Rec."NHIF No")
                {
                    Editable = IDNoEditable;
                    ShowMandatory = true;
                    Caption = 'NHIF Number';
                    Visible = false;
                }
                field("Passport No."; Rec."Passport No.")
                {
                    Editable = IDNoEditable;

                    Caption = 'Passport Number';
                }

                field("Religion."; Rec."Religion.")
                {
                    Editable = IDNoEditable;
                    ShowMandatory = true;
                    Caption = 'Religion';
                    Visible = false;
                }
                field("Date Format"; Rec."Date Format") { Editable = false; }

                field("Date of Birth"; Rec."Date of Birth")
                {
                    Editable = IDNoEditable;
                    ShowMandatory = true;
                }

                field("Retirement Date"; Rec."Retirement Date")
                {
                    Editable = false;

                }
                field("Receive SMS Notification"; Rec."Receive SMS Notification")
                {
                    Editable = IDNoEditable;
                    ShowMandatory = true;
                }
                field(Age; Rec.Age)
                {
                    Editable = false;
                }

                field("Registration Date"; Rec."Registration Date")
                {
                    Editable = IDNoEditable;
                    ShowMandatory = true;
                }
                field("Marital Status"; Rec."Marital Status")
                {
                    Editable = IDNoEditable;
                    ShowMandatory = true;
                }
                field("Member Region"; Rec."Member Region")
                {
                    Editable = TownEditable;
                    ShowMandatory = true;
                }
                field("Member Type"; Rec."Member Type")
                {
                    Editable = IDNoEditable;
                    ShowMandatory = true;
                    Caption = 'Membership Category';
                }
                field("Member Approval Status"; Rec."Membership Approval Status")
                {
                    Editable = false;
                }
                field("Membership Operational Status"; Rec."Membership Operational Status")
                {
                    Editable = IDNoEditable;
                }
                field("Exempted From Tax"; Rec."Exempted From Tax")
                {
                    Visible = false;
                    Editable = IDNoEditable;
                }
                field("Why Exempt from Tax?"; Rec."Why Exempt from Tax?") { Visible = false; }
                field("Tax Exemption Start Date"; Rec."Tax Exemption Start Date") { Visible = false; }
                field("Tax Exemption Period"; Rec."Tax Exemption Period") { Visible = false; }
                field("Tax Exemption End Date"; Rec."Tax Exemption End Date")
                {
                    Editable = false;
                    visible = false;
                }
                field("Station Representative"; Rec."Station Representative")
                {
                    Visible = false;
                    Editable = IDNoEditable;
                }

                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    Editable = IDNoEditable;
                    Visible = false;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    Visible = false;
                    Caption = 'Sacco Branch';
                    Editable = IDNoEditable;
                    //ShowMandatory = true;
                }
                field(Salary; Rec.Salary)
                {
                    Caption = 'Salary Range';
                    Visible = false;

                    // trigger OnValidate()
                    // var
                    //     myInt: Integer;
                    //     saccoSet: Record "Sacco General Set-Up";
                    //     theSalary: decimal;
                    // begin
                    //     // ClassATierVisible := false;
                    //     // ClassBTierVisible := false;
                    //     // ClassCTierVisible := false;
                    //     // ClassDTierVisible := false;
                    //     // ClassETierVisible := false;


                    //     // theSalary := Rec.Salary
                    //     saccoSet.get();
                    //     if (Rec.Salary = saccoSet."Min Salary Range") or (Rec.Salary <= saccoSet."Max Salary Range") then begin
                    //         Rec."Membership Class Tier" := Rec."Membership Class Tier"::"Class A";
                    //         ClassATierVisible := true;
                    //     end
                    //     else
                    //         if (Rec.Salary = saccoSet."Minimum Class B Salary Range") or (Rec.Salary <= saccoSet."Maximum Class B Salary Range") then begin
                    //             Rec."Membership Class Tier" := Rec."Membership Class Tier"::"Class B";
                    //             ClassBTierVisible := true;
                    //         end
                    //         else
                    //             if (Rec.Salary = saccoSet."Minimum Class C Salary Range") or (Rec.Salary <= saccoSet."Maximum Class C Salary Range") then begin
                    //                 Rec."Membership Class Tier" := Rec."Membership Class Tier"::"Class C";
                    //                 ClassCTierVisible := true;
                    //             end
                    //             else
                    //                 if (Rec.Salary = saccoSet."Minimum Class D Salary Range") or (Rec.Salary <= saccoSet."Maximum Class D Salary Range") then begin
                    //                     Rec."Membership Class Tier" := Rec."Membership Class Tier"::"Class D";
                    //                     ClassDTierVisible := true;
                    //                 end
                    //                 else
                    //                     if (Rec.Salary = saccoSet."Minimum Class E Salary Range") or (Rec.Salary <= saccoSet."Maximum Class E Salary Range") then begin
                    //                         Rec."Membership Class Tier" := Rec."Membership Class Tier"::"Class E";
                    //                         ClassETierVisible := true;
                    //                     end;

                    // end;
                }

                field("Membership Class Tier"; Rec."Membership Class Tier")
                {
                    Caption = 'Membership Class Tier';
                    visible = false;
                    Editable = IDNoEditable;

                    trigger OnValidate()
                    var
                        sacco: Record "Sacco General Set-Up";
                    begin
                        ClassATierVisible := false;
                        ClassBTierVisible := false;
                        ClassCTierVisible := false;
                        ClassDTierVisible := false;
                        ClassFATierVisible := false;
                        ClassFBTierVisible := false;
                        ClassFCTierVisible := false;

                        if Rec."Membership Class Tier" = Rec."Membership Class Tier"::"Class A" then begin
                            ClassATierVisible := true;
                        end;

                        if Rec."Membership Class Tier" = Rec."Membership Class Tier"::"Class B" then begin
                            ClassBTierVisible := true;
                        end;
                        if Rec."Membership Class Tier" = Rec."Membership Class Tier"::"Class C" then begin
                            ClassCTierVisible := true;
                        end;
                        if Rec."Membership Class Tier" = Rec."Membership Class Tier"::"Class D" then begin
                            ClassDTierVisible := true;
                        end;
                        if Rec."Membership Class Tier" = Rec."Membership Class Tier"::"Class FA" then begin
                            ClassFATierVisible := true;
                        end;
                        if Rec."Membership Class Tier" = Rec."Membership Class Tier"::"Class FB" then begin
                            ClassFBTierVisible := true;
                        end;
                        if Rec."Membership Class Tier" = Rec."Membership Class Tier"::"Class FC" then begin
                            ClassFCTierVisible := true;
                        end;
                        sacco.Get();
                        if Rec."Membership Class Tier" = Rec."Membership Class Tier"::"Class A" then begin
                            Rec."Monthly Contribution" := sacco.MonthlyContributions;
                        end;
                        if Rec."Membership Class Tier" = Rec."Membership Class Tier"::"Class A" then begin
                            Rec."Registration Fee" := sacco.RegistrationFee;
                        end;
                        if Rec."Membership Class Tier" = Rec."Membership Class Tier"::"Class A" then begin
                            Rec.ShareCapital := sacco.ShareCapital;
                        end;
                        if Rec."Membership Class Tier" = Rec."Membership Class Tier"::"Class A" then begin
                            Rec.BBF := sacco.BenevolentFund;
                        end;
                        if Rec."Membership Class Tier" = Rec."Membership Class Tier"::"Class B" then begin
                            Rec."Monthly Contribution" := sacco."Class B MonthlyContributions";
                        end;
                        if Rec."Membership Class Tier" = Rec."Membership Class Tier"::"Class B" then begin
                            Rec."Registration Fee" := sacco."Class B RegistrationFee";
                        end;
                        if Rec."Membership Class Tier" = Rec."Membership Class Tier"::"Class B" then begin
                            Rec.ShareCapital := sacco."Class B ShareCapital";
                        end;
                        if Rec."Membership Class Tier" = Rec."Membership Class Tier"::"Class B" then begin
                            Rec.BBF := sacco."Class B BenevolentFund";
                        end;
                        if Rec."Membership Class Tier" = Rec."Membership Class Tier"::"Class C" then begin
                            Rec."Monthly Contribution" := sacco."Class C MonthlyContributions";
                        end;
                        if Rec."Membership Class Tier" = Rec."Membership Class Tier"::"Class C" then begin
                            Rec."Registration Fee" := sacco."Class C RegistrationFee";
                        end;
                        if Rec."Membership Class Tier" = Rec."Membership Class Tier"::"Class C" then begin
                            Rec.ShareCapital := sacco."Class C ShareCapital";
                        end;
                        if Rec."Membership Class Tier" = Rec."Membership Class Tier"::"Class C" then begin
                            Rec.BBF := sacco."Class C BenevolentFund";
                        end;
                        if Rec."Membership Class Tier" = Rec."Membership Class Tier"::"Class D" then begin
                            Rec."Monthly Contribution" := sacco."Class D MonthlyContributions";
                        end;
                        if Rec."Membership Class Tier" = Rec."Membership Class Tier"::"Class D" then begin
                            Rec."Registration Fee" := sacco."Class D RegistrationFee";
                        end;
                        if Rec."Membership Class Tier" = Rec."Membership Class Tier"::"Class D" then begin
                            Rec.ShareCapital := sacco."Class D ShareCapital";
                        end;
                        if Rec."Membership Class Tier" = Rec."Membership Class Tier"::"Class D" then begin
                            Rec.BBF := sacco."Class D BenevolentFund";
                        end;
                        if Rec."Membership Class Tier" = Rec."Membership Class Tier"::"Class FA" then begin
                            Rec."Monthly Contribution" := sacco."Class FA MonthlyContributions";
                        end;
                        if Rec."Membership Class Tier" = Rec."Membership Class Tier"::"Class FA" then begin
                            Rec."Registration Fee" := sacco."Class FA RegistrationFee";
                        end;
                        if Rec."Membership Class Tier" = Rec."Membership Class Tier"::"Class FA" then begin
                            Rec.ShareCapital := sacco."Class FA ShareCapital";
                        end;
                        if Rec."Membership Class Tier" = Rec."Membership Class Tier"::"Class FA" then begin
                            Rec.BBF := sacco."Class FA BenevolentFund";
                        end;
                        if Rec."Membership Class Tier" = Rec."Membership Class Tier"::"Class FB" then begin
                            Rec."Monthly Contribution" := sacco."Class FB MonthlyContributions";
                        end;
                        if Rec."Membership Class Tier" = Rec."Membership Class Tier"::"Class FB" then begin
                            Rec."Registration Fee" := sacco."Class FB RegistrationFee";
                        end;
                        if Rec."Membership Class Tier" = Rec."Membership Class Tier"::"Class FB" then begin
                            Rec.ShareCapital := sacco."Class FB ShareCapital";
                        end;
                        if Rec."Membership Class Tier" = Rec."Membership Class Tier"::"Class FB" then begin
                            Rec.BBF := sacco."Class FB BenevolentFund";
                        end;
                        if Rec."Membership Class Tier" = Rec."Membership Class Tier"::"Class FC" then begin
                            Rec."Monthly Contribution" := sacco."Class FC MonthlyContributions";
                        end;
                        if Rec."Membership Class Tier" = Rec."Membership Class Tier"::"Class FC" then begin
                            Rec."Registration Fee" := sacco."Class FC RegistrationFee";
                        end;
                        if Rec."Membership Class Tier" = Rec."Membership Class Tier"::"Class FC" then begin
                            Rec.ShareCapital := sacco."Class FC ShareCapital";
                        end;
                        if Rec."Membership Class Tier" = Rec."Membership Class Tier"::"Class FC" then begin
                            Rec.BBF := sacco."Class FC BenevolentFund";
                        end;
                    end;

                }
                group("Class A Details")
                {
                    caption = 'Class A Tier Details';
                    Visible = ClassATierVisible;

                    field("RegistrationFee"; Rec."Registration Fee")
                    {
                        Editable = false;
                    }
                    field("MonthlyContribution"; Rec."Monthly Contribution")
                    {
                        Editable = false;
                    }
                    field(SharesCapital; Rec.ShareCapital)
                    {
                        Editable = false;
                    }
                    field("Class A BBF"; Rec.BBF)
                    {
                        Editable = false;
                    }
                }
                group("Class B Details")
                {
                    caption = 'Class B Tier Details';
                    Visible = ClassBTierVisible;

                    field("Class B RegistrationFee"; Rec."Registration Fee")
                    {
                        Editable = false;
                    }
                    field("Class B MonthlyContribution"; Rec."Monthly Contribution")
                    {
                        Editable = false;
                    }
                    field("Class B ShareCapital"; Rec.ShareCapital)
                    {
                        Editable = false;
                    }
                    field("Class B BBF"; Rec.BBF)
                    {
                        Editable = false;
                    }

                }
                group("Class C Details")
                {
                    caption = 'Class C Tier Details';
                    Visible = ClassCTierVisible;

                    field("Class C RegistrationFee"; Rec."Registration Fee")
                    {
                        Editable = false;
                    }
                    field("Class C MonthlyContribution"; Rec."Monthly Contribution")
                    {
                        Editable = false;
                    }
                    field("Class C ShareCapital"; Rec.ShareCapital)
                    {
                        Editable = false;
                    }
                    field("Class C BBF"; Rec.BBF)
                    {
                        Editable = false;
                    }

                }
                group("Class D Details")
                {
                    caption = 'Class D Tier Details';
                    Visible = ClassDTierVisible;

                    field("Class D RegistrationFee"; Rec."Registration Fee")
                    {
                        Editable = false;
                    }
                    field("Class D MonthlyContribution"; Rec."Monthly Contribution")
                    {
                        Editable = false;
                    }
                    field("Class D ShareCapital"; Rec.ShareCapital)
                    {
                        Editable = false;
                    }
                    field("Class D BBF"; Rec.BBF)
                    {
                        Editable = false;
                    }
                }
                group("Class FA Details")
                {
                    caption = 'Class F-A Tier Details';
                    Visible = ClassFATierVisible;

                    field("Class FA RegistrationFee"; Rec."Registration Fee")
                    {
                        Editable = false;
                    }
                    field("Class FA MonthlyContribution"; Rec."Monthly Contribution")
                    {
                        Editable = false;
                    }
                    field("Class FA ShareCapital"; Rec.ShareCapital)
                    {
                        Editable = false;
                    }
                    field("Class FA BBF"; Rec.BBF)
                    {
                        Editable = false;
                    }
                }
                group("Class FB Details")
                {
                    caption = 'Class F-B Tier Details';
                    Visible = ClassFBTierVisible;

                    field("Class FB RegistrationFee"; Rec."Registration Fee")
                    {
                        Editable = false;
                    }
                    field("Class FB MonthlyContribution"; Rec."Monthly Contribution")
                    {
                        Editable = false;
                    }
                    field("Class FB ShareCapital"; Rec.ShareCapital)
                    {
                        Editable = false;
                    }
                    field("Class FB BBF"; Rec.BBF)
                    {
                        Editable = false;
                    }
                }
                group("Class FC Details")
                {
                    caption = 'Class F-C Tier Details';
                    Visible = ClassFCTierVisible;

                    field("Class FC RegistrationFee"; Rec."Registration Fee")
                    {
                        Editable = false;
                    }
                    field("Class FC MonthlyContribution"; Rec."Monthly Contribution")
                    {
                        Editable = false;
                    }
                    field("Class FC ShareCapital"; Rec.ShareCapital)
                    {
                        Editable = false;
                    }
                    field("Class FC BBF"; Rec.BBF)
                    {
                        Editable = false;
                    }
                }

                field("Monthly Contribution"; Rec."Monthly Contribution")
                {
                    ShowMandatory = true;
                    Editable = IDNoEditable;
                }
                field(BBF; Rec.BBF)
                {
                    Editable = false;
                    visible = false;
                }
                field(ShareCapital; Rec.ShareCapital)
                {
                    Editable = false;
                    Visible = false;
                }
                field("Mode Of Remmittance"; Rec."Mode Of Remmittance")
                {

                    Visible = false;
                    Editable = IDNoEditable;
                }
                field("Customer Service Rep."; Rec."Customer Service Rep.")
                {
                    Editable = IDNoEditable;
                    Visible = true;
                }
                field("Referee ID No"; Rec."Referee ID No")
                {
                    Editable = IDNoEditable;
                    Visible = true;
                }
                field("Mode of Payment"; Rec."Mode of Payment")
                {
                    ShowMandatory = true;
                    Visible = false;
                }
                field("Transaction Reference Number"; Rec."Transaction Reference Number")
                {
                    Visible = false;
                }
                field("Registration Fee"; Rec."Registration Fee")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Registration Status"; Rec."Registration Status")
                {
                    ShowMandatory = true;
                    Editable = Rec."Mode of Payment" = Rec."Mode of Payment"::Checkoff;
                }
                field("Registration Fee Comm %"; Rec."Registration Fee Comm %")
                {
                    Editable = IDNoEditable;
                }
                field("Registration Fee Comm Amount"; Rec."Registration Fee Comm Amount")
                {
                    Editable = IDNoEditable;
                }
                group("Rejoining Details")
                {
                    Visible = RejoiningDetailsVisible;
                    field("Rejoining Fee"; Rec."Rejoining Fee")
                    {
                        Editable = IDNoEditable;
                    }
                    field("Rejoining Date"; Rec."Rejoining Date")
                    {
                    }
                }

                field("Customer Posting Group"; Rec."Customer Posting Group")
                {
                    Editable = false;

                }


                field("E-mail Indemnified"; Rec."E-mail Indemnified")
                {
                    Editable = IDNoEditable;
                    Visible = false;
                }


                field("Country/Region Code"; Rec."Country/Region Code")
                {
                    Caption = 'Country';
                    Editable = CountryEditable;
                    LookupPageId = CountriesLookup;
                    Visible = false;

                }

                field(City; Rec.City)
                {
                    Editable = TownEditable;
                    Visible = false;
                }
                field(District; Rec.District)
                {
                    Editable = TownEditable;
                    Visible = false;
                }


                field(Location; Rec.Location)
                {
                    Editable = TownEditable;
                    Visible = false;
                }

                field("Sub-Location"; Rec."Sub-Location")
                {
                    Editable = TownEditable;
                    Visible = false;
                }



                field("Member's Residence"; Rec."Member's Residence")
                {
                    Editable = MemberResidenceEditable;
                    Visible = false;
                }
                field("Address 2"; Rec."Address 2")
                {
                    Caption = 'Physical Address';
                    Editable = PhysicalAddressEditable;
                    Visible = false;
                }



                field("Application Category"; Rec."Application Category")
                {
                    Editable = true;
                    Visible = false;
                }



                field("Captured By"; Rec."Captured By")
                {
                    Editable = false;
                }
                field("Created By"; Rec."Created By")
                {
                    Editable = false;
                }


                field("Final Approver"; Rec."Final Approver")
                {
                    Caption = 'Approved By';
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

            group("Product Patronage")
            {
                field("Property Type"; Rec."Property Type")
                {

                    Editable = IDNoEditable;
                }


                field("Loan Purpose"; Rec."Loan Purpose")
                {
                    Editable = IDNoEditable;
                    // Caption = 'Upline Customer No.';
                    Visible = true;
                }
                field("Loan Purpose Specification"; Rec."Loan Purpose Specification")
                {
                    Editable = IDNoEditable;
                    Visible = true;
                    // Caption = 'Upline Customer Name';
                }

                field("Proposed Location County"; Rec."Proposed Location County")
                {
                    Editable = IDNoEditable;
                    Visible = true;
                    // Caption = 'Upline Customer Name';
                }

                field("Proposed Location Town"; Rec."Proposed Location Town")
                {
                   Editable = IDNoEditable;
                    Visible = true;
                    // Caption = 'Upline Customer Name';
                }

                field("Is the property owned? "; Rec."Is the property owned? ")
                {
                   Editable = IDNoEditable;
                    Visible = true;
                    // Caption = 'Upline Customer Name';
                }



            }
            group("Contacts")
            {

                field(County; Rec.County)
                {
                    Caption = 'County Code';
                    Editable = IDNoEditable;
                    Visible = true;
                }
                field(CountyName; Rec.CountyName)
                {
                    Caption = 'County Name';
                    Editable = false;
                    Visible = true;
                }
                field("Sub-county"; Rec."Sub-county")
                {
                    Editable = IDNoEditable;
                    Visible = true;
                }
                field("Area"; Rec."Area")
                {
                    Editable = IDNoEditable;
                    Caption = 'Town';
                    //Visible = false;
                }

                field("Nearest Landmark"; Rec."Nearest Landmark")
                {
                    Editable = IDNoEditable;
                    Caption = 'Nearest Landmark';
                    Visible = false;
                }

                field("Mobile Phone No"; Rec."Mobile Phone No")
                {
                    Editable = IDNoEditable;
                    ShowMandatory = true;
                }


                field("Secondary Mobile No"; Rec."Secondary Mobile No")
                {
                    Caption = 'Other Mobile Number';
                    Editable = IDNoEditable;
                    Visible = true;
                }

                field("E-Mail (Personal)"; Rec."E-Mail (Personal)")
                {
                    Editable = IDNoEditable;
                    Caption = 'Personal E-mail Address';
                }

                field("Work E-Mail"; Rec."Work E-Mail")
                {
                    Editable = IDNoEditable;
                    Caption = 'Job E-mail Address';
                }
                field(Address; Rec.Address)
                {
                    Caption = 'Box Address';
                    Editable = IDNoEditable;

                }
                field("Postal Code"; Rec."Postal Code")
                {
                    Editable = IDNoEditable;

                }

            }
            group("Financials")
            {
                Visible = false;
                field("Bank Code"; Rec."Bank Code")
                {
                    Editable = IDNoEditable;
                }
                field("Bank Name"; Rec."Bank Name")
                {
                    Editable = IDNoEditable;
                }
                field("Bank Branch Code"; Rec."Bank Branch Code")
                {
                    Editable = IDNoEditable;
                }
                field("Bank Branch Name"; Rec."Bank Branch Name")
                {
                    Editable = IDNoEditable;
                }
                field("Bank Account No"; Rec."Bank Account No")
                {
                    Editable = IDNoEditable;
                }

            }
            group("Source Of Income")
            {
                Caption = 'Source Of Income';
                field("Employment Info"; Rec."Employment Info")
                {
                    Editable = IDNoEditable;
                    ShowMandatory = true;

                    trigger OnValidate()
                    var
                        Joint2DetailsVisible: Boolean;
                        Joint3DetailsVisible: Boolean;
                        AccountCategoryEditable: Boolean;
                        // EmployedVisible: Boolean;
                        // SelfEmployedVisible: Boolean;
                        // OtherVisible: Boolean;
                        PassportEditable: Boolean;
                        IDNoEditable: Boolean;
                    begin
                        EmployedVisible := false;
                        SelfEmployedVisible := false;
                        OtherVisible := false;

                        if Rec."Employment Info" = Rec."employment info"::Employed then begin
                            EmployedVisible := true;
                        end;

                        if Rec."Employment Info" = Rec."employment info"::"Self-Employed" then begin
                            SelfEmployedVisible := true;
                        end;

                        // if (Rec."Employment Info" = Rec."employment info"::Others) or (Rec."Employment Info" = Rec."employment info"::Contracting) then begin
                        //     OtherVisible := true;
                        // end;

                        if Rec."Identification Document" = Rec."identification document"::"Nation ID Card" then begin
                            PassportEditable := false;
                            IDNoEditable := true
                        end else
                            if Rec."Identification Document" = Rec."identification document"::"Passport Card" then begin
                                PassportEditable := true;
                                IDNoEditable := false
                            end else
                                if Rec."Identification Document" = Rec."identification document"::"Aliens Card" then begin
                                    PassportEditable := true;
                                    IDNoEditable := true;
                                end;
                    end;
                }
                group(Employed)
                {

                    Caption = 'Employment Details';
                    Visible = EmployedVisible;

                    field("Employment Status"; Rec."Employment Status")
                    {
                        Editable = IDNoEditable;
                        Visible = false;
                    }
                    field("Member Payment Type"; Rec."Member Payment Type")
                    {
                        Visible = false;
                        Editable = IDNoEditable;
                    }

                    field("Date of Employment"; Rec."Date of Employment")
                    {
                        Visible = false;
                        Editable = IDNoEditable;
                    }
                    field("Position Held"; Rec."Position Held")
                    {
                        Editable = IDNoEditable;
                        Visible = false;
                    }
                    field("Non MOU"; Rec."Non MOU")
                    {
                        Editable = IDNoEditable;
                    }
                    field("Employer Code"; Rec."Employer Code")
                    {
                        Editable = IDNoEditable;
                        Visible = not (Rec."Non MOU");
                    }
                    field("Employer Name"; Rec."Employer Name")
                    {
                        Editable = IDNoEditable;
                        Visible = not (Rec."Non MOU");
                    }
                    field("Non_MOU Employer Code"; Rec."Business Employer Code")
                    {
                        Editable = IDNoEditable;
                        Visible = Rec."Non MOU";
                    }
                    field("Non_MOU Employer Name"; Rec."Business Employer Name")
                    {
                        Editable = IDNoEditable;
                        Visible = Rec."Non MOU";
                    }
                    field("Employer Address"; Rec."Employer Address")
                    {
                        Editable = IDNoEditable;
                    }

                    field("Employment Terms"; Rec."Employment Terms")
                    {
                        Editable = IDNoEditable;
                        trigger OnValidate()
                        begin
                            shocontract := false;
                            if rec."Employment Terms" = rec."Employment Terms"::Contract then begin
                                shocontract := true;
                            end;
                        end;
                    }
                    field("Employment Start Date"; Rec."Employment Start Date")
                    {
                        Visible = false;
                    }
                    field("Employment Period"; Rec."Employment Period")
                    {
                        Visible = false;
                    }
                    group(ContractDetails)
                    {
                        Visible = shoContract;
                        Caption = 'Contract Details';
                        field("Employment End Date"; Rec."Employment End Date") { }
                    }

                    field(Designation; Rec.Designation)
                    {
                        Visible = true;
                        Editable = IDNoEditable;
                        ShowMandatory = true;
                    }
                    field("Workstation County"; Rec."Workstation County")
                    {
                        Editable = IDNoEditable;
                        ShowMandatory = true;
                    }
                    field("Workstation County Name"; Rec."Workstation County Name")
                    {
                        Editable = false;
                        ShowMandatory = true;
                    }
                    field("Workstation Region"; Rec."Workstation Region")
                    {
                        Editable = false;
                        ShowMandatory = true;
                    }
                    field(Workstation; Rec.Workstation)
                    {
                        Visible = true;
                        Editable = IDNoEditable;
                        ShowMandatory = true;
                    }
                }

                group(SelfEmployed)
                {
                    Caption = 'Self_Employment Details';
                    Visible = SelfEmployedVisible;

                    field("Employer Code_Business"; Rec."Employer Code")
                    {
                        Editable = BusinessNameEditable;
                        Visible = false;
                    }
                    field("Employer Name_Business"; Rec."Employer Name")
                    {
                        Editable = false;
                        Visible = false;
                    }
                    field("Employer Address_KTDA"; Rec."Employer Address")
                    {
                        Editable = IDNoEditable;
                        Visible = false;
                    }

                    field("Employment Terms_KTDA"; Rec."Employment Terms")
                    {
                        Editable = IDNoEditable;
                        Visible = false;
                        trigger OnValidate()
                        begin
                            shocontract := false;
                            if rec."Employment Terms" = rec."Employment Terms"::Contract then begin
                                shocontract := true;
                            end;
                        end;
                    }

                    field(Designation_KTDA; Rec.Designation)
                    {

                        Editable = IDNoEditable;
                        ShowMandatory = true;
                        Visible = false;
                    }
                    field("Workstation County_KTDA"; Rec."Workstation County")
                    {
                        Editable = IDNoEditable;
                        Visible = false;
                        ShowMandatory = true;
                    }
                    field("Workstation County Name_KTDA"; Rec."Workstation County Name")
                    {
                        Editable = false;
                        ShowMandatory = true;
                        Visible = false;
                    }
                    field(Workstation_KTDA; Rec.Workstation)
                    {
                        Visible = false;
                        Editable = IDNoEditable;
                        ShowMandatory = true;
                    }
                    field(BuyingCenter_KTDA; Rec."Buying Center")
                    {
                        Visible = false;
                        Editable = IDNoEditable;
                        ShowMandatory = true;
                        ToolTip = 'If the member is not under KTDA then consider this their duty station.';
                    }
                    field("Nature Of Business"; Rec."Nature Of Business")
                    {
                        // Editable = NatureofBussEditable;
                    }
                    field(Industry; Rec.Industry)
                    {
                        Visible = false;
                        // Editable = IndustryEditable;
                    }
                    field("Business Name"; Rec."Business Name")
                    {
                        Editable = BusinessNameEditable;
                    }
                    field("Physical Business Location"; Rec."Physical Business Location")
                    {
                        Editable = PhysicalBussLocationEditable;
                    }
                    field("Year of Commence"; Rec."Year of Commence")
                    {
                        Editable = YearOfCommenceEditable;
                    }
                    field("Main Sector"; Rec."Main Sector")
                    {
                        Visible = false;

                    }
                    field("Manin Sector Name"; Rec."Main Sector Name")
                    {
                        Editable = false;
                        Caption = 'Main sector Name';
                        Visible = false;
                    }

                    field("Sub Sector"; Rec."Sub Sector")
                    {
                        Visible = false;

                    }
                    field("SubSector Name"; Rec."SubSector Name") { Editable = false; Visible = false; }


                    field("Sector Specific"; Rec."Sector Specific")
                    {
                        caption = 'Specific Sector';
                        Visible = false;
                        trigger OnValidate()
                        var
                            SpecificSector: Record "Specific Sector";
                        begin
                            /*                         SpecificSector.Reset();
                                                    SpecificSector.SetRange(SpecificSector.Code, Rec."Sector Specific");
                                                    if SpecificSector.FindFirst() then begin
                                                        Rec."Sector Specific Name" := SpecificSector.Description;
                                                        Rec."Main Sector" := SpecificSector."Main Sector";
                                                        Rec."Sub Sector" := SpecificSector."Sub-Sector";
                                                    end; */
                        end;
                    }
                    field("Sector Specific Name"; Rec."Sector Specific Name") { Editable = false; Caption = 'Specific Sector Name'; Visible = false; }
                }
                group(Other)
                {
                    Caption = 'Details';
                    Visible = OtherVisible;
                    field("Others Details"; Rec."Others Details")
                    {
                        Caption = 'Occupation Details';
                        Editable = OthersEditable;
                    }
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
                        Editable = IDNoEditable;
                    }
                    field("Member Residency Status"; Rec."Member Residency Status")
                    {
                        ShowMandatory = true;
                        Editable = IDNoEditable;
                    }
                    field(Entities; Rec.Entities)
                    {
                        Editable = IDNoEditable;
                    }
                    field("Industry Type"; Rec."Industry Type")
                    {
                        ShowMandatory = true;
                        Editable = IDNoEditable;
                    }
                    field("Length Of Relationship"; Rec."Length Of Relationship")
                    {
                        ShowMandatory = true;
                        Editable = IDNoEditable;
                    }
                    field("International Trade"; Rec."International Trade")
                    {
                        ShowMandatory = true;
                        Editable = IDNoEditable;
                    }
                }
                group("Product Risk Rating")
                {
                    //Visible = false;
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
                        //   Image = Person;
                        //StyleExpr = CoveragePercentStyle;
                    }
                    field("Due Diligence Measure"; Rec."Due Diligence Measure")
                    {
                        Editable = false;
                        //   Image = Person;
                        //StyleExpr = CoveragePercentStyle;
                    }
                }
                part(Control27; "Member Due Diligence Measure")
                {
                    Caption = 'Due Diligence Measure';
                    SubPageLink = "Member No" = field("No.");
                    SubPageView = sorting("Due Diligence No");
                }
            }
            group(Joint2Details)
            {
                Caption = 'Joint Account Two';
                Visible = Joint2DetailsVisible;
                field("First Name2"; Rec."First Name2")
                {
                    Caption = 'First Name';
                    ShowMandatory = true;

                    trigger OnValidate()
                    begin
                        Rec."Name 2" := Rec."First Name2";
                    end;
                }
                field("Middle Name2"; Rec."Middle Name2")
                {
                    Caption = 'Middle Name';

                    trigger OnValidate()
                    begin
                        Rec."Name 2" := Rec."First Name2" + ' ' + Rec."Middle Name2";
                    end;
                }
                field("Last Name2"; Rec."Last Name2")
                {
                    Caption = 'Last Name';
                    ShowMandatory = true;

                    trigger OnValidate()
                    begin
                        Rec."Name 2" := Rec."First Name2" + ' ' + Rec."Middle Name2" + ' ' + Rec."Last Name2";
                    end;
                }
                field("Name 2"; Rec."Name 2")
                {
                    Caption = 'Name';
                    Editable = false;
                }
                field(Address3; Rec.Address3)
                {
                    Caption = 'Address';
                }
                field("Postal Code 2"; Rec."Postal Code 2")
                {
                    Caption = 'Postal Code';
                }
                field("Town 2"; Rec."Town 2")
                {
                    Caption = 'Town';
                }
                field("Mobile No. 3"; Rec."Mobile No. 3")
                {
                    Caption = 'Mobile No.';
                    ShowMandatory = true;
                }
                field("Date of Birth2"; Rec."Date of Birth2")
                {
                    Caption = 'Date of Birth';
                }
                field("ID No.2"; Rec."ID No.2")
                {
                    Caption = 'ID No.';
                    ShowMandatory = true;
                }
                field("Passport 2"; Rec."Passport 2")
                {
                    Caption = 'Passport No.';
                }
                field(Gender2; Rec.Gender2)
                {
                    Caption = 'Gender';
                    ShowMandatory = true;
                }
                field("Marital Status2"; Rec."Marital Status2")
                {
                    Caption = 'Marital Status';
                }
                field("Home Postal Code2"; Rec."Home Postal Code2")
                {
                    Caption = 'Home Postal Code';
                }
                field("Home Town2"; Rec."Home Town2")
                {
                    Caption = 'Home Town';
                }
                field("Employer Code2"; Rec."Employer Code2")
                {
                    Caption = 'Employer Code';
                }
                field("Employer Name2"; Rec."Employer Name2")
                {
                    Caption = 'Employer Name';
                }
                field("E-Mail (Personal2)"; Rec."E-Mail (Personal2)")
                {
                    Caption = 'E-Mail (Personal)';
                }
            }
            group(Joint3Details)
            {
                Caption = 'Joint Account Three';
                Visible = Joint3DetailsVisible;
                field("First Name3"; Rec."First Name3")
                {
                    Caption = 'First Name';
                    ShowMandatory = true;

                    trigger OnValidate()
                    begin
                        Rec."Name 3" := Rec."First Name3";
                    end;
                }
                field("Middle Name 3"; Rec."Middle Name 3")
                {
                    Caption = 'Middle Name';

                    trigger OnValidate()
                    begin
                        Rec."Name 3" := Rec."First Name3" + ' ' + Rec."Middle Name 3";
                    end;
                }
                field("Last Name3"; Rec."Last Name3")
                {
                    Caption = 'Last Name';
                    ShowMandatory = true;

                    trigger OnValidate()
                    begin
                        Rec."Name 3" := Rec."First Name3" + ' ' + Rec."Middle Name 3" + ' ' + Rec."Last Name3";
                    end;
                }
                field("Name 3"; Rec."Name 3")
                {
                    Caption = 'Name';
                    Editable = false;
                }
                field(Address4; Rec.Address4)
                {
                    Caption = 'Address';
                }
                field("Postal Code 3"; Rec."Postal Code 3")
                {
                    Caption = 'Postal Code';
                }
                field("Town 3"; Rec."Town 3")
                {
                    Caption = 'Town';
                }
                field("Mobile No. 4"; Rec."Mobile No. 4")
                {
                    Caption = 'Mobile No.';
                    ShowMandatory = true;
                }
                field("Date of Birth3"; Rec."Date of Birth3")
                {
                    Caption = 'Date of Birth';
                    ShowMandatory = true;
                }
                field("ID No.3"; Rec."ID No.3")
                {
                    Caption = 'ID No.';
                    ShowMandatory = true;
                }
                field("Passport 3"; Rec."Passport 3")
                {
                    Caption = 'Passport No.';
                }
                field(Gender3; Rec.Gender3)
                {
                    Caption = 'Gender';
                    ShowMandatory = true;
                }
                field("Marital Status3"; Rec."Marital Status3")
                {
                    Caption = 'Marital Status';
                }
                field("Home Postal Code3"; Rec."Home Postal Code3")
                {
                    Caption = 'Home Postal Code';
                }
                field("Home Town3"; Rec."Home Town3")
                {
                    Caption = 'Home Town';
                }
                field("Employer Code3"; Rec."Employer Code3")
                {
                    Caption = 'Employer Code';
                }
                field("Employer Name3"; Rec."Employer Name3")
                {
                    Caption = 'Employer Name';
                }
                field("E-Mail (Personal3)"; Rec."E-Mail (Personal3)")
                {
                }
            }
        }
        area(factboxes)
        {
            part(Control35; "Member Picture-App")
            {
                Caption = 'Picture';
                //Editable = MobileEditable;
                SubPageLink = "No." = field("No.");
                // Visible=false;
            }
            part(Control36; "Member Signature-App")
            {
                Caption = 'Signature';
                Editable = MobileEditable;
                Enabled = MobileEditable;
                // Visible=false;
                SubPageLink = "No." = field("No.");
            }

            part(Control36778; "Member FrontID-App")
            {
                Caption = 'Front ID';
                Editable = MobileEditable;
                Enabled = MobileEditable;
                SubPageLink = "No." = field("No.");
            }

            part(Control36779; "Member BackID-App")
            {
                Caption = 'Back ID';
                Editable = MobileEditable;
                Enabled = MobileEditable;
                SubPageLink = "No." = field("No.");
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
                    Visible=false;

                    trigger OnAction()
                    begin
                        /*                         ObjProductsApp.RESET;
                                                ObjProductsApp.SETRANGE(ObjProductsApp."Membership Applicaton No", Rec."No.");
                                                IF ObjProductsApp.FINDSET THEN BEGIN
                                                    ObjProductsApp.DELETEALL;
                                                END;


                                                AccoutTypes.RESET;
                                                AccoutTypes.SETRANGE(AccoutTypes."Default Account", TRUE);
                                                IF AccountTypes.FIND('-') THEN BEGIN
                                                    REPEAT
                                                        IF AccountTypes."Default Account" = TRUE THEN BEGIN
                                                            ObjProductsApp.INIT;
                                                            ObjProductsApp."Membership Applicaton No" := Rec."No.";
                                                            ObjProductsApp.Names := Rec.Name;
                                                            ObjProductsApp.Product := AccountTypes.Code;
                                                            ObjProductsApp."Product Name" := AccountTypes.Description;
                                                            ObjProductsApp."Product Source" := AccoutTypes."Activity Code";
                                                            ObjProductsApp.INSERT;
                                                            ObjProductsApp.VALIDATE(ObjProductsApp.Product);
                                                            ObjProductsApp.MODIFY;
                                                        END;
                                                    UNTIL AccountTypes.NEXT = 0;
                                                END;  */


                    end;
                }
                action("Next of Kin Details")
                {
                    Caption = 'Nominees';
                    Image = Relationship;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;
                    RunObject = Page "Membership App Nominee Detail";
                    RunPageLink = "Account No" = field("No.");
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

                    trigger OnAction()
                    var
                        ObjMemberAppSignatories: Record "Member App Signatories";
                    begin


                        //===================================================================Signatory 1
                        if Rec."Account Category" = Rec."account category"::Joint then begin
                            ObjMemberAppSignatories.Init;
                            ObjMemberAppSignatories."Account No" := Rec."No.";
                            ObjMemberAppSignatories.Names := Rec.Name;
                            ObjMemberAppSignatories."ID No." := Rec."ID No.";
                            ObjMemberAppSignatories."Date Of Birth" := Rec."Date of Birth";
                            ObjMemberAppSignatories."Email Address" := Rec."E-Mail (Personal)";
                            ObjMemberAppSignatories."Mobile No." := Rec."Mobile Phone No";
                            ObjMemberAppSignatories.Insert;
                        end;

                        //===================================================================Signatory 2
                        if Rec."Account Category" = Rec."account category"::Joint then begin
                            ObjMemberAppSignatories.Init;
                            ObjMemberAppSignatories."Account No" := Rec."No.";
                            ObjMemberAppSignatories.Names := Rec."Name 2";
                            ObjMemberAppSignatories."ID No." := Rec."ID No.2";
                            ObjMemberAppSignatories."Date Of Birth" := Rec."Date of Birth2";
                            ObjMemberAppSignatories."Email Address" := Rec."E-Mail (Personal2)";
                            ObjMemberAppSignatories."Mobile No." := Rec."Mobile No. 2";
                            ObjMemberAppSignatories.Insert;
                        end;

                        //===================================================================Signatory 3
                        if Rec."Account Category" = Rec."account category"::Joint then begin
                            ObjMemberAppSignatories.Init;
                            ObjMemberAppSignatories."Account No" := Rec."No.";
                            ObjMemberAppSignatories.Names := Rec."Name 3";
                            ObjMemberAppSignatories."ID No." := Rec."ID No.3";
                            ObjMemberAppSignatories."Date Of Birth" := Rec."Date of Birth3";
                            ObjMemberAppSignatories."Email Address" := Rec."E-Mail (Personal3)";
                            ObjMemberAppSignatories."Mobile No." := Rec."Mobile No. 3";
                            ObjMemberAppSignatories.Insert;
                        end;
                    end;
                }
                action("Member Agent Details")
                {
                    Image = Group;
                    Promoted = true;
                    Visible = false;
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
                    Visible = false;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Individual Member Risk Rating";
                    RunPageLink = "Membership Application No" = field("No.");

                    trigger OnAction()
                    begin
                        //SFactory.FnGetMemberApplicationAMLRiskRating(Rec."No.");
                    end;
                }
                separator(Action6)
                {
                    Caption = '-';
                }
                action("Send Approval Request")
                {
                    Caption = 'Send Approval Request';
                    //Enabled = (not OpenApprovalEntriesExist) and EnabledApprovalWorkflowsExist;
                    Enabled = canSendApproval;
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedOnly = true;

                    trigger OnAction()
                    var
                        Text001: label 'This request is already pending approval';
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin




                        //========================================================================================Check Next of Kin Info
                        if (Rec."Account Category" = Rec."account category"::Individual) then begin
                            ObjNOkApp.Reset;
                            ObjNOkApp.SetRange(ObjNOkApp."Account No", Rec."No.");
                            if ObjNOkApp.Find('-') = false then begin
                                Error('Please Insert Next of kin Information');
                            end;
                        end;
                        if Rec."Account Category" = Rec."account category"::Individual then begin
                            Rec.TESTFIELD(Picture);
                            Rec.TESTFIELD(Signature);
                            Rec.TESTFIELD("ID Front");
                            Rec.TESTFIELD("ID Back");
                        end;


                        if rec."ID No." = '' then begin
                            Error('The member must have an ID No.');
                        end;
                        if rec."Mobile Phone No" = '' then begin
                            Error('The member should have a mobile phone number.');
                        end;
                        if rec."Employment Info" = rec."Employment Info"::" " then begin
                            Error('The member should have an employment type.');
                        end;
                        if rec."Registration Status" <> rec."Registration Status"::Paid then begin
                            Error('The member should have paid the registration fee first.');
                        end;
                        if Rec."Membership Approval Status" = Rec."Membership Approval Status"::Approved then
                            Error('The record is already approved.');
                        if Rec."Membership Approval Status" = Rec."Membership Approval Status"::"Pending Approval" then
                            Error('The record is already Pending Approval.');
                        FnCheckfieldrestriction;



                        ObjProductsApp.Reset;
                        ObjProductsApp.SetRange(ObjProductsApp."Membership Applicaton No", Rec."No.");
                        if ObjProductsApp.FindSet then begin
                            VarProductCount := ObjProductsApp.Count;
                            if VarProductCount < 1 then
                                Error('You must select Membership and atleast 1 Account product to create');
                        end;

                        /*                         ObjProductsApp.Reset;
                                                ObjProductsApp.SetRange(ObjProductsApp."Membership Applicaton No", Rec."No.");
                                                if ObjProductsApp.FindSet = false then begin
                                                    Error('You must select products for the member');
                                                end; */

                        ObjGenSetUp.Get();

                        if Rec."Account Category" = Rec."account category"::Joint then
                            Rec.TestField(Rec."Joint Account Name");

                        //=============================================================================================Check of Member Already Exists

                        IF Rec."ID No." <> '' THEN BEGIN
                            CustomerTable.RESET;
                            CustomerTable.SETRANGE(CustomerTable."ID No.", Rec."ID No.");
                            CustomerTable.SETRANGE(CustomerTable."Customer Type", CustomerTable."Customer Type"::Member);
                            IF CustomerTable.FIND('-') THEN BEGIN
                                IF (CustomerTable."No." <> Rec."No.") AND (Rec."Account Category" = Rec."Account Category"::Individual)/* AND (CustomerTable.Status = CustomerTable.Status::Active)*/ THEN
                                    ERROR('Member has already been created');
                            END;
                        END;


                        //===================================================================================Check if there is any product Selected
                        /*                         ObjProductsApp.Reset;
                                                ObjProductsApp.SetRange(ObjProductsApp."Membership Applicaton No", Rec."No.");
                                                if ObjProductsApp.Find('-') = false then begin
                                                    Error('Please Select Products to be Openned');
                                                end; */
                        Codeunit.RUN(CODEUNIT::"Custom Workflow Events");
                        if WorkflowManagement.CheckMembershipApplicationApprovalsWorkflowEnabled(Rec) then
                            WorkflowManagement.OnSendMembershipApplicationForApproval(Rec);
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
                        if Rec."Membership Approval Status" = Rec."Membership Approval Status"::Open then
                            Error('The record is already open.');
                        IF Workflowmanagement.CheckMembershipApplicationApprovalsWorkflowEnabled(Rec) THEN
                            Workflowmanagement.OnCancelMembershipApplicationApprovalRequest(Rec);
                    end;
                }
                action(Approval)
                {
                    Caption = 'Approvals';
                    Image = Approvals;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedOnly = true;

                    trigger OnAction()
                    var
                        ApprovalEntries: Page "Approval Entries";
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
                action("Create Account")
                {
                    Caption = 'Create Account';
                    //Enabled = canCreate;
                    Image = Customer;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    //Visible = EnableCreateMember;

                    trigger OnAction()
                    var
                        VarAccounts: Text;
                        ObjAccountType: Record "Account Types-Saving Products";
                        SaccoNoSeries: Record "Sacco No. Series";
                        CustomerTable: record Customer;
                        VarNewMembNo: code[40];
                        LoansR: Record "Loans Register";
                        DataSheet: Record "Data Sheet Main";
                        LoanTypes: Record "Account Types-Saving Products";
                        PTEN: text[100];
                        SaccoGeneral: Record "Sacco General Set-Up";
                        AccountTypeCode: Code[20];
                        Zones: Record "Member Delegate Zones";
                        Zonecode: Code[10];
                        MemberNumber: Code[20];

                    begin
                        //if rec."Membership Approval Status" <> rec."Membership Approval Status"::Approved then
                        // Error('The Membership Application must be approved before the member is created');
                        Rec.TestField(Rec."Monthly Contribution");
                        FnCheckfieldrestriction;

                        /*                        ObjProductsApp.Reset;
                                               ObjProductsApp.SetRange(ObjProductsApp."Membership Applicaton No", Rec."No.");
                                               if ObjProductsApp.FindSet = false then begin
                                                   Error('You must select products (account types) to be created for the member');
                                               end;

                                               ObjProductsApp.Reset;
                                               ObjProductsApp.SetRange(ObjProductsApp."Membership Applicaton No", Rec."No.");
                                               //ObjProductsApp.SetRange(ObjProductsApp.product);
                                               if ObjProductsApp.FindSet = false then begin
                                                   Error('You must select Membership product for a new Member for Member No to be assigned');
                                               end; */

                        // if Confirm('Are you sure you want to create the selected accounts for the New Member?', false) = true then begin
                        if Confirm('Do you wish to proceed with creating this member?', true) = false then
                            exit
                        else begin


                            //================================================================================================Back office Account

                            CustomerTable.Reset();
                            CustomerTable.SetRange("ID No.", rec."ID No.");
                            if CustomerTable.Find('-') then begin
                                Error('A member already exists with the ID No. %1.', CustomerTable."ID No.");
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
                            //Create Member
                            //Message('The member number will be %1', VarNewMembNo);
                            // Error('The member number will be %1', VarNewMembNo);
                            CustomerTable.Init;
                            CustomerTable."No." := Format(VarNewMembNo);
                            CustomerTable."Applicant No." := Rec."No.";
                            CustomerTable."Created On" := Today;
                            CustomerTable.Name := Rec.Name;
                            CustomerTable.Designation := Rec.Designation;
                            CustomerTable.Workstation := Rec.Workstation;
                            CustomerTable."KTDA Buying Centre" := Rec."Buying Center";
                            CustomerTable."Last Name" := Rec."Last Name";
                            CustomerTable.Surname := Rec."Last Name";
                            CustomerTable."First Name" := Rec."First Name";
                            CustomerTable."Middle Name" := Rec."Middle Name";

                            CustomerTable.Address := Rec.Address;
                            CustomerTable."Address 2" := Rec."Address 2";
                            CustomerTable."Post Code" := Rec."Postal Code";
                            CustomerTable.Town := Rec.Town;
                            CustomerTable."Religion." := Rec."Religion.";
                            CustomerTable.Religion := Rec.Religion;
                            CustomerTable."NHIF No" := Rec."NHIF No";
                            CustomerTable.County := Rec.County;
                            CustomerTable."Allow Multiple Posting Groups" := TRUE;
                            CustomerTable.ISNormalMember := true;
                            CustomerTable."Allow Multiple Posting Groups" := TRUE;
                            CustomerTable.City := Rec.City;
                            CustomerTable."Member Type" := Rec."Member Type";
                            CustomerTable."Country/Region Code" := Rec."Country/Region Code";
                            CustomerTable."Phone No." := Rec."Mobile Phone No";
                            CustomerTable."Mobile Phone No" := Rec."Mobile Phone No";
                            CustomerTable."Mobile Phone No" := Rec."Mobile Phone No";
                            CustomerTable."Global Dimension 1 Code" := Rec."Global Dimension 1 Code";
                            CustomerTable."Global Dimension 2 Code" := Rec."Global Dimension 2 Code";
                            CustomerTable."Customer Posting Group" := Rec."Customer Posting Group";
                            CustomerTable."Registration Date" := Today;
                            CustomerTable."Mobile Phone No" := Rec."Mobile Phone No";
                            CustomerTable.Status := CustomerTable.Status::Active;
                            CustomerTable."Membership Status" := CustomerTable."Membership Status"::Active;
                            CustomerTable."Date of Birth" := Rec."Date of Birth";
                            CustomerTable.Piccture := Rec.Picture;
                            CustomerTable.Signature := Rec.Signature;
                            CustomerTable."ID Front" := Rec."ID Front";
                            CustomerTable."ID Back" := Rec."ID Back";
                            CustomerTable."Station/Department" := Rec."Station/Department";
                            CustomerTable."E-Mail" := Rec."E-Mail (Personal)";
                            CustomerTable."E-Mail (Personal)" := Rec."E-Mail (Personal)";
                            CustomerTable.Location := Rec.Location;
                            CustomerTable.Title := Rec.Title;
                            CustomerTable."Applicant No." := Rec."No.";
                            CustomerTable."Home Address" := Rec."Home Address";
                            CustomerTable."Home Postal Code" := Rec."Home Postal Code";
                            CustomerTable."Home Town" := Rec."Home Town";
                            CustomerTable."Recruited By" := Rec."Recruited By";
                            CustomerTable."Contact Person" := Rec."Contact Person";
                            CustomerTable."ContactPerson Relation" := Rec."ContactPerson Relation";
                            CustomerTable."ContactPerson Occupation" := Rec."ContactPerson Occupation";
                            CustomerTable."Reffered By Member No" := rec."Reffered By Member No";
                            CustomerTable."Reffered By Member Name" := rec."Reffered By Member Name";
                            CustomerTable."Member Share Class" := Rec."Member Share Class";
                            CustomerTable."Member's Residence" := Rec."Member's Residence";
                            CustomerTable."Member House Group" := Rec."Member House Group";
                            CustomerTable."Member House Group Name" := Rec."Member House Group Name";
                            CustomerTable."Occupation Details" := Rec."Employment Info";
                            if Rec."Non MOU" = true then begin
                                CustomerTable."Employer Code" := Rec."Business Employer Code";
                                CustomerTable."Employer Name" := Rec."Business Employer Name";
                                CustomerTable."Employer Address" := Rec."Business Employer Address";
                            end else begin
                                CustomerTable."Employer Code" := Rec."Employer Code";
                                CustomerTable."Employer Name" := Rec."Employer Name";
                                CustomerTable."Employer Address" := Rec."Employer Address";
                            end;
                            CustomerTable."Employment Terms" := Rec."Employment Terms";
                            CustomerTable."Date of Employment" := Rec."Date of Employment";
                            CustomerTable."Position Held" := Rec."Position Held";
                            CustomerTable."Expected Monthly Income" := Rec."Expected Monthly Income";
                            CustomerTable."Expected Monthly Income Amount" := Rec."Expected Monthly Income Amount";
                            CustomerTable."Nature Of Business" := Rec."Nature Of Business";
                            CustomerTable.Industry := Rec.Industry;
                            CustomerTable."Business Name" := Rec."Business Name";
                            CustomerTable."Physical Business Location" := Rec."Physical Business Location";//
                            CustomerTable."Year of Commence" := Rec."Year of Commence";
                            CustomerTable."Identification Document" := Rec."Identification Document";
                            CustomerTable."Referee Member No" := Rec."Referee Member No";
                            CustomerTable."Referee Name" := Rec."Referee Name";
                            CustomerTable."Referee ID No" := Rec."Referee ID No";
                            CustomerTable."Referee Mobile Phone No" := Rec."Referee Mobile Phone No";
                            CustomerTable."Email Indemnified" := Rec."E-mail Indemnified";
                            CustomerTable."Created By" := UserId;
                            CustomerTable."Member Needs House Group" := Rec."Member Needs House Group";
                            CustomerTable."Mode Of Remmittance" := Rec."Mode Of Remmittance";
                            CustomerTable.Gender := Rec.Gender;
                            CustomerTable."Nearest Landmark" := Rec."Nearest Landmark";
                            CustomerTable.Designation := Rec.Designation;
                            CustomerTable."Retirement Date" := Rec."Retirement Date";
                            CustomerTable.Age := Rec.Age;
                            CustomerTable."Receive SMS Notification" := Rec."Receive SMS Notification";
                            CustomerTable."Station Representative" := Rec."Station Representative";
                            CustomerTable."Sales Person" := Rec."Sales Person";
                            CustomerTable."Customer Service Rep." := Rec."Customer Service Rep.";
                            CustomerTable."Customer Service Rep. Name" := Rec."Customer Service Rep. Name";
                            //*****************************to Sort Joint
                            CustomerTable."Name 2" := Rec."Name 2";
                            CustomerTable.Address3 := Rec.Address3;
                            CustomerTable."Postal Code 2" := Rec."Postal Code 2";
                            CustomerTable."Home Postal Code2" := Rec."Home Postal Code2";
                            CustomerTable."Home Town2" := Rec."Home Town2";
                            CustomerTable."ID No.2" := Rec."ID No.2";
                            CustomerTable."Passport 2" := Rec."Passport 2";
                            CustomerTable.Gender2 := Rec.Gender2;
                            CustomerTable."Marital Status2" := Rec."Marital Status2";
                            CustomerTable."E-Mail (Personal2)" := Rec."E-Mail (Personal2)";
                            CustomerTable."Employer Code2" := Rec."Employer Code2";
                            CustomerTable."Employer Name2" := Rec."Employer Name2";
                            CustomerTable."Picture 2" := Rec."Picture 2";
                            CustomerTable."Signature  2" := Rec."Signature  2";


                            CustomerTable."Name 3" := Rec."Name 3";
                            CustomerTable."Address3-Joint" := Rec.Address4;
                            CustomerTable."Postal Code 3" := Rec."Postal Code 3";
                            CustomerTable."Home Postal Code3" := Rec."Home Postal Code3";
                            CustomerTable."Mobile No. 4" := Rec."Mobile No. 4";
                            CustomerTable."Home Town3" := Rec."Home Town3";
                            CustomerTable."ID No.3" := Rec."ID No.3";
                            CustomerTable."Passport 3" := Rec."Passport 3";
                            CustomerTable.Gender3 := Rec.Gender3;
                            CustomerTable."Marital Status3" := Rec."Marital Status3";
                            CustomerTable."E-Mail (Personal3)" := Rec."E-Mail (Personal3)";
                            CustomerTable."Employer Code3" := Rec."Employer Code3";
                            CustomerTable."Employer Name3" := Rec."Employer Name3";
                            CustomerTable."Picture 3" := Rec."Picture 3";
                            CustomerTable."Signature  3" := Rec."Signature  3";
                            CustomerTable."Member Region":=Rec."Member Region";
                            CustomerTable."Global Dimension 2 Code":=Rec."Member Region";
                            CustomerTable."Marketing Campaign ID" := Rec."Marketing Campaign ID";
                            CustomerTable."Marketing Event ID" := Rec."Marketing Event ID";
                            CustomerTable."Account Category" := Rec."Account Category";
                            CustomerTable."Joint Account Name" := Rec."Joint Account Name";
                            CustomerTable."Employment Start Date" := Rec."Employment Start Date";
                            CustomerTable."Employment End Date" := Rec."Employment End Date";
                            CustomerTable."Employment Period" := Rec."Employment Period";
                            CustomerTable."Tax Exemption End Date" := Rec."Tax Exemption End Date";
                            CustomerTable."Tax Exemption Period" := Rec."Tax Exemption Period";
                            CustomerTable."Tax Exemption Start Date" := Rec."Tax Exemption Start Date";

                            if Rec."Account Category" = Rec."account category"::Joint then
                                CustomerTable.Name := Rec."Joint Account Name";
                            //===================================================================================End Joint Account Details

                            //**
                            CustomerTable."Office Branch" := Rec."Office Branch";
                            CustomerTable.Department := Rec.Department;
                            CustomerTable.Occupation := Rec.Occupation;
                            CustomerTable."Bank Code" := Rec."Bank Code";
                            CustomerTable."Bank Branch Code" := Rec."Bank Code";
                            CustomerTable."Bank Branch Name" := UpperCase(Rec."Bank Branch Name");
                            CustomerTable."Bank Name" := Rec."Bank Name";
                            CustomerTable."Bank Account No." := Rec."Bank Account No";
                            //**
                            CustomerTable."Sub-Location" := Rec."Sub-Location";
                            CustomerTable.District := Rec.District;
                            CustomerTable."Payroll No" := Rec."Payroll No";
                            CustomerTable."ID No." := Rec."ID No.";
                            CustomerTable."Mobile Phone No" := Rec."Mobile Phone No";
                            CustomerTable."Marital Status" := Rec."Marital Status";
                            CustomerTable."Customer Type" := CustomerTable."customer type"::Member;
                            CustomerTable.Gender := Rec.Gender;
                            CustomerTable."Main Sector" := Rec."Main Sector";
                            CustomerTable."Main Sector Name" := Rec."Main Sector Name";
                            CustomerTable."Sub Sector" := Rec."Sub Sector";
                            CustomerTable."SubSector Name" := Rec."SubSector Name";
                            CustomerTable."Sector Specific" := Rec."Sector Specific";
                            CustomerTable."Sector Specific Name" := Rec."Sector Specific Name";

                            CustomerTable.Piccture := Rec.Picture;
                            CustomerTable.Signature := Rec.Signature;

                            CustomerTable."Monthly Contribution" := Rec."Monthly Contribution";
                            CustomerTable."Contact Person" := Rec."Contact Person";
                            CustomerTable."Contact Person Phone" := Rec."Contact Person Phone";
                            CustomerTable."ContactPerson Relation" := Rec."ContactPerson Relation";
                            CustomerTable."Recruited By" := Rec."Recruited By";
                            CustomerTable."ContactPerson Occupation" := Rec."ContactPerson Occupation";
                            CustomerTable."Village/Residence" := Rec."Village/Residence";
                            CustomerTable.Pin := Rec."KRA PIN";
                            CustomerTable."KYC Completed" := true;
                            //Product Patronage
                            CustomerTable."Property Type" := Rec."Property Type";
                            CustomerTable."Loan Purpose" := Rec."Loan Purpose";
                            CustomerTable."Loan Purpose Specification" := Rec."Loan Purpose Specification";
                            CustomerTable."Proposed Location County" := Rec."Proposed Location County";
                            CustomerTable."Proposed Location Town" := Rec."Proposed Location Town";
                            CustomerTable."Is the property owned? ":= Rec."Is the property owned? ";

                            //========================================================================Member Risk Rating
                            CustomerTable."Individual Category" := Rec."Individual Category";
                            CustomerTable.Entities := Rec.Entities;
                            CustomerTable."Member Residency Status" := Rec."Member Residency Status";
                            CustomerTable."Industry Type" := Rec."Industry Type";
                            CustomerTable."Length Of Relationship" := Rec."Length Of Relationship";
                            CustomerTable."International Trade" := Rec."International Trade";
                            CustomerTable."Electronic Payment" := Rec."Electronic Payment";
                            CustomerTable."Accounts Type Taken" := Rec."Accounts Type Taken";
                            CustomerTable."Cards Type Taken" := Rec."Cards Type Taken";
                            CustomerTable."Employment Start Date" := Rec."Employment Start Date";
                            CustomerTable."Employment End Date" := Rec."Employment End Date";
                            CustomerTable."Employment Period" := Rec."Employment Period";
                            CustomerTable."Tax Exemption End Date" := Rec."Tax Exemption End Date";
                            CustomerTable."Tax Exemption Period" := Rec."Tax Exemption Period";
                            CustomerTable."Tax Exemption Start Date" := Rec."Tax Exemption Start Date";
                            CustomerTable."Reffered By Member No" := Rec."Reffered By Member No";
                            CustomerTable."Reffered By Member Name" := Rec."Reffered By Member Name";
                            CustomerTable."MLM Level" := Rec."MLM Level";
                            CustomerTable."Downline ID" := Rec."Downline ID";
                            CustomerTable."Upline ID" := Rec."Upline ID";
                            //======================================================Create Standing Order No.
                            if Rec."Member Payment Type" = Rec."member payment type"::"Standing Order" then begin
                                if ObjNoSeries.Get then begin
                                    ObjNoSeries.TestField(ObjNoSeries."Standing Order Members Nos");
                                    VarStandingNo := NoSeriesMgt.GetNextNo(ObjNoSeries."Standing Order Members Nos", 0D, true);
                                    if VarStandingNo <> '' then begin
                                        CustomerTable."Standing Order No" := VarStandingNo;
                                    end;
                                end;
                            end;
                            CustomerTable.Insert(true);

                            SaccoGeneral.Get();
                            //Avice

                            DataSheet.Init;
                            DataSheet."PF/Staff No" := Rec."Payroll No";
                            DataSheet."Type of Deduction" := 'REGISTRATION FEE';
                            DataSheet."Remark/LoanNO" := VarNewMembNo;
                            DataSheet.Name := Rec.Name;
                            DataSheet."ID NO." := Rec."ID No.";
                            DataSheet."Amount ON" := SaccoGeneral."Registration Fee";
                            DataSheet."Amount OFF" := 0;
                            DataSheet."REF." := '2026';
                            DataSheet."New Balance" := 0;
                            DataSheet.Date := Today;
                            DataSheet.Employer := '';
                            DataSheet."Repayment Method" := DataSheet."Repayment Method"::Constants;
                            DataSheet."Transaction Type" := DataSheet."transaction type"::EFFECT;
                            DataSheet."Sort Code" := PTEN;
                            DataSheet.Insert;
                            //En

                            //Advice
                            DataSheet.Init;
                            DataSheet."PF/Staff No" := Rec."Payroll No";
                            DataSheet."Type of Deduction" := 'BBF FUND';
                            DataSheet."Remark/LoanNO" := VarNewMembNo;
                            DataSheet.Name := Rec.Name;
                            DataSheet."ID NO." := Rec."ID No.";
                            DataSheet."Amount ON" := 300;
                            DataSheet."Amount OFF" := 0;
                            DataSheet."REF." := '2026';
                            DataSheet."New Balance" := 0;
                            DataSheet.Date := Today;
                            DataSheet.Employer := '';
                            DataSheet."Repayment Method" := DataSheet."Repayment Method"::Constants;
                            DataSheet."Transaction Type" := DataSheet."transaction type"::EFFECT;
                            DataSheet."Sort Code" := PTEN;
                            DataSheet.Insert;

                            //En
                            //charge Registration Fee
                            GenJournalLine.Reset;
                            GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
                            GenJournalLine.SetRange("Journal Batch Name", 'REGFee');
                            GenJournalLine.DeleteAll;

                            ObjGenSetUp.Get();

                            //Charge Registration Fee
                            if ObjGenSetUp."Charge BOSA Registration Fee" = true then begin

                                LineNo := LineNo + 10000;

                                GenJournalLine.Init;
                                GenJournalLine."Journal Template Name" := 'GENERAL';
                                GenJournalLine."Journal Batch Name" := 'REGFee';
                                GenJournalLine."Document No." := Rec."No.";
                                GenJournalLine."Line No." := LineNo;
                                GenJournalLine."Account Type" := GenJournalLine."account type"::Customer;
                                GenJournalLine."Account No." := VarNewMembNo;
                                GenJournalLine.Validate(GenJournalLine."Account No.");
                                GenJournalLine."Posting Date" := Today;
                                GenJournalLine."External Document No." := 'REGFEE/' + Format(Rec."Payroll No");
                                GenJournalLine.Description := 'Registration Fee';
                                GenJournalLine.Amount := ObjGenSetUp."BOSA Registration Fee Amount";
                                GenJournalLine.Validate(GenJournalLine.Amount);
                                GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
                                GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                                GenJournalLine."Bal. Account No." := ObjGenSetUp."BOSA Registration Fee Account";
                                GenJournalLine."Transaction Type" := GenJournalLine."Transaction Type"::"Registration Fee";
                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                if GenJournalLine.Amount <> 0 then
                                    GenJournalLine.Insert;

                                GenJournalLine.Reset;
                                GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
                                GenJournalLine.SetRange("Journal Batch Name", 'REGFee');
                                if GenJournalLine.Find('-') then begin
                                    Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco", GenJournalLine);
                                end;
                            end;

                            //end Registration Fee
                            //========================================================================End Member Risk Rating

                            ObjNextOfKinApp.Reset;
                            ObjNextOfKinApp.SetRange(ObjNextOfKinApp."Account No", Rec."No.");
                            if ObjNextOfKinApp.Find('-') then begin
                                nokNo := 1;
                                repeat
                                    ObjNextOfKin.Init;
                                    ObjNextOfKin."Account No" := CustomerTable."No.";
                                    ObjNextOfKin.Name := ObjNextOfKinApp.Name;
                                    ObjNextOfKin.Relationship := ObjNextOfKinApp.Relationship;
                                    ObjNextOfKin.Beneficiary := ObjNextOfKinApp.Beneficiary;
                                    ObjNextOfKin."Date of Birth" := ObjNextOfKinApp."Date of Birth";
                                    ObjNextOfKin.Address := ObjNextOfKinApp.Address;
                                    ObjNextOfKin.Telephone := ObjNextOfKinApp.Telephone;
                                    ObjNextOfKin.Email := ObjNextOfKinApp.Email;
                                    ObjNextOfKin."ID No." := ObjNextOfKinApp."ID No.";
                                    ObjNextOfKin."Member No" := ObjNextOfKinApp."Member No";
                                    ObjNextOfKin."%Allocation" := ObjNextOfKinApp."%Allocation";
                                    ObjNextOfKin.Description := ObjNextOfKinApp.Description;
                                    ObjNextOfKin."Next Of Kin Type" := ObjNextOfKinApp."Next Of Kin Type";
                                    ObjNextOfKin."NoK No." := nokNo;
                                    ObjNextOfKin.Insert;
                                    nokNo := nokNo + 1;
                                until ObjNextOfKinApp.Next = 0;
                            end;

                            //==================================================================================Insert Member Agents
                            ObjMemberAppAgent.Reset;
                            ObjMemberAppAgent.SetRange(ObjMemberAppAgent."Account No", Rec."No.");
                            if ObjMemberAppAgent.Find('-') then begin
                                repeat

                                    if ObjNoSeries.Get then begin
                                        ObjNoSeries.TestField(ObjNoSeries."Agent Serial Nos");
                                        VarDocumentNo := NoSeriesMgt.GetNextNo(ObjNoSeries."Agent Serial Nos", 0D, true);
                                        if VarDocumentNo <> '' then begin
                                            ObjMemberAgent.Init;
                                            ObjMemberAgent."Document No" := VarDocumentNo;
                                            ObjMemberAgent."Account No" := CustomerTable."No.";
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
                                        end;
                                    end;
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
                            VarBOSAACC := CustomerTable."No.";
                            //  end;Kitui
                            // end; 

                            //==================================================================================================End Membership Registration

                            //==========================================s========================================================Member Accounts Accounts
                            ObjProductsApp.Reset;
                            ObjProductsApp.SetRange(ObjProductsApp."Membership Applicaton No", Rec."No.");
                            ObjProductsApp.SetFilter(ObjProductsApp."Product Source", '<>%1', ObjProductsApp."Product Source"::BOSA);
                            //ObjProductsApp.SETFILTER(ObjProductsApp.Product,'<>%1','');
                            if ObjProductsApp.FindSet then begin
                                repeat
                                    ObjAccountTypess.Reset();
                                    ObjAccountTypess.SetRange(ObjAccountTypess.Code, ObjProductsApp.Product);
                                    if ObjAccountTypess.find('-') then begin
                                        VarAcctNo := VarNewMembNo + ObjAccountTypess."Product Code";
                                    end;


                                    if Rec."Account Category" = Rec."account category"::Individual then begin
                                        ObjAccounts.Reset;
                                        ObjAccounts.SetRange(ObjAccounts."ID No.", Rec."ID No.");
                                        ObjAccounts.SetRange(ObjAccounts."Account Type", ObjProductsApp.Product);
                                        ObjAccounts.SetFilter(ObjAccounts.Status, '<>%1&<>%2', ObjAccounts.Status::Closed, ObjAccounts.Status::Deceased);
                                        if ObjAccounts.FindSet then begin
                                            Error('The Member has an existing %1', ObjAccounts."Account Type");
                                        end;
                                    end;

                                    if VarAcctNo <> '' then begin

                                        //===================================================================Create Account
                                        ObjAccounts.Init;
                                        ObjAccounts."No." := VarAcctNo;
                                        ObjAccounts."Date of Birth" := Rec."Date of Birth";
                                        ObjAccounts."Last Name" := Rec."Last Name";
                                        ObjAccounts.Designation := Rec.Designation;
                                        ObjAccounts.Workstation := Rec.Workstation;
                                        ObjAccounts."KTDA Buying Centre" := Rec."Buying Center";
                                        ObjAccounts."First Name" := Rec."First Name";
                                        ObjAccounts."Middle Name" := Rec."Middle Name";
                                        ObjAccounts."Referee ID No" := Rec."Referee ID No";
                                        ObjAccounts."Marital Status" := Rec."Marital Status";
                                        ObjAccounts."Why Exempt from Tax?" := Rec."Why Exempt from Tax?";
                                        ObjAccounts.Name := Rec.Name;
                                        ObjAccounts."Creditor Type" := ObjAccounts."creditor type"::"FOSA Account";
                                        ObjAccounts."Personal No." := Rec."Payroll No";
                                        ObjAccounts."ID No." := Rec."ID No.";
                                        ObjAccounts."Mobile Phone No" := Rec."Mobile Phone No";
                                        ObjAccounts."Phone No." := Rec."Mobile Phone No";
                                        ObjAccounts."Registration Date" := Rec."Registration Date";
                                        ObjAccounts."Post Code" := Rec."Postal Code";
                                        ObjAccounts.County := Rec.City;
                                        ObjAccounts.piccture := Rec.Picture;
                                        ObjAccounts.Signature := Rec.Signature;
                                        ObjAccounts."ID Front" := Rec."ID Front";
                                        ObjAccounts."ID Back" := Rec."ID Back";

                                        ObjAccounts."BOSA Account No" := CustomerTable."No.";
                                        ObjAccounts."Passport No." := Rec."Passport No.";
                                        if Rec."Non MOU" = true then begin
                                            ObjAccounts."Employer Code" := Rec."Business Employer Code";
                                        end else
                                            ObjAccounts."Employer Code" := Rec."Employer Code";

                                        ObjAccounts.Status := ObjAccounts.Status::Active;
                                        ObjAccounts."Account Type" := ObjProductsApp.Product;
                                        ObjAccounts."Date of Birth" := Rec."Date of Birth";
                                        ObjAccounts."Global Dimension 1 Code" := Format(ObjProductsApp."Product Source");
                                        ObjAccounts."Global Dimension 2 Code" := Rec."Global Dimension 2 Code";
                                        ObjAccounts.Address := Rec.Address;
                                        ObjAccounts."Employment Start Date" := Rec."Employment Start Date";
                                        ObjAccounts."Employment End Date" := Rec."Employment End Date";
                                        ObjAccounts."Employment Period" := Rec."Employment Period";
                                        ObjAccounts."Tax Exemption End Date" := Rec."Tax Exemption End Date";
                                        ObjAccounts."Tax Exemption Period" := Rec."Tax Exemption Period";
                                        ObjAccounts."Tax Exemption Start Date" := Rec."Tax Exemption Start Date";
                                        ObjAccounts."Reffered By Member No" := rec."Reffered By Member No";
                                        ObjAccounts."Reffered By Member Name" := rec."Reffered By Member Name";
                                        ObjAccounts."Sales Person" := Rec."Sales Person";
                                        ObjAccounts."Customer Service Rep." := Rec."Customer Service Rep.";
                                        ObjAccounts."Customer Service Rep. Name" := Rec."Customer Service Rep. Name";
                                        if Rec."Account Category" = Rec."account category"::Joint then begin
                                            ObjAccounts."Account Category" := ObjAccounts."account category"::Corporate;
                                            ObjAccounts."Group Category" := ObjAccounts."Group Category"::"Co-operate";
                                        end else
                                            ObjAccounts."Account Category" := Rec."Account Category";
                                        ObjAccounts."Address 2" := Rec."Address 2";
                                        ObjAccounts."Phone No." := Rec."Mobile Phone No";
                                        ObjAccounts."Registration Date" := Today;
                                        ObjAccounts.Status := ObjAccounts.Status::Active;
                                        ObjAccounts.Section := Rec.Section;
                                        ObjAccounts."Home Address" := Rec."Home Address";
                                        ObjAccounts.District := Rec.District;
                                        ObjAccounts."Application No." := Rec."No.";
                                        ObjAccounts.Location := Rec.Location;
                                        ObjAccounts."Sub-Location" := Rec."Sub-Location";
                                        ObjAccounts."Monthly Contribution" := Rec."Monthly Contribution";
                                        ObjAccounts."E-Mail" := Rec."E-Mail (Personal)";
                                        ObjAccounts."Group/Corporate Trade" := Rec."Group/Corporate Trade";
                                        ObjAccounts."Name of the Group/Corporate" := Rec."Name of the Group/Corporate";
                                        ObjAccounts."Signing Instructions" := Rec."Signing Instructions";
                                        ObjAccounts."Certificate No" := Rec."Certificate No";
                                        ObjAccounts."Application No." := Rec."No.";
                                        ObjAccounts."Created By" := UserId;
                                        ObjAccounts."Account Creation Date" := Today;

                                        //=============================================================Joint Account Details
                                        ObjAccounts."Name 2" := Rec."Name 2";
                                        ObjAccounts."Address3-Joint" := Rec.Address3;
                                        ObjAccounts."Postal Code 2" := Rec."Postal Code 2";
                                        ObjAccounts.Designation := Rec.Designation;
                                        ObjAccounts."Marketing Event ID" := Rec."Marketing Event ID";
                                        ObjAccounts."Marketing Campaign ID" := Rec."Marketing Campaign ID";
                                        ObjAccounts.Workstation := Rec.Workstation;
                                        ObjAccounts."Home Postal Code2" := Rec."Home Postal Code2";
                                        ObjAccounts."Home Town2" := Rec."Home Town2";
                                        ObjAccounts."ID No.2" := Rec."ID No.2";
                                        ObjAccounts."Passport 2" := Rec."Passport 2";
                                        ObjAccounts.Gender2 := Rec.Gender2;
                                        ObjAccounts."Marital Status2" := Rec."Marital Status2";
                                        ObjAccounts."E-Mail (Personal2)" := Rec."E-Mail (Personal2)";
                                        ObjAccounts."Employer Code2" := Rec."Employer Code2";
                                        ObjAccounts."Employer Name2" := Rec."Employer Name2";
                                        ObjAccounts."Picture 2" := Rec."Picture 2";
                                        ObjAccounts."Signature  2" := Rec."Signature  2";
                                        ObjAccounts."Member's Residence" := Rec."Member's Residence";
                                        ObjAccounts."Joint Account Name" := Rec."Joint Account Name";

                                        ObjAccounts."Name 3" := Rec."Name 3";
                                        ObjAccounts."Address3-Joint" := Rec.Address4;
                                        ObjAccounts."Postal Code 3" := Rec."Postal Code 3";
                                        ObjAccounts."Home Postal Code3" := Rec."Home Postal Code3";
                                        ObjAccounts."Home Town3" := Rec."Home Town3";
                                        ObjAccounts."ID No.3" := Rec."ID No.3";
                                        ObjAccounts."Passport 3" := Rec."Passport 3";
                                        ObjAccounts.Gender3 := Rec.Gender3;
                                        ObjAccounts."Marital Status3" := Rec."Marital Status3";
                                        ObjAccounts."E-Mail (Personal3)" := Rec."E-Mail (Personal3)";
                                        ObjAccounts."Employer Code3" := Rec."Employer Code3";
                                        ObjAccounts."Employer Name3" := Rec."Employer Name3";
                                        ObjAccounts."Picture 3" := Rec."Picture 3";
                                        ObjAccounts."Signature  3" := Rec."Signature  3";
                                        ObjAccounts."Joint Account Name" := Rec."Joint Account Name";
                                        ObjAccounts."Employment End Date" := Rec."Employment End Date";
                                        ObjAccounts."Employment Period" := Rec."Employment Period";
                                        ObjAccounts."Tax Exemption End Date" := Rec."Tax Exemption End Date";
                                        ObjAccounts."Tax Exemption Period" := Rec."Tax Exemption Period";
                                        ObjAccounts."Tax Exemption Start Date" := Rec."Tax Exemption Start Date";

                                        //=============================================================End Joint Account Details
                                        ObjAccounts.Insert;

                                        SaccoGeneral.get();

                                        //AdvicE
                                        IF ObjProductsApp.Product = '101' THEN BEGIN
                                            DataSheet.Init;
                                            DataSheet."PF/Staff No" := Rec."Payroll No";
                                            LoanTypes.get(ObjProductsApp.Product);
                                            DataSheet."Type of Deduction" := LoanTypes.Description;
                                            DataSheet."Remark/LoanNO" := VarAcctNo;
                                            DataSheet.Name := Rec.Name;
                                            DataSheet."ID NO." := Rec."ID No.";
                                            DataSheet."Amount ON" := SaccoGeneral."Retained Shares";
                                            DataSheet."Amount OFF" := 0;
                                            DataSheet."REF." := '2026';
                                            DataSheet."New Balance" := 0;
                                            DataSheet.Date := Today;
                                            DataSheet.Employer := '';
                                            DataSheet."Repayment Method" := DataSheet."Repayment Method"::Constants;
                                            DataSheet."Transaction Type" := DataSheet."transaction type"::EFFECT;
                                            DataSheet."Sort Code" := PTEN;
                                            DataSheet.Insert;
                                        END;


                                        IF ObjProductsApp.Product = '102' THEN BEGIN
                                            DataSheet.Init;
                                            DataSheet."PF/Staff No" := Rec."Payroll No";
                                            LoanTypes.get(ObjProductsApp.Product);
                                            DataSheet."Type of Deduction" := LoanTypes.Description;
                                            DataSheet."Remark/LoanNO" := VarAcctNo;
                                            DataSheet.Name := Rec.Name;
                                            DataSheet."ID NO." := Rec."ID No.";
                                            DataSheet."Amount ON" := Rec."Monthly Contribution";
                                            DataSheet."Amount OFF" := 0;
                                            DataSheet."REF." := '2026';
                                            DataSheet."New Balance" := 0;
                                            DataSheet.Date := Today;
                                            DataSheet.Employer := '';
                                            DataSheet."Repayment Method" := DataSheet."Repayment Method"::Constants;
                                            DataSheet."Transaction Type" := DataSheet."transaction type"::EFFECT;
                                            DataSheet."Sort Code" := PTEN;
                                            DataSheet.Insert;
                                        END;

                                        //End Advice
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

                                            //Update Member with FOSA Account
                                            if CustomerTable.Get(VarBOSAACC) then begin
                                                CustomerTable."FOSA Account No." := VarAcctNo;
                                                CustomerTable.Modify;
                                            end;
                                        end;

                                        ObjNextOfKinApp.Reset;
                                        ObjNextOfKinApp.SetRange(ObjNextOfKinApp."Account No", Rec."No.");
                                        if ObjNextOfKinApp.Find('-') then begin
                                            repeat
                                                ObjNextofKinFOSA.Init;
                                                ObjNextofKinFOSA."Account No" := VarAcctNo;
                                                ObjNextofKinFOSA.Name := ObjNextOfKinApp.Name;
                                                ObjNextofKinFOSA.Relationship := ObjNextOfKinApp.Relationship;
                                                ObjNextofKinFOSA.Beneficiary := ObjNextOfKinApp.Beneficiary;
                                                ObjNextofKinFOSA."Date of Birth" := ObjNextOfKinApp."Date of Birth";
                                                ObjNextofKinFOSA.Address := ObjNextOfKinApp.Address;
                                                ObjNextofKinFOSA.Telephone := ObjNextOfKinApp.Telephone;
                                                ObjNextofKinFOSA.Email := ObjNextOfKinApp.Email;
                                                ObjNextofKinFOSA."ID No." := ObjNextOfKinApp."ID No.";
                                                ObjNextofKinFOSA."Member No" := ObjNextOfKinApp."Member No";
                                                ObjNextofKinFOSA."%Allocation" := ObjNextOfKinApp."%Allocation";
                                                ObjNextofKinFOSA."Next Of Kin Type" := ObjNextOfKinApp."Next Of Kin Type";
                                                ObjNextofKinFOSA.Insert;
                                            until ObjNextOfKinApp.Next = 0;
                                        end;

                                        //==================================================================================================Insert Account Agents
                                        ObjMemberAppAgent.Reset;
                                        ObjMemberAppAgent.SetRange(ObjMemberAppAgent."Account No", Rec."No.");
                                        if ObjMemberAppAgent.Find('-') then begin
                                            repeat
                                                if ObjNoSeries.Get then begin
                                                    ObjNoSeries.TestField(ObjNoSeries."Agent Serial Nos");
                                                    VarDocumentNo := NoSeriesMgt.GetNextNo(ObjNoSeries."Agent Serial Nos", 0D, true);
                                                    if VarDocumentNo <> '' then begin
                                                        ObjAccountAgents.Init;
                                                        ObjAccountAgents."Document No" := VarDocumentNo;
                                                        ObjAccountAgents."Account No" := VarAcctNo;
                                                        ObjAccountAgents.Names := ObjMemberAppAgent.Names;
                                                        ObjAccountAgents."Date Of Birth" := ObjMemberAppAgent."Date Of Birth";
                                                        ObjAccountAgents."Staff/Payroll" := ObjMemberAppAgent."Staff/Payroll";
                                                        ObjAccountAgents."ID No." := ObjMemberAppAgent."ID No.";
                                                        ObjAccountAgents."Allowed  Correspondence" := ObjMemberAppAgent."Allowed  Correspondence";
                                                        ObjAccountAgents."Allowed Balance Enquiry" := ObjMemberAppAgent."Allowed Balance Enquiry";
                                                        ObjAccountAgents."Allowed FOSA Withdrawals" := ObjMemberAppAgent."Allowed FOSA Withdrawals";
                                                        ObjAccountAgents."Allowed Loan Processing" := ObjMemberAppAgent."Allowed Loan Processing";
                                                        ObjAccountAgents."Must Sign" := ObjMemberAppAgent."Must Sign";
                                                        ObjAccountAgents."Must be Present" := ObjMemberAppAgent."Must be Present";
                                                        ObjAccountAgents."Expiry Date" := ObjMemberAppAgent."Expiry Date";
                                                        ObjAccountAgents.Insert;
                                                    end;
                                                end;
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
                                        //END;
                                        Message('You have successfully created a %1 Product, A/C No=%2', ObjProductsApp.Product, VarAcctNo);
                                    end;
                                //End Charge Registration Fee
                                until ObjProductsApp.Next = 0;
                            end;
                            Message('You have successfully Registered a New KUSCCO Investment Member. Membership No=%1.The Member will be notifed via SMS and/or Email.', CustomerTable."No.");

                            //=================================================================================================================End Member Accounts

                            if Rec."Member Payment Type" = Rec."member payment type"::"Standing Order" then
                                Message('Member Standing order No is %1', VarStandingNo);
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
                                //SFactory.FnSendSMS('MEMBERAPP', 'You Membership Registration has been completed. Your Member No is ' + VarBOSAACC + ' and your Accounts are: ' + VarAccounts,
                                //VarBOSAACC, Rec."Mobile Phone No");
                                SmsCodeunit.SendSmsWithID(Source::NEW_MEMBER, Rec."Mobile Phone No", 'Your membership registration has been completed. Your Member No. is ' + VarBOSAACC + ' and your FOSA Accounts are: ' + VarAccounts, VarBOSAACC, VarBOSAACC + '.', false, 200, false, 'CBS', CreateGuid(), 'CBS');

                            end;

                            //======================================================================================================Send Email
                            if ObjGenSetUp."Send Membership Reg Email" = true then begin
                                FnSendRegistrationEmail(Rec."No.", Rec."E-Mail (Personal)", Rec."ID No.", VarBOSAACC);
                            end;
                            Rec.Created := true;
                            Rec.CalcFields(Rec."Assigned No.");
                            FnRuninsertBOSAAccountNos(VarBOSAACC);//========================================================================Update Membership Account with BOSA Account Nos
                        end;
                    end;
                }


            }
        }
    }

    trigger OnAfterGetCurrRecord()
    var
    // WorkflowManagement: Codeunit "Workflow Management";
    // WorkflowEventHandling: Codeunit "Workflow Event Handling";
    begin
        UpdateControls();
        SetControlAppearance();
        EnableCreateMember := false;
        EnableUpdateKYC := false;
        // OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(RecordId);
        //CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(RecordId);
        EnabledApprovalWorkflowsExist := true;

        // if Rec."Membership Approval Status" = Rec."Membership Approval Status"::Approved then begin
        //     OpenApprovalEntriesExist := false;
        //     CanCancelApprovalForRecord := false;
        //     EnabledApprovalWorkflowsExist := false;
        // end;
        if (Rec."Membership Approval Status" = Rec."Membership Approval Status"::Approved) then
            EnableCreateMember := true;

        if Rec.Created = true then
            EnableCreateMember := false;

        if (Rec.Created = true) and (Rec."KYC Completed" = false) and (Rec."Online Application" = true) then
            EnableUpdateKYC := true;

        //ObjGenSetUp.Get;
        // Rec."Monthly Contribution" := ObjGenSetUp."Min. Contribution";
    end;

    trigger OnAfterGetRecord()
    begin

        StyleText := 'UnFavorable';


        if Rec."Identification Document" = Rec."identification document"::"Nation ID Card" then begin
            PassportEditable := false;
            IDNoEditable := true
        end else
            if Rec."Identification Document" = Rec."identification document"::"Passport Card" then begin
                PassportEditable := true;
                IDNoEditable := false
            end else
                if Rec."Identification Document" = Rec."identification document"::"Aliens Card" then begin
                    PassportEditable := true;
                    IDNoEditable := true;
                end;

        SetStyles();
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    var
        ObjAccountTypes: record "Account Types-Saving Products";
        ObjSelectProduct: record "Membership Reg. Products Appli";

    begin
        Rec."Responsibility Centre" := ObjUserMgt.GetSalesFilter;

        /* 
                        ObjAccountTypes.Reset;
                ObjAccountTypes.SetRange(ObjAccountTypes."Default Account", true);
                if ObjAccountTypes.FindSet then begin
                    repeat
                        ObjSelectProduct.Init;
                        ObjSelectProduct."Membership Applicaton No" :=Rec."No.";
                        ObjSelectProduct.Product := ObjAccountTypes.Code;
                        ObjSelectProduct."Product Name" := ObjAccountTypes.Description;
                        ObjSelectProduct."Product Source" := ObjAccountTypes."Activity Code";
                        ObjSelectProduct."Show On List" := ObjAccountTypes."Show On List";
                        ObjSelectProduct."Account Category":= ObjSelectProduct."Account Category"::Single;
                        ObjSelectProduct.Insert;
                    until ObjAccountTypes.Next = 0;
                end;   */
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    var
        UserMgt: Codeunit "User Management";
    begin
        ObjGenSetUp.Get();
        Rec."Monthly Contribution" := ObjGenSetUp."Monthly Share Contributions";
        Rec."Customer Posting Group" := ObjGenSetUp."Default Customer Posting Group";
        // "Global Dimension 1 Code" := 'BOSA';
        // "Global Dimension 2 Code" := 'NAIROBI';
        //"Self Recruited":=TRUE;





        /*IF "Account Category"<>"Account Category"::Joint THEN BEGIN
        Joint2DetailsVisible:=FALSE;
        Joint3DetailsVisible:=FALSE;
        END ELSE
        Joint2DetailsVisible:=TRUE;
        Joint3DetailsVisible:=TRUE;*/

    end;

    trigger OnOpenPage()
    begin

        if ObjUserMgt.GetSalesFilter <> '' then begin
            Rec.FilterGroup(2);
            Rec.SetRange(Rec."Responsibility Centre", ObjUserMgt.GetSalesFilter);
            Rec.FilterGroup(0);
        end;

        Joint2DetailsVisible := false;
        Joint3DetailsVisible := false;

        if Rec."Account Category" = Rec."account category"::Joint then begin
            Joint2DetailsVisible := true;
            Joint3DetailsVisible := true;
        end;
        if Rec."Account Category" = Rec."account category"::Individual then begin
            Joint2DetailsVisible := false;
            Joint3DetailsVisible := false;
        end;

        EmployedVisible := false;
        SelfEmployedVisible := false;
        RejoiningDetailsVisible := false;
        shocontract := false;
        Joint2DetailsVisible := false;
        ClassATierVisible := false;
        ClassBTierVisible := false;
        ClassCTierVisible := false;
        ClassDTierVisible := false;
        ClassFATierVisible := false;
        ClassFBTierVisible := false;
        ClassFCTierVisible := false;
        // OtherVisible := false;

        if Rec."Employment Info" = Rec."employment info"::Employed then begin
            EmployedVisible := true;
        end;

        if Rec."Employment Info" = Rec."employment info"::"Self-Employed" then begin
            SelfEmployedVisible := true;
        end;

        if Rec."New/Rejoining" = Rec."New/Rejoining"::Rejoining then begin
            RejoiningDetailsVisible := true;
        end;

        if Rec."Membership Class Tier" = Rec."Membership Class Tier"::"Class A" then begin
            ClassATierVisible := true;
        end;

        if Rec."Membership Class Tier" = Rec."Membership Class Tier"::"Class B" then begin
            ClassBTierVisible := true;
        end;

        if Rec."Membership Class Tier" = Rec."Membership Class Tier"::"Class C" then begin
            ClassCTierVisible := true;
        end;

        if Rec."Membership Class Tier" = Rec."Membership Class Tier"::"Class D" then begin
            ClassDTierVisible := true;
        end;

        if Rec."Membership Class Tier" = Rec."Membership Class Tier"::"Class FA" then begin
            ClassFATierVisible := true;
        end;

        if Rec."Membership Class Tier" = Rec."Membership Class Tier"::"Class FB" then begin
            ClassFBTierVisible := true;
        end;

        if Rec."Membership Class Tier" = Rec."Membership Class Tier"::"Class FC" then begin
            ClassFCTierVisible := true;
        end;

        if Rec."Employment Terms" = Rec."Employment Terms"::Contract then begin
            shocontract := true;
        end;

        if Rec."Account Category" = Rec."Account Category"::Joint then begin
            Joint2DetailsVisible := true;
        end;


        //if (Rec."Employment Info" = Rec."employment info"::Others) or (Rec."Employment Info" = Rec."employment info"::Contracting) then begin
        //     OtherVisible := true;
        // end;

        if Rec."Identification Document" = Rec."identification document"::"Nation ID Card" then begin
            PassportEditable := false;
            IDNoEditable := true
        end else
            if Rec."Identification Document" = Rec."identification document"::"Passport Card" then begin
                PassportEditable := true;
                IDNoEditable := false
            end else
                if Rec."Identification Document" = Rec."identification document"::"Aliens Card" then begin
                    PassportEditable := true;
                    IDNoEditable := true;
                end;
    end;

    var
        StatusPermissions: Record "Status Change Permision";
        ObjCust: Record "Members Register";
        ObjAccounts: Record Vendor;
        VarAcctNo: Code[20];
        ObjNextOfKinApp: Record "Member App Nominee";
        nokNo: Integer;
        ObjAccountSign: Record "FOSA Account Sign. Details";
        ObjAccountSignApp: Record "Member App Signatories";
        ObjAcc: Record Vendor;
        MembershipEditable: Boolean;
        UsersID: Record User;
        ObjNok: Record "Member App Nominee";
        ObjNOKBOSA: Record "Members Next of Kin";
        VarBOSAACC: Code[20];
        ObjNextOfKin: Record "Members Next of Kin";
        VarPictureExists: Boolean;
        text001: label 'Status must be open';
        ObjUserMgt: Codeunit "User Setup Management";
        ObjNotificationE: Codeunit Mail;
        VarMailBody: Text[250];
        VarccEmail: Text[1000];
        VartoEmail: Text[1000];
        ObjGenSetUp: Record "Sacco General Set-Up";
        VarClearingAcctNo: Code[20];
        VarAdvrAcctNo: Code[20];
        ObjAccountTypess: Record "Account Types-Saving Products";
        VarDivAcctNo: Code[20];
        NameEditable: Boolean;
        AddressEditable: Boolean;
        NoEditable: Boolean;
        DioceseEditable: Boolean;
        HomeAdressEditable: Boolean;
        GlobalDim1Editable: Boolean;
        GlobalDim2Editable: Boolean;
        CustPostingGroupEdit: Boolean;
        PhoneEditable: Boolean;
        shocontract: Boolean;

        MaritalstatusEditable: Boolean;
        IDNoEditable: Boolean;
        RegistrationDateEdit: Boolean;
        OfficeBranchEditable: Boolean;
        DeptEditable: Boolean;
        SectionEditable: Boolean;
        OccupationEditable: Boolean;
        DesignationEdiatble: Boolean;
        EmployerCodeEditable: Boolean;
        EmployerNameEditable: Boolean;
        DepartmentEditable: Boolean;
        TermsofEmploymentEditable: Boolean;
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
        AccountTypes: record "Account Types-Saving Products";
        BranchCodeEditable: Boolean;
        BankAccountNoEditable: Boolean;
        ProductEditable: Boolean;
        SecondaryMobileEditable: Boolean;
        AccountCategoryEditable: Boolean;
        OfficeTelephoneEditable: Boolean;
        OfficeExtensionEditable: Boolean;
        MemberParishEditable: Boolean;
        KnowDimkesEditable: Boolean;
        CountyEditable: Boolean;
        DistrictEditable: Boolean;
        LocationEditable: Boolean;
        SubLocationEditable: Boolean;
        EmploymentInfoEditable: Boolean;
        VillageResidence: Boolean;
        SignatureExists: Boolean;
        VarNewMembNo: Code[30];
        ObjSaccosetup: Record "Sacco No. Series";
        ObjNOkApp: Record "Member App Nominee";
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
        ObjDataSheet: Record "Data Sheet Main";
        ObjSMSMessage: Record "SMS Messages";
        iEntryNo: Integer;
        Cuat: Integer;
        EmployedEditable: Boolean;
        ContractingEditable: Boolean;
        OthersEditable: Boolean;
        Joint2DetailsVisible: Boolean;
        RejoiningDetailsVisible: Boolean;
        ObjProductsApp: Record "Membership Reg. Products Appli";
        ObjNextofKinFOSA: Record "FOSA Account NOK Details";
        ObjUsersRec: Record User;
        Joint3DetailsVisible: Boolean;
        CompInfo: Record "Company Information";
        LineNo: Integer;
        GenJournalLine: Record "Gen. Journal Line";
        FirstNameEditable: Boolean;
        MiddleNameEditable: Boolean;
        SmsCodeunit: CodeUnit "Sms Management";
        LastNameEditable: Boolean;
        PayrollNoEditable: Boolean;
        MemberResidenceEditable: Boolean;
        ShareClassEditable: Boolean;
        KRAPinEditable: Boolean;
        ObjViewLog: Record "View Log Entry";
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ","Purchase Requisition",RFQ,"Store Requisition","Payment Voucher",MembershipApplication,LoanApplication,LoanDisbursement,ProductApplication,StandingOrder,MembershipWithdrawal,ATMCard,GuarantorRecovery;
        WelcomeMessage: label '<p style="font-family:Verdana,Arial;font-size:10pt">Dear<b> %1,</b></p><p style="font-family:Verdana,Arial;font-size:9pt">Welcome to Kingdom Sacco</p><p style="font-family:Verdana,Arial;font-size:9pt">This is to confirm that your membership Application has been received and Undergoing Approval</p><p style="font-family:Verdana,Arial;font-size:9pt"> </b></p><br>Regards<p>%3</p><p><b>KINGDOM SACCO LTD</b></p>';
        RegistrationMessage: label '<p style="font-family:Verdana,Arial;font-size:10pt">Dear<b> %1,</b></p><p style="font-family:Verdana,Arial;font-size:9pt">Welcome to Kingdom Sacco</p><p style="font-family:Verdana,Arial;font-size:9pt">This is to confirm that your membership registration has been successfully processed</p><p style="font-family:Verdana,Arial;font-size:9pt">Your membership number is <b>%2</b></p><br>Regards<p>%3</p><p><b>KINGDOM SACCO LTD</b></p>';
        OpenApprovalEntriesExist: Boolean;
        EnabledApprovalWorkflowsExist: Boolean;
        // ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        CanCancelApprovalForRecord: Boolean;
        OpenApprovalEntriesExistForCurrUser: Boolean;
        canSendApproval: Boolean;
        canCreate: Boolean;
        EventFilter: Text;
        EnableCreateMember: Boolean;
        SFactory: Codeunit "Au Factory";
        NatureofBussEditable: Boolean;
        IndustryEditable: Boolean;
        BusinessNameEditable: Boolean;

        PhysicalBussLocationEditable: Boolean;
        YearOfCommenceEditable: Boolean;
        PositionHeldEditable: Boolean;
        EmploymentDateEditable: Boolean;
        EmployerAddressEditable: Boolean;
        EmailIndemnifiedEditable: Boolean;
        SendEStatementsEditable: Boolean;
        ObjAccountTypes: Record "Account Types-Saving Products";
        ObjAccountAppAgent: Record "Account Agents App Details";
        ObjAccountAgent: Record "Account Agent Details";
        ObjMemberAppAgent: Record "Member Agents App Details";
        ObjMemberAgent: Record "Member Agent Details";
        IdentificationDocTypeEditable: Boolean;
        PhysicalAddressEditable: Boolean;
        RefereeEditable: Boolean;
        MonthlyIncomeEditable: Boolean;
        ObjAccountAgents: Record "Account Agent Details";
        ObjMembers: Record "Members Register";
        ObjBOSAAccount: Record "BOSA Accounts No Buffer";
        StyleText: Text[20];
        CoveragePercentStyle: Text;
        ObjMemberNoseries: Record "Member Accounts No Series";
        VarAccountTypes: Text[1000];
        VarAccountDescription: Text[1000];
        ObjAccountType: Record "Account Types-Saving Products";
        VarMemberName: Text[100];
        SurestepFactory: Codeunit "Au Factory";
        VarEmailSubject: Text;
        VarEmailBody: Text;
        VarTextExtension: Text;
        VarTextExtensionII: Text;
        VarEnableNeedHouse: Boolean;
        EmployedVisible: Boolean;
        SelfEmployedVisible: Boolean;
        OtherVisible: Boolean;
        ObjNoSeries: Record "Sacco No. Series";
        Source: Option NEW_MEMBER,NEW_ACCOUNT,LOAN_ACCOUNT_APPROVAL,DEPOSIT_CONFIRMATION,CASH_WITHDRAWAL_CONFIRM,LOAN_APPLICATION,LOAN_APPRAISAL,LOAN_GUARANTORS,LOAN_REJECTED,LOAN_POSTED,LOAN_DEFAULTED,SALARY_PROCESSING,TELLER_CASH_DEPOSIT,TELLER_CASH_WITHDRAWAL,TELLER_CHEQUE_DEPOSIT,FIXED_DEPOSIT_MATURITY,INTERACCOUNT_TRANSFER,ACCOUNT_STATUS,STATUS_ORDER,EFT_EFFECTED,ATM_APPLICATION_FAILED,ATM_COLLECTION,MBANKING,MEMBER_CHANGES,CASHIER_BELOW_LIMIT,CASHIER_ABOVE_LIMIT,INTERNETBANKING,CRM,MOBILE_PIN;
        VarDocumentNo: Code[30];
        NoSeriesMgt: Codeunit "No. Series";
        VarProductCount: Integer;
        ObjMemberAppSignatories: Record "Member App Signatories";
        EnableUpdateKYC: Boolean;
        VarStandingNo: Code[20];
        WorkflowManagement: Codeunit WorkflowIntegration;
        CustomerTable: Record Customer;
        ClassATierVisible: Boolean;
        ClassBTierVisible: Boolean;
        ClassCTierVisible: Boolean;
        ClassDTierVisible: Boolean;
        ClassFATierVisible: Boolean;
        ClassFBTierVisible: Boolean;
        ClassFCTierVisible: Boolean;
        sacco: Record "Sacco General Set-Up";


    procedure UpdateControls()
    begin

        if (Rec."Membership Approval Status" = Rec."Membership Approval Status"::Approved) or ((Rec."Online Application" = true) and (Rec."KYC Completed" = true)) then begin
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
            ProductEditable := false;
            SecondaryMobileEditable := false;
            AccountCategoryEditable := false;
            OfficeTelephoneEditable := false;
            OfficeExtensionEditable := false;
            CountyEditable := false;
            DistrictEditable := false;
            LocationEditable := false;
            SubLocationEditable := false;
            EmploymentInfoEditable := false;
            MemberParishEditable := false;
            KnowDimkesEditable := false;
            EmployerCodeEditable := false;
            DepartmentEditable := false;
            TermsofEmploymentEditable := false;
            FirstNameEditable := false;
            MiddleNameEditable := false;
            LastNameEditable := false;
            PayrollNoEditable := false;
            MemberResidenceEditable := false;
            ShareClassEditable := false;
            KRAPinEditable := false;
            RecruitedByEditable := false;
            EmailIndemnifiedEditable := false;
            SendEStatementsEditable := false;

            NatureofBussEditable := false;
            IndustryEditable := false;
            BusinessNameEditable := false;
            PhysicalBussLocationEditable := false;
            YearOfCommenceEditable := false;
            PositionHeldEditable := false;
            EmploymentDateEditable := false;
            EmployerAddressEditable := false;
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
            ProductEditable := false;
            SecondaryMobileEditable := false;
            AccountCategoryEditable := false;
            OfficeTelephoneEditable := false;
            OfficeExtensionEditable := false;
            CountyEditable := false;
            DistrictEditable := false;
            LocationEditable := false;
            SubLocationEditable := false;
            EmploymentInfoEditable := false;
            MemberParishEditable := false;
            KnowDimkesEditable := false;
            EmployerCodeEditable := false;
            DepartmentEditable := false;
            TermsofEmploymentEditable := false;
            FirstNameEditable := false;
            MiddleNameEditable := false;
            LastNameEditable := false;
            PayrollNoEditable := false;
            MemberResidenceEditable := false;
            ShareClassEditable := false;
            KRAPinEditable := false;
            RecruitedByEditable := false;
            EmailIndemnifiedEditable := false;
            SendEStatementsEditable := false;
            NatureofBussEditable := false;
            IndustryEditable := false;
            BusinessNameEditable := false;
            PhysicalBussLocationEditable := false;
            YearOfCommenceEditable := false;
            PositionHeldEditable := false;
            EmploymentDateEditable := false;
            EmployerAddressEditable := false;
            EmailIndemnifiedEditable := false;
            SendEStatementsEditable := false;
            IdentificationDocTypeEditable := false;
            PhysicalAddressEditable := false;
            RefereeEditable := false;
            MonthlyIncomeEditable := false;
        end;


        if (Rec."Membership Approval Status" = Rec."Membership Approval Status"::Open) or ((Rec."Online Application" = true) and (Rec."KYC Completed" = false)) then begin
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
            ProductEditable := true;
            SecondaryMobileEditable := true;
            AccountCategoryEditable := true;
            OfficeTelephoneEditable := true;
            OfficeExtensionEditable := true;
            CountyEditable := true;
            DistrictEditable := true;
            LocationEditable := true;
            SubLocationEditable := true;
            EmploymentInfoEditable := true;
            MemberParishEditable := true;
            KnowDimkesEditable := true;
            EmployerCodeEditable := true;
            DepartmentEditable := true;
            TermsofEmploymentEditable := true;
            FirstNameEditable := true;
            MiddleNameEditable := true;
            LastNameEditable := true;
            PayrollNoEditable := true;
            MemberResidenceEditable := true;
            ShareClassEditable := true;
            KRAPinEditable := true;
            RecruitedByEditable := true;
            EmailIndemnifiedEditable := true;
            SendEStatementsEditable := true;
            NatureofBussEditable := true;
            IndustryEditable := true;
            BusinessNameEditable := true;
            PhysicalBussLocationEditable := true;
            YearOfCommenceEditable := true;
            PositionHeldEditable := true;
            EmploymentDateEditable := true;
            EmployerAddressEditable := true;
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

        ObjGenSetUp.Get;
        CompInfo.Get;



        //SMS MESSAGE
        ObjSMSMessage.Reset;
        if ObjSMSMessage.Find('+') then begin
            iEntryNo := ObjSMSMessage."Entry No";
            iEntryNo := iEntryNo + 1;
        end
        else begin
            iEntryNo := 1;
        end;


        ObjSMSMessage.Init;
        ObjSMSMessage."Entry No" := iEntryNo;
        ObjSMSMessage."Batch No" := Rec."No.";
        ObjSMSMessage."Document No" := '';
        ObjSMSMessage."Account No" := VarBOSAACC;
        ObjSMSMessage."Date Entered" := Today;
        ObjSMSMessage."Time Entered" := Time;
        ObjSMSMessage.Source := 'MEMBAPP';
        ObjSMSMessage."Entered By" := UserId;
        ObjSMSMessage."Sent To Server" := ObjSMSMessage."sent to server"::No;
        ObjSMSMessage."SMS Message" := 'Dear Member your application has been received and going through approval,'
        + ' ' + CompInfo.Name + ' ' + ObjGenSetUp."Customer Care No";
        ObjSMSMessage."Telephone No" := Rec."Mobile Phone No";
        if Rec."Mobile Phone No" <> '' then
            ObjSMSMessage.Insert;
    end;


    procedure FnSendRegistrationSMS()
    begin

        ObjGenSetUp.Get;
        CompInfo.Get;



        //SMS MESSAGE
        ObjSMSMessage.Reset;
        if ObjSMSMessage.Find('+') then begin
            iEntryNo := ObjSMSMessage."Entry No";
            iEntryNo := iEntryNo + 1;
        end
        else begin
            iEntryNo := 1;
        end;


        ObjSMSMessage.Init;
        ObjSMSMessage."Entry No" := iEntryNo;
        ObjSMSMessage."Batch No" := Rec."No.";
        ObjSMSMessage."Document No" := '';
        ObjSMSMessage."Account No" := VarBOSAACC;
        ObjSMSMessage."Date Entered" := Today;
        ObjSMSMessage."Time Entered" := Time;
        ObjSMSMessage.Source := 'MEMBREG';
        ObjSMSMessage."Entered By" := UserId;
        ObjSMSMessage."Sent To Server" := ObjSMSMessage."sent to server"::No;
        ObjSMSMessage."SMS Message" := 'Dear Member you have been registered successfully, your Membership No is '
        + VarBOSAACC + ' Name ' + Rec.Name + ' ' + CompInfo.Name + ' ' + ObjGenSetUp."Customer Care No";
        ObjSMSMessage."Telephone No" := Rec."Mobile Phone No";
        if Rec."Mobile Phone No" <> '' then
            ObjSMSMessage.Insert;
    end;

    local procedure UpdateViewLogEntries()
    begin
        ObjViewLog.Init;
        ObjViewLog."Entry No." := ObjViewLog."Entry No." + 1;
        ObjViewLog."User ID" := UserId;
        ObjViewLog."Table No." := 51516364;
        ObjViewLog."Table Caption" := 'Members Register';
        ObjViewLog.Date := Today;
        ObjViewLog.Time := Time;
    end;

    local procedure FnCheckfieldrestriction()
    begin
        if (Rec."Account Category" = Rec."account category"::Individual) then begin
            //CALCFIELDS(Picture,Signature);
            Rec.TestField(Name);
            Rec.TestField(Rec."ID No.");
            Rec.TestField(Rec."Mobile Phone No");
            if (Rec."Membership Class Tier" = Rec."Membership Class Tier"::"Class A") or (Rec."Membership Class Tier" = Rec."Membership Class Tier"::"Class B") or (Rec."Membership Class Tier" = Rec."Membership Class Tier"::"Class C") or (Rec."Membership Class Tier" = Rec."Membership Class Tier"::"Class D") then begin
                Rec.TestField(Rec."KRA PIN");
                Rec.TestField("E-Mail (Personal)");
            end;

            Rec.TestField(Rec."Customer Posting Group");
            //Rec.TestField(Rec."E-Mail (Personal)");
            if Rec."Monthly Contribution" = 0 then
                Error('Monthly contribution should have a value');
            if Rec."Account Category" = Rec."account category"::Individual then begin
                //TESTFIELD(Picture);
                //TESTFIELD(Signature);
            end;
        end else

            if (Rec."Account Category" = Rec."account category"::Corporate) or (Rec."Account Category" = Rec."account category"::Joint) then begin
                Rec.TestField(Name);
                Rec.TestField(Rec."Registration No");
                Rec.TestField(Rec."Copy of KRA Pin");
                Rec.TestField(Rec."Customer Posting Group");

            end;
        // if Rec."Employment Info" = Rec."Employment Info"::Employed then begin
        //     Rec.TestField(Rec."Employment Info");
        //     Rec.TestField(Rec."Employer Code");
        //     Rec.TestField(Rec."Employer Name");
        //Rec.TestField(Rec."Terms of Employment");
        // Rec.TestField(Rec."Employment Start Date");
        // Rec.TestField(Rec."Employment End Date");
        // Rec.TestField(Rec.Designation);
        //Rec.TestField(Rec.Workstation);


        // end;
    end;

    local procedure FnSendReceivedApplicationEmail(ApplicationNo: Code[20]; Email: Text[50]; IDNo: Code[20])
    var
        Memb: Record "Membership Applications";
        //  SMTPMail: Codeunit "SMTP Mail";
        //  SMTPSetup: Record "SMTP Mail Setup";
        FileName: Text[100];
        Attachment: Text[250];
        CompanyInfo: Record "Company Information";
        recipient: List of [Text];
    begin
        // SMTPSetup.Get();

        Memb.Reset;
        Memb.SetRange(Memb."No.", ApplicationNo);
        Memb.SetFilter(Memb."E-Mail (Personal)", '<>%1', '');
        if Memb.Find('-') then begin
            if Email = '' then begin
                Error('Email Address Missing for Member Application number' + '-' + Memb."No.");
            end;
            //     if Memb."E-Mail (Personal)" <> '' then
            //         recipient.Add(Email);
            //     SMTPMail.CreateMessage(SMTPSetup."Email Sender Name", SMTPSetup."Email Sender Address", recipient, 'Membership Application', '', true);
            //     SMTPMail.AppendBody(StrSubstNo(WelcomeMessage, Memb.Name, IDNo, UserId));
            //     SMTPMail.AppendBody(SMTPSetup."Email Sender Name");
            //     SMTPMail.AppendBody('<br><br>');
            //     SMTPMail.AddAttachment(FileName, Attachment);
            //SMTPMail.Send;
        end;




    end;

    local procedure FnSendRegistrationEmail(ApplicationNo: Code[20]; Email: Text[50]; IDNo: Code[20]; VarMemberNo: Code[30])
    var
        Memb: Record "Membership Applications";
        // SMTPMail: Codeunit "SMTP Mail";
        // SMTPSetup: Record "SMTP Mail Setup";
        FileName: Text[100];
        Attachment: Text[250];
        CompanyInfo: Record "Company Information";
    begin
        //SMTPSetup.Get();

        VarAccountDescription := '';
        VarAccountTypes := '<p><ul style="list-style-type:square">';

        ObjAccounts.Reset;
        ObjAccounts.SetRange(ObjAccounts."BOSA Account No", VarMemberNo);
        if ObjAccounts.FindSet then begin
            repeat

                if ObjAccountType.Get(ObjAccounts."Account Type") then begin
                    VarAccountDescription := ObjAccountType."Product Short Name";
                end;

                VarAccountTypes := VarAccountTypes + '<li>' + Format(ObjAccounts."No.") + ' - ' + Format(VarAccountDescription) + '</li>';
            until ObjAccounts.Next = 0;
        end;
        VarAccountTypes := VarAccountTypes + '</ul></p>';

        VarMemberName := SurestepFactory.FnConvertTexttoBeginingWordstostartWithCapital(Rec.Name);
        VarTextExtension := '<p>At Vision Sacco, we provide you with a variety of efficient and convenient services that enable you to:</p>' +
               '<p>1. Make Automated Deposit to your account through any Equity Bank Branch to our Account No. 15172262333007 and any Family Bank Branch via Utility Payment. You will provide your Kingdom Sacco 12-digit Account Number.</p>' +
               '<p>2. Make Automated Deposits through MPESA or Equitel/Equity Bank Agents using our Paybill No. 521000 and through Family Bank Agents using Bill Payment Code 020, then provide your Account Number and Amount.</p>' +
               '<p>3. Transact through our Mobile Banking Channels to Apply for Loans, MPESA Withdrawal, Account Transfers, Account Enquiries, Statement Requests etc. You can download Kingdom Sacco Mobile App on Google Play Store</p>';

        VarTextExtensionII := '<p>5. Access funds via Cardless ATM Withdrawal Service with Family Bank accessible to all our registered Mobile Banking Users. For guidelines send the word CARDLESS to 0705270662 or use our Mobile App.</p>' +
               '<p>6. Apply for a Cheque Book and initiate cheque payments from your account at Vision Sacco.</p>' +
               '<p>7. Process your salary to your Vision Sacco Account and benefit from very affordable salary loans.</p>' +
               '<p>8. Operate an Ufalme Account and save in order to acquire Land/Housing in our upcoming projects.</p>' +
               '<p>Visit our website <a href="http://www.visionsacco.com">www.visionsacco.com</a> for more information on our service offering.</p>' +
               '<p>Thank you for choosing Vision Sacco. Our objective is to empower you economically and socially by promoting a Savings and Investments culture and providing affordable credit.</p>';


        VarEmailSubject := 'WELCOME TO VISION SACCO';
        VarEmailBody := 'Welcome and Thank you for Joining Vision Sacco. Your Membership Number is ' + VarMemberNo + '. Your Account Numbers are: ' + VarAccountTypes + VarTextExtension + VarTextExtensionII;

        //  SurestepFactory.FnSendStatementViaMail(VarMemberName, VarEmailSubject, VarEmailBody, "E-Mail (Personal)", '', '');
    end;

    local procedure FnUpdateMemberSubAccounts()
    begin
        /*ObjSaccosetup.GET;
        
        //SHARE CAPITAL
        ObjProductsApp.RESET;
        ObjProductsApp.SETRANGE(ObjProductsApp."Membership Applicaton No","No.");
        ObjProductsApp.SETRANGE(ObjProductsApp."Product Source",ObjProductsApp."Product Source"::BOSA);
        ObjProductsApp.SETRANGE(ObjProductsApp.Product,'601');
        IF ObjProductsApp.FINDSET THEN BEGIN
          ObjMembers.RESET;
          ObjMembers.SETRANGE(ObjMembers."ID No.","ID No.");
          IF ObjMembers.FINDSET THEN BEGIN
            IF "Global Dimension 2 Code"='NAIROBI' THEN BEGIN
              ObjMembers."Share Capital No":=INCSTR(ObjSaccosetup."Share Capital Account No(HQ)");
                ObjSaccosetup."Share Capital Account No(HQ)":=ObjMembers."Share Capital No";
                ObjMembers.MODIFY;
                ObjSaccosetup.MODIFY;
        
                ObjVarBOSAACCount.INIT;
                ObjVarBOSAACCount."Account No":=ObjMembers."Share Capital No";
                ObjVarBOSAACCount."Transaction Type":=ObjVarBOSAACCount."Transaction Type"::"Share Capital";
                ObjVarBOSAACCount."Member No":=ObjMembers."No.";
                ObjVarBOSAACCount."Account Name":=ObjMembers.Name;
                ObjVarBOSAACCount."ID No":=ObjMembers."ID No.";
                ObjVarBOSAACCount."Account Type":='601';
                ObjVarBOSAACCount.INSERT;
              END;
        
              IF "Global Dimension 2 Code"='NAIVASHA' THEN BEGIN
              ObjMembers."Share Capital No":=INCSTR(ObjSaccosetup."Share Capital Account No(NAIV)");
                ObjSaccosetup."Share Capital Account No(NAIV)":=ObjMembers."Share Capital No";
                ObjMembers.MODIFY;
                ObjSaccosetup.MODIFY;
        
                ObjVarBOSAACCount.INIT;
                ObjVarBOSAACCount."Account No":=ObjMembers."Share Capital No";
                ObjVarBOSAACCount."Transaction Type":=ObjVarBOSAACCount."Transaction Type"::"Share Capital";
                ObjVarBOSAACCount."Member No":=ObjMembers."No.";
                ObjVarBOSAACCount."Account Name":=ObjMembers.Name;
                ObjVarBOSAACCount."ID No":=ObjMembers."ID No.";
                ObjVarBOSAACCount."Account Type":='601';
                ObjVarBOSAACCount.INSERT;
                END;
        
                IF "Global Dimension 2 Code"='NAKURU' THEN BEGIN
                ObjMembers."Share Capital No":=INCSTR(ObjSaccosetup."Share Capital Account No(NKR)");
                  ObjSaccosetup."Share Capital Account No(NKR)":=ObjMembers."Share Capital No";
                  ObjMembers.MODIFY;
                  ObjSaccosetup.MODIFY;
        
                  ObjVarBOSAACCount.INIT;
                  ObjVarBOSAACCount."Account No":=ObjMembers."Share Capital No";
                  ObjVarBOSAACCount."Transaction Type":=ObjVarBOSAACCount."Transaction Type"::"Share Capital";
                  ObjVarBOSAACCount."Member No":=ObjMembers."No.";
                  ObjVarBOSAACCount."Account Name":=ObjMembers.Name;
                  ObjVarBOSAACCount."ID No":=ObjMembers."ID No.";
                  ObjVarBOSAACCount."Account Type":='601';
                  ObjVarBOSAACCount.INSERT;
                  END;
        
                  IF "Global Dimension 2 Code"='ELDORET' THEN BEGIN
                  ObjMembers."Share Capital No":=INCSTR(ObjSaccosetup."Share Capital Account No(ELD)");
                    ObjSaccosetup."Share Capital Account No(ELD)":=ObjMembers."Share Capital No";
                    ObjMembers.MODIFY;
                    ObjSaccosetup.MODIFY;
        
                    ObjVarBOSAACCount.INIT;
                    ObjVarBOSAACCount."Account No":=ObjMembers."Share Capital No";
                    ObjVarBOSAACCount."Transaction Type":=ObjVarBOSAACCount."Transaction Type"::"Share Capital";
                    ObjVarBOSAACCount."Member No":=ObjMembers."No.";
                    ObjVarBOSAACCount."Account Name":=ObjMembers.Name;
                    ObjVarBOSAACCount."ID No":=ObjMembers."ID No.";
                    ObjVarBOSAACCount."Account Type":='601';
                    ObjVarBOSAACCount.INSERT;
                    END;
        
                    IF "Global Dimension 2 Code"='MOMBASA' THEN BEGIN
                    ObjMembers."Share Capital No":=INCSTR(ObjSaccosetup."Share Capital Account No(MSA)");
                      ObjSaccosetup."Share Capital Account No(MSA)":=ObjMembers."Share Capital No";
                      ObjMembers.MODIFY;
                      ObjSaccosetup.MODIFY;
        
                      ObjVarBOSAACCount.INIT;
                      ObjVarBOSAACCount."Account No":=ObjMembers."Share Capital No";
                      ObjVarBOSAACCount."Transaction Type":=ObjVarBOSAACCount."Transaction Type"::"Share Capital";
                      ObjVarBOSAACCount."Member No":=ObjMembers."No.";
                      ObjVarBOSAACCount."Account Name":=ObjMembers.Name;
                      ObjVarBOSAACCount."ID No":=ObjMembers."ID No.";
                      ObjVarBOSAACCount."Account Type":='601';
                      ObjVarBOSAACCount.INSERT;
                      END;
            END;
          END;
        //END SHARE CAPITAL
        
        //DEPOSITS CONTRIBUTION
        ObjProductsApp.RESET;
        ObjProductsApp.SETRANGE(ObjProductsApp."Membership Applicaton No","No.");
        ObjProductsApp.SETRANGE(ObjProductsApp."Product Source",ObjProductsApp."Product Source"::BOSA);
        ObjProductsApp.SETRANGE(ObjProductsApp.Product,'602');
        IF ObjProductsApp.FINDSET THEN BEGIN
          ObjMembers.RESET;
          ObjMembers.SETRANGE(ObjMembers."ID No.","ID No.");
          IF ObjMembers.FINDSET THEN BEGIN
            IF "Global Dimension 2 Code"='NAIROBI' THEN BEGIN
              ObjMembers."Deposits Account No":=INCSTR(ObjSaccosetup."Deposits Account No(HQ)");
                ObjSaccosetup."Deposits Account No(HQ)":=ObjMembers."Deposits Account No";
                ObjMembers.MODIFY;
                ObjSaccosetup.MODIFY;
        
                ObjVarBOSAACCount.INIT;
                ObjVarBOSAACCount."Account No":=ObjMembers."Deposits Account No";
                ObjVarBOSAACCount."Transaction Type":=ObjVarBOSAACCount."Transaction Type"::"Deposit Contribution";
                ObjVarBOSAACCount."Member No":=ObjMembers."No.";
                ObjVarBOSAACCount."Account Name":=ObjMembers.Name;
                ObjVarBOSAACCount."ID No":=ObjMembers."ID No.";
                ObjVarBOSAACCount."Account Type":='602';
                ObjVarBOSAACCount.INSERT;
              END;
        
              IF "Global Dimension 2 Code"='NAIVASHA' THEN BEGIN
              ObjMembers."Deposits Account No":=INCSTR(ObjSaccosetup."Deposits Account No(NAIV)");
                ObjSaccosetup."Deposits Account No(NAIV)":=ObjMembers."Deposits Account No";
                ObjMembers.MODIFY;
                ObjSaccosetup.MODIFY;
        
                ObjVarBOSAACCount.INIT;
                ObjVarBOSAACCount."Account No":=ObjMembers."Deposits Account No";
                ObjVarBOSAACCount."Transaction Type":=ObjVarBOSAACCount."Transaction Type"::"Deposit Contribution";
                ObjVarBOSAACCount."Member No":=ObjMembers."No.";
                ObjVarBOSAACCount."Account Name":=ObjMembers.Name;
                ObjVarBOSAACCount."ID No":=ObjMembers."ID No.";
                ObjVarBOSAACCount."Account Type":='602';
                ObjVarBOSAACCount.INSERT;
                END;
        
                IF "Global Dimension 2 Code"='NAKURU' THEN BEGIN
                ObjMembers."Deposits Account No":=INCSTR(ObjSaccosetup."Deposits Account No(NKR)");
                  ObjSaccosetup."Deposits Account No(NKR)":=ObjMembers."Deposits Account No";
                  ObjMembers.MODIFY;
                  ObjSaccosetup.MODIFY;
        
                  ObjVarBOSAACCount.INIT;
                  ObjVarBOSAACCount."Account No":=ObjMembers."Deposits Account No";
                  ObjVarBOSAACCount."Transaction Type":=ObjVarBOSAACCount."Transaction Type"::"Deposit Contribution";
                  ObjVarBOSAACCount."Member No":=ObjMembers."No.";
                  ObjVarBOSAACCount."Account Name":=ObjMembers.Name;
                  ObjVarBOSAACCount."ID No":=ObjMembers."ID No.";
                  ObjVarBOSAACCount."Account Type":='602';
                  ObjVarBOSAACCount.INSERT;
                  END;
                  IF "Global Dimension 2 Code"='ELDORET' THEN BEGIN
                  ObjMembers."Deposits Account No":=INCSTR(ObjSaccosetup."Deposits Account No(ELD)");
                    ObjSaccosetup."Deposits Account No(ELD)":=ObjMembers."Deposits Account No";
                    ObjMembers.MODIFY;
                     ObjSaccosetup.MODIFY;
        
                    ObjVarBOSAACCount.INIT;
                    ObjVarBOSAACCount."Account No":=ObjMembers."Deposits Account No";
                    ObjVarBOSAACCount."Transaction Type":=ObjVarBOSAACCount."Transaction Type"::"Deposit Contribution";
                    ObjVarBOSAACCount."Member No":=ObjMembers."No.";
                    ObjVarBOSAACCount."Account Name":=ObjMembers.Name;
                    ObjVarBOSAACCount."ID No":=ObjMembers."ID No.";
                    ObjVarBOSAACCount."Account Type":='602';
                    ObjVarBOSAACCount.INSERT;
                    END;
                    IF "Global Dimension 2 Code"='MOMBASA' THEN BEGIN
                    ObjMembers."Deposits Account No":=INCSTR(ObjSaccosetup."Deposits Account No(MSA)");
                      ObjSaccosetup."Deposits Account No(MSA)":=ObjMembers."Deposits Account No";
                      ObjMembers.MODIFY;
                      ObjSaccosetup.MODIFY;
        
                      ObjVarBOSAACCount.INIT;
                      ObjVarBOSAACCount."Account No":=ObjMembers."Deposits Account No";
                      ObjVarBOSAACCount."Transaction Type":=ObjVarBOSAACCount."Transaction Type"::"Deposit Contribution";
                      ObjVarBOSAACCount."Member No":=ObjMembers."No.";
                      ObjVarBOSAACCount."Account Name":=ObjMembers.Name;
                      ObjVarBOSAACCount."ID No":=ObjMembers."ID No.";
                      ObjVarBOSAACCount."Account Type":='602';
                      ObjVarBOSAACCount.INSERT;
                      END;
            END;
          END;
        
        //CORPORATE DEPOSITS CONTRIBUTION
        ObjProductsApp.RESET;
        ObjProductsApp.SETRANGE(ObjProductsApp."Membership Applicaton No","No.");
        ObjProductsApp.SETRANGE(ObjProductsApp."Product Source",ObjProductsApp."Product Source"::BOSA);
        ObjProductsApp.SETRANGE(ObjProductsApp.Product,'603');
        IF ObjProductsApp.FINDSET THEN BEGIN
          ObjMembers.RESET;
          ObjMembers.SETRANGE(ObjMembers."ID No.","ID No.");
          IF ObjMembers.FINDSET THEN BEGIN
            IF "Global Dimension 2 Code"='NAIROBI' THEN BEGIN
              ObjMembers."Deposits Account No":=INCSTR(ObjSaccosetup."Deposits Account No(HQ)");
                ObjSaccosetup."Deposits Account No(HQ)":=ObjMembers."Deposits Account No";
                ObjMembers.MODIFY;
                ObjSaccosetup.MODIFY;
        
                ObjVarBOSAACCount.INIT;
                ObjVarBOSAACCount."Account No":=ObjMembers."Deposits Account No";
                ObjVarBOSAACCount."Transaction Type":=ObjVarBOSAACCount."Transaction Type"::"Deposit Contribution";
                ObjVarBOSAACCount."Member No":=ObjMembers."No.";
                ObjVarBOSAACCount."Account Name":=ObjMembers.Name;
                ObjVarBOSAACCount."ID No":=ObjMembers."ID No.";
                ObjVarBOSAACCount."Account Type":='603';
                ObjVarBOSAACCount.INSERT;
              END;
        
              IF "Global Dimension 2 Code"='NAIVASHA' THEN BEGIN
              ObjMembers."Deposits Account No":=INCSTR(ObjSaccosetup."Deposits Account No(NAIV)");
                ObjSaccosetup."Deposits Account No(NAIV)":=ObjMembers."Deposits Account No";
                ObjMembers.MODIFY;
                ObjSaccosetup.MODIFY;
        
                ObjVarBOSAACCount.INIT;
                ObjVarBOSAACCount."Account No":=ObjMembers."Deposits Account No";
                ObjVarBOSAACCount."Transaction Type":=ObjVarBOSAACCount."Transaction Type"::"Deposit Contribution";
                ObjVarBOSAACCount."Member No":=ObjMembers."No.";
                ObjVarBOSAACCount."Account Name":=ObjMembers.Name;
                ObjVarBOSAACCount."ID No":=ObjMembers."ID No.";
                ObjVarBOSAACCount."Account Type":='603';
                ObjVarBOSAACCount.INSERT;
                END;
        
                IF "Global Dimension 2 Code"='NAKURU' THEN BEGIN
                ObjMembers."Deposits Account No":=INCSTR(ObjSaccosetup."Deposits Account No(NKR)");
                  ObjSaccosetup."Deposits Account No(NKR)":=ObjMembers."Deposits Account No";
                  ObjMembers.MODIFY;
                  ObjSaccosetup.MODIFY;
        
                  ObjVarBOSAACCount.INIT;
                  ObjVarBOSAACCount."Account No":=ObjMembers."Deposits Account No";
                  ObjVarBOSAACCount."Transaction Type":=ObjVarBOSAACCount."Transaction Type"::"Deposit Contribution";
                  ObjVarBOSAACCount."Member No":=ObjMembers."No.";
                  ObjVarBOSAACCount."Account Name":=ObjMembers.Name;
                  ObjVarBOSAACCount."ID No":=ObjMembers."ID No.";
                  ObjVarBOSAACCount."Account Type":='603';
                  ObjVarBOSAACCount.INSERT;
                  END;
                  IF "Global Dimension 2 Code"='ELDORET' THEN BEGIN
                  ObjMembers."Deposits Account No":=INCSTR(ObjSaccosetup."Deposits Account No(ELD)");
                    ObjSaccosetup."Deposits Account No(ELD)":=ObjMembers."Deposits Account No";
                    ObjMembers.MODIFY;
                     ObjSaccosetup.MODIFY;
        
                    ObjVarBOSAACCount.INIT;
                    ObjVarBOSAACCount."Account No":=ObjMembers."Deposits Account No";
                    ObjVarBOSAACCount."Transaction Type":=ObjVarBOSAACCount."Transaction Type"::"Deposit Contribution";
                    ObjVarBOSAACCount."Member No":=ObjMembers."No.";
                    ObjVarBOSAACCount."Account Name":=ObjMembers.Name;
                    ObjVarBOSAACCount."ID No":=ObjMembers."ID No.";
                    ObjVarBOSAACCount."Account Type":='603';
                    ObjVarBOSAACCount.INSERT;
                    END;
                    IF "Global Dimension 2 Code"='MOMBASA' THEN BEGIN
                    ObjMembers."Deposits Account No":=INCSTR(ObjSaccosetup."Deposits Account No(MSA)");
                      ObjSaccosetup."Deposits Account No(MSA)":=ObjMembers."Deposits Account No";
                      ObjMembers.MODIFY;
                      ObjSaccosetup.MODIFY;
        
                      ObjVarBOSAACCount.INIT;
                      ObjVarBOSAACCount."Account No":=ObjMembers."Deposits Account No";
                      ObjVarBOSAACCount."Transaction Type":=ObjVarBOSAACCount."Transaction Type"::"Deposit Contribution";
                      ObjVarBOSAACCount."Member No":=ObjMembers."No.";
                      ObjVarBOSAACCount."Account Name":=ObjMembers.Name;
                      ObjVarBOSAACCount."ID No":=ObjMembers."ID No.";
                      ObjVarBOSAACCount."Account Type":='603';
                      ObjVarBOSAACCount.INSERT;
                      END;
            END;
          END;
        
        //FOSA SHARES CONTRIBUTION
        ObjProductsApp.RESET;
        ObjProductsApp.SETRANGE(ObjProductsApp."Membership Applicaton No","No.");
        ObjProductsApp.SETRANGE(ObjProductsApp."Product Source",ObjProductsApp."Product Source"::BOSA);
        ObjProductsApp.SETRANGE(ObjProductsApp.Product,'605');
        IF ObjProductsApp.FINDSET THEN BEGIN
          ObjMembers.RESET;
          ObjMembers.SETRANGE(ObjMembers."ID No.","ID No.");
          IF ObjMembers.FINDSET THEN BEGIN
            IF "Global Dimension 2 Code"='NAIROBI' THEN BEGIN
              ObjMembers."Deposits Account No":=INCSTR(ObjSaccosetup."Deposits Account No(HQ)");
                ObjSaccosetup."Deposits Account No(HQ)":=ObjMembers."Deposits Account No";
                ObjMembers.MODIFY;
                ObjSaccosetup.MODIFY;
        
                ObjVarBOSAACCount.INIT;
                ObjVarBOSAACCount."Account No":=ObjMembers."Deposits Account No";
                ObjVarBOSAACCount."Transaction Type":=ObjVarBOSAACCount."Transaction Type"::"Deposit Contribution";
                ObjVarBOSAACCount."Member No":=ObjMembers."No.";
                ObjVarBOSAACCount."Account Name":=ObjMembers.Name;
                ObjVarBOSAACCount."ID No":=ObjMembers."ID No.";
                ObjVarBOSAACCount."Account Type":='605';
                ObjVarBOSAACCount.INSERT;
              END;
        
              IF "Global Dimension 2 Code"='NAIVASHA' THEN BEGIN
              ObjMembers."Deposits Account No":=INCSTR(ObjSaccosetup."Deposits Account No(NAIV)");
                ObjSaccosetup."Deposits Account No(NAIV)":=ObjMembers."Deposits Account No";
                ObjMembers.MODIFY;
                ObjSaccosetup.MODIFY;
        
                ObjVarBOSAACCount.INIT;
                ObjVarBOSAACCount."Account No":=ObjMembers."Deposits Account No";
                ObjVarBOSAACCount."Transaction Type":=ObjVarBOSAACCount."Transaction Type"::"Deposit Contribution";
                ObjVarBOSAACCount."Member No":=ObjMembers."No.";
                ObjVarBOSAACCount."Account Name":=ObjMembers.Name;
                ObjVarBOSAACCount."ID No":=ObjMembers."ID No.";
                ObjVarBOSAACCount."Account Type":='605';
                ObjVarBOSAACCount.INSERT;
                END;
        
                IF "Global Dimension 2 Code"='NAKURU' THEN BEGIN
                ObjMembers."Deposits Account No":=INCSTR(ObjSaccosetup."Deposits Account No(NKR)");
                  ObjSaccosetup."Deposits Account No(NKR)":=ObjMembers."Deposits Account No";
                  ObjMembers.MODIFY;
                  ObjSaccosetup.MODIFY;
        
                  ObjVarBOSAACCount.INIT;
                  ObjVarBOSAACCount."Account No":=ObjMembers."Deposits Account No";
                  ObjVarBOSAACCount."Transaction Type":=ObjVarBOSAACCount."Transaction Type"::"Deposit Contribution";
                  ObjVarBOSAACCount."Member No":=ObjMembers."No.";
                  ObjVarBOSAACCount."Account Name":=ObjMembers.Name;
                  ObjVarBOSAACCount."ID No":=ObjMembers."ID No.";
                  ObjVarBOSAACCount."Account Type":='605';
                  ObjVarBOSAACCount.INSERT;
                  END;
                  IF "Global Dimension 2 Code"='ELDORET' THEN BEGIN
                  ObjMembers."Deposits Account No":=INCSTR(ObjSaccosetup."Deposits Account No(ELD)");
                    ObjSaccosetup."Deposits Account No(ELD)":=ObjMembers."Deposits Account No";
                    ObjMembers.MODIFY;
                     ObjSaccosetup.MODIFY;
        
                    ObjVarBOSAACCount.INIT;
                    ObjVarBOSAACCount."Account No":=ObjMembers."Deposits Account No";
                    ObjVarBOSAACCount."Transaction Type":=ObjVarBOSAACCount."Transaction Type"::"Deposit Contribution";
                    ObjVarBOSAACCount."Member No":=ObjMembers."No.";
                    ObjVarBOSAACCount."Account Name":=ObjMembers.Name;
                    ObjVarBOSAACCount."ID No":=ObjMembers."ID No.";
                    ObjVarBOSAACCount."Account Type":='605';
                    ObjVarBOSAACCount.INSERT;
                    END;
                    IF "Global Dimension 2 Code"='MOMBASA' THEN BEGIN
                    ObjMembers."Deposits Account No":=INCSTR(ObjSaccosetup."Deposits Account No(MSA)");
                      ObjSaccosetup."Deposits Account No(MSA)":=ObjMembers."Deposits Account No";
                      ObjMembers.MODIFY;
                      ObjSaccosetup.MODIFY;
        
                      ObjVarBOSAACCount.INIT;
                      ObjVarBOSAACCount."Account No":=ObjMembers."Deposits Account No";
                      ObjVarBOSAACCount."Transaction Type":=ObjVarBOSAACCount."Transaction Type"::"Deposit Contribution";
                      ObjVarBOSAACCount."Member No":=ObjMembers."No.";
                      ObjVarBOSAACCount."Account Name":=ObjMembers.Name;
                      ObjVarBOSAACCount."ID No":=ObjMembers."ID No.";
                      ObjVarBOSAACCount."Account Type":='605';
                      ObjVarBOSAACCount.INSERT;
                      END;
            END;
          END;
        
        //FOSA SHARES CONTRIBUTION
        ObjProductsApp.RESET;
        ObjProductsApp.SETRANGE(ObjProductsApp."Membership Applicaton No","No.");
        ObjProductsApp.SETRANGE(ObjProductsApp."Product Source",ObjProductsApp."Product Source"::BOSA);
        ObjProductsApp.SETRANGE(ObjProductsApp.Product,'607');
        IF ObjProductsApp.FINDSET THEN BEGIN
          ObjMembers.RESET;
          ObjMembers.SETRANGE(ObjMembers."ID No.","ID No.");
          IF ObjMembers.FINDSET THEN BEGIN
            IF "Global Dimension 2 Code"='NAIROBI' THEN BEGIN
              ObjMembers."Deposits Account No":=INCSTR(ObjSaccosetup."Deposits Account No(HQ)");
                ObjSaccosetup."Deposits Account No(HQ)":=ObjMembers."Deposits Account No";
                ObjMembers.MODIFY;
                ObjSaccosetup.MODIFY;
        
                ObjVarBOSAACCount.INIT;
                ObjVarBOSAACCount."Account No":=ObjMembers."Deposits Account No";
                ObjVarBOSAACCount."Transaction Type":=ObjVarBOSAACCount."Transaction Type"::"Deposit Contribution";
                ObjVarBOSAACCount."Member No":=ObjMembers."No.";
                ObjVarBOSAACCount."Account Name":=ObjMembers.Name;
                ObjVarBOSAACCount."ID No":=ObjMembers."ID No.";
                ObjVarBOSAACCount."Account Type":='607';
                ObjVarBOSAACCount.INSERT;
              END;
        
              IF "Global Dimension 2 Code"='NAIVASHA' THEN BEGIN
              ObjMembers."Deposits Account No":=INCSTR(ObjSaccosetup."Deposits Account No(NAIV)");
                ObjSaccosetup."Deposits Account No(NAIV)":=ObjMembers."Deposits Account No";
                ObjMembers.MODIFY;
                ObjSaccosetup.MODIFY;
        
                ObjVarBOSAACCount.INIT;
                ObjVarBOSAACCount."Account No":=ObjMembers."Deposits Account No";
                ObjVarBOSAACCount."Transaction Type":=ObjVarBOSAACCount."Transaction Type"::"Deposit Contribution";
                ObjVarBOSAACCount."Member No":=ObjMembers."No.";
                ObjVarBOSAACCount."Account Name":=ObjMembers.Name;
                ObjVarBOSAACCount."ID No":=ObjMembers."ID No.";
                ObjVarBOSAACCount."Account Type":='607';
                ObjVarBOSAACCount.INSERT;
                END;
        
                IF "Global Dimension 2 Code"='NAKURU' THEN BEGIN
                ObjMembers."Deposits Account No":=INCSTR(ObjSaccosetup."Deposits Account No(NKR)");
                  ObjSaccosetup."Deposits Account No(NKR)":=ObjMembers."Deposits Account No";
                  ObjMembers.MODIFY;
                  ObjSaccosetup.MODIFY;
        
                  ObjVarBOSAACCount.INIT;
                  ObjVarBOSAACCount."Account No":=ObjMembers."Deposits Account No";
                  ObjVarBOSAACCount."Transaction Type":=ObjVarBOSAACCount."Transaction Type"::"Deposit Contribution";
                  ObjVarBOSAACCount."Member No":=ObjMembers."No.";
                  ObjVarBOSAACCount."Account Name":=ObjMembers.Name;
                  ObjVarBOSAACCount."ID No":=ObjMembers."ID No.";
                  ObjVarBOSAACCount."Account Type":='607';
                  ObjVarBOSAACCount.INSERT;
                  END;
                  IF "Global Dimension 2 Code"='ELDORET' THEN BEGIN
                  ObjMembers."Deposits Account No":=INCSTR(ObjSaccosetup."Deposits Account No(ELD)");
                    ObjSaccosetup."Deposits Account No(ELD)":=ObjMembers."Deposits Account No";
                    ObjMembers.MODIFY;
                     ObjSaccosetup.MODIFY;
        
                    ObjVarBOSAACCount.INIT;
                    ObjVarBOSAACCount."Account No":=ObjMembers."Deposits Account No";
                    ObjVarBOSAACCount."Transaction Type":=ObjVarBOSAACCount."Transaction Type"::"Deposit Contribution";
                    ObjVarBOSAACCount."Member No":=ObjMembers."No.";
                    ObjVarBOSAACCount."Account Name":=ObjMembers.Name;
                    ObjVarBOSAACCount."ID No":=ObjMembers."ID No.";
                    ObjVarBOSAACCount."Account Type":='607';
                    ObjVarBOSAACCount.INSERT;
                    END;
                    IF "Global Dimension 2 Code"='MOMBASA' THEN BEGIN
                    ObjMembers."Deposits Account No":=INCSTR(ObjSaccosetup."Deposits Account No(MSA)");
                      ObjSaccosetup."Deposits Account No(MSA)":=ObjMembers."Deposits Account No";
                      ObjMembers.MODIFY;
                      ObjSaccosetup.MODIFY;
        
                      ObjVarBOSAACCount.INIT;
                      ObjVarBOSAACCount."Account No":=ObjMembers."Deposits Account No";
                      ObjVarBOSAACCount."Transaction Type":=ObjVarBOSAACCount."Transaction Type"::"Deposit Contribution";
                      ObjVarBOSAACCount."Member No":=ObjMembers."No.";
                      ObjVarBOSAACCount."Account Name":=ObjMembers.Name;
                      ObjVarBOSAACCount."ID No":=ObjMembers."ID No.";
                      ObjVarBOSAACCount."Account Type":='607';
                      ObjVarBOSAACCount.INSERT;
                      END;
            END;
          END;
        
        //BENEVOLENT FUND
        
        ObjProductsApp.RESET;
        ObjProductsApp.SETRANGE(ObjProductsApp."Membership Applicaton No","No.");
        ObjProductsApp.SETRANGE(ObjProductsApp."Product Source",ObjProductsApp."Product Source"::BOSA);
        ObjProductsApp.SETRANGE(ObjProductsApp.Product,'606');
        IF ObjProductsApp.FINDSET THEN BEGIN
          ObjMembers.RESET;
          ObjMembers.SETRANGE(ObjMembers."ID No.","ID No.");
          IF ObjMembers.FINDSET THEN BEGIN
            IF "Global Dimension 2 Code"='NAIROBI' THEN BEGIN
              ObjMembers."Benevolent Fund No":=INCSTR(ObjSaccosetup."BenFund Account No(HQ)");
                ObjSaccosetup."BenFund Account No(HQ)":=ObjMembers."Benevolent Fund No";
                ObjMembers.MODIFY;
                ObjSaccosetup.MODIFY;
        
                ObjVarBOSAACCount.INIT;
                ObjVarBOSAACCount."Account No":=ObjMembers."Benevolent Fund No";
                ObjVarBOSAACCount."Transaction Type":=ObjVarBOSAACCount."Transaction Type"::"Benevolent Fund";
                ObjVarBOSAACCount."Member No":=ObjMembers."No.";
                ObjVarBOSAACCount."Account Name":=ObjMembers.Name;
                ObjVarBOSAACCount."ID No":=ObjMembers."ID No.";
                ObjVarBOSAACCount."Account Type":='606';
                ObjVarBOSAACCount.INSERT;
        
              END;
              IF "Global Dimension 2 Code"='NAIVASHA' THEN BEGIN
              ObjMembers."Benevolent Fund No":=INCSTR(ObjSaccosetup."BenFund Account No(NAIV)");
                ObjSaccosetup."BenFund Account No(NAIV)":=ObjMembers."Benevolent Fund No";
                ObjMembers.MODIFY;
                ObjSaccosetup.MODIFY;
        
                ObjVarBOSAACCount.INIT;
                ObjVarBOSAACCount."Account No":=ObjMembers."Benevolent Fund No";
                ObjVarBOSAACCount."Transaction Type":=ObjVarBOSAACCount."Transaction Type"::"Benevolent Fund";
                ObjVarBOSAACCount."Member No":=ObjMembers."No.";
                ObjVarBOSAACCount."Account Name":=ObjMembers.Name;
                ObjVarBOSAACCount."ID No":=ObjMembers."ID No.";
                ObjVarBOSAACCount."Account Type":='606';
                ObjVarBOSAACCount.INSERT;
                END;
        
                IF "Global Dimension 2 Code"='NAKURU' THEN BEGIN
                ObjMembers."Benevolent Fund No":=INCSTR(ObjSaccosetup."BenFund Account No(NKR)");
                  ObjSaccosetup."BenFund Account No(NKR)":=ObjMembers."Benevolent Fund No";
                  ObjMembers.MODIFY;
                  ObjSaccosetup.MODIFY;
        
                  ObjVarBOSAACCount.INIT;
                  ObjVarBOSAACCount."Account No":=ObjMembers."Benevolent Fund No";
                  ObjVarBOSAACCount."Transaction Type":=ObjVarBOSAACCount."Transaction Type"::"Benevolent Fund";
                  ObjVarBOSAACCount."Member No":=ObjMembers."No.";
                  ObjVarBOSAACCount."Account Name":=ObjMembers.Name;
                  ObjVarBOSAACCount."ID No":=ObjMembers."ID No.";
                  ObjVarBOSAACCount."Account Type":='606';
                  ObjVarBOSAACCount.INSERT;
                  END;
        
                  IF "Global Dimension 2 Code"='ELDORET' THEN BEGIN
                  ObjMembers."Benevolent Fund No":=INCSTR(ObjSaccosetup."BenFund Account No(ELD)");
                    ObjSaccosetup."BenFund Account No(ELD)":=ObjMembers."Benevolent Fund No";
                    ObjMembers.MODIFY;
                    ObjSaccosetup.MODIFY;
        
        
                    ObjVarBOSAACCount.INIT;
                    ObjVarBOSAACCount."Account No":=ObjMembers."Benevolent Fund No";
                    ObjVarBOSAACCount."Transaction Type":=ObjVarBOSAACCount."Transaction Type"::"Benevolent Fund";
                    ObjVarBOSAACCount."Member No":=ObjMembers."No.";
                    ObjVarBOSAACCount."Account Name":=ObjMembers.Name;
                    ObjVarBOSAACCount."ID No":=ObjMembers."ID No.";
                    ObjVarBOSAACCount."Account Type":='606';
                    ObjVarBOSAACCount.INSERT;
                    END;
        
                    IF "Global Dimension 2 Code"='MOMBASA' THEN BEGIN
                    ObjMembers."Benevolent Fund No":=INCSTR(ObjSaccosetup."BenFund Account No(MSA)");
                      ObjSaccosetup."BenFund Account No(MSA)":=ObjMembers."Benevolent Fund No";
                      ObjMembers.MODIFY;
                      ObjSaccosetup.MODIFY;
        
                      ObjVarBOSAACCount.INIT;
                      ObjVarBOSAACCount."Account No":=ObjMembers."Benevolent Fund No";
                      ObjVarBOSAACCount."Transaction Type":=ObjVarBOSAACCount."Transaction Type"::"Benevolent Fund";
                      ObjVarBOSAACCount."Member No":=ObjMembers."No.";
                      ObjVarBOSAACCount."Account Name":=ObjMembers.Name;
                      ObjVarBOSAACCount."ID No":=ObjMembers."ID No.";
                      ObjVarBOSAACCount."Account Type":='606';
                      ObjVarBOSAACCount.INSERT;
                      END;
            END;
          END;
          */

    end;

    local procedure SetStyles()
    begin
        CoveragePercentStyle := 'Strong';
        if Rec."Member Risk Level" <> Rec."member risk level"::"Low Risk" then
            CoveragePercentStyle := 'Unfavorable';
        if Rec."Member Risk Level" = Rec."member risk level"::"Low Risk" then
            CoveragePercentStyle := 'Favorable';
    end;

    local procedure FnRuninsertBOSAAccountNos(VarMemberNo: Code[30])
    begin

        ObjAccounts.RESET;
        ObjAccounts.SETRANGE(ObjAccounts."BOSA Account No", VarMemberNo);
        ObjAccounts.SETRANGE(ObjAccounts."Account Type", '002');
        ObjAccounts.SETRANGE(ObjAccounts.Status, ObjAccounts.Status::Active);
        IF ObjAccounts.FINDSET THEN BEGIN
            IF CustomerTable.GET(VarMemberNo) THEN BEGIN
                CustomerTable."Share Capital No" := ObjAccounts."No.";
                CustomerTable.MODIFY;
            END;
        END;

        ObjAccounts.RESET;
        ObjAccounts.SETRANGE(ObjAccounts."BOSA Account No", VarMemberNo);
        ObjAccounts.SETFILTER(ObjAccounts."Account Type", '=%1', '003');
        ObjAccounts.SETRANGE(ObjAccounts.Status, ObjAccounts.Status::Active);
        IF ObjAccounts.FINDSET THEN BEGIN
            IF CustomerTable.GET(VarMemberNo) THEN BEGIN
                CustomerTable."Deposits Account No" := ObjAccounts."No.";
                CustomerTable.MODIFY;
            END;
        END;

        ObjAccounts.RESET;
        ObjAccounts.SETRANGE(ObjAccounts."BOSA Account No", VarMemberNo);
        ObjAccounts.SETFILTER(ObjAccounts."Account Type", '=%1', 'ESS');
        ObjAccounts.SETRANGE(ObjAccounts.Status, ObjAccounts.Status::Active);
        IF ObjAccounts.FINDSET THEN BEGIN
            IF CustomerTable.GET(VarMemberNo) THEN BEGIN
                CustomerTable."School Fees Shares Account" := ObjAccounts."No.";
                CustomerTable.MODIFY;
            END;
        END;


    end;

    local procedure FnRunAMLDueDiligenceCheck()
    begin
        Rec.TestField(Rec."Individual Category");
        Rec.TestField(Rec."Member Residency Status");
        Rec.TestField(Rec."Industry Type");
        Rec.TestField(Rec."Length Of Relationship");
        Rec.TestField(Rec."International Trade");
        Rec.TestField(Rec."Electronic Payment");
        Rec.TestField(Rec."Accounts Type Taken");
        Rec.TestField(Rec."Cards Type Taken");
        Rec.TestField(Rec."Others(Channels)");
    end;

    local procedure FnRunCheckDueDiligenceMeasureGeneration()
    var
        ObjDueDiligenceMeasures: Record "Member Due Diligence Measures";
    begin
        ObjDueDiligenceMeasures.Reset;
        ObjDueDiligenceMeasures.SetRange(ObjDueDiligenceMeasures."Member No", Rec."No.");
        if not ObjDueDiligenceMeasures.Find('-') then begin
            Error('Kindly Generate Due Diligence Measures for this Application before Proceeding');
        end;
    end;

    local procedure FnRunEnsureDueDiligenceMeasureChecked()
    var
        ObjDueDiligenceMeasures: Record "Member Due Diligence Measures";
    begin
        ObjDueDiligenceMeasures.Reset;
        ObjDueDiligenceMeasures.SetRange(ObjDueDiligenceMeasures."Member No", Rec."No.");
        ObjDueDiligenceMeasures.SetRange(ObjDueDiligenceMeasures."Due Diligence Done", false);
        if ObjDueDiligenceMeasures.FindSet then begin
            Error('Kindly Ensure All Due Diligence Measures for this Application has been Checked before Creating the Account');
        end;
    end;

    local procedure FnSendKYCUpdateEmail(ApplicationNo: Code[20]; Email: Text[50]; IDNo: Code[20]; VarMemberNo: Code[30])
    var
        Memb: Record "Membership Applications";
        // SMTPMail: Codeunit "SMTP Mail";
        // SMTPSetup: Record "SMTP Mail Setup";
        FileName: Text[100];
        Attachment: Text[250];
        CompanyInfo: Record "Company Information";
    begin
        //SMTPSetup.Get();

        VarAccountDescription := '';
        VarAccountTypes := '<p><ul style="list-style-type:square">';

        ObjAccounts.Reset;
        ObjAccounts.SetRange(ObjAccounts."BOSA Account No", VarMemberNo);
        if ObjAccounts.FindSet then begin
            repeat

                if ObjAccountType.Get(ObjAccounts."Account Type") then begin
                    VarAccountDescription := ObjAccountType."Product Short Name";
                end;

                VarAccountTypes := VarAccountTypes + '<li>' + Format(ObjAccounts."No.") + ' - ' + Format(VarAccountDescription) + '</li>';
            until ObjAccounts.Next = 0;
        end;
        VarAccountTypes := VarAccountTypes + '</ul></p>';

        VarMemberName := SurestepFactory.FnConvertTexttoBeginingWordstostartWithCapital(Rec.Name);
        VarTextExtension := '<p>At Demo Sacco, we provide you with a variety of efficient and convenient services that enable you to:</p>' +
               '<p>1. Make Automated Deposit to your account through any Equity Bank Branch to our Account No. 15172262333007 and any Family Bank Branch via Utility Payment. You will provide your Demo Sacco 12-digit Account Number.</p>' +
               '<p>2. Make Automated Deposits through MPESA or Equitel/Equity Bank Agents using our Paybill No. 521000 and through Family Bank Agents using Bill Payment Code 020, then provide your Account Number and Amount.</p>' +
               '<p>3. Transact through our Mobile Banking Channels to Apply for Loans, MPESA Withdrawal, Account Transfers, Account Enquiries, Statement Requests etc. You can download Demo Sacco Mobile App on Google Play Store</p>';

        VarTextExtensionII := '<p>5. Access funds via Cardless ATM Withdrawal Service with Family Bank accessible to all our registered Mobile Banking Users. For guidelines send the word CARDLESS to 0705270662 or use our Mobile App.</p>' +
               '<p>6. Apply for a Cheque Book and initiate cheque payments from your account at Demo Sacco.</p>' +
               '<p>7. Process your salary to your Demo Sacco Account and benefit from very affordable salary loans.</p>' +
               '<p>8. Operate an Ufalme Account and save in order to acquire Land/Housing in our upcoming projects.</p>' +
               '<p>Visit our website <a href="http://www.Demosacco.com">www.Demosacco.com</a> for more information on our service offering.</p>' +
               '<p>Thank you for choosing Demo Sacco. Our objective is to empower you economically and socially by promoting a Savings and Investments culture and providing affordable credit.</p>';


        VarEmailSubject := 'MEMBERSHIP KYC DETAILS UPDATED - ' + VarMemberNo;
        VarEmailBody := '<p>Your Membership KYC Details have successfully been updated. You can now transact on your Accounts without any limits.</p>' +
              '<p>Your Membership Number is ' + VarMemberNo + '. Your Account Numbers are: ' + VarAccountTypes + '</p>' + VarTextExtension + VarTextExtensionII;

        //SurestepFactory.FnSendStatementViaMail(VarMemberName, VarEmailSubject, VarEmailBody, "E-Mail (Personal)", '', '');
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






