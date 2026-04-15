table 50770 "Register Salary Accounts"
{
    Caption = 'Register Salary Accounts';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[20])
        {
            Editable = false;
            Caption = 'No.';
        }
        field(2; "Staff No."; Code[20])
        {
            Caption = 'Staff No.';
            TableRelation = "HR Employees"."No.";

            trigger OnValidate()
            begin

            end;
        }
        field(3; "Staff Name"; Text[500])
        {
            Caption = 'Staff Name';
        }
        field(4; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
        }
        field(5; "Salary Account"; Code[20])
        {
            Caption = 'Salary Account';
            TableRelation = Vendor."No." where("Employer Code" = filter(<> 'STAFF'), "Creditor Type" = filter("FOSA Account"), "Account Type" = filter('103'));
            trigger OnValidate()
            begin
                salDetails.Reset();
                salDetails.SetRange("FOSA Account No", "Salary Account");
                if salDetails.Find('-') then begin
                    Error('This member is already a salary earner');
                end;

                regSalary.Reset();
                regSalary.SetRange("Salary Account", "Salary Account");
                regSalary.SetFilter("Staff No.", '<>%1', "Staff No.");
                if regSalary.Find('-') then begin
                    Error('This salary account has already been captured by %1', regSalary."Staff Name");
                end;

                regSalary.Reset();
                regSalary.SetRange("Salary Account", "Salary Account");
                regSalary.SetRange("Staff No.", "Staff No.");
                regSalary.SetFilter("No.", '<>%1', "No.");
                if regSalary.Find('-') then begin
                    Error('You have already captured this salary account on another application, No: %1', regSalary."No.");
                end;

                vend.Reset();
                vend.Get("Salary Account");
                "Salary Account Holder" := vend.Name;
                "Payroll No" := vend."Personal No.";
                "Employer Code" := vend."Employer Code";
            end;
        }
        field(6; "Salary Account Holder"; Text[500])
        {
            Caption = 'Salary Account Holder';
        }
        field(7; "Expected Salary"; Decimal)
        {
            Caption = 'Expected Salary';
        }
        field(8; "Expected Date"; Date)
        {
            Caption = 'Expected Date';
        }
        field(9; Posted; Boolean)
        {
            Caption = 'Posted';
        }
        field(10; "Posted On"; Date)
        {
            Caption = 'Posted On';
        }
        field(11; "Posted By"; Code[20])
        {
            Caption = 'Posted By';
        }
        field(12; Status; Option)
        {
            Editable = false;
            OptionCaption = 'Open,Pending Approval,Approved,Rejected,Sent To HR,Received,Paid';
            OptionMembers = Open,"Pending Approval",Approved,Rejected,"Sent To HR",Received,Paid;
        }
        field(13; "Sent To HR"; Boolean)
        {
        }
        field(14; "Payroll No"; Code[20])
        {
        }
        field(15; "Employer Code"; Code[20])
        {
        }
        field(16; "No Series"; Code[20])
        {
        }
    }
    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }
    var
        noSeries: Codeunit "No. Series";
        saccoNos: Record "Sacco No. Series";
        regSalary: Record "Register Salary Accounts";
        employees: Record "HR Employees";
        vend: Record Vendor;
        detVend: Record "Detailed Vendor Ledg. Entry";
        salDetails: Record "Salary Details";

    trigger OnInsert()
    begin
        if "No." = '' then begin
            saccoNos.Get();
            saccoNos.TestField("Salary Registration Nos");
            noSeries.GetNextNo(saccoNos."Salary Registration Nos");
        end;

        employees.Reset();
        employees.SetRange("User ID", UserId);
        if employees.Find('-') then begin
            "Staff No." := employees."No.";
            "Staff Name" := employees.FullName();
        end else
            Error('User %1 has not been tied to an employee member.', UserId);
    end;
}
