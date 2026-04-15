//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50510 "MOBILE Applications"
{

    fields
    {
        field(1; "No."; Code[50])
        {
            Editable = false;

            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    SaccoNoSeries.Get;
                    NoSeriesMgt.TestManual(SaccoNoSeries."Cloudpesa Reg No.");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "Account No"; Code[30])
        {
            Editable = true;
            TableRelation = Customer where(ISNormalMember = filter(true));
            trigger OnValidate()
            var
            begin
                Mobile.Reset();
                Mobile.SetRange("Account No", "Account No");
                if Mobile.FindFirst() then begin
                    Error('Theres an exixting record for this member; Application No: %1', Mobile."No.");
                end;

                SaccoSetup.Get();
                Members.Reset();
                Members.SetRange("No.", "Account No");
                if Members.FindFirst() then begin

                    Members.CalcFields("Shares Retained");
                    if Members."Shares Retained" < SaccoSetup."Retained Shares" then begin
                        Message('Member does not meet minimum shares requirement.');
                    end;

                    if Members."Date of Registration" <> 0D then begin
                        if (CalcDate('<6M>', Members."Registration Date")) > Today then begin
                            Error('Member is under six months');
                        end;
                    end;

                    if Members."ID No." = '' then Error('Kindly ensure this member has an ID No.');
                    if Members.Pin = '' then Error('Kindly ensure this member has a KRA pin.');
                    if Members."Membership Status" <> Members."Membership Status"::Active then Error('This member is a dormant member.');
                    if Members.Defaulter then Error('This member is a defaulter.');
                    if Members.Piccture.Count() = 0 then Error('Kindly ensure this member has a Picture.');
                    if Members.Signature.Count() = 0 then Error('Kindly ensure this member has a Signature.');
                    if Members."ID Front".Count() = 0 then Error('Kindly ensure this member has a front image of their ID.');
                    if Members."ID Back".Count() = 0 then Error('Kindly ensure this member has a back image of their ID.');

                    "Account Name" := Members.Name;
                    Telephone := Members."Mobile Phone No";
                    "ID No" := Members."ID No.";
                end;
            end;
        }
        field(3; "Account Name"; Text[50])
        {
            Editable = false;
            Enabled = true;
        }
        field(4; Telephone; Code[20])
        {
            Editable = false;
            Enabled = true;
        }
        field(5; "ID No"; Code[20])
        {
            Editable = false;
            Enabled = true;
        }
        field(6; Status; Option)
        {
            Editable = false;
            Enabled = true;
            OptionCaption = 'Application,Pending Approval,Approved,Rejected,Canceled';
            OptionMembers = Application,"Pending Approval",Approved,Rejected,Canceled;

            trigger OnValidate()
            begin
                if Status = Status::Approved then begin
                    Members.Reset();
                    Members.Get("Account No");
                    Members."Mobile Banking Registered" := true;
                    Members."Mobile Banking Status" := true;
                    Members.Modify;
                end
            end;
        }
        field(7; "Date Applied"; Date)
        {
            Editable = true;
            Enabled = true;
        }
        field(8; "Time Applied"; Time)
        {
            Editable = true;
            Enabled = true;
        }
        field(9; "Created By"; Code[50])
        {
            Editable = true;
        }
        field(10; Sent; Boolean)
        {
            Editable = false;
        }
        field(11; "No. Series"; Code[50])
        {
            Editable = false;
            TableRelation = "No. Series";
        }
        field(12; SentToServer; Boolean)
        {
            Editable = true;
        }
        field(14; "Last PIN Reset"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Reset By"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(16; "PIN Requested"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(17; Guid; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(18; "Username"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(19; "Password"; Text[2042])
        {
            DataClassification = ToBeClassified;
        }
        field(20; "OTP Code"; Text[10])
        {
            DataClassification = ToBeClassified;
        }
        field(21; "IsMember"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(22; "Application"; Text[10])
        {
            DataClassification = ToBeClassified;
        }
        field(23; "Security Code"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(24; "Security Answer"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(25; "Activated"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(26; "Member Banking"; Option)
        {
            OptionCaption = ' ,Mobile,Internet,Both';
            OptionMembers = " ",Mobile,Internet,Both;
        }
        field(27; "Terms Read and Understood"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin

        if "No." = '' then begin
            SaccoNoSeries.Get;
            SaccoNoSeries.TestField(SaccoNoSeries."Cloudpesa Reg No.");
            NoSeriesMgt.GetNextNo(SaccoNoSeries."Cloudpesa Reg No.");
        end;


        "Time Applied" := Time;
        "Created By" := UserId;
        "Date Applied" := Today;
        Guid := CreateGuid;
    end;

    var
        SaccoNoSeries: Record "Sacco No. Series";
        Accounts: Record Vendor;
        Members: Record Customer;
        Mobile: Record "MOBILE Applications";
        SaccoSetup: Record "Sacco General Set-Up";
        NoSeriesMgt: Codeunit "No. Series";
        FieldRef: Guid;
}




