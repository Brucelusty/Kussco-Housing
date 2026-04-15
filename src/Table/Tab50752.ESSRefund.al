table 50752 "ESS Refund"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "ESSRef No."; Code[20])
        {
            Editable = false;
        }
        field(2; "No. Series"; Code[20])
        {
            Editable = false;
        }
        field(3; "Captured On"; Date)
        {
            Editable = false;
        }
        field(4; "Member No"; Code[20])
        {
            TableRelation = Customer."No." where(ISNormalMember = filter(true), "Membership Status" = filter(Active));
            trigger OnValidate()
            begin
                essRef.Reset();
                essRef.SetFilter("ESSRef No.", '<>%1', "ESSRef No.");
                essRef.SetRange("Member No", "Member No");
                essRef.SetRange(Refunded, false);
                if essRef.Find('-') then begin
                    Error('This member has an existing ESS Refund yet to be refunded, ESSNo.: %1', essRef."ESSRef No.");
                end;

                if cust.Get("Member No") then begin
                    // File Movement Control disabled at the user's request, to be re-enabled after review with users.

                    // files.Reset();
                    // files.SetRange("File Return Status", files."File Return Status"::Issued);
                    // files.SetRange("File Received", true);
                    // files.SetRange("Issued To", UserId);
                    // if files.Find('-') = false then begin
                    //     if files."Account Type" = files."Account Type"::Staff then begin
                    //         if files."Account No." <> cust."Payroll No" then Error('Kindly ensure you have this member''s file in your possession.');
                    //     end else begin
                    //         if files."Account No." <> "Member No" then Error('Kindly ensure you have this member''s file in your possession.');
                    //     end;
                    // end;

                    "Member Name" := cust.Name;
                    "PF No" := cust."Payroll No";

                    loansReg.Reset();
                    loansReg.SetRange("Client Code", "Member No");
                    loansReg.SetRange("Loan Product Type", 'L04');
                    loansReg.SetFilter("Outstanding Balance", '>%1', 0);
                    if loansReg.Find('-') then begin
                        loansReg.CalcFields("Outstanding Balance");
                        if loansReg."Outstanding Balance" > 0 then begin
                            "Has Active ESS Loan" := true;
                            Message('The member has an ESS loan: %1, with an outstanding balance of %2.', loansReg."Loan  No.", loansReg."Outstanding Balance");
                        end;
                    end else
                        "Has Active ESS Loan" := false;

                    vend.Reset();
                    vend.SetRange("BOSA Account No", "Member No");
                    vend.SetRange("Account Type", '104');
                    if vend.Find('-') then begin
                        vend.CalcFields(Balance);
                        if vend.Balance <= 0 then Error('The member has no amount in their ESS Savings Account.');
                        "ESS Refund" := vend.Balance;
                        "ESS Account" := vend."No.";
                    end else
                        Error('The selected member has no ESS Savings Account.');
                end;
            end;
        }
        field(5; "Member Name"; Text[250])
        {
            Editable = false;
        }
        field(6; "PF No"; Code[20])
        {
            Editable = false;
        }
        field(7; "Has Active ESS Loan"; Boolean)
        {
            Editable = false;
        }
        field(8; "Registered On"; Date)
        {
            // Editable = false;
            trigger OnValidate()
            begin
                saccoGen.Get();
                if "Registered On" <> 0D then begin
                    if "Early Refund" = true then begin
                        "Maturing On" := CalcDate(saccoGen."ESS Refund Notice-Early", "Registered On");
                        Matured := true;
                    end else
                        "Maturing On" := CalcDate(saccoGen."ESS Refund Notice Maturity", "Registered On");
                end;
            end;
        }
        field(9; "Maturing On"; Date)
        {
            Editable = false;
        }
        field(10; "Registered"; Boolean)
        {
            Editable = false;
        }
        field(11; Matured; Boolean)
        {
            Editable = false;
        }
        field(12; "Refund Batch No"; Code[20])
        {
            TableRelation = "ESS Refund Batch"."ESSRef Batch No." where(Posted = filter(false));

        }
        field(13; "ESS Refund"; Decimal)
        {
            trigger OnValidate()
            begin
                vend.Reset();
                vend.SetRange("BOSA Account No", "Member No");
                vend.SetRange("Account Type", '104');
                if vend.Find('-') then begin
                    vend.CalcFields(Balance);
                    if "ESS Refund" > vend.Balance then Error('The refund cannot be more than the member''s current ESS Balance of %1.', vend.Balance);
                end
            end;
        }
        field(14; "ESS Account"; Code[20])
        {

        }
        field(15; Refunded; Boolean)
        {

        }
        field(16; "Early Refund"; Boolean)
        {

        }
        field(17; "Captured By"; Code[20])
        {

        }
        field(18; "Refunded On"; Date)
        {
            FieldClass = FlowField;
            CalcFormula = max("Detailed Vendor Ledg. Entry"."Posting Date" where("Vendor No." = field("ESS Account"), Reversed = filter(false), "Document No." = field("Posting Code")));
        }
        field(19; "Posting Code"; Code[20])
        {
        }
    }

    keys
    {
        key(Key1; "ESSRef No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        // Add changes to field groups here
    }

    var
        myInt: Integer;
        noSeries: Codeunit "No. Series";
        essRef: Record "ESS Refund";
        saccoNoseries: Record "Sacco No. Series";
        cust: Record Customer;
        vend: Record Vendor;
        loansReg: Record "Loans Register";
        saccoGen: Record "Sacco General Set-Up";
        files: Record "File Movement Line";

    trigger OnInsert()
    begin
        if "ESSRef No." = '' then begin
            saccoNoseries.Get();
            saccoNoseries.TestField("ESS Refund Nos");
            noSeries.GetNextNo(saccoNoseries."ESS Refund Nos");
        end;

        "Captured On" := Today;
        "Captured By" := UserId;
        "Registered On" := Today;
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

}
