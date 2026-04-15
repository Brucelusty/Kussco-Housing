page 51020 "Defauter Card"
{
    ApplicationArea = All;
    PageType = Card;
    DeleteAllowed = false;
    InsertAllowed = false;
    SourceTable = "Loans Register";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Loan  No.";Rec."Loan  No.")
                {
                    Editable = false;
                }
                field("Application Date";Rec."Application Date")
                {
                    Editable = false;
                }
                field("Client Code";Rec."Client Code")
                {
                    Editable = false;
                }
                field("Client Name";Rec."Client Name")
                {
                }
                field("Staff No";Rec."Staff No")
                {
                    Editable = false;
                }
                field("Loan Product Type";Rec."Loan Product Type")
                {
                    Editable = false;
                }
                field("Loan Product Type Name";Rec."Loan Product Type Name")
                {
                    Editable = false;
                }
                field("Loans Referee 1 Mobile No.";Rec."Loans Referee 1 Mobile No.")
                {
                    Editable = false;
                }
                field("Approved Amount";Rec."Approved Amount")
                {
                    Editable = false;
                }
                field(Installments;Rec.Installments)
                {
                }
                field("Loans Category";Rec."Loans Category")
                {
                    Editable = false;
                }
                field("Loans Category-SASRA";Rec."Loans Category-SASRA")
                {
                    Editable = false;
                }
                // field("Oustanding Interest";Rec."Oustanding Interest")
                // {
                // }
                field("Outstanding Balance";Rec."Outstanding Balance")
                {
                }
                field("Issued Date";Rec."Issued Date")
                {
                    Editable = false;
                }
                // field("Defaulted Balance";Rec."Defaulted Balance")
                // {
                //     Editable = false;
                // }
                field("Loan Debt Collector";Rec."Loan Debt Collector")
                {
                    Caption='Loan Officer';
                }
                field("Debt Collectors Name";Rec."Debt Collector Name")
                {
                    Caption='Loan Officer Name';
                }
                field("Debtor Collection Status";Rec."Debtor Collection Status")
                {
                    Visible=false;
                }
                field("Payment Due Date";Rec."Payment Due Date")
                {
                    Caption = 'Agreed Payment Start Date';
                }
                field("Notification Date";Rec."Notification Date")
                {
                }
                field("Agreed Amount";Rec."Agreed Amount")
                {

                }
                field("1st Notice";Rec."1st Notice")
                {
                    Editable = false;
                }
                field("2nd Notice";Rec."2nd Notice")
                {
                    Editable = false;
                }
                field("Final Notice";Rec."Final Notice")
                {
                    Editable = false;
                }
            }
        }
        area(FactBoxes)
        {
            systempart(Control1905767507; Notes)
            {
            }part(Control14; "Member Statistics FactBox")
            {
                Caption = 'Member Statistics FactBox';
                SubPageLink = "No." = field("Client Code");
            }
            part(Control13; "Member Picture-Uploaded")
            {
                Caption = 'Picture';
                Editable = false;
                Enabled = false;
                ShowFilter = false;
                SubPageLink = "No." = field("Client Code");
            }
            part(Control12; "Member Signature-Uploaded")
            {
                Caption = 'Signature';
                Editable = false;
                Enabled = false;
                SubPageLink = "No." = field("Client Code");
            }
            part(Control555; "Member FrontID-Uploaded")
            {
                Caption = 'Front ID';
                Editable = false;
                Enabled = false;
                SubPageLink = "No." = field("Client Code");
            }
            part(Control556; "Member BackID-Uploaded")
            {
                Caption = 'Back ID';
                Editable = false;
                Enabled = false;
                SubPageLink = "No." = field("Client Code");
            }
        }
    }

    actions
    {
        area(Processing)
        {
            
            action("Send 1st  Notice")
            {
                Caption = 'Send Reminder SMS';
                Image = Alerts;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    vend.Reset();
                    vend.SetRange("BOSA Account No", rec."Client Code");
                    vend.SetRange("Account Type", '103');
                    if vend.Find('-') then begin
                        notice:= 'Dear '+vend.Name+'. This is a reminder on your '+rec."Loan Product Type Name"+' loan repayment of '+Format(rec."Agreed Amount")+' by '+Format(rec."Notification Date")+'. Kindly contact 0205029204/211. for further assistance.';
                        smsManagement.SendSmsWithID(Source::LOAN_DEFAULTED, vend."Mobile Phone No", notice, vend."BOSA Account No", vend."No.", true, 240, true, 'CBS', CreateGuid(),'CBS');
                    end;
                end;
            }
        }
    }
    var
    notice: Text[1800];
    Source: Option NEW_MEMBER,NEW_ACCOUNT,LOAN_ACCOUNT_APPROVAL,DEPOSIT_CONFIRMATION,CASH_WITHDRAWAL_CONFIRM,LOAN_APPLICATION,LOAN_APPRAISAL,LOAN_GUARANTORS,LOAN_REJECTED,LOAN_POSTED,LOAN_DEFAULTED,SALARY_PROCESSING,TELLER_CASH_DEPOSIT,TELLER_CASH_WITHDRAWAL,TELLER_CHEQUE_DEPOSIT,FIXED_DEPOSIT_MATURITY,INTERACCOUNT_TRANSFER,ACCOUNT_STATUS,STATUS_ORDER,EFT_EFFECTED,ATM_APPLICATION_FAILED,ATM_COLLECTION,MBANKING,MEMBER_CHANGES,CASHIER_BELOW_LIMIT,CASHIER_ABOVE_LIMIT,INTERNETBANKING,CRM,MOBILE_PIN,WITHDRAWAL,LOAN_REMINDER,PIGGY_BANK,MEMBER_EXIT,ESS_REFUND,FIXED_DEPOSIT;
    smsManagement: Codeunit "Sms Management";
    cust: Record Customer;
    vend: Record Vendor;
    LoanApp: Record "Loans Register";
}

