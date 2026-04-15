//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50302 "File Movement Line"
{

    fields
    {
        field(1; "Document No."; Code[20])
        {
        }
        field(2; "File Type"; Code[20])
        {
            TableRelation = "File Types SetUp".Code where("Member Type" = field("Account Type"));

            trigger OnValidate() begin
                fileTypes.Reset();
                fileTypes.SetRange(Code, "File Type");
                if fileTypes.Find('-') then begin
                    "Account Type" := fileTypes."Member Type";
                end;

            end;
        }
        field(3; "Account Type"; Option)
        {
            Editable = false;
            OptionCaption = ' ,Member,FOSA,Staff';
            OptionMembers = " ",Member,FOSA,Staff;
        }
        field(4; "Account No."; Code[20])
        {
            TableRelation = if ("Account Type" = const(Member)) Customer."No." where(ISNormalMember = filter(true), "Employer Code" = filter(<>'STAFF'))
            else if ("Account Type" = const(FOSA)) Vendor."No." where("Creditor Type" = filter("FOSA Account"), "Employer Code" = filter(<>'STAFF')) 
            else if ("Account Type" = const(Staff)) "HR Employees"."No." where(Status = filter(Active));

            trigger OnValidate()
            begin
                if "File Return" = false then begin
                    files.Reset();
                    files.SetRange("Account No.", "Account No.");
                    files.SetRange("File Return Status", files."File Return Status"::Issued);
                    if files.Find('-') then begin
                        Error('This file is currently under the custody of %1', files."Issued To");
                    end;
                end;
                
                if "Account Type" = "Account Type"::Member then begin
                    cust.Reset();
                    if cust.Get("Account No.") then begin
                        "Account Name" := cust.Name;
                        "File Number" := cust."Payroll No"
                    end;
                end else if "Account Type" = "Account Type"::FOSA then begin
                    vend.Reset();
                    if vend.Get("Account No.") then begin
                        "Account Name" := vend.Name;
                        "File Number" := vend."Personal No."
                    end;
                end else if "Account Type" = "Account Type"::Staff then begin
                    staff.Reset();
                    if staff.Get("Account No.") then begin
                        "Account Name" := staff.FullName();
                        "File Number" := staff."No.";
                    end;
                end;
            end;
        }
        field(5; "Purpose/Description"; Text[2000])
        {
        }
        field(6; "Global Dimension 1 Code"; Code[20])
        {
            TableRelation = "Dimension Value".Code where("Global Dimension No." = filter(1));
        }
        field(7; "Global Dimension 2 Code"; Code[20])
        {
            TableRelation = "Dimension Value".Code where("Global Dimension No." = filter(2));
        }
        field(8; "Account Name"; Text[100])
        {
            Editable = false;
        }
        field(9; "File Number"; Code[50])
        {
            Editable = false;
        }
        field(10; "Line No."; Integer)
        {
            AutoIncrement = true;
        }
        field(11; "Destination File Location"; Code[40])
        {
            TableRelation = if ("File Return" = filter(false)) "Responsibility Center".Code else "File Locations Setup".Location;
            Editable = false;
        }
        // field(10; "Line No."; Integer)
        // {
        //     AutoIncrement = true;
        // }
        field(12; "File Return Status"; Option)
        {
            Editable = false;
            InitValue = Open;
            OptionCaption = 'Open,Issued,Returned,Issuing';
            OptionMembers = Open,Issued,Returned,Issuing;
        }
        field(13; Status; Option)
        {
            // Editable = false;
            InitValue = Open;
            OptionCaption = ',Open,Pending Approval,Approved,Issued,Returned,Transferred,Transfer Rejected';
            OptionMembers = ,Open,"Pending Approval",Approved,Issued,Returned,Transferred,"Transfer Rejected";
        }
        field(14; "Issued To"; Code[20])
        {
            TableRelation = "HR Employees"."No.";
            Editable = false;
        }
        field(15; "Is Available"; Boolean)
        {
        }
        field(16; "Reason For Rejection"; Text[2000])
        {
        }
        field(17; "File Received"; Boolean)
        {
        }
        field(18; "File Received On"; DateTime)
        {
        }
        field(19; "File Return"; Boolean)
        {
        }
        field(20; Returnee; Code[20])
        {

        }
        field(21; "Returning File"; Code[20])
        {
            TableRelation = "File Movement Line"."Account No." where("File Received" = filter(true), "Issued To" = field(Returnee));
        }
    }

    keys
    {
        key(Key1; "Line No.", "Document No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert() begin
        
        fileMovement.Reset();
        fileMovement.SetRange("No.", "Document No.");
        if fileMovement.Find('-') then begin
            if fileMovement."File Return" = false then begin
                if fileMovement."Issuing File Location" = '' then Error('Kindly select an issuing location for the files.');
                "Account Type" := fileMovement."Account Type";
                "Destination File Location" := fileMovement."Responsiblity Center";
                "Issued To" := fileMovement."Requested By";
            end else begin
                "Account Type" := fileMovement."Account Type";
                "File Return" := fileMovement."File Return";
                "Destination File Location" := fileMovement."File Location";
            end;
        end;
    end;

    var
    fileMovement: Record "File Movement Header";
    cust: Record Customer;
    vend: Record Vendor;
    staff: Record "HR Employees";
    fileTypes: Record "File Types SetUp";
    files: Record "File Movement Line";

}




