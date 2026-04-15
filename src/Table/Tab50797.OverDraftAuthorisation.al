table 50797 "Over Draft Authorisation"
{
    // DrillDownPageID = //51516466
    // posted overdaft list;
    // LookupPageID = 51516466;

    fields
    {
        field(1; "No."; Code[20])
        {

            trigger OnValidate()
            begin
                IF "No." <> xRec."No." THEN BEGIN
                    NoSetup.GET();
                    NoSeriesMgt.TestManual(NoSetup."Overdraft App Nos.");
                    "No. Series" := '';
                END;
            end;
        }
        field(2; "Account No."; Code[20])
        {
            TableRelation = Vendor."No." WHERE("Vendor Posting Group" = CONST('ORDINARY'));

            trigger OnValidate()
            var
                DefLoan: Record "Loans Register";
                Err_defloan: Label 'Selected member has a Loan %1 which is in %2 category, member cannot access overdraft!';
                err_acc: Label '%1, does not qualify since the account balance is %2';
            begin
                IF Account.GET("Account No.") THEN BEGIN
                    "Account Name" := Account.Name;
                    "Account Type" := Account."Account Type";
                    "Staff No." := Account."Personal No.";
                    "Employer Code" := Account."Employer Code";

                    Account.CALCFIELDS(Account."Balance (LCY)");
                    IF Account."Balance (LCY)" < 0 THEN
                        ERROR(err_acc, Account.Name, Account."Balance (LCY)");

                    IF AccountTypes.GET("Account Type") THEN BEGIN
                        IF AccountTypes."Allow Over Draft" = FALSE THEN
                            ERROR('Overdraft not allowed for this account type.');

                        AccountTypes.TESTFIELD(AccountTypes."Over Draft Interest Account");

                        "Overdraft Interest %" := AccountTypes."Over Draft Interest %";
                    END;

                    DefLoan.RESET;
                    DefLoan.SETRANGE(DefLoan."Client Code", Account."BOSA Account No");
                    DefLoan.SETFILTER(DefLoan."Outstanding Balance", '>0');
                    DefLoan.SETFILTER(DefLoan."Loans Category-SASRA", '%1|%2|%3',
                    DefLoan."Loans Category-SASRA"::Substandard, DefLoan."Loans Category-SASRA"::Doubtful,
                    DefLoan."Loans Category-SASRA"::Loss);
                    IF DefLoan.FINDSET THEN
                        REPEAT
                            ERROR(Err_defloan, DefLoan."Loan  No." + ' : ' + DefLoan."Loan Product Type" + ' ' + DefLoan."Loan Product Type Name", DefLoan."Loans Category-SASRA");
                        UNTIL DefLoan.NEXT = 0;

                    CalculateReccommededAmount;
                    VALIDATE("Withdrawal Amount", "Recommended Amount" -
                    (("Recommended Amount" * 0.01 * "Overdraft Interest %") + GetCharges("Recommended Amount")));
                    "Requested Amount" := "Withdrawal Amount";

                END
                ELSE BEGIN
                    IF Bank.GET("Account No.") THEN BEGIN
                        "Account Name" := Bank.Name;
                    END;
                END;
            end;
        }
        field(3; "Cheque Book No."; Code[20])
        {
        }
        field(4; "Account Name"; Text[50])
        {
        }
        field(8; "Client No."; Code[20])
        {
            Caption = 'Client No.';
        }
        field(9; "Effective/Start Date"; Date)
        {

            trigger OnValidate()
            begin
                "Expiry Date" := CALCDATE(Duration, "Effective/Start Date");
                VALIDATE("Expiry Date");
            end;
        }
        field(10; "Expiry Date"; Date)
        {

            trigger OnValidate()
            begin

                AllowMultipleOD := FALSE;

                IF ("Effective/Start Date" <> 0D) AND ("Expiry Date" <> 0D) THEN BEGIN

                    IF Account.GET("Account No.") THEN BEGIN
                        IF AccountTypes.GET("Account Type") THEN BEGIN
                            AllowMultipleOD := AccountTypes."Allow Multiple Over Draft";
                        END;
                    END;


                    /*OverDraftAuth.RESET;
                    OverDraftAuth.SETCURRENTKEY(OverDraftAuth."Account No.",OverDraftAuth.Status,OverDraftAuth.Expired);
                    OverDraftAuth.SETRANGE(OverDraftAuth."Account No.","Account No.");
                    OverDraftAuth.SETRANGE(OverDraftAuth.Status,OverDraftAuth.Status::Approved);
                    OverDraftAuth.SETRANGE(OverDraftAuth.Expired,FALSE);
                    OverDraftAuth.SETRANGE(OverDraftAuth.Liquidated,FALSE);
                    OverDraftAuth.SETRANGE(Posted,TRUE);
                    IF OverDraftAuth.FIND('-') THEN BEGIN
                    REPEAT

                        IF ("Effective/Start Date" >= OverDraftAuth."Effective/Start Date") AND ("Effective/Start Date" <= OverDraftAuth."Expiry Date") THEN
                        BEGIN
                            IF AllowMultipleOD = TRUE THEN BEGIN
                                IF CONFIRM('There is an already approved Over Draft within the specified period. - %1. Do you wish to issue another one?' +
                                   '',FALSE,OverDraftAuth."No.") = FALSE THEN
                                ERROR('Process Terminated.');
                                END ELSE
                                ERROR('There is an already approved Over Draft within the specified period. - %1. Cancel an existing one if you' +
                                       ' want to issue another one.',OverDraftAuth."No.");
                                END;

                                IF ("Expiry Date" >= OverDraftAuth."Effective/Start Date") AND ("Expiry Date" <= OverDraftAuth."Expiry Date") THEN BEGIN
                                IF AllowMultipleOD = TRUE THEN BEGIN
                                IF CONFIRM('There is an already approved Over Draft within the specified period. - %1. Do you wish to issue another one?' +
                                   '',FALSE,OverDraftAuth."No.") = FALSE THEN
                                ERROR('Process Terminated.');
                            END ELSE
                                ERROR('There is an already approved Over Draft within the specified period. - %1. Cancel an existing one if you' +
                                   ' want to issue another one.',OverDraftAuth."No.");

                        END;

                    UNTIL OverDraftAuth.NEXT = 0;
                    END;*/
                END;

            end;
        }
        field(11; Duration; DateFormula)
        {

            trigger OnValidate()
            begin
                TESTFIELD("Effective/Start Date");
                TESTFIELD(Duration);

                IF "Effective/Start Date" < TODAY THEN
                    ERROR('Effective date cannot be in the past.');

                "Expiry Date" := CALCDATE(Duration, "Effective/Start Date");
                VALIDATE("Expiry Date");
            end;
        }
        field(14; Status; Option)
        {
            Editable = true;
            OptionCaption = 'Open,Pending,Approved,Rejected';
            OptionMembers = Open,Pending,Approved,Rejected;
        }
        field(15; Remarks; Text[50])
        {
        }
        field(16; "Approved Amount"; Decimal)
        {
            Editable = false;

            trigger OnValidate()
            var
                Err_Appr: Label 'Approved amount cannot exceed %1';
            begin
                /*CalculateReccommededAmount;
                IF "Approved Amount">"Recommended Amount" THEN
                  ERROR(Err_Appr,"Recommended Amount");
                
                IF Status<>Status::Open THEN
                  ValidateIfUserHasPermission;*/

            end;
        }
        field(17; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(19; "Transacting Branch"; Code[20])
        {
            Editable = false;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(20; "Created By"; Code[60])
        {
            Editable = false;
        }
        field(21; "Approved By"; Code[20])
        {
            Editable = false;
        }
        field(22; "Canceled By"; Code[20])
        {
            Editable = false;
        }
        field(23; "Overdraft Interest %"; Decimal)
        {
            Editable = false;
        }
        field(26; Finished; Boolean)
        {
        }
        field(27; "Application Date"; Date)
        {
        }
        field(28; "Account Type"; Code[20])
        {
        }
        field(29; "Issue to"; Option)
        {
            OptionCaption = 'Account,Cashier';
            OptionMembers = Account,Cashier;
        }
        field(30; "Requested Amount"; Decimal)
        {

            trigger OnValidate()
            var
                Err_req: Label 'Requested amount cannot exceed %1';
            begin
            end;
        }
        field(31; Expired; Boolean)
        {
        }
        field(32; "Date Approved"; Date)
        {
            Editable = false;
        }
        field(33; "Overdraft Fee"; Decimal)
        {
            Editable = false;
        }
        field(34; Liquidated; Boolean)
        {
        }
        field(35; "Date Liquidated"; Date)
        {
            Editable = false;
        }
        field(36; "Liquidated By"; Code[30])
        {
            Editable = false;
        }
        field(37; "1st Approval"; Code[20])
        {
        }
        field(38; "1st Approval Date"; Date)
        {
        }
        field(39; Posted; Boolean)
        {
            Editable = false;
        }
        field(40; "Net Salary"; Decimal)
        {
            Editable = false;

            trigger OnValidate()
            begin
                /*"Approved Amount":="Net Salary"*0.7;
                //"Overdraft Fee":="Requested Amount"*0.05;
                "Overdraft Fee":="Requested Amount"*0.07;
                //"Amount Available":="Requested Amount"+"Overdraft Fee";
                //"Amount Available":="Requested Amount"+"Overdraft Fee";
                //IF "Requested Amount">"Approved Amount" THEN
                  //ERROR('error');
                
                 */

            end;
        }
        field(41; "Amount Available"; Decimal)
        {
            Editable = false;
        }
        field(42; "Date Created"; DateTime)
        {
            Editable = false;
        }
        field(43; "Date Posted"; DateTime)
        {
            Editable = false;
        }
        field(44; "Posted By"; Code[20])
        {
            Editable = false;
        }
        field(45; "Recommended Amount"; Decimal)
        {
            Editable = false;
        }
        field(46; "Withdrawal Amount"; Decimal)
        {

            trigger OnValidate()
            begin

                //IF Mobile THEN BEGIN
                IF Status <> Status::Open THEN
                    ValidateIfUserHasPermission;
                CalculateReccommededAmount;


                IF "Withdrawal Amount" > "Requested Amount" THEN
                    "Withdrawal Amount" := "Requested Amount";

                CalculateApprovedAmount;

                /*END
                ELSE BEGIN
                    CalculateReccommededAmount;
                
                    "Approved Amount" := "Withdrawal Amount";
                
                END;*/


                "Overdraft Fee" := "Overdraft Interest %" * 0.01 * "Withdrawal Amount";

            end;
        }
        field(47; Mobile; Boolean)
        {
        }
        field(48; "Last Notification"; Option)
        {
            OptionMembers = " ","1","2","3","4","5","6","7","8","9","10";
        }
        field(49; "Next Notification"; Option)
        {
            OptionMembers = " ","1","2","3","4","5","6","7","8","9","10";
        }
        field(50; "Last Mobile Loan Rem. Date"; Date)
        {
        }
        field(51; "Staff No."; Code[20])
        {
        }
        field(52; "Employer Code"; Code[20])
        {
        }
    }

    keys
    {
        key(Key1; "No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        ERROR('Deletion diallowed!');
    end;

    trigger OnInsert()
    var
        ODAuth: Record //"51516328"
        "Over Draft Authorisation";
    begin

        IF NOT Mobile THEN BEGIN
            ODAuth.RESET;
            ODAuth.SETRANGE(Status, ODAuth.Status::Open);
            IF ODAuth.FINDLAST THEN
                ERROR('Please utilize overdraft %1, before proceeding!', ODAuth."No.");
        END;

        IF "No." = '' THEN BEGIN
            NoSetup.GET;
            NoSetup.TESTFIELD(NoSetup."Overdraft App Nos.");
            NoSeriesMgt.GetNextNo(NoSetup."Overdraft App Nos.");
        END;


        "Created By" := UPPERCASE(USERID);
        "Date Created" := CURRENTDATETIME;
    end;

    var
        NoSetup: Record //"51516257"
        "Sacco General Set-Up";
        NoSeriesMgt: Codeunit "No. Series";
        Account: Record 23;
        UsersID: Record 2000000120;
        BanksList: Record //"51516311"
        Banks;
        "Bank Name": Text[30];
        ChequeNo: Code[20];
        i: Integer;
        Bank: Record 270;
        AccountTypes: Record //"51516295"
        "Account Types-Saving Products";
        OverDraftAuth: Record //"51516328"
        "Over Draft Authorisation";
        AllowMultipleOD: Boolean;
        SalaryPro: Record //"51516317"
        "Salary Processing Lines";
        ApperovedAmount: Decimal;
        RequestedAmount: Decimal;
        OnSacco: Record //"51516257"
        "Sacco General Set-Up";
        USetup: Record 91;
        IsStaff: Boolean;
        Acc: Record 23;

    procedure Liquidate()
    var
        UserSetup: Record 91;
    begin
        USetup.GET(USERID);
        TESTFIELD(Posted, TRUE);
        ValidateIfUserHasPermission;


        IF NOT CONFIRM('Liquidate overdraft %1?', FALSE, Rec."No." + ' - ' + "Account No." + ' - ' + "Account Name" + ': ' + FORMAT("Approved Amount")) THEN EXIT;
        TESTFIELD(Expired, FALSE);
        TESTFIELD(Liquidated, FALSE);

        Liquidated := TRUE;
        "Date Liquidated" := TODAY;
        "Liquidated By" := USERID;
        MODIFY;

        MESSAGE('Overdraft liquidated successfully!');
    end;

    procedure Approve()
    var
        UserSetup: Record 91;
    begin
        ValidateOverDraft;
        USetup.GET(USERID);
        IF NOT USetup.OverDraft THEN
            ERROR('You do not have the permission to approve overdraft, please contact the systems admin!');

        IF NOT CONFIRM('Approve overdraft %1?', FALSE, Rec."No." + ' - ' + "Account No." + ' - ' + "Account Name" + ': ' + FORMAT("Approved Amount")) THEN EXIT;

        TESTFIELD(Status, Status::Pending);

        Status := Status::Approved;
        "Date Approved" := TODAY;
        "Approved By" := USERID;
        MODIFY;

        MESSAGE('Overdraft approved successfully!');
    end;

    procedure ValidateOverDraft()
    begin
        TESTFIELD("Account No.");
        TESTFIELD("Effective/Start Date");
        TESTFIELD(Duration);
        TESTFIELD("Expiry Date");
        TESTFIELD("Requested Amount");
        TESTFIELD("Approved Amount");
        TESTFIELD("Withdrawal Amount");
    end;

    procedure PostOverDraft()
    var
        ApprovalEntries: Page 658;
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None",JV,"Member Closure","Account Opening",Batches,"Payment Voucher","Petty Cash",Requisition,Loan,Interbank,Imprest,Checkoff,"FOSA Account Opening",StandingOrder,HRJob,HRLeave,"HRTransport Request",HRTraining,"HREmp Requsition",MicroTrans,"Account Reactivation",Overdraft;
        AvailableBalance: Decimal;
        MinAccBal: Decimal;
        StatusPermissions: Record //"51516310"
        "Status Change Permision";
        BankName: Text[200];
        Banks: Record //"51516311"
        Banks;
        UsersID: Record 2000000120;
        AccP: Record 23;
        AccountTypes: Record //"51516295"
        "Account Types-Saving Products";
        GenJournalLine: Record 81;
        LineNo: Integer;
        Account: Record 23;
        i: Integer;
        DActivity: Code[20];
        DBranch: Code[20];
        ODCharge: Decimal;
        AccNo: Boolean;
        ReqAmount: Boolean;
        AppAmount: Boolean;
        ODInt: Boolean;
        EstartDate: Boolean;
        Durationn: Boolean;
        ODFee: Boolean;
        Remmarks: Boolean;
        ApprovedAmount: Decimal;
        Benki: Record 270;
    begin
        IF Posted = TRUE THEN
            ERROR('This Overdraft has already been issued');

        IF Status <> Status::Approved THEN
            ERROR('You cannot post an application being processed.');

        ValidateOverDraft;


        IF CONFIRM('Are you sure you want to authorise this overdraft? This will charge overdraft issue fee.', FALSE) = FALSE THEN
            EXIT;

        //Overdraft Issue Fee
        AccountTypes.RESET;
        AccountTypes.SETRANGE(AccountTypes.Code, "Account Type");
        IF AccountTypes.FIND('-') THEN BEGIN



            UsersID.RESET;
            UsersID.SETRANGE(UsersID."User Name", UPPERCASE(USERID));
            IF UsersID.FIND('-') THEN BEGIN
                //DBranch:=UsersID.branch;
                DActivity := 'FOSA';
                //MESSAGE('%1,%2',Branch,Activity);
            END;
            TESTFIELD("Overdraft Fee");

            IF "Overdraft Fee" > 0 THEN BEGIN
                //AccountTypes.TESTFIELD("Over Draft Issue Charge %");

                GenJournalLine.RESET;
                GenJournalLine.SETRANGE(GenJournalLine."Journal Template Name", 'PURCHASES');
                GenJournalLine.SETRANGE(GenJournalLine."Journal Batch Name", 'FTRANS');
                IF GenJournalLine.FIND('-') THEN
                    GenJournalLine.DELETEALL;

                LineNo := LineNo + 10000;

                GenJournalLine.INIT;
                GenJournalLine."Journal Template Name" := 'PURCHASES';
                GenJournalLine."Journal Batch Name" := 'FTRANS';
                GenJournalLine."Line No." := LineNo;
                GenJournalLine."Document No." := "No.";
                GenJournalLine."Posting Date" := TODAY;
                GenJournalLine."External Document No." := "No.";
                GenJournalLine."Account Type" := GenJournalLine."Account Type"::Vendor;
                GenJournalLine."Account No." := "Account No.";
                GenJournalLine.VALIDATE(GenJournalLine."Account No.");
                GenJournalLine.Description := 'Overdraft Issue Charges';
                GenJournalLine.VALIDATE(GenJournalLine."Currency Code");
                GenJournalLine.Amount := "Overdraft Fee";
                GenJournalLine.VALIDATE(GenJournalLine.Amount);
                IF GenJournalLine.Amount <> 0 THEN
                    GenJournalLine.INSERT;


                LineNo := LineNo + 10000;
                AccountTypes.TESTFIELD("Over Draft Issue Charge A/C");

                GenJournalLine.INIT;
                GenJournalLine."Journal Template Name" := 'PURCHASES';
                GenJournalLine."Journal Batch Name" := 'FTRANS';
                GenJournalLine."Line No." := LineNo;
                GenJournalLine."Document No." := "No.";
                GenJournalLine."Posting Date" := TODAY;
                GenJournalLine."External Document No." := "No.";
                GenJournalLine."Account Type" := GenJournalLine."Bal. Account Type"::"G/L Account";
                GenJournalLine."Account No." := AccountTypes."Over Draft Issue Charge A/C";
                GenJournalLine.VALIDATE(GenJournalLine."Account No.");
                GenJournalLine.Description := PADSTR('Overdraft issue charge for: ' + "Account No.", 50);
                GenJournalLine.VALIDATE(GenJournalLine."Currency Code");
                GenJournalLine.Amount := -"Overdraft Fee";
                GenJournalLine.VALIDATE(GenJournalLine.Amount);
                GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 1 Code");
                GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 2 Code");
                IF GenJournalLine.Amount <> 0 THEN
                    GenJournalLine.INSERT;



                //Post New
                GenJournalLine.RESET;
                GenJournalLine.SETRANGE("Journal Template Name", 'PURCHASES');
                GenJournalLine.SETRANGE("Journal Batch Name", 'FTRANS');
                IF GenJournalLine.FIND('-') THEN BEGIN
                    CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post Sacco", GenJournalLine);
                END;

                //Post New

            END;
        END;
        //Overdraft Fee

        Posted := TRUE;
        "Date Posted" := CURRENTDATETIME;
        "Posted By" := USERID;
        MODIFY;

        MESSAGE('Overdraft authorised and charges posted successfully.');
    end;

    procedure RejectOverDraft()
    var
        UserSetup: Record 91;
    begin
        ValidateOverDraft;

        USetup.GET(USERID);
        IF NOT USetup.OverDraft THEN
            ERROR('You do not have the permission to reject overdraft, please contact the systems admin!');

        IF NOT CONFIRM('Reject overdraft %1?', FALSE, Rec."No." + ' - ' + "Account No." + ' - ' + "Account Name" + ': ' + FORMAT("Approved Amount")) THEN EXIT;

        TESTFIELD(Status, Status::Pending);

        Status := Status::Rejected;
        "Canceled By" := USERID;
        MODIFY;

        MESSAGE('Overdraft rejected successfully!');
    end;

    local procedure CalculateReccommededAmount()
    var
        Charges: Record //"51516297"
        Charges;
        SalFee: Decimal;
        SalLines: Record //"51516317"
        "Salary Processing Lines";
        SaccoGeneralSetUp: Record //"51516257"
        "Sacco General Set-Up";
        "95%OfSalary": Decimal;
        SalaryLoansBal: Decimal;
        ExistingOds: Decimal;
        VendorLedger: Record 25;
        SalaryAmount: Decimal;
        PrevSalaryAmount: Decimal;
        "80%OfSalary": Decimal;
    begin
        IF Charges.GET('SAL') THEN BEGIN
            SalFee := Charges."Charge Amount";
            SaccoGeneralSetUp.GET;
            SaccoGeneralSetUp.TESTFIELD(SaccoGeneralSetUp."Excise Duty(%)");
            SalFee += (SaccoGeneralSetUp."Excise Duty(%)" * 0.01 * SalFee);
        END;

        SalaryAmount := 0;
        PrevSalaryAmount := 0;

        SalLines.RESET;
        SalLines.SETRANGE(SalLines."Account No.", Rec."Account No.");
        SalLines.SETRANGE(SalLines.Processed, TRUE);
        // SalLines.SETRANGE(SalLines.Type,SalLines.Type::Salary,SalLines.Type::Pension);
        IF SalLines.FINDLAST THEN BEGIN
            SalaryAmount := SalLines.Amount;
            IF SalLines.FIND('<') THEN
                PrevSalaryAmount := SalLines.Amount;
        END;

        IsStaff := FALSE;
        VendorLedger.RESET;
        VendorLedger.SETRANGE(VendorLedger."Vendor No.", "Account No.");
        VendorLedger.SETRANGE(VendorLedger.Reversed, FALSE);
        VendorLedger.SETFILTER(VendorLedger."External Document No.", 'SALARY*');
        VendorLedger.SETFILTER(VendorLedger.Amount, '<0');
        VendorLedger.SETAUTOCALCFIELDS(VendorLedger.Amount);
        IF VendorLedger.FINDLAST THEN BEGIN
            SalaryAmount := VendorLedger.Amount * -1;
            IsStaff := TRUE;
        END;

        //New salary
        Acc.GET("Account No.");
        //SalaryAmount:=Acc."Net Salary";
        //end of new

        IF PrevSalaryAmount > 0 THEN BEGIN
            IF SalaryAmount > PrevSalaryAmount THEN
                SalaryAmount := PrevSalaryAmount;
        END;

        IF Acc."Employer Code" = 'STAFF' THEN BEGIN

            VendorLedger.RESET;
            VendorLedger.SETRANGE(VendorLedger."Vendor No.", "Account No.");
            VendorLedger.SETRANGE(VendorLedger.Reversed, FALSE);
            VendorLedger.SETFILTER(VendorLedger."External Document No.", 'SALARY*');
            VendorLedger.SETFILTER(VendorLedger.Amount, '<0');
            VendorLedger.SETAUTOCALCFIELDS(VendorLedger.Amount);
            IF VendorLedger.FINDLAST THEN BEGIN
                SalaryAmount := VendorLedger.Amount * -1;
                IsStaff := TRUE;
            END;
        END;

        "Net Salary" := SalaryAmount;

        IF SalaryAmount > 0 THEN BEGIN
            "95%OfSalary" := (SalaryAmount * 0.95);
            //"80%OfSalary" := (SalaryAmount*0.8);
            SalaryLoansBal := GetSalaryLoansBalance;
            ExistingOds := GetExistingODs;
            "Recommended Amount" := "95%OfSalary" - (SalFee + SalaryLoansBal + ExistingOds);
            IF "Recommended Amount" < 0 THEN "Recommended Amount" := 0;
            IF "Recommended Amount" > 50000 THEN "Recommended Amount" := 53500;
            //sMESSAGE('SalFee %1\SalaryLoansBal %2\ExistingOds %3\STOAmt %4',SalFee,SalaryLoansBal,ExistingOds,0);
            IF GetExistingODs > 0 THEN
                "Recommended Amount" := 0;
        END
    end;

    local procedure GetSalaryLoansBalance(): Decimal
    var
        SalLoan: Record "Loans Register";
        SalLoanBal: Decimal;
        StandingOrders: Record //"51516307"
        "Standing Orders";
        ReceiptAllocation: Record //"51516246"
        "Receipt Allocation";
        MembLedger: Record //"51516224"
        "Member Ledger Entry";
        IntDue: Decimal;
    begin
        SalLoanBal := 0;
        SalLoan.RESET;
        SalLoan.SETCURRENTKEY(Source, "Client Code", "Loan Product Type", "Issued Date");
        SalLoan.SETRANGE(SalLoan."Account No", Rec."Account No.");
        SalLoan.SETRANGE(SalLoan."Recovery Mode", SalLoan."Recovery Mode"::Salary, SalLoan."Recovery Mode"::Pension);
        SalLoan.SETFILTER(SalLoan."Outstanding Balance", '>0');
        SalLoan.SETAUTOCALCFIELDS(SalLoan."Outstanding Balance");
        IF SalLoan.FINDSET THEN
            REPEAT

                IF SalLoan."Issued Date" <= 20190815D THEN BEGIN

                    MembLedger.RESET;
                    MembLedger.SETRANGE(MembLedger."Loan No", SalLoan."Loan  No.");
                    MembLedger.SETRANGE(MembLedger."Transaction Type", MembLedger."Transaction Type"::"Interest Due");
                    MembLedger.SETRANGE(MembLedger.Reversed, FALSE);
                    MembLedger.SETFILTER(MembLedger.Amount, '0');
                    IF MembLedger.FINDLAST THEN
                        IntDue := MembLedger.Amount;
                    SalLoan.Repayment := (SalLoan."Approved Amount" / SalLoan.Installments) + IntDue;

                END ELSE
                    SalLoan.Repayment := SalLoan.GetLoanExpectedRepayment(0, CALCDATE('CM', TODAY));

                IF SalLoan.Repayment > SalLoan."Outstanding Balance" THEN
                    SalLoan.Repayment := SalLoan."Outstanding Balance";

                IF IsStaff AND (SalLoan.Source = SalLoan.Source::BOSA) THEN
                    SalLoan.Repayment := 0;

                SalLoanBal += SalLoan.Repayment;

            UNTIL SalLoan.NEXT = 0;

        StandingOrders.RESET;
        StandingOrders.SETRANGE(StandingOrders."Source Account No.", "Account No.");
        StandingOrders.SETRANGE(StandingOrders.Status, StandingOrders.Status::Approved);
        //StandingOrders.SETFILTER(StandingOrders."Income Type",'%1|%2',StandingOrders."Income Type"::Pension,StandingOrders."Income Type"::Salary);
        StandingOrders.SETRANGE(StandingOrders."End Date", 0D, TODAY);
        IF StandingOrders.FINDSET THEN
            REPEAT
                ReceiptAllocation.RESET;
                ReceiptAllocation.SETRANGE(ReceiptAllocation."Document No", StandingOrders."No.");
                ReceiptAllocation.SETFILTER(ReceiptAllocation."Loan No.", '<>%1', '');
                IF ReceiptAllocation.FINDFIRST THEN BEGIN
                    SalLoan.GET(ReceiptAllocation."Loan No.");
                    SalLoan.CALCFIELDS(SalLoan."Outstanding Balance");
                    IF SalLoan."Outstanding Balance" > 0 THEN BEGIN
                        SalLoan.Repayment := SalLoan.GetLoanExpectedRepayment(0, CALCDATE('CM', TODAY));
                        IF SalLoan.Repayment > SalLoan."Outstanding Balance" THEN
                            SalLoan.Repayment := SalLoan."Outstanding Balance";
                        SalLoanBal += SalLoan.Repayment;
                    END;
                END;
            UNTIL StandingOrders.NEXT = 0;
        EXIT(SalLoanBal);
    end;

    local procedure GetExistingODs(): Decimal
    var
        ExistingOds: Record //"51516328"
        "Over Draft Authorisation";
    begin
        ExistingOds.RESET;
        ExistingOds.SETRANGE(ExistingOds."Account No.", Rec."Account No.");
        ExistingOds.SETRANGE(ExistingOds.Status, ExistingOds.Status::Approved);
        ExistingOds.SETRANGE(ExistingOds.Posted, TRUE);
        ExistingOds.SETRANGE(ExistingOds.Liquidated, FALSE);
        ExistingOds.SETRANGE(ExistingOds.Expired, FALSE);
        IF ExistingOds.FINDFIRST THEN BEGIN
            ExistingOds.CALCSUMS(ExistingOds."Approved Amount");
            EXIT(ExistingOds."Approved Amount");
        END;
    end;

    procedure ValidateIfUserHasPermission()
    begin
        USetup.GET(USERID);
        IF NOT USetup.OverDraft THEN
            ERROR('You do not have the permission to approve overdraft, please contact the systems admin!');
    end;

    local procedure CalculateApprovedAmount()
    var
        ErrAppr: Label 'The approved amount cannot exceed %1';
    begin
        "Approved Amount" := "Withdrawal Amount" + ("Withdrawal Amount" * 0.01 * "Overdraft Interest %") + GetCharges("Withdrawal Amount");
        IF "Approved Amount" > "Recommended Amount" THEN
            ERROR(ErrAppr, "Recommended Amount");
    end;

    procedure GetCharges(Amount: Decimal): Decimal
    var
        Charges: Record //"51516297"
        Charges;
        ChargeAmount: Decimal;
        SaccoGeneralSetUp: Record //"51516257"
        "Sacco General Set-Up";
    begin
        /*         Charges.RESET;
                Charges.SETRANGE(Charges.Description,'Cash Withdrawal Charges');
                IF Charges.FIND('-') THEN BEGIN
                IF (Amount>=100)  AND (Amount<=5000) THEN
                ChargeAmount:=Charges."Between 100 and 5000";

                 IF  (Amount>=5001) AND (Amount<=10000) THEN
                ChargeAmount:=Charges."Between 5001 - 10000";

                IF (Amount>=10001) AND (Amount<=30000) THEN
                  ChargeAmount:=Charges."Between 10001 - 30000";

                IF (Amount>=30001) AND (Amount<=50000) THEN
                ChargeAmount:=Charges."Between 30001 - 50000";

                 IF (Amount>=50001) AND (Amount<=100000) THEN
                ChargeAmount:=Charges."Between 50001 - 100000";

                 IF (Amount>=100001) AND (Amount<=200000) THEN
                   ChargeAmount:=Charges."Between 100001 - 200000";

                IF (Amount>=200001) AND (Amount<=500000) THEN
                 ChargeAmount:=Charges."Between 200001 - 500000";

                IF (Amount>=500001) AND (Amount<=100000000.0) THEN
                  ChargeAmount:=Charges."Between 500001 Above";
                END; */
        SaccoGeneralSetUp.GET;
        EXIT(ChargeAmount + (SaccoGeneralSetUp."Excise Duty(%)" * 0.01 * ChargeAmount));
    end;
}

