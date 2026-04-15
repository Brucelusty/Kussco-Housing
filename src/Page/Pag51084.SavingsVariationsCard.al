page 51084 "Savings Variations Card"
{
    ApplicationArea = All;
    PageType = Card;
    UsageCategory = Lists;
    PromotedActionCategories = 'New,Process,Report,Approvals';
    SourceTable = "Savings Variation";
    
    layout
    {
        area(Content)
        {
            Group(General)
            {
                field("Variation No";Rec."Variation No")
                {}
                field("Member No";Rec."Member No")
                {
                    // Editable = canEdit;
                }
                field("Member Name";Rec."Member Name")
                {}
                field("Savings Account Type";Rec."Savings Account Type")
                {
                    // Editable = canEdit;
                }
                field("Account Type";Rec."Account Type")
                {}
                field("Approval Status";Rec."Approval Status")
                {}
                field("Old Savings";Rec."Old Savings")
                {}
                field("New Savings";Rec."New Savings")
                {
                    // Editable = canEdit;
                }
                field("Reason for Change";Rec."Reason for Change")
                {
                    MultiLine = true;
                    // Editable = canEdit;
                }
                field(Updated;Rec.Updated)
                {}
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
                Caption = 'Send For Approval';
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedOnly = true;
                Enabled = (Rec."Approval Status" = Rec."Approval Status"::New);
                
                trigger OnAction()
                begin
                    Rec.TestField("New Savings");
                    Rec.TestField("Approval Status", Rec."Approval Status"::New);

                    workflowInt.CheckSavingsVarApprovalsWorkflowEnabled(Rec);
                    workflowInt.OnSendSavingsVarDocForApproval(Rec);
                end;
            }
            action(CancelApproval)
            {
                Caption = 'Cancel Approval Request';
                Image = CancelApprovalRequest;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedOnly = true;
                Enabled = (Rec."Approval Status" = Rec."Approval Status"::"Pending Approval");
                
                trigger OnAction()
                begin
                    Rec.TestField("Approval Status", Rec."Approval Status"::"Pending Approval");

                    workflowInt.CheckSavingsVarApprovalsWorkflowEnabled(Rec);
                    workflowInt.OnCancelSavingsVarApprovalRequest(Rec);
                end;
            }
            action(ApprovalEntries)
            {
                Caption = 'Approval Entries';
                Image = Approvals;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedOnly = true;
                Enabled = (Rec."Approval Status" = Rec."Approval Status"::"Pending Approval");
                
                trigger OnAction()
                begin
                    approvalEntries.SetRecordFilters(Database::"Savings Variation", approvalDoc::SavingsVariation, Rec."Variation No");
                    approvalEntries.Run();
                end;
            }

            action(UpdateChanges)
            {
                Caption = 'Vary Savings';
                Image = UpdateUnitCost;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                Enabled = not (Rec.Updated);
                Visible = (Rec."Approval Status" = Rec."Approval Status"::Approved);
                
                trigger OnAction()
                begin
                    savingsAccounts.Reset();
                    savingsAccounts.SetRange(Code, Rec."Savings Account Type");
                    if savingsAccounts.Find('-') then begin
                        if savingsAccounts.Code = '101' then begin
                            if cust.Get(Rec."Member No") then begin
                                cust."Share Capital Contribution" := Rec."New Savings";
                                cust.Modify;
                                
                                Rec.Updated:= true;
                                Rec.Modify;
                                Message('Success');
                            end;
                        end else if savingsAccounts.Code = '102' then begin
                            if cust.Get(Rec."Member No") then begin
                                cust."Monthly Contribution" := Rec."New Savings";
                                cust.Modify;
                                
                                Rec.Updated:= true;
                                Rec.Modify;
                                Message('Success');
                            end;
                        end else if savingsAccounts.Code = '104' then begin
                            if cust.Get(Rec."Member No") then begin
                                cust."ESS Contribution" := Rec."New Savings";
                                cust.Modify;
                                
                                Rec.Updated:= true;
                                Rec.Modify;
                                Message('Success');
                            end;
                        end else if savingsAccounts.Code = '106' then begin
                            if cust.Get(Rec."Member No") then begin
                                cust."Jibambe Savings Contribution" := Rec."New Savings";
                                cust.Modify;
                                
                                Rec.Updated:= true;
                                Rec.Modify;
                                Message('Success');
                            end;
                        end else if savingsAccounts.Code = '107' then begin
                            if cust.Get(Rec."Member No") then begin
                                cust."Wezesha Savings Contribution" := Rec."New Savings";
                                cust.Modify;
                                
                                Rec.Updated:= true;
                                Rec.Modify;
                                Message('Success');
                            end;
                        end else if savingsAccounts.Code = '109' then begin
                            if cust.Get(Rec."Member No") then begin
                                cust."Mdosi Jr Contribution" := Rec."New Savings";
                                cust.Modify;
                                
                                Rec.Updated:= true;
                                Rec.Modify;
                                Message('Success');
                            end;
                        end else if savingsAccounts.Code = '110' then begin
                            if cust.Get(Rec."Member No") then begin
                                cust."Pension Akiba Contribution" := Rec."New Savings";
                                cust.Modify;
                                
                                Rec.Updated:= true;
                                Rec.Modify;
                                Message('Success');
                            end;
                        end;
                    end;
                end;
            }
        }
    }

    trigger OnAfterGetCurrRecord() begin
        canEdit := false;
        if Rec."Approval Status" = Rec."Approval Status"::New then begin
            canEdit := true;
        end else begin
            canEdit := false;
        end;
    end;
    trigger OnAfterGetRecord() begin
        canEdit := false;
        if Rec."Approval Status" = Rec."Approval Status"::New then begin
            canEdit := true;
        end else begin
            canEdit := false;
        end;
    end;
    var
    canEdit: Boolean;
    approvalDoc: Enum "Approval Document Type";
    approvalEntries: Page "Approval Entries";
    workflowInt: Codeunit WorkflowIntegration;
    cust: Record Customer;
    savingsAccounts: Record "Account Types-Saving Products";
}


