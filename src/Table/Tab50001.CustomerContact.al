table 50001 "Customer Contact"
{
    Caption = 'Customer Contact';
    DataClassification = ToBeClassified;//

    fields
    {

        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            Editable = false;
        }
        field(2; Name; Code[50])
        {
            Caption = 'Name';
        }
        field(173001; "Phone Number Prefix"; Text[3])
        {
            Caption = 'Phone Number Prefix';
            Editable = false;
            InitValue = '254';

            trigger OnValidate()
            begin
                if "Phone Number Prefix" = '' then
                    "Phone Number Prefix" := '254';
            end;
        }

        field(173002; "Phone Number Suffix"; Code[20])
        {
            Caption = 'Phone Number Suffix';

            trigger OnValidate()
            var
                //Char: DotNet Char;
                i: Integer;
                Cust: Record Customer;
                ObjMemberApplication: Record "Membership Applications";
                PhoneNoCannotContainLettersErr: Label 'Phone number cannot contain letters';
                PhoneMinLengthErr: Label 'Phone number suffix must be at least 9 digits long';
                PhoneMaxLengthErr: Label 'Phone number suffix cannot be longer than 9 digits';
            begin
                // Ensure prefix is set
                if "Phone Number Prefix" = '' then
                    "Phone Number Prefix" := '254';

                // Validate no letters in phone number
                for i := 1 to StrLen("Phone Number Suffix") do
                    //if Char.IsLetter("Phone Number Suffix"[i]) then
                    // FieldError("Phone Number Suffix", PhoneNoCannotContainLettersErr);

                    // Validate minimum length
                    if (StrLen("Phone Number Suffix") < 9) then
                        Error(PhoneMinLengthErr);

                // Validate maximum length
                if (StrLen("Phone Number Suffix") > 9) then
                    Error(PhoneMaxLengthErr);

                // Combine prefix and suffix to create full mobile number
                "Mobile Phone No" := "Phone Number Prefix" + "Phone Number Suffix";

                // Check if number already exists in Customer table
                if "Mobile Phone No" <> '' then begin
                    Cust.Reset();
                    Cust.SetRange("Mobile Phone No", "Mobile Phone No");
                    if Cust.FindFirst() then
                        Error('This Mobile Number is already in use by an active Member. Kindly use another number');
                end;

                // Check if number exists in Member Application table
                if "Mobile Phone No" <> '' then begin
                    ObjMemberApplication.Reset();
                    ObjMemberApplication.SetRange("Mobile Phone No", "Mobile Phone No");
                    if ObjMemberApplication.FindFirst() then
                        Error('This Mobile Number %1 is already in use. Kindly use another number', "Mobile Phone No");
                end;
            end;
        }

        field(68013; "Mobile Phone No"; Code[30])
        {
            //Editable = false;
            Caption = 'Mobile Phone No';
        }
        field(8; "Global Dimension 1 Code"; Code[20])
        {
            Caption = 'Global Dimension 1 Code';
            CaptionClass = '1,1,1';

            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));//
        }
        field(9; "Global Dimension 2 Code"; Code[20])
        {
            Caption = 'Global Dimension 2 Code';
            CaptionClass = '1,1,2';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));

            trigger OnValidate()
            begin
                /*DimValue.RESET;
                DimValue.SETRANGE(DimValue.Code,"Global Dimension 2 Code");
                  IF DimValue.FIND('-') THEN BEGIN
                    "Member Branch Code":=DimValue."Branch Codes";
                  END;
                  FnCreateDefaultSavingsProducts();
                  */

            end;
        }
        field(69258; "Marketing Activity"; Option)
        {
            OptionCaption = 'Normal Outbound,Activation,Marketing Drive,Breakfast Meetings,Dinner Meetings,Social Media,Others';
            OptionMembers = "Normal Outbound",Activation,"Marketing Drive","Breakfast Meetings","Dinner Meetings","Social Media",Others;
        }

        field(69259; "Marketing Channel"; Option)
        {
            OptionCaption = 'Sales Executive,Self,Newspaper Advert,TV Advert,Radio Advert,Walk-In,Road Sign,Street Poles,Customer Referrals,Facebook,Website,Youtube,Instagram,Other';
            OptionMembers = "Sales Executive",Self,"Newspaper Advert","TV Advert","Radio Advert","Walk-In","Road Sign","Street Poles","Customer Referrals",Facebook,Website,Youtube,Instagram,Other;
        }
        field(6; "Sales Agent Code"; Code[50])
        {
            Caption = 'Marketer Officer';
            TableRelation = "Salesperson/Purchaser".Code;


        }
        field(7; "Sales Executive Code"; Code[50])
        {
            Caption = 'Sales Executive';
            TableRelation = "Salesperson/Purchaser";
        }
        field(25; "HO Referral"; Code[50])
        {
            Caption = 'HO Referral';
            TableRelation = "HR Employees";
            trigger OnValidate()
            var
                HREmployee: Record "HR Employees";
                HREmployeeList: Page "HR Employee List";
            begin
                HREmployee.Reset();
                HREmployee.Reset();
                HREmployee.SetRange(HREmployee."No.", "HO Referral");
                if HREmployee.FindFirst() then begin
                    "HO Referral Name" := HREmployee."Search Name";
                end;
            end;

        }

        field(26; "HO Referral Name"; Text[200])
        {
            Caption = 'HO Referral Name';
            Editable = false;

        }


        field(10; "Sales Team Leader Code"; Code[20])
        {
            TableRelation = "HR Employees" WHERE("Job Title" = CONST('Sales Team Leader'));  // Assuming this is the job title

            trigger OnValidate()
            begin
                TestField("Sales Team Leader Code");
            end;
        }
        field(11; "No. Series"; Code[10])
        {
        }
        field(12; "Surname"; Code[40])
        {
            trigger OnValidate()
            begin
                //   Name := "Surname";
            end;
        }
        field(13; "First Name"; Code[40])
        {
            trigger OnValidate()
            begin
                // Name := "Surname" + ' ' + "First Name";
            end;
        }
        field(14; "Other Name"; Code[40])
        {
            trigger OnValidate()
            begin
                //  Name := "Surname" + ' ' + "First Name" + ' ' + "Other Name";
            end;
        }
        field(15; Title; Enum TitleEnum)
        {

            trigger OnValidate()
            var
                myInt: Integer;
            begin
                Name := Surname;
            end;
        }
        field(16; "Live Location"; Text[100])
        {

        }
        field(17; "Application Status"; Option)
        {
            OptionCaption = 'Pending,Approved,Converted,Rejected,Incomplete';
            OptionMembers = Pending,Approved,Converted,Rejected,Incomplete;
        }
        field(18; Status; Option)
        {
            OptionCaption = 'Open,Pending Approval,Approved,Rejected';
            OptionMembers = Open,"Pending Approval",Approved,Rejected;
        }
        field(19; "Converted"; Boolean)
        {
        }
        field(20; "Shortcut Dimension 3 Code"; Code[20])
        {
            CaptionClass = '1,2,3';
            Caption = 'Shortcut Dimension 3 Code';
            Description = 'Stores the reference of the Third global dimension in the database';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(3));//

            trigger OnValidate()
            begin


            end;
        }
        field(22; "Shortcut Dimension 4 Code"; Code[20])
        {
            CaptionClass = '1,2,4';
            Caption = 'Shortcut Dimension 4 Code';
            Description = 'Stores the reference of the Fourth global dimension in the database';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(4));

            trigger OnValidate()
            begin


            end;
        }
        field(23; "Shortcut Dimension 5 Code"; Code[20])
        {
            CaptionClass = '1,2,5';
            Description = 'Stores the reference of the 5th global dimension in the database Station';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(5));

            trigger OnValidate()
            begin
            end;
        }
        field(24; "Application Date"; Date)
        {
            Editable = false;
        }
        field(27; "Referred By"; Code[120])
        {
            Caption = 'Referred By';
            TableRelation = Customer."No." where(ISNormalMember = filter(true));
            ToolTip = 'Specifies who referred the contact.';
        }

        field(28; "Lead Type"; enum AccountCategoryenum)
        {
            Caption = 'Lead Type';
            ToolTip = 'Specifies who referred the contact.';
        }
        field(29; "Consent Signed"; Boolean)
        {
            Caption = 'Consent Signed';
            ToolTip = 'Specifies if the contact has signed consent.';
        }
        field(30; "E-Mail Address"; Text[500])
        {
            Caption = 'E-Mail Address';
            ToolTip = 'Specifies if the contact has an email address.';
        }
        field(31; "Lead Status"; Option)
        {
            Caption = 'Lead Status';
            ToolTip = 'Specifies the status of the lead.';
            OptionCaption = 'Active,Dormant,Archived';
            OptionMembers = Active,Dormant,Archived;
            Editable = true;
        }
        field(32; "Marketing Campaign ID"; Code[40])
        {
            Caption = 'Marketing Campaign ID';
            ToolTip = 'Specifies Marketing Campaign ID';
            TableRelation = "Marketing Campaign"."Campaign ID";
        }
        field(33; "Marketing Event ID"; Code[40])
        {
            Caption = 'Marketing Event ID';
            ToolTip = 'Specifies who Marketing Event ID.';
            TableRelation = "Marketing Event"."Event ID" where("Campaign ID" = field("Marketing Campaign ID"));
        }

        field(34; "Portal Leads"; Boolean)
        {
            Caption = 'Portal Leads';
            ToolTip = 'Specifies who Marketing Event ID.';

        }


    }
    keys
    {
        key(PK; "No.", Name)
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    begin
        if "No." = '' then begin
            if "No." = '' then begin
                SalesSetup.Get();
                SalesSetup.TestField(SalesSetup."Contact Nos");
                "No." := NoSeriesMgt.GetNextNo(SalesSetup."Contact Nos");
                "Application Date" := today;

            end;
        end;



        /*F UsersID.GET(USERID) THEN BEGIN
        "Global Dimension 2 Code":=UsersID.Branch;
        VALIDATE("Global Dimension 2 Code");
        END;*/


        /*
        DimMgt.UpdateDefaultDim(
          DATABASE::Vendor,"No.",
          "Global Dimension 1 Code","Global Dimension 2 Code");
        */

    end;

    local procedure UpdateFullName()
    var
        FullName: Text;
    begin
        FullName := '';

        if Surname <> '' then
            FullName := Surname;

        if "First Name" <> '' then begin
            if FullName <> '' then
                FullName += ' ';
            FullName += "First Name";
        end;

        if "Other Name" <> '' then begin
            if FullName <> '' then
                FullName += ' ';
            FullName += "Other Name";
        end;

        if Name <> FullName then
            Name := CopyStr(FullName, 1, 50);
    end;

    var
        Text000: label 'You cannot delete %1 %2 because there is at least one outstanding Sales %3 for this customer.';
        Text002: label 'Do you wish to create a contact for %1 %2?';
        SalesSetup: Record "Sacco No. Series";
        Text003: label 'Contact %1 %2 is not related to customer %3 %4.';
        Text004: label 'post';
        Text005: label 'create';

        HrEmployees: Record "HR Employees";
        Text006: label 'You cannot %1 this type of document when Customer %2 is blocked with type %3';
        Text007: label 'You cannot delete %1 %2 because there is at least one not cancelled Service Contract for this customer.';
        Text008: label 'Deleting the %1 %2 will cause the %3 to be deleted for the associated Service Items. Do you want to continue?';
        Text009: label 'Cannot delete customer.';
        Text010: label 'The %1 %2 has been assigned to %3 %4.\The same %1 cannot be entered on more than one %3. Enter another code.';
        Text011: label 'Reconciling IC transactions may be difficult if you change IC Partner Code because this %1 has ledger entries in a fiscal year that has not yet been closed.\ Do you still want to change the IC Partner Code?';
        Text012: label 'You cannot change the contents of the %1 field because this %2 has one or more open ledger entries.';
        Text013: label 'You cannot delete %1 %2 because there is at least one outstanding Service %3 for this customer.';
        Text014: label 'Before you can use Online Map, you must fill in the Online Map Setup window.\See Setting Up Online Map in Help.';
        Text015: label 'You cannot delete %1 %2 because there is at least one %3 associated to this customer.';
        GenSetUp: Record "Sacco General Set-Up";
        MinShares: Decimal;
        MovementTracker: Record "Movement Tracker";
        Cust: Record Customer;
        Vend: Record Vendor;
        CustFosa: Code[20];
        Vend2: Record Vendor;
        FOSAAccount: Record Vendor;
        StatusPermissions: Record "Status Change Permision";
        RefundsR: Record Refunds;
        Text016: label 'You cannot change the contents of the %1 field because this %2 has one or more posted ledger entries.';
        NoSeriesMgt: Codeunit "No. Series";
        PostCode: Record "Post Code";
        User: Record User;
        Employer: Record "Employers Register";
        DataSheet: Record "Data Sheet Main";
        Parishes: Record "Member's Parishes";
        UsersRec: Record User;
        PhoneNoCannotContainLettersErr: Label 'must not contain letters';
        Dates: Codeunit "Dates Calculation";
        DAge: DateFormula;
        HREmployee: Record "HR Employees";
        DimValue: Record "Dimension Value";
        CustMember: Record "Members Register";
        ObjMemberApplication: Record "Membership Applications";
        ObjMemberCell: Record "Member House Groups";
        ObjSelectProduct: Record "Membership Reg. Products Appli";
        ObjAccountTypes: Record "Account Types-Saving Products";
        ObjAuSactions: Record "AU Sanction List";
        VarSactionListExistI: Integer;
        VarSactionListExistII: Integer;
        VarSactionListExistIII: Integer;
        ObjPeps: Record "Politically Exposed Persons";
        ObjExpectedTurnOver: Record "Expected Monthly TurnOver";
        ObjRegionUnits: Record "Regions & Units";
        ObjBanks: Record "Banks Ver2";
}
