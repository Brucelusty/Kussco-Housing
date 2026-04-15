//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50683 "Standing Order Card"
{
    ApplicationArea = All;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Reports,Approval,Budgetary Control,Cancellation,Category7_caption,Category8_caption,Category9_caption,Category10_caption';
    SourceTable = "Standing Orders";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; Rec."No.")
                {
                    Editable = false;
                }
                field("Source Account Type"; Rec."Source Account Type")
                {
                }
                field("BOSA Account No."; Rec."BOSA Account No.")
                {
                    Caption = 'Member No';
                   // Importance = Additional;
                }
                field("Source Account No."; Rec."Source Account No.")
                {
                    AssistEdit = false;
                    Editable = false;
                }
                field("Staff/Payroll No.";Rec."Staff/Payroll No.")
                {
                    AssistEdit = false;
                    Editable = false;
                }
                field("Account Name"; Rec."Account Name")
                {
                    Editable = false;
                }
                field("Source Account Narrations"; Rec."Source Account Narrations")
                {
                    Caption = 'STO Narration';
                }
                field("Source Global Dimension 1 Code"; Rec."Source Global Dimension 1 Code")
                {
                    Caption = 'Source Account Activity';
                    visible = False;
                }
                field("Source Global Dimension 2 Code"; Rec."Source Global Dimension 2 Code")
                {
                    Caption = 'Source Account Branch';
                    visible = False;
                }
                field(Amount; Rec.Amount)
                {
                    Editable = AmountEditable;
                }
                field("Destination Account Type"; Rec."Destination Account Type")
                {
                    visible = False;
                    Editable = DestinationAccountTypeEditable;
                    OptionCaption = '<,Member Account,Other Banks Account,G/L Account,Supplier Account,Loan Account';

                    trigger OnValidate()
                    begin
                        ReceiptAllVisible := false;
                        DestinationAccountsVisible := false;

                        if Rec."Destination Account Type" = Rec."destination account type"::"Member Account" then begin
                            ReceiptAllVisible := false;
                            DestinationAccountsVisible := true;
                        end;


                        BankDetailsVisible := false;
                        if Rec."Destination Account Type" = Rec."destination account type"::"Other Banks Account" then begin
                            BankDetailsVisible := true;
                            DestinationAccountsVisible := true;
                        end;




                        ReceiptAllVisible := false;
                        DestinationAccountsVisible := false;

                        if Rec."Destination Account Type" = Rec."destination account type"::"Member Account" then begin
                            ReceiptAllVisible := false;
                            DestinationAccountsVisible := true;
                        end;


                        BankDetailsVisible := false;
                        if Rec."Destination Account Type" = Rec."destination account type"::"Other Banks Account" then begin
                            BankDetailsVisible := true;
                            DestinationAccountsVisible := true;
                        end;
                    end;
                }
                field("Destination Account No."; Rec."Destination Account No.")
                {
                    visible = False;
                    Editable = DestinationAccountNoEditable;
                }
                field("Destination Account Name"; Rec."Destination Account Name")
                {
                    visible = False;
                    Editable = DestinationAccountNameEditable;
                }
                group(BankDetails)
                {
                    Caption = 'Bank Details';
                    
                    Visible = BankDetailsVisible;
                    field("Bank Code"; Rec."Bank Code")
                    {

                        trigger OnValidate()
                        begin
                            BankName := '';
                            if Banks.Get(Rec."Bank Code") then
                                BankName := Banks."Bank Name";
                        end;
                    }
                    field(BankName; BankName)
                    {
                        Caption = 'Bank Name';
                    }
                }
                field("Destination Account Narrations"; Rec."Destination Account Narrations")
                {
                    Caption = 'Destination Account Narration';
                    visible = False;
                }
                field("Dest. Global Dimension 1 Code"; Rec."Dest. Global Dimension 1 Code")
                {
                    Caption = 'Destination Account Activity';
                    visible = False;
                }
                field("Dest. Global Dimension 2 Code"; Rec."Dest. Global Dimension 2 Code")
                {
                    Caption = 'Destination Account Branch';
                    visible = False;
                }
                field("Allocated Amount"; Rec."Allocated Amount")
                {
                }
                field("Effective/Start Date"; Rec."Effective/Start Date")
                {
                    Editable = EffectiveDateEditable;
                }
                field(Duration; Rec.Duration)
                {
                    Editable = DurationEditable;
                }
                field("End Date"; Rec."End Date")
                {
                    Editable = false;
                    Importance = Additional;
                }
                field(Frequency; Rec.Frequency)
                {
                    Editable = FrequencyEditable;
                }
                field("Execute Condition"; Rec."Execute Condition")
                {
                    visible = False;
                    ToolTip = 'Specify Execute Condition when funds are not Sufficient';

                    trigger OnValidate()
                    begin
                        ExecuteConditionVisible := false;
                        if Rec."Execute Condition" = Rec."execute condition"::"If no Funds Retry Standing Order" then begin
                            ExecuteConditionVisible := true;
                        end;
                    end;
                }
                field("Don't Allow Partial Deduction"; Rec."Don't Allow Partial Deduction")
                {
                    Editable = false;
                    visible = False;
                }
                field(Unsuccessfull; Rec.Unsuccessfull)
                {
                    Editable = false;
                    Importance = Additional;
                }
                field("Next Run Date"; Rec."Next Run Date")
                {
                }
                group("Retry Details:")
                {
                    Caption = 'Retry Details:';
                    Visible = ExecuteConditionVisible;
                    field("No of Tolerance Days"; Rec."No of Tolerance Days")
                    {
                        Caption = 'No of Retry Days';
                        Editable = false;
                        Importance = Additional;
                    }
                    field("End of Tolerance Date"; Rec."End of Tolerance Date")
                    {
                        Caption = 'Last Retry Date';
                        Editable = false;
                        ToolTip = 'This is the last date the system will attempt to run the standing order after the tolerance period';
                    }
                }
                field(Balance; Rec.Balance)
                {
                    Editable = false;
                    Importance = Additional;
                }
                field(Effected; Rec.Effected)
                {
                    Editable = false;
                    Importance = Additional;
                }
                field("Auto Process"; Rec."Auto Process")
                {
                    Editable = false;
                    Importance = Additional;
                }
                field("Standing Order Dedution Type"; Rec."Standing Order Dedution Type")
                {
                }
                field("None Salary"; Rec."None Salary")
                {
                }
                field("Link PaytoFOSA";Rec."Link PaytoFOSA")
                {
                    Importance = Additional;
                }
                field("Date Reset"; Rec."Date Reset")
                {
                    Editable = false;
                    Importance = Additional;
                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                    Importance = Additional;
                }
                field("Posted By"; Rec."Posted By")
                {
                    Editable = false;
                    Importance = Additional;
                }
            }
            // part("Receipt Allocation";Rec."Receipt Allocation-BOSA")
            // {
            //     SubPageLink = "Document No" = field("No.");
            //     Visible = ReceiptAllVisible;
            // }
            part("Receipt Allocation"; "Receipt Allocation-BOSA")
            {
                SubPageLink = "Document No" = field("No.");
            }
        }
        area(factboxes)
        {
            part(Control25; "FOSA Statistics FactBox")
            {
                SubPageLink = "No." = field("Source Account No.");
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Reset)
            {
                Caption = 'Reset';
                Promoted = true;
                PromotedCategory = Process;
                Visible = false;

                trigger OnAction()
                begin
                    if Confirm('Are you sure you want to reset the standing order?') = true then begin

                        Rec.Effected := false;
                        Rec.Balance := 0;
                        Rec.Unsuccessfull := false;
                        Rec."Auto Process" := false;
                        Rec."Date Reset" := Today;
                        Rec.Modify;

                        RAllocations.Reset;
                        RAllocations.SetRange(RAllocations."Document No", Rec."No.");
                        if RAllocations.Find('-') then begin
                            repeat
                                RAllocations."Amount Balance" := 0;
                                RAllocations."Interest Balance" := 0;
                                RAllocations.Modify;
                            until RAllocations.Next = 0;
                        end;

                    end;
                end;
            }
            action(Approve)
            {
                Caption = 'Approve';
                Enabled = true;
                Image = Approve;
                Promoted = true;
                PromotedCategory = Process;
                Visible = false;

                trigger OnAction()
                begin
                    Rec.TestField("Source Account No.");
                    if Rec."Destination Account Type" <> Rec."destination account type"::"Other Banks Account" then
                        Rec.TestField("Destination Account No.");
                    Rec.TestField("Effective/Start Date");
                    Rec.TestField(Frequency);
                    Rec.TestField("Next Run Date");


                    StatusPermissions.Reset;
                    StatusPermissions.SetRange(StatusPermissions."User ID", UserId);
                    StatusPermissions.SetRange(StatusPermissions."Function", StatusPermissions."function"::"Standing Order");
                    if StatusPermissions.Find('-') = false then
                        Error('You do not have permissions to change the standing order status.');
                end;
            }
            action(Reject)
            {
                Caption = 'Reject';
                Image = Reject;
                Promoted = true;
                PromotedCategory = Process;
                Visible = false;

                trigger OnAction()
                begin
                    StatusPermissions.Reset;
                    StatusPermissions.SetRange(StatusPermissions."User ID", UserId);
                    StatusPermissions.SetRange(StatusPermissions."Function", StatusPermissions."function"::"Standing Order");
                    if StatusPermissions.Find('-') = false then
                        Error('You do not have permissions to change the standing status.');
                end;
            }
            action(Stop)
            {
                Caption = 'Stop';
                Promoted = true;
                PromotedCategory = Process;
                Visible = false;

                trigger OnAction()
                begin
                    StatusPermissions.Reset;
                    StatusPermissions.SetRange(StatusPermissions."User ID", UserId);
                    StatusPermissions.SetRange(StatusPermissions."Function", StatusPermissions."function"::"Standing Order");
                    if StatusPermissions.Find('-') = false then
                        Error('You do not have permissions to stop the standing order.');

                    if Confirm('Are you sure you want to stop the standing order?', false) = true then begin
                        Rec.Status := Rec.Status::Approved;
                        Rec.Modify;
                    end;
                end;
            }
            group(Approvals)
            {
                action("Send Approval Request")
                {
                    Caption = 'Send Approval Request';
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category4;
                    Enabled = (rec.Status = rec.Status::Open);

                    trigger OnAction()
                    var
                        Text001: label 'This request is already pending approval';
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        Rec.TestField("Source Account No.");
                        Rec.TestField("Source Account Narrations");
                        if Rec."Destination Account Type" = Rec."destination account type"::"Member Account" then

                        Rec.TestField("Effective/Start Date");
                        Rec.TestField(Frequency);
                        Rec.TestField("Next Run Date");

                        if Rec."Destination Account Type" = Rec."destination account type"::"Other Banks Account" then begin
                            Rec.CalcFields("Allocated Amount");
                            if Rec.Amount <> Rec."Allocated Amount" then
                                Error('Allocated amount must be equal to amount');
                        end;

                        Rec.CalcFields("Allocated Amount");
                        if Rec.Amount <> Rec."Allocated Amount" then Error('Allocated amount must be equal to amount');

                        if Rec.Status <> Rec.Status::Open then
                            Error(Text001);
                        // Message('Sent for Approval');

                        if workflowintegration.CheckStandingOrderApprovalsWorkflowEnabled(Rec) then
                            workflowintegration.OnSendStandingOrderForApproval(Rec);
                        // Rec.Status := Rec.Status::Approved;
                        // Rec.Modify();
                        // Message('Record has been approved.');
                    end;
                }
                action(Approval)
                {
                    Caption = 'Approvals';
                    Image = Approval;
                    Promoted = true;
                    PromotedCategory = Category4;
                    Enabled = (rec.Status = rec.Status::Pending);

                    trigger OnAction()
                    var
                        ApprovalEntries: Page "Approval Entries";
                        approvalDoc: Enum "Approval Document Type";
                    begin
                        ApprovalEntries.SetRecordFilters(Database::"Standing Orders", approvalDoc::StandingOrder, Rec."No.");
                        ApprovalEntries.Run;
                    end;
                }
                action("Cancel Approval Request")
                {
                    Caption = 'Cancel Approval Request';
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category4;
                    Enabled = (rec.Status = rec.Status::Pending);

                    trigger OnAction()
                    var
                        Approvalmgt: Codeunit "Approvals Mgmt.";
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        if workflowintegration.CheckStandingOrderApprovalsWorkflowEnabled(Rec) then begin
                            workflowintegration.OnCancelStandingOrderApprovalRequest(Rec);
                            // Rec.Status := Rec.Status::Open;
                            // Rec.Modify;
                        end;
                    end;
                }
            }
        }
        area(creation)
        {
            action(Create_STO)
            {
                Caption = 'Create_STO';
                Enabled = true;
                Image = Approve;
                Promoted = true;
                PromotedCategory = Process;
                Visible = false;

                trigger OnAction()
                begin
                    Rec.TestField("Source Account No.");
                    if Rec."Destination Account Type" <> Rec."destination account type"::"Other Banks Account" then
                        Rec.TestField("Destination Account No.");
                    Rec.TestField("Effective/Start Date");
                    Rec.TestField(Frequency);
                    Rec.TestField("Next Run Date");

                    //IF Status<>Status::"2" THEN
                    //ERROR('Standing order status must be approved for you to create it');

                    StatusPermissions.Reset;
                    StatusPermissions.SetRange(StatusPermissions."User ID", UserId);
                    StatusPermissions.SetRange(StatusPermissions."Function", StatusPermissions."function"::"Standing Order");
                    if StatusPermissions.Find('-') = false then
                        Error('You do not have permissions to change the standing order status.');
                end;
            }
            action(Stop_STO)
            {
                Caption = 'Stop_STO';
                Image = Stop;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    /*StatusPermissions.RESET;
                    StatusPermissions.SETRANGE(StatusPermissions."User ID",USERID);
                    StatusPermissions.SETRANGE(StatusPermissions."Function",StatusPermissions."Function"::"Standing Order");
                    IF StatusPermissions.FIND('-') = FALSE THEN
                    ERROR('You do not have permissions to stop the standing order.');*/

                    if Confirm('Are you sure you want to stop the standing order?', false) = true then begin
                        STOs.Reset;
                        STOs.SetRange(STOs."No.", Rec."No.");
                        if STOs.FindSet then begin
                            STOs."Stopped By" := UserId;
                            STOs."Stopped On" := CurrentDatetime;
                            STOs."Is Active" := false;
                            STOs.Status := Rec.Status::Stopped;
                            STOs.Modify;
                        end;
                    end;

                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        BankName := '';
        if Banks.Get(Rec."Bank Code") then
            BankName := Banks."Bank Name";

        ReceiptAllVisible := false;
        DestinationAccountsVisible := false;

        if Rec."Destination Account Type" = Rec."destination account type"::"Member Account" then begin
            ReceiptAllVisible := false;
            DestinationAccountsVisible := true;
        end;


        BankDetailsVisible := false;
        if Rec."Destination Account Type" = Rec."destination account type"::"Other Banks Account" then begin
            BankDetailsVisible := true;
            DestinationAccountsVisible := true;
        end;



        if Rec.Status = Rec.Status::Open then begin
            AmountEditable := true;
            DestinationAccountNoEditable := true;
            DestinationAccountNameEditable := true;
            FrequencyEditable := true;
            DurationEditable := true;
            EffectiveDateEditable := true;
            DestinationAccountTypeEditable := true
        end else
            if Rec.Status = Rec.Status::Pending then begin
                AmountEditable := false;
                DestinationAccountNoEditable := false;
                DestinationAccountNameEditable := false;
                FrequencyEditable := false;
                DurationEditable := false;
                EffectiveDateEditable := false;
                DestinationAccountTypeEditable := false
            end else begin
                AmountEditable := false;
                DestinationAccountNoEditable := false;
                DestinationAccountNameEditable := false;
                FrequencyEditable := false;
                DurationEditable := false;
                EffectiveDateEditable := false;
                DestinationAccountTypeEditable := false;
            end;

        ExecuteConditionVisible := false;
        if Rec."Execute Condition" = Rec."execute condition"::"If no Funds Retry Standing Order" then begin
            ExecuteConditionVisible := true;
        end;
    end;

    trigger OnOpenPage()
    begin
        if Rec.Status = Rec.Status::Approved then
            CurrPage.Editable := false;

        ReceiptAllVisible := false;

        BankDetailsVisible := false;
        if Rec."Destination Account Type" = Rec."destination account type"::"Other Banks Account" then begin
            BankDetailsVisible := true;
        end;

        if Rec."Destination Account Type" = Rec."destination account type"::"Member Account" then begin
            ReceiptAllVisible := false;
            DestinationAccountsVisible := true;
        end;




        if Rec.Status = Rec.Status::Open then begin
            AmountEditable := true;
            DestinationAccountNoEditable := true;
            DestinationAccountNameEditable := true;
            FrequencyEditable := true;
            DurationEditable := true;
            EffectiveDateEditable := true;
            DestinationAccountTypeEditable := true
        end else
            if Rec.Status = Rec.Status::Pending then begin
                AmountEditable := false;
                DestinationAccountNoEditable := false;
                DestinationAccountNameEditable := false;
                FrequencyEditable := false;
                DurationEditable := false;
                EffectiveDateEditable := false;
                DestinationAccountTypeEditable := false
            end else begin
                AmountEditable := false;
                DestinationAccountNoEditable := false;
                DestinationAccountNameEditable := false;
                FrequencyEditable := false;
                DurationEditable := false;
                EffectiveDateEditable := false;
                DestinationAccountTypeEditable := false;
            end;


        ExecuteConditionVisible := false;
        if Rec."Execute Condition" = Rec."execute condition"::"If no Funds Retry Standing Order" then begin
            ExecuteConditionVisible := true;
        end;
    end;

    var
        StatusPermissions: Record "Status Change Permision";
        BankName: Text[20];
        Banks: Record Banks;
        UsersID: Record User;
        vend: Record Vendor;
        RAllocations: Record "Receipt Allocation";
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ","Purchase Requisition",RFQ,"Store Requisition","Payment Voucher",MembershipApplication,LoanApplication,LoanDisbursement,ProductApplication,StandingOrder,MembershipWithdrawal,ATMCard,GuarantorRecovery;
        ReceiptAllVisible: Boolean;
        ObjAccount: Record Vendor;
        BankDetailsVisible: Boolean;
        AmountEditable: Boolean;
        DestinationAccountTypeEditable: Boolean;
        DestinationAccountNoEditable: Boolean;
        EffectiveDateEditable: Boolean;
        FrequencyEditable: Boolean;
        DescriptionEditable: Boolean;
        DestinationAccountNameEditable: Boolean;
        DurationEditable: Boolean;
        DestinationAccountsVisible: Boolean;
        ExecuteConditionVisible: Boolean;
        STOs: Record "Standing Orders";
        workflowintegration: Codeunit WorkflowIntegration;

    local procedure AllocatedAmountOnDeactivate()
    begin
        CurrPage.Update := true;
    end;
}






