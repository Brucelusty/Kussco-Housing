page 50021 "Notice Card"
{
    ApplicationArea = All;
    PageType = Card;
    UsageCategory = Administration;
    SourceTable = "Withdrawal Notice";

    layout
    {
        area(Content)
        {
            group(NoticeDetatils)
            {
                field("No."; Rec."No.")
                {
                }
                field("Member No"; Rec."Member No")
                {
                    ShowMandatory = True;
                }
                field(Name; Rec.Name)
                {
                }
                field("Withdrawal Type"; Rec."Withdrawal Type")
                {
                    ShowMandatory = True;
                }
                field("Phone No"; Rec."Phone No")
                {
                }
                field("Payroll No"; Rec."Payroll No")
                {
                }
                field("FOSA Account"; Rec."FOSA Account")
                {
                    Caption='Savings Account';
                }
                field("Notice Date"; Rec."Notice Date")
                {
                }
                field("Registration Date"; Rec."Registration Date")
                {
                    Editable = false;
                    Caption = 'Application Date';
                }
                field("Maturity Date"; Rec."Maturity Date")
                {
                    Editable = false;
                }
                field("Approval Status"; Rec."Approval Status")
                {
                }
                field("Notice Status"; Rec."Notice Status")
                {
                }
                field("Deposits to be deducted"; Rec."Deposits to be deducted")
                {
                }
                group(VolExit)
                {
                    Visible = rec."Withdrawal Type" <> rec."Withdrawal Type"::Death;
                    Caption = 'Reason for Exit';
                    field("Interview Done"; Rec."Interview Done")
                    {
                        ShowMandatory = True;
                    }
                    field("Reason for Exit"; Rec."Reason for Exit")
                    {
                        Editable = Rec."Interview Done";
                    }
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

            action("Register")
            {
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                PromotedIsBig = true;
                Image = MoveToNextPeriod;
                Enabled = (Rec."Withdrawal Type" <> Rec."Withdrawal Type"::" ");

                trigger OnAction()
                var
                    loans: Record "Loans Register";
                    Guarantee: record "Loans Guarantee Details";
                    AmountGuaranteed: Decimal;
                    Members: Record "Members Register";
                    OutstandingAmount: Decimal;
                begin
/*                     Cust.reset();
                    cust.SetRange("No.", Rec."Member No");
                    if cust.find('-') then begin
                        if Cust.Piccture.Count() = 0 then Error('Kindly ensure this member has a Picture.');
                        if Cust.Signature.Count() = 0 then Error('Kindly ensure this member has a Signature.');
                        if Cust."ID Front".Count() = 0 then Error('Kindly ensure this member has a front image of their ID.');
                        if Cust."ID Back".Count() = 0 then Error('Kindly ensure this member has a back image of their ID.');
                    end; */

                    if Rec."Withdrawal Type" = Rec."Withdrawal Type"::Voluntary then begin
                        if cust.Get(Rec."Member No") then begin
                            Cust.CalcFields("Current Shares", "Ordinary Savings", "Shares Retained", "Total Loan Balance", "No of Loans Guaranteed", "Total Committed Shares");
                            if Cust."Total Loan Balance" > Cust."Current Shares" then begin
                                Error('The member %1 has a total loan balance of %2 that cannot be fully offset by their deposits of %3.', Rec."Member No", Cust."Total Loan Balance", Cust."Current Shares");
                            end;
                            if currentLiability > Cust."Current Shares" then begin
                                Error('The member %1 has a total guaranteed amount of %2 for %3 loans.', Rec."Member No", currentLiability, cust."No of Loans Guaranteed");
                            end;

                        end;

                        if rec."Interview Done" = false then Error('The interview with the exiting member should be done prior to registering the exit.');

                        // AmountGuaranteed := 0;
                        // Guarantee.Reset();
                        // Guarantee.SetRange(Guarantee."Member No", Rec."Member No");
                        // Guarantee.SetRange(Guarantee.Substituted, false);
                        // // Guarantee.
                        // Guarantee.SetAutoCalcFields(Guarantee."Outstanding Balance");
                        // Guarantee.SetFilter(Guarantee."Outstanding Balance", '>%1', 0);
                        // if Guarantee.FindSet() then begin
                        //     repeat
                        //         loans.Get(Guarantee."Loan No");
                        //         if loans."Client Code" <> Guarantee."Member No" then begin
                        //             Error('Member %1 has an outstanding loan %2 you have guaranteed.', loans."Client Code", Guarantee."Loan No");
                        //         end;
                        //     //Guarantee.CalcSums(Guarantee."Amont Guaranteed");
                        //     //AmountGuaranteed := Guarantee."Amont Guaranteed";
                        //     until Guarantee.Next() = 0;
                        // end;
                        // //if AmountGuaranteed > 0 then Error('Member has an outstanding loan %1 he has guaranteed.',);


                        // Members.Reset;
                        // Members.SetRange(Members."No.", Rec."Member No");
                        // if Members.FindFirst() then begin
                        //     Members.CalcFields(Members."Current Savings");
                        //     loans.Reset();
                        //     loans.SetRange(Loans."Client Code", Members."No.");
                        //     loans.SetAutoCalcFields("Outstanding Balance");
                        //     loans.SetFilter(loans."Outstanding Balance", '>%1', 0);
                        //     if loans.FindSet() then begin
                        //         repeat
                        //             OutstandingAmount += loans."Outstanding Balance";
                        //         until loans.Next() = 0;
                        //     end;

                        //     if Members."Current Savings" < OutstandingAmount then
                        //         Error('Member has no enough deposits to cater for the oustanding loans');
                        // end;
                    end;
                    if Confirm('Do you wish to proceed with the exit process for this member? An SMS shall be sent.', false) = true then begin
                        Rec."Approval Status" := Rec."Approval Status"::Approved;
                        rec."Notice Status" := rec."Notice Status"::Registered;
                        if Cust.Get(rec."Member No") then begin
                            if rec."Withdrawal Type" <> rec."Withdrawal Type"::Death then begin
                                Cust."Membership Status" := cust."Membership Status"::"Awaiting Exit";
                            end;
                            exitNotif := 'Dear ' + rec.Name + '. Your exit application has been registered successfully.';
                            // smsManagement.SendSmsWithID(Source::MEMBER_EXIT, cust."Mobile Phone No", exitNotif, cust."No.", cust."FOSA Account No.", TRUE, 230, TRUE, 'CBS', CreateGuid(), 'CBS');
                            Cust.Modify();
                        end;
                         rec."Notice Date" := Today;
                         Rec."Notice Status":=Rec."Notice Status"::Registered;
                        //rec.Validate("Notice Date");
                        Rec.Modify();
                    end;
                    //end;
                end;
            }
            action("Check Guarantorship")
            {
                Image = "Report";
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                Enabled = (Rec."Withdrawal Type" <> Rec."Withdrawal Type"::" ");
                Visible = false;
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
                PromotedCategory = Process;
                PromotedOnly = true;
                Enabled = (Rec."Withdrawal Type" <> Rec."Withdrawal Type"::" ");
                Visible=false;

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
                        Report.Run(175076, true, false, loanReg);
                end;
            }
            action("Withdrawal Slip")
            {
                Image = Entries;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                Enabled = (Rec."Withdrawal Type" <> Rec."Withdrawal Type"::" ");

                trigger OnAction()
                begin

                    Cust.Reset;
                    Cust.SetRange(Cust."No.", Rec."Member No");
                    if Cust.Find('-') then
                        Report.Run(175078, true, false, Cust);
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        currentLiability := 0;
        guarDetails.Reset();
        guarDetails.SetRange("Member No", Rec."Member No");
        guarDetails.SetRange(Substituted, false);
        if guarDetails.Find('-') then begin
            repeat
                loanReg.Reset();
                loanReg.SetRange("Loan  No.", guarDetails."Loan No");
                loanReg.SetFilter("Outstanding Balance", '>%1', 0);
                if loanReg.Find('-') then begin
                    loanReg.CalcFields("Outstanding Balance");
                    currentLiability := currentLiability + (Round(((loanReg."Outstanding Balance" / loanReg."Approved Amount") * guarDetails."Amont Guaranteed"), 0.01, '='));
                end;
            until guarDetails.Next() = 0;
        end;
    end;

    var
        myInt: Integer;
        deduction: Boolean;
        currentLiability: Decimal;
        exitNotif: Text[1500];
        Source: Option NEW_MEMBER,NEW_ACCOUNT,LOAN_ACCOUNT_APPROVAL,DEPOSIT_CONFIRMATION,CASH_WITHDRAWAL_CONFIRM,LOAN_APPLICATION,LOAN_APPRAISAL,LOAN_GUARANTORS,LOAN_REJECTED,LOAN_POSTED,LOAN_DEFAULTED,SALARY_PROCESSING,TELLER_CASH_DEPOSIT,TELLER_CASH_WITHDRAWAL,TELLER_CHEQUE_DEPOSIT,FIXED_DEPOSIT_MATURITY,INTERACCOUNT_TRANSFER,ACCOUNT_STATUS,STATUS_ORDER,EFT_EFFECTED,ATM_APPLICATION_FAILED,ATM_COLLECTION,MBANKING,MEMBER_CHANGES,CASHIER_BELOW_LIMIT,CASHIER_ABOVE_LIMIT,INTERNETBANKING,CRM,MOBILE_PIN,WITHDRAWAL,LOAN_REMINDER,PIGGY_BANK,MEMBER_EXIT;
        smsManagement: Codeunit "Sms Management";
        Cust: Record Customer;
        guarDetails: Record "Loans Guarantee Details";
        loanReg: Record "Loans Register";
}


