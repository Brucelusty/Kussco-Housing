//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50396 "Membership Exist"
{

    fields
    {
        field(1; "No."; Code[20])
        {

            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    SalesSetup.Get;
                    NoSeriesMgt.TestManual(SalesSetup."Closure  Nos");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "Member No."; Code[20])
        {
            TableRelation = Customer;
            Editable = false;

            trigger OnValidate()
            begin
                IntTotal := 0;
                LoanTotal := 0;

                if Cust.Get("Member No.") then
                    ExitingMember := Cust.Name;

                //Restrict No of Withdrawals
                Closure.Reset;
                Closure.SetRange(Closure."Member No.", "Member No.");
                Closure.SetRange(Closure."Member Name", ExitingMember);
                Closure.SetFilter(Closure."No.", '<>%1', "No.");
                Closure.SetRange(Closure.Posted, false);
                if Closure.FindSet then begin
                    Error('The Member has another withdrawal application Closure No %1', Closure."No.");
                end;



                if Cust.Get("Member No.") then begin
                    "Member Name" := Cust.Name;
                    "Deposits Code" := cust."Deposits Account No";
                    "ID Number" := Cust."ID No.";
                    MemberStatus := Cust."Membership Status";
                    SchoolFeesShares := Cust."School Fees Shares";
                    "Withdrawal Fee" := GenSetup."Withdrawal Fee";
                    "Payroll/StaffNo" := Cust."Payroll No";
                    Cust.CalcFields(Cust."Current Shares", Cust."Risk Fund", Cust."Shares Retained", Cust."Dependant Savings 1", Cust."Dependant Savings 2", Cust."Dependant Savings 3"
                    , Cust."Holiday Savings", Cust."Utafiti Housing", Cust."HouseHold Savings", Cust."Interest On Deposits", Cust."Total Loan Balance", Cust."School Fees Shares",
                    Cust."Benevolent Fund", Cust."Benevolent Fund Historical");
                    "Loan Balance" := Cust."Total Loan Balance";
                    "Member Deposits" := Cust."Current Shares";
                    SchoolFeesShares := Cust."School Fees Shares";
                    "FOSA Account No." := Cust."FOSA Account No.";
                    "Unpaid Dividends" := Cust."Dividend Amount" + Cust."Interest On Deposits";
                    "Share Capital" := Cust."Shares Retained";
                    "Member Savings" := Cust."Dependant Savings 1" + Cust."Dependant Savings 2" + Cust."Dependant Savings 3" + Cust."HouseHold Savings" + Cust."Utafiti Housing" + Cust."Holiday Savings";
                    "Seller Share Capital Account" := Cust."Share Capital No";
                    Dependand1 := Cust."Dependant Savings 1";
                    dependand2 := Cust."Dependant Savings 2";
                    dependand3 := Cust."Dependant Savings 3";
                    holidaysaving := Cust."Holiday Savings";
                    PrdOverdeduction := Cust."Un-allocated Funds";
                    utafitihousing := Cust."Utafiti Housing";

                    if Cust."Total Loan Balance" = 0 then "Loans Cleared" := true;
                    if (Cust."Benevolent Fund" + Cust."Benevolent Fund Historical") = 0 then "Has BBF" := false;

                    Venor.reset;
                    Venor.SetRange(Venor."No.", "FOSA Account No.");
                    Venor.SetRange(Venor."Account Type", '103');
                    if Venor.FindFirst() then begin
                        Venor.CalcFields(Venor.Balance);
                        "Total FOSA Account" := Venor.Balance;
                        "Total Account Amount" := Venor.Balance + Cust."Current Shares";
                        "Paying Bank" := "FOSA Account No.";
                    end;
                    "Risk Fund" := Cust."Risk Fund";
                    if Cust."Risk Fund" < 0 then
                        "Risk Beneficiary" := true;

                    GenSetup.Get();
                    if "Risk Beneficiary" <> true then
                        "Risk Refundable" := (GenSetup."Risk Beneficiary (%)" / 100) * "Risk Fund";
                end;

                CalcFields("Share Capital to Sell");

                "Tax: Membership Exit Fee" := GenSetup."Withdrawal Fee" * (GenSetup."Excise Duty(%)" / 100);

                if "Sell Share Capital" = false then begin
                    "Total Adds" := "Member Deposits" + "Unpaid Dividends" + "Member Savings"
                end else
                    "Total Adds" := "Member Deposits" + "Unpaid Dividends" + "Share Capital to Sell" + "Member Savings";


                Loans.Reset;
                Loans.SetRange(Loans."Client Code", "Member No.");
                Loans.SetRange(Loans.Posted, true);
                //Loans.SetFilter(Loans.Source, '%1|%2', Loans.Source::BOSA, Loans.Source::" ");
                Loans.SetFilter(Loans."Outstanding Balance", '>0');
                if Loans.Find('-') then begin
                    repeat
                        Loans.CalcFields(Loans."Outstanding Balance");
                        VarLoanDue := SFactory.FnRunLoanAmountDue(Loans."Loan  No.");
                        //IntTotal := IntTotal + (Loans."Outstanding Interest");
                        LoanTotal := LoanTotal + Loans."Outstanding Balance";
                    until Loans.Next = 0;
                end;
                Loans.Reset;
                Loans.SetRange(Loans."Client Code", "Member No.");
                Loans.SetRange(Loans.Posted, true);
                // Loans.SetFilter(Loans.Source, '%1|%2', Loans.Source::BOSA, Loans.Source::" ");
                Loans.SetFilter(Loans."Outstanding Interest", '>0');
                if Loans.Find('-') then begin
                    repeat
                        Loans.CalcFields(Loans."Outstanding Balance", "Outstanding Interest");
                        //VarLoanDue := SFactory.FnRunLoanAmountDue(Loans."Loan  No.");
                        IntTotal := IntTotal + (Loans."Outstanding Interest");
                    //LoanTotal := LoanTotal + Loans."Outstanding Balance";
                    until Loans.Next = 0;
                end;
                //FOSA Loans
                Loans.Reset;
                Loans.SetRange(Loans."Client Code", "FOSA Account No.");
                Loans.SetRange(Loans.Posted, true);
                Loans.SetRange(Loans.Source, Loans.Source::FOSA);
                Loans.SetFilter(Loans."Outstanding Balance", '>0');
                if Loans.Find('-') then begin
                    repeat
                        Loans.CalcFields(Loans."Outstanding Balance");
                        VarLoanDue := SFactory.FnRunLoanAmountDue(Loans."Loan  No.");
                        IntTotalFOSA := IntTotalFOSA + (Loans."Outstanding Interest");
                        LoanTotalFOSA := LoanTotalFOSA + Loans."Outstanding Balance";
                    until Loans.Next = 0;
                end;


                "Total Loan" := LoanTotal;
                "Total Interest" := IntTotal;
                "Total Loans FOSA" := LoanTotalFOSA;
                "Total Oustanding Int FOSA" := IntTotalFOSA;
                "Total Lesses" := "Total Loan" + "Total Interest" + "Total Loans FOSA" + "Total Oustanding Int FOSA";
                "Net Payable to the Member" := "Total Adds" - "Total Lesses";

                "Member Liability" := SFactory.FnGetMemberLiability("Member No.");
                if "Member Liability" = 0 then "Guarantorship Cleared" := true;
            end;
        }
        field(3; "Member Name"; Text[50])
        {
        }
        field(4; "Application Date"; Date)
        {
            Caption = 'Application Date';
            Editable = false;
        }
        field(5; Status; Option)
        {
            OptionCaption = 'Open,Pending,Approved,Rejected';
            OptionMembers = Open,Pending,Approved,Rejected;
        }
        field(6; Posted; Boolean)
        {
        }
        field(7; "Total Loan"; Decimal)
        {
        }
        field(8; "Total Interest"; Decimal)
        {
        }
        field(9; "Member Deposits"; Decimal)
        {
        }
        field(10; "No. Series"; Code[20])
        {
        }
        field(11; "Closure Type"; Option)
        {
            OptionMembers = ,Voluntary,PreviousVoluntary,Death;
            Caption = 'Reason For Exit';
            Editable = false;
        }
        field(12; "Mode Of Disbursement"; Option)
        {
            OptionCaption = 'FOSA Account';
            OptionMembers = "FOSA Account";
        }
        field(13; "Paying Bank"; Code[20])
        {
            TableRelation = Vendor."No.";

            trigger OnValidate()
            begin
                //if ("Mode Of Disbursement" = "mode of disbursement"::Customer) or ("Mode Of Disbursement" = "mode of disbursement"::Vendor) then begin
                if "Paying Bank" = '' then
                    Error('You Must Specify the FOSA Account');
            end;
            //end;
        }
        field(14; "Cheque No."; Code[20])
        {
        }
        field(15; "FOSA Account No."; Code[20])
        {
            TableRelation = Vendor."No." where("BOSA Account No" = field("Member No."),
                                                Status = filter(<> Closed | Deceased),
                                                Blocked = filter(<> Payment | All));
        }
        field(16; Payee; Text[80])
        {
        }
        field(17; "Net Pay"; Decimal)
        {
        }
        field(18; "Risk Fund"; Decimal)
        {
        }
        field(19; "Risk Beneficiary"; Boolean)
        {
        }
        field(20; "Risk Refundable"; Decimal)
        {
        }
        field(21; "Total Adds"; Decimal)
        {
        }
        field(22; "Total Lesses"; Decimal)
        {
        }
        field(23; "Unpaid Dividends"; Decimal)
        {
        }
        field(24; "Total Loans FOSA"; Decimal)
        {
        }
        field(25; "Total Oustanding Int FOSA"; Decimal)
        {
        }
        field(26; "Net Payable to the Member"; Decimal)
        {
        }
        field(27; "Risk Fund Arrears"; Decimal)
        {
        }
        field(28; "Withdrawal Application Date"; Date)
        {

            trigger OnValidate()
            begin
                //GenSetup.GET();
            end;
        }
        field(29; "Reason For Withdrawal"; Option)
        {
            OptionMembers = ,Voluntary,PreviousVoluntary,Death;
            ;

        }
        field(30; "Sell Share Capital to"; Code[20])
        {
            TableRelation = "Members Register"."No.";

            trigger OnValidate()
            begin
                if Cust.Get("Sell Share Capital to") then begin
                    "Sell Shares Member Name" := Cust.Name;
                end;
            end;
        }
        field(31; "Sell Shares Member Name"; Code[20])
        {
        }
        field(32; "Share Capital Transfer Fee"; Decimal)
        {
        }
        field(33; "Sell Share Capital"; Boolean)
        {

            trigger OnValidate()
            begin
                GenSetup.Get();
                "Share Capital Transfer Fee" := GenSetup."Share Capital Transfer Fee";
                "Tax: Share Capital Transfer Fe" := "Share Capital Transfer Fee" * (GenSetup."Excise Duty(%)" / 100);
            end;
        }
        field(34; "Share Capital"; Decimal)
        {
        }
        field(35; "Share Capital to Sell"; Decimal)
        {
            CalcFormula = sum("Share Capital Sell".Amount where("Document No" = field("No.")));
            FieldClass = FlowField;
        }
        field(36; "Maturity Date"; Date)
        {
            caption = 'Maturity Date';
            Editable = false;
        }
        field(37; "Member Liability"; Decimal)
        {
        }
        field(38; "House Group Exit Application"; Code[30])
        {
        }
        field(39; "Seller Share Capital Account"; Code[30])
        {
        }
        field(40; "Tax: Share Capital Transfer Fe"; Decimal)
        {
        }
        field(41; "Tax: Membership Exit Fee"; Decimal)
        {
        }
        field(42; "Closed By"; Code[30])
        {
            Editable = false;
        }
        field(43; "Closed On"; Date)
        {
            Editable = false;
        }
        field(44; "Absolve Member Liability"; Boolean)
        {
        }
        field(45; "Exit Type"; Option)
        {
            OptionCaption = 'Full Member Exit, BOSA Account Clousre';
            OptionMembers = "Full Member Exit"," BOSA Account Clousre";
        }
        field(46; "Member Savings"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(47; Dependand1; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(48; dependand2; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(49; dependand3; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50; holidaysaving; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(51; PrdOverdeduction; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(52; utafitihousing; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Housing';
        }
        field(53; "Interview Done?"; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(54; "Total Account Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(55; "Total FOSA Account"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(56; "Notice No"; Code[60])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Withdrawal Notice"."No." where("Approval Status" = const(Approved), Matured = const(true));
            trigger OnValidate()
            var
                Notice: Record "Withdrawal Notice";
            begin
                Notice.Reset();
                Notice.SetRange(Notice."No.", "Notice No");
                if Notice.FindFirst() then begin
                    "Member No." := Notice."Member No";
                    "Maturity Date" := Notice."Maturity Date";
                    "Reason For Withdrawal" := Notice."Withdrawal Type";
                    "Closure Type" := Notice."Withdrawal Type";
                    // "Application Date":= Notice."Registration Date";
                    "Exit Notice Date" := Notice."Notice Date";
                    "Interview Done?" := Notice."Interview Done";
                    "Reason For Exit" := Notice."Reason for Exit";
                    Validate("Member No.");
                end;
            end;
        }
        field(57; "Notice Date"; Date)
        {

            trigger OnValidate()
            begin
                "Due Date" := "Notice Date" + 60;
                IF "Due Date" = TODAY THEN
                    MODIFY;
            end;
        }
        field(58; "Due Date"; Date)
        {
        }
        field(59; "ID Number"; code[20])
        { }
        field(60; "Payroll/StaffNo"; Text[30])
        { }
        field(61; MemberStatus; Option)
        {
            TableRelation = Customer."Membership Status";
            OptionCaption = 'Active,Deceased,Retired,Dormant,Awaiting Exit,Exited,Fully Exited,Re-instated,Closed';
            OptionMembers = Active,Deceased,Retired,Dormant,"Awaiting Exit",Exited,"Fully Exited","Re-instated",Closed;

        }
        field(62; "Withdrawal Fees"; Decimal)
        { }
        field(63; "Amount To Disburse"; Decimal)
        {
            trigger OnValidate()
            var
                customer: Record Customer;
            begin
                GenSetup.Get();
                customer.Reset();
                customer.SetRange("No.", "Member No.");
                if customer.Find('-') then begin
                    customer.CalcFields("Current Shares", "Shares Retained", "Ordinary Savings", "School Fees Shares");
                    "Member Deposits" := customer."Current Shares";
                    "Share Capital" := customer."Shares Retained";
                    "Total Refund" := customer."Current Shares" - GenSetup."Withdrawal Fee";
                    Remainder := customer."Current Shares" - GenSetup."Withdrawal Fee";
                    if "Amount To Disburse" > "Total Refund" then Error('The member can only be reimbursed a total of %1.', "Total Refund");
                end;
            end;

        }
        field(64; "Exit Batch No."; code[20])
        {
            Editable = true;
            // TableRelation = if(Posted = const(false)) "Member Exit Batch"."Exit Batch No."
            // else
            // if(Posted = const(true)) "Member Exit Batch"."Exit Batch No.";
            TableRelation = "Member Exit Batch"."Exit Batch No.";
            trigger OnValidate()
            var
                memberExit: Record "Membership Exist";
                withdrawal: Record "Withdrawal Notice";
                saccoGen: Record "Sacco General Set-Up";
                loansGuar: Record "Loans Guarantee Details";
                loansReg: Record "Loans Register";
                totalCredit: Decimal;
                totalDebit: Decimal;
                totalRefund: Decimal;
                currentLiability: Decimal;
                deposits: Decimal;
            begin
                // if rec.Status <> rec.Status::Approved then Error('Ensure that the exit has been approved before a batch is attached.');
                withdrawal.Reset();
                withdrawal.setRange("Payroll No", withdrawal."Payroll No");
                if withdrawal.find('-') then begin
                    // if withdrawal."Approval Status" <> withdrawal."approval status"::Approved then
                    //     // Error('You Can Only Batch approved member exit');
                end;

                if Cust.Get("Member No.") then begin
                    Cust.CalcFields("Total Loan Balance", "Current Shares", "School Fees Shares");
                    loansGuar.Reset();
                    loansGuar.SetRange("Member No", cust."No.");
                    loansGuar.SetRange(Substituted, false);
                    if loansGuar.Find('-') then begin
                        repeat
                            loansReg.Reset();
                            loansReg.SetRange("Loan  No.", loansGuar."Loan No");
                            loansReg.SetFilter("Outstanding Balance", '>%1', 0);
                            if loansReg.Find('-') then begin
                                loansReg.CalcFields("Outstanding Balance");
                                currentLiability := currentLiability + Round(((loansReg."Outstanding Balance" / loansReg."Approved Amount") * loansGuar."Amont Guaranteed"), 0.01, '=');
                            end;
                        until loansGuar.Next() = 0;
                    end;
                end;

                saccoGen.Get();
                totalCredit := 0;
                totalDebit := 0;
                totalRefund := 0;
                totalCredit := (Cust."Current Shares" + Cust."School Fees Shares" + Cust."Dividend Amount" + Cust."Interest On Deposits");
                totalDebit := (saccoGen."Withdrawal Fee" + Cust."Total Loan Balance" + currentLiability);
                totalRefund := totalCredit - totalDebit;
                "Amount To Disburse" := totalRefund;
                Remainder := totalRefund;
                "Total Refund" := totalRefund;
            end;
        }
        field(65; SchoolFeesShares; Decimal)
        { }
        field(66; "Withdrawal Fee"; Decimal)
        { }
        field(67; "System Created"; Boolean) { }
        field(68; "Exit Notice Date"; Date) { }
        field(69; "Loan Balance"; Decimal) { }
        field(70; "Loans Cleared"; Boolean) { }
        field(71; "Guarantorship Cleared"; Boolean) { }
        field(72; "Deposits Paid"; Boolean) { }
        field(73; "Total Refund"; Decimal) { }
        field(74; "Remainder"; Decimal)
        {
            trigger OnValidate()
            begin
                if ("Total Refund" - Remainder) = "Total Refund" then begin
                    "Fully Paid" := true;
                    Posted := true;
                    Validate("Fully Paid");
                end else
                    "Fully Paid" := false;
            end;
        }
        field(75; "Fully Paid"; Boolean)
        {
            Editable = false;
            trigger OnValidate()
            begin
                if "Fully Paid" = true then begin
                    if "Closure Type" = "Closure Type"::Death then begin
                        if Cust.Get("Member No.") then begin
                            Cust."Membership Status" := Cust."Membership Status"::Deceased;
                            Cust.Status := Cust.Status::Deceased;
                            Cust.modify;

                            vend.Reset();
                            vend.SetRange("BOSA Account No", Cust."No.");
                            if vend.FindSet() then begin
                                repeat
                                    vend.Status := vend.Status::Deceased;
                                    vend."Membership Status" := vend."Membership Status"::Deceased;
                                    vend.modify;
                                until vend.Next() = 0;
                            end;
                        end;
                    end else begin
                        if Cust.Get("Member No.") then begin
                            Cust."Membership Status" := Cust."Membership Status"::"Awaiting Exit";
                            Cust.Status := Cust.Status::Closed;
                            Cust.modify;

                            vend.Reset();
                            vend.SetRange("BOSA Account No", Cust."No.");
                            if vend.FindSet() then begin
                                repeat
                                    vend.Status := vend.Status::Closed;
                                    vend."Membership Status" := vend."Membership Status"::"Awaiting Exit";
                                    vend.modify;
                                until vend.Next() = 0;
                            end;
                        end;
                    end;
                end
            end;
        }
        field(76; "Has BBF"; Boolean)
        {

        }
        field(77; "Reason For Exit"; Text[1500])
        {

        }
        field(78; "Refunded Date"; Date)
        {
            FieldClass = FlowField;
            CalcFormula = max("Detailed Vendor Ledg. Entry"."Posting Date" where("Vendor No." = field("Deposits Code"), Reversed = filter(false), "Document No." = field("Posting Code")));
        }
        field(79; "Posting Code"; Code[20])
        {
        }
        field(80; "Deposits Code"; Code[20])
        {
        }
        field(81; "Legacy Upload"; Boolean)
        {
        }
        field(82; "Refunded On"; Date)
        {
        }

    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        if "No." = '' then begin
            SalesSetup.Get;
            SalesSetup.TestField(SalesSetup."Closure  Nos");
            NoSeriesMgt.GetNextNo(SalesSetup."Closure  Nos");
        end;
        "Application Date" := Today;
        GenSetup.Get;
        "Tax: Membership Exit Fee" := GenSetup."Withdrawal Fee" * (GenSetup."Excise Duty(%)" / 100);
    end;

    trigger OnDelete()
    begin
        if "Fully Paid" = true then Error('You cannot delete a fully paid exit.');
    end;

    var
        SalesSetup: Record "Sacco No. Series";
        NoSeriesMgt: Codeunit "No. Series";
        Cust: Record Customer;
        vend: Record Vendor;
        Loans: Record "Loans Register";
        MemLed: Record "Member Ledger Entry";
        IntTotal: Decimal;
        LoanTotal: Decimal;
        GenSetup: Record "Sacco General Set-Up";
        IntTotalFOSA: Decimal;
        LoanTotalFOSA: Decimal;
        Venor: Record Vendor;
        SFactory: Codeunit "Au Factory";
        VarLoanDue: Decimal;
        Closure: Record "Membership Exist";
        ExitingMember: Text;
}




