//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50541 "Change Request"
{

    DrillDownPageId = "Change Request List";
    LookupPageId = "Change Request List";


    fields
    {
        field(1; No; Code[30])
        {
            Editable = false;

            trigger OnValidate()
            begin
                if No <> xRec.No then begin
                    SalesSetup.Get;
                    NoSeriesMgt.TestManual(SalesSetup."Change Request No");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; Type; Option)
        {
            OptionCaption = ' ,Mobile Change,,Account Change,,,,';
            OptionMembers = " ","Mobile Change","ATM Change","Backoffice Change","Agile Change","Next Of Kin Change","Microfinance Change","Picture Change";

            trigger OnValidate()
            begin
                "Account No" := '';
            end;
        }
        field(3; "Account No"; Code[50])
        {
            TableRelation = if (Type = const("Backoffice Change")) Customer."No." where(ISNormalMember = const(true))
            else
            if (Type = const("Mobile Change")) Vendor."No."
            else
            if (Type = const("ATM Change")) Vendor."No."
            else
            if (Type = const("Agile Change")) Vendor."No." where("Vendor Posting Group" = filter(<> 'TCREDITORS'))
            else
            if (Type = filter("Microfinance Change")) Customer."No." where(ISNormalMember = const(true))
            else
            if (Type = const("Next Of Kin Change")) Customer."No." where(ISNormalMember = const(true));

            trigger OnValidate()
            begin
                Clear(Picture);
                if ((Type = Type::"Mobile Change") or (Type = Type::"ATM Change") or (Type = Type::"Agile Change")) then begin
                    vend.Reset;
                    vend.SetRange(vend."No.", "Account No");
                    if vend.Find('-') then begin
                        Name := vend.Name;
                        Branch := vend."Global Dimension 2 Code";
                        Address := vend.Address;
                        //Picture:=vend.Picture;
                        //signinature:=vend.Signature;
                        Email := vend."E-Mail";
                        "Mobile No" := vend."Mobile Phone No";
                        "S-Mobile No" := vend."S-Mobile No";
                        "ATM Collector Name" := vend."ATM Collector Name";
                        "ID No" := vend."ID No.";
                        "Personal No" := vend."Personal No.";
                        "Account Type" := vend."Account Type";
                        City := vend.City;
                        Section := vend.Section;
                        "Card Expiry Date" := vend."Card Expiry Date";
                        "Card No" := vend."Card No.";
                        "Card Valid From" := vend."Card Valid From";
                        "Card Valid To" := vend."Card Valid To";
                        "Marital Status" := vend."Marital Status";
                        "Reason for change" := vend."Reason For Blocking Account";
                        "Phone No.(Old)" := vend."Phone No.";
                        "Mobile No" := vend."Mobile Phone No";
                        Blocked := vend.Blocked;
                        "Blocked (New)" := vend.Blocked;
                        "Status." := vend.Status;
                        "Status.(New)" := vend.Status;
                        "Child DOB Old" := vend."Child DOB";
                        "Childs Gender Old" := vend."Childs Gender";
                        "Child Name Old" := vend."Child Name";
                        "Birth Certificate No Old" := vend."Child Birth certificate";
                        "Business Contact(Store)" := vend."Business Contact(Store)";
                        "Business Description(Store)" := vend."Business Description(Store)";
                        "Business Email(Store)" := vend."Business Email(Store)";
                        "Business Location(Store)" := vend."Business Location(Store)";
                        "Business Name(Store)" := vend."Business Name(Store)";
                        "Business Phone(Store)" := vend."Business Phone(Store)";
                        "Business Short Code(Store)" := vend."Business Short Code(Store)";
                        "Business Status(Store)" := vend."Business Status(Store)";
                        "Business Type(Store)" := vend."Business Type(Store)";
                        "Business Website(Store)" := vend."Business Website(Store)";

                    end;


                end;


                if Type = Type::"Backoffice Change" then begin
                    Memb.Reset;
                    Memb.SetRange(Memb."No.", "Account No");
                    if Memb.Find('-') then begin

                        Name := Memb.Name;
                        "FOSA Account No" := Memb."FOSA Account No.";
                        Workstation := Memb.Workstation;
                        Designation := Memb.Designation;
                        Branch := Memb."Global Dimension 2 Code";
                        Address := Memb.Address;
                        Email := Memb."E-Mail";
                        "Mobile No" := Memb."Mobile Phone No";
                        "ID No" := Memb."ID No.";
                        "Personal No" := Memb."Payroll No";
                        "Post Code" := Memb."Post Code";
                        City := Memb.City;
                        Section := Memb.Section;
                        "Marital Status" := Memb."Marital Status";
                        "Monthly Contributions" := Memb."Monthly Contribution";
                        // "Signing Instructions":=Memb."Signing Instructions";
                        "Member Account Status" := Memb.Status;
                        "Membership Status" := Memb."Membership Status";
                        "Membership Status(New)" := Memb."Membership Status";
                        // "Group Account No":=Memb."Group Account No";
                        //"Group Account Name":=Memb."Group Account Name";
                        "Member Account Status" := Memb.Status;
                        "Employer Code" := Memb."Employer Code";
                        "Status." := Memb.Status;
                        "Status.(New)" := Memb.Status;
                        "Date Of Birth" := Memb."Date of Birth";
                        Disabled := Memb.Disabled;
                        Occupation := Memb.Occupation;
                        Blocked := Memb.Blocked;
                        "Bank Code(Old)" := Memb."Bank Branch Code";
                        "Bank Account No(Old)" := Memb."Bank Account No.";
                        "KRA Pin(Old)" := Memb.Pin;
                        "Account Category" := Memb."Account Category";
                        "Bank Branch Name" := Memb."Bank Branch Name";
                        "Bank Name" := Memb."Bank Name";
                        "Bank Branch Code" := Memb."Bank Branch Code";
                        Gender := Memb.Gender;
                        "Mode Of Remmittance" := Memb."Mode Of Remmittance";
                        County := Memb.County;
                        "Sub-county" := Memb."Sub-county";
                        "Area" := Memb."Area";
                        "Nearest Landmark" := Memb."Nearest Landmark";
                        "Member Type" := Memb."Member Type";
                        "Member Type(New Value)" := Memb."Member Type";
                        "ATM No." := Memb."ATM No";
                        "Insider Status" := Memb."Insider Status";
                        "Insider Status (New)" := Memb."Insider Status";
                        "Sales Rep" := Memb."Sales Person";
                        "New Sales Rep" := Memb."Sales Person";
                        "Customer Service Rep" := Memb."Customer Service Rep.";
                        "New Customer Service Rep" := Memb."Customer Service Rep.";

                        //bank
                    end;
                end;
                //Next Of Kin
                if Type = Type::"Next Of Kin Change" then begin
                    if ObjCust.Get("Account No") then begin
                        Options := Text000;
                        Selected := Dialog.StrMenu(Options, 1, Text002);
                        if Selected = 4 then begin
                            "Kin Option" := 4;
                            ObjCust.CalcFields("No of Next of Kin");
                            nextofkin := ObjCust."No of Next of Kin";
                            if nextofkin > 1 then begin
                                Nok.Reset();
                                Nok.SetRange(Nok."Account No", "Account No");
                                if Nok.FindSet() then begin
                                    repeat
                                        if Confirm('Next of Kin: %1', false, Nok.Name) = true then begin
                                            "Kin Name" := Nok.Name;
                                            "Kin ID No." := Nok."ID No.";
                                            Relationship := Nok.Relationship;
                                            "Kin Date of Birth" := Nok."Date of Birth";
                                            "%Allocation" := Nok."%Allocation";
                                            "%Allocation (New)" := Nok."%Allocation";
                                            "Kin Address" := Nok.Address;
                                            "Next Of Kin Type" := Nok."Next Of Kin Type";
                                            Description := Nok.Description;
                                            "Kin Telephone" := Nok.Telephone;
                                            "Kin Email" := Nok.Email;
                                            "Kin No." := Nok."NoK No.";
                                            exit;
                                        end else begin
                                            // Message('Next');
                                        end;
                                    until Nok.Next() = 0;
                                end;
                            end else if nextofkin = 1 then begin
                                Nok.Reset();
                                Nok.SetRange(Nok."Account No", ObjCust."No.");
                                if Nok.Find('-') then begin
                                    "Kin Name" := Nok.Name;
                                    "Kin ID No." := Nok."ID No.";
                                    Relationship := Nok.Relationship;
                                    "Kin Date of Birth" := Nok."Date of Birth";
                                    "%Allocation" := Nok."%Allocation";
                                    "%Allocation (New)" := Nok."%Allocation";
                                    "Kin Address" := Nok.Address;
                                    "Next Of Kin Type" := Nok."Next Of Kin Type";
                                    Description := Nok.Description;
                                    "Kin Telephone" := Nok.Telephone;
                                    "Kin Email" := Nok.Email;
                                    "Kin No." := nok."NoK No.";
                                end;
                            end else if nextofkin = 0 then begin
                                Error('The member %1 has no next of kin information to change.', "Account No");
                            end;
                        end else if Selected = 3 then begin
                            "Kin Option" := 3;
                            ObjCust.CalcFields("No of Next of Kin");
                            nextofkin := ObjCust."No of Next of Kin";
                            if nextofkin > 1 then begin
                                Nok.Reset();
                                Nok.SetRange(Nok."Account No", "Account No");
                                if Nok.FindSet() then begin
                                    repeat
                                        if Confirm('Next of Kin: %1', false, Nok.Name) = true then begin
                                            "Kin Name" := Nok.Name;
                                            "Kin ID No." := Nok."ID No.";
                                            Relationship := Nok.Relationship;
                                            "Kin Date of Birth" := Nok."Date of Birth";
                                            "%Allocation" := Nok."%Allocation";
                                            "%Allocation (New)" := Nok."%Allocation";
                                            "Kin Address" := Nok.Address;
                                            "Next Of Kin Type" := Nok."Next Of Kin Type";
                                            Description := Nok.Description;
                                            "Kin Telephone" := Nok.Telephone;
                                            "Kin Email" := Nok.Email;
                                            "Kin No." := Nok."NoK No.";
                                            exit;
                                        end else begin
                                            // Message('Next');
                                        end;
                                    until Nok.Next() = 0;
                                end;
                            end else if nextofkin = 1 then begin
                                Nok.Reset();
                                Nok.SetRange(Nok."Account No", ObjCust."No.");
                                if Nok.Find('-') then begin
                                    "Kin Name" := Nok.Name;
                                    "Kin ID No." := Nok."ID No.";
                                    Relationship := Nok.Relationship;
                                    "Kin Date of Birth" := Nok."Date of Birth";
                                    "%Allocation" := Nok."%Allocation";
                                    "%Allocation (New)" := Nok."%Allocation";
                                    "Kin Address" := Nok.Address;
                                    "Next Of Kin Type" := Nok."Next Of Kin Type";
                                    Description := Nok.Description;
                                    "Kin Telephone" := Nok.Telephone;
                                    "Kin Email" := Nok.Email;
                                    "Kin No." := nok."NoK No.";
                                end;
                            end else if nextofkin = 0 then begin
                                Error('The member %1 has no next of kin information to change.', "Account No");
                            end;
                        end else if Selected = 2 then begin
                            "Kin Option" := 2;
                            ObjCust.CalcFields("No of Next of Kin");
                            nextofkin := ObjCust."No of Next of Kin";
                            // if nextofkin = 0 then begin

                            // end else
                            if nextofkin > 1 then begin
                                Nok.Reset();
                                Nok.SetRange(Nok."Account No", "Account No");
                                if Nok.FindSet() then begin
                                    // i:= 1;
                                    repeat
                                        // arrayofNames[i]:= Nok.Name;
                                        // listofNames.Insert(i, Nok.Name);
                                        // i:= i + 1;
                                        if Confirm('Next of Kin: %1', false, Nok.Name) = true then begin
                                            "Kin Name" := Nok.Name;
                                            "Kin ID No." := Nok."ID No.";
                                            Relationship := Nok.Relationship;
                                            "Kin Date of Birth" := Nok."Date of Birth";
                                            "%Allocation" := Nok."%Allocation";
                                            "%Allocation (New)" := Nok."%Allocation";
                                            "Kin Address" := Nok.Address;
                                            // "Kin Address(new)" := Nok.Address;
                                            "Next Of Kin Type" := Nok."Next Of Kin Type";
                                            Description := Nok.Description;
                                            "Kin Telephone" := Nok.Telephone;
                                            "Kin Email" := Nok.Email;
                                            "Kin No." := Nok."NoK No.";
                                            exit;
                                        end else begin
                                            // Message('Next');
                                        end;
                                    until Nok.Next() = 0;
                                    // Message(Format(listofNames));
                                end;
                            end else if nextofkin = 1 then begin
                                Nok.Reset();
                                Nok.SetRange(Nok."Account No", ObjCust."No.");
                                if Nok.FindSet() then begin
                                    // repeat
                                    "Kin Name" := Nok.Name;
                                    "Kin ID No." := Nok."ID No.";
                                    Relationship := Nok.Relationship;
                                    "Kin Date of Birth" := Nok."Date of Birth";
                                    "%Allocation" := Nok."%Allocation";
                                    "%Allocation (New)" := Nok."%Allocation";
                                    "Kin Address" := Nok.Address;
                                    // "Kin Address(new)" := Nok.Address;
                                    "Next Of Kin Type" := Nok."Next Of Kin Type";
                                    Description := Nok.Description;
                                    "Kin Telephone" := Nok.Telephone;
                                    "Kin Email" := Nok.Email;
                                    "Kin No." := nok."NoK No.";
                                    // until Nok.Next() = 0;
                                end;
                            end else if nextofkin = 0 then begin
                                Error('The member %1 has no next of kin information to change.', "Account No");
                            end;
                        end else if Selected = 1 then begin
                            "Kin Option" := 1;
                            Message('Ok');
                        end else begin
                            Message('None Selected');
                        end;
                    end;
                end;


                //Microfinance Change
                if Type = Type::"Microfinance Change" then begin
                    Memb.Reset;
                    Memb.SetRange(Memb."No.", "Account No");
                    if Memb.Find('-') then begin

                        Name := Memb.Name;
                        Branch := Memb."Global Dimension 2 Code";
                        Address := Memb.Address;
                        Email := Memb."E-Mail";
                        "Mobile No" := Memb."Mobile Phone No";
                        "ID No" := Memb."ID No.";
                        "Personal No" := Memb."Payroll No";
                        City := Memb.City;
                        Section := Memb.Section;
                        "Marital Status" := Memb."Marital Status";
                        "Monthly Contributions" := Memb."Monthly Contribution";
                        //"Signing Instructions":=Memb."Signing Instructions";
                        "Member Account Status" := Memb.Status;
                    end;
                end;
            end;
        }
        field(4; "Mobile No"; Code[50])
        {
        }
        field(5; Name; Text[40])
        {
        }
        field(6; "No. Series"; Code[30])
        {
        }
        field(7; Address; Code[150])
        {
        }
        field(8; Branch; Code[30])
        {
        }
        field(9; Picture; MediaSet)
        {
        }
        field(10; signinature; MediaSet)
        {
        }
        field(11; City; Code[30])
        {
        }
        field(12; "E-mail"; Code[100])
        {
        }
        field(13; "Personal No"; Code[30])
        {
        }
        field(14; "ID No"; Code[40])
        {
        }
        field(15; "Marital Status"; Option)
        {
            OptionCaption = 'Married,Single';
            OptionMembers = Married,Single;
        }
        field(16; "Passport No."; Code[30])
        {
        }
        field(17; Status; Option)
        {
            OptionCaption = 'Open,Pending,Approved,Rejected';
            OptionMembers = Open,Pending,Approved,Rejected;
        }
        field(18; "Account Type"; Code[30])
        {
        }
        field(19; "Account Category"; Option)
        {
            OptionCaption = 'Single,Joint,Corporate,Group,Parish,Church,Church Department,Staff';
            OptionMembers = Single,Joint,Corporate,Group,Parish,Church,"Church Department",Staff;
        }
        field(20; Email; Code[40])
        {
        }
        field(21; Section; Code[40])
        {
        }
        field(22; "Card No"; Code[30])
        {
        }
        field(23; "Home Address"; Code[100])
        {
        }
        field(24; Loaction; Code[20])
        {
        }
        field(25; "Sub-Location"; Code[30])
        {
        }
        field(26; District; Code[30])
        {
        }
        field(27; "Reason for change"; Text[50])
        {
        }
        field(28; "Signing Instructions"; Text[40])
        {
        }
        field(29; "S-Mobile No"; Code[20])
        {
        }
        field(30; "ATM Approve"; Code[30])
        {
        }
        field(31; "Card Expiry Date"; Date)
        {
        }
        field(32; "Card Valid From"; Date)
        {
        }
        field(33; "Card Valid To"; Date)
        {
        }
        field(34; "Date ATM Linked"; Date)
        {
        }
        field(35; "ATM No."; Code[16])
        {
        }
        field(36; "ATM Issued"; Boolean)
        {
        }
        field(37; "ATM Self Picked"; Boolean)
        {
        }
        field(38; "ATM Collector Name"; Code[30])
        {
        }
        field(39; "ATM Collectors ID"; Code[20])
        {
        }
        field(40; "Atm Collectors Moile"; Code[30])
        {
        }
        field(41; "Member Type."; Option)
        {
            OptionCaption = ' ,class A,class B';
            OptionMembers = " ","class A","class B";
        }
        field(42; "Monthly Contributions"; Decimal)
        {
        }
        field(43; "Captured by"; Code[50])
        {
            Editable = false;
        }
        field(44; "Capture Date"; Date)
        {
            Editable = false;
        }
        field(46; "Approved by"; Code[50])
        {
            Editable = false;
        }
        field(47; "Approval Date"; Date)
        {
            Editable = false;
        }
        field(48; Changed; Boolean)
        {
            Editable = false;
        }
        field(49; "Responsibility Centers"; Code[20])
        {
            TableRelation = "Responsibility Center";
        }
        field(50; "Member Cell Group"; Code[30])
        {
            TableRelation = "Hexa Binary";

            trigger OnValidate()
            begin
                if MemberCell.Get("Member Cell Group") then begin
                    // "Member Cell Name":=MemberCell."Cell Group Name";
                end;
            end;
        }
        field(51; "Member Cell Name"; Code[30])
        {
        }
        field(52; "Group Account No"; Code[30])
        {
            TableRelation = Customer."No." where("Group Account" = filter(true));
        }
        field(53; "Group Account Name"; Code[30])
        {
        }
        field(54; "Member Account Status"; Option)
        {
            OptionCaption = 'Active,Non-Active,Blocked,Dormant,Re-instated,Deceased,Withdrawal,Retired,Termination,Resigned,Ex-Company,Casuals,Family Member,Defaulter,Applicant,Rejected,New,Awaiting Withdrawal';
            OptionMembers = Active,"Non-Active",Blocked,Dormant,"Re-instated",Deceased,Withdrawal,Retired,Termination,Resigned,"Ex-Company",Casuals,"Family Member",Defaulter,Applicant,Rejected,New,"Awaiting Withdrawal";
        }
        field(55; "Mobile No(New Value)"; Code[50])
        {
            trigger OnValidate()
            var
                //Char: DotNet Char;
                i: Integer;
            begin

                //  if (StrLen("Mobile No(New Value)") <> 12) then
                //   Error('Mobile No. should be equal to  12 Characters');
            end;
        }
        field(56; "Name(New Value)"; Text[40])
        {
        }
        field(57; "No. Series(New Value)"; Code[30])
        {
        }
        field(58; "Address(New Value)"; Code[30])
        {
        }
        field(59; "Branch(New Value)"; Code[30])
        {
        }
        field(60; "Picture(New Value)"; Blob)
        {
            SubType = Bitmap;
        }
        field(61; "signinature(New Value)"; Blob)
        {
            SubType = Bitmap;
        }
        field(62; "City(New Value)"; Code[30])
        {
        }
        field(63; "E-mail(New Value)"; Code[250])
        {
        }
        field(64; "Personal No(New Value)"; Code[30])
        {
        }
        field(65; "ID No(New Value)"; Code[40])
        {
        }
        field(66; "Marital Status(New Value)"; Option)
        {
            OptionCaption = ' ,Single,Married,Devorced,Widower,Widow';
            OptionMembers = " ",Single,Married,Devorced,Widower,Widow;
        }
        field(67; "Passport No.(New Value)"; Code[30])
        {
        }
        field(68; "Status(New Value)"; Option)
        {
            OptionCaption = 'Open,Pending,Approved,Rejected';
            OptionMembers = Open,Pending,Approved,Rejected;
        }
        field(69; "Account Type(New Value)"; Code[30])
        {
        }
        field(70; "Account Category(New Value)"; Option)
        {
            OptionCaption = 'Single,Joint,Corporate,Group,Parish,Church,Church Department,Staff';
            OptionMembers = Single,Joint,Corporate,Group,Parish,Church,"Church Department",Staff;
        }
        field(71; "Email(New Value)"; Text[250])
        {
        }
        field(72; "Section(New Value)"; Code[40])
        {
        }
        field(73; "Card No(New Value)"; Code[30])
        {
        }
        field(74; "Home Address(New Value)"; Code[100])
        {
        }
        field(75; "Loaction(New Value)"; Code[20])
        {
        }
        field(76; "Sub-Location(New Value)"; Code[30])
        {
        }
        field(77; "District(New Value)"; Code[30])
        {
        }
        field(78; "Signing Instructions(NewValue)"; Text[40])
        {
        }
        field(79; "S-Mobile No(New Value)"; Code[40])
        {
            trigger OnValidate()
            var
                // Char: DotNet Char;
                i: Integer;
            begin

                if (StrLen("S-Mobile No(New Value)") <> 12) then
                    Error('Mobile No. should be equal to 12 Characters');
            end;
        }
        field(80; "ATM No.(New Value)"; Code[16])
        {
        }
        field(81; "Monthly Contributions(NewValu)"; Decimal)
        {
        }
        field(82; "Member Account Status(NewValu)"; Option)
        {
            OptionCaption = 'Active,Frozen,Closed,Archived,New,Dormant,Deceased';
            // OptionCaption = ' ,Active,Non-Active,Blocked,Dormant,Re-instated,Deceased,Withdrawn,Retired,Termination,Resigned,Ex-Company,Casuals,Family Member,Defaulter,Applicant,Rejected,New';
            OptionMembers = " ",Active,"Non-Active",Blocked,Dormant,"Re-instated",Deceased,Withdrawn,Retired,Termination,Resigned,"Ex-Company",Casuals,"Family Member",Defaulter,Applicant,Rejected,New;
        }
        field(83; "Charge Reactivation Fee"; Boolean)
        {
        }
        field(84; "Phone No.(Old)"; Code[20])
        {
        }
        field(85; "Phone No.(New)"; Code[20])
        {
        }
        field(86; Blocked; enum "Vendor Blocked")
        {
            // OptionCaption = ' ,Ship,Invoice,All';
            // OptionMembers = " ",Ship,Invoice,All;
        }
        field(87; "Blocked (New)"; enum "Vendor Blocked")
        {
            // OptionCaption = ' ,Ship,Invoice,All';
            // OptionMembers = " ",Ship,Invoice,All;
        }
        field(88; "Status (New Value)"; Option)
        {
            OptionCaption = 'Active,Frozen,Closed,Archived,New,Dormant,Deceased,Retired';
            OptionMembers = Active,Frozen,Closed,Archived,New,Dormant,Deceased,Retired;
        }
        field(89; "Employer Code"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(90; "Employer Code(New)"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Employers Register"."Employer Code";
        }
        field(91; "Status."; Option)
        {
            DataClassification = ToBeClassified;
            // OptionCaption = 'Active,Non-Active,Blocked,Dormant,Re-instated,Deceased,Withdrawal,Retired,Termination,Resigned,Ex-Company,Casuals,Family Member,Defaulter,Applicant,Rejected,New,Awaiting Withdrawal';
            // OptionMembers = Active,"Non-Active",Blocked,Dormant,"Re-instated",Deceased,Withdrawal,Retired,Termination,Resigned,"Ex-Company",Casuals,"Family Member",Defaulter,Applicant,Rejected,New,"Awaiting Withdrawal";

            //<Active,Non-Active,Blocked,Dormant,Re-instated,Deceased,Withdrawal,Retired,Termination,Resigned,Ex-Company,Casuals,Family Member,Defaulter,Awaiting Withdrawal,Closed>
            // OptionCaption = 'Active,Blocked,Dormant,"Re-instated",Deceased,Closed';
            // OptionMembers = Active,Blocked,Dormant,"Re-instated",Deceased,Closed;


            OptionCaption = 'Active,Frozen,Closed,Archived,Dormant,Deceased';
            //Active,Frozen,Closed,Archived,New,Dormant,Deceased
            OptionMembers = Active,Frozen,Closed,Archived,Dormant,Deceased;
        }
        field(92; "Status.(New)"; Option)
        {
            DataClassification = ToBeClassified;
            // OptionCaption = 'Active,Non-Active,Blocked,Dormant,Re-instated,Deceased,Withdrawal,Retired,Termination,Resigned,Ex-Company,Casuals,Family Member,Defaulter,Applicant,Rejected,New,Awaiting Withdrawal';
            // OptionMembers = Active,"Non-Active",Blocked,Dormant,"Re-instated",Deceased,Withdrawal,Retired,Termination,Resigned,"Ex-Company",Casuals,"Family Member",Defaulter,Applicant,Rejected,New,"Awaiting Withdrawal";

            //<Active,Non-Active,Blocked,Dormant,Re-instated,Deceased,Withdrawal,Retired,Termination,Resigned,Ex-Company,Casuals,Family Member,Defaulter,Awaiting Withdrawal,Closed>
            // OptionCaption = 'Active,Blocked,Dormant,"Re-instated",Deceased,Closed';
            // OptionMembers = Active,Blocked,Dormant,"Re-instated",Deceased,Closed;


            OptionCaption = 'Active,Frozen,Closed,Archived,Dormant,Deceased';
            //Active,Frozen,Closed,Archived,New,Dormant,Deceased
            OptionMembers = Active,Frozen,Closed,Archived,Dormant,Deceased;
            trigger OnValidate()
            begin
                vend.Reset();
                vend.SetRange("No.", "Account No");
                if vend.Find('-') then begin
                    if "Status.(New)" = "Status.(New)"::Closed then begin
                        if vend.GetAvailableBalance() <> 0 then Error('The account still has an available balance of %1.', vend.GetAvailableBalance());
                    end;
                end;
            end;
        }
        field(93; "Retirement Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(94; "Retirement Date(New)"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(95; "Date Of Birth"; Date)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if "Date Of Birth" <> 0D then begin
                    Age := Dates.DetermineAge("Date Of Birth", Today);
                end;
            end;
        }
        field(96; Disabled; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(97; "Occupation(New)"; Code[40])
        {
            DataClassification = ToBeClassified;
        }
        field(98; Occupation; Code[40])
        {
            DataClassification = ToBeClassified;
        }
        field(99; "Bank Code(Old)"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Banks."Bank Code";

            trigger OnValidate()
            var
                Banks: Record Banks;
            begin

                /*Banks.RESET;
                Banks.SETRANGE(Banks.Code,"Bank Code");
                IF Banks.FIND('-') THEN
                  "Bank Name":=Banks."Bank Name";*/

            end;
        }
        field(100; "Bank Code(New)"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Banks."Bank Code";

            trigger OnValidate()
            var
                Banks: Record Banks;
            begin

                Banks.Reset;
                Banks.SetRange(Banks."Bank Code", "Bank Code(New)");
                if Banks.Find('-') then
                    "Bank Name (New)" := Banks."Bank Name";
            end;
        }
        field(101; "Bank Account No(Old)"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(102; "Bank Account No(New)"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(103; "KRA Pin(Old)"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(104; "KRA Pin(New)"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(105; Age; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(106; Gender; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Male,Female';
            OptionMembers = " ",Male,Female;
        }
        field(107; "Bank Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(108; "Bank Name (New)"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(109; "Bank Branch Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(110; "Bank Branch Name(New)"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(111; "Bank Branch Code"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(112; "Bank Branch Code(New)"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Bank Branch"."Branch No";

            trigger OnValidate()
            begin
                Bankbranch.Reset;
                Bankbranch.SetRange(Bankbranch."Branch No", "Bank Branch Code(New)");
                if Bankbranch.Find('-') then
                    "Bank Branch Name(New)" := Bankbranch."Branch Name";
            end;
        }
        field(113; "Post Code"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(114; "Post Code (New)"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Post Code".Code;

            trigger OnValidate()
            begin
                PostCodes.Reset;
                PostCodes.SetRange(PostCodes.Code, "Post Code (New)");
                if PostCodes.Find('-') then
                    "City(New Value)" := PostCodes.City;
            end;
        }
        field(69227; "Designation Code(New)"; Code[100])
        {
            DataClassification = ToBeClassified;
            // TableRelation = Designation.Designation;
        }
        field(69228; "Designation"; Code[100])
        {
            DataClassification = ToBeClassified;
            // TableRelation = Designation.Designation;
        }
        field(69229; "Workstation Code(New)"; Code[40])
        {
            DataClassification = ToBeClassified;
            // TableRelation = WorkStations.Code;
        }
        field(69230; "Workstation"; Code[40])
        {
            DataClassification = ToBeClassified;
            TableRelation = WorkStations.Code;
        }
        field(69226; "Religion."; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = ,Christians,Muslims,Jews,"Religiously Unaffiliated",Hindus,Buddhists,"Other Religions";
            OptionCaption = ',Christians,Muslims,Jews,Religiously Unaffiliated,Hindus,Buddhists,Other Religions';

        }
        field(115; "Member Type"; Option)
        {
            OptionMembers = Member,Staff,Board,"Station Representative";
            OptionCaption = 'Member,Staff,Board,Station Representative';
            Editable = false;
        }

        field(116; "Member Type(New Value)"; Option)
        {
            OptionMembers = " ",Member,Staff,Board,"Station Representative";
            OptionCaption = ' ,Member,Staff,Board,Station Representative';
            trigger OnValidate()
            begin
                if "Member Type(New Value)" = "Member Type(New Value)"::Board then begin
                    "Insider Status (New)" := "Insider Status (New)"::"Board Member";
                end else if "Member Type(New Value)" = "Member Type(New Value)"::Staff then begin
                    "Insider Status (New)" := "Insider Status (New)"::"Staff Member";
                end else if "Member Type(New Value)" = "Member Type(New Value)"::"Station Representative" then begin
                    "Insider Status (New)" := "Insider Status (New)"::"Delegate Member";
                end else if "Member Type(New Value)" = "Member Type(New Value)"::Member then begin
                    "Insider Status (New)" := "Insider Status (New)"::" ";
                end;
            end;
        }

        field(117; "Exempted From Tax"; Boolean)
        {

        }
        field(118; "Exempted From Tax(New Value)"; Boolean)
        {

        }
        field(119; "Sub-county"; Code[100])
        {

        }
        field(120; "Sub-county(New Value)"; Code[100])
        {

        }
        field(121; "Area"; Code[100])
        {

        }

        field(122; "Area(New Value)"; Code[100])
        {

        }
        field(123; "Work E-Mail"; Code[100])
        {

        }
        field(124; "Work E-Mail(New Value)"; Code[100])
        {

        }

        field(125; "Nearest Landmark"; Text[100])
        {

        }

        field(126; "Nearest Landmark(New Value)"; Text[100])
        {

        }
        field(127; "Mode Of Remmittance"; Option)
        {
            OptionCaption = ',Checkoff,Standing Order,Cash,M-Pesa,Direct Debit';
            OptionMembers = ,Checkoff,"Standing Order",Cash,"M-Pesa","Direct Debit";
        }

        field(128; "Mode Of Remmittance(New Value)"; Option)
        {
            OptionCaption = ',Checkoff,Standing Order,Cash,M-Pesa,Direct Debit';
            OptionMembers = ,Checkoff,"Standing Order",Cash,"M-Pesa","Direct Debit";
        }

        field(129; "County"; Code[100])
        {

        }

        field(130; "County(New Value)"; Code[100])
        {

        }

        field(131; "Religion"; Text[120])
        {
            DataClassification = ToBeClassified;


        }
        field(132; "FOSA Account No"; code[120])
        {
            DataClassification = ToBeClassified;
        }

        field(133; "Child DOB Old"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;

        }

        field(134; "Child DOB New"; Date)
        {
            DataClassification = ToBeClassified;


        }

        field(135; "Child Name Old"; Text[200])
        {
            DataClassification = ToBeClassified;

            Editable = false;

        }

        field(136; "Child Name New"; Text[200])
        {
            DataClassification = ToBeClassified;


        }
        field(137; "Childs Gender Old"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Male,Female';
            OptionMembers = " ",Male,Female;
            Editable = false;
        }
        field(138; "Childs Gender New"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Male,Female';
            OptionMembers = " ",Male,Female;
        }

        field(139; "Amount Of Remmitance Old"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;

        }


        field(140; "Amount Of Remmitance New"; Decimal)
        {
            DataClassification = ToBeClassified;


        }
        field(141; "Mode Of Remmittance F"; Option)
        {
            OptionCaption = ',Checkoff,Standing Order,Cash,M-Pesa,Direct Debit';
            OptionMembers = ,Checkoff,"Standing Order",Cash,"M-Pesa","Direct Debit";
        }

        field(142; "Mode Of Remmittance F(New)"; Option)
        {
            OptionCaption = ',Checkoff,Standing Order,Cash,M-Pesa,Direct Debit';
            OptionMembers = ,Checkoff,"Standing Order",Cash,"M-Pesa","Direct Debit";
        }

        field(143; "Birth Certificate No Old"; Code[200])
        {
            DataClassification = ToBeClassified;
            Editable = false;

        }


        field(144; "Birth Certificate No New"; Code[200])
        {
            DataClassification = ToBeClassified;


        }

        field(145; "ID Front"; MediaSet)
        {
        }
        field(146; "ID Back"; MediaSet)
        {
        }
        field(147; KinAge; Text[50])
        {
        }
        field(148; "KinAge(New)"; Text[50])
        {
        }
        field(149; "Membership Status"; Option)
        {
            OptionCaption = 'Active,Deceased,Retired,Dormant,Awaiting Exit,Exited,Fully Exited,Re-instated,Closed';
            OptionMembers = Active,Deceased,Retired,Dormant,"Awaiting Exit",Exited,"Fully Exited","Re-instated",Closed;
        }
        field(150; "Membership Status(New)"; Option)
        {
            OptionCaption = 'Active,Deceased,Retired,Dormant,Awaiting Exit,Exited,Fully Exited,Re-instated,Closed';
            OptionMembers = Active,Deceased,Retired,Dormant,"Awaiting Exit",Exited,"Fully Exited","Re-instated",Closed;
        }
        field(151; "Customer Service Rep"; Code[20])
        { }
        field(152; "New Customer Service Rep"; Code[20])
        {
            TableRelation = "HR Employees"."No.";
        }
        field(153; "Sales Rep"; Code[20])
        { }
        field(154; "New Sales Rep"; Code[20])
        {
            TableRelation = "HR Employees"."No.";
        }
        field(200; "Kin Name"; Text[150])
        {
            NotBlank = true;
        }
        field(201; "Kin Name(new)"; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(300; Relationship; Text[30])
        {
            NotBlank = true;
            TableRelation = "Relationship Types";
        }
        field(301; "Relationship (New)"; Text[30])
        {
            TableRelation = "Relationship Types".code;
        }
        field(400; Beneficiary; Boolean)
        {
        }
        field(401; "Insider Status"; Option)
        {
            OptionCaption = ' ,Board Member,Staff Member,Delegate Member,Regular Member';
            OptionMembers = " ","Board Member","Staff Member","Delegate Member","Regular Member";
        }
        field(402; "Insider Status (New)"; Option)
        {
            OptionCaption = ' ,Board Member,Staff Member,Delegate Member,Regular Member';
            OptionMembers = " ","Board Member","Staff Member","Delegate Member","Regular Member";
            Editable = false;
        }
        field(500; "Kin Date of Birth"; Date)
        {

            trigger OnValidate()
            begin
                KinAge := Dates.DetermineAge("Kin Date of Birth", Today);
            end;
        }
        field(501; "Kin Date of Birth (new)"; Date)
        {

            trigger OnValidate()
            begin
                if "Kin Date of Birth (new)" > Today then begin
                    Error('The date of birth cannot be in the future.');
                end;
                "KinAge(New)" := Dates.DetermineAge("Kin Date of Birth (new)", Today);

                calcAge := (Today - "Kin Date of Birth (new)") / 365;
                // Message('%1',calcAge);
                if (calcAge < 18) and ("Kin ID No.(New)" <> '') then begin
                    // Clear("ID No.");
                    // Clear("Date of Birth");
                    // Clear(Age);
                    Error('The %1 has an age of %2 thus cannot have an ID No.', "Relationship (New)", "KinAge(New)");
                end;
            end;
        }
        field(600; "Kin Address"; Text[80])
        {
        }
        field(601; "Kin Address(new)"; Text[80])
        {
            DataClassification = ToBeClassified;
        }
        field(700; "Kin Telephone"; Code[50])
        {
        }
        field(701; "Kin Telephone(New)"; Code[50])
        {
            trigger OnValidate()
            var
                // Char: DotNet Char;
                i: Integer;
                PhoneNoCannotContainLettersErr: Label 'Phone number must not contain letters.';
            begin


                if (StrLen("Kin Telephone(New)") <> 12) then
                    Error('Mobile No. cannot be less than 12 digits');
            end;
        }
        field(800; Fax; Code[10])
        {
        }
        field(810; "Kin No."; Integer)
        {
        }
        field(811; "Kin Option"; Integer)
        {
        }

        field(812; "Business Name(Store)"; Code[80])
        {
        }
        field(813; "Business Name(Store) New"; Code[80])
        {
        }
        field(814; "Business Short Code(Store)"; Code[70])
        {
        }
        field(815; "Business Short Code(Store) New"; Code[70])
        {
        }
        field(816; "Business Type(Store)"; Code[70])
        {
        }
        field(817; "Business Type(Store) New"; Code[70])
        {
        }
        field(818; "Business Status(Store)"; Option)
        {
            OptionCaption = ' ,Active,Dormant';
            OptionMembers = " ",Active,Dormant;
        }
        field(819; "Business Status(Store) New"; Option)
        {
            OptionCaption = ' ,Active,Dormant';
            OptionMembers = " ",Active,Dormant;
        }
        field(820; "Business Location(Store)"; Code[80])
        {
        }
        field(821; "Business Location(Store) New"; Code[80])
        {
        }
        field(822; "Business Contact(Store)"; Code[80])
        {
        }
        field(823; "Business Contact(Store) New"; Code[80])
        {
        }
        field(824; "Business Email(Store)"; Code[80])
        {
        }
        field(825; "Business Email(Store) New"; Code[80])
        {
        }
        field(826; "Business Phone(Store)"; Code[80])
        {
        }
        field(827; "Business Phone(Store) New"; Code[80])
        {
        }
        field(828; "Business Website(Store)"; Text[500])
        {
        }
        field(829; "Business Website(Store) New"; Text[500])
        {
        }
        field(830; "Business Description(Store)"; Text[500])
        {
        }
        field(831; "Business Description New"; Text[500])
        {
        }

        field(900; "Kin Email"; Text[30])
        {
        }
        field(901; "Kin Email(New)"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(1100; "Kin ID No."; Code[50])
        {
        }
        field(1101; "Kin ID No.(New)"; Code[50])
        {
            trigger OnValidate()
            begin
                if "Kin Date of Birth (new)" <> 0D then begin
                    calcAge := (Today - "Kin Date of Birth (new)") / 365;
                    // Message('%1',calcAge);
                    if (calcAge < 18) and ("Kin ID No.(New)" <> '') then begin
                        // Clear("ID No.");
                        // Clear("Date of Birth");
                        // Clear(Age);
                        Error('The %1 has an age of %2 thus cannot have an ID No.', "Relationship (New)", "KinAge(New)");
                    end;
                end;

                if (StrLen("Kin ID No.(New)") < 5) or (StrLen("Kin ID No.(New)") > 10) then begin
                    Error('ID number cannot be less than 5 Characters or more than 10 characters.');
                end;
            end;
        }
        field(1200; "%Allocation"; Decimal)
        {
            Editable = false;
            trigger OnValidate()
            begin
                "Maximun Allocation %" := 100;
                Modify;
                CalcFields("Total Allocation");
                if ("Total Allocation" > 100) then
                    Error('% Allocation cannot be more than 100');
            end;
        }
        field(1201; "%Allocation (New)"; Decimal)
        {
            trigger OnValidate()
            begin
                if "Kin Option" = 1 then begin//Add New
                    if ObjCust.Get("Account No") then begin
                        ObjCust.CalcFields("No of Next of Kin");
                        if ObjCust."No of Next of Kin" = 1 then begin
                            Nok.Reset();
                            Nok.SetRange(Nok."Account No", "Account No");
                            if Nok.Find('-') then begin
                                if Nok."%Allocation" + rec."%Allocation (New)" <> 100 then begin
                                    Nok."%Allocation" := 100 - rec."%Allocation (New)";
                                    Nok.modify;
                                end;
                            end;
                        end;
                        // if ObjCust."No of Next of Kin" >= 1 then begin
                        //     Nok.Reset();
                        //     Nok.SetRange(Nok."Account No", "Account No");
                        //     if Nok.FindSet() then begin
                        //         Message('Choose which next of kin''s % allocation will be affected');
                        //         repeat
                        //             if Confirm('Next of Kin: %1', false, Nok.Name) = true then begin
                        //                 "Allocated Nok %" := Nok."%Allocation";
                        //                 "Allocated Nok No" := Nok."NoK No.";
                        //                 exit;
                        //             end else begin
                        //                 // Message('Next');
                        //             end;
                        //         until Nok.Next() = 0;
                        //         if "Allocated Nok %" > "%Allocation (New)" then Error('The inputted % allocation cannot be greater than that of the nok you selected.');
                        //         "New Allocated Nok %":=(Nok."Total Allocation" - "%Allocation (New)");
                        //     end;
                        // end;
                    end;
                end else if "Kin Option" = 2 then begin//Update existing 
                    if ObjCust.Get("Account No") then begin
                        ObjCust.CalcFields("No of Next of Kin");
                        if ObjCust."No of Next of Kin" = 1 then begin
                            Nok.Reset();
                            Nok.SetRange(Nok."Account No", "Account No");
                            if Nok.Find('-') then begin
                                if Nok."%Allocation" + rec."%Allocation (New)" <> 100 then begin
                                    Nok."%Allocation" := 100 - rec."%Allocation (New)";
                                    Nok.modify;
                                end;
                            end;
                        end;
                    end;
                end else if "Kin Option" = 3 then begin//Replace Existing
                    if ObjCust.Get("Account No") then begin
                        ObjCust.CalcFields("No of Next of Kin");
                        if ObjCust."No of Next of Kin" = 1 then begin
                            Nok.Reset();
                            Nok.SetRange(Nok."Account No", "Account No");
                            if Nok.Find('-') then begin
                                if Nok."%Allocation" + rec."%Allocation (New)" <> 100 then begin
                                    Nok."%Allocation" := 100 - rec."%Allocation (New)";
                                    Nok.modify;
                                end;
                            end;
                        end;
                    end;
                end;
            end;

        }
        field(1300; "Total Allocation"; Decimal)
        {
            CalcFormula = sum("Members Next of Kin"."%Allocation" where("Account No" = field("Account No")));
            FieldClass = FlowField;
        }
        field(1400; "Maximun Allocation %"; Decimal)
        {
        }
        field(1600; Description; Text[50])
        {
        }
        field(1601; "Description (new)"; Text[50])
        {
        }
        field(1700; "Next Of Kin Type"; Option)
        {
            OptionCaption = ' ,Beneficiary,Next of Kin';
            OptionMembers = " ",Beneficiary,"Next of Kin";
        }
        field(1701; "Next Of Kin Type (new)"; Option)
        {
            OptionCaption = ' ,Beneficiary,Next of Kin';
            OptionMembers = " ",Beneficiary,"Next of Kin";
        }
        field(1800; "Member No"; Code[20])
        {
            TableRelation = Customer."No." where(ISNormalMember = filter(true));

            trigger OnValidate()
            begin
                IF ObjCust.GET("Member No") THEN BEGIN
                    "Member Name" := ObjCust.Name;
                END;
            end;
        }
        field(3000; "Member Name"; Code[50])
        {
        }
        field(1901; "Document No"; Code[20])
        {
        }





    }

    keys
    {
        key(Key1; No)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin


        if No = '' then begin
            SalesSetup.Get;
            SalesSetup.TestField(SalesSetup."Change Request No");
            No:=NoSeriesMgt.GetNextNo(SalesSetup."Change Request No");
        end;

        "Captured by" := UserId;
        "Capture Date" := Today;
    end;

    var
        ObjCust: Record Customer;
        Options: Text[250];
        calcAge: Decimal;
        Selected: Integer;
        Text000: Label 'Create New Next of Kin,Update Existing Next of Kin,Replace Existing Next of Kin,Remove Existing Next of Kin';
        Text001: Label 'You selected option %1.';
        Text002: Label 'Choose one of the following next of kin change options:';
        nextofkin: Integer;
        Nok: Record "Members Next of Kin";
        SalesSetup: Record "Sacco No. Series";
        NoSeriesMgt: Codeunit "No. Series";
        vend: Record Vendor;
        Memb: Record Customer;
        MemberCell: Record "Hexa Binary";
        MediaId: Guid;
        Dates: Codeunit "Dates Calculation";
        MemmberExit: Record "Membership Exist";
        Bankbranch: Record "Bank Branch";
        PostCodes: Record "Post Code";
}




