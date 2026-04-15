page 51076 "BOD Payments Card"
{
    ApplicationArea = All;
    PageType = Card;
    UsageCategory = Lists;
    PromotedActionCategories = 'New,Process,Report,Approvals';
    SourceTable = "BOD Honoraria";
    // DeleteAllowed = false;
    
    layout
    {
        area(Content)
        {
            group(GroupName)
            {
                field("Honoraria No";Rec."Honoraria No")
                {
                }
                field(Description;Rec.Description)
                {
                    ShowMandatory = true;
                    Editable = (Rec."Approval Status" = Rec."Approval Status"::Open);
                }
                field("Cheque No";Rec."Cheque No")
                {
                    ShowMandatory = true;
                    Editable = (Rec."Approval Status" = Rec."Approval Status"::Open);
                }
                field("Total Expected Amount";Rec."Total Expected Amount")
                {
                    ShowMandatory = true;
                    Editable = (Rec."Approval Status" = Rec."Approval Status"::Open);
                }
                field("Total Amount";Rec."Total Amount")
                {
                    Style = StrongAccent;
                }
                field("Total Count";Rec."Total Count")
                {
                    Style = Subordinate;
                }
                field("Initiated On";Rec."Initiated On")
                {
                }
                field("Approval Status";Rec."Approval Status")
                {
                    Style = Strong;
                }
                field(Paid;Rec.Paid)
                {
                }
                field("Posted On";Rec."Posted On")
                {
                }
            }
            part(HonorariaLines; "BOD Honoraria Lines")
            {
                SubPageLink = "No." = field("Honoraria No");
                Editable = (Rec."Approval Status" = Rec."Approval Status"::Open);
                
            }
        }
        area(Factboxes)
        {
            
        }
    }
    
    actions
    {
        area(Processing)
        {
            action(SendApproval)
            {
                Caption = 'Send Approval Request';
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Category4;
                Enabled = rec."Approval Status" = rec."Approval Status"::Open;
                
                trigger OnAction()
                begin
                    Rec.TestField(Description);
                    rec.CalcFields("Total Amount");
                    if rec."Total Amount" <> rec."Total Expected Amount" then Error('Ensure the amount allocated to each board member sums up to the total expected amount.');

                    workflowInt.CheckBODHonorariumApprovalsWorkflowEnabled(Rec);
                    workflowInt.OnSendBODHonorariumForApproval(Rec);
                end;
            }
            action(CancelApproval)
            {
                Caption = 'Cancel Approval Request';
                Image = CancelApprovalRequest;
                Promoted = true;
                PromotedCategory = Category4;
                Enabled = rec."Approval Status" = rec."Approval Status"::Pending;
                
                trigger OnAction()
                begin
                    workflowInt.CheckBODHonorariumApprovalsWorkflowEnabled(Rec);
                    workflowInt.OnCancelBODHonorariumApprovalRequest(Rec);
                end;
            }
            action(ApprovalEntries)
            {
                Caption = 'View Approval Request';
                Image = ApprovalSetup;
                Promoted = true;
                PromotedCategory = Category4;
                Enabled = rec."Approval Status" = rec."Approval Status"::Pending;

                trigger OnAction()
                begin
                    approvalEntries.SetRecordFilters(Database::"BOD Honoraria", approvalDoc::BODHonorarium, rec."Honoraria No");
                    approvalEntries.Run();
                end;
            }

            action(Post)
            {
                Caption = 'Post Honoraria';
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                PromotedIsBig = true;
                Enabled = rec."Approval Status" = rec."Approval Status"::Approved;
                
                trigger OnAction()
                begin
                    lineNo := 0;
                    batchTemplate := 'PAYMENTS';
                    batchName := 'HONORARIA';

                    GenJournalLine.Reset();
                    GenJournalLine.SetRange("Journal Template Name", batchTemplate);
                    GenJournalLine.SetRange("Journal Batch Name", batchName);
                    if GenJournalLine.FindSet() then begin
                        GenJournalLine.DeleteAll();
                    end;

                    GenBatches.Reset();
                    GenBatches.SetRange("Journal Template Name", batchTemplate);
                    GenBatches.SetRange(Name, batchName);
                    if GenBatches.Find('-') = false then begin
                        GenBatches.Init();
                        GenBatches."Journal Template Name" := batchTemplate;
                        GenBatches.Name := batchName;
                        GenBatches.Description := 'BOD Honoraria Payment';
                        GenBatches.Insert();
                    end;

                    fundSetup.Get();
                    if (fundSetup."PAYE Honoraria Account" <> '') and (fundSetup."Committee Honoraria Account" <> '') then begin
                        BODLines.Reset();
                        BODLines.SetRange("No.", rec."Honoraria No");
                        if BODLines.Find('-') then begin
                            repeat
                                PayHonoraria(Rec."Honoraria No", BODLines."FOSA Account", fundSetup."PAYE Honoraria Account", fundSetup."Committee Honoraria Account", BODLines."PAYE Amount", BODLines."Net Amount");
                                smsMessage:= 'Dear '+nameStyle.NameStyle(BODLines.BOD)+', your Board Honorarium of Kshs.'+Format(BODLines."Net Amount")+' has been processed and successfully posted to your FOSA A/C.';
                                smsManagement.SendSmsWithID(Source::BOD_HONORARIA, BODLines."Mobile Phone No", smsMessage, BODLines."FOSA Account", BODLines."FOSA Account", false, 225, false, 'CBS', CreateGuid(), 'CBS');
                            until BODLines.Next()= 0;

                            GenJournalLine.Reset();
                            GenJournalLine.SetRange("Journal Template Name", batchTemplate);
                            GenJournalLine.SetRange("Journal Batch Name", batchName);
                            if GenJournalLine.Find('-') then begin
                                Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco", GenJournalLine);
                            end;
                            
                            rec."Posted By" := UserId;
                            rec."Posted On" := Today;
                            rec.Paid := true;
                            rec.modify;
                        end;
                    end;
                end;
            }
        }
    }
    var
    lineNo: Integer;
    smsMessage: Text[1500];
    docNo: Code[30];
    batchName: Code[20];
    batchTemplate: Code[20];
    Source: Option NEW_MEMBER,NEW_ACCOUNT,LOAN_ACCOUNT_APPROVAL,DEPOSIT_CONFIRMATION,CASH_WITHDRAWAL_CONFIRM,LOAN_APPLICATION,LOAN_APPRAISAL,LOAN_GUARANTORS,LOAN_REJECTED,LOAN_POSTED,LOAN_DEFAULTED,SALARY_PROCESSING,TELLER_CASH_DEPOSIT,TELLER_CASH_WITHDRAWAL,TELLER_CHEQUE_DEPOSIT,FIXED_DEPOSIT_MATURITY,INTERACCOUNT_TRANSFER,ACCOUNT_STATUS,STATUS_ORDER,EFT_EFFECTED,ATM_APPLICATION_FAILED,ATM_COLLECTION,MBANKING,MEMBER_CHANGES,CASHIER_BELOW_LIMIT,CASHIER_ABOVE_LIMIT,INTERNETBANKING,CRM,MOBILE_PIN,WITHDRAWAL,LOAN_REMINDER,PIGGY_BANK,MEMBER_EXIT,ESS_REFUND,FIXED_DEPOSIT,BOD_HONORARIA;
    approvalDoc: Enum "Approval Document Type";
    approvalEntries: Page "Approval Entries";
    AUFactory: Codeunit "Au Factory";
    smsManagement: Codeunit "Sms Management";
    nameStyle: Codeunit "SMS Reminders";
    workflowInt: Codeunit WorkflowIntegration;
    BODLines: Record "BOD Honoraria Lines";
    fundSetup: Record "Funds General Setup";
    GenBatches: Record "Gen. Journal Batch";
    GenJournalLine: Record "Gen. Journal Line";
    vend: Record Vendor;


    local procedure PayHonoraria(honorarium: Code[20]; fosa: Code[20]; paye: Code[20]; honoraria: Code[20]; payeAmount: Decimal; netAmount: Decimal)
    var
        myInt: Integer;
    begin
        docNo := honorarium;

        if vend.Get(fosa) then begin
            lineNo:= lineNo + 1000;
            AUFactory.FnCreateGnlJournalLines(batchTemplate, batchName, docNo, lineNo, GenJournalLine."Transaction Type"::" ",
             GenJournalLine."Account Type"::"G/L Account", honoraria, Today, (netAmount+payeAmount), '', 'Committee Honoraria-'+Rec.Description, '');
             //-------------------------------------------------------->-CREDIT COMMITTEE HONORARIA A/C-<----------------------------------------------------

            lineNo:= lineNo + 1000;
            AUFactory.FnCreateGnlJournalLines(batchTemplate, batchName, docNo, lineNo, GenJournalLine."Transaction Type"::" ",
             GenJournalLine."Account Type"::Vendor, fosa, Today, (netAmount+payeAmount)*-1, '', 'Committee Honoraria-'+Rec.Description, '');
             //-------------------------------------------------------->-DEBIT FOSA A/C-<--------------------------------------------------------------------
            
            lineNo:= lineNo + 1000;
            AUFactory.FnCreateGnlJournalLines(batchTemplate, batchName, docNo, lineNo, GenJournalLine."Transaction Type"::" ",
             GenJournalLine."Account Type"::Vendor, fosa, Today, (payeAmount), '', 'Committee Honoraria (PAYE)-'+Rec.Description, '');
             //-------------------------------------------------------->-CREDIT FOSA A/C -PAYE- -<----------------------------------------------------

            lineNo:= lineNo + 1000;
            AUFactory.FnCreateGnlJournalLines(batchTemplate, batchName, docNo, lineNo, GenJournalLine."Transaction Type"::" ",
             GenJournalLine."Account Type"::"G/L Account", paye, Today, (payeAmount)*-1, '', 'Committee Honoraria (PAYE)-'+Rec.Description, '');
             //-------------------------------------------------------------->-DEBIT PAYE A/C-<---------------------------------------------------------------
        end;
    end;

}


