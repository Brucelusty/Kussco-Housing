page 65728 "Follow Up Card"
{
    ApplicationArea = All;
    PageType = Card;
    SourceTable = "Loans Register";
    UsageCategory = Administration;
    Caption = 'Defaulter Case';
    PromotedActionCategories = 'Process';
    InsertAllowed = false;

    layout
    {
        area(Content)
        {
            group(General)
            {

                field("Loan  No."; Rec."Loan  No.") { Editable = false; }
                field("Borrower No."; Rec."Client Code") { Editable = false; }
                field("Borrower Name"; Rec."Client Name") { Editable = false; }
                field("Loan Disbursement Date"; Rec."Loan Disbursement Date") { }
                field("Repayment Start Date"; Rec."Repayment Start Date") { }
                field("Expected Date of Completion"; Rec."Expected Date of Completion") { }
                field("Portfolio Officer"; Rec."Portfolio Officer") { Editable = false; }
                field("Recovery Stage"; Rec."Recovery Stage") { Editable = false; }
                field("Loan Status"; Rec."Loan Status") { }
            }
            group("Spouse Details")
            {
                field("Spouse Name"; Rec."Spouse Name") { Editable = false; }
                field("Spouse Email Address"; Rec."Spouse Email Address") { Editable = false; }
                field("Spouse Phone No"; Rec."Spouse Phone No") { Editable = false; }
            }
            group("Alternative Details")
            {
                field("Alternative Name"; Rec."Alternative Name") { Editable = false; }
                field("Alternative Email Address"; Rec."Alternative Email Address") { Editable = false; }
                field("Alternative Phone No"; Rec."Alternative Phone No") { Editable = false; }
            }
            group("Arrears Details")
            {
                field("Outstanding Amount"; Rec."Outstanding Balance") { Editable = false; }
                field("Days in Arrears"; Rec."Days In Arrears") { }
                field("Arrears Bucket"; Rec."Arrears Bucket") { }
            }


            part("Collateral Details"; "Loan Collateral Security")
            {
                SubPageLink = "Loan No" = FIELD("Loan  No.");
            }


            part(Communication; "Defaulter Communication")
            {
                SubPageLink = "Case No." = FIELD("Loan  No.");
            }

            part(InternalRecovery; "Statutory Notice")
            {
                SubPageLink = "Case No." = FIELD("Loan  No.");
                Caption = 'Internal Recovery';
            }
            part(PaymentPlan; "Payment Plan")
            {
                SubPageLink = "Case No." = FIELD("Loan  No.");
                Caption = 'Payment Plan (Internal)';
            }

            part(Notices; "Statutory Notice(legal)")
            {
                SubPageLink = "Case No." = FIELD("Loan  No.");
                Caption = 'Legal Recovery';
            }

            part("PaymentPlanLegal"; "Payment Plan(Legal)")
            {
                SubPageLink = "Case No." = FIELD("Loan  No.");
                Caption = 'Payment Plan (Legal)';
            }

            part(Auction; "Auction Subpage")
            {
                SubPageLink = "Case No." = FIELD("Loan  No.");
            }
        }

        area(FactBoxes)
        {
            part(Control14; "Member Statistics FactBox")
            {
                Caption = 'Member Statistics FactBox';//
                SubPageLink = "No." = field("Client Code");
            }
        }
    }

    actions
    {
        area(Processing)
        {
            group("Escalation")
            {
                action("Evaluate Escalation")
                {
                    Image = Calculate;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        Codeunit.Run(131103, Rec); // Escalation Engine
                    end;
                }

                action("Suspend Case")
                {
                    Image = Pause;
                    Promoted = true;
                    PromotedCategory = Category4;
                }
            }


            action(Attachments)
            {
                Caption = 'Attachments';
                Image = Attach;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    CaseAttachments: Page "Case Attachment Page";
                begin
                    CaseAttachments.SetLoanNo(Rec."Loan  No.");
                    CaseAttachments.RunModal();
                end;
            }

            group("Communication.")
            {
                action("Log Communication")
                {
                    Image = Phone;
                    Promoted = true;
                    PromotedCategory = Category5;
                }
            }

            group("Legal")
            {
                action("Generate Notice")
                {
                    Image = Print;
                    Promoted = true;
                    PromotedCategory = Category6;
                }

                action("Create Auction")
                {
                    Image = Auction;
                    Promoted = true;
                    PromotedCategory = Category6;
                }
            }

            group("Committee")
            {
                action("Submit Payment Plan")
                {
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category4;
                }
            }
        }
    }
}


