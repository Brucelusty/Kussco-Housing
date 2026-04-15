table 50756 "Leave Supervisor Approval"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Integer)
        {
            Editable = false;
            AutoIncrement = true;
        }
        field(2; "Leave No."; Code[20])
        {
            Editable = false;
            TableRelation = "HR Leave Application"."Application Code";
        }
        field(3; "Staff No"; Code[20])
        {
            Editable = false;
        }
        field(4; "Staff Name"; Code[50])
        {
            Editable = false;
        }
        field(5; "Leave Type"; Code[20])
        {
            Editable = false;
        }
        field(6; "Days Applied"; Decimal)
        {
            Editable = false;
        }
        field(7; "Approved Days"; Decimal)
        {
            Editable = true;
        }
        field(8; "Releiver"; Code[50])
        {
            Editable = false;
        }
        field(9; "Day Applied"; Date)
        {
            Editable = false;
        }
        field(10; "Leave Account Balance"; Decimal)
        {
            Editable = false;
        }
        field(11; "Approval Status"; Option)
        {
            Editable = false;
            OptionCaption = 'New,Pending,Approved,Rejected';
            OptionMembers = New,Pending,Approved,Rejected;

            trigger OnValidate()
            begin
                if "Approval Status" = "Approval Status"::New then begin
                    leave.Reset();
                    leave.SetRange("Application Code", "Leave No.");
                    if leave.Find('-') then begin
                        leave.Status := leave.Status::New;
                        leave.modify;
                    end;
                end;
                if "Approval Status" = "Approval Status"::Pending then begin
                    leave.Reset();
                    leave.SetRange("Application Code", "Leave No.");
                    if leave.Find('-') then begin
                        leave.Status := leave.Status::"HOD Approval";
                        leave.modify;
                    end;
                end;
                if "Approval Status" = "Approval Status"::Rejected then begin
                    leave.Reset();
                    leave.SetRange("Application Code", "Leave No.");
                    if leave.Find('-') then begin
                        leave.Status := leave.Status::Rejected;
                        leave.modify;
                    end;
                end;
                if "Approval Status" = "Approval Status"::Approved then begin
                    leave.Reset();
                    leave.SetRange("Application Code", "Leave No.");
                    if leave.Find('-') then begin
                        leave."Days Applied" := "Approved Days";
                        leave."Approver Comments" := "Approver Remarks";
                        leave.Validate("Days Applied");
                        leave.Status := leave.Status::"HR Approval";
                        leave.modify;

                        if Workflowintegration.CheckLeaveApplicationApprovalsWorkflowEnabled(leave) then begin
                            Workflowintegration.OnSendLeaveApplicationForApproval(leave);
                        end;

                    end;
                end;
            end;
        }
        field(12; "Approver Remarks"; Text[2048])
        {
            Editable = true;
        }

    }

    keys
    {
        key(Key1; "No.", "Leave No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        // Add changes to field groups here
    }

    var
        myInt: Integer;
        noSeries: Codeunit "No. Series";
        Workflowintegration: codeunit WorkflowIntegration;
        fundSetup: Record "Funds General Setup";
        insider: Record InsiderLending;
        vend: Record Vendor;
        leave: Record "HR Leave Application";

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin
        if "Approval Status" <> "Approval Status"::New then Error('You cannot delete this record.');
    end;

    trigger OnRename()
    begin

    end;

}
