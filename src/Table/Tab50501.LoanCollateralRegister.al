//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50501 "Loan Collateral Register"
{
    //nownPage51516558;
    //nownPage51516558;

    fields
    {
        field(1; "Document No"; Code[20])
        {

            trigger OnValidate()
            begin
                if "Document No" <> xRec."Document No" then begin
                    SalesSetup.Get;
                    NoSeriesmgt.TestManual(SalesSetup."Collateral Register No");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "Registered Owner"; Code[100])
        {
        }
        field(3; "Member No."; Code[30])
        {
            TableRelation = Customer."No." wherE(ISNormalMember = filter(true));

            trigger OnValidate()
            begin
                if Members.Get("Member No.") then begin
                    "Member Name" := Members.Name;
                    "ID No." := Members."ID No.";
                    "Charge Account" := Members."FOSA Account No.";
                end;
            end;
        }
        field(4; "Member Name"; Code[100])
        {
        }
        field(5; "ID No."; Code[100])
        {
        }
        field(6; "Collateral Type."; Option)
        {
            OptionMembers = Cash;
        }
        field(7; "Collateral Description"; Text[250])
        {
        }
        field(8; "Date Received"; Date)
        {
            Editable = false;
            trigger OnValidate()
            begin
                "Received By" := UserId;
            end;
        }
        field(9; "Received By"; Code[20])
        {
            Editable = false;
        }
        field(10; "Date Released"; Date)
        {
        }
        field(11; "Released By"; Code[20])
        {
        }
        field(12; Picture; Blob)
        {
            SubType = Bitmap;
        }
        field(13; "No. Series"; Code[20])
        {
        }
        field(14; "Registration/Reference No"; Code[50])
        {
        }
        field(15; "Search No"; Code[50])
        {
        }
        field(16; "Valuer Name"; Code[100])
        {
        }
        field(17; "IR No"; Code[1200])
        {
        }
        field(18; "Chasis No"; Code[50])
        {
        }
        field(19; "Valuer Address"; Code[100])
        {
        }
        field(20; "Valuer Phone No"; Code[20])
        {
        }
        field(21; "Land Location"; Code[20])
        {
        }
        field(22; "Insurance Effective Date"; Date)
        {
            Caption = 'Effective Date';
        }
        field(23; "Insurance Expiration Date"; Date)
        {
            Caption = 'Expiration Date';
        }
        field(24; "Insurance Policy No."; Text[30])
        {
            Caption = 'Policy No.';
        }
        field(25; "Insurance Annual Premium"; Decimal)
        {
            AutoFormatType = 1;
            BlankZero = true;
            Caption = 'Annual Premium';
            MinValue = 0;
        }
        field(26; "Policy Coverage"; Decimal)
        {
            AutoFormatType = 1;
            BlankZero = true;
            Caption = 'Policy Coverage';
            MinValue = 0;
        }
        field(27; "Total Value Insured"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Total Value Insured';
        }
        field(28; Comment; Boolean)
        {
            Caption = 'Comment';
        }
        field(29; "Insurance Type"; Code[10])
        {
            Caption = 'Insurance Type';
            TableRelation = "Insurance Type";
        }
        field(31; "Insurance Vendor No."; Code[20])
        {
            Caption = 'Insurance Vendor No.';
            TableRelation = Vendor where("Insurance Company" = filter(true));

            trigger OnValidate()
            begin
                if ObjAccount.Get("Insurance Vendor No.") then
                    "Insurance Vendor Name" := ObjAccount.Name;
            end;
        }
        field(32; "Asset Value"; Decimal)
        {
        }
        field(33; "Depreciation Completion Date"; Date)
        {
        }
        field(34; "Asset Depreciation Amount"; Decimal)
        {
            CalcFormula = sum("Collateral Depr Register"."Depreciation Amount" where("Document No" = field("Document No")));
            FieldClass = FlowField;
        }
        field(35; "Asset Value @Loan Completion"; Decimal)
        {
            CalcFormula = min("Collateral Depr Register"."Collateral NBV" where("Document No" = field("Document No")));
            FieldClass = FlowField;
        }
        field(36; "Depreciation Percentage"; Decimal)
        {
        }
        field(37; "Collateral Posting Group"; Code[20])
        {
            TableRelation = "FA Posting Group".Code;

            trigger OnValidate()
            begin
                ObjFAPostingGroup.Reset;
                ObjFAPostingGroup.SetRange(ObjFAPostingGroup.Code, "Collateral Posting Group");
                if ObjFAPostingGroup.FindSet then begin
                    "Collateral Depreciation Method" := ObjFAPostingGroup."Depreciation Method";
                    "Depreciation Percentage" := ObjFAPostingGroup."Depreciation %";
                end;
            end;
        }
        field(38; "Collateral Depreciation Method"; Option)
        {
            OptionCaption = 'Straight-Line,Declining-Balance 1,Declining-Balance 2,DB1/SL,DB2/SL,User-Defined,Manual';
            OptionMembers = "Straight-Line","Declining-Balance 1","Declining-Balance 2","DB1/SL","DB2/SL","User-Defined",Manual;
        }
        field(39; "Action"; Option)
        {
            OptionCaption = ' ,Receive at HQ,Lodge to Strong Room,Retrieve From Strong Room,Issue to Lawyer,Issue to Insurance Agent,Release to Member,Dispatch to Branch,Receive at Branch,Receive From Lawyer,Issue to Auctioneer,Booked to Safe Custody';
            OptionMembers = " ","Receive at HQ","Lodge to Strong Room","Retrieve From Strong Room","Issue to Lawyer","Issue to Insurance Agent","Release to Member","Dispatch to Branch","Receive at Branch","Receive From Lawyer","Issue to Auctioneer","Booked to Safe Custody";

            trigger OnValidate()
            begin
                if Confirm('Are you sure you want to' + Format(Action) + ' this Collateral', false) = true then begin

                    if Action = Action::"Receive at HQ" then begin
                        "Received to HQ By" := UserId;
                        "Received to HQ On" := Today;
                        FnUpdateCollateralMovement(Action::"Receive at HQ", Today, UserId, "Document No");
                    end;
                    if (Action = Action::"Dispatch to Branch") then begin
                        "Dispatched to Branch By" := UserId;
                        "Dispatched to Branch On" := Today;
                        FnUpdateCollateralMovement(Action::"Dispatch to Branch", Today, UserId, "Document No");
                    end;
                    if (Action = Action::"Receive at Branch") then begin
                        "Received at Branch By" := UserId;
                        "Received at Branch On" := Today;
                        FnUpdateCollateralMovement(Action::"Receive at Branch", Today, UserId, "Document No");
                    end;
                    if (Action = Action::"Issue to Lawyer") then begin
                        "Issued to Lawyer By" := UserId;
                        "Issued to Lawyer On" := Today;
                        FnUpdateCollateralMovement(Action::"Issue to Lawyer", Today, UserId, "Document No");
                    end;
                    if (Action = Action::"Receive From Lawyer") then begin
                        "Received From Lawyer By" := UserId;
                        "Received From Lawyer On" := Today;
                        FnUpdateCollateralMovement(Action::"Receive From Lawyer", Today, UserId, "Document No");
                    end;
                    if Action = Action::"Issue to Auctioneer" then begin
                        "Issued to Auctioneer By" := UserId;
                        "Issued to Auctioneer On" := Today;
                        FnUpdateCollateralMovement(Action::"Issue to Auctioneer", Today, UserId, "Document No");
                    end;
                    if Action = Action::"Issue to Insurance Agent" then begin
                        "Issued to Insurance Agent By" := UserId;
                        "Issued to Insurance Agent On" := Today;
                        FnUpdateCollateralMovement(Action::"Issue to Insurance Agent", Today, UserId, "Document No");
                    end;
                    if Action = Action::"Release to Member" then begin
                        "Released to Member By" := UserId;
                        "Released to Member on" := Today;
                        FnUpdateCollateralMovement(Action::"Release to Member", Today, UserId, "Document No");
                    end;
                    if Action = Action::"Retrieve From Strong Room" then begin
                        "Retrieved From Strong Room By" := UserId;
                        "Retrieved From Strong Room On" := Today;
                        FnUpdateCollateralMovement(Action::"Retrieve From Strong Room", Today, UserId, "Document No");
                    end;
                end;
            end;
        }
        field(40; "Received to HQ By"; Code[20])
        {
        }
        field(41; "Received to HQ On"; Date)
        {
        }
        field(42; "Lodged to Strong Room By"; Code[20])
        {
        }
        field(43; "Lodged to Strong Room On"; Date)
        {
        }
        field(44; "Retrieved From Strong Room By"; Code[20])
        {
        }
        field(45; "Retrieved From Strong Room On"; Date)
        {
        }
        field(46; "Issued to Lawyer By"; Code[20])
        {
        }
        field(47; "Issued to Lawyer On"; Date)
        {
        }
        field(48; "Lawyer Code"; Code[20])
        {
            TableRelation = Vendor."No." where("Sacco Lawyer" = filter(true));

            trigger OnValidate()
            begin
                if ObjAccount.Get("Lawyer Code") then begin
                    "Lawyer Name" := ObjAccount.Name;
                end;
            end;
        }
        field(49; "Lawyer Name"; Code[50])
        {
        }
        field(50; "Issued to Insurance Agent By"; Code[20])
        {
        }
        field(51; "Issued to Insurance Agent On"; Date)
        {
        }
        field(52; "Insurance Agent Code"; Code[20])
        {
        }
        field(53; "Insurance Agent Name"; Code[50])
        {
        }
        field(54; "Released to Member By"; Code[20])
        {
        }
        field(55; "Released to Member on"; Date)
        {
        }
        field(56; "Dispatched to Branch By"; Code[20])
        {
        }
        field(57; "Dispatched to Branch On"; Date)
        {
        }
        field(58; "Dispatch to Branch"; Code[20])
        {
            TableRelation = "Dimension Value".Code where("Global Dimension No." = filter(2));
        }
        field(59; "Received at Branch By"; Code[20])
        {
        }
        field(60; "Received at Branch On"; Date)
        {
        }
        field(61; "Received From Lawyer By"; Code[20])
        {
        }
        field(62; "Received From Lawyer On"; Date)
        {
        }
        field(63; "Issued to Auctioneer By"; Code[20])
        {
        }
        field(64; "Issued to Auctioneer On"; Date)
        {
        }
        field(65; "Booked to Safe Custody By"; Code[20])
        {
        }
        field(66; "Booked to Safe Custody On"; Date)
        {
        }
        field(67; "Last Collateral Action"; Code[50])
        {
        }
        field(68; "Lodged By(Custodian 1)"; Code[20])
        {
        }
        field(69; "Lodged By(Custodian 2)"; Code[20])
        {
        }
        field(70; "Date Lodged"; Date)
        {
        }
        field(71; "Time Lodged"; Time)
        {
        }
        field(72; "Released By(Custodian 1)"; Code[20])
        {
        }
        field(73; "Released By(Custodian 2)"; Code[20])
        {
        }
        field(74; "Date Released from SafeCustody"; Date)
        {
        }
        field(75; "Time Released from SafeCustody"; Time)
        {
        }
        field(76; "Charge Account"; Code[20])
        {
            TableRelation = Vendor."No." where("BOSA Account No" = field("Member No."));
        }
        field(77; "Package Type"; Code[20])
        {
            TableRelation = "Package Types".Code;
        }
        field(78; "Last Collateral Action Entry"; Code[20])
        {
            CalcFormula = max("Collateral Movement  Register"."Document No" where("Collateral ID" = field("Document No"),
                                                                                   "Action Type" = filter(<> '')));
            FieldClass = FlowField;
        }
        field(79; "Insurance Vendor Name"; Code[100])
        {
            Caption = 'Insurance Vendor No.';
            TableRelation = Vendor where("Insurance Company" = filter(true));
        }
        field(80; "Collateral Code"; Code[20])
        {
            NotBlank = true;
            TableRelation = "Loan Collateral Set-up".Code;

            trigger OnValidate()
            begin
                ObjCollateraltypes.Reset;
                ObjCollateraltypes.SetRange(ObjCollateraltypes.Code, "Collateral Code");
                if ObjCollateraltypes.FindSet then begin
                    "Collateral Type" := ObjCollateraltypes.Type;
                    "CollateralSecurity Description" := ObjCollateraltypes."Security Description";
                    "Collateral Multiplier" := ObjCollateraltypes."Value Considered";
                    "Percentage Value" := ObjCollateraltypes."Value Considered";
                    "Collateral Category" := ObjCollateraltypes.Category;
                    "Collateral Security" := ObjCollateraltypes.Security;
                    "Collateral Posting Group" := ObjCollateraltypes."Collateral Posting Group";
                    Validate("Collateral Posting Group");
                end;
            end;
        }
        field(81; "Collateral Type"; Option)
        {
            //Editable = false;
            NotBlank = true;
            //Caption = 'Security Type';
            OptionCaption = ' ,Developed,Vacant,Savings';
            OptionMembers = " ",Developed,Vacant,Savings;
        }
        field(82; "CollateralSecurity Description"; Text[50])
        {
            // Editable = false;
            Caption = 'Security Description';
        }
        field(83; "Collateral Category"; Option)
        {
            Editable = false;
            OptionCaption = ' ,Urban,Peri-Urban,Town Centers';
            OptionMembers = " ","Urban","Peri-Urban","Town Centers";
        }
        field(84; "Collateral Multiplier"; Decimal)
        {
            Editable = false;

            trigger OnValidate()
            begin
                //"Guarantee Value":="Collateral Multiplier"*0.7;
            end;
        }
        field(85; "Market Value"; Decimal)
        {
            trigger OnValidate()
            begin
                //"Guaranteed Amount" := ("Percentage Value" * "Market Value");
            end;
        }
        field(96; "Percentage Value"; Decimal)
        {
            Editable = false;
            trigger OnValidate()
            begin
                //  "Forced Sale Value" := 0;
                //  "Market Value" := 0;
            end;
        }
        field(86; "Forced Sale Value"; Decimal)
        {
            trigger OnValidate()
            begin
                "Guaranteed Amount" := ("Percentage Value" * "Forced Sale Value");
            end;
        }
        field(97; "Guaranteed Amount"; Decimal)
        {
        }
        field(87; "Last Valued On"; Date)
        {
        }
        field(88; "File No"; Code[50])
        {
        }
        field(89; "Released to"; Text[50])
        {
        }
        field(90; "Collateral Registered"; Boolean)
        {
        }
        field(91; "Collateral Security"; Option)
        {
            Editable = false;
            InitValue = "Title Deed";
            OptionCaption = ' ,Log BooK,Title Deed';
            OptionMembers = " ","Log BooK","Title Deed";
        }
        field(92; "Date Bonded"; Date)
        {
        }
        field(93; "Bonded By"; Code[20])
        {
        }
        field(94; Bonded; Boolean)
        { }
        field(95; "Land Size"; Code[20])
        {
            InitValue = ' Ha';
        }
        field(98; "Security Description"; Option)
        {
            //Editable = false;
            OptionCaption = ' ,Bungalow,Mansionatte,Apartment,Vacant,Commercial Unit,Savings';
            OptionMembers = " ",Bungalow,Mansionatte,Apartment,Vacant,"Commercial Unit",Savings;
        }

        field(99; "KRA Pin"; Code[80])
        {
        }
        field(100; "ID No"; Code[80])
        {
        }
        field(101; "Location"; Code[80])
        {
        }
        field(102; "Location Description"; Text[1500])
        {
        }
        field(103; "Owner Phone No"; Code[40])
        {
        }
        field(104; "Owner E-mail"; Text[150])
        {
        }
        field(105; "Owner Location"; Code[200])
        {
        }
        field(106; "Security Type"; Option)
        {
            Editable = false;
            NotBlank = true;
            //Caption = 'Security Type';
            OptionCaption = ' ,Lease Hold,Free Hold';
            OptionMembers = " ","Lease Hold","Free Hold";
        }
        field(107; "Property Status"; Option)
        {
            Editable = false;
            NotBlank = true;
            //Caption = 'Security Type';
            OptionCaption = 'Developed,Undeveloped';
            OptionMembers = " ","Developed","Undeveloped";
        }
        field(108; "Property Type"; Option)
        {

            NotBlank = true;
            //Caption = 'Security Type';
            OptionCaption = 'Commercial,Residential,Agricultural';
            OptionMembers = Commercial,Residential,Agricultural;
        }
        field(109; "Property Location"; code[100])
        {

            NotBlank = true;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = filter(2));
        }
        field(110; "Property Location Description"; Text[150])
        {

        }
        field(111; "Land Topology"; Option)
        {
            OptionCaption = 'Flat,Sloppy';
            OptionMembers = "Flat",Sloppy;
        }
        field(112; "Type Of Soil"; Option)
        {
            OptionCaption = ',Loam,Sandy,Silty,Clay,Rocky,Marshy';
            OptionMembers = " ","Loam","Sandy","Silty","Clay","Rocky","Marshy";
        }

        field(113; "Registered Owner Phone"; Code[20])
        {

        }
        field(114; "Registered Owner E-mail"; Text[150])
        {

        }
        field(115; "Registered Owner Location"; Text[150])
        {

        }
        field(116; "Registered Owner ID"; Code[20])
        {

        }
        field(117; "Registered Owner KRA Pin"; Code[20])
        {

        }





    }

    keys
    {
        key(Key1; "Document No")
        {
            Clustered = true;
        }
        key(Key2; "Collateral Description")
        {
        }
        key(Key3; "Collateral Code")
        {
        }
        key(Key4; "Registered Owner")
        {
        }
        key(Key5; "Member No.")
        {
        }
        key(Key6; "Member Name")
        {
        }
        key(Key7; "Registration/Reference No")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Document No", "Collateral Description", "Collateral Code", "Registered Owner", "Member No.", "Member Name")
        {
        }
    }

    trigger OnInsert()
    begin

        if "Document No" = '' then begin
            SalesSetup.Get;
            SalesSetup.TestField(SalesSetup."Collateral Register No");
            "Document No" := NoSeriesmgt.GetNextNo(SalesSetup."Collateral Register No");
        end;

        "Date Received" := Today;
        Validate("Date Received");
    end;

    trigger OnDelete()
    var
        myInt: Integer;
    begin
        Error('You cannot delete a record in the Loan Collateral Register Table');
    end;

    var
        NoSeriesmgt: Codeunit "No. Series";
        SalesSetup: Record "Sacco No. Series";
        Cust: Record "Members Register";
        Members: Record Customer;
        ObjFAPostingGroup: Record "FA Posting Group";
        ObjCollMovement: Record "Collateral Movement Register.";
        ObjAccount: Record Vendor;
        ObjCollateraltypes: Record "Loan Collateral Set-up";

    local procedure FnUpdateCollateralMovement(VarAction: Option; VarActionDate: Date; VarActionedBy: Code[20]; VarDocNo: Code[10])
    begin
        ObjCollMovement.Reset;
        ObjCollMovement.SetCurrentkey("Entry No");
        if ObjCollMovement.FindLast then begin
            ObjCollMovement.Init;
            ObjCollMovement."Entry No" := IncStr(ObjCollMovement."Entry No");
            ObjCollMovement."Document No" := VarDocNo;
            ObjCollMovement."Current Location" := VarAction;
            ObjCollMovement."Date Actioned" := VarActionDate;
            ObjCollMovement."Action By" := VarActionedBy;
            ObjCollMovement.Insert;
        end;
    end;
}




