//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50369 "Loans Guarantee Details"
{
    DrillDownPageId = "Loans Guarantee Details";
    LookupPageId = "Loans Guarantee Details";

    fields
    {
        field(1; "Loan No"; Code[20])
        {
            NotBlank = true;
            TableRelation = "Loans Register"."Loan  No.";
        }
        field(2; "Member No"; Code[20])
        {
            NotBlank = false;
            TableRelation = Customer."No." where(ISNormalMember = const(true));

            trigger OnValidate()
            var
                AmountGuaranteed: Decimal;
                TotalAmountGuaranteed: Decimal;
                AmountGuar: Decimal;
                LoanProducts: Record "Loan Products Setup";
                TotalAmountToGuarantee: Decimal;
                AmountCommitted: Decimal;
                currentLiability: Decimal;
                guarantorshipRef: Decimal;
                GuarantorsDetails: Record "Loans Guarantee Details";
                MaximumAmountToCommit: Decimal;
                custDeposits: Decimal;
                CustR: Record Customer;
                BalanceToCommit: Decimal;
                SaccoSetup: Record "Sacco General Set-Up";
                offsetFreed: Decimal;
                vuka: Boolean;

            begin
                SaccoSetup.Get();

                LoansGuaranteeDetails.Reset();
                LoansGuaranteeDetails.SetRange(LoansGuaranteeDetails."Member No", "Member No");
                LoansGuaranteeDetails.SetAutoCalcFields(LoansGuaranteeDetails."Outstanding Balance");
                LoansGuaranteeDetails.SetFilter(LoansGuaranteeDetails."Outstanding Balance", '>%1', 0);
                LoansGuaranteeDetails.SetRange(LoansGuaranteeDetails.Substituted, false);
                if LoansGuaranteeDetails.FindSet() then begin
                    LoansGuaranteeDetails.CalcSums(LoansGuaranteeDetails."Amont Guaranteed");
                    TotalAmountGuaranteed := LoansGuaranteeDetails."Amont Guaranteed";
                    "Committed Shares" := TotalAmountGuaranteed;
                end;

                offsetFreed := FnCheckOffsetGuarantorship("Member No", TotalAmountGuaranteed);
                TotalAmountGuaranteed := TotalAmountGuaranteed - offsetFreed;
                "Committed Shares":= TotalAmountGuaranteed;

                LoanGuarantors.SetRange(LoanGuarantors."Member No", "Member No");
                SelfGuaranteedA := 0;
                Date := Today;
                "Guarantorship Multiplier" := SaccoSetup."Guarantors Multiplier";
                
                LnGuarantor.Reset;
                LnGuarantor.SetRange(LnGuarantor."Loan  No.", "Loan No");
                if LnGuarantor.Find('-') then begin
                    if LnGuarantor."Client Code" = "Member No" then begin
                        "Self Guarantee" := true;
                        "Guarantorship Multiplier" := 1;
                    end;
                end;

                LoanApps.Reset;
                LoanApps.SetRange(LoanApps."Client Code", "Member No");
                LoanApps.SetFilter(LoanApps."Loans Category", '%1|%2', LoanApps."Loans Category"::Doubtful, LoanApps."Loans Category"::Loss);
                LoanApps.SetAutoCalcFields(LoanApps."Outstanding Balance");
                LoanApps.SetFilter(LoanApps."Outstanding Balance", '>%1', 0);
                LoanApps.SetRange(LoanApps.Posted, true);
                if LoanApps.Find('-') then begin
                    repeat
                        Error('Member has a defaulted loan, Loan No: %1.', LoanApps."Loan  No.");
                    until LoanApps.Next = 0;
                end;

                if Cust.Get("Member No") then begin
                    if Cust."Membership Status" <> Cust."Membership Status"::Active then Error('The member needs to be an active member.');
                    Cust.CalcFields(Cust."Outstanding Balance", Cust."Current Shares", Cust.TLoansGuaranteed);
                    Name := Cust.Name;
                    "Staff/Payroll No." := Cust."Payroll No";
                    "Loan Balance" := Cust."Outstanding Balance";
                    Shares := Cust."Current Shares" * 1;
                    "Mobile No" := Cust."Mobile Phone No";
                    "ID No." := Cust."ID No.";
                    "TotalLoan Guaranteed" := TotalAmountGuaranteed;
                end;
                
                TotalAmountToGuarantee := SaccoSetup."Guarantors Multiplier" * Shares;
                "Max Guarantorship" := TotalAmountToGuarantee;
                
                LoanApp.Reset();
                LoanApp.SetRange(LoanApp."Loan  No.", "Loan No");
                if LoanApp.FindFirst() then begin
                    vuka := false;
                    LoanProducts.Reset();
                    LoanProducts.SetRange(LoanProducts.Code, LoanApp."Loan Product Type");
                    if LoanProducts.FindFirst() then begin
                        if LoanProducts.Code = 'A20' then begin
                            "Deposit Ability" := true;
                            vuka := true;
                        end;
                    end;
                end;

                "Free Shares" := "Max Guarantorship" - TotalAmountGuaranteed;

                allowableGuar := 0;
                unpostedGuar := 0;

                AmountCommitted := 0;
                currentLiability := 0;
                GuarantorsDetails.RESET;
                GuarantorsDetails.SETRANGE(GuarantorsDetails."Member No", "Member No");
                IF GuarantorsDetails.FINDFIRST THEN BEGIN
                    currentLiability := FnCheckOffsetGuarantorshipLiability("Member No");

                    IF CustR.GET("Member No") THEN
                        CustR.CALCFIELDS(CustR."Current Shares");
                        custDeposits:= CustR."Current Shares";
                    MaximumAmountToCommit := 0;
                    SaccoSetup.GET();
                    
                    unpostedGuar := FnCheckUnpostedGuarantorship("Member No");
                    guarantorshipRef:= currentLiability + unpostedGuar;

                    if "Self Guarantee" = true then begin

                        MaximumAmountToCommit := Round((custDeposits * 0.9), 0.01, '=');
                        if guarantorshipRef > MaximumAmountToCommit then begin
                            if vuka = false then Error('You can only self guarantee %1. Your current guaranteed amount is %2 with a current liability of %3.', MaximumAmountToCommit, AmountCommitted, guarantorshipRef);
                        end else begin
                            "Committed Shares" := currentLiability;
                            BalanceToCommit := (custDeposits * 0.9) - currentLiability;
                            "Free Shares" := BalanceToCommit;
                        end;
                        if custDeposits < BalanceToCommit then begin
                            allowableGuar := custDeposits;
                        end else allowableGuar := BalanceToCommit;
                    end else begin
                        MaximumAmountToCommit := CustR."Current Shares" * SaccoSetup."Guarantors Multiplier";
                        IF guarantorshipRef > MaximumAmountToCommit THEN BEGIN
                            if vuka = false then ERROR('You can only guarantee deposits up to %1. Your current guaranteed amount is %2 with a liability of %3.', MaximumAmountToCommit, AmountCommitted, guarantorshipRef);
                        END ELSE BEGIN
                            BalanceToCommit := MaximumAmountToCommit - guarantorshipRef;
                            MESSAGE('Maximum deposits to guarantee is %1. Committed amount is %2. Deposit balance to guarantee is %3.', MaximumAmountToCommit, guarantorshipRef, BalanceToCommit);
                        END;
                        "Committed Shares" := currentLiability;
                        "Free Shares":=BalanceToCommit;

                        if MaximumAmountToCommit < BalanceToCommit then begin
                            allowableGuar := MaximumAmountToCommit;
                        end else allowableGuar := BalanceToCommit;
                    end;

                    Validate("Allowable Guarantorship", allowableGuar);
                    Validate("Unposted Guarantorship", unpostedGuar);
                END;

            end;
        }
        field(3; Name; Text[200])
        {
            Editable = false;
        }
        field(4; "Loan Balance"; Decimal)
        {
            Editable = false;
        }
        field(5; Shares; Decimal)
        {
            Editable = false;
        }
        field(6; "No Of Loans Guaranteed"; Integer)
        {
            CalcFormula = count("Loans Guarantee Details" where("Member No" = field("Member No"),
                                                                 "Outstanding Balance" = filter(> 1)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(7; Substituted; Boolean)
        {
            trigger OnValidate()
            begin
                //TESTFIELD("Substituted Guarantor");
            end;
        }
        field(8; Date; Date)
        {
        }
        field(9; "Shares Recovery"; Boolean)
        {
        }
        field(10; "New Upload"; Boolean)
        {
        }
        field(11; "Amont Guaranteed"; Decimal)
        {

            trigger OnValidate()
            var
                TotalL: Decimal;
            begin
                // Validate("Member No");

                LoanApp.Reset();
                LoanApp.SetRange(LoanApp."Loan  No.", "Loan No");
                if LoanApp.FindFirst() then begin
                    LoansGuaranteeDetails.Reset();
                    LoansGuaranteeDetails.SetRange(LoansGuaranteeDetails."Loan No", "Loan No");
                    LoansGuaranteeDetails.SetRange(LoansGuaranteeDetails.Substituted, false);
                    if LoansGuaranteeDetails.FindSet() then begin
                        LoansGuaranteeDetails.CalcSums(LoansGuaranteeDetails."Amont Guaranteed");
                        TotalL := LoansGuaranteeDetails."Amont Guaranteed";
                    end;
                    // if LoanApp."Requested Amount" < ("Amont Guaranteed" + TotalL) then
                    //     Error('Amount Guaranteed must not be more than requested amount');
                end;

                if "Deposit Ability" = false then begin
                    if "Amont Guaranteed" > "Free Shares" then Error('Guaranteed Amount cannot be greater than Free Shares');//on go live
                end;

                SharesVariance := 0;
                LoanGuarantors.Reset;
                LoanGuarantors.SetRange(LoanGuarantors."Member No", "Member No");
                if LoanGuarantors.Find('-') then begin
                    repeat
                        LoanGuarantors.CalcFields(LoanGuarantors."Outstanding Balance");
                        if LoanGuarantors."Outstanding Balance" > 0 then begin
                            Totals := Totals + LoanGuarantors."Amont Guaranteed";
                        end;
                    until LoanGuarantors.Next = 0;
                end;
            end;

        }
        field(12; "Staff/Payroll No."; Code[20])
        {

            trigger OnValidate()
            begin
                /*Cust.RESET;
                Cust.SETRANGE(Cust."Personal No","Staff/Payroll No.");
                IF Cust.FIND('-') THEN BEGIN
                "Member No":=Cust."No.";
                VALIDATE("Member No");
                END
                ELSE
                "Member No":='';//ERROR('Record not found.')
                */

            end;
        }
        field(13; "Account No."; Code[20])
        {
            TableRelation = Customer."No." where(ISNormalMember = filter(true));
        }
        field(14; "Self Guarantee"; Boolean)
        {

            // trigger OnValidate()
            // begin
            //     if ObjCust.Get("Member No") then begin
            //         if ObjCust."Member House Group" <> '' then
            //             Error('A Member in a house can not self guarantee');
            //     end;
            // end;
        }
        field(15; "ID No."; Code[70])
        {
        }
        field(16; "Outstanding Balance"; Decimal)
        {
            CalcFormula = sum("Detailed Cust. Ledg. Entry".Amount where("Transaction Type" = filter(Loan | repayment),
                                                                  "Loan No" = field("Loan No")));
            FieldClass = FlowField;
        }
        field(17; "Total Loans Guaranteed"; Decimal)
        {
            CalcFormula = sum("Loans Guarantee Details"."Amont Guaranteed" where("Loan No" = field("Loan No"),
                                                                                  Substituted = const(false),
                                                                                  "Self Guarantee" = const(false)));
            FieldClass = FlowField;
        }
        field(18; "Total Loans Outstanding"; Decimal)
        {
            CalcFormula = sum("Detailed Cust. Ledg. Entry".Amount where("Transaction Type" = filter(Loan | repayment| "Interest Paid" | "Interest Due"| "Loan Penalty Paid"| "Loan Penalty Charged"),
                                                                  "Loan No" = field("Loan No")));
            FieldClass = FlowField;

            trigger OnValidate()
            begin
                /*"Total Loans Guaranteed":="Outstanding Balance";
                MODIFY;
                */

            end;
        }
        field(19; "Guarantor Outstanding"; Decimal)
        {
            CalcFormula = sum("Detailed Cust. Ledg. Entry".Amount where("Customer No." = field("Member No"),
                                                                  "Transaction Type" = filter(Loan | repayment)
                                                                  ));
            FieldClass = FlowField;
        }
        field(20; "Employer Code"; Code[20])
        {
            TableRelation = Customer."No.";
        }
        field(21; "Employer Name"; Text[100])
        {
        }
        field(22; "Substituted Guarantor"; Code[200])
        {
            TableRelation = Customer."No.";

            trigger OnValidate()
            begin
                GenSetUp.Get();
                // if LoansG > GenSetUp."Maximum No of Guarantees" then begin
                //     Error('Member has guaranteed more than maximum active loans and  can not Guarantee any other Loans');
                //     "Member No" := '';
                //     "Staff/Payroll No." := '';
                //     Name := '';
                //     "Loan Balance" := 0;
                //     Date := 0D;
                //     exit;
                // end;


                // Loans.Reset;
                // Loans.SetRange(Loans."Client Code", "Member No");
                // if Loans.Find('-') then begin
                //     if LoanGuarantors."Self Guarantee" = true then
                //         Error('This Member has Self Guaranteed and Can not Guarantee another Loan');
                // end;
            end;
        }
        field(23; "Loanees  No"; Code[50])
        {
            CalcFormula = lookup("Loans Register"."Client Code" where("Loan  No." = field("Loan No")));
            FieldClass = FlowField;
        }
        field(24; "Loanees  Name"; Text[100])
        {
            CalcFormula = lookup("Loans Register"."Client Name" where("Loan  No." = field("Loan No")));
            FieldClass = FlowField;
        }
        field(25; "Loan Product"; Code[50])
        {
            CalcFormula = lookup("Loans Register"."Loan Product Type" where("Loan  No." = field("Loan No")));
            FieldClass = FlowField;
        }
        field(26; "Entry No."; Integer)
        {
        }
        field(27; "Loan Application Date"; Date)
        {
            CalcFormula = lookup("Loans Register"."Application Date" where("Loan  No." = field("Loan No")));
            FieldClass = FlowField;
        }
        field(28; "Free Shares"; Decimal)
        {
        }
        field(29; "Line No"; Integer)
        {
        }
        field(30; "Member Cell"; Code[10])
        {
        }
        field(31; "Share capital"; Decimal)
        {
        }
        field(32; "TotalLoan Guaranteed"; Decimal)
        {
            Description = '`';
        }
        field(33; Totals; Decimal)
        {
        }
        field(34; "Shares *3"; Decimal)
        {
        }
        field(35; "Deposits variance"; Decimal)
        {
        }
        field(36; "Defaulter Loan Installments"; Code[10])
        {
        }
        field(37; "Defaulter Loan Repayment"; Decimal)
        {
        }
        field(38; "Exempt Defaulter Loan"; Boolean)
        {
        }
        field(39; "Additional Defaulter Amount"; Decimal)
        {
        }
        field(40; "Total Guaranteed"; Decimal)
        {
            CalcFormula = sum("Loans Guarantee Details"."Loan Balance" where("Loan No" = field("Loan No"),
                                                                              Substituted = filter(false)));
            Description = '//>Sum total guaranteed amount for each loan';
            FieldClass = FlowField;
        }
        field(41; "Unposted Guarantorship"; Decimal)
        {

        }
        field(42; "Allowable Guarantorship"; Decimal)
        {

        }
        field(43; "Amount Recovered"; Decimal)
        {
            
        }
        field(44; "Fully Recovered"; Boolean)
        {
            
        }
        field(45; "Deposit Ability"; Boolean)
        {
            
        }
        field(69161; "Total Committed Shares"; Decimal)
        {
            CalcFormula = sum("Loans Guarantee Details"."Amont Guaranteed" where("Member No" = field("Member No"), Substituted = filter(false)));
            FieldClass = FlowField;
        }
        field(69162; "Oustanding Interest"; Decimal)
        {
            CalcFormula = sum("Detailed Cust. Ledg. Entry".Amount where("Customer No." = field("Member No"),
                                                                  "Transaction Type" = filter("Interest Paid"),
                                                                  "Loan No" = field("Loan No")));
            FieldClass = FlowField;
        }
        field(69163; "Loan Risk Amount"; Decimal)
        {
        }
        field(69164; "Total Loan Risk"; Decimal)
        {
            CalcFormula = sum("Loans Guarantee Details"."Loan Risk Amount" where("Loan No" = field("Loan No")));
            FieldClass = FlowField;
        }
        field(69165; "Total Amount Guaranteed"; Decimal)
        {
            CalcFormula = sum("Loans Guarantee Details"."Amont Guaranteed" where("Loan No" = field("Loan No"),
                                                                                  Substituted = const(false)));
            FieldClass = FlowField;
        }
        field(69166; "Approval Token"; Code[50])
        {
        }
        field(69167; "Acceptance Status"; Option)
        {
            OptionCaption = 'Pending,Accepted,Declined';
            OptionMembers = Pending,Accepted,Declined;
        }
        field(69168; "Date Accepted"; DateTime)
        {
        }
        field(69169; "Mobile No"; Code[30])
        {
        }
        field(69170; "Date Responded"; DateTime)
        {
        }
        field(69171; "Deposit Multiplier"; Decimal)
        {
        }
        field(69172; "Guarantorship Multiplier"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin

                Shares := Cust."Current Shares" * 1;
                "Free Shares" := ((Shares * LnGuarantor."Guarantorship Multiplier") * -1) - "TotalLoan Guaranteed";
                //  Message('SHares Freeshares %1|%2', Shares, "Free Shares");
                //"Free Shares" := ((Shares * LnGuarantor."Guarantorship Multiplier") * -1) - "TotalLoan Guaranteed";
            end;

        }
        field(69173; "Max Guarantorship"; Decimal)
        {
            Editable = false;
        }

        field(69174; "Committed Shares"; Decimal)
        {
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "Loan No", "Staff/Payroll No.", "Member No", "Entry No.")
        {
        }
        key(Key2; "Loan No", "Member No")
        {
            Clustered = true;
            SumIndexFields = Shares;
        }
    }

    fieldgroups
    {
    }

    var
        Cust: Record Customer;
        LoanGuarantors: Record "Loans Guarantee Details";
        Loans: Record "Loans Register";
        LoansR: Record "Loans Register";
        LoansG: Integer;
        GenSetUp: Record "Sacco General Set-Up";
        SelfGuaranteedA: Decimal;
        unpostedGuar: Decimal;
        allowableGuar: Decimal;
        StatusPermissions: Record "Status Change Permision";
        Employer: Record "Sacco Employers";
        loanG: Record "Loans Guarantee Details";
        CustomerRecord: Record Customer;
        MemberSaccoAge: Date;
        ComittedShares: Decimal;
        LoanApp: Record "Loans Register";
        DefaultInfo: Text;
        ok: Boolean;
        SharesVariance: Decimal;
        MemberCust: Record Customer;
        LnGuarantor: Record "Loans Register";
        LoanApps: Record "Loans Register";
        Text0001: label 'This Member has an Outstanding Defaulter Loan which has never been serviced';
        freeshares: Decimal;
        loanrec: Record "Loans Guarantee Details";
        ObjWithApp: Record "Membership Exist";
        ObjCust: Record Customer;
        LoansGuaranteeDetails: Record "Loans Guarantee Details";

        offsets: Record "Loan Offset Details";
        ObjSaccoGeneralSetUp: Record "Sacco General Set-Up";

    local procedure UPDATEG()
    begin
    end;

    local procedure FnRunGetLoanRisk() VarLoanRisk: Decimal
    var
        ObjLoanType: Record "Loan Products Setup";
        ObjLoanCollateral: Record "Loan Collateral Details";
        VarCollateralSecurity: Decimal;
        VarArreasAmount: Decimal;
        VarNoGroupMembers: Integer;
        VarGroupNetWorth: Decimal;
        ObjCust: Record Customer;
        VarLastMonth: Date;
        ObjRepaymentSch: Record "Loan Repayment Schedule";
        VarArrears: Decimal;
        VarDateFilter: Text;
        VarRepaymentPeriod: Date;
        VarScheduledLoanBal: Decimal;
        VarLBal: Decimal;
        VarLastMonthDate: Integer;
        VarLastMonthMonth: Integer;
        VarLastMonthYear: Integer;
        VarRepaymentDate: Date;
        VarRepayDate: Integer;
        VarTotalArrears: Decimal;
        VarExitDeposits: Decimal;
        VarExitLoans: Decimal;
        VarMemberGuarantorshipLiability: Decimal;
        "NoofMonthsArrears:Deposit": Decimal;
        "AmountArrears:Deposit": Decimal;
        VarLastDayofPreviousMonth: Date;
        VarTotalLoansIssued: Decimal;
        ObjLoans: Record "Loans Register";
    begin
        //-----------------------------------------------------Get Group Networth
        VarCollateralSecurity := 0;
        VarRepaymentPeriod := WorkDate;
        VarArrears := 0;
        VarTotalArrears := 0;

        ObjLoanCollateral.Reset;
        ObjLoanCollateral.SetRange(ObjLoanCollateral."Member No", "Member No");
        if ObjLoanCollateral.FindSet then begin
            repeat

                ObjLoans.Reset;
                ObjLoans.SetRange(ObjLoans."Loan  No.", ObjLoanCollateral."Loan No");
                if ObjLoans.FindSet then begin
                    ObjLoans.CalcFields(ObjLoans."Outstanding Balance");
                    if ObjLoans."Outstanding Balance" > 0 then begin
                        VarCollateralSecurity := VarCollateralSecurity + ObjLoanCollateral."Guarantee Value";
                    end;
                end;
            until ObjLoanCollateral.Next = 0;
        end;


        ObjCust.Reset;
        ObjCust.SetRange(ObjCust."No.", "Member No");
        if ObjCust.FindSet then begin
            ObjCust.CalcFields(ObjCust."Total Loans Outstanding");
            if ObjCust."Total Loans Outstanding" > VarCollateralSecurity then begin
                VarLoanRisk := ObjCust."Total Loans Outstanding" - VarCollateralSecurity
            end else
                VarLoanRisk := 0;
        end;
    end;

    local procedure FnGetHouseGroupNetWorth(VarGuarantorNo: Code[30]) VarLoanRisk: Decimal
    var
        VarCollateralSecurity: Decimal;
        ObjLoanCollateral: Record "Loan Collateral Details";
        ObjLoans: Record "Loans Register";
        ObjCust: Record Customer;
    begin
        //-----------------------------------------------------Get Group Networth
        VarCollateralSecurity := 0;


        ObjLoanCollateral.Reset;
        ObjLoanCollateral.SetRange(ObjLoanCollateral."Member No", VarGuarantorNo);
        if ObjLoanCollateral.FindSet then begin
            repeat

                ObjLoans.Reset;
                ObjLoans.SetRange(ObjLoans."Loan  No.", ObjLoanCollateral."Loan No");
                if ObjLoans.FindSet then begin
                    ObjLoans.CalcFields(ObjLoans."Outstanding Balance");
                    if ObjLoans."Outstanding Balance" > 0 then begin
                        VarCollateralSecurity := VarCollateralSecurity + ObjLoanCollateral."Guarantee Value";
                    end;
                end;
            until ObjLoanCollateral.Next = 0;
        end;


        ObjCust.Reset;
        ObjCust.SetRange(ObjCust."No.", VarGuarantorNo);
        if ObjCust.FindSet then begin
            ObjCust.CalcFields(ObjCust."Total Loans Outstanding");
            if ObjCust."Total Loans Outstanding" > VarCollateralSecurity then begin
                VarLoanRisk := ObjCust."Total Loans Outstanding" - VarCollateralSecurity
            end else
                VarLoanRisk := 0;

        end;
    end;

    procedure FnCheckUnpostedGuarantorship(member: Code[20]) Amount: Decimal
    var
        myInt: Integer;
    begin
        Amount := 0;
        LoanGuarantors.Reset;
        LoanGuarantors.SetRange(LoanGuarantors."Member No", member);
        if LoanGuarantors.Find('-') then begin
            repeat
                LoanApp.Reset();
                LoanApp.SetRange("Loan  No.", LoanGuarantors."Loan No");
                LoanApp.SetFilter(LoanApp."Loan Status", '%1|%2', LoanApp."Loan Status"::Appraisal, LoanApp."Loan Status"::Approved);
                if LoanApp.Find('-') then begin
                    loanG.Reset();
                    loanG.SetRange("Loan No", LoanApp."Loan  No.");
                    if loanG.Find('-') then begin
                        Amount := Amount + loanG."Amont Guaranteed";
                    end;
                end;
            until LoanGuarantors.Next = 0;
        end;
    end;

    procedure FnCheckOffsetGuarantorship(member: Code[20]; committed: Decimal) committedFree: Decimal
    var
    begin
        committedFree := 0;
        LoansGuaranteeDetails.Reset();
        LoansGuaranteeDetails.SetRange("Member No", member);
        LoansGuaranteeDetails.SetAutoCalcFields("Outstanding Balance");
        LoansGuaranteeDetails.SetFilter("Outstanding Balance", '>%1', 0);
        LoansGuaranteeDetails.SetRange(Substituted, false);
        if LoansGuaranteeDetails.Find('-') then begin
            repeat
                offsets.Reset();
                offsets.SetRange("Client Code", member);
                offsets.SetRange("Loan Top Up", LoansGuaranteeDetails."Loan No");
                if offsets.Find('-') then begin
                    repeat
                        committedFree := committedFree + LoansGuaranteeDetails."Amont Guaranteed";
                    until offsets.Next() = 0;
                end;
            until LoansGuaranteeDetails.Next() = 0;
        end;
    end;

    procedure FnCheckOffsetGuarantorshipLiability(member: Code[20]) liability: Decimal
    var
    begin
        liability := 0;
        LoansGuaranteeDetails.Reset();
        LoansGuaranteeDetails.SetRange("Member No", member);
        LoansGuaranteeDetails.SetAutoCalcFields("Outstanding Balance");
        LoansGuaranteeDetails.SetFilter("Outstanding Balance", '>%1', 0);
        LoansGuaranteeDetails.SetRange(Substituted, false);
        if LoansGuaranteeDetails.Find('-') then begin
            repeat
                offsets.Reset();
                offsets.SetRange("Client Code", member);
                offsets.SetRange("Loan Top Up", LoansGuaranteeDetails."Loan No");
                if not offsets.Find('-') then begin
                    repeat
                        LoanApp.RESET;
                        LoanApp.SETRANGE(LoanApp."Loan  No.", LoansGuaranteeDetails."Loan No");
                        LoanApp.SETAUTOCALCFIELDS(LoanApp."Outstanding Balance");
                        LoanApp.SETFILTER(LoanApp."Outstanding Balance", '>%1', 0);
                        IF LoanApp.FINDFIRST THEN BEGIN
                            if LoanApp."Approved Amount" > 0 then begin
                                Liability := Round(((LoanApp."Outstanding Balance" / LoanApp."Approved Amount") * LoansGuaranteeDetails."Amont Guaranteed"), 0.01, '=') + Liability;
                            end else begin
                                Liability := Round(((LoanApp."Outstanding Balance" / LoanApp."Requested Amount") * LoansGuaranteeDetails."Amont Guaranteed"), 0.01, '=') + Liability;
                            end;
                        END;
                    until offsets.Next() = 0;
                end;
            until LoansGuaranteeDetails.Next() = 0;
        end;

    end;
}




