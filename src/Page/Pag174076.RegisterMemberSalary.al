namespace TelepostSacco.TelepostSacco;

page 51178 "Register Member Salary"
{
    ApplicationArea = All;
    Caption = 'Register Member Salary';
    PageType = Card;
    SourceTable = "Register Salary Accounts";
    UsageCategory = Lists;
    PromotedActionCategories = 'New,Report,Process,Approvals';
    
    layout
    {
        area(Content)
        {
            Group(General)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.', Comment = '%';
                }
                field("Staff No."; Rec."Staff No.")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Staff No. field.', Comment = '%';
                }
                field("Staff Name"; Rec."Staff Name")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Staff Name field.', Comment = '%';
                }
                field("Salary Account"; Rec."Salary Account")
                {
                    ToolTip = 'Specifies the value of the Salary Account field.', Comment = '%';
                }
                field("Salary Account Holder"; Rec."Salary Account Holder")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Salary Account Holder field.', Comment = '%';
                }
                field("Expected Date"; Rec."Expected Date")
                {
                    ToolTip = 'Specifies the value of the Expected Date field.', Comment = '%';
                }
                field("Expected Salary"; Rec."Expected Salary")
                {
                    ToolTip = 'Specifies the value of the Expected Salary field.', Comment = '%';
                }
                field("Payroll No";Rec."Payroll No")
                {
                    Editable = false;
                }
                field("Employer Code";Rec."Employer Code")
                {
                    Editable = false;
                }
                field(Posted; Rec.Posted)
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Posted field.', Comment = '%';
                }
                field("Posted On"; Rec."Posted On")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Posted On field.', Comment = '%';
                }
                field(Status;Rec.Status)
                {
                    Editable = false;
                    Style = StrongAccent;
                    ToolTip = 'Specifies the value of the Posted By field.', Comment = '%';
                }
            }
        }
    }
    
    actions
    {
        area(Reporting)
        {}
        area(Processing)
        {
            
        }
        area(Navigation)
        {
            action(SendApproval)
            {
                Caption = 'Send Approval Request';
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedOnly = true;

                trigger OnAction() begin
                    Rec.TestField("Staff No.");
                    Rec.TestField("Salary Account");
                    Rec.Status := Rec.Status::Approved;
                    Rec.Modify;
                    Message('The record has been approved');
                end;
            }
            action(CancelApproval)
            {
                Caption = 'Cancel Approval Request';
                Image = CancelApprovalRequest;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedOnly = true;

                trigger OnAction() begin
                    Rec.Status := Rec.Status::Open;
                    Rec.Modify;
                    Message('The approval request has been canceled');
                end;
            }
            action(Approvals)
            {
                Caption = 'Approval Entries';
                Image = Approvals;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedOnly = true;

                trigger OnAction() begin
                    Message('There exists no ongoing approval instances for this record.');
                end;
            }
        }
    }

    var
    canSend: Boolean;

    trigger OnAfterGetCurrRecord() begin
        canSend := false;
        if Rec.Status = Rec.Status::Approved then begin
            canSend := true;
        end;
    end;

    trigger OnAfterGetRecord() begin
        canSend := false;
        if Rec.Status = Rec.Status::Approved then begin
            canSend := true;
        end;
    end;
}


