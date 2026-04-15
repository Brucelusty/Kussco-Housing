page 50037 "Funeral Rider Processing Card"
{
    ApplicationArea = All;
    PageType = Card;
    UsageCategory = Lists;
    SourceTable = "Funeral Rider Processing";
    // Editable = false;
    DeleteAllowed = false;
    PromotedActionCategories = 'Home,Report,Process,Attachments';
    // ModifyAllowed = false;
    // InsertAllowed = false;
    
    layout
    {
        area(Content)
        {
            Group(General)
            {
                field("FR No.";Rec."FR No.")
                {
                }
                field("Member No.";Rec."Member No.")
                {
                    ShowMandatory = True;
                    Editable = canSendApproval;
                }
                field("Member Name";Rec."Member Name")
                {
                }
                field("Member Deceased";Rec."Member Deceased")
                {
                    Editable = canSendApproval;
                }
                field("Next of Kin Deceased";Rec."Next of Kin Deceased")
                {
                    Editable = canSendApproval;
                    trigger OnValidate() begin
                        if rec."Next of Kin Deceased" = true then begin
                            nokVisible:= true;
                        end else nokVisible:= false;
                    end;
                }
                group("Next of Kin")
                {
                    Visible = nokVisible;
                    field("NoK ID No.";Rec."NoK ID No.")
                    {
                        ShowMandatory = true;
                    }
                    field("NoK Name";Rec."NoK Name")
                    {
                    }
                    field("NoK Relationship";Rec."NoK Relationship")
                    {
                    }
                    field("NoK is Member";Rec."NoK is Member")
                    {
                    }
                    field("NoK BBF";Rec."NoK BBF")
                    {
                    }
                }
                field("Has BBF Contributions";Rec."Has BBF Contributions")
                {
                }
                field("Burial Permit No";Rec."Burial Permit No")
                {
                    ShowMandatory = true;
                    Editable = canSendApproval;
                }
                field("Processing Status";Rec."Processing Status")
                {
                }
                field("Approval Status";Rec."Approval Status")
                {
                }
                field("Reason For Rejection";Rec."Reason For Rejection")
                {
                    Visible = false;
                    Editable = not rec."FR Fee Paid";
                }
                field("Captured On";Rec."Captured On")
                {
                }
                // field()
                // {
                // }
            }
        }
        area(Factboxes)
        {
            part(Control1000000052; "Member Statistics FactBox")
            {
                Caption = 'Member Statistics FactBox';
                SubPageLink = "No." = field("Member No.");
            }
            part("Attached Documents"; "Document Attachment Factbox")
            {
                Caption = 'Burial Permit Slip';
                SubPageLink = "Table ID" = const(Database::"Funeral Rider Processing"), "No." = field("FR No.");
            }
        }
    }
    
    actions
    {
        area(Reporting)
        {
            action(Attachment)
            {
                Caption = 'Attachments';
                Image = Attach;
                ToolTip = 'Add a file as an attachment. You can attach images as well as documents.';
                Promoted = true;
                PromotedCategory = Category4;

                trigger OnAction()
                var
                    DocumentAttachmentDetails: Page "Document Attachment Details";
                    RecRef: RecordRef;
                begin
                    RecRef.GetTable(Rec);
                    DocumentAttachmentDetails.OpenForRecRef(RecRef);
                    DocumentAttachmentDetails.RunModal();
                end;
            }
        }
        area(Processing)
        {
            action(SendApproval)
            {
                Caption = 'Send Approval Request';
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                Enabled = canSendApproval;
                
                trigger OnAction()
                begin
                    if rec."Member No." = '' then Error('Kindly fill in the member no.');
                    if (rec."Next of Kin Deceased" = true) and (rec."NoK Name" = '') then Error('Kindly fill in the next ok kin details.');
                    if rec."Burial Permit No" = '' then Error('Kindly fill in the burial permit no.');
                    if Rec."Has BBF Contributions" = false then Message('The member %1 has no BFF contributions.', rec."Member No.");
                    if rec."NoK is Member" = true and Rec."NoK BBF" = false then Message('The nok member %1 has no BFF contributions.', rec."NoK Member No.");

                    
                    docFactbox.Reset();
                    docFactbox.SetRange("Table ID", Database::"Funeral Rider Processing");
                    docFactbox.SetRange("No.", Rec."FR No.");
                    if docFactbox.FindSet() then begin
                        noOfRecords:= docFactbox.Count;
                    end;
                    if noOfRecords <= 0 then Error('Ensure that a document is attached to this funeral rider.');

                    if rec."Approval Status" = rec."Approval Status"::Open then begin
                        workflowInt.CheckFRFeePayApprovalsWorkflowEnabled(Rec);
                        workflowInt.OnSendFRFeePayForApproval(Rec);

                        CurrPage.Close();
                    end;
                end;
            }
            action(CancelApproval)
            {
                Caption = 'Cancel Approval Request';
                Image = CancelApprovalRequest;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                Enabled = CanCancelApprovalForRecord;
                
                trigger OnAction()
                begin
                    if Rec."Approval Status" = Rec."Approval Status"::"Pending Approval" then begin
                        workflowInt.OnCancelFRFeePayApprovalRequest(Rec);
                    end;
                end;
            }
            action(Approval)
            {
                Caption = 'Approval';
                Image = Approvals;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                Enabled = OpenApprovalEntriesExistForCurrUser;
                
                trigger OnAction()
                var
                approvalEntries: Page "Approval Entries";
                approvalDoc: Enum "Approval Document Type";
                begin
                    approvalEntries.SetRecordFilters(Database::"Funeral Rider Processing", approvalDoc::FRFeePay, Rec."FR No.");
                    approvalEntries.RunModal();
                end;
            }
            action(FRPayment)
            {
                Caption = 'Pay FR Fee';
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Enabled = canCreate and (not rec."FR Fee Paid");
                Visible = canCreate;
                
                trigger OnAction()
                begin
                    if rec."Has BBF Contributions" = false then Error('The funeral rider payment cannot be processed successfully because the member has no BBF contributions.');
                    payment:= 0;
                    FRFeeAccount:= '';
                    saccoGenSetup.Get();
                    payment:= saccoGenSetup."Funeral Expense Amount";
                    FRFeeAccount:= saccoGenSetup."Funeral Expenses Account";
                    if payment = 0 then Error('Confirm that the funeral rider payment is set up in the sacco setup.');

                    if Confirm('Do you wish to proceed with posting the funeral rider for this member', true) = false then exit;

                    batchTemplate := 'PAYMENTS';
                    batchName := 'FUNERAL';
                    docNo := 'FRFEE'+ Rec."Member No." +'-'+Rec."FR No.";
                    lineNo := 0;

                    GenJournalLine.Reset;
                    GenJournalLine.SetRange("Journal Template Name", 'PAYMENTS');
                    GenJournalLine.SetRange("Journal Batch Name", 'FUNERAL');
                    if GenJournalLine.FindSet() then begin
                        GenJournalLine.DeleteAll
                    end;
                    
                    GenBatches.Reset;
                    GenBatches.SetRange(GenBatches."Journal Template Name", 'PAYMENTS');
                    GenBatches.SetRange(GenBatches.Name, 'FUNERAL');
                    if GenBatches.Find('-') = false then begin
                        GenBatches.Init;
                        GenBatches."Journal Template Name" := 'PAYMENTS';
                        GenBatches.Name := 'FUNERAL';
                        GenBatches.Description := 'FUNERAL RIDER PAYMENT';
                        GenBatches.Insert;
                    end;

                    if vend.Get(Rec."Member FOSA Account") then begin
                        lineNo := lineNo + 10000;
                        AUFactory.FnCreateGnlJournalLine(batchTemplate, batchName, docNo, lineNo, GenJournalLine."Transaction Type"::" ",
                        GenJournalLine."Account Type"::"G/L Account", FRFeeAccount, Today, payment, '', '',
                        'Funeral Rider '+Rec."Member No."+' Payment', '', GenJournalLine."Application Source"::" ");
                        //--------------------------------(CREDIT Funeral Rider Account)---------------------------------------------

                        //------------------------------------2. DEBIT FOSA A/C---------------------------------------------------------------------------------------------
                        lineNo := lineNo + 10000;
                        AUFactory.FnCreateGnlJournalLine(batchTemplate, batchName, docNo, lineNo, GenJournalLine."Transaction Type"::" ",
                        GenJournalLine."Account Type"::Vendor, Vend."No.", Today, payment * -1, ' ', '',
                        'Funeral Rider '+Rec."Member No."+' Payment', '', GenJournalLine."Application Source"::" ");

                        if (rec."Next of Kin Deceased" = true) and (rec."NoK Relationship" = 'SPOUSE') and (rec."NoK Member No." <> '')then begin
                            lineNo := lineNo + 10000;
                            AUFactory.FnCreateGnlJournalLine(batchTemplate, batchName, docNo, lineNo, GenJournalLine."Transaction Type"::" ",
                            GenJournalLine."Account Type"::"G/L Account", FRFeeAccount, Today, payment, '', '',
                            'Funeral Rider '+Rec."NoK Member No."+' Payment', '', GenJournalLine."Application Source"::" ");
                            //--------------------------------(CREDIT Funeral Rider Account)---------------------------------------------

                            //------------------------------------2. DEBIT FOSA A/C---------------------------------------------------------------------------------------------
                            lineNo := lineNo + 10000;
                            AUFactory.FnCreateGnlJournalLine(batchTemplate, batchName, docNo, lineNo, GenJournalLine."Transaction Type"::" ",
                            GenJournalLine."Account Type"::Vendor, Vend."No.", Today, payment * -1, ' ', '',
                            'Funeral Rider '+Rec."NoK Member No."+' Payment', '', GenJournalLine."Application Source"::" ");
                        end;

                        GenJournalLine.Reset;
                        GenJournalLine.SetRange("Journal Template Name", batchTemplate);
                        GenJournalLine.SetRange("Journal Batch Name", batchName);
                        if GenJournalLine.Find('-') then begin
                            Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco", GenJournalLine);
                        end;
                        
                        detVend.Reset();
                        detVend.SetRange("Vendor No.", rec."Member FOSA Account");
                        detVend.SetRange("Document No.", docNo);
                        if detVend.Find('-') then begin
                            rec."FR Fee Paid":= true;
                            rec."Processing Status" := rec."Processing Status"::Paid;
                            rec."Payment Doc No" := docNo;
                            rec.modify;
                            Message('The payment process completed successfully.');
                        end else Error('The payment did not go through successfully');
                    end;
                    
                end;
            }
            action(RejectRecord)
            {
                Caption = 'Reject Record';
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                Enabled = not canCreate and (not rec."FR Fee Paid");
                Visible = false;
                
                trigger OnAction()
                begin
                    if Rec."Reason For Rejection" <> '' then begin
                        Rec."Processing Status":= rec."Processing Status"::Rejected;
                        rec."Approval Status":= rec."Approval Status"::Rejected;
                        rec.modify;
                    end else Error('Kindly fill in the reason for rejection.');
                end;
            }
        }
    }

    trigger OnAfterGetRecord() begin
        SetControlAppearance();

        nokVisible:= false;
        if rec."Next of Kin Deceased" = true then begin
            nokVisible:= true;
        end else nokVisible:= false;
    end;
    trigger OnAfterGetCurrRecord() begin
        SetControlAppearance();

        nokVisible:= false;
        if rec."Next of Kin Deceased" = true then begin
            nokVisible:= true;
        end else nokVisible:= false;
    end;

    local procedure SetControlAppearance()
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    begin
        OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Rec.RecordId);
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(Rec.RecordId);
        if rec."Approval Status" = rec."Approval Status"::Open then begin
            canSendApproval := True;
            canCreate := false;
        end
        else if Rec."Approval Status" = Rec."Approval Status"::Approved then begin
            canSendApproval := false;
            canCreate := true;
        end
        else begin
            canSendApproval := false;
            canCreate := false
        end;
    end;

    var
    noOfRecords: Integer;
    nokVisible: Boolean;
    OpenApprovalEntriesExist: Boolean;
    EnabledApprovalWorkflowsExist: Boolean;
    CanCancelApprovalForRecord: Boolean;
    OpenApprovalEntriesExistForCurrUser: Boolean;
    canSendApproval: Boolean;
    canCreate: Boolean;
    factBoxEnable: Boolean;
    lineNo: Integer;
    payment: Decimal;
    docNo: Code[30];
    batchName: Code[20];
    batchTemplate: Code[20];
    FRFeeAccount: Code[20];
    workflowInt: Codeunit WorkflowIntegration;
    AUFactory: Codeunit "Au Factory";
    saccoGenSetup: Record "Sacco General Set-Up";
    GenBatches: Record "Gen. Journal Batch";
    GenJournalLine: Record "Gen. Journal Line";
    cust: Record Customer;
    vend: Record Vendor;
    detVend: Record "Detailed Vendor Ledg. Entry";
    docFactbox: Record "Document Attachment";
}


