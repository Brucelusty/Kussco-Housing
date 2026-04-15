table 50750 "Funeral Rider Processing"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "FR No."; Code[20])
        {
            Editable = false;
        }
        field(2; "No. Series"; Code[20])
        { }
        field(10; "Member No."; Code[20])
        {
            TableRelation = Customer."No." where(ISNormalMember = const(true), "Membership Status" = filter(Active));
            trigger OnValidate()
            var
            begin
                Cust.Reset();
                Cust.SetRange("No.", "Member No.");
                if Cust.Find('-') then begin
                    cust.CalcFields("Shares Retained", "Current Shares");
                    saccoGen.Get();
                    if (Cust."Shares Retained" < saccoGen."Retained Shares") then begin
                        Message('The member %1 has not reached the minimum share capital of %2.', "Member No.", saccoGen."Retained Shares");
                        if (Cust."Current Shares" > (saccoGen."Retained Shares" - Cust."Shares Retained")) then begin
                            if Confirm('If you wish to proceed, the member will be deducted from their deposits to fill the required share capital. Continue?', false) = true then begin
                                SharesTransfer("Member No.");
                            end else
                                Error('Cancelled.');
                        end/* else Error('The member lacks the deficit amount to fill their share capital from their deposits.')*/;
                    end;

                    "Member Name" := Cust.Name;
                    "Principal Contributor" := Cust."No.";
                    "Member FOSA Account" := Cust."Ordinary Savings Acc";
                    "Member Deceased" := true;
                    Validate("Member Deceased");

                    cust.CalcFields("Benevolent Fund", "Benevolent Fund Historical");
                    if (Cust."Benevolent Fund" > 0) or (Cust."Benevolent Fund Historical" > 0) then begin
                        "Has BBF Contributions" := true;
                    end else
                        "Has BBF Contributions" := false;
                end;
            end;
        }
        field(11; "Member Name"; Text[500])
        {
            Editable = false;
        }
        field(12; "NoK ID No."; Code[20])
        {
            TableRelation = "Members Next of Kin"."ID No." where("Member No" = field("Member No."));
            Editable = false;
            // trigger OnValidate() begin
            //     nok.Reset();
            //     nok.SetRange("ID No.", "NoK ID No.");
            //     if nok.Find('-') then begin
            //         "NoK Name" := nok.Name;
            //         "NoK Relationship" := nok.Relationship;
            //     end;
            //     Cust.Reset();
            //     Cust.SetRange("ID No.", "NoK ID No.");
            //     if Cust.Find('-') then begin
            //         "NoK is Member":= true;
            //         "NoK Member No.":= Cust."No.";
            //         Deceased:= "NoK Name";
            //     end else "NoK is Member" := false;
            // end;
        }
        field(13; "NoK Name"; Text[500])
        {
            Editable = false;
        }
        field(14; "NoK Relationship"; Text[500])
        {
            Editable = false;
        }
        field(15; "Member Deceased"; Boolean)
        {
            trigger OnValidate()
            begin
                if "Member Deceased" = true then begin
                    frpay.Reset();
                    frpay.SetRange("Member No.", "Member No.");
                    frpay.SetRange("Member Deceased", true);
                    if frpay.Find('-') then begin
                        if frpay."FR No." <> "FR No." then Error('An existing funeral rider for this member is ongoing. No.: %1', frpay."FR No.");
                    end;
                    Deceased := "Member Name";
                    "Next of Kin Deceased" := false;
                    "NoK ID No." := '';
                    "NoK Name" := '';
                    "NoK Relationship" := '';
                    "NoK is Member" := false;
                    "NoK Member No." := '';
                end;
            end;
        }
        field(16; "Next of Kin Deceased"; Boolean)
        {
            trigger OnValidate()
            begin
                if "Next of Kin Deceased" = true then begin
                    frpay.Reset();
                    frpay.SetRange("Member No.", "Member No.");
                    frpay.SetRange("Next of Kin Deceased", true);
                    if frpay.Find('-') then begin
                        if frpay."FR No." <> "FR No." then Error('An existing funeral rider for a next of kin for this member is ongoing. No.: %1', frpay."FR No.");
                    end;


                    "Member Deceased" := false;
                    Deceased := "NoK Name";
                    nok.Reset();
                    nok.SetRange("Account No", "Member No.");
                    nok.SetRange(Relationship, 'SPOUSE');
                    if nok.Find('-') then begin
                        "NoK ID No." := nok."ID No.";
                        "NoK Name" := nok.Name;
                        "NoK Relationship" := nok.Relationship;
                        Deceased := "NoK Name";
                    end else
                        Error('The member lacks a spouse under next of kin.');
                    if "NoK ID No." <> '' then begin
                        Cust.Reset();
                        Cust.SetRange("ID No.", "NoK ID No.");
                        if Cust.Find('-') then begin
                            if Cust."Membership Status" <> Cust."Membership Status"::Active then Error('The member %1 is not an active member.', Cust."No.");

                            cust.CalcFields("Shares Retained", "Current Shares");
                            saccoGen.Get();
                            if (Cust."Shares Retained" < saccoGen."Retained Shares") then begin
                                Message('The member %1 has not reached the minimum share capital of %2.', Cust."No.", saccoGen."Retained Shares");
                                if (Cust."Current Shares" > (saccoGen."Retained Shares" - Cust."Shares Retained")) then begin
                                    if Confirm('If you wish to proceed, the member will be deducted from their deposits to fill the required share capital. Continue?', false) = true then begin
                                        SharesTransfer(Cust."No.");
                                    end else
                                        Error('Cancelled.');
                                end else
                                    Error('The member lacks the deficit amount to fill their share capital from their deposits.');
                            end;

                            "NoK is Member" := true;
                            "NoK Member No." := Cust."No.";

                            cust.CalcFields("Benevolent Fund", "Benevolent Fund Historical");
                            if (Cust."Benevolent Fund" > 0) or (Cust."Benevolent Fund Historical" > 0) then begin
                                "NoK BBF" := true;
                            end else
                                "NoK BBF" := false;

                        end else
                            "NoK is Member" := false;
                    end;
                end else
                    "Member Deceased" := true;
                // if "Next of Kin Deceased" = true then begin
                //     frpay.Reset();
                //     frpay.SetRange("Member No.", "Member No.");
                //     if frpay.Find('-') then begin
                //         if frpay."Next of Kin Deceased" = true then begin
                //             Error('The member has an ongoing funeral rider process, No.: %1', frpay."FR No.");
                //         end else begin
                //             // Error('The member has an ongoing funeral rider process, No.: %1', frpay."FR No.");
                //         end;
                //     end;
                // end;

            end;
        }
        field(17; "Principal Contributor"; Code[20])
        {
            Editable = false;
        }
        field(18; "Deceased"; Code[300])
        {
            Editable = false;
        }
        field(19; "FR Fee Paid"; Boolean)
        {
            Editable = false;
        }
        field(20; "Member FOSA Account"; Code[20])
        {
            Editable = false;
        }
        field(21; "NoK is Member"; Boolean)
        {
            Editable = false;
        }
        field(22; "Captured On"; Date)
        {
            Editable = false;
        }
        field(23; "Captured By"; Code[20])
        {
            Editable = false;
        }
        field(24; "Paid On"; Date)
        {
            Editable = false;
        }
        field(25; "Payment Doc No"; Code[50])
        {
            Editable = false;
        }
        field(26; "Processing Status"; Option)
        {
            Editable = false;

            OptionCaption = ' ,Captured,"Pending Approval",Approved,Paid,Rejected';
            OptionMembers = ,Captured,"Pending Approval",Approved,Paid,Rejected;
        }
        field(27; "Approval Status"; Option)
        {
            Editable = false;

            OptionCaption = 'Open,"Pending Approval",Approved,Rejected';
            OptionMembers = Open,"Pending Approval",Approved,Rejected;
        }
        field(28; "Burial Permit No"; Code[20])
        { }
        field(29; "Has BBF Contributions"; Boolean)
        {
            Editable = false;
        }
        field(30; "Reason For Rejection"; Text[500])
        { }
        field(31; "Paid By"; Code[20])
        {
            Editable = false;
        }
        field(32; "Rejected By"; Code[20])
        {
            Editable = false;
        }
        field(33; "Notice No"; Code[20])
        {
            Editable = false;
        }
        field(34; "NoK Member No."; Code[20])
        {
            Editable = false;
        }
        field(35; "NoK BBF"; Boolean)
        {
            Editable = false;
        }
        field(36; "Approved By"; Code[20])
        {
            Editable = false;
        }
        field(37; "Approved On"; Date)
        {
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "FR No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        // Add changes to field groups here
    }

    var
        noSeries: Codeunit "No. Series";
        noSeriesSetup: Record "Sacco No. Series";
        Cust: Record Customer;
        nok: Record "Members Next of Kin";
        saccoGen: Record "Sacco General Set-Up";
        frpay: Record "Funeral Rider Processing";

    trigger OnInsert()
    begin
        if "FR No." = '' then begin
            noSeriesSetup.Get();
            noSeriesSetup.TestField("Funeral Rider Nos");
            noSeries.GetNextNo(noSeriesSetup."Funeral Rider Nos");
        end;

        "Processing Status" := "Processing Status"::Captured;
        "Captured By" := UserId;
        "Captured On" := Today;
    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

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
        GenBatches: Record "Gen. Journal Batch";
        SaccoGen: Record "Sacco General Set-Up";
    begin

        BATCH_TEMPLATE := 'PAYMENTS';
        BATCH_NAME := 'SHARERECOV';

        GenJournalLine.Reset;
        GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
        GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
        if GenJournalLine.FindSet() then begin
            GenJournalLine.DeleteAll
        end;
        GenBatches.Reset;
        GenBatches.SetRange(GenBatches."Journal Template Name", BATCH_TEMPLATE);
        GenBatches.SetRange(GenBatches.Name, BATCH_NAME);
        if GenBatches.Find('-') = false then begin
            GenBatches.Init;
            GenBatches."Journal Template Name" := BATCH_TEMPLATE;
            GenBatches.Name := BATCH_NAME;
            GenBatches.Description := 'Share Capital Recovery';
            GenBatches.Insert;
        end;
        SaccoGen.Get();

        DOCUMENT_NO := 'RECOVERY-' + member;

        Vendor.Reset();
        Vendor.SetRange(Vendor."BOSA Account No", member);
        Vendor.SetFilter(Vendor."Account Type", '101');
        Vendor.SetAutoCalcFields(Vendor.Balance);
        Vendor.SetFilter(Vendor.Balance, '<%1', SaccoGen."Retained Shares");
        if Vendor.FindSet() then begin
            Vendor.CalcFields(Balance);
            repeat
                RemainingAmount := 0;
                RemainingAmount := SaccoGen."Retained Shares" - Vendor.Balance;
                Vend.Reset();
                Vend.SetRange(Vend."BOSA Account No", member);
                Vend.SetRange(Vend."BOSA Account No", Vendor."BOSA Account No");
                Vend.SetRange(Vend."Account Type", '102');
                if Vend.FindFirst() then begin
                    // AsAt := CalcDate('-3M', Today);
                    Detvend.Reset();
                    DetVend.SetRange(DetVend."Vendor No.", Vend."No.");
                    // DetVend.SetFilter(DetVend."Posting Date", '%1..%2', AsAt, Today);
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
