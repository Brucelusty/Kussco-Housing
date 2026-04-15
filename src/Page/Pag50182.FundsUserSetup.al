//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50182 "Funds User Setup"

{
    ApplicationArea = All;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "Funds User Setup";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(UserID; Rec.UserIDS)
                {
                }
                field("Receipt Journal Template";Rec."Receipt Journal Template")
                {
                }
                field("Receipt Journal Batch";Rec."Receipt Journal Batch")
                {
                }
                field("Payment Journal Template";Rec."Payment Journal Template")
                {
                }
                field("Payment Journal Batch";Rec."Payment Journal Batch")
                {
                }
                field("Petty Cash Template";Rec."Petty Cash Template")
                {
                }
                field("Petty Cash Batch";Rec."Petty Cash Batch")
                {
                }
                field("FundsTransfer Template Name";Rec."FundsTransfer Template Name")
                {
                }
                field("FundsTransfer Batch Name";Rec."FundsTransfer Batch Name")
                {
                }
                field("Default Receipts Bank";Rec."Default Receipts Bank")
                {
                }
                field("Default Payment Bank";Rec."Default Payment Bank")
                {
                }
                field("Default Petty Cash Bank";Rec."Default Petty Cash Bank")
                {
                }
                field("Max. Cash Collection";Rec."Max. Cash Collection")
                {
                }
                field("Max. Cheque Collection";Rec."Max. Cheque Collection")
                {
                }
                field("Max. Deposit Slip Collection";Rec."Max. Deposit Slip Collection")
                {
                }
                field("Supervisor ID";Rec."Supervisor ID")
                {
                }
                field("Bank Pay In Journal Template";Rec."Bank Pay In Journal Template")
                {
                }
                field("Bank Pay In Journal Batch";Rec."Bank Pay In Journal Batch")
                {
                }
                field("Imprest Template";Rec."Imprest Template")
                {
                }
                field("Imprest  Batch";Rec."Imprest  Batch")
                {
                }
                field("Claim Template";Rec."Claim Template")
                {
                }
                field("Claim  Batch";Rec."Claim  Batch")
                {
                }
                field("Advance Template";Rec."Advance Template")
                {
                }
                field("Advance  Batch";Rec."Advance  Batch")
                {
                }
                field("Advance Surr Template";Rec."Advance Surr Template")
                {
                }
                field("Advance Surr Batch";Rec."Advance Surr Batch")
                {
                }
                field("Dim Change Journal Template";Rec."Dim Change Journal Template")
                {
                }
                field("Dim Change Journal Batch";Rec."Dim Change Journal Batch")
                {
                }
                field("Journal Voucher Template";Rec."Journal Voucher Template")
                {
                }
                field("Journal Voucher Batch";Rec."Journal Voucher Batch")
                {
                }
                field("Post Payment Voucher";Rec."Post Payment Voucher")
                {
                }
                field("Post Cash Voucher";Rec."Post Cash Voucher")
                {
                }
                field("Post Money Voucher";Rec."Post Money Voucher")
                {
                }
                field("Post Petty Cash";Rec."Post Petty Cash")
                {
                }
                field("Post Receipt";Rec."Post Receipt")
                {
                }
                field("Post Funds Withdrawal";Rec."Post Funds Withdrawal")
                {
                }
                field("Post Funds Transfer";Rec."Post Funds Transfer")
                {
                }
                field("Post Imprest";Rec."Post Imprest")
                {
                }
                field("Post Imprest Accounting";Rec."Post Imprest Accounting")
                {
                }
                field("Post Claims";Rec."Post Claims")
                {
                }
                field("Post Member Bills";Rec."Post Member Bills")
                {
                }
                field("Post CPD Bills";Rec."Post CPD Bills")
                {
                }
                field("Reverse Payment Voucher";Rec."Reverse Payment Voucher")
                {
                }
                field("Reverse Cash Voucher";Rec."Reverse Cash Voucher")
                {
                }
                field("Reverse Money Voucher";Rec."Reverse Money Voucher")
                {
                }
                field("Reverse Petty Cash";Rec."Reverse Petty Cash")
                {
                }
                field("Reverse Receipt";Rec."Reverse Receipt")
                {
                }
                field("Reverse Funds Withdrawal";Rec."Reverse Funds Withdrawal")
                {
                }
                field("Reverse Funds Transfer";Rec."Reverse Funds Transfer")
                {
                }
                field("Reverse Imprest";Rec."Reverse Imprest")
                {
                }
                field("Reverse Imprest Accounting";Rec."Reverse Imprest Accounting")
                {
                }
                field("Reverse Claims";Rec."Reverse Claims")
                {
                }
                field("Reverse Member Bills";Rec."Reverse Member Bills")
                {
                }
                field("Reverse CPD Bills";Rec."Reverse CPD Bills")
                {
                }
            }
        }
    }

    actions
    {
    }
}






