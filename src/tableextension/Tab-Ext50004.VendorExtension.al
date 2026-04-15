//************************************************************************
tableextension 50004 "VendorExtension" extends Vendor
{
    fields
    {
        // Add changes to table fields here
        field(50029; "Creditor Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,FOSA Account,Supplier';
            OptionMembers = " ","FOSA Account",Supplier;
        }
        field(50030; "Personal No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50031; "ID No."; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50032; "Last Maintenance Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50033; "Activate Sweeping Arrangement"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50034; "Sweeping Balance"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50035; "Sweep To Account"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Vendor;
        }
        field(50036; "Fixed Deposit Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Active,Matured,Closed,Not Matured';
            OptionMembers = " ",Active,Matured,Closed,"Not Matured";
        }
        field(50037; "Call Deposit"; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                AccountTypes: Record "Account Types-Saving Products";
            begin
                IF AccountTypes.GET("Account Type") THEN BEGIN
                    IF AccountTypes."Fixed Deposit" = FALSE THEN
                        ERROR('Call deposit only applicable for Fixed Deposits.');
                END;
            end;
        }
        field(50038; "Mobile Phone No"; Code[35])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                vend: Record Vendor;
            begin

                Vend.RESET;
                Vend.SETRANGE(Vend."Personal No.", "Personal No.");
                IF Vend.FIND('-') THEN
                    Vend.MODIFYALL(Vend."Mobile Phone No", "Mobile Phone No");

                /*Cust.RESET;
                Cust.SETRANGE(Cust."Staff No","Staff No");
                IF Cust.FIND('-') THEN
                Cust.MODIFYALL(Cust."Mobile Phone No","Mobile Phone No");*/

            end;
        }
        field(50112; "Group Mobile Phone No"; Code[35])
        {
            DataClassification = ToBeClassified;
        }
        field(50113; "Deposits Interest Amount"; Decimal)
        {
        }
        field(50039; "Marital Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Single,Married,Devorced,Widower,Separated';
            OptionMembers = " ",Single,Married,Devorced,Widower,Separated;
        }
        field(50040; "Registration Date"; Date)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                IF "Account Type" = 'FIXED' THEN BEGIN
                    TESTFIELD("Registration Date");
                    "FD Maturity Date" := CALCDATE("Fixed Duration", "Registration Date");
                END;
            end;
        }
        field(50041; "BOSA Account No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50042; Signature; MediaSet)
        {
            Caption = 'Signature';
            DataClassification = ToBeClassified;
        }
        field(50043; "Passport No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50044; "Employer Code"; Code[15])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Employers Register"."Employer Code";
        }
        field(50045; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Active,Frozen,Dormant,Archived,Closed,Deceased';
            //Active,Frozen,Closed,Archived,New,Dormant,Deceased
            OptionMembers = Active,Frozen,Dormant,Archived,Closed,Deceased;

            trigger OnValidate()
            begin
                //  IF (Status = Status::Active) OR (Status = Status::Deceased) THEN
                //    Blocked := Blocked::" "
                //  ELSE
                //     Blocked := Blocked::All
            end;
        }
        field(50046; "Account Type"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Account Types-Saving Products".Code;

            trigger OnValidate()
            var
                AccountTypes: Record "Account Types-Saving Products";
            begin
                IF AccountTypes.GET("Account Type") THEN BEGIN
                    AccountTypes.TESTFIELD(AccountTypes."Posting Group");
                    "Vendor Posting Group" := AccountTypes."Posting Group";
                    "Call Deposit" := FALSE;
                    "Account Type Name" := AccountTypes.Description;
                END;
            end;
        }
        field(50047; "Account Category"; Enum AccountCategoryEnum)
        {
            DataClassification = ToBeClassified;

        }
        field(50048; "FD Marked for Closure"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50049; "Last Withdrawal Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50050; "Last Overdraft Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50051; "Last Min. Balance Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50052; "Last Deposit Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50053; "Last Transaction Posting Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50054; "Date Closed"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50055; "Uncleared Cheques"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum(Transactions.Amount WHERE("Account No" = FIELD("No."), Posted = CONST(true),
                                                             "Cheque Processed" = CONST(false), "Type _Transactions" = CONST("Cheque Deposit")));
        }
        field(50056; "Expected Maturity Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50057; "ATM Transactions"; Decimal)
        {
            //TODO
            FieldClass = FlowField;
            CalcFormula = Sum("ATM Transactions".Amount WHERE("Account No" = FIELD("No."),
                                                               Posted = CONST(false)));
            Editable = false;
        }
        field(50058; "Date of Birth"; Date)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                dates: Codeunit "Dates Calculation";
            begin
                IF "Date of Birth" <> 0D THEN BEGIN
                    IF "Date of Birth" > TODAY THEN ERROR('Date of birth cannot be greater than today');

                    IF GenSetUp.GET() THEN BEGIN
                        IF CALCDATE(GenSetUp."Min. Member Age", "Date of Birth") > TODAY THEN ERROR('Applicant is below the mininmum membership age of %1', GenSetUp."Min. Member Age");
                        "Retirement Date" := CalcDate(GenSetUp."Retirement Age", "Date Of Birth");
                        // if "Registration Date" <> 0D then age := dates.DetermineAge("Date Of Birth", "Registration Date");
                        if "Registration Date" <> 0D then Age := dates.DetermineAge("Date Of Birth", Today);
                    END;

                end;
            end;
        }
        field(50059; "Last Transaction Date"; Date)
        {
            FieldClass = FlowField;

            AutoFormatType = 1;
            CalcFormula = Max("Detailed Vendor Ledg. Entry"."Posting Date" WHERE("Vendor No." = FIELD("No."),
                                                                                  "Document No." = FILTER(<> 'ORDINARYBBF310324')));
            Caption = 'Last Transaction Date';
            Editable = false;
        }
        field(50060; "E-Mail (Personal)"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50061; Section; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Member Section"."No.";
        }
        field(50062; "Card No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50063; "Home Address"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50064; Location; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50065; "Sub-Location"; Text[15])
        {
            DataClassification = ToBeClassified;
        }
        field(50066; District; Text[15])
        {
            DataClassification = ToBeClassified;
        }
        field(50067; "Resons for Status Change"; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50068; "Closure Notice Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50069; "Fixed Deposit Type"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Fixed Deposit Type".Code;

            trigger OnValidate()
            var
                FDType: Record "Fixed Deposit Type";
                interestCalc: Record "FD Interest Calculation Crite";
                Vend: record vendor;
            begin
                IF "Account Type" = 'FIXED' THEN BEGIN
                    IF "Account Type" = 'FIXED' THEN BEGIN
                        IF FDType.GET("Fixed Deposit Type") THEN
                            "FD Maturity Date" := CALCDATE(FDType.Duration, TODAY);
                        "FD Duration" := FDType."No. of Months";
                        "Fixed Deposit Status" := "Fixed Deposit Status"::Active;
                    END;

                    IF "Account Type" = 'FIXED' THEN BEGIN
                        IF interestCalc.GET(interestCalc.Code) THEN
                            "Interest rate" := interestCalc."Interest Rate"
                    END;

                    IF "Account Type" = 'CALLDEPOSIT' THEN BEGIN
                        IF interestCalc.GET(interestCalc.Code) THEN
                            "Interest rate" := interestCalc."On Call Interest Rate";
                    END;
                END;

                AccountTypes.Reset;
                AccountTypes.SETRANGE(AccountTypes."Current Account", true);
                if AccountTypes.FindLast() then begin
                    //Message('hERE%1', AccountTypes.CODE);
                    Vend.Reset;
                    Vend.SetRange(Vend."Account Type", AccountTypes.code);
                    Vend.SetRange(Vend."BOSA Account No", Rec."BOSA Account No");
                    if Vend.Find('-') then begin

                        "Savings Account No." := Vend."No.";

                    end;
                END;
            end;
        }
        field(50070; "Interest Earned"; Decimal)
        {
            //TODO
            CalcFormula = Sum("Interest Buffer"."Interest Amount" WHERE("Account No" = FIELD("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50071; "Untranfered Interest"; Decimal)
        {
            //TODO
            CalcFormula = Sum("Interest Buffer"."Interest Amount" WHERE("Account No" = FIELD("No."),
                                                                         Transferred = FILTER(false
                                                                         )));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50072; "FD Maturity Date"; Date)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                /*"FD Duration":="FD Maturity Date"-"Registration Date";
                 "FD Duration":=ROUND("FD Duration"/30,1);
                MODIFY;
                */

            end;
        }
        field(50073; "Savings Account No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Vendor."No.";
        }
        field(50074; "Old Account No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Enabled = false;
        }
        field(50075; "Salary Processing"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50076; "Amount to Transfer"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                interestCalc: Record "FD Interest Calculation Crite";
                GenSetUp: Record "Sacco General Set-Up";
                FDDuration: Integer;
            begin
                CALCFIELDS(Balance);
                //TESTFIELD("Registration Date");
                /*
                
                IF AccountTypes.GET("Account Type") THEN BEGIN
                IF "Account Type" = 'MUSTARD' THEN BEGIN
                IF "Last Withdrawal Date" = 0D THEN BEGIN
                "Last Withdrawal Date" :="Registration Date";
                MODIFY;
                END;
                
                IF (CALCDATE(AccountTypes."Savings Duration","Last Withdrawal Date") > TODAY) THEN BEGIN
                ERROR('You can only withdraw from this account once in %1.',AccountTypes."Savings Duration")
                END ELSE BEGIN
                IF "Amount to Transfer" > (Balance*0.25) THEN
                ERROR('Amount cannot be more than 25 Percent of the balance. i.e. %1',(Balance*0.25));
                
                END;
                
                END ELSE BEGIN
                IF AccountTypes."Savings Withdrawal penalty" > 0 THEN BEGIN
                IF (CALCDATE(AccountTypes."Savings Duration","Registration Date") > TODAY) THEN BEGIN
                IF ("Amount to Transfer"+ROUND(("Amount to Transfer"*(AccountTypes."Savings Withdrawal penalty")),1,'>')) > Balance THEN
                ERROR('You cannot transfer more than %1.',Balance-ROUND((Balance*(AccountTypes."Savings Withdrawal penalty")),1,'>'));
                
                END;
                
                END ELSE BEGIN
                IF "Amount to Transfer" > Balance THEN
                MESSAGE('Amount cannot be more than the balance.');
                
                END;
                END;
                END;
                  */
                //"Expected Interest On Term Dep":=ROUND((("Amount to Transfer"*"Interest rate"/100)/12)*FDDuration,1);

                IF "Account Type" = 'FIXED' THEN BEGIN
                    interestCalc.RESET;
                    interestCalc.SETRANGE(interestCalc.Code, "Fixed Deposit Type");
                    interestCalc.SETRANGE(interestCalc.Duration, "Fixed Duration");
                    IF interestCalc.FIND('-') THEN BEGIN
                        GenSetUp.GET();
                        "Interest rate" := interestCalc."Interest Rate";
                        FDDuration := interestCalc."No of Months";
                        "Expected Interest On Term Dep" := ROUND((("Amount to Transfer" * "Interest rate" / 100) / 365) * FDDuration, 1);
                        "Expected Interest On Term Dep" := "Expected Interest On Term Dep" - ("Expected Interest On Term Dep" * (GenSetUp."Withholding Tax (%)" / 100));
                        //"FD Maturity Date":=CALCDATE(FDDuration,"Fixed Deposit Start Date");
                        IF ("Amount to Transfer" < interestCalc."Minimum Amount") OR ("Amount to Transfer" > interestCalc."Maximum Amount") THEN
                            ERROR('You Cannot Deposit More OR less than the limits');
                    END;
                END;

            end;
        }
        field(50077; Proffesion; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50078; "Signing Instructions"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Any to Sign,Two to Sign,Three to Sign,All to Sign,Four to Sign,Sole Signatory';
            OptionMembers = " ","Any to Sign","Two to Sign","Three to Sign","All to Sign","Four to Sign","Sole Signatory";
        }
        field(50079; Hide; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50080; "Monthly Contribution"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50081; "Not Qualify for Interest"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50082; Gender; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Male,Female';
            OptionMembers = " ",Male,Female;
        }
        field(50083; "Fixed Duration"; DateFormula)
        {
            DataClassification = ToBeClassified;
            TableRelation = "FD Interest Calculation Crite".Duration WHERE(Code = FIELD("Fixed Deposit Type"));

            trigger OnValidate()
            var
                interestCalc: Record "FD Interest Calculation Crite";
                FDDuration: integer;
            begin
                IF "Account Type" = 'FIXED' THEN BEGIN
                    "FD Maturity Date" := CALCDATE("Fixed Duration", "Fixed Deposit Start Date");
                END;



                IF "Account Type" = 'FIXED' THEN BEGIN
                    interestCalc.RESET;
                    interestCalc.SETRANGE(interestCalc.Code, "Fixed Deposit Type");
                    interestCalc.SETRANGE(interestCalc.Duration, "Fixed Duration");
                    IF interestCalc.FIND('-') THEN BEGIN
                        "Interest rate" := interestCalc."Interest Rate";
                        FDDuration := interestCalc."No of Months";
                        "Expected Interest On Term Dep" := ROUND((("Amount to Transfer" * interestCalc."Interest Rate" / 100) / 12) * interestCalc."No of Months", 1);
                    END;
                END;

                IF "Account Type" = 'CALLDEPOSIT' THEN BEGIN
                    interestCalc.RESET;
                    interestCalc.SETRANGE(interestCalc.Code, "Fixed Deposit Type");
                    interestCalc.SETRANGE(interestCalc."No of Months", "FD Duration");
                    IF interestCalc.FIND('-') THEN BEGIN
                        "Interest rate" := interestCalc."On Call Interest Rate";
                        FDDuration := interestCalc."No of Months";
                        "Expected Interest On Term Dep" := ROUND((("Amount to Transfer" * interestCalc."On Call Interest Rate" / 100) / 12) * interestCalc."No of Months", 1);
                    END;
                END;
            end;
        }
        field(50084; "System Created"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50085; "External Account No"; Code[15])
        {
            DataClassification = ToBeClassified;
        }
        field(50086; "Bank Code"; Code[15])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Bank Account"."No.";
        }
        field(50087; Enabled; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50088; "Current Salary"; Decimal)
        {
            //TODO
            CalcFormula = Sum("Salary Processing Lines".Amount WHERE("Account No." = FIELD("No."),
                                                                      Date = FIELD("Date Filter"),
                                                                      Processed = CONST(false)));
            FieldClass = FlowField;
        }
        field(50089; "Defaulted Loans Recovered"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50090; "Document No. Filter"; Code[20])
        {
            FieldClass = FlowFilter;
        }
        field(50091; "EFT Transactions"; Decimal)
        {
            //TODO
            CalcFormula = Sum("EFT/RTGS Details"."Total Amount" WHERE("Account No" = FIELD("No."), Transferred = CONST(false)));
            FieldClass = FlowField;
        }
        field(50092; "Formation/Province"; Code[15])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                Vend: Record vendor;
            begin
                Vend.RESET;
                Vend.SETRANGE(Vend."Personal No.", "Personal No.");
                IF Vend.FIND('-') THEN BEGIN
                    REPEAT
                        Vend."Formation/Province" := "Formation/Province";
                        Vend.MODIFY;
                    UNTIL Vend.NEXT = 0;
                END;
            end;
        }
        field(50093; "Division/Department"; Code[15])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Member Departments"."No.";
        }
        field(50094; "Station/Sections"; Code[15])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Member Section"."No.";
        }
        field(50095; "Neg. Interest Rate"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50096; "Date Renewed"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50097; "Last Interest Date"; Date)
        {
            DataClassification = ToBeClassified;
            Description = 'Check the flowfield';
        }
        field(50098; "Don't Transfer to Savings"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50099; "Type Of Organisation"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Club,Association,Partnership,Investment,Merry go round,Other';
            OptionMembers = " ",Club,Association,Partnership,Investment,"Merry go round",Other;
        }
        field(50100; "Source Of Funds"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Business Receipts,Income from Investment,Salary,Other';
            OptionMembers = " ","Business Receipts","Income from Investment",Salary,Other;
        }
        field(50101; "S-Mobile No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50102; "FOSA Default Dimension"; Integer)
        {
            CalcFormula = Count("Default Dimension" WHERE("Table ID" = CONST(23),
                                                           "No." = FIELD("No."),
                                                           "Dimension Value Code" = CONST('FOSA')));
            FieldClass = FlowField;
        }
        field(50103; "ATM Prov. No"; Code[18])
        {
            DataClassification = ToBeClassified;
        }
        field(50104; "ATM Approve"; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                StatusPermissions: Record "Status Change Permision";
            begin
                IF "ATM Approve" = TRUE THEN BEGIN
                    StatusPermissions.RESET;
                    StatusPermissions.SETRANGE(StatusPermissions."User ID", USERID);
                    StatusPermissions.SETRANGE(StatusPermissions."Function", StatusPermissions."Function"::"ATM Approval");
                    IF StatusPermissions.FIND('-') = FALSE THEN
                        ERROR('You do not have permissions to do an Atm card approval');
                    "Card No." := "ATM Prov. No";
                    "Atm card ready" := FALSE;
                    MODIFY;
                END;
            end;
        }
        field(50105; "Dividend Paid"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = - Sum("Detailed Vendor Ledg. Entry"."Amount (LCY)" WHERE("Vendor No." = FIELD("No."),
                                                                                   "Initial Entry Global Dim. 1" = FIELD("Global Dimension 1 Filter"),
                                                                                   "Initial Entry Global Dim. 2" = FIELD("Global Dimension 2 Filter"),
                                                                                   "Currency Code" = FIELD("Currency Filter"),
                                                                                   //"Document No."=CONST("DIVIDEND"),
                                                                                   "Posting Date" = CONST(20110403D)));
            Caption = 'Balance (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50106; "Force No."; Code[10])
        {
            DataClassification = ToBeClassified;
            Enabled = false;
        }
        field(50107; "Card Expiry Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50108; "Card Valid From"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50109; "Card Valid To"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50114; Service; Text[10])
        {
            DataClassification = ToBeClassified;
        }
        field(50115; Reconciled; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50116; "FD Duration"; Integer)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                interestCalc: Record "FD Interest Calculation Crite";
                FDDuration: Integer;
            begin
                /* IF "Account Type"='FIXED' THEN
                  "FD Maturity Date":="Registration Date"+("FD Duration"*30);
                  MODIFY;*/
                /*
               interestCalc.RESET;
               interestCalc.SETRANGE(interestCalc.Code,"Fixed Deposit Type");
               interestCalc.SETRANGE(interestCalc."No of Months","FD Duration");
               IF interestCalc.FIND('-') THEN BEGIN
               "Interest rate":=interestCalc."Interest Rate";
               END;
               */
                IF "Account Type" = 'FIXED' THEN BEGIN
                    TESTFIELD("Registration Date");
                    "FD Maturity Date" := CALCDATE(format("FD Duration") + 'M', TODAY);
                    //"FD Maturity Date":=CALCDATE("FD Duration",TODAY);
                END;


                IF "Account Type" = 'FIXED' THEN BEGIN
                    interestCalc.RESET;
                    interestCalc.SETRANGE(interestCalc.Code, "Fixed Deposit Type");
                    interestCalc.SETRANGE(interestCalc."No of Months", "FD Duration");
                    IF interestCalc.FIND('-') THEN BEGIN
                        "Interest rate" := interestCalc."Interest Rate";
                        FDDuration := interestCalc."No of Months";
                        "Expected Interest On Term Dep" := ROUND((("Amount to Transfer" * interestCalc."Interest Rate" / 100) / 12) * interestCalc."No of Months", 1);
                    END;
                END;

                IF "Account Type" = 'CALLDEPOSIT' THEN BEGIN
                    interestCalc.RESET;
                    interestCalc.SETRANGE(interestCalc.Code, "Fixed Deposit Type");
                    interestCalc.SETRANGE(interestCalc."No of Months", "FD Duration");
                    IF interestCalc.FIND('-') THEN BEGIN
                        "Interest rate" := interestCalc."On Call Interest Rate";
                        FDDuration := interestCalc."No of Months";
                        //"Expected Interest On Term Dep":=ROUND((("Amount to Transfer"*interestCalc."On Call Interest Rate"/100)/12)*interestCalc."No of Months",1);
                    END;
                END;

            end;
        }
        field(50117; "Employer P/F"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(50118; "Outstanding Balance"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50119; "Atm card ready"; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var

                StatusPermissions: Record "Status Change Permision";

            begin
                IF "Atm card ready" = TRUE THEN BEGIN
                    StatusPermissions.RESET;
                    StatusPermissions.SETRANGE(StatusPermissions."User ID", USERID);
                    StatusPermissions.SETRANGE(StatusPermissions."Function", StatusPermissions."Function"::"Atm card ready");
                    IF StatusPermissions.FIND('-') = FALSE THEN
                        ERROR('You do not have permission to change atm status');
                END;
            end;
        }
        field(50120; "Current Shares"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50121; "Debtor Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'FOSA Account,Micro Finance';
            OptionMembers = "FOSA Account","Micro Finance";
        }
        field(50122; "Group Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50123; "Group Account"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50124; "Shares Recovered"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50125; "Group Balance"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50126; "Old Bosa Acc no"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50127; "Group Loan Balance"; Decimal)
        {
            /*             CalcFormula = - Sum("Member Ledger Entry".Amount WHERE("Transaction Type" = FILTER("Junior Savings" | "FOSA Shares"), "Group Code" = FIELD("Group Code")));
                        FieldClass = FlowField; */
        }
        field(50128; CodeDelete; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50129; "ContactPerson Occupation"; Code[15])
        {
            DataClassification = ToBeClassified;
        }
        field(50130; "ContacPerson Phone"; Text[15])
        {
            DataClassification = ToBeClassified;
        }
        field(50131; "ClassB Shares"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50132; "Date ATM Linked"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50133; "ATM No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            //Enabled = false;
        }
        field(50134; "Reason For Blocking Account"; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50135; "Uncleared Loans"; Decimal)
        {
            //todo
            CalcFormula = Sum("Loans Register"."Net Payment to FOSA" WHERE("Account No" = FIELD("No."),
                                                                            Posted = FILTER(true),
                                                                            "Processed Payment" = FILTER(false)));
            FieldClass = FlowField;
        }
        field(50136; NetDis; Decimal)
        {
            //todo
            CalcFormula = Sum("Loans Register"."Net Payment to FOSA" WHERE("Account No" = FIELD("No."),
                                                                                "Processed Payment" = FILTER(false)));
            FieldClass = FlowField;
        }
        field(50137; "Transfer Amount to Savings"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50138; "Notice Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50139; "Account Frozen"; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50140; "Interest rate"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50141; "Fixed duration2"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50142; "FDR Deposit Status Type"; Option)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            OptionCaption = ' ,New,Renewed,Terminated';
            OptionMembers = " ",New,Renewed,Terminated;
        }
        field(50143; "ATM Expiry Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50144; "ATM Issued"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50145; "ATM Self Picked"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50146; "ATM Collector Name"; Text[15])
        {
            DataClassification = ToBeClassified;
        }
        field(50147; "ATM Collector's ID"; Text[15])
        {
            DataClassification = ToBeClassified;
        }
        field(50148; "ATM Collector's Mobile"; Text[15])
        {
            DataClassification = ToBeClassified;
        }
        field(50149; Test; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(50150; "Outstanding Loans"; Decimal)
        {
            /*             CalcFormula = Sum("Member Ledger Entry".Amount WHERE("FOSA Account No." = FIELD("No."),
                                                                              "Transaction Type" = FILTER("Share Capital" | "Interest Paid" | "FOSA Shares"),
                                                                              "Posting Date" = FIELD("Date Filter")));
                        FieldClass = FlowField; */
        }
        field(50151; "Outstanding Interest"; Decimal)
        {
            CalcFormula = Sum("Member Ledger Entry".Amount WHERE("FOSA Account No." = FIELD("No."),
                                                                  "Transaction Type" = FILTER("Deposit Contribution" | "Insurance Contribution"),
                                                                  "Posting Date" = FIELD("Date Filter")));
            FieldClass = FlowField;
        }
        field(50152; "Cheque Book Account No"; Code[15])
        {
            DataClassification = ToBeClassified;
        }
        field(50153; "Home Postal Code"; Code[15])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Post Code";
        }
        field(50154; "Child Picture"; MediaSet)
        {
            DataClassification = ToBeClassified;
        }
        field(50155; "Postal Code 2"; Code[15])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Post Code";
        }
        field(50156; "Town 2"; Code[15])
        {
            DataClassification = ToBeClassified;
        }
        field(50157; "Passport 2"; Code[15])
        {
            DataClassification = ToBeClassified;
        }
        field(50158; "Member Parish 2"; Code[15])
        {
            DataClassification = ToBeClassified;
            Enabled = false;
        }
        field(50159; "Member Parish Name 2"; Text[15])
        {
            DataClassification = ToBeClassified;
            Enabled = false;
        }
        field(50160; "Name of the Group/Corporate"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50161; "Date of Registration"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50162; "No of Members"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50163; "Group/Corporate Trade"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50164; "Certificate No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50165; "ID No.2"; Code[15])
        {
            DataClassification = ToBeClassified;
        }
        field(50166; "Picture 2"; BLOB)
        {
            DataClassification = ToBeClassified;
            Enabled = false;
            SubType = Bitmap;
        }
        field(50167; "Signature  2"; BLOB)
        {
            DataClassification = ToBeClassified;
            Enabled = false;
            SubType = Bitmap;
        }
        field(50168; Title2; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Mr.,Mrs.,Miss.,DR.,Prof.,Fr.,Sr.,Bro.';
            OptionMembers = " ","Mr.","Mrs.","Miss.","DR.","Prof.","Fr.","Sr.","Bro.";
        }
        field(50169; "Mobile No. 3"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50170; "Date of Birth2"; Date)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                GenSetUp: Record "Sacco General Set-Up";
            begin
                IF "Date of Birth" > TODAY THEN
                    ERROR('Date of birth cannot be greater than today');


                IF "Date of Birth" <> 0D THEN BEGIN
                    IF GenSetUp.GET() THEN BEGIN
                        IF CALCDATE(GenSetUp."Min. Member Age", "Date of Birth") > TODAY THEN
                            ERROR('Applicant bellow the mininmum membership age of %1', GenSetUp."Min. Member Age");
                    END;
                END;
            end;
        }
        field(50171; "Marital Status2"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ",Single,Married,Devorced,Widower,Widow;
        }
        field(50172; Gender2; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Male,Female';
            OptionMembers = " ",Male,Female;
        }
        field(50173; "Address3-Joint"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50174; "Home Postal Code2"; Code[15])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Post Code";

            trigger OnValidate()
            begin
                /*PostCode.RESET;
                PostCode.SETRANGE(PostCode.Code,"Home Postal Code2");
                IF PostCode.FIND('-') THEN BEGIN
                "Home Town":=PostCode.City
                END;
                */

            end;
        }
        field(50175; "Home Town2"; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50176; "Payroll/Staff No2"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(50177; "Employer Code2"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "HR Asset Transfer Header";

            trigger OnValidate()
            begin
                /*Employer.GET("Employer Code");
                "Employer Name":=Employer.Description;
                */

            end;
        }
        field(50178; "Employer Name2"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50179; "E-Mail (Personal2)"; Text[25])
        {
            DataClassification = ToBeClassified;
        }
        field(50180; "Contact Person Phone"; Code[15])
        {
            DataClassification = ToBeClassified;
        }
        field(50181; "ContactPerson Relation"; Code[15])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Relationship Types";
        }
        field(50182; "Recruited By"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Customer."No.";

            trigger OnValidate()
            begin
                /*ve.RESET;
                Cust.SETRANGE(Cust."No.","Recruited By");
                IF Cust.FIND('-') THEN BEGIN
                "Recruiter Name":=Cust.Name;
               END;
               */

            end;
        }
        field(50183; Dioces; Code[10])
        {
            DataClassification = ToBeClassified;
            Enabled = false;
        }
        field(50184; "Mobile No. 2"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50185; "Employer Name"; Code[15])
        {
            DataClassification = ToBeClassified;
        }
        field(50186; Title; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Mr.,Mrs.,Miss.,DR.,Prof.,Fr.,Sr.,Bro.';
            OptionMembers = " ","Mr.","Mrs.","Miss.","DR.","Prof.","Fr.","Sr.","Bro.";
        }
        field(50187; Town; Code[20])
        {
            DataClassification = ToBeClassified;
            Enabled = false;
        }
        field(50188; "Received 1 Copy Of ID"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50189; "Received 1 Copy Of Passport"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50190; "Specimen Signature"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50191; Created; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50192; "Incomplete Application"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50193; "Created By"; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(50194; "Assigned No."; Code[20])
        {
            CalcFormula = Lookup(Customer."No." WHERE("ID No." = FIELD("ID No.")));
            FieldClass = FlowField;
        }
        field(50195; "Home Town"; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50196; "Recruiter Name"; Text[20])
        {
            DataClassification = ToBeClassified;
            Enabled = false;
        }
        field(50197; "Copy of Current Payslip"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50198; "Member Registration Fee Receiv"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50199; "Copy of KRA Pin"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50200; "Contact person age"; Date)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                /* IF "Contact person age" > TODAY THEN
                 ERROR('Age cannot be greater than today');
                
                
                IF "Contact person age" <> 0D THEN BEGIN
                IF GenSetUp.GET() THEN BEGIN
                IF CALCDATE(GenSetUp."Min. Member Age","Contact person age") > TODAY THEN
                ERROR('Contact person should be atleast 18years and above %1',GenSetUp."Min. Member Age");
                END;
                END;  */

            end;
        }
        field(50201; "First member name"; Text[20])
        {
            DataClassification = ToBeClassified;
            Enabled = false;
        }
        field(50202; "Date Establish"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50203; "Registration No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50204; "Self Recruited"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50205; "Relationship With Recruiter"; Code[15])
        {
            DataClassification = ToBeClassified;
            Enabled = false;
        }
        field(50206; "Application Category"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'New Application,Rejoining,Transfer';
            OptionMembers = "New Application",Rejoining,Transfer;
        }
        field(50207; "Members Parish"; Code[20])
        {
            DataClassification = ToBeClassified;
            Enabled = false;
            TableRelation = "Member's Parishes".Code;

            trigger OnValidate()
            var
                Parishes: Record "Member's Parishes";
                GenSetUp: Record "Sacco General Set-Up";
            begin
                Parishes.RESET;
                Parishes.SETRANGE(Parishes.Code, "Members Parish");
                IF Parishes.FIND('-') THEN BEGIN
                    "Parish Name" := Parishes.Description;
                END;
            end;
        }
        field(50208; "Parish Name"; Text[20])
        {
            DataClassification = ToBeClassified;
            Enabled = false;
        }
        field(50209; "Employment Info"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Employed,UnEmployed,Contracting,Others';
            OptionMembers = " ",Employed,UnEmployed,Contracting,Others;
        }
        field(50210; "Contracting Details"; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50211; "Others Details"; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50212; "Contact Person"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50213; "Office Telephone No."; Code[5])
        {
            DataClassification = ToBeClassified;
        }
        field(50214; "Extension No."; Code[5])
        {
            DataClassification = ToBeClassified;
        }
        field(50215; "On Term Deposit Maturity"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Pay to FOSA Account_ Deposit+Interest,Roll Back Deposit+Interest,Roll Back Deposit Only';
            OptionMembers = " ","Pay to FOSA Account_ Deposit+Interest","Roll Back Deposit+Interest","Roll Back Deposit Only";
        }
        field(50216; "Member's Residence"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50217; "Joint Account Name"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50218; "Postal Code 3"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Post Code";
        }
        field(50219; "Town 3"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50220; "Passport 3"; Code[15])
        {
            DataClassification = ToBeClassified;
        }
        field(50221; "Member Parish 3"; Code[10])
        {
            DataClassification = ToBeClassified;
            Enabled = false;
        }
        field(50222; "Member Parish Name 3"; Text[15])
        {
            DataClassification = ToBeClassified;
            Enabled = false;
        }
        field(50223; "Picture 3"; BLOB)
        {
            DataClassification = ToBeClassified;
            SubType = Bitmap;
        }
        field(50224; "Signature  3"; BLOB)
        {
            DataClassification = ToBeClassified;
            SubType = Bitmap;
        }
        field(50225; Title3; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Mr.,Mrs.,Miss.,DR.,Prof.,Fr.,Sr.,Bro.';
            OptionMembers = " ","Mr.","Mrs.","Miss.","DR.","Prof.","Fr.","Sr.","Bro.";
        }
        field(50226; "Mobile No. 3-Joint"; Code[15])
        {
            DataClassification = ToBeClassified;
        }
        field(50227; "Date of Birth3"; Date)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                GenSetUp: Record "Sacco General Set-Up";

            begin
                IF "Date of Birth" > TODAY THEN
                    ERROR('Date of birth cannot be greater than today');


                IF "Date of Birth" <> 0D THEN BEGIN
                    IF GenSetUp.GET() THEN BEGIN
                        IF CALCDATE(GenSetUp."Min. Member Age", "Date of Birth") > TODAY THEN
                            ERROR('Applicant bellow the mininmum membership age of %1', GenSetUp."Min. Member Age");
                    END;
                END;
            end;
        }
        field(50228; "Marital Status3"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ",Single,Married,Devorced,Widower,Widow;
        }
        field(50229; Gender3; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Male,Female';
            OptionMembers = " ",Male,Female;
        }
        field(50230; Address3; Code[15])
        {
            DataClassification = ToBeClassified;
        }
        field(50231; "Home Postal Code3"; Code[15])
        {
            DataClassification = ToBeClassified;
            // TableRelation = "Post Code";

            trigger OnValidate()
            begin
                // PostCode.RESET;
                // PostCode.SETRANGE(PostCode.Code,"Home Postal Code");
                // IF PostCode.FIND('-') THEN BEGIN
                // "Home Town":=PostCode.City
                // END;
            end;
        }
        field(50232; "Home Town3"; Text[15])
        {
            DataClassification = ToBeClassified;
        }
        field(50233; "Payroll/Staff No3"; Code[5])
        {
            DataClassification = ToBeClassified;
        }
        field(50234; "Employer Code3"; Code[15])
        {
            DataClassification = ToBeClassified;
            TableRelation = "HR Asset Transfer Header";

            trigger OnValidate()
            begin
                /*Employer.GET("Employer Code");
                "Employer Name":=Employer.Description;
                */

            end;
        }
        field(50235; "Employer Name3"; Code[15])
        {
            DataClassification = ToBeClassified;
        }
        field(50236; "E-Mail (Personal3)"; Text[25])
        {
            DataClassification = ToBeClassified;
        }
        field(50237; "Name 3"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50238; "ID No.3"; Code[15])
        {
            DataClassification = ToBeClassified;
        }
        field(50239; "Mobile No. 4"; Code[15])
        {
            DataClassification = ToBeClassified;
        }
        field(50240; Address4; Code[15])
        {
            DataClassification = ToBeClassified;
        }
        field(50241; "Expected Interest On Term Dep"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50242; "Current Account Balance"; Decimal)
        {
            CalcFormula = - Sum("Detailed Vendor Ledg. Entry"."Amount (LCY)" WHERE("Vendor No." = FIELD("Savings Account No."),
                                                                                   "Initial Entry Global Dim. 1" = FIELD("Global Dimension 1 Filter"),
                                                                                   "Initial Entry Global Dim. 2" = FIELD("Global Dimension 2 Filter"),
                                                                                   "Currency Code" = FIELD("Currency Filter")));
            FieldClass = FlowField;
        }
        field(50243; "Allowable Cheque Discounting %"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50244; "Cheque Discounted"; Decimal)
        {
            //todo
            CalcFormula = Sum(Transactions."Cheque Discounted Amount" WHERE("Account No" = FIELD("No."),
                                                                             Posted = CONST(true),
                                                                             "Cheque Processed" = CONST(false),
                                                                             "Type _Transactions" = CONST("Cheque Deposit")));
            FieldClass = FlowField;
        }
        field(50245; "Mobile Transactions"; Decimal)
        {
            CalcFormula = Sum("Mobile Banking Transactions".Amount WHERE(Posted = CONST(false),
                                                                     Status = CONST(Pending)));
            FieldClass = FlowField;
        }
        field(50246; "Staff Account"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50247; "Debt Collector"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50248; "Debt Collector %"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50249; "Comission On Cheque Discount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50250; "Fixed Deposit Start Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50251; "Prevous Fixed Deposit Type"; Code[15])
        {
            DataClassification = ToBeClassified;
        }
        field(50252; "Prevous FD Start Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50253; "Prevous Fixed Duration"; DateFormula)
        {
            DataClassification = ToBeClassified;
        }
        field(50254; "Prevous Expected Int On FD"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50255; "Prevous FD Maturity Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50256; "Prevous FD Deposit Status Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Matured;
        }
        field(50257; "Prevous Interest Rate FD"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50258; "Last Interest Earned Date"; Date)
        {
            //todo
            CalcFormula = Max("Interest Buffer"."Interest Date" WHERE("Account No" = FIELD("No.")));
            FieldClass = FlowField;
        }
        field(50259; "Last Salary Earned"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50260; "Reason for Freezing Account"; Code[15])
        {
            DataClassification = ToBeClassified;
        }
        field(50261; "Account Frozen By"; Code[15])
        {
            DataClassification = ToBeClassified;
        }
        field(50262; "Fixed Deposit Certificate No."; Code[15])
        {
            DataClassification = ToBeClassified;
        }
        field(50263; "E-Loan Qualification Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50264; "Pension No"; Code[15])
        {
            DataClassification = ToBeClassified;
        }
        field(50265; "Doublicate Accounts"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50266; "Assigned System ID"; Code[15])
        {
            DataClassification = ToBeClassified;
            TableRelation = User."User Name";
        }
        field(50267; "Prevous Blocked Status"; enum "Vendor Blocked")
        {
            DataClassification = ToBeClassified;
            // OptionCaption = ' ,Payment,All';
            // OptionMembers = " ",Payment,All;
        }
        field(50268; "Untransfered interest Savings"; Decimal)
        {
            // CalcFormula = Sum("Interest Buffer Savings"."Interest Amount" WHERE ("Account No"=FIELD("No."),
            //                                                                      Transferred=FILTER(false)));
            // FieldClass = FlowField;
        }
        field(50269; "Sacco No"; Code[15])
        {
            DataClassification = ToBeClassified;
        }
        field(50270; "Account Book Balance"; Decimal)
        {
            CalcFormula = Sum("Detailed Vendor Ledg. Entry".Amount WHERE("Vendor No." = FIELD("No."),
                                                                          "Posting Date" = FIELD("Date Filter")));
            FieldClass = FlowField;
        }
        field(50271; "Account Special Instructions"; Code[15])
        {
            DataClassification = ToBeClassified;
        }
        field(50272; "Cheque Discounted Amount"; Decimal)
        {
            //todo"
            FieldClass = FlowField;
            CalcFormula = sum(Transactions."Cheque Discounted Amount" where("Account No." = field("No."), Posted = const(true),
            Type = const('Cheque Deposit'),
            "Cheque Processed" = filter(false)));
        }

        field(50273; "Bulk Withdrawal Appl Done"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50274; "Bulk Withdrawal Appl Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50275; "Bulk Withdrawal Appl Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50276; "Bulk Withdrawal Fee"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50277; "Bulk Withdrawal App Done By"; Code[15])
        {
            DataClassification = ToBeClassified;
        }
        field(50278; "Bulk Withdrawal App Date For W"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50279; "Referee Member No"; Code[15])
        {
            DataClassification = ToBeClassified;
            TableRelation = Customer."No.";

            trigger OnValidate()
            var
                Cust: Record Customer;
            begin
                IF Cust.GET("Referee Member No") THEN BEGIN
                    "Referee Name" := Cust.Name;
                    "Referee Mobile Phone No" := Cust."Mobile Phone No";
                    "Referee ID No" := Cust."ID No.";
                END;
            end;
        }
        field(50280; "Referee Name"; Code[25])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50281; "Referee ID No"; Code[15])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50282; "Referee Mobile Phone No"; Code[15])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50283; "Email Indemnified"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50284; "Send E-Statements"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50285; "Sacco Lawyer"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50286; "ATM Withdrawal Limit"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50287; "No Of Signatories"; Integer)
        {
            CalcFormula = Count("FOSA Account Sign. Details" WHERE("Account No" = FIELD("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50288; "Cheque Clearing No"; Code[5])
        {
            DataClassification = ToBeClassified;
        }
        field(50289; "Excess Repayment Rule"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Exempt From Excess Rule,Biggest Loan,Smallest Loan,Oldest Loan,Newest Loan';
            OptionMembers = " ","Exempt From Excess Rule","Biggest Loan","Smallest Loan","Oldest Loan","Newest Loan";
        }
        field(50290; "Insurance Company"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50291; "Over Draft Limit Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50292; "Over Draft Limit Expiry Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50293; Auctioneer; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50294; "Account Type Name"; Text[50])
        {
            CalcFormula = Lookup("Account Types-Saving Products".Description WHERE(Code = FIELD("Account Type")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50295; "Balance For Reporting"; Decimal)
        {
            CalcFormula = Sum("Detailed Vendor Ledg. Entry".Amount WHERE("Vendor No." = FIELD("No."),
                                                                          "Initial Entry Global Dim. 1" = FIELD("Global Dimension 1 Filter"),
                                                                          "Initial Entry Global Dim. 2" = FIELD("Global Dimension 2 Filter"),
                                                                          "Currency Code" = FIELD("Currency Filter"),
                                                                          "Posting Date" = FIELD("Date Filter")));
            FieldClass = FlowField;
        }
        field(50296; "Frozen Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50297; "Operating Mode"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Self,Jointly';
            OptionMembers = Self,Jointly;
        }
        field(50298; "Account Creation Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50299; "Modified By"; Code[18])
        {
            DataClassification = ToBeClassified;
        }
        field(50300; "Modified On"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50301; "Supervised On"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50302; "Supervised By"; Code[15])
        {
            DataClassification = ToBeClassified;
        }
        field(50303; "Account Closed On"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50356; "Account Closed By"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50305; "Balance Historical"; Decimal)
        {
            CalcFormula = Sum("Member Historical Ledger Entry".Amount WHERE("Account No." = FIELD("No."),
                                                                             "Posting Date" = FIELD("Date Filter")));
            FieldClass = FlowField;
        }
        field(50306; "Transaction Alerts"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,All Debit Transactions,All Credit Transactions,All Transactions';
            OptionMembers = " ","All Debit Transactions","All Credit Transactions","All Transactions";
        }
        field(50307; Dormancy; Boolean)
        {
            CalcFormula = Exist("Detailed Vendor Ledg. Entry" WHERE("Posting Date" = FIELD("Date Filter"),
                                                                     "Vendor No." = FIELD("No.")));
            FieldClass = FlowField;
        }
        field(50308; "Account Balance"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50309; "KRA Pin"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50310; "Exempt BOSA Penalty"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50311; "Exemption Expiry Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50312; "Send To Family Bank"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50313; "Overdraft Sweeping Source"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'All FOSA Accounts,Specific FOSA Account';
            OptionMembers = "All FOSA Accounts","Specific FOSA Account";
        }
        field(50314; "Specific OD Sweeping Account"; Code[15])
        {
            DataClassification = ToBeClassified;
            TableRelation = Vendor."No." WHERE("BOSA Account No" = FIELD("BOSA Account No"));
        }
        field(50315; "Minimum Balance"; Decimal)
        {
            CalcFormula = Sum("Account Types-Saving Products"."Minimum Balance" WHERE(Code = FIELD("Account Type")));
            FieldClass = FlowField;
        }
        field(50316; "Deposits Contributed Ver1"; Decimal)
        {
            CalcFormula = Sum("Detailed Vendor Ledg. Entry".Amount WHERE("Vendor No." = FIELD("No."),
                                                                          "Posting Date" = FIELD("Date Filter")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50317; "OD Under Debt Collection"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50318; "OD Debt Collector"; Code[15])
        {
            DataClassification = ToBeClassified;
            TableRelation = Vendor."No." WHERE("Debt Collector" = FILTER(true));

            trigger OnValidate()
            var
                Vend: Record Vendor;
            begin
                Vend.RESET;
                Vend.CALCFIELDS(Vend.Balance);
                Vend.SETRANGE(Vend."No.", "OD Debt Collector");
                IF Vend.FIND('-') THEN BEGIN
                    "OD Debt Collector Interest %" := Vend."Debt Collector %";
                    "OD Under Debt Collection" := TRUE;
                    "Debt Collector Name" := Vend.Name;
                    "Debt Collection date Assigned" := WORKDATE;
                    "OD Bal As At Debt Collection" := Vend.Balance;
                END;
            end;
        }
        field(50319; "OD Debt Collector Interest %"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50320; "Debt Collection date Assigned"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50321; "Debt Collector Name"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50322; "OD Bal As At Debt Collection"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50323; "Dormant Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50324; "Account Dormancy Period"; Boolean)
        {
            CalcFormula = Exist("Account Types-Saving Products" WHERE(Code = FIELD("Account Type"),
                                                                       "Dormancy Period (-M)" = FILTER(<> '')));
            FieldClass = FlowField;
        }
        field(50325; "Last Transaction Date_H"; Date)
        {
            AutoFormatType = 1;
            CalcFormula = Max("Member Historical Ledger Entry"."Posting Date" WHERE("Account No." = FIELD("No.")));
            Caption = 'Last Transaction Date';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50326; "Last Transaction Date VerII"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50327; "Silver Account No"; Code[200])
        {
            DataClassification = ToBeClassified;
        }
        field(50328; piccture; MediaSet)
        {
            DataClassification = ToBeClassified;
        }
        field(50329; "Last Name"; Code[200])
        {
            DataClassification = ToBeClassified;
        }
        field(50330; "First Name"; Code[200])
        {
            DataClassification = ToBeClassified;
        }
        field(50331; "Middle Name"; Code[200])
        {
            DataClassification = ToBeClassified;
        }
        field(50332; "NHIF No"; Code[40])
        {
            DataClassification = ToBeClassified;
        }
        field(50333; "Religion."; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = ,Christians,Muslims,Jews,"Religiously Unaffiliated",Hindus,Buddhists,"Other Religions";
            OptionCaption = ',Christians,Muslims,Jews,Religiously Unaffiliated,Hindus,Buddhists,Other Religions';

        }
        field(50334; "Retirement Date"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;

        }

        field(50335; Age; Text[500])
        {
        }

        field(50336; "Member Type"; Option)
        {
            OptionMembers = Member,Staff,Board,"Station Representative";
            OptionCaption = 'Member,Staff,Board,Station Representative';

        }
        field(50337; "Exempted From Tax"; Boolean)
        {

        }
        field(50338; "How did you know about us?"; Text[1200])
        {

        }
        field(50339; "Sub-county"; Text[250])
        {
            TableRelation = "Sub-County" where("County Code" = field(County));

        }
        field(50340; "Area"; Code[100])
        {

        }
        field(50341; "Work E-Mail"; Code[100])
        {

        }

        field(50342; "Nearest Landmark"; Text[100])
        {

        }

        field(50343; "Mode Of Remmittance"; Option)
        {
            OptionCaption = ',Checkoff,"Standing Order",Cash,M-Pesa,"Direct Debit"';
            OptionMembers = ,Checkoff,"Standing Order",Cash,"M-Pesa","Direct Debit";
        }

        field(50344; "Religion"; Text[100])
        {
            DataClassification = ToBeClassified;

        }


        field(50345; "Station Representative"; Text[100])
        {
            DataClassification = ToBeClassified;

        }



        field(50346; "Receive SMS Notification"; Boolean)
        {
            DataClassification = ToBeClassified;

        }



        field(50347; "Workstation"; Code[100])
        {
            DataClassification = ToBeClassified;

        }
        field(50348; "KTDA Buying Centre"; Code[100])
        {
            DataClassification = ToBeClassified;

        }
        field(50304; "New/Rejoining"; Option)
        {
            OptionCaption = 'New,Rejoining';
            OptionMembers = New,Rejoining;
        }
        field(50349; "How Did you Know us?"; Option)
        {
            OptionCaption = ',Website,"Social Media",Marketing,Member,Partnership';
            OptionMembers = ,Website,"Social Media",Marketing,Member,Partnership;
        }
        field(50350; "Registration Fee"; Decimal)
        {

        }
        field(50351; "Registration Fee Comm %"; Decimal)
        {

        }
        field(50352; "Registration Fee Comm Amount"; Decimal)
        {

        }
        field(50353; "Why Exempt from Tax?"; Text[2048])
        {

        }
        field(50354; "Reffered By Member No"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = Customer where(ISNormalMember = const(true));
            trigger OnValidate()
            var
                Cust: Record Customer;
                GenSetUp: Record "Sacco General Set-Up";
            begin
                Cust.Reset();
                Cust.SetRange(Cust."No.", "Reffered By Member No");
                if Cust.FindFirst() then begin
                    "Reffered By Member Name" := Cust.Name;
                    "Referee ID No" := Cust."ID No.";
                end;
                GenSetUp.Get();
                "Registration Fee Comm Amount" := (GenSetUp."BOSA Registration Fee Amount" * GenSetUp."BOSA RegistrationFee (%)") / 100;
            end;
        }
        field(50355; "Reffered By Member Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50357; "Secondary Mobile No"; Code[20])
        {
        }
        field(50358; "Postal Code"; Code[20])
        {
            TableRelation = "Post Code";

            trigger OnValidate()
            var
                PostCode: Record "Post Code";
            begin
                PostCode.Reset;
                PostCode.SetRange(PostCode.Code, "Postal Code");
                if PostCode.Find('-') then begin
                    Town := PostCode.City
                end;
            end;
        }

        field(50359; "Bank Name"; Code[30])
        {
            Editable = false;
        }
        field(50360; "Bank Branch Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Banks Ver2"."Branch Code";

            trigger OnValidate()
            var
                ObjBanks: Record "Banks Ver2";
            begin
                ObjBanks.Reset;
                ObjBanks.SetRange(ObjBanks."Branch Code", "Bank Branch Code");
                if ObjBanks.FindSet then begin
                    "Bank Branch Name" := ObjBanks."Branch Name";
                end;
            end;
        }
        field(50361; "Bank Branch Name"; Text[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50362; "Bank Account No"; Code[15])
        {

        }
        field(50002; "Old FOSA Account"; Code[60])
        {
            DataClassification = ToBeClassified;
        }
        field(50003; "Child Name"; text[2048])
        {
            DataClassification = ToBeClassified;
        }
        field(50004; "Child ID"; code[2048])
        {
            // DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                ages := (Today - "Child DOB") / 365;
                if ages < 18 then Error('The child has not reached the valid age for an ID number.');
            end;
        }
        field(50005; "Child Birth certificate"; code[2048])
        {
            DataClassification = ToBeClassified;
        }
        field(50006; "Group ID No"; code[2048])
        {
            DataClassification = ToBeClassified;
        }
        field(50007; "Fixed Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50008; "FD Interest Rate"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50009; "Vendor Account No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50010; "Amount Transfered?"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50011; "Date Transfered"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(50012; "Transferred By"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50013; "Employment Start Date"; Date)
        {
            Editable = false;
        }
        field(50014; "Employment End Date"; Date)
        {
            Editable = false;
        }

        field(50015; "Employment Period"; DateFormula)
        {
            Editable = false;
        }

        field(50016; "Tax Exemption Start Date"; Date)
        {
            Editable = false;
        }
        field(50017; "Tax Exemption End Date"; Date)
        {
            Editable = false;
        }
        field(50018; Designation; Code[2048])
        {
            TableRelation = Designation.Designation;
        }
        field(50110; Revoked; Boolean)
        {
            Editable = false;
        }
        field(50111; "Pending MPesa Withdrawals"; Decimal)
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum("Mpesa Withdawal Buffer"."Amount Requested" where("Vendor No" = field("No."), Posted = filter(false), Reversed = filter(false)));
        }

        field(50019; "Tax Exemption Period"; DateFormula)
        {
            Editable = false;
        }
        field(50020; "Membership Status"; Option)
        {
            Editable = true;

            OptionCaption = 'Active,Deceased,Retired,Dormant,Awaiting Exit,Exited,Fully Exited,Re-instated,Closed';
            OptionMembers = Active,Deceased,Retired,Dormant,"Awaiting Exit",Exited,"Fully Exited","Re-instated",Closed;

            trigger OnValidate()
            begin
                cust.Reset();
                cust.SetRange("No.", "BOSA Account No");
                cust.SetRange(ISNormalMember, true);
                if cust.FindSet() then begin
                    repeat
                        cust.Status := Status;
                        cust."Membership Status" := "Membership Status";
                        cust.modify;
                    until cust.Next() = 0;
                end;
            end;
        }

        field(50021; "Withdrawal Before Maturity Charges"; Decimal)
        {

            Editable = false;

        }
        field(50022; "Tax Rate %"; Decimal)
        {

            Editable = false;

        }
        field(50023; "Upon Maturity"; Option)
        {
            OptionCaption = ' ,Close the FXD against the Account,Roll-over the FXD and refix the Principal,Roll-over the FXD and refix the Principal and Interest';
            OptionMembers = " ","Close the FXD against the Account","Roll-over the FXD and refix the Principal","Roll-over the FXD and refix the Principal and Interest";
        }
        field(50024; "Computed Interest"; Decimal)
        {

            Editable = false;

        }
        field(50025; "Tax"; Decimal)
        {

            Editable = false;

        }
        field(50026; "Net Interest"; Decimal)
        {

            Editable = false;

        }
        field(50027; "Duration"; DateFormula)
        {

            Editable = false;

        }
        field(50028; "Contract No."; code[30])
        {



        }
        field(50363; "Account Balance."; Decimal)
        {
            Editable = false;
        }
        field(50364; "Salary Average Amount"; Decimal)
        {
            //todo
            CalcFormula = average("Member Transactions".Amount WHERE("FOSA Account No" = FIELD("No.")));
            FieldClass = FlowField;
        }
        field(50365; "ID Front"; MediaSet)
        {

        }
        field(50366; "ID Back"; MediaSet)
        {

        }
        field(50000; "Childs Gender"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Male,Female';
            OptionMembers = " ",Male,Female;
        }

        field(50001; "Child DOB"; Date)
        {
            trigger OnValidate()
            begin
                if "Child DOB" > Today then Error('The date of birth cannot be in the future.');
            end;
        }


        field(50367; "Amount to freeze"; Decimal)
        {

        }
        field(50368; "Net Salary"; Decimal)
        {
        }
        field(50369; "Deposit Contribution"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = - Sum("Member Ledger Entry".Amount WHERE("Customer No." = FIELD("BOSA Account No"), "Transaction Type" = CONST("Deposit Contribution")));
        }
        field(50370; "Shares Capital"; Decimal)
        {
            /*             FieldClass = FlowField;
                        CalcFormula = - Sum("Member Ledger Entry".Amount WHERE("Customer No." = FIELD("BOSA Account No"), "Transaction Type" = CONST("Share Capital"))); */
        }
        field(50371; "Salary earner"; Boolean)
        {
        }
        field(50372; "FOSA Loans"; Decimal)
        {
            FieldClass = FlowField;

            CalcFormula = Sum("Member Ledger Entry".Amount WHERE("Customer No." = FIELD("BOSA Account No"), "Transaction Type" = FILTER(Loan), "Loan No" = FILTER(<> '')));
        }
        field(50374; "Customer Next of Kin"; Boolean)
        {
            TableRelation = Customer."Has Next of Kin";
        }
        field(50373; "Account Type Options"; Option)
        {
            OptionMembers = "101","102","103";
            DataClassification = ToBeClassified;
            // TableRelation = "Account Types-Saving Products".Code;

            // trigger OnValidate()
            // var
            //     AccountTypes: Record "Account Types-Saving Products";
            // begin
            //     IF AccountTypes.GET("Account Type") THEN BEGIN
            //         AccountTypes.TESTFIELD(AccountTypes."Posting Group");
            //         "Vendor Posting Group" := AccountTypes."Posting Group";
            //         "Call Deposit" := FALSE;
            //         "Account Type Name" := AccountTypes.Description;
            //     END;
            // end;
        }
        field(50375; "Card Status"; Option)
        {
            OptionCaption = ' ,Pending,Active,Frozen';
            OptionMembers = " ",Pending,Active,Frozen;
            Editable = false;
            //  Enabled = false;
        }
        field(50376; "Old FOSA Account NAV2016"; Code[30])
        {

            Editable = false;
        }
        field(50377; "ZIP Code"; Code[300])
        {


        }
        field(50378; "Income Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Salary,Pension';
            OptionMembers = " ",Salary,Pension;
        }
        field(50379; "MPESA Mobile No"; Code[35])
        {
            DataClassification = ToBeClassified;
        }

        field(50380; "Business Name(Store)"; Code[80])
        {
            DataClassification = ToBeClassified;
        }
        field(50381; "Business Short Code(Store)"; Code[70])
        {
            DataClassification = ToBeClassified;
        }

        field(50382; "Business Type(Store)"; Code[70])
        {
            DataClassification = ToBeClassified;
        }
        field(50383; "Business Status(Store)"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ",Active,Dormant;
        }
        field(50384; "Business Location(Store)"; Code[80])
        {
            DataClassification = ToBeClassified;
        }
        field(50385; "Business Contact(Store)"; Code[80])
        {
            DataClassification = ToBeClassified;
        }

        field(50386; "Business Email(Store)"; Code[80])
        {
            DataClassification = ToBeClassified;
        }
        field(50387; "Business Phone(Store)"; Code[80])
        {
            DataClassification = ToBeClassified;
        }
        field(50388; "Business Website(Store)"; Text[500])
        {
            DataClassification = ToBeClassified;
        }

        field(50389; "Business Logo(Store)"; Blob)
        {
            DataClassification = ToBeClassified;
        }
        field(50390; "Business Description(Store)"; Text[500])
        {
            DataClassification = ToBeClassified;
        }
        field(50391; "Last Account Trans"; Date)
        {
            FieldClass = FlowField;
            CalcFormula = max("Detailed Vendor Ledg. Entry"."Posting Date" where("Vendor No." = field("No."), Reversed = filter(false)));
        }
        field(50392; "Transaction Amount"; Decimal)
        {
        }
        field(50393; "Last Transaction"; Text[500])
        {
        }
        field(50394; "Statement Balance"; Decimal)
        {
        }

        field(50395; "Start Date"; Date)
        {
        }
        field(50396; "End Date"; Date)
        {
        }

        field(50397; "Balance Filterable"; Decimal)
        {
            AutoFormatExpression = Rec."Currency Code";
            AutoFormatType = 1;
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = - sum("Detailed Vendor Ledg. Entry".Amount where("Vendor No." = field("No."), "Posting Date" = field("Date Filter"),
                                                                           "Initial Entry Global Dim. 1" = field("Global Dimension 1 Filter"),
                                                                           "Initial Entry Global Dim. 2" = field("Global Dimension 2 Filter"),
                                                                           "Currency Code" = field("Currency Filter")));
            Caption = 'Balance';
        }
        field(50398; "Sales Person"; Text[2048])
        {

        }
        field(50399; "Customer Service Rep."; Code[20])
        {

        }
        field(50400; "Customer Service Rep. Name"; Text[200])
        {

        }
        field(50401; "Application No."; Code[50])
        {
        }
        field(50402; "Group Category"; Option)
        {
            OptionMembers = "Co-operate",Chamaa;
            OptionCaption = 'Co-operate,Chamaa';
        }
        field(50403; "ATM Enabled"; Boolean)
        {
        }
        field(50404; "Flagged Transactions"; Decimal)
        {
            //todo"
            FieldClass = FlowField;
            CalcFormula = sum("MOBILE MPESA Trans".Amount where("Account No" = field("No."), "Transaction Found" = const(false), "Transaction Type" = filter('Withdrawal'), "Document Date" = filter('11/06/2024..14/06/24')));
        }
        field(50405; "Last Account Credit Trans"; Date)
        {
            FieldClass = FlowField;
            CalcFormula = max("Detailed Vendor Ledg. Entry"."Posting Date" where("Vendor No." = field("No."), Reversed = filter(false), "Credit Amount" = filter(> 0)));
        }
        field(50406; "Last Account Debit Trans"; Date)
        {
            FieldClass = FlowField;
            CalcFormula = max("Detailed Vendor Ledg. Entry"."Posting Date" where("Vendor No." = field("No."), Reversed = filter(false), "Debit Amount" = filter(> 0)));
        }
        field(50407; "Dividend amount"; Decimal)
        {
            //todo"

        }
        field(50408; "Salary Amount"; Decimal)
        {
            AutoFormatExpression = Rec."Currency Code";
            AutoFormatType = 1;
            CalcFormula = - sum("Detailed Vendor Ledg. Entry".Amount where("Vendor No." = field("No."),
                                                                           "Initial Entry Global Dim. 1" = field("Global Dimension 1 Filter"),
                                                                           "Initial Entry Global Dim. 2" = field("Global Dimension 2 Filter"),
                                                                           "Posting Date" = field("Date Filter"),
                                                                           "Document No." = filter('SAL*')));
            Caption = 'Salary Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50409; "Marketing Campaign ID"; Code[40])
        {
            Caption = 'Marketing Campaign ID';
            ToolTip = 'Specifies Marketing Campaign ID';
            TableRelation = "Marketing Campaign"."Campaign ID";
        }
        field(50410; "Marketing Event ID"; Code[40])
        {
            Caption = 'Marketing Event ID';
            ToolTip = 'Specifies who Marketing Event ID.';
            TableRelation = "Marketing Event"."Event ID" where("Campaign ID" = field("Marketing Campaign ID"));
        }
    }

    // Global Variables

    var
        AccountTypes: Record "Account Types-Saving Products";
        FDType: Record "Fixed Deposit Type";
        ReplCharge: Decimal;
        Vends: Record Vendor;
        gnljnlLine: Record "Gen. Journal Line";
        FOSAAccount: Record Vendor;
        Member: Record Customer;
        Vend: Record Vendor;
        Loans: Record "Loans Register";
        // StatusPermissions: Record "Status Change Permision";
        interestCalc: Record "FD Interest Calculation Crite";
        GenSetUp: Record "Sacco General Set-Up";
        Parishes: Record "Member's Parishes";
        FDDuration: Integer;
        ages: Decimal;
        Cust: Record Customer;

    procedure GetAvailableBalance() Balance: Decimal;
    var
        AvailableBalance: Decimal;
    begin
        Vend.SetRange("No.", "No.");
        Vend.SetAutoCalcFields(Balance, "Pending MPesa Withdrawals", "ATM Transactions", "Uncleared Cheques", "EFT Transactions");
        if Vend.FindFirst() then begin
            //   Balance := Vend.Balance;
            if Vend."Account Type" = '103' then begin
                vend.CalcFields(Balance, "Pending MPesa Withdrawals", "ATM Transactions", "Uncleared Cheques", "EFT Transactions");
                Balance := Vend.Balance - ((Vend."Uncleared Cheques" - Vend."Cheque Discounted Amount") + Vend."ATM Transactions" + Vend."EFT Transactions" + 1000 + Vend."Mobile Transactions" + Vend."Amount to freeze" + Vend."Pending MPesa Withdrawals");
            end else begin
                vend.CalcFields(Balance, "Pending MPesa Withdrawals", "ATM Transactions", "Uncleared Cheques", "EFT Transactions");
                Balance := Vend.Balance - ((Vend."Uncleared Cheques" - Vend."Cheque Discounted Amount") + Vend."ATM Transactions" + Vend."EFT Transactions" + Vend."Mobile Transactions" + Vend."Amount to freeze" + Vend."Pending MPesa Withdrawals");
            end;
        end;
        exit(Balance);
    end;
}
