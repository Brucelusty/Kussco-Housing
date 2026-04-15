page 50034 "Registered Notice Card"
{
    ApplicationArea = All;
    PageType = Card;
    UsageCategory = Lists;
    SourceTable = "Withdrawal Notice";
    DeleteAllowed = false;
    InsertAllowed = false;
    // Editable = false;

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                }
                field("Member No"; Rec."Member No")
                {
                    Editable = false;
                }
                field(Name; Rec.Name)
                {
                }
                field("Withdrawal Type";Rec."Withdrawal Type")
                {
                    Editable = false;
                }
                field("Notice Date";Rec."Notice Date")
                {
                }
                field("Maturity Date";Rec."Maturity Date")
                {
                }
                field("Notice Status";Rec."Notice Status")
                {
                }
                field("Reason for Exit";Rec."Reason for Exit")
                {
                }
                field("Reason for Deceased";Rec."Reason for Deceased")
                {
                }
                field("Marked Deceased By";Rec."Marked Deceased By")
                {
                    Editable = false;
                }

            }
        }
        
        area(FactBoxes)
        {
            part(Control1000000052; "Member Statistics FactBox")
            {
                Caption = 'Member Statistics FactBox';
                SubPageLink = "No." = field("Member No");
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Return to Registration")
            {
                Image = ReverseRegister;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                PromotedIsBig = true;
                Enabled = not Rec.Matured;

                trigger OnAction()
                begin
                    if (rec.Matured = true) or (rec."Maturity Date" <=Today) then Error('This exit cannot be returned to registration since it has already matured.');

                    if cust.get(rec."Member No") then begin
                        cust."Membership Status":= cust."Previous Status";
                        cust.Modify();
                        
                        rec."Approval Status":= rec."Approval Status"::New;
                        rec."Notice Status":= rec."Notice Status"::Initiated;
                        rec."Maturity Date":= 0D;
                        rec."Notice Date":= 0D;
                        Rec.Modify();
                    end;
                end;
            }
            
            action("Proceed")
            {
                Image = Continue;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                PromotedIsBig = true;
                Enabled = not Rec.Matured;

                trigger OnAction()
                begin
                    if rec."Maturity Date" <= Today then begin
                        rec.Matured:= true;
                        rec."Notice Status":= rec."Notice Status"::Matured;
                        rec.Modify;
                        Message('You can successfully proceed with processing this member''s exit.');
                    end else Error('This notice has not reached its maturity date of %1.', rec."Maturity Date");
                end;
            }

            action("Mark As Deceased")
            {
                Image = RemoveContacts;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                PromotedIsBig = true;
                // Enabled = not Rec.Matured;

                trigger OnAction()
                begin
                    if Confirm('Do you wish to mark this withdrawal case as one of Death Nature?', true) = false then exit;

                    Cust.Reset();
                    Cust.SetRange("No.", Rec."Member No");
                    if Cust.Find('-') then begin
                        Cust."Membership Status" := Cust."Membership Status"::Deceased;
                        cust.Modify;
                    end;
                    
                    Rec.TestField("Reason for Deceased");
                    Rec."Marked Deceased By" := UserId;
                    Rec."Withdrawal Type" := Rec."Withdrawal Type"::Death;
                    Rec.Modify;
                end;
            }
            
        }
        area(Reporting)
        {
            action("Withdrawal Slip")
            {
                Image = Entries;
                Promoted = true;
                PromotedCategory = Report;
                PromotedOnly = true;
                trigger OnAction()
                begin

                    Cust.Reset;
                    Cust.SetRange(Cust."No.", Rec."Member No");
                    if Cust.Find('-') then
                        Report.Run(175079, true, false, Cust);
                end;
            }
            action("Check Guarantorship")
            {
                Image = "Report";
                Promoted = true;
                PromotedCategory = Report;
                PromotedOnly = true;

                trigger OnAction()
                var
                begin

                    if cust.Get(Rec."Member No") then begin
                        Cust.CalcFields("No of Loans Guaranteed", "Total Committed Shares");

                        if currentLiability > 0 then begin
                            Message('The member %1 has a total guaranteed amount of %2 for %3 loans.', Rec."Member No", currentLiability, cust."No of Loans Guaranteed");
                        end;
                    end;

                    Cust.Reset;
                    Cust.SetRange(Cust."No.", Rec."Member No");
                    if Cust.Find('-') then
                        Report.Run(80009, true, false, Cust);
                end;
            }
            action("Check Loans")
            {
                Image = StatisticsDocument;
                Promoted = true;
                PromotedCategory = Report;
                PromotedOnly = true;

                trigger OnAction()
                begin
                    if cust.Get(Rec."Member No") then begin
                        Cust.CalcFields("Total Loan Balance");
                        if Cust."Total Loan Balance" > 0 then begin
                            Message('The member %1 has a total loan balance of %2.', Rec."Member No", Cust."Total Loan Balance");
                        end;
                    end;

                    loanReg.Reset;
                    loanReg.SetRange(loanReg."Client Code", Rec."Member No");
                    if loanReg.Find('-') then
                        Report.Run(175077, true, false, loanReg);
                end;
            }
        }
    }
    trigger OnAfterGetRecord() begin
        currentLiability:= 0;
        guarDetails.Reset();
        guarDetails.SetRange("Member No", Rec."Member No");
        guarDetails.SetRange(Substituted, false);
        if guarDetails.Find('-') then begin
            repeat
                loanReg.Reset();
                loanReg.SetRange("Loan  No.", guarDetails."Loan No");
                loanReg.SetFilter("Outstanding Balance", '>%1',0);
                if loanReg.Find('-') then begin
                    loanReg.CalcFields("Outstanding Balance");
                    currentLiability := currentLiability + (Round(((loanReg."Outstanding Balance"/loanReg."Approved Amount")*guarDetails."Amont Guaranteed"), 0.01, '='));
                end;
            until guarDetails.Next() = 0;
        end;
    end;

    var
    currentLiability: Decimal;
    Cust: Record Customer;
    guarDetails: Record "Loans Guarantee Details";
    loanReg: Record "Loans Register";
}


