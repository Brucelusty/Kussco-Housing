table 50771 "Staff Marketing Payment"
{
    Caption = 'Staff Marketing Payment';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[20])
        {
            Editable = false;
            Caption = 'No.';
        }
        field(2; "Payment Date"; Date)
        {
            Caption = 'Payment Date';
        }
        field(3; "Payment By"; Code[20])
        {
            Caption = 'Payment By';
        }
        field(4; "Membership Rate"; Decimal)
        {
            Caption = 'Membership Rate';
        }
        field(5; "Salary Rate"; Decimal)
        {
            Caption = 'Salary Rate';
        }
        field(6; "Staff No."; Code[20])
        {
            Caption = 'Payment To';
            TableRelation = "HR Employees"."No.";

            trigger OnValidate()
            begin
                cust.Reset();
                cust.SetRange("Payroll No", "Staff No.");
                if cust.Find('-') then begin
                    "Member No" := cust."No.";
                end;
            end;
        }
        field(7; Status; Option)
        {
            Editable = false;
            OptionCaption = 'Open,Pending Approval,Approved,Rejected,Received,Paid';
            OptionMembers = Open,"Pending Approval",Approved,Rejected,Received,Paid;
        }
        field(8; "Member No"; Code[20])
        {
            TableRelation = Customer."No.";
        }
        field(9; "No Series"; Code[20])
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
        cust: Record Customer;
        employees: Record "HR Employees";

    trigger OnInsert()
    begin
        if "No." = '' then begin
            saccoNos.Get();
            saccoNos.TestField("Staff Payment Nos");
            noSeries.GetNextNo(saccoNos."Staff Payment Nos");
        end;

        employees.Reset();
        employees.SetRange("User ID", UserId);
        if employees.Find('-') then begin
            Validate("Staff No.", employees."No.");
        end;
    end;

}
