//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51068 "FOSA Product Application View"
{
    ApplicationArea = All;
    Caption = 'Account Applications';
    PageType = Card;
    PromotedActionCategories = 'New,Process,Reports,Approval,Budgetary Control,Cancellation,Category7_caption,Category8_caption,Category9_caption,Category10_caption';
    RefreshOnActivate = true;
    Editable = false;
    DeleteAllowed = false;
    SourceTable = "FOSA Account Applicat. Details";

    layout
    {
        area(content)
        {
            group("General Info")
            {
                Caption = 'General Info';
                field("No."; Rec."No.")
                {
                    Caption = 'Application No';
                    Editable = false;
                }
                field("BOSA Account No"; Rec."BOSA Account No")
                {
                    Caption = 'Member No.';
                    ShowMandatory = true;
                }
                field("Staff No"; Rec."Staff No")
                {
                    Caption = 'Payroll No';

                }
                field("Account Type"; Rec."Account Type")
                {
                    ShowMandatory = TRUE;
                    //Editable = AccountTypeEditable;

                    trigger OnValidate()
                    begin
                        FixedAccVisible := false;
                        ChildrenAccVisible := false;
                        JipangeAccVisible := false;
                        BusinessAccountVisible := false;


                        if Rec."Account Type" = '101' then begin
                            JipangeAccVisible := true;
                        end;
                        if Rec."Account Type" = '102' then begin
                            JipangeAccVisible := true;
                        end;
                        if Rec."Account Type" = '103' then begin
                            JipangeAccVisible := true;
                        end;

                        if Rec."Account Type" = '104' then begin
                            ESSVisible := true;
                        end;
                        if Rec."Account Type" = '105' then begin
                            chamaaVisible := true;
                        end;
                        if Rec."Account Type" = '106' then begin
                            jibambeVisible := true;
                        end;
                        if Rec."Account Type" = '107' then begin
                            wezeshaVisible := true;
                        end;
                        if Rec."Account Type" = '108' then begin
                            FixedAccVisible := true;
                        end;
                        if Rec."Account Type" = '109' then begin
                            ChildrenAccVisible := true;
                        end;
                        if Rec."Account Type" = '110' then begin
                            pensionVisible := true;
                        end;

                        if Rec."Account Type" = '111' then begin
                            BusinessAccountVisible := true;
                        end;

                    end;
                }
                field(MemberName; Rec.Name)
                {
                    Editable = false;
                    caption = 'Member Name';

                    trigger OnValidate()
                    begin
                        Rec.Name := UpperCase(Rec.Name);
                    end;
                }
                field("MemberID No."; Rec."ID No.")
                {
                    Editable = false;
                    Caption = 'Member ID No.';

                    trigger OnValidate()
                    begin
                        Acc.Reset;
                        Acc.SetRange(Acc."ID No.", Rec."ID No.");
                        Acc.SetRange(Acc."Account Type", Rec."Account Type");
                        Acc.SetRange(Acc.Status, Acc.Status::Active);
                        if Acc.Find('-') then
                            Error('Account already created.');
                    end;
                }
                field("MemberMobile Phone No"; Rec."Mobile Phone No")
                {
                    Editable = false;
                    Caption = 'Member Mobile Phone No.';

                    trigger OnValidate()
                    begin
                        Rec."Mobile Phone No" := UpperCase(Rec."Mobile Phone No");
                    end;
                }
                field("KRA No."; Rec."KRA No.")
                {
                    Caption = 'Member KRA No.';
                    Editable = false;
                }

                field("E-Mail"; Rec."E-Mail")
                {
                    Editable = false;

                    trigger OnValidate()
                    begin
                        Rec."E-Mail" := UpperCase(Rec."E-Mail");
                    end;
                }
                field("Account Balnce."; Rec."Account Balance")
                {
                    //Caption = 'Jipange Balance';
                    Editable = false;
                }
                field("Member Employer"; Rec."Employer Code")
                {
                    Editable = false;
                }
                field("Registration Date"; Rec."Registration Date")
                {

                }
            }

            group(Fixed)
            {
                caption = 'Fixed Account';
                Visible = FixedAccVisible;

                field(Name; Rec.Name)
                {
                    Editable = false;
                    Visible = false;

                    trigger OnValidate()
                    begin
                        Rec.Name := UpperCase(Rec.Name);
                    end;
                }
                field("Vendor Account No"; Rec."Vendor Account No")
                {
                    Caption = 'Account No';
                    Editable = false;
                    Visible = false;
                }
                field("Account Balance"; Rec."Account Balance")
                {
                    Editable = false;
                    Visible = false;
                }


                // field("FD Type Speedkey"; Rec."FD Type Speedkey") { ShowMandatory = true; }
                field("Fixed Deposit Certificate No."; Rec."Fixed Deposit Certificate No.") { }
                // field("Minimum Amount"; Rec."Minimum Amount") { }
                //field("Maximum Amount"; Rec."Maximum Amount") { }
                field("FD Interest Rate"; Rec."FD Interest Rate") { Editable = false; Caption = 'FD Interest Rate %'; }
                field("FD Duration"; Rec."FD Duration") { Editable = false; }
                field(Duration; Rec.Duration) { Editable = false; }
                field("Fixed Amount"; Rec."Fixed Amount")
                {
                    Caption = 'Principal Required';
                    ShowMandatory = true;
                    trigger onvalidate()

                    begin
                        if (Rec."Fixed Amount" < Rec."Minimum Amount") and (Rec."Fixed Amount" > Rec."Maximum Amount") then
                            Error('Amount is not within the Limit');

                    end;

                }
                field("Application Date"; Rec."Application Date")
                {
                    Caption = 'Interest Start Date';
                    ShowMandatory = true;
                }

                field("FD Maturity Date"; Rec."FD Maturity Date")
                {
                    Editable = false;
                }
                field("Withdrawal Before Maturity Charges"; Rec."Withdrawal Before Maturity Charges")
                {
                    Editable = false;
                }
                field("Tax Rate %"; Rec."Tax Rate %")
                {
                    Editable = false;
                }
                field("Upon Maturity"; Rec."Upon Maturity")
                {
                    ShowMandatory = true;
                }
                field("Computed Interest"; Rec."Computed Interest")
                {
                    Editable = false;
                }
                field(Tax; Rec.Tax)
                {
                    Editable = false;
                }
                field("Net Interest"; Rec."Net Interest")
                {
                    Editable = false;
                }

                field("Mobile Phone No"; Rec."Mobile Phone No")
                {
                    Editable = false;
                    visible = false;

                    trigger OnValidate()
                    begin
                        Rec."Mobile Phone No" := UpperCase(Rec."Mobile Phone No");
                    end;
                }

                field("ID No."; Rec."ID No.")
                {
                    Editable = false;
                    visible = false;

                    trigger OnValidate()
                    begin
                        Acc.Reset;
                        Acc.SetRange(Acc."ID No.", Rec."ID No.");
                        Acc.SetRange(Acc."Account Type", Rec."Account Type");
                        Acc.SetRange(Acc.Status, Acc.Status::Active);
                        if Acc.Find('-') then
                            Error('Account already created.');
                    end;
                }

                // field("Account Type Name"; Rec."Account Type Name")
                // {
                //     Editable = false;
                // }
                field("Account Category"; Rec."Account Category")
                {
                    Editable = false;
                }
                // field("Fixed Employer Code";Rec."Employer Code")
                // {

                // }
                field("Fixed Monthly Contribution"; Rec."Monthly Contribution")
                {
                    ShowMandatory = true;
                }
                field("Fixed Recruited By"; Rec."Recruited By")
                {
                    ShowMandatory = true;
                }
            }
            group(General)
            {
                Caption = 'Account Details';
                Visible = wezeshaVisible or pensionVisible or chamaaVisible or ESSVisible or jibambeVisible;

                // field(JipangeName; Rec.Name)
                // {
                //     Editable = false;
                //     caption = 'Name';

                //     trigger OnValidate()
                //     begin
                //         Rec.Name := UpperCase(Rec.Name);
                //     end;
                // }
                // field("JipangeID No."; Rec."ID No.")
                // {
                //     Editable = false;
                //     Caption = 'ID No.';

                //     trigger OnValidate()
                //     begin
                //         Acc.Reset;
                //         Acc.SetRange(Acc."ID No.", Rec."ID No.");
                //         Acc.SetRange(Acc."Account Type", Rec."Account Type");
                //         Acc.SetRange(Acc.Status, Acc.Status::Active);
                //         if Acc.Find('-') then
                //             Error('Account already created.');
                //     end;
                // }
                // field("JipangeMobile Phone No"; Rec."Mobile Phone No")
                // {
                //     Editable = false;
                //     Caption = 'Mobile Phone No.';

                //     trigger OnValidate()
                //     begin
                //         Rec."Mobile Phone No" := UpperCase(Rec."Mobile Phone No");
                //     end;
                // }
                // field("JipangeKRA No."; Rec."KRA No.")
                // {
                //     Caption = 'KRA No.';
                // }
                // field("Account Balance."; Rec."Account Balance")
                // {
                //     Caption = 'Account Balance';
                // }

                //  field("Member Employer Code";Rec."Employer Code")
                // {
                // }
                field("Monthly Contribution"; Rec."Monthly Contribution")
                {
                    ShowMandatory = true;
                }
                field("Recruited By"; Rec."Recruited By")
                {
                    ShowMandatory = true;
                }
            }

            group(Business)
            {
                Caption = 'Account Details';
                Visible = BusinessAccountVisible;

                // field("Business Account Name"; Rec.Name)
                // {
                //     Editable = false;
                //     caption = 'Name';

                //     trigger OnValidate()
                //     begin
                //         Rec.Name := UpperCase(Rec.Name);
                //     end;
                // }
                // field("Business Account ID No."; Rec."ID No.")
                // {
                //     Editable = false;
                //     Caption = 'ID No.';

                //     trigger OnValidate()
                //     begin
                //         Acc.Reset;
                //         Acc.SetRange(Acc."ID No.", Rec."ID No.");
                //         Acc.SetRange(Acc."Account Type", Rec."Account Type");
                //         Acc.SetRange(Acc.Status, Acc.Status::Active);
                //         if Acc.Find('-') then
                //             Error('Account already created.');
                //     end;
                // }

                // field("Business Account Mobile Phone No"; Rec."Mobile Phone No")
                // {
                //     Editable = false;
                //     Caption = 'Mobile Phone No.';

                //     trigger OnValidate()
                //     begin
                //         Rec."Mobile Phone No" := UpperCase(Rec."Mobile Phone No");
                //     end;
                // }
                // field("Business Account KRA No."; Rec."KRA No.")
                // {
                //     Caption = 'KRA No.';
                // }

                // field("Business Account Balance."; Rec."Account Balance")
                // {
                //     Caption = 'Account Balance';
                // }

                field("Business Store Name"; Rec."Business Name(Store)")
                {
                    //Editable = false;
                    showMandatory = true;
                }

                field("Business Type"; Rec."Business Type(Store)")
                {
                    // Editable = false;
                    showMandatory = true;
                }

                field("Business Location"; Rec."Business Location(Store)")
                {
                    // Editable = false;
                    showMandatory = true;
                }
                field("Business Contact"; Rec."Business Contact(Store)")
                {
                    //  Editable = false;
                    showMandatory = true;
                }
                field("Business Email"; Rec."Business Email(Store)")
                {
                    //Editable = false;
                    showMandatory = true;
                }
                field("Business Phone"; Rec."Business Phone(Store)")
                {
                    //Editable = false;
                    showMandatory = true;
                }
                field("Business Website"; Rec."Business Website(Store)")
                {
                    // Editable = false;
                    showMandatory = true;
                }
                field("Business Description"; Rec."Business Description(Store)")
                {
                    // Editable = false;
                    showMandatory = true;
                }
                // field("Business Employer Code";Rec."Employer Code")
                // {
                // }
                //  field("Business Monthly Contribution";Rec."Monthly Contribution")
                // {

                // }
                //  field("Business Recruited By";Rec."Recruited By")
                // {
                // }
            }

            group(ChildrenAcc)
            {
                Caption = 'Children Acc';
                Visible = ChildrenAccVisible;

                field(ChildName; Rec."Name of the Child")
                {
                    Editable = true;
                    caption = 'Name of Child';
                    ShowMandatory = true;

                    trigger OnValidate()
                    begin
                        Rec."Name of the Child" := UpperCase(Rec."Name of the Child");
                    end;
                }
                field(BirthCertNo; Rec."Birth Certificate-Child")
                {
                    Editable = true;
                    caption = 'Birth Certificate No.';
                    ShowMandatory = true;
                }
                field("Date of Birth-Child"; Rec."Date of Birth-Child")
                {
                    Editable = true;
                    Caption = 'Child Date of Birth';
                    ShowMandatory = true;
                }
                field("Children Monthly Contribution"; Rec."Monthly Contribution")
                {
                    ShowMandatory = true;

                }
                field("Children Recruited By"; Rec."Recruited By")
                {
                    ShowMandatory = true;
                }
            }
            group("Employment Info")
            {
                Caption = 'Employment Info';
                Visible = false;
                field(Control26; Rec."Employment Info")
                {
                    Editable = EmploymentInfoEditable;
                    ShowMandatory = true;

                    trigger OnValidate()
                    begin
                        if Rec."Employment Info" = Rec."employment info"::Employed then begin
                            EmployerCodeEditable := true;
                            DepartmentEditable := true;
                            TermsofEmploymentEditable := true;
                            ContractingEditable := false;
                            EmployedEditable := false;
                            OccupationEditable := false;
                            PositionHeldEditable := true;
                            EmploymentDateEditable := true;
                            EmployerAddressEditable := true;
                            NatureofBussEditable := false;
                            IndustryEditable := false;
                            BusinessNameEditable := false;
                            PhysicalBussLocationEditable := false;
                            YearOfCommenceEditable := false;



                        end else
                            if Rec."Employment Info" = Rec."employment info"::Contracting then begin
                                ContractingEditable := true;
                                EmployerCodeEditable := false;
                                DepartmentEditable := false;
                                TermsofEmploymentEditable := false;
                                OccupationEditable := false;
                                PositionHeldEditable := false;
                                EmploymentDateEditable := false;
                                EmployerAddressEditable := false;
                                NatureofBussEditable := false;
                                IndustryEditable := false;
                                BusinessNameEditable := false;
                                PhysicalBussLocationEditable := false;
                                YearOfCommenceEditable := false;
                            end else
                                if Rec."Employment Info" = Rec."employment info"::Others then begin
                                    OthersEditable := true;
                                    ContractingEditable := false;
                                    EmployerCodeEditable := false;
                                    DepartmentEditable := false;
                                    TermsofEmploymentEditable := false;
                                    OccupationEditable := false;
                                    PositionHeldEditable := false;
                                    EmploymentDateEditable := false;
                                    EmployerAddressEditable := false
                                end else
                                    if Rec."Employment Info" = Rec."employment info"::"Self-Employed" then begin
                                        OccupationEditable := true;
                                        EmployerCodeEditable := false;
                                        DepartmentEditable := false;
                                        TermsofEmploymentEditable := false;
                                        ContractingEditable := false;
                                        EmployedEditable := false;
                                        NatureofBussEditable := true;
                                        IndustryEditable := true;
                                        BusinessNameEditable := true;
                                        PhysicalBussLocationEditable := true;
                                        YearOfCommenceEditable := true;
                                        PositionHeldEditable := false;
                                        EmploymentDateEditable := false;
                                        EmployerAddressEditable := false

                                    end;



                        /*
                        IF "Identification Document"="Identification Document"::"Nation ID Card" THEN BEGIN
                          PassportEditable:=FALSE;
                          IDNoEditable:=TRUE
                          END ELSE
                          IF "Identification Document"="Identification Document"::"Passport Card" THEN BEGIN
                          PassportEditable:=TRUE;
                          IDNoEditable:=FALSE
                          END ELSE
                          IF "Identification Document"="Identification Document"::"Aliens Card" THEN BEGIN
                          PassportEditable:=TRUE;
                          IDNoEditable:=TRUE;
                        END;
                        */

                    end;
                }
                field("Employer Code"; Rec."Employer Code")
                {
                    Editable = false;
                    ShowMandatory = true;
                }
                field("Employer Name"; Rec."Employer Name")
                {
                    Editable = EmployedEditable;
                }
                field("Employer Address"; Rec."Employer Address")
                {
                    Editable = EmployerAddressEditable;
                }
                field("Date of Employment"; Rec."Date of Employment")
                {
                    Editable = EmploymentDateEditable;
                }
                field("Position Held"; Rec."Position Held")
                {
                    Editable = PositionHeldEditable;
                }
                field("Expected Monthly Income"; Rec."Expected Monthly Income")
                {
                    Editable = MonthlyIncomeEditable;
                }
                field("Nature Of Business"; Rec."Nature Of Business")
                {
                    Editable = NatureofBussEditable;
                }
                field(Industry; Rec.Industry)
                {
                    Editable = IndustryEditable;
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
                field(Occupation; Rec.Occupation)
                {
                    Editable = OccupationEditable;
                }
                field("Others Details"; Rec."Others Details")
                {
                    Editable = OthersEditable;
                }
            }
            // group("Child Details")
            // {
            //     Visible = ChildsDet;
            //     field("Name of the Child"; Rec."Name of the Child") { }
            //     field("Birth Certificate-Child"; Rec."Birth Certificate-Child") { }
            //     field("Date of Birth-Child"; Rec."Date of Birth-Child") { }
            // }

        }
        area(factboxes)
        {
            part(Control1000000025; "Vendor Picture-App")
            {
                Caption = 'Picture';
                Editable = MobileNoEditable;
                Enabled = MobileNoEditable;
                SubPageLink = "No." = field("No.");
            }
            part(Control1000000024; "Vendor Signature-App")
            {
                Caption = 'Signature';
                Editable = MobileNoEditable;
                Enabled = MobileNoEditable;
                SubPageLink = "No." = field("No.");
            }
            part(Control100000940; "SApp FrontID-App")
            {
                Caption = 'Picture';
                Editable = MobileNoEditable;
                Enabled = MobileNoEditable;
                SubPageLink = "No." = field("No.");
            }
            part(Control1000000980; "SApp BackID-App")
            {
                Caption = 'Signature';
                Editable = MobileNoEditable;
                Enabled = MobileNoEditable;
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
                action("Next of Kin")
                {
                    Caption = 'Next of Kin';
                    Image = Relationship;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Product App Nominee Details";
                    RunPageLink = "Account No" = field("No.");
                }
                action("Account Signatories ")
                {
                    Caption = 'Signatories';
                    Image = Group;
                    Promoted = true;
                    PromotedCategory = Process;
                    // RunObject = Page "Product App Signatories";
                    // RunPageLink = "Account No" = field("No.");
                }
                action("Account Agent Details")
                {
                    RunObject = Page "Account Agent App List";
                    RunPageLink = "Account No" = field("No.");
                }
            }
        }
        area(processing)
        {
            action(Approve)
            {
                Caption = 'Approve';
                Image = Approve;
                Promoted = true;
                PromotedCategory = Process;
                Visible = false;

                trigger OnAction()
                begin
                    //TESTFIELD("Employer Code");
                    Rec.TestField("Account Type");
                    //TESTFIELD("ID No.");
                    Rec.TestField("Staff No");
                    //TESTFIELD("BOSA Account No");
                    Rec.TestField("Date of Birth");
                    Rec.TestField("Global Dimension 2 Code");



                    if Rec."Application Status" = Rec."application status"::Converted then
                        Error('Application has already been Created.');

                    //-----Check Nominee details----------------
                    if (Rec."Account Type" = 'SAVINGS') then begin
                        Nok.Reset;
                        Nok.SetRange(Nok."Account No", Rec."No.");
                        if Nok.Find('-') = false then begin
                            Error('Next of Kin have not been specified.');
                        end;
                    end;
                    //-----Check Nominee details----------------



                    if Confirm('Are you sure you want to approve & create this account', true) = false then
                        exit;
                    Rec."Application Status" := Rec."application status"::Converted;
                    Rec.Modify;

                    BranchC := '';
                    IncrementNo := '';
                    /*
                    DimensionValue.RESET;
                    DimensionValue.SETRANGE(DimensionValue.Code,"Global Dimension 2 Code");
                    IF DimensionValue.FIND('-') THEN
                    BranchC:=DimensionValue."Account Code";
                    IncrementNo:=INCSTR(DimensionValue."No. Series");
                    
                    DimensionValue."No. Series":=IncrementNo;
                    DimensionValue.MODIFY;
                    */

                    if AccoutTypes.Get(Rec."Account Type") then begin
                        if AccoutTypes."Fixed Deposit" = true then begin
                            Rec.TestField(Rec."Savings Account No.");
                            //TESTFIELD("Maturity Type");
                            //TESTFIELD("Fixed Deposit Type");
                        end;

                        //Based on BOSA
                        ///////
                        if Rec."Parent Account No." = '' then begin
                            if DimensionValue.Get('BRANCH', Rec."Global Dimension 2 Code") then begin

                                if (AccoutTypes."Use Savings Account Number" = true) then begin
                                    Rec.TestField("Savings Account No.");
                                    AcctNo := AccoutTypes."Account No Prefix" + CopyStr(Rec."Savings Account No.", 4)
                                end else
                                    //DimensionValue."No. Series":=INCSTR(DimensionValue."No. Series");
                                    DimensionValue.Modify;
                            end;

                        end else begin
                            Rec.TestField("Kin No");
                            AcctNo := CopyStr(Rec."Parent Account No.", 1, 14) + Rec."Kin No";
                        end;
                        if AccoutTypes."Fixed Deposit" = true then begin
                            if Rec."Kin No" <> '' then
                                AcctNo := CopyStr(AcctNo, 1, 14) + Rec."Kin No";
                        end;
                        ///////
                        AccoutTypes.Get(Rec."Account Type");
                        if AccoutTypes.Code = 'Salary' then begin
                            //IF  "Kin No" <>'' THEN
                            AcctNo := AccoutTypes."Account No Prefix" + '-' + AccoutTypes."Ending Series";


                            Accounts.Init;
                            //Accounts."No.":=AcctNo;
                            Accounts."No." := Rec."No.";
                            AcctNo := Rec."No.";
                            Accounts."Date of Birth" := Rec."Date of Birth";
                            Accounts.Name := Rec.Name;
                            Accounts."Creditor Type" := Accounts."creditor type"::"FOSA Account";
                            Accounts."Debtor Type" := Rec."Debtor Type";
                            if Rec."Micro Single" = true then
                                Accounts."Group Account" := false
                            else
                                if Rec."Micro Group" = true then
                                    Accounts."Group Account" := false;
                            Accounts."Personal No." := Rec."Staff No";
                            Accounts."ID No." := Rec."ID No.";
                            Accounts."Mobile Phone No" := Rec."Mobile Phone No";
                            Accounts."Registration Date" := Rec."Registration Date";
                            Accounts."Marital Status" := Rec."Marital Status";
                            Accounts."BOSA Account No" := Rec."BOSA Account No";
                            Accounts.piccture := Rec.Picture;
                            Accounts.Signature := Rec.Signature;
                            Accounts."ID Back" := Rec."ID Back";
                            Accounts."ID Front" := Rec."ID Front";
                            Accounts."Passport No." := Rec."Passport No.";
                            Accounts."Employer Code" := Rec."Employer Code";
                            Accounts.Status := Accounts.Status::Active;
                            Accounts."Account Type" := Rec."Account Type";
                            Accounts."Account Category" := Rec."Account Category";
                            Accounts."Date of Birth" := Rec."Date of Birth";
                            Accounts."Global Dimension 1 Code" := 'FOSA';
                            Accounts."Global Dimension 2 Code" := Rec."Global Dimension 2 Code";
                            Accounts.Address := Rec.Address;
                            Accounts."Address 2" := Rec."Address 2";
                            Accounts.City := Rec.City;
                            Accounts."Phone No." := Rec."Phone No.";
                            Accounts."Telex No." := Rec."Telex No.";
                            Accounts."Post Code" := Rec."Post Code";
                            Accounts.County := Rec.County;
                            Accounts."E-Mail" := Rec."E-Mail";
                            Accounts."Home Page" := Rec."Home Page";
                            Accounts."Registration Date" := Today;
                            if Rec."Account Type" = '111' then begin
                                Accounts."Business Contact(Store)" := Rec."Business Contact(Store)";
                                Accounts."Business Description(Store)" := Rec."Business Description(Store)";
                                Accounts."Business Email(Store)" := Rec."Business Email(Store)";
                                Accounts."Business Location(Store)" := Rec."Business Location(Store)";
                                Accounts."Business Logo(Store)" := Rec."Business Logo(Store)";
                                Accounts."Business Name(Store)" := Rec."Business Name(Store)";
                                Accounts."Business Phone(Store)" := Rec."Business Phone(Store)";
                                Accounts."Business Short Code(Store)" := AccoutTypes."Store Series";
                                Accounts."Business Status(Store)" := Rec."Business Status(Store)";
                                Accounts."Business Type(Store)" := Rec."Business Type(Store)";
                                Accounts."Business Website(Store)" := Rec."Business Website(Store)";
                            end
                            else if Rec."Account Type" = '109' then begin
                                ObjAccounts."Child Name" := rec."Name of the Child";
                                ObjAccounts."Child Birth certificate" := Rec."Birth Certificate-Child";
                                ObjAccounts."Child DOB" := rec."Date of Birth-Child";
                            end;
                            //Accounts.Status:=Status::New;
                            //Accounts.Status:=Status::Open;
                            Accounts.Section := Rec.Section;
                            Accounts."Home Address" := Rec."Home Address";
                            Accounts.District := Rec.District;
                            Accounts.Location := Rec.Location;
                            Accounts."Sub-Location" := Rec."Sub-Location";
                            Accounts."Savings Account No." := Rec."Savings Account No.";
                            Accounts."Signing Instructions" := Rec."Signing Instructions";
                            Accounts."Fixed Deposit Type" := Rec."Fixed Deposit Type";
                            Accounts."FD Maturity Date" := Rec."FD Maturity Date";
                            Accounts."Registration Date" := Today;
                            Accounts."Monthly Contribution" := Rec."Monthly Contribution";
                            Accounts."Formation/Province" := Rec."Formation/Province";
                            Accounts."Division/Department" := Rec."Division/Department";
                            Accounts."Station/Sections" := Rec."Station/Sections";
                            Accounts."Force No." := Rec."Force No.";
                            Accounts."Vendor Posting Group" := Rec."Account Type";
                            Accounts.Insert;

                            if Rec."Account Type" = '111' then begin
                                AccoutTypes."Store Series" := INCSTR(AccoutTypes."Store Series");
                                AccoutTypes.Modify();
                            end;

                        end;

                    end;
                    Accounts.Reset;
                    if Accounts.Get(AcctNo) then begin
                        Accounts.Validate(Accounts.Name);
                        Accounts.Validate(Accounts."Account Type");
                        Accounts.Validate(Accounts."Global Dimension 1 Code");
                        Accounts.Validate(Accounts."Global Dimension 2 Code");
                        Accounts.Modify;

                        //Update BOSA with FOSA Account
                        if (Rec."Account Type" = 'SAV') then begin
                            if Cust.Get(Rec."BOSA Account No") then begin
                                Cust."FOSA Account No." := AcctNo;
                                //Cust."FOSA Account":="No.";
                                Cust.Modify;
                            end;
                        end;

                    end;

                    NextOfKinApp.Reset;
                    NextOfKinApp.SetRange(NextOfKinApp."Account No", Rec."No.");
                    if NextOfKinApp.Find('-') then begin
                        repeat
                            NextOfKin.Init;
                            //NextOfKin."Account No":=AcctNo;
                            NextOfKin."Account No" := Rec."No.";

                            NextOfKin.Name := NextOfKinApp.Name;
                            NextOfKin.Relationship := NextOfKinApp.Relationship;
                            NextOfKin.Beneficiary := NextOfKinApp.Beneficiary;
                            NextOfKin."Date of Birth" := NextOfKinApp."Date of Birth";
                            NextOfKin.Address := NextOfKinApp.Address;
                            NextOfKin.Telephone := NextOfKinApp.Telephone;
                            NextOfKin.Fax := NextOfKinApp.Fax;
                            NextOfKin.Email := NextOfKinApp.Email;
                            NextOfKin."ID No." := NextOfKinApp."ID No.";
                            NextOfKin."%Allocation" := NextOfKinApp."%Allocation";
                            NextOfKin.Insert;

                        until NextOfKinApp.Next = 0;
                    end;

                    AccountSignApp.Reset;
                    AccountSignApp.SetRange(AccountSignApp."Document No", Rec."No.");
                    if AccountSignApp.Find('-') then begin
                        repeat
                            AccountSign.Init;
                            AccountSign."Account No" := AcctNo;
                            AccountSign.Names := AccountSignApp.Names;
                            AccountSign."Date Of Birth" := Rec."Date of Birth";
                            AccountSign."Staff/Payroll" := AccountSignApp."Staff/Payroll";
                            AccountSign."ID No." := AccountSignApp."ID No.";
                            AccountSign.Signatory := AccountSignApp.Signatory;
                            AccountSign."Must Sign" := AccountSignApp."Must Sign";
                            AccountSign."Must be Present" := AccountSignApp."Must be Present";
                            AccountSign.Picture := AccountSignApp.Picture;
                            AccountSign.Signature := AccountSignApp.Signature;
                            AccountSign."Expiry Date" := AccountSignApp."Expiry Date";
                            AccountSign.Insert;

                        until AccountSignApp.Next = 0;
                    end;

                    Message('Account approved & created successfully.');

                end;
            }
            action(Reject)
            {
                Caption = 'Reject';
                Image = Reject;
                Promoted = true;
                PromotedCategory = Process;
                Visible = false;

                trigger OnAction()
                begin
                    if Rec."Application Status" = Rec."application status"::Converted then
                        Error('Application has already been converted.');

                    if Confirm('Are you sure you want to reject this application', true) = true then begin
                        Rec."Application Status" := Rec."application status"::Rejected;
                        Rec.Modify;
                    end;
                end;
            }
            group(Approvals)
            {
                action(Create)
                {
                    Caption = 'Create Product';
                    Enabled = EnableCreateMember;
                    Image = BankAccount;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedOnly = true;
                    Visible = false;

                    trigger OnAction()
                    var
                        ObjAccounttypes: Record "Account Types-Saving Products";
                        VarMaxnoofAccounts: Integer;
                        ObjAccounts: Record Vendor;
                        VarNoofMemberAccounts: Integer;
                    begin

                        //-----Check Mandatory Fields---------
                        //TESTFIELD("Employer Code");
                        Rec.TestField("Account Type");
                        Rec.TestField("ID No.");
                        //TESTFIELD("Staff No");
                        Rec.TestField("BOSA Account No");
                        Rec.TestField("Date of Birth");
                        Rec.TestField("Global Dimension 2 Code");
                        if Rec."Global Dimension 2 Code" = '' then
                            Error('Please specify the branch.');

                        //-----End Check Mandatory Fields---------

                        VarNoofMemberAccounts := 0;

                        ObjAccounttypes.Reset;
                        ObjAccounttypes.SetRange(ObjAccounttypes.Code, Rec."Account Type");
                        if ObjAccounttypes.FindSet then begin
                            VarMaxnoofAccounts := ObjAccounttypes."Maximum No Of Accounts";

                            ObjAccounts.Reset;
                            ObjAccounts.SetRange(ObjAccounts."ID No.", Rec."ID No.");
                            ObjAccounts.SetRange(ObjAccounts."Account Type", Rec."Account Type");
                            if ObjAccounts.FindSet then begin
                                VarNoofMemberAccounts := ObjAccounts.Count;
                            end;

                            /*if VarNoofMemberAccounts >= VarMaxnoofAccounts then begin
                                Error('Member has exceeded the maximum no of accounts one can have for this product.No of accounts the Member has %1#,maximum allowable %2#', VarNoofMemberAccounts, VarMaxnoofAccounts);
                            end;*/
                        end;


                        /*//----Check If account Already Exists------
                        Acc.RESET;
                        Acc.SETRANGE(Acc."ID No.","ID No.");
                        Acc.SETRANGE(Acc."Account Type","Account Type");
                        Acc.SETRANGE(Acc.Status,Acc.Status::Active);
                          IF Acc.FIND('-') THEN
                            ERROR('Account already exists. %1',Acc."No.");
                        //----End Check If account Already Exists------*/


                        //---Checkfields If Fixed Deposit------------
                        if AccoutTypes.Get(Rec."Account Type") then begin
                            if AccoutTypes."Fixed Deposit" = true then begin
                                Rec.TestField("Savings Account No.");
                                //TESTFIELD("Maturity Type");
                                //TESTFIELD("Fixed Deposit Type");
                            end;
                            //---End Checkfields If Fixed Deposit------------

                            if Rec."Application Status" = Rec."application status"::Converted then
                                Error('Application has already been converted.');



                            if Confirm('Are you sure you want to create this account?', true) = false then
                                exit;
                            Rec."Application Status" := Rec."application status"::Converted;
                            Rec."Registration Date" := Today;
                            Rec.Modify;

                            ObjAccountTypes.Reset();
                            ObjAccountTypes.SetRange(ObjAccountTypes.code, Rec."Account Type");
                            if ObjAccountTypes.Find('-') then begin
                                VarAcctNo := ObjAccountTypes.Branch + '-' + Rec."BOSA Account No" + '-' + ObjAccountTypes."Product Code";

                                Message('Generated account number is %1Branch%2Code%3', VarAcctNo, ObjAccountTypes.Branch, ObjAccountTypes."Product Code");
                            end;



                            AcctNo := VarAcctNo;


                            //---Create Account on Vendor Table----
                            Accounts.Init;
                            Accounts."No." := AcctNo;
                            Accounts."Date of Birth" := Rec."Date of Birth";
                            Accounts.Name := Rec.Name;
                            Accounts."Creditor Type" := Accounts."creditor type"::"FOSA Account";
                            Accounts."Personal No." := Rec."Staff No";
                            Accounts."ID No." := Rec."ID No.";
                            Accounts."Mobile Phone No" := Rec."Mobile Phone No";
                            Accounts."Monthly Contribution" := Rec."Monthly Contribution";
                            Accounts."Employer Code" := Rec."Employer Code";
                            Accounts."Recruited By" := Rec."Recruited By";
                            // Accounts."Payroll/Staff No2" := Rec."Staff No";
                            Accounts."Registration Date" := Rec."Registration Date";
                            Accounts."Employer Code" := Rec."Employer Code";
                            Accounts."BOSA Account No" := Rec."BOSA Account No";
                            if Rec."Account Type" = '111' then begin
                                Accounts."Business Contact(Store)" := Rec."Business Contact(Store)";
                                Accounts."Business Description(Store)" := Rec."Business Description(Store)";
                                Accounts."Business Email(Store)" := Rec."Business Email(Store)";
                                Accounts."Business Location(Store)" := Rec."Business Location(Store)";
                                Accounts."Business Logo(Store)" := Rec."Business Logo(Store)";
                                Accounts."Business Name(Store)" := Rec."Business Name(Store)";
                                Accounts."Business Phone(Store)" := Rec."Business Phone(Store)";
                                Accounts."Business Short Code(Store)" := AccoutTypes."Store Series";
                                Accounts."Business Status(Store)" := Rec."Business Status(Store)";
                                Accounts."Business Type(Store)" := Rec."Business Type(Store)";
                                Accounts."Business Website(Store)" := Rec."Business Website(Store)";
                            end
                            else if Rec."Account Type" = '109' then begin
                                ObjAccounts."Child Name" := rec."Name of the Child";
                                ObjAccounts."Child Birth certificate" := Rec."Birth Certificate-Child";
                                ObjAccounts."Child DOB" := rec."Date of Birth-Child";
                            end;
                            //Accounts.Picture := Picture;
                            Accounts.Signature := Rec.Signature;
                            Accounts."Fixed Amount" := Rec."Fixed Amount";
                            Accounts."FD Interest Rate" := Rec."FD Interest Rate";
                            Accounts."Fixed Deposit Type" := Rec."Fixed Deposit Type";
                            Accounts."Vendor Account No" := Rec."Vendor Account No";
                            Accounts."Passport No." := Rec."Passport No.";
                            Accounts.Status := Accounts.Status::Active;
                            Accounts."Account Type" := Rec."Account Type";
                            Accounts."Account Category" := Rec."Account Category";
                            Accounts."Date of Birth" := Rec."Date of Birth";
                            Accounts."Global Dimension 1 Code" := 'FOSA';
                            Accounts."Global Dimension 2 Code" := Rec."Global Dimension 2 Code";
                            Accounts.Address := Rec.Address;
                            Accounts."Address 2" := Rec."Address 2";
                            Accounts.City := Rec.City;
                            Accounts."Phone No." := Rec."Phone No.";
                            Accounts."Telex No." := Rec."Telex No.";
                            Accounts."Post Code" := Rec."Post Code";
                            Accounts.County := Rec.County;
                            Accounts."E-Mail" := Rec."E-Mail";
                            Accounts."Home Page" := Rec."Home Page";
                            Accounts."Registration Date" := Today;
                            Accounts.Status := Rec.Status::Approved;
                            Accounts.Section := Rec.Section;
                            Accounts."Home Address" := Rec."Home Address";
                            Accounts.District := Rec.District;
                            Accounts.Location := Rec.Location;
                            Accounts."Sub-Location" := Rec."Sub-Location";
                            Accounts."Savings Account No." := Rec."Savings Account No.";
                            Accounts."Registration Date" := Today;
                            Accounts."Vendor Posting Group" := Rec."Vendor Posting Group";
                            Accounts.Insert;
                            Rec."Application Status" := Rec."application status"::Converted;
                            Accounts.Modify;

                            if Rec."Account Type" = '111' then begin
                                AccoutTypes."Store Series" := INCSTR(AccoutTypes."Store Series");
                                AccoutTypes.Modify();
                            end;
                        end;
                        //AccoutTypes."Last No Used":=INCSTR(AccoutTypes."Last No Used");

                        ObjMemberNoseries.Reset;
                        ObjMemberNoseries.SetRange(ObjMemberNoseries."Account Type", Rec."Account Type");
                        ObjMemberNoseries.SetRange(ObjMemberNoseries."Branch Code", Rec."Global Dimension 2 Code");
                        if ObjMemberNoseries.FindSet then begin
                            ObjMemberNoseries."Account No" := IncStr(AcctNo);
                            ObjMemberNoseries.Modify;
                        end;


                        Accounts.Reset;
                        if Accounts.Get(AcctNo) then begin
                            Accounts.Validate(Accounts.Name);
                            Accounts.Validate(Accounts."Account Type");
                            Accounts.Validate(Accounts."Global Dimension 1 Code");
                            Accounts.Validate(Accounts."Global Dimension 2 Code");
                            Accounts.Modify;

                            //---Update BOSA with FOSA Account----
                            if (Rec."Account Type" = 'SAVINGS') then begin
                                if Cust.Get(Rec."BOSA Account No") then begin
                                    Cust."FOSA Account No." := AcctNo;
                                    Cust.Modify;
                                end;
                            end;
                            //---End Update BOSA with FOSA Account----
                        end;

                        //----Insert Nominee Information------
                        NextOfKinApp.Reset;
                        NextOfKinApp.SetRange(NextOfKinApp."Account No", Rec."No.");
                        if NextOfKinApp.Find('-') then begin
                            repeat
                                NextOfKin.Init;
                                NextOfKin."Account No" := AcctNo;
                                NextOfKin.Name := NextOfKinApp.Name;
                                NextOfKin.Relationship := NextOfKinApp.Relationship;
                                NextOfKin.Beneficiary := NextOfKinApp.Beneficiary;
                                NextOfKin."Date of Birth" := NextOfKinApp."Date of Birth";
                                NextOfKin.Address := NextOfKinApp.Address;
                                NextOfKin.Telephone := NextOfKinApp.Telephone;
                                //NextOfKin.Fax:=NextOfKinApp.Fax;
                                NextOfKin.Email := NextOfKinApp.Email;
                                NextOfKin."ID No." := NextOfKinApp."ID No.";
                                NextOfKin."%Allocation" := NextOfKinApp."%Allocation";
                                NextOfKin.Insert;
                            until NextOfKinApp.Next = 0;
                        end;
                        //----End Insert Nominee Information------

                        //Insert Account Signatories------
                        AccountSignApp.Reset;
                        AccountSignApp.SetRange(AccountSignApp."Document No", Rec."No.");
                        if AccountSignApp.Find('-') then begin
                            repeat
                                AccountSign.Init;
                                AccountSign."Account No" := AcctNo;
                                AccountSign.Names := AccountSignApp.Names;
                                AccountSign."Date Of Birth" := AccountSignApp."Date Of Birth";
                                AccountSign."Staff/Payroll" := AccountSignApp."Staff/Payroll";
                                AccountSign."ID No." := AccountSignApp."ID No.";
                                AccountSign.Signatory := AccountSignApp.Signatory;
                                AccountSign."Must Sign" := AccountSignApp."Must Sign";
                                AccountSign."Must be Present" := AccountSignApp."Must be Present";
                                //AccountSign.Picture:=AccountSignApp.Picture;
                                //AccountSign.Signature:=AccountSignApp.Signature;
                                AccountSign."Expiry Date" := AccountSignApp."Expiry Date";
                                AccountSign.Insert;
                                Rec."Application Status" := Rec."application status"::Converted;
                            until AccountSignApp.Next = 0;
                        end;
                        //Insert Account Signatories------

                        //Insert Account Agents------
                        ObjAccountAppAgents.Reset;
                        ObjAccountAppAgents.SetRange(ObjAccountAppAgents."Account No", Rec."No.");
                        if ObjAccountAppAgents.Find('-') then begin
                            repeat
                                ObjAccountAgents.Init;
                                ObjAccountAgents."Account No" := AcctNo;
                                ObjAccountAgents.Names := ObjAccountAppAgents.Names;
                                ObjAccountAgents."Date Of Birth" := ObjAccountAppAgents."Date Of Birth";
                                ObjAccountAgents."Staff/Payroll" := ObjAccountAppAgents."Staff/Payroll";
                                ObjAccountAgents."ID No." := ObjAccountAppAgents."ID No.";
                                ObjAccountAgents."Allowed  Correspondence" := ObjAccountAppAgents."Allowed  Correspondence";
                                ObjAccountAgents."Allowed Balance Enquiry" := ObjAccountAppAgents."Allowed Balance Enquiry";
                                ObjAccountAgents."Allowed FOSA Withdrawals" := ObjAccountAppAgents."Allowed FOSA Withdrawals";
                                ObjAccountAgents."Allowed Loan Processing" := ObjAccountAppAgents."Allowed Loan Processing";
                                ObjAccountAgents."Must Sign" := ObjAccountAppAgents."Must Sign";
                                ObjAccountAgents."Must be Present" := ObjAccountAppAgents."Must be Present";
                                ObjAccountAgents.Picture := ObjAccountAppAgents.Picture;
                                ObjAccountAgents.Signature := ObjAccountAppAgents.Signature;
                                ObjAccountAgents."Expiry Date" := ObjAccountAppAgents."Expiry Date";
                                ObjAccountAgents.Insert;
                                Rec."Application Status" := Rec."application status"::Converted;
                            until ObjAccountAppAgents.Next = 0;
                        end;
                        //Insert Account Agents------

                        //--Send Confirmation Sms to The Member------
                        SFactory.FnSendSMS('FOSA ACC', 'Your Account successfully created.Account No=' + AcctNo, AcctNo, Rec."Mobile Phone No");
                        Message('You have successfully created a %1 Product, A/C No=%2. Member will be notified via SMS', Rec."Account Type", AcctNo);


                        ObjMember.Reset;
                        ObjMember.SetRange(ObjMember."No.", Rec."BOSA Account No");
                        if ObjMember.FindSet then begin
                            if Rec."Account Type" = '602' then begin
                                ObjMember."Deposits Account No" := AcctNo;
                                ObjMember.Modify;
                            end;

                            if Rec."Account Type" = '601' then begin
                                ObjMember."Share Capital No" := AcctNo;
                                ObjMember.Modify;
                            end;

                            if Rec."Account Type" = '605' then begin
                                ObjMember."FOSA Shares Account No" := AcctNo;
                                ObjMember.Modify;
                            end;

                            if Rec."Account Type" = '606' then begin
                                ObjMember."Benevolent Fund No" := AcctNo;
                                ObjMember.Modify;
                            end;
                        end;

                        if ObjAccounts.Get(AcctNo) then begin
                            ObjAccounts.Status := ObjAccounts.Status::Active;
                            ObjAccounts.Modify;
                        end;
                        CurrPage.Close;
                    end;
                }
                action(CreateII)
                {
                    Caption = 'Create Account';
                    Enabled = EnableCreateMember;
                    Image = BankAccount;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    var
                        ObjAccountTypes: Record "Account Types-Saving Products";
                    begin
                        if Rec."Account Type" = 'FIXEDDEPOSIT' then begin
                            Rec.TestField(Rec."Fixed Amount");
                            // Rec.TestField(Rec."Fixed Deposit Type");
                            Rec.TestField(Rec."Application Date");
                        end;
                        //==================================================================================================Front Office Accounts
                        if Confirm('Are you sure you want to create this account?', true) = false then
                            exit;

                        ObjAccountTypes.Reset();
                        ObjAccountTypes.SetRange(ObjAccountTypes.code, Rec."Account Type");
                        if ObjAccountTypes.Find('-') then begin
                            VarAcctNo := ObjAccountTypes.Branch + '-' + Rec."BOSA Account No" + '-' + ObjAccountTypes."Product Code";
                        end;
                        // Message('Generated account number is %1Branch%2Code%3', VarAcctNo, ObjAccountTypes.Branch, ObjAccountTypes."Product Code");
                        ObjAccountTypes.Reset;
                        ObjAccountTypes.SetRange(ObjAccountTypes.Code, Rec."Account Type");
                        if ObjAccountTypes.FindSet then begin
                            VarMaxNoOfAccountsAllowable := ObjAccountTypes."Maximum No Of Accounts";
                        end;

                        /* ObjAccounts.Reset;
                        ObjAccounts.SetRange(ObjAccounts."BOSA Account No", Rec."BOSA Account No");
                        ObjAccounts.SetRange(ObjAccounts."Account Type", Rec."Account Type");
                        ObjAccounts.SetFilter(ObjAccounts.Status, '<>%1&<>%2', ObjAccounts.Status::Closed, ObjAccounts.Status::Deceased);
                        if ObjAccounts."No." <> 'FIXED' then begin
                            if ObjAccounts.FindSet then begin
                                VarNoAccounts := ObjAccounts.Count;
                                if VarNoAccounts >= VarMaxNoOfAccountsAllowable then
                                    Error('The Member has Exceeeded the Maximum No of Accounts they can have under this product. No. of Accounts %1 , Maximum No. of Accounts %2',
                                    VarNoAccounts, VarMaxNoOfAccountsAllowable);
                            end; 
                        end;*/
                        //===================================================================Create FOSA account
                        ObjAccounts.Init;
                        ObjAccounts."No." := VarAcctNo;
                        ObjAccounts."Date of Birth" := Rec."Date of Birth";
                        ObjAccounts.Name := Rec.Name;
                        ObjAccounts."Creditor Type" := ObjAccounts."creditor type"::"FOSA Account";
                        ObjAccounts."Personal No." := Rec."Staff No";
                        ObjAccounts."ID No." := Rec."ID No.";
                        ObjAccounts."Mobile Phone No" := Rec."Mobile Phone No";
                        ObjAccounts."Phone No." := Rec."Mobile Phone No";
                        ObjAccounts."Post Code" := Rec."Post Code";
                        ObjAccounts.County := Rec.City;
                        ObjAccounts."BOSA Account No" := Rec."BOSA Account No";
                        ObjAccounts.Piccture := Rec.Picture;
                        ObjAccounts.Signature := Rec.Signature;
                        ObjAccounts."Passport No." := Rec."Passport No.";
                        ObjAccounts."Employer Code" := Rec."Employer Code";
                        ObjAccounts.Status := ObjAccounts.Status::Deceased;
                        if Rec."Account Type" = '111' then begin
                            ObjAccounts."Business Contact(Store)" := Rec."Business Contact(Store)";
                            ObjAccounts."Business Description(Store)" := Rec."Business Description(Store)";
                            ObjAccounts."Business Email(Store)" := Rec."Business Email(Store)";
                            ObjAccounts."Business Location(Store)" := Rec."Business Location(Store)";
                            ObjAccounts."Business Logo(Store)" := Rec."Business Logo(Store)";
                            ObjAccounts."Business Name(Store)" := Rec."Business Name(Store)";
                            ObjAccounts."Business Phone(Store)" := Rec."Business Phone(Store)";
                            ObjAccounts."Business Short Code(Store)" := AccoutTypes."Store Series";
                            ObjAccounts."Business Status(Store)" := Rec."Business Status(Store)";
                            ObjAccounts."Business Type(Store)" := Rec."Business Type(Store)";
                            ObjAccounts."Business Website(Store)" := Rec."Business Website(Store)";
                        end
                        else if Rec."Account Type" = '109' then begin
                            ObjAccounts."Child Name" := rec."Name of the Child";
                            ObjAccounts."Child Birth certificate" := Rec."Birth Certificate-Child";
                            ObjAccounts."Child DOB" := rec."Date of Birth-Child";
                        end;
                        ObjAccounts."Fixed Amount" := Rec."Fixed Amount";
                        ObjAccounts."Vendor Posting Group" := Rec."Vendor Posting Group";
                        ObjAccounts."FD Interest Rate" := Rec."FD Interest Rate";
                        ObjAccounts."Fixed Deposit Type" := Rec."Fixed Deposit Type";
                        ObjAccounts."FD Duration" := Rec."FD Duration";
                        ObjAccounts."Fixed Deposit Start Date" := Rec."Application Date";
                        ObjAccounts."FD Maturity Date" := Rec."FD Maturity Date";
                        ObjAccounts."Vendor Account No" := Rec."Vendor Account No";
                        ObjAccounts."Withdrawal Before Maturity Charges" := Rec."Withdrawal Before Maturity Charges";
                        ObjAccounts."Tax Rate %" := Rec."Tax Rate %";
                        ObjAccounts."Upon Maturity" := Rec."Upon Maturity";
                        ObjAccounts."Computed Interest" := Rec."Computed Interest";
                        ObjAccounts.Tax := Rec.Tax;
                        ObjAccounts."Net Interest" := Rec."Net Interest";
                        ObjAccounts.Duration := Rec.Duration;
                        ObjAccounts."Fixed Deposit Certificate No." := Rec."Fixed Deposit Certificate No.";
                        ObjAccounts."Account Balance." := Rec."Account Balance";

                        ObjAccounts."Account Type" := Rec."Account Type";
                        ObjAccounts."Date of Birth" := Rec."Date of Birth";
                        ObjAccounts."Global Dimension 1 Code" := Rec."Global Dimension 1 Code";
                        ObjAccounts."Global Dimension 2 Code" := Rec."Global Dimension 2 Code";
                        ObjAccounts.Address := Rec.Address;
                        if Rec."Account Category" = Rec."account category"::Corporate then begin
                            ObjAccounts."Account Category" := ObjAccounts."account category"::Corporate;
                            ObjAccounts."Group Category" := ObjAccounts."Group Category"::"Co-operate";
                        end else
                            ObjAccounts."Account Category" := Rec."Account Category";
                        ObjAccounts."Address 2" := Rec."Address 2";
                        ObjAccounts."Phone No." := Rec."Mobile Phone No";
                        ObjAccounts."Application No." := Rec."No.";
                        ObjAccounts.Status := ObjAccounts.Status::Active;
                        ObjAccounts.Section := Rec.Section;
                        ObjAccounts."Home Address" := Rec."Home Address";
                        ObjAccounts.District := Rec.District;
                        ObjAccounts.Location := Rec.Location;
                        ObjAccounts."Sub-Location" := Rec."Sub-Location";
                        ObjAccounts."Registration Date" := Today;
                        ObjAccounts."Vendor Posting Group" := Rec."Vendor Posting Group";
                        ObjAccounts."Fixed Amount" := Rec."Fixed Amount";
                        ObjAccounts."FD Interest Rate" := Rec."FD Interest Rate";
                        ObjAccounts."Fixed Deposit Type" := Rec."Fixed Deposit Type";
                        ObjAccounts."Vendor Account No" := Rec."Vendor Account No";
                        ObjAccounts."FD Duration" := Rec."FD Duration";
                        ObjAccounts."Fixed Deposit Start Date" := Rec."Application Date";
                        ObjAccounts."FD Maturity Date" := Rec."FD Maturity Date";
                        ObjAccounts."Withdrawal Before Maturity Charges" := Rec."Withdrawal Before Maturity Charges";
                        ObjAccounts."Tax Rate %" := Rec."Tax Rate %";
                        ObjAccounts."Upon Maturity" := Rec."Upon Maturity";
                        ObjAccounts."Computed Interest" := Rec."Computed Interest";
                        ObjAccounts.Tax := Rec.Tax;
                        ObjAccounts."Net Interest" := Rec."Net Interest";
                        ObjAccounts.Duration := Rec.Duration;
                        ObjAccounts."Fixed Deposit Certificate No." := Rec."Fixed Deposit Certificate No.";
                        ObjAccounts."Account Balance" := Rec."Account Balance";

                        ObjAccounts."Monthly Contribution" := Rec."Monthly Contribution";
                        ObjAccounts."E-Mail" := Rec."E-Mail (Personal)";
                        //ObjAccounts."Group/Corporate Trade":="Group/Corporate Trade";
                        ObjAccounts."Name of the Group/Corporate" := Rec."Name of the Group/Corporate";
                        ObjAccounts."Certificate No" := Rec."Certificate No";
                        ObjAccounts."Application No." := Rec."No.";
                        ObjAccounts."Created By" := UserId;
                        ObjAccounts."Account Creation Date" := WorkDate;

                        //=============================================================Joint Account Details
                        ObjAccounts."Name 2" := Rec."Name 2";
                        ObjAccounts."Address3-Joint" := Rec.Address3;
                        ObjAccounts."Postal Code 2" := Rec."Postal Code 2";
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
                        //IF "Account Category"="Account Category"::Joint THEN
                        //ObjAccounts."Joint Account Name":="First Name"+' '+"First Name2";

                        ObjAccounts."Name 3" := Rec."Name 3";
                        ObjAccounts."Address3-Joint" := Rec.Address4;
                        ObjAccounts."Postal Code 3" := Rec."Postal Code 3";
                        ObjAccounts."ID No.3" := Rec."ID No.3";
                        ObjAccounts."Passport 3" := Rec."Passport 3";
                        ObjAccounts.Gender3 := Rec.Gender3;
                        ObjAccounts."Marital Status3" := Rec."Marital Status3";
                        ObjAccounts."E-Mail (Personal3)" := Rec."E-Mail (Personal3)";
                        ObjAccounts."Employer Code3" := Rec."Employer Code3";
                        ObjAccounts."Employer Name3" := Rec."Employer Name3";
                        ObjAccounts."Picture 3" := Rec."Picture 3";
                        ObjAccounts."Signature  3" := Rec."Signature  3";
                        //IF "Account Category"="Account Category"::Joint THEN
                        //ObjAccounts."Joint Account Name":="First Name"+' &'+"First Name2"+' &'+"First Name3"+'JA';

                        //=============================================================End Joint Account Details
                        ObjAccounts.Insert(true);
                        ObjAccounts.Modify();
                        if ObjAccounts.Insert(true) then begin
                            ObjAccountTypes.Reset();
                            ObjAccountTypes.SetRange(ObjAccountTypes.code, Rec."Account Type");
                            if ObjAccountTypes.Find('-') then begin
                                ObjAccountTypes."Last No Used" := IncStr(ObjAccountTypes."Last No Used");
                                if Rec."Account Type" = '111' then begin
                                    ObjAccountTypes."Store Series" := INCSTR(ObjAccountTypes."Store Series");
                                end;
                                ObjAccountTypes.Modify()

                            end;
                            Message('Nextno %1', ObjAccountTypes."Last No Used");
                        end;


                        ObjAccounts.Reset;
                        if ObjAccounts.Get(VarAcctNo) then begin
                            ObjAccounts.Validate(ObjAccounts.Name);
                            ObjAccounts.Validate(ObjAccounts."Account Type");
                            ObjAccounts.Modify;


                            ObjMemberNoseries.Reset;
                            ObjMemberNoseries.SetRange(ObjMemberNoseries."Account Type", Rec."Account Type");
                            ObjMemberNoseries.SetRange(ObjMemberNoseries."Branch Code", Rec."Global Dimension 2 Code");
                            if ObjMemberNoseries.FindSet then begin
                                ObjMemberNoseries."Account No" := IncStr(ObjMemberNoseries."Account No");
                                ObjMemberNoseries.Modify;
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
                                    ObjAccountAgents.Init;
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
                                            ObjAccountSign."Email Address" := ObjAccountSignApp."Email Address";
                                            ObjAccountSign."Mobile No" := ObjAccountSignApp."Mobile Phone No.";
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
                        end;
                        Message('You have successfully created a %1 Product, A/C No=%2', Rec."Account Type", VarAcctNo);

                        Rec.Created := true;
                        Rec."New FOSA No." := VarAcctNo;
                        Rec.Modify;
                        //==========================================================================================================End Front Office Accounts
                        if Confirm('Do you want to notify this member through sms?') then begin
                            SFactory.FnSendSMS('ACCOUNTAPP', 'Dear ' + Rec.Name + 'Your ' + Rec."Account Type" + 'has been created. Your account number is ' +
                            VarAcctNo, Rec."BOSA Account No", Rec."Phone No.");
                        end;

                        //========================================================================================================Update Piggy Bank Details
                        /*                         if (ObjNoSeries.Get) and (Rec."Issue Piggy Bank" = true) then begin
                                                    SFactory.FnRunPostPiggyBankCharges(Rec."No.", false);

                                                    ObjNoSeries.TestField(ObjNoSeries."Piggy Bank No");
                                                    VarPiggyBankNo := NoSeriesMgt.GetNextNo(ObjNoSeries."Piggy Bank No", 0D, true);
                                                    if VarPiggyBankNo <> '' then begin
                                                        ObjPiggyBank.Init;
                                                        ObjPiggyBank."Document No" := VarPiggyBankNo;
                                                        ObjPiggyBank."Member Account No" := Rec."BOSA Account No";
                                                        ObjPiggyBank."Member Name" := Rec."Parent Account Name";
                                                        ObjPiggyBank."Piggy Bank Account" := VarAcctNo;
                                                        ObjPiggyBank."Piggy Bank Account Name" := Rec.Name;
                                                        ObjPiggyBank."Issued On" := WorkDate;
                                                        ObjPiggyBank."Issued By" := UserId;
                                                        ObjPiggyBank."Collected By" := Rec."Parent Account Name";
                                                        ObjPiggyBank.Insert;
                                                    end;
                                                end; */
                        CurrPage.Close();
                    end;

                }
                action("Send Approval Request")
                {
                    Caption = 'Send Approval Request';
                    Enabled = (not OpenApprovalEntriesExist) and EnabledApprovalWorkflowsExist;
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedOnly = true;

                    trigger OnAction()
                    var
                        Text001: label 'This request is already pending approval';
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                        WorkflowMgt: Codeunit WorkflowIntegration;
                    begin
                        if Confirm('Are you sure you want to send Approval request for this record?', true) = false then
                            exit;
                        if Rec."Micro Group" <> true then begin
                            Rec.TestField("Account Type");
                            Rec.TestField("ID No.");
                            Rec.TestField("BOSA Account No");
                        end;

                        if WorkflowMgt.CheckFAccountApplicationApprovalsWorkflowEnabled(Rec) then
                            WorkflowMgt.OnSendFAccountApplicationForApproval(Rec);
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
                        Approvalmgt: Codeunit "Approvals Mgmt.";
                        WorkflowMgt: Codeunit WorkflowIntegration;
                    begin
                        if Confirm('Are you sure you want cancel Approval request for this record?', true) = false then
                            exit;
                        WorkflowMgt.OnCancelFAccountApplicationApprovalRequest(Rec);
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
                        DocumentType := Documenttype::ProductApplication;
                        ApprovalEntries.SetRecordFilters(Database::"FOSA Account Applicat. Details", approvalDoc::ProductApplication, Rec."No.");
                        ApprovalEntries.Run;
                    end;
                }
            }
        }
    }


    trigger OnAfterGetCurrRecord()
    begin
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(Rec.RecordId);
        EnabledApprovalWorkflowsExist := true;
        if Rec.Status = Rec.Status::Approved then begin
            OpenApprovalEntriesExist := false;
            CanCancelApprovalForRecord := false;
            EnabledApprovalWorkflowsExist := false;
        end;
        if Rec."Account Type" = '109' then begin
            ChildrenAccVisible := true;
        end;
        if Rec."Account Type" = '108' then begin
            FixedAccVisible := true;
        end;
        if Rec."Account Type" = '107' then begin
            JipangeAccVisible := true;
        end;
        if Rec."Account Type" = '104' then begin
            JipangeAccVisible := true;
        end;
        if Rec."Account Type" = '103' then begin
            JipangeAccVisible := true;
        end;
        if Rec."Account Type" = '101' then begin
            JipangeAccVisible := true;
        end;
        if Rec."Account Type" = '102' then begin
            JipangeAccVisible := true;
        end;
        if Rec."Account Type" = '105' then begin
            JipangeAccVisible := true;
        end;
        if Rec."Account Type" = '106' then begin
            JipangeAccVisible := true;
        end;
        if Rec."Account Type" = '111' then begin
            BusinessAccountVisible := true;
        end;
        ChildsDet := false;
        if Rec."Account Type" = 'CHILDRENS' THEN BEGIN
            ChildsDet := TRUE;
        END;
        if (Rec.Status = Rec.Status::Approved) then
            EnableCreateMember := true;
    end;

    trigger OnAfterGetRecord()
    var
        Vend: Record Vendor;
        Cust: Record Customer;
    begin
        //UpdateControls;

        EmployerCodeEditable := true;
        DepartmentEditable := true;
        TermsofEmploymentEditable := true;
        ContractingEditable := true;
        EmployedEditable := true;
        OccupationEditable := true;
        PositionHeldEditable := true;
        EmploymentDateEditable := true;
        EmployerAddressEditable := true;
        NatureofBussEditable := true;
        IndustryEditable := true;
        BusinessNameEditable := true;
        PhysicalBussLocationEditable := true;
        YearOfCommenceEditable := true;
        if Rec."Employment Info" = Rec."employment info"::Employed then begin
            EmployerCodeEditable := true;
            DepartmentEditable := true;
            TermsofEmploymentEditable := true;
            ContractingEditable := false;
            EmployedEditable := false;
            OccupationEditable := false;
            PositionHeldEditable := true;
            EmploymentDateEditable := true;
            EmployerAddressEditable := true;
            NatureofBussEditable := false;
            IndustryEditable := false;
            BusinessNameEditable := false;
            PhysicalBussLocationEditable := false;
            YearOfCommenceEditable := false;



        end else
            if Rec."Employment Info" = Rec."employment info"::Contracting then begin
                ContractingEditable := true;
                EmployerCodeEditable := false;
                DepartmentEditable := false;
                TermsofEmploymentEditable := false;
                OccupationEditable := false;
                PositionHeldEditable := false;
                EmploymentDateEditable := false;
                EmployerAddressEditable := false;
                NatureofBussEditable := false;
                IndustryEditable := false;
                BusinessNameEditable := false;
                PhysicalBussLocationEditable := false;
                YearOfCommenceEditable := false;
            end else
                if Rec."Employment Info" = Rec."employment info"::Others then begin
                    OthersEditable := true;
                    ContractingEditable := false;
                    EmployerCodeEditable := false;
                    DepartmentEditable := false;
                    TermsofEmploymentEditable := false;
                    OccupationEditable := false;
                    PositionHeldEditable := false;
                    EmploymentDateEditable := false;
                    EmployerAddressEditable := false
                end else
                    if Rec."Employment Info" = Rec."employment info"::"Self-Employed" then begin
                        OccupationEditable := true;
                        EmployerCodeEditable := false;
                        DepartmentEditable := false;
                        TermsofEmploymentEditable := false;
                        ContractingEditable := false;
                        EmployedEditable := false;
                        NatureofBussEditable := true;
                        IndustryEditable := true;
                        BusinessNameEditable := true;
                        PhysicalBussLocationEditable := true;
                        YearOfCommenceEditable := true;
                        PositionHeldEditable := false;
                        EmploymentDateEditable := false;
                        EmployerAddressEditable := false

                    end;
        ChildsDet := false;
        if Rec."Account Type" = 'CHILDRENS' THEN BEGIN
            ChildsDet := TRUE;
        END;

        //validating empty payroll numbers
        Vend.Reset();
        Vend.SetRange(Vend.Name, Rec.Name);
        if Vend.find('-') then begin
            if Rec."Staff No" = '' then begin
                Rec."Staff No" := Vend."Personal No.";
            end;
        end;

    end;

    trigger OnFindRecord(Which: Text): Boolean
    var
        RecordFound: Boolean;
    begin
        RecordFound := Rec.Find(Which);
        CurrPage.Editable := RecordFound or (Rec.GetFilter("No.") = '');
        exit(RecordFound);
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        //"Debtor Type":="Debtor Type"::Account;
        //"Application Date":=TODAY;
        Rec."Global Dimension 1 Code" := 'FOSA';
    end;

    trigger OnOpenPage()
    var
        MapMgt: Codeunit "Online Map Management";
    begin

        ActivateFields;

        if Rec.Status = Rec.Status::Approved then
            CurrPage.Editable := false;
        UpdateControls;


        EmploymentInfoEditable := true;
        EmployerCodeEditable := true;
        DepartmentEditable := true;
        TermsofEmploymentEditable := true;
        ContractingEditable := true;
        EmployedEditable := true;
        OccupationEditable := true;
        PositionHeldEditable := true;
        EmploymentDateEditable := true;
        EmployerAddressEditable := true;
        NatureofBussEditable := true;
        IndustryEditable := true;
        BusinessNameEditable := true;
        PhysicalBussLocationEditable := true;
        YearOfCommenceEditable := true;




        if Rec."Employment Info" = Rec."employment info"::Employed then begin
            EmployerCodeEditable := true;
            DepartmentEditable := true;
            TermsofEmploymentEditable := true;
            ContractingEditable := false;
            EmployedEditable := false;
            OccupationEditable := false;
            PositionHeldEditable := true;
            EmploymentDateEditable := true;
            EmployerAddressEditable := true;
            NatureofBussEditable := false;
            IndustryEditable := false;
            BusinessNameEditable := false;
            PhysicalBussLocationEditable := false;
            YearOfCommenceEditable := false;



        end else
            if Rec."Employment Info" = Rec."employment info"::Contracting then begin
                ContractingEditable := true;
                EmployerCodeEditable := false;
                DepartmentEditable := false;
                TermsofEmploymentEditable := false;
                OccupationEditable := false;
                PositionHeldEditable := false;
                EmploymentDateEditable := false;
                EmployerAddressEditable := false;
                NatureofBussEditable := false;
                IndustryEditable := false;
                BusinessNameEditable := false;
                PhysicalBussLocationEditable := false;
                YearOfCommenceEditable := false;
            end else
                if Rec."Employment Info" = Rec."employment info"::Others then begin
                    OthersEditable := true;
                    ContractingEditable := false;
                    EmployerCodeEditable := false;
                    DepartmentEditable := false;
                    TermsofEmploymentEditable := false;
                    OccupationEditable := false;
                    PositionHeldEditable := false;
                    EmploymentDateEditable := false;
                    EmployerAddressEditable := false
                end else
                    if Rec."Employment Info" = Rec."employment info"::"Self-Employed" then begin
                        OccupationEditable := true;
                        EmployerCodeEditable := false;
                        DepartmentEditable := false;
                        TermsofEmploymentEditable := false;
                        ContractingEditable := false;
                        EmployedEditable := false;
                        NatureofBussEditable := true;
                        IndustryEditable := true;
                        BusinessNameEditable := true;
                        PhysicalBussLocationEditable := true;
                        YearOfCommenceEditable := true;
                        PositionHeldEditable := false;
                        EmploymentDateEditable := false;
                        EmployerAddressEditable := false

                    end;
        /*  ChildsDet := false;
         if Rec."Account Type" = 'CHILDRENS' THEN BEGIN
             ChildsDet := TRUE;
         END; */
    end;

    var
        CalendarMgmt: Codeunit "Calendar Management";
        PaymentToleranceMgt: Codeunit "Payment Tolerance Management";
        CustomizedCalEntry: Record "Customized Calendar Entry";
        CustomizedCalendar: Record "Customized Calendar Change";
        Text001: label 'Do you want to allow payment tolerance for entries that are currently open?';
        Text002: label 'Do you want to remove payment tolerance from entries that are currently open?';
        PictureExists: Boolean;
        AccoutTypes: Record "Account Types-Saving Products";
        Accounts: Record Vendor;
        AcctNo: Code[50];
        DimensionValue: Record "Dimension Value";
        NextOfKin: Record "FOSA Account NOK Details";
        NextOfKinApp: Record "FOSA Account App Kin Details";
        AccountSign: Record "FOSA Account Sign. Details";
        AccountSignApp: Record "Product App Signatories";
        Acc: Record Vendor;
        UsersID: Record User;
        Nok: Record "FOSA Account App Kin Details";
        Cust: Record Customer;
        NOKBOSA: Record "FOSA Account NOK Details";
        BranchC: Code[20];
        DimensionV: Record "Dimension Value";
        IncrementNo: Code[20];
        MicSingle: Boolean;
        MicGroup: Boolean;
        BosaAcnt: Boolean;
        EmailEdiatble: Boolean;
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ","Purchase Requisition",RFQ,"Store Requisition","Payment Voucher",MembershipApplication,LoanApplication,LoanDisbursement,ProductApplication,StandingOrder,MembershipWithdrawal,ATMCard,GuarantorRecovery,ChangeRequest,TreasuryTransactions;
        SaccoSetup: Record "Sacco No. Series";
        MicroGroupCode: Boolean;
        BusinessAccountVisible: Boolean;
        pensionVisible: Boolean;
        wezeshaVisible: Boolean;
        jibambeVisible: Boolean;
        chamaaVisible: Boolean;
        ESSVisible: Boolean;
        Vendor: Record Vendor;
        NameEditable: Boolean;
        NoEditable: Boolean;
        AddressEditable: Boolean;
        GlobalDim1Editable: Boolean;
        GlobalDim2Editable: Boolean;
        DocNo: code[40];
        VendorPostingGroupEdit: Boolean;
        PhoneEditable: Boolean;
        MaritalstatusEditable: Boolean;
        Accountypessetup: Record "Account Types-Saving Products";
        IDNoEditable: Boolean;
        RegistrationDateEdit: Boolean;
        ChildsDet: Boolean;
        EmployerCodeEditable: Boolean;
        DOBEditable: Boolean;
        StaffNoEditable: Boolean;
        GenderEditable: Boolean;
        MonthlyContributionEdit: Boolean;
        PostCodeEditable: Boolean;
        CityEditable: Boolean;
        RecruitedEditable: Boolean;
        ContactPEditable: Boolean;
        ContactPRelationEditable: Boolean;
        ContactPOccupationEditable: Boolean;
        ContactPPhoneEditable: Boolean;
        BOSAnoEditable: Boolean;
        MobileNoEditable: Boolean;
        PassPortNoEditable: Boolean;
        ApplicationDateEditable: Boolean;
        AccountTypeEditable: Boolean;
        AccountCategoryEditable: Boolean;
        ParentAccountEditable: Boolean;
        SavingsAccountEditable: Boolean;
        SigningInstructionEditable: Boolean;
        ActivityEditable: Boolean;
        BranchEditable: Boolean;
        Accountype: Boolean;
        Approvalusers: Record "Status Change Permision";
        Member: Record Customer;
        IncrementNoF: Code[20];
        SMSMessage: Record "SMS Messages";
        iEntryNo: Integer;
        ParentEditable: Boolean;
        SavingsEditable: Boolean;
        CurrentAcc: Code[20];
        OpenApprovalEntriesExist: Boolean;
        EnabledApprovalWorkflowsExist: Boolean;
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        CanCancelApprovalForRecord: Boolean;
        EventFilter: Text;
        EnableCreateMember: Boolean;
        SFactory: Codeunit "Au Factory";
        ObjAccountAgents: Record "Account Agent Details";
        ObjAccountAppAgents: Record "Account Agents App Details";
        EmploymentInfoEditable: Boolean;
        DepartmentEditable: Boolean;
        TermsofEmploymentEditable: Boolean;
        ContractingEditable: Boolean;
        EmployedEditable: Boolean;
        OccupationEditable: Boolean;
        PositionHeldEditable: Boolean;
        EmploymentDateEditable: Boolean;
        EmployerAddressEditable: Boolean;
        NatureofBussEditable: Boolean;
        IndustryEditable: Boolean;
        BusinessNameEditable: Boolean;
        PhysicalBussLocationEditable: Boolean;
        YearOfCommenceEditable: Boolean;
        OthersEditable: Boolean;
        MonthlyIncomeEditable: Boolean;
        RefereeEditable: Boolean;
        ObjMember: Record Customer;
        ObjMemberNoseries: Record "Member Accounts No Series";
        VarAcctNo: Code[30];
        VarMaxNoOfAccountsAllowable: Integer;
        VarNoAccounts: Integer;
        ObjAccountSign: Record "FOSA Account Sign. Details";
        ObjNextofKinFOSA: Record "FOSA Account NOK Details";
        ObjAccounts: Record Vendor;
        ObjNextOfKinApp: Record "FOSA Account App Kin Details";
        ObjMemberAppAgent: Record "Account Agents App Details";
        ObjAccountSignApp: Record "Product App Signatories";
        ObjNoSeries: Record "Sacco No. Series";
        VarDocumentNo: Code[30];
        NoSeriesMgt: Codeunit "No. Series";
        ObjPiggyBank: Record "Piggy Bank Issuance";
        VarPiggyBankNo: Code[30];
        FixedAccVisible: Boolean;
        JipangeAccVisible: Boolean;
        ChildrenAccVisible: Boolean;


    procedure ActivateFields()
    begin
    end;

    local procedure ContactOnAfterValidate()
    begin
        //ActivateFields;
    end;

    local procedure ICPartnerCodeOnAfterValidate()
    begin
        // CurrPage.Update;
    end;


    procedure Controls()
    begin
        //IF (MicSingle = TRUE) OR (MicGroup=TRUE) THEN
        //BosaAcnt:=FALSE


    end;


    procedure UpdateControls()
    begin

        if Rec.Status = Rec.Status::Approved then begin
            NameEditable := false;
            NoEditable := false;
            AddressEditable := false;
            ActivityEditable := false;
            BranchEditable := false;
            SigningInstructionEditable := false;
            BOSAnoEditable := false;
            SavingsAccountEditable := false;
            ParentAccountEditable := false;
            MobileNoEditable := false;
            AccountTypeEditable := false;
            VendorPostingGroupEdit := false;
            PhoneEditable := false;
            MaritalstatusEditable := false;
            IDNoEditable := false;
            PhoneEditable := false;
            RegistrationDateEdit := false;
            PassPortNoEditable := false;
            EmployerCodeEditable := false;
            DOBEditable := false;
            EmailEdiatble := false;
            StaffNoEditable := false;
            GenderEditable := false;
            MonthlyContributionEdit := false;
            PostCodeEditable := false;
            CityEditable := false;
            RecruitedEditable := false;
            ContactPEditable := false;
            ContactPRelationEditable := false;
            ContactPOccupationEditable := false;
            ContactPPhoneEditable := false;
        end;


        if Rec.Status = Rec.Status::Pending then begin
            NameEditable := false;
            NoEditable := false;
            AddressEditable := false;
            ActivityEditable := false;
            BranchEditable := false;
            SigningInstructionEditable := false;
            BOSAnoEditable := false;
            SavingsAccountEditable := false;
            ParentAccountEditable := false;
            MobileNoEditable := false;
            AccountTypeEditable := false;
            VendorPostingGroupEdit := false;
            PhoneEditable := false;
            MaritalstatusEditable := false;
            IDNoEditable := false;
            PhoneEditable := false;
            RegistrationDateEdit := false;
            PassPortNoEditable := false;
            EmployerCodeEditable := false;
            DOBEditable := false;
            EmailEdiatble := false;
            StaffNoEditable := false;
            GenderEditable := false;
            MonthlyContributionEdit := false;
            PostCodeEditable := false;
            CityEditable := false;
            RecruitedEditable := false;
            ContactPEditable := false;
            ContactPRelationEditable := false;
            ContactPOccupationEditable := false;
            ContactPPhoneEditable := false;
        end;

        if Rec.Status = Rec.Status::Open then begin
            NameEditable := true;
            NoEditable := true;
            AddressEditable := true;
            ActivityEditable := true;
            BranchEditable := true;
            SigningInstructionEditable := true;
            BOSAnoEditable := true;
            SavingsAccountEditable := true;
            ParentAccountEditable := true;
            MobileNoEditable := true;
            AccountTypeEditable := true;
            VendorPostingGroupEdit := true;
            PhoneEditable := true;
            MaritalstatusEditable := true;
            IDNoEditable := true;
            PhoneEditable := true;
            RegistrationDateEdit := true;
            PassPortNoEditable := true;
            EmployerCodeEditable := true;
            DOBEditable := true;
            EmailEdiatble := true;
            StaffNoEditable := true;
            GenderEditable := true;
            MonthlyContributionEdit := true;
            PostCodeEditable := true;
            CityEditable := true;
            RecruitedEditable := true;
            ContactPEditable := true;
            ContactPRelationEditable := true;
            ContactPOccupationEditable := true;
            ContactPPhoneEditable := true;
        end;
    end;
}




