table 50007 "Withdrawal Notice"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[40])
        {
            Caption = 'No.';
            DataClassification = ToBeClassified;
            Editable = false;
            trigger OnValidate()
            begin
                TestField("No.");
                if "No." <> xRec."No." then begin
                    SalesSetup.Get;
                    NoSeriesMgt.TestManual(SalesSetup."CLosure Notice Nos");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "Member No"; Code[40])
        {
            Caption = 'Member No';
            DataClassification = ToBeClassified;
            TableRelation = Customer where(ISNormalMember = const(true)/*, "Membership Status" = filter(<>Exited)*/);
            trigger OnValidate()
            var
                Cust: Record Customer;
                saccoGen: Record "Sacco General Set-Up";
            begin
                withNotice.Reset();
                withNotice.SetRange("Member No", "Member No");
                withNotice.SetFilter("No.", '<>%1', "No.");
                if withNotice.Find('-') then begin
                    // if withNotice."No." <> "No." then begin
                    Error('The inputted member, %1 has an ongoing exit process, notice no.: %2.', withNotice."Member No", withNotice."No.");
                    // end;
                end;

                saccoGen.Get();

                frPay.Reset();
                frPay.SetRange("Member Deceased", true);
                frPay.SetRange("Member No.", "Member No");
                if frPay.Find('-') then begin
                    if (frPay."FR Fee Paid" = false) and (frPay."Has BBF Contributions" = true) then begin
                        Error('The member''s funeral rider payment has not been processed.');
                    end else begin
                        "Burial Permit Serial" := frPay."Burial Permit No";
                        "Death Case" := true;
                        "Withdrawal Type" := "Withdrawal Type"::Death;
                        Validate("Withdrawal Type");
                    end;
                end else begin
                    frPay.Reset();
                    frPay.SetRange("NoK is Member", true);
                    frPay.SetRange("NoK Member No.", "Member No");
                    if frPay.Find('-') then begin
                        if (frPay."FR Fee Paid" = false) and (frPay."NoK BBF" = true) then begin
                            Error('The member''s NoK funeral rider payment has not been processed.');
                        end else begin
                            "Burial Permit Serial" := frPay."Burial Permit No";
                            "Death Case" := true;
                            "Withdrawal Type" := "Withdrawal Type"::Death;
                            Validate("Withdrawal Type");
                        end;
                    end;
                end;

                Cust.Reset();
                Cust.SetRange(Cust."No.", "Member No");
                if cust.Find('-') then begin
                    cust.CalcFields("Shares Retained", "Current Shares");
                    if Cust."Current Shares" <= 0 then Error('The member has no deposits.');
                    if (Cust."Shares Retained" < saccoGen."Retained Shares") then begin
                        Message('The member %1 has not reached the minimum share capital of %2.', "Member No", saccoGen."Retained Shares");
                        if (Cust."Current Shares" > (saccoGen."Retained Shares" - Cust."Shares Retained")) then begin
                            if Confirm('If you wish to proceed, the member will be deducted from their deposits to fill the required share capital. Continue?', false) = true then begin
                                SharesTransfer("Member No");
                            end else
                                Error('Cancelled.');
                        end else
                            Error('The member lacks the deficit amount to fill their share capital from their deposits.');
                    end;

                    if (Cust."Membership Status" = cust."Membership Status"::"Awaiting Exit") or (Cust."Membership Status" = cust."Membership Status"::"Fully Exited") or (Cust."Membership Status" = cust."Membership Status"::Exited) or (Cust."Membership Status" = cust."Membership Status"::Closed) then begin
                        Error('The member is already exited or in the process of exiting.');
                    end;
                    Name := Cust.Name;
                    "Payroll No" := Cust."Payroll No";
                    "Phone No" := Cust."Mobile Phone No";
                    "FOSA Account" := Cust."FOSA Account No.";
                    "Registration Date" := today;
                end;

            end;
        }
        field(3; "Name"; Text[200])
        {
            Caption = 'Name';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(4; "Phone No"; Text[200])
        {
            Caption = 'Phone No';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(5; "Payroll No"; Text[200])
        {
            Caption = 'Payroll No';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(6; "FOSA Account"; Text[200])
        {
            Caption = 'FOSA Account';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(7; "Notice Date"; Date)
        {
            Caption = 'Notice Date';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                GenSetUp.Get();
                "Maturity Date" := CalcDate(GenSetUp."Closure Notice Period", "Notice Date");
            end;
        }
        field(8; "Registration Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(9; "Withdrawal Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ",Voluntary,PreviousVoluntary,Death;
            trigger OnValidate()
            var
                myInt: Integer;
                now: date;
            begin
                now := Today;
                GenSetUp.get();
                // case "Withdrawal Type" of
                //   "Withdrawal Type"::Death:
                //   "Maturity Date" := "Registration Date";
                //    "Withdrawal Type"::PreviousVoluntary:
                //   "Maturity Date" := now;
                //    "Withdrawal Type"::Voluntary:

                // end;
                // if "Withdrawal Type" = "Withdrawal Type"::Voluntary then begin
                //     if cust.Get("Member No") then begin
                //         Cust.CalcFields("Total Loan Balance", "No of Loans Guaranteed", "Total Committed Shares");
                //         if Cust."Total Loan Balance" > 0 then begin
                //             Error('The member %1 has a total loan balance of %2.', "Member No", Cust."Total Loan Balance");
                //         end;
                //         if Cust."Total Committed Shares" > 0 then begin
                //             Error('The member %1 has a total guaranteed amount of %2 for %3 loans.', "Member No", cust."Total Committed Shares", cust."No of Loans Guaranteed");
                //         end;
                //     end;
                // end;
                // if "Withdrawal Type" = "Withdrawal Type"::Death then begin
                //     "Maturity Date" := "Registration Date";
                // end;
                if "Withdrawal Type" = "Withdrawal Type"::PreviousVoluntary then Error('Select Voluntary instead.');

                "Death Case" := false;
                if "Withdrawal Type" = "Withdrawal Type"::Death then begin
                    "Deposits to be deducted" := false;

                    frPay.Reset();
                    frPay.SetRange("Member Deceased", true);
                    frPay.SetRange("Member No.", "Member No");
                    if frPay.Find('-') then begin
                        if (frPay."FR Fee Paid" = false) and (frPay."Has BBF Contributions" = true) then begin
                            Error('The member''s funeral rider payment has not been processed.');
                        end else begin
                            "Burial Permit Serial" := frPay."Burial Permit No";
                            "Death Case" := true;
                            "Withdrawal Type" := "Withdrawal Type"::Death;
                        end;
                    end else begin
                        frPay.Reset();
                        frPay.SetRange("NoK is Member", true);
                        frPay.SetRange("NoK Member No.", "Member No");
                        if frPay.Find('-') then begin
                            if (frPay."FR Fee Paid" = false) and (frPay."NoK BBF" = true) then begin
                                Error('The member''s NoK funeral rider payment has not been processed.');
                            end else begin
                                "Burial Permit Serial" := frPay."Burial Permit No";
                                "Death Case" := true;
                                "Withdrawal Type" := "Withdrawal Type"::Death;
                            end;
                        end else
                            Error('Kindly initiate and complete this member''s funeral rider process.');
                    end;
                end;

                if "Withdrawal Type" <> "Withdrawal Type"::Death then begin
                    frPay.Reset();
                    frPay.SetRange("Member Deceased", true);
                    frPay.SetRange("Member No.", "Member No");
                    if frPay.Find('-') then begin
                        Error('The member has a funeral rider being processed thus can only withdraw by death.');
                    end else begin
                        frPay.Reset();
                        frPay.SetRange("NoK is Member", true);
                        frPay.SetRange("NoK Member No.", "Member No");
                        if frPay.Find('-') then begin
                            Error('The member has a funeral rider being processed thus can only withdraw by death.');
                        end;
                    end;
                end;
            end;
        }

        field(15; "Maturity Date"; Date)
        {
            Caption = 'Maturity Date';
            Editable = false;
        }

        field(10; "Notice Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = ,Initiated,Matured,Converted,Registered;
            Editable = false;
        }
        field(11; "Approval Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = New,"Pending Approval",Approved,Rejected,Cancelled;
            Editable = false;
        }
        field(12; "No. Series"; Code[40])
        {
        }
        field(13; "Burial Permit Serial"; Code[40])
        {
        }
        field(14; "Converted"; Boolean)
        {
        }
        field(16; "Deposits to be deducted"; Boolean)
        {

        }
        field(17; "Death Case"; Boolean)
        {

        }
        field(18; Matured; Boolean)
        {

        }
        field(19; "Interview Done"; Boolean)
        {

        }
        field(20; "Reason for Exit"; Text[1800])
        {

        }
        field(21; "Reason for Deceased"; Text[1800])
        {

        }
        field(22; "Marked Deceased By"; code[20])
        {

        }
        field(23; "Legacy Upload"; Boolean)
        {

        }
        field(24; "ESS Shares"; Decimal)
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum("Membership Exist".SchoolFeesShares where("Member No." = field("Member No")));
        }
        field(25; "Current Shares"; Decimal)
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum("Membership Exist"."Member Deposits" where("Member No." = field("Member No")));
        }
        field(26; "Loan Balance"; Decimal)
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum("Membership Exist"."Loan Balance" where("Member No." = field("Member No")));
        }
        field(27; "Portal Application"; Boolean)
        {

        }
    }

    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }

    var
        GenSetUp: Record "Sacco General Set-Up";
        SalesSetup: Record "Sacco No. Series";
        Cust: Record Customer;
        NoSeriesMgt: Codeunit "No. Series";
        withNotice: Record "Withdrawal Notice";
        frPay: Record "Funeral Rider Processing";

    trigger OnInsert()
    var
        UserMgt: Codeunit "User Management";
        UserSetup: Record "User Setup";
    begin

        if "No." = '' then begin
            SalesSetup.Get();
            SalesSetup.TestField(SalesSetup."CLosure Notice Nos");
            "No.":=NoSeriesMgt.GetNextNo(SalesSetup."CLosure Notice Nos");
        end;

        "Notice Status" := "Notice Status"::Initiated;
        "Deposits to be deducted" := true;
    end;

    local procedure SharesTransfer(member: Code[20])
    var
        Vendor: Record Vendor;
        LineNo: integer;
        VBalance: Decimal;
        BATCH_TEMPLATE: code[100];
        BATCH_NAME: code[100];
        DOCUMENT_NO: code[100];
        TotalRepay: Decimal;
        Vend: Record Vendor;
        DetVend: Record "Detailed Vendor Ledg. Entry";
        DepositAmount: Decimal;
        AsAt: Date;
        RemainingAmount: Decimal;
        AUFactory: Codeunit "Au Factory";
        GenJournalLine: Record "Gen. Journal Line";
        SaccoGen: Record "Sacco General Set-Up";
    begin

        BATCH_TEMPLATE := 'PAYMENTS';
        BATCH_NAME := 'SHARERECOV';

        GenJournalLine.Reset;
        GenJournalLine.SetRange("Journal Template Name", 'PAYMENTS');
        GenJournalLine.SetRange("Journal Batch Name", 'SHARERECOV');
        if GenJournalLine.FindSet() then begin
            GenJournalLine.DeleteAll
        end;

        SaccoGen.Get();
        DOCUMENT_NO := 'RECOVERIES ' + Format(Today);

        Vendor.Reset();
        Vendor.SetRange(Vendor."BOSA Account No", member);
        Vendor.SetFilter(Vendor."Account Type", '101');
        Vendor.SetAutoCalcFields(Vendor.Balance);
        Vendor.SetFilter(Vendor.Balance, '<%1', SaccoGen."Retained Shares");
        if Vendor.FindSet() then begin
            repeat
                RemainingAmount := 0;
                RemainingAmount := SaccoGen."Retained Shares" - Vendor.Balance;
                Vend.Reset();
                Vend.SetRange(Vend."BOSA Account No", member);
                Vend.SetRange(Vend."Account Type", '102');
                if Vend.FindFirst() then begin
                    Detvend.Reset();
                    DetVend.SetRange(DetVend."Vendor No.", Vend."No.");
                    if DetVend.FindSet() then begin
                        DetVend.CalcSums(DetVend.Amount);
                        DepositAmount := -DetVend.Amount;
                        if RemainingAmount <= DepositAmount then begin
                            LineNo := LineNo + 10000;
                            AUFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                            GenJournalLine."Account Type"::Vendor, Vendor."No.", today, RemainingAmount * -1, '', '',
                            'Share Capital recovery', '', GenJournalLine."Application Source"::" ");
                            //--------------------------------(CREDIT Member DEPOSIT Account)---------------------------------------------

                            //------------------------------------2. DEBIT FOSA A/C---------------------------------------------------------------------------------------------
                            LineNo := LineNo + 10000;
                            AUFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                            GenJournalLine."Account Type"::Vendor, Vend."No.", today, RemainingAmount, ' ', '',
                            'Share Capital recovery', '', GenJournalLine."Application Source"::" ");
                        end;
                    end;
                end;
            until Vendor.Next() = 0;

            GenJournalLine.Reset;
            GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
            GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
            if GenJournalLine.Find('-') then begin
                Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco", GenJournalLine);
            end;
        END;
    end;
}
