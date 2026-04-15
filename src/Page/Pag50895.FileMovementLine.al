//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50895 "File Movement Line"
{
    ApplicationArea = All;
    PageType = ListPart;
    SourceTable = "File Movement Line";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Global Dimension 2 Code";Rec."Global Dimension 2 Code")
                {
                    Caption = 'Branch';
                    ShowMandatory = true;
                }
                field("Account Type";Rec."Account Type")
                {
                }
                field("File Type";Rec."File Type")
                {
                }
                field("Account No.";Rec."Account No.")
                {
                }
                field("File Number";Rec."File Number")
                {
                    ShowMandatory = true;
                }
                field("Account Name";Rec."Account Name")
                {
                }
                field("Purpose/Description";Rec."Purpose/Description")
                {
                    ShowMandatory = true;
                }
                field("Destination File Location";Rec."Destination File Location")
                {
                    ShowMandatory = true;
                }
                field("Issued To";Rec."Issued To")
                {
                    ShowMandatory = true;
                }
                field("File Return Status";Rec."File Return Status")
                {
                    ShowMandatory = true;
                }
                field("File Received";Rec."File Received")
                {
                    ShowMandatory = true;
                }
                field("Is Available";Rec."Is Available")
                {
                    ShowMandatory = true;
                }
                field("Reason For Rejection";Rec."Reason For Rejection")
                {
                    Editable = canReject;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
        }
    }

    trigger OnAfterGetCurrRecord() begin
        canSendApproval := false;
        canReject := false;

        if Rec."File Return Status" = Rec."File Return Status"::Issued then canSendApproval := true;
        if Rec."Is Available" = false then canReject := true;
    end;
    var
    canSendApproval: Boolean;
    canReject: Boolean;
    approvalDoc: Enum "Approval Document Type";
    ApprovalEntries: Page "Approval Entries";
    workflowInt: Codeunit WorkflowIntegration;
    files: Record "File Movement Header";
}






