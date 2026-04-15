//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50803 "Standing Order Card Approved"
{
    ApplicationArea = All;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Reports,Approval,Budgetary Control,Cancellation,Category7_caption,Category8_caption,Category9_caption,Category10_caption';
    SourceTable = "Standing Orders";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;

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
                field("Source Account No."; Rec."Source Account No.")
                {
                    AssistEdit = false;
                    Editable = true;
                }
                field("Staff/Payroll No."; Rec."Staff/Payroll No.")
                {
                    Editable = false;
                }
                field("Account Name"; Rec."Account Name")
                {
                    Editable = false;
                }
                field("Source Account Narrations"; Rec."Source Account Narrations")
                {
                    Caption='STO Narration';
                }
                field("Source Global Dimension 1 Code"; Rec."Source Global Dimension 1 Code")
                {
                    visible = False;
                    Caption = 'Source Account Activity';
                }
                field("Source Global Dimension 2 Code"; Rec."Source Global Dimension 2 Code")
                {
                    visible = False;
                    Caption = 'Source Account Branch';
                }
                field(Amount; Rec.Amount)
                {
                }
                field("Destination Account Type"; Rec."Destination Account Type")
                {
                    visible = False;
                }
                field("Destination Account No."; Rec."Destination Account No.")
                {
                    visible = False;
                }
                field("Destination Account Name"; Rec."Destination Account Name")
                {
                    visible = False;
                }
                field("Destination Account Narrations"; Rec."Destination Account Narrations")
                {
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
                group(BankDetails)
                {
                    Caption = 'BankDetails';
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
                field("BOSA Account No."; Rec."BOSA Account No.")
                {
                    Importance = Additional;
                }
                field("Allocated Amount"; Rec."Allocated Amount")
                {
                }
                field("Effective/Start Date"; Rec."Effective/Start Date")
                {
                }
                field(Duration; Rec.Duration)
                {
                }
                field("End Date"; Rec."End Date")
                {
                    Importance = Additional;
                }
                field(Frequency; Rec.Frequency)
                {
                }
                field("Execute Condition"; Rec."Execute Condition")
                {
                }
                field("Don't Allow Partial Deduction"; Rec."Don't Allow Partial Deduction")
                {
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
                    field("Next Attempt Date"; Rec."Next Attempt Date")
                    {
                        Caption = 'Next Retry Date';
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
                }
                field("Posted By"; Rec."Posted By")
                {
                    Editable = false;
                    Importance = Additional;
                }
                field("Is Active"; Rec."Is Active")
                {
                }
                field("Created On"; Rec."Created On")
                {
                    Editable = false;
                }
                field("Created By"; Rec."Created By")
                {
                    Editable = false;
                }
            }
            part("Receipt Allocation"; "Receipt Allocation-BOSA")
           
            {
                SubPageLink = "Document No" = field("No.");
                 Editable=false;
            }
        }
        area(factboxes)
        {
            part(Control2; "FOSA Statistics FactBox")
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
                Caption = 'Deactivate STO';
                Image = StopPayment;
                Promoted = true;
                PromotedCategory = Process;
              //  Visible = false;

                trigger OnAction()
                begin
/*                     StatusPermissions.Reset;
                    StatusPermissions.SetRange(StatusPermissions."User ID", UserId);
                    StatusPermissions.SetRange(StatusPermissions."Function", StatusPermissions."function"::"Standing Order");
                    if StatusPermissions.Find('-') = false then
                        Error('You do not have permissions to stop the standing order.');
 */
                    if Confirm('Are you sure you want to stop the standing order?', false) = true then begin
                        Rec."Is Active" := false;
                        Rec.Status:=Rec.Status::Stopped;
                        Rec.MODIFY;
                    end;
                end;
            }
            action(Run)
            {
                Caption = 'Run STO';
                Image = PostedPayment;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                LineNo: Integer;
                EXTERNAL_DOC_NO: Code[40];
                accountType: Code[50];
                BATCH_NAME: Code[50];
                BATCH_TEMPLATE: Code[50];
                DOCUMENT_NO: Code[40];
                DedStatus: Option Successfull,"Partial Deduction",Failed;
                AUFactory: Codeunit "Au Factory";
                GenBatches: Record "Gen. Journal Batch";
                GenJournalLine: Record "Gen. Journal Line";
                vendor: Record Vendor;
                stoLines: Record "Receipt Allocation";
                userSetup: Record "User Setup";
                begin
                    userSetup.Reset();
                    userSetup.SetRange("User ID", UserId);
                    if userSetup.Find('-') then begin
                        if (userSetup."Is Manager" = false) or (userSetup.Overdraft = false) then Error('You do not have the rights to run standing orders.');
                    end;

                    if Confirm('Are you sure you want to run the standing order?', true) = false then exit;

                    
                    BATCH_TEMPLATE := 'GENERAL';
                    BATCH_NAME := 'RUNSTOS';
                    DOCUMENT_NO := Rec."No.";

                    GenJournalLine.RESET;
                    GenJournalLine.SETRANGE("Journal Template Name", BATCH_TEMPLATE);
                    GenJournalLine.SETRANGE("Journal Batch Name", BATCH_NAME);
                    if GenJournalLine.FindSet() then begin
                        GenJournalLine.DELETEALL;
                    end;

                    GenBatches.Reset;
                    GenBatches.SetRange(GenBatches."Journal Template Name", BATCH_TEMPLATE);
                    GenBatches.SetRange(GenBatches.Name, BATCH_NAME);
                    if GenBatches.Find('-') = false then begin
                        GenBatches.Init;
                        GenBatches."Journal Template Name" := BATCH_TEMPLATE;
                        GenBatches.Name := BATCH_NAME;
                        GenBatches.Insert;
                    end;

                    vendor.Reset();
                    vendor.SetRange("No.", Rec."Source Account No.");
                    if vendor.Find('-') then begin
                        vendor.CalcFields(Balance);
                        stoLines.Reset();
                        stoLines.SetRange("Document No", Rec."No.");
                        if stoLines.Find('-') then begin
                            Rec.CalcFields("Allocated Amount");
                            EXTERNAL_DOC_NO := Rec."No.";
                            if Rec."Allocated Amount" < vendor.Balance then begin
                                repeat
                                    if stoLines."STO Account Type" = stoLines."STO Account Type"::Member then begin
                                        if stoLines."Transaction Type" = stoLines."Transaction Type"::Dividend then begin
                                            LineNo := LineNo + 10000;
                                            AUFactory.FnCreateGnlJournalLineSal(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::Dividend,
                                            GenJournalLine."account type"::Customer, vendor."Bosa Account No", Today, -stoLines.Amount, 'BOSA',
                                            EXTERNAL_DOC_NO, 'BBF Contribution', '', GenJournalLine."application source"::" ",
                                                vendor."Bosa Account No", GenJournalLine."Salary Receipt Type"::"6-STO");
                                            LineNo := LineNo + 10000;
                                            AUFactory.FnCreateGnlJournalLineSal(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                                            GenJournalLine."account type"::Vendor,  vendor."No.", Today, stoLines.Amount, 'BOSA',
                                            EXTERNAL_DOC_NO, 'BBF Contribution', '', GenJournalLine."application source"::" ",
                                                vendor."Bosa Account No", GenJournalLine."Salary Receipt Type"::"6-STO");
                                        end;
                                    end else if stoLines."STO Account Type" = stoLines."STO Account Type"::"FOSA Account" then begin
                                        accountType := getAccountType(stoLines."Member No");
                                        LineNo := LineNo + 10000;
                                        AUFactory.FnCreateGnlJournalLineSal(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                                        GenJournalLine."account type"::Vendor, stoLines."Member No", Today, -stoLines.Amount, 'FOSA',
                                        EXTERNAL_DOC_NO, accountType + ' Contribution', '', GenJournalLine."application source"::" ",
                                        vendor."Bosa Account No", GenJournalLine."Salary Receipt Type"::"6-STO");
                                        LineNo := LineNo + 10000;
                                        AUFactory.FnCreateGnlJournalLineSal(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                                        GenJournalLine."account type"::Vendor, vendor."No.", Today, stoLines.Amount, 'FOSA',
                                        EXTERNAL_DOC_NO, accountType + ' Contribution', '', GenJournalLine."application source"::" ",
                                        vendor."Bosa Account No", GenJournalLine."Salary Receipt Type"::"6-STO");
                                    end;
                                    Rec."Next Run Date" := CalcDate('<1M>', Today);
                                    Rec.Effected := true;
                                    Rec."Date Reset" := Today;
                                    Rec.Modify;
                                    DedStatus := DedStatus::Successfull;
                                    FnRegisterProcessedStandingOrder(Rec, DOCUMENT_NO, Rec."Allocated Amount", DedStatus);

                                until stoLines.Next() = 0;
                                
                                GenJournalLine.Reset;
                                GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
                                GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
                                if GenJournalLine.Find('-') then begin
                                    Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco", GenJournalLine);
                                end;
                            end else begin
                                DedStatus := DedStatus::Failed;
                                FnRegisterProcessedStandingOrder(Rec, DOCUMENT_NO, Rec."Allocated Amount", DedStatus);
                            end;
                        end;
                    end;
                end;
            }
            group(Approvals)
            {
                Visible = false;
                action(Approval)
                {
                    Caption = 'Approvals';
                    Image = Approval;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        ApprovalEntries: Page "Approval Entries";
                    begin
                        DocumentType := Documenttype::STO;
                        ApprovalEntries.SetRecordFilters(Database::"HR Commitee Members", DocumentType, Rec."No.");
                        ApprovalEntries.Run;
                    end;
                }
                action("Send Approval Request")
                {
                    Caption = 'Send Approval Request';
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        Text001: label 'This request is already pending approval';
                        Approvalmgt: Codeunit "Approvals Mgmt.";
                    begin
                        Rec.TestField("Source Account No.");
                        if Rec."Destination Account Type" <> Rec."destination account type"::"Other Banks Account" then
                            Rec.TestField("Destination Account No.");

                        Rec.TestField("Effective/Start Date");
                        Rec.TestField(Frequency);
                        Rec.TestField("Next Run Date");

                        if Rec."Destination Account Type" = Rec."destination account type"::"Other Banks Account" then begin
                            Rec.CalcFields("Allocated Amount");
                            if Rec.Amount <> Rec."Allocated Amount" then
                                Error('Allocated amount must be equal to amount');
                        end;

                        if Rec.Status <> Rec.Status::Open then
                            Error(Text001);


                        /*
                       //End allocate batch number
                       IF Approvalmgt.SendFOSASTOApprovalRequest(Rec) THEN;
                         */
                        Rec.Status := Rec.Status::Approved;
                        Rec."Posted By" := UserId;

                    end;
                }
                action("Cancel Approval Request")
                {
                    Caption = 'Cancel Approval Request';
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        Approvalmgt: Codeunit "Approvals Mgmt.";
                    begin

                        //IF Approvalmgt.CancelFOSASTOApprovalRequest(Rec,TRUE,TRUE) THEN;
                    end;
                }
            }
        }
        area(creation)
        {
            action(Create_STO)
            {
                Caption = 'Activate STO';
                Enabled = true;
                Image = Approve;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    Rec.TestField("Source Account No.");
                    if Rec."Destination Account Type" <> Rec."destination account type"::"Other Banks Account" then
                     //   Rec.TestField("Destination Account No.");
                    Rec.TestField("Effective/Start Date");
                    Rec.TestField(Frequency);
                    Rec.TestField("Next Run Date");

                    if Rec."Is Active" = true then begin
                        Error('The Standing Order is already Activated');
                        exit;
                    end;

                    if Confirm('Are you sure you want to activate this Standing Order?') = false then
                        exit;
                    Rec."Is Active" := true;
                    Rec."Posted By" := UserId;
                    Rec.Modify;
                end;
            }
            action(StopAmend)
            {
                Caption = 'Amend Standing Order';
                Image = Edit;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    if Confirm('Confirm Standing Order Amend', false) = true then begin
                        Rec.Status := Rec.Status::Open;
                        Rec."Modified By" := UserId;
                        Rec."Modified On" := CurrentDatetime;
                        Rec.Modify;
                        Message('Standing Order Reopened Succesfully');
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
        if Rec."Destination Account Type" = Rec."destination account type"::"Other Banks Account" then begin
            ReceiptAllVisible := true;
        end;

        BankDetailsVisible := false;
        if Rec."Destination Account Type" = Rec."destination account type"::"Member Account" then begin
            BankDetailsVisible := true;
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
        if Rec."Destination Account Type" = Rec."destination account type"::"Other Banks Account" then begin
            ReceiptAllVisible := true;
        end;

        BankDetailsVisible := false;
        if Rec."Destination Account Type" = Rec."destination account type"::"Member Account" then begin
            BankDetailsVisible := true;
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
        RAllocations: Record "Receipt Allocation";
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None",JV,"Member Closure","Account Opening",Batches,"Payment Voucher","Petty Cash",Requisition,Loan,Interbank,Imprest,Checkoff,"FOSA Account Opening",STO;
        ReceiptAllVisible: Boolean;
        ObjAccount: Record Vendor;
        BankDetailsVisible: Boolean;
        ExecuteConditionVisible: Boolean;

    local procedure AllocatedAmountOnDeactivate()
    begin
        CurrPage.Update := true;
    end;

    local procedure getAccountType(account: Code[20]) Type: Code[50]
    var
    Vend: Record Vendor;
    accTypes: Record "Account Types-Saving Products";
    begin
        Vend.Reset();
        Vend.SetRange("No.", account);
        if Vend.Find('-') then begin
            if accTypes.Get(Vend."Account Type") then begin
                Type := accTypes.Description;
            end;
        end;
    end;

    local procedure FnRegisterProcessedStandingOrder(sto: Record "Standing Orders"; docNo: Code[20]; AmountToDeduct: Decimal; DedStatus: Option Successfull,"Partial Deduction",Failed)
    var
        stoReg: Record "Standing Order Register";
    begin
        stoReg.Reset;
        stoReg.SetRange("Document No.", docNo);
        if stoReg.Find('-') then
            stoReg.DeleteAll;

        stoReg.Init;
        stoReg."Register No." := '';
        stoReg.Validate(stoReg."Register No.");
        stoReg."Standing Order No." := sto."No.";
        stoReg."Source Account No." := sto."Source Account No.";
        stoReg."Staff/Payroll No." := sto."Staff/Payroll No.";
        stoReg.Date := Today;
        stoReg."Account Name" := sto."Account Name";
        stoReg."Destination Account Type" := sto."Destination Account Type";
        stoReg."Destination Account No." := sto."Destination Account No.";
        stoReg."Destination Account Name" := sto."Destination Account Name";
        stoReg."BOSA Account No." := sto."BOSA Account No.";
        stoReg."Effective/Start Date" := sto."Effective/Start Date";
        stoReg."End Date" := sto."End Date";
        stoReg.Duration := sto.Duration;
        stoReg.Frequency := sto.Frequency;
        stoReg."Don't Allow Partial Deduction" := sto."Don't Allow Partial Deduction";
        stoReg."Deduction Status" := DedStatus;
        stoReg.Remarks := sto."Standing Order Description";
        stoReg.Amount := sto.Amount;
        stoReg."Amount Deducted" := AmountToDeduct;
        if sto."Destination Account Type" = sto."destination account type"::"Member Account" then
            stoReg.EFT := true;
        stoReg."Document No." := docNo;
        if not stoReg.Insert(true) then stoReg.Modify(true);
    end;


}




