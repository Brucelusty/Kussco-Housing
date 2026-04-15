//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50301 "File Movement Header"
{
    //nownPage51516603;
    //nownPage51516603;

    fields
    {
        field(1; "No."; Code[20])
        {
            Editable = false;
        }
        field(2; "File Number"; Code[40])
        {
        }
        field(3; "File Name"; Text[100])
        {
        }
        field(4; "Account No."; Code[40])
        {
            TableRelation = Vendor."No.";

            trigger OnValidate()
            begin
                Vendor.Reset;
                Vendor.SetRange(Vendor."No.", "Account No.");
                if Vendor.Find('-') then
                    "Account Name" := Vendor.Name;
            end;
        }
        field(5; "Account Name"; Text[50])
        {
            Editable = false;
        }
        field(6; "Date Requested"; Date)
        {
            Editable = false;
        }
        field(7; "Requested By"; Code[50])
        {
            Editable = false;
        }
        field(8; "Date Retrieved"; Date)
        {
        }
        field(9; "Responsiblity Center"; Code[50])
        {
            TableRelation = "Responsibility Center".Code;
            Editable = false;
        }
        field(10; "Expected Return Date"; Date)
        {
            Editable = false;
        }
        field(11; "Duration Requested"; DateFormula)
        {

            trigger OnValidate()
            begin
                "Expected Return Date" := CalcDate("Duration Requested", Today);
            end;
        }
        field(12; "Date Returned"; Date)
        {
        }
        field(13; "File Location"; Code[40])
        {
            TableRelation = "File Locations Setup".Location;

            trigger OnValidate()
            begin
                fileLocation.Reset();
                fileLocation.SetRange(Location, "File Location");
                if fileLocation.Find('-') then begin
                    "Account Type" := fileLocation."Account Type";
                    "Returned By" := "User ID";
                end;
            end;
        }
        field(14; "Current File Location"; Code[40])
        {
            Editable = false;
            TableRelation = "File Locations Setup".Location;
        }
        field(15; "Retrieved By"; Code[40])
        {
        }
        field(16; "Returned By"; Code[40])
        {
            Editable = false;
        }
        field(17; "Global Dimension 1 Code"; Code[40])
        {
            TableRelation = "Dimension Value".Code where("Global Dimension No." = filter(1));
        }
        field(18; "Global Dimension 2 Code"; Code[40])
        {
            TableRelation = "Dimension Value".Code where("Global Dimension No." = filter(2));
        }
        field(19; Status; Option)
        {
            Editable = false;
            InitValue = Open;
            OptionCaption = ',Open,Pending Approval,Approved,Issued,Returned,Transferred,Transfer Rejected';
            OptionMembers = ,Open,"Pending Approval",Approved,Issued,Returned,Transferred,"Transfer Rejected";

            trigger OnValidate()
            begin
                if Status = Status::Open then begin
                    files.Reset();
                    files.SetRange("Document No.", "No.");
                    if files.FindSet() then begin
                        repeat
                            files."File Return Status" := files."File Return Status"::Open;
                            files.Modify;
                        until files.Next() = 0;
                    end;
                end else if Status = Status::"Pending Approval" then begin
                    files.Reset();
                    files.SetRange("Document No.", "No.");
                    if files.FindSet() then begin
                        repeat
                            files."File Return Status" := files."File Return Status"::Issuing;
                            files.Modify;
                        until files.Next() = 0;
                    end;
                end else if Status = Status::Approved then begin
                    files.Reset();
                    files.SetRange("Document No.", "No.");
                    files.SetRange("Is Available", false);
                    if files.FindSet() then begin
                        repeat
                            if files."Reason For Rejection" = '' then Error('Kindly state a reason for rejecting %1''s file.', files."Account Name");
                        until files.Next() = 0;
                    end;
                    files.Reset();
                    files.SetRange("Document No.", "No.");
                    files.SetRange("Is Available", true);
                    if files.FindSet() then begin
                        repeat
                            files."File Return Status" := files."File Return Status"::Issued;
                            files.Modify;
                        until files.Next() = 0;
                    end;
                end else if Status = Status::"Transfer Rejected" then begin
                    Rec.TestField("Reason For Rejection");

                    files.Reset();
                    files.SetRange("Document No.", "No.");
                    if files.FindSet() then begin
                        repeat
                            files."File Return Status" := files."File Return Status"::Open;
                            files.Modify;
                        until files.Next() = 0;
                    end;
                end;
            end;
        }
        field(20; "User ID"; Code[40])
        {
            Editable = false;
        }
        field(21; "Issuing File Location"; Code[40])
        {
            Editable = true;
            TableRelation = "File Locations Setup".Location where("File Storage" = filter(true));

            trigger OnValidate()
            begin
                fileLocation.Reset();
                fileLocation.SetRange(Location, "Issuing File Location");
                if fileLocation.Find('-') then begin
                    "Account Type" := fileLocation."Account Type";
                    "Current File Location" := "Issuing File Location";
                end;
            end;
        }
        field(22; "No. Series"; Code[20])
        {
        }
        field(23; "File Movement Status"; Option)
        {
            Editable = false;
            InitValue = Open;
            OptionCaption = 'Open,Issued,Returned,Transferred';
            OptionMembers = Open,Issued,Returned,Transferred;
        }

        field(24; "General Remarks"; Option)
        {
            OptionCaption = ' ,Reconciliation purposes,Auditing purposes,Refunds,Loan & Signatories,Withdrawal,Risks payment,Cheque Payment,Custody,Document Filing,Passbook,Complaint Letters,Defaulters,Asked for it,Holiday Fund,Receipting,Feeding,Debting,Others';
            OptionMembers = " ","Reconciliation purposes","Auditing purposes",Refunds,"Loan & Signatories",Withdrawal,"Risks payment","Cheque Payment",Custody,"Document Filing",Passbook,"Complaint Letters",Defaulters,"Asked for it","Holiday Fund",Receipting,Feeding,Debting,Others;
        }

        field(25; "Specific Remarks"; Text[2048])
        {

        }
        field(26; "Employer Code"; Code[20])
        {
            TableRelation = "Employers Register"."Employer Code";
        }
        field(27; "Account Type"; Option)
        {
            Editable = false;
            OptionCaption = ' ,Member,FOSA,Staff';
            OptionMembers = " ",Member,FOSA,Staff;
        }
        field(28; "Reason For Rejection"; Text[2000])
        {

        }
        field(29; "File Return"; Boolean)
        {

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

    trigger OnDelete()
    begin
        Error('You do not have permissions to delete this record, Please contact the system administrator');
    end;

    trigger OnInsert()
    begin
        if "No." = '' then begin
            if "File Return" = false then begin
                GenLedgerSetup.Get;
                GenLedgerSetup.TestField("File Movement Nos");
                NoSeriesMgt.GetNextNo(GenLedgerSetup."File Movement Nos");
            end else begin
                GenLedgerSetup.Get;
                GenLedgerSetup.TestField("File Return Nos");
                NoSeriesMgt.GetNextNo(GenLedgerSetup."File Return Nos");
            end;
        end;

        employees.Reset();
        employees.SetRange("User ID", UserId);
        if employees.Find('-') then begin
            "User ID" := UserId;
            "Requested By" := UserId;
            "Responsiblity Center" := employees."Responsibility Center";
        end;
        //Set To Defaut On Insert A New Rec-Kimoo
        "Date Requested" := Today;
        // "Issuing File Location" := 'REGISTRY';
    end;

    trigger OnModify()
    begin
        //ERROR('You do not have permissions to modify this record, Please contact the system administrator');
    end;

    trigger OnRename()
    begin
        //ERROR('You do not have permissions to rename this record, Please contact the system administrator');
    end;

    var
        NoSeriesMgt: Codeunit "No. Series";
        GenLedgerSetup: Record "Sacco No. Series";
        Vendor: Record Vendor;
        employees: Record "HR Employees";
        fileLocation: Record "File Locations Setup";
        files: Record "File Movement Line";
}




