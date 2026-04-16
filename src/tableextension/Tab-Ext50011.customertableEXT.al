//************************************************************************
tableextension 50011 "customertableEXT" extends Customer
{
    fields
    {
        // Add changes to table fields here
        field(50000; "Account Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Travel Advance,Staff Advance,Implementing Partner,Others,Donor,Member,CPD Provider,Institution';
            OptionMembers = " ","Travel Advance","Staff Advance","Implementing Partner",Others,Donor,Member,"CPD Provider",Institution;

            trigger OnValidate()
            begin
                //Prevent Changing once entries exist
                //TestNoEntriesExist(FIELDCAPTION("Account Type"));
            end;
        }
        field(50001; "Employee Job Group"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Salary Processing Header".No;
        }
        field(50002; "Donor Category"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Intramural,Extramural';
            OptionMembers = " ",Intramural,Extramural;
        }
        field(50003; "Allow Indirect Cost"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50004; "CPD Provider Reg Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50005; "Member Category Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50006; "No. SeriesCPD"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50007; "No. SeriesMember"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50008; "ISNormalMember"; Boolean)
        {
            DataClassification = ToBeClassified;

        }
        field(50009; "ID Number"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50010; "Member Category Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50011; "Graduation Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50012; "Member No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50013; Gender; Option)
        {
            DataClassification = ToBeClassified;
            //OptionMembers = Male,Female;
            OptionCaption = ' ,Male,Female';
            OptionMembers = " ",Male,Female;
        }
        field(50014; "Date Of Birth"; Date)
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
        field(50015; Religion; Enum MemberReligionEnum)
        {
            DataClassification = ToBeClassified;
        }
        field(50016; Citizenship; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50017; "Passport No"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50018; Age; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50019; "Spa Membership Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ",Full,Partial;
        }
        field(50020; "Insurance Account"; Boolean)
        {

        }
        field(50466; "Staff Paid"; Boolean)
        {

        }
        field(50021; "Code"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50022; CodeII; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50023; "Vs No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50024; Debtors; Decimal)
        {
            CalcFormula = sum("Detailed Cust. Ledg. Entry".Amount
             where("Posting Date" = field("Date Filter"),
                                                                 "Customer No." = field("No.")));
            FieldClass = FlowField;
        }
        field(50025; "Last Deposit Date"; Date)
        {
            FieldClass = FlowField;
            CalcFormula = max("Detailed Vendor Ledg. Entry"."Posting Date" where("Vendor No." = field("Deposits Account No"), Reversed = filter(false)));
        }
        field(50026; "Recruited Members"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count(Customer where("Reffered By Member No" = field("No.")));
        }
        field(50027; "Total Interest Income"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = - sum("Detailed Cust. Ledg. Entry".Amount where("Customer No." = field("No."), Reversed = filter(false),
                                                                        "Transaction Type" = filter("Interest Paid"), "Posting Date" = field("Date Filter")));
        }
        field(50199; "Old Deposit Balance"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = - sum("Old Member Ledger Entries".Amount where("Member No." = field("No."), Reveresed = filter('FALSE'), Transaction = filter('Deposit Contribution'), "Posting Date" = field("Date Filter")));
        }
        field(50200; "Old ESS Balance"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = - sum("Old Member Ledger Entries".Amount where("Member No." = field("No."), Reveresed = filter('FALSE'), Transaction = filter('SchFee Shares'), "Posting Date" = field("Date Filter")));
        }
        field(50201; "Old Share Capital Balance"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = - sum("Old Member Ledger Entries".Amount where("Member No." = field("No."), Reveresed = filter('FALSE'), Transaction = filter('Shares Capital'), "Posting Date" = field("Date Filter")));
        }
        field(50028; testing; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50203; "Customer Type"; Option)
        {
            OptionCaption = ' ,Member,FOSA,Investments,Property,MicroFinance';
            OptionMembers = " ",Member,FOSA,Investments,Property,MicroFinance;
        }
        field(50029; "Registration Date"; Date)
        {
        }
        field(50030; "Current Loan"; Decimal)
        {
            CalcFormula = sum("Detailed Cust. Ledg. Entry".Amount where("Customer No." = field("No."), "Transaction Type" = const("Share Capital"),
                                                                  "Posting Date" = field("Date Filter"), "Document No." = field("Document No. Filter")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50031; "Current Shares"; Decimal)
        {
            // CalcFormula = - sum("Detailed Vendor Ledg. Entry".Amount where("Vendor No." = field("Deposits Account No"),/* "Document No." = filter(<>'DEPOSBBF310324'),*/
            //Reversed = filter(False), "Posting Date" = field("Date Filter")));
            CalcFormula = - sum("Detailed Cust. Ledg. Entry".Amount where("Customer No." = field("No."),
                                                                  "Transaction Type" = filter("Deposit Contribution"), "Posting Date" = field("Date Filter")
                                                                  ));

            Editable = false;
            FieldClass = FlowField;
        }
        field(50032; "Total Repayments"; Decimal)
        {
            Editable = false;
        }
        field(50033; "Principal Balance"; Decimal)
        {
        }
        field(50034; "Principal Repayment"; Decimal)
        {
        }
        field(50035; "Debtors Type"; Option)
        {
            OptionCaption = ' ,Staff,Client,Others';
            OptionMembers = " ",Staff,Client,Others;
        }
        field(50036; "Total Loan Balance"; Decimal)
        {
            CalcFormula = sum("Detailed Cust. Ledg. Entry".Amount where("Customer No." = field("No."), Reversed = filter(false), "Posting Date" = field("Date Filter"),
                                                                        "Transaction Type" = filter(repayment | Loan | "Interest Paid" | "Interest Due" | "Loan Penalty Charged" | "Loan Penalty Paid")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50037; "Outstanding Balance"; Decimal)
        {
            CalcFormula = sum("Detailed Cust. Ledg. Entry".Amount where("Customer No." = field("No."), Reversed = filter(false),
                                                                  "Transaction Type" = filter(repayment | Loan), "Posting Date" = field("Date Filter")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50038; Status; Option)
        {
            Editable = true;
            Caption = 'Transaction Status';
            //<Active,Non-Active,Blocked,Dormant,Re-instated,Deceased,Withdrawal,Retired,Termination,Resigned,Ex-Company,Casuals,Family Member,Defaulter,Awaiting Withdrawal,Closed>
            // OptionCaption = 'Active,Blocked,Dormant,"Re-instated",Deceased,Withdrawn,Retired,Closed';
            // OptionMembers = Active,Blocked,Dormant,"Re-instated",Deceased,Withdrawn,Retired,Closed;


            OptionCaption = 'Active,Frozen,Dormant,Archived,Closed,Deceased';
            //Active,Frozen,Closed,Archived,New,Dormant,Deceased
            OptionMembers = Active,Frozen,Dormant,Archived,Closed,Deceased;

            trigger OnValidate()
            begin
                //Advice:=TRUE;
                //"Status Change Date" := TODAY;
                //"Last Marking Date" := TODAY;
                //MODIFY;
                /*
                IF xRec.Status=xRec.Status::Deceased THEN
                ERROR('Deceased status cannot be changed');
                
                Vend2.RESET;
                Vend2.SETRANGE(Vend2."Staff No","Payroll/Staff No");
                Vend2.SETRANGE(Vend2."Account Type",'PRIME');
                IF Vend2.FIND('-') THEN BEGIN
                REPEAT
                IF Status = Status::Deceased THEN BEGIN
                IF (Vend2."Account Type"<>'JUNIOR') THEN BEGIN
                Vend2.Status:=Vend2.Status::"6";
                Vend2.Blocked:=Vend2.Blocked::All;
                Vend2.MODIFY;
                END;
                END;
                UNTIL Vend2.NEXT = 0;
                END;
                
                //Charge Entrance fee on reinstament
                IF Status=Status::"Re-instated" THEN BEGIN
                GenSetUp.GET(0);
                "Registration Fee":=GenSetUp."Registration Fee";
                MODIFY;
                END;
                
                IF (Status<>Status::Active) OR (Status<>Status::Dormant) THEN
                Blocked:=Blocked::All;
                 */

                "Previous Status" := xRec.Status;//==========================================================update previous Membership Status
                "Status Change Date" := WorkDate;
                "Status Changed By" := UserId;

            end;
        }
        field(50039; "FOSA Account No."; Code[20])
        {
            TableRelation = Vendor."No.";
        }
        field(50040; "Old Account No2."; Code[10])
        {
            Enabled = false;
        }
        field(50041; "Loan Product Filter"; Code[15])
        {
            FieldClass = FlowFilter;
            TableRelation = "Loan Products Setup".Code;
        }
        field(50042; "Employer Code"; Code[120])
        {
            TableRelation = "Employers Register"."Employer Code";

            trigger OnValidate()
            begin
                /*Vend2.RESET;
                Vend2.SETRANGE(Vend2."Staff No","Payroll/Staff No");
                IF Vend2.FIND('-') THEN BEGIN
                REPEAT
                Vend2."Company Code":="Employer Code";
                Vend2.MODIFY;
                UNTIL Vend2.NEXT = 0;
                END;*/

            end;
        }
        field(50043; "Date of BirthN"; Date)
        {

            trigger OnValidate()
            begin
                /*IF "Date of Birth" <> 0D THEN BEGIN
                IF GenSetUp.GET(0) THEN BEGIN
                IF CALCDATE(GenSetUp."Min. Member Age","Date of Birth") > TODAY THEN
                ERROR('Applicant bellow the mininmum membership age of %1',GenSetUp."Min. Member Age");
                END;
                END;*/
                /*
              IF "Date of Birth" > TODAY THEN
              ERROR('Date of birth cannot be greater than today');
               */

            end;
        }
        field(50044; "E-Mail (Personal)"; Text[50])
        {
        }
        field(50045; "Station/Department"; Code[2])
        {
        }
        field(50046; "Home Address"; Text[20])
        {
        }
        field(50047; Location; Text[50])
        {
            Enabled = false;
        }
        field(50048; "Sub-Location"; Text[20])
        {
            Enabled = false;
        }
        field(50049; District; Text[20])
        {
        }
        field(50050; "Resons for Status Change"; Text[20])
        {
        }
        field(50051; "Payroll No"; Code[20])
        {

            trigger OnValidate()
            begin
                /*IF "Customer Type" = "Customer Type"::" " THEN
                EXIT;
                
                IF "Customer Type" = "Customer Type"::FOSA THEN
                EXIT;
                IF "Payroll/Staff No"<>'' THEN BEGIN
                Cust.RESET;
                Cust.SETRANGE(Cust."Payroll/Staff No","Payroll/Staff No");
                Cust.SETRANGE(Cust."Customer Type",Cust."Customer Type"::Member);
                IF Cust.FIND('-') THEN BEGIN
                //IF Cust."No." <> "No." THEN
                   //ERROR('Staff/Payroll No. already exists');
                END;
                END;
                
                IF xRec."Payroll/Staff No"<>'' THEN BEGIN
                IF "Payroll/Staff No"<>xRec."Payroll/Staff No" THEN BEGIN
                IF CONFIRM('Are you sure you want to change the staff number?',TRUE)=TRUE THEN BEGIN
                CustFosa:='5-02-'+"No."+'-00';
                
                //MESSAGE('%1',CustFosa);
                
                
                
                Cust.RESET;
                Cust.SETRANGE(Cust."Customer Type",Cust."Customer Type"::FOSA);
                Cust.SETRANGE("No.",CustFosa);
                IF Cust.FIND('-') THEN BEGIN
                Cust."Payroll/Staff No":="Payroll/Staff No";
                END;
                
                
                
                
                Vend.RESET;
                Vend.SETRANGE(Vend."No.","FOSA Account");
                IF Vend.FIND('-') THEN BEGIN
                IF Vend."Staff No" <> '' THEN BEGIN
                Vend2.RESET;
                Vend2.SETRANGE(Vend2."Staff No",Vend."Staff No");
                IF Vend2.FIND('-') THEN BEGIN
                REPEAT
                Vend2."Staff No":="Payroll/Staff No";
                Vend2.MODIFY;
                UNTIL Vend2.NEXT = 0;
                END;
                END;
                END;
                Vend.RESET;
                Vend2.RESET;
                
                Loans.RESET;
                Loans.SETRANGE(Loans."Client Code","No.");
                Loans.SETFILTER(Loans.Source,'BOSA');
                IF Loans.FIND('-') THEN BEGIN
                REPEAT
                //MESSAGE('NIMEGET %1%2',"Staff No",Loans."Staff No");
                Loans."Staff No":="Payroll/Staff No";
                Loans.MODIFY;
                UNTIL Loans.NEXT=0;
                END;
                
                Loans.RESET;
                Loans.SETRANGE(Loans."Client Code","FOSA Account");
                Loans.SETFILTER(Loans.Source,'FOSA');
                IF Loans.FIND('-') THEN BEGIN
                REPEAT
                //MESSAGE('NIMEGET %1%2',"Staff No",Loans."Staff No");
                Loans."Staff No":="Payroll/Staff No";
                Loans.MODIFY;
                UNTIL Loans.NEXT=0;
                END;
                
                
                
                END
                ELSE
                "Payroll/Staff No":=xRec."Payroll/Staff No"
                END;
                END;     */

            end;
        }
        field(50052; "ID No."; Code[30])
        {

            trigger OnValidate()
            begin
                /*IF "ID No."<>'' THEN BEGIN
                Cust.RESET;
                Cust.SETRANGE(Cust."ID No.","ID No.");
                Cust.SETRANGE(Cust."Customer Type",Cust."Customer Type"::Member);
                IF Cust.FIND('-') THEN BEGIN
                IF Cust."No." <> "No." THEN
                   ERROR('ID No. already exists');
                END;
                END;*/

            end;
        }
        field(50053; "Mobile Phone No"; Code[30])
        {
        }
        field(50204; "Group Mobile Phone No"; code[30])
        {

        }
        field(50054; "Marital Status"; enum "Marital Status")
        {

        }
        field(50055; Signature; MediaSet)
        {
            Caption = 'Signature';
        }
        field(50056; "Passport No."; Code[10])
        {
        }
        field(50057; Genderr; Option)
        {
            OptionCaption = ' ,Male,Female';
            OptionMembers = " ",Male,Female;

            trigger OnValidate()
            begin
                /*Vend2.RESET;
                Vend2.SETRANGE(Vend2."Staff No","Payroll/Staff No");
                IF Vend2.FIND('-') THEN BEGIN
                REPEAT
                Vend2.Gender:=Gender;
                Vend2.MODIFY;
                UNTIL Vend2.NEXT = 0;
                END;
                 */

            end;
        }
        field(50058; "Withdrawal Date"; Date)
        {
        }
        field(50059; "Withdrawal Fee"; Decimal)
        {
            Editable = false;
            FieldClass = Normal;
        }
        field(50060; "Status - Withdrawal App."; Option)
        {
            CalcFormula = lookup("Membership Exist".Status where("Member No." = field("No.")));
            FieldClass = FlowField;
            OptionCaption = 'Open,Pending,Approved,Rejected';
            OptionMembers = Open,Pending,Approved,Rejected;

            trigger OnValidate()
            begin
                //"Approval Date":=TODAY;


                /*IF "Status - Withdrawal App." = "Status - Withdrawal App."::Approved THEN BEGIN
                TESTFIELD("Closure Remarks");
                
                CALCFIELDS("Outstanding Balance","Accrued Interest","Current Shares","Insurance Fund","FOSA Outstanding Balance",
                           "FOSA Oustanding Interest");
                
                CALCFIELDS("Outstanding Balance");
                IF ("Outstanding Balance"+"Accrued Interest"+"FOSA Outstanding Balance"+"FOSA Oustanding Interest") +
                   ("Current Shares"+"Insurance Fund") > 0 THEN
                IF CONFIRM('Member shares deposits and insurance fund not enough to clear loan. Do you wish to continue') = FALSE THEN
                ERROR('Approval terminated.');
                
                END; */

            end;
        }
        field(50061; "Withdrawal Application Date"; Date)
        {

            trigger OnValidate()
            begin
                if "Withdrawal Application Date" <> 0D then
                    "Withdrawal Date" := CalcDate('2M', "Withdrawal Application Date");

                GenSetUp.Get();
                "Withdrawal Fee" := GenSetUp."Withdrawal Fee";
                "Membership Status" := "Membership Status"::"Fully Exited";
                Blocked := Blocked::All;
            end;
        }
        field(50062; "Investment Monthly Cont"; Decimal)
        {
        }
        field(50063; "Investment Max Limit."; Decimal)
        {
        }
        field(50064; "Current Investment Total"; Decimal)
        {
            CalcFormula = sum("Detailed Cust. Ledg. Entry".Amount where("Customer No." = field("No."),
                                                                   "Transaction Type" = const("Loan Insurance Charged"),
                                                                   "Posting Date" = field("Date Filter"),
                                                                   "Document No." = field("Document No. Filter")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50065; "Document No. Filter"; Code[10])
        {
            FieldClass = FlowFilter;
        }
        field(50066; "Shares Retained"; Decimal)
        {
            //CalcFormula = - sum("Detailed Vendor Ledg. Entry".Amount where("Vendor No." = field("Share Capital No"), /*"Document No." = filter(<>'SHARCBBF310324'),*/
            // Reversed = filter(False), "Posting Date" = field("Date Filter")));
            CalcFormula = - sum("Detailed Cust. Ledg. Entry".Amount where("Customer No." = field("No."),
                                                                  "Transaction Type" = filter("Share Capital"), "Posting Date" = field("Date Filter")
                                                                  ));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50067; "Registration Fee Paid"; Decimal)
        {
            CalcFormula = - sum("Detailed Cust. Ledg. Entry".Amount where("Customer No." = field("No."), Reversed = filter(false),
                                                                           "Transaction Type" = const("Registration Fee")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50068; "Registration Fee"; Decimal)
        {
        }
        field(50069; "Society Code"; Code[10])
        {
        }
        field(50070; "Insurance Fund"; Decimal)
        {
            /*             CalcFormula = sum("Detailed Cust. Ledg. Entry".Amount where("Customer No." = field("No."),
                                                                               "Transaction Type" = filter(insuranc),
                                                                               "Posting Date" = field("Date Filter"),
                                                                               "Document No." = field("Document No. Filter")));
                        Editable = false;
                        FieldClass = FlowField; */
        }
        field(50071; "Monthly Contribution"; Decimal)
        {

            trigger OnValidate()
            begin


                "Previous Share Contribution" := xRec."Monthly Contribution";



                Advice := true;
                //"Advice Type":="Advice Type"::Adjustment;


                DataSheet.Init;
                DataSheet."PF/Staff No" := "Payroll No";
                DataSheet."Type of Deduction" := 'Shares/Deposits';
                DataSheet."Remark/LoanNO" := 'ADJ FORM';
                DataSheet.Name := Name;
                DataSheet."ID NO." := "ID No.";
                DataSheet."Amount ON" := "Monthly Contribution";
                DataSheet."REF." := '2026';
                DataSheet."New Balance" := "Current Shares" * -1;
                DataSheet.Date := Today;
                DataSheet."Amount OFF" := xRec."Monthly Contribution";
                DataSheet.Employer := "Employer Code";
                DataSheet."Transaction Type" := DataSheet."transaction type"::ADJUSTMENT;
                //DataSheet."Sort Code":=PTEN;
                DataSheet.Insert;

            end;
        }
        field(50072; "Investment B/F"; Decimal)
        {
        }
        field(50073; "Dividend Amount"; Decimal)
        {
            /*             CalcFormula = - sum("Detailed Cust. Ledg. Entry".Amount where("Customer No." = field("No."),
                                                                            "Transaction Type" = const(Dividend),
                                                                          "Posting Date" = field("Date Filter")));
                        FieldClass = FlowField; */
        }
        field(50074; "Name of Chief"; Text[500])
        {
        }
        field(50075; "Office Telephone No."; Code[50])
        {
        }
        field(50076; "Extension No."; Code[50])
        {
        }
        field(50077; "Welfare Contribution"; Decimal)
        {

            trigger OnValidate()
            begin
                //Advice:=TRUE;
            end;
        }
        field(50078; Advice; Boolean)
        {
        }
        field(50079; Province; Code[50])
        {
            Enabled = false;
        }
        field(50080; "Previous Share Contribution"; Decimal)
        {
        }
        field(50081; "Un-allocated Funds"; Decimal)
        {
            CalcFormula = - sum("Detailed Cust. Ledg. Entry".Amount where("Customer No." = field("No."),
                                                                               "Transaction Type" = const("Deposit Contribution"),
                                                                               "Posting Date" = field("Date Filter"),
                                                                               "Document No." = field("Document No. Filter")));//
            Editable = false;
            Caption = 'Coop Shares';
            FieldClass = FlowField;
        }
        field(50082; "Refund Request Amount"; Decimal)
        {
            Editable = false;
        }
        field(50083; "Refund Issued"; Boolean)
        {
            Editable = false;
        }
        field(50084; "Batch No."; Code[50])
        {
            Enabled = false;

            trigger OnValidate()
            begin


            end;
        }
        field(50085; "Current Status"; Option)
        {
            OptionMembers = Approved,Rejected;
        }
        field(50086; "Cheque No."; Code[20])
        {
        }
        field(50087; "Cheque Date"; Date)
        {
        }
        field(50088; "Accrued Interest"; Decimal)
        {
            CalcFormula = sum("Detailed Cust. Ledg. Entry".Amount where("Customer No." = field("No."),
                                                                  "Transaction Type" = filter("Deposit Contribution")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50089; "Defaulted Loans Recovered"; Boolean)
        {
        }
        field(50090; "Withdrawal Posted"; Boolean)
        {
        }
        field(50091; "Loan No. Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = "Loans Register"."Loan  No." where("Client Code" = field("No."));
        }
        field(50092; "Currect File Location"; Code[10])
        {
            CalcFormula = max("File Movement Tracker".Station where("Member No." = field("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50093; "Move To1"; Integer)
        {
            TableRelation = "Approvals Set Up".Stage where("Approval Type" = const("File Movement"));
        }
        field(50094; "File Movement Remarks"; Text[10])
        {
            Enabled = false;
        }
        field(50095; "Status Change Date"; Date)
        {
        }
        field(50096; "Last Payment Date"; Date)
        {

            FieldClass = FlowField;
            CalcFormula = max("Cust. Ledger Entry"."Posting Date" where("Customer No." = field("No.")));
        }
        field(50097; "Discounted Amount"; Decimal)
        {
        }
        field(50098; "Current Savings"; Decimal)
        {
            CalcFormula = sum("Detailed Cust. Ledg. Entry".Amount where("Customer No." = field("No."),
                                                                   "Transaction Type" = const("Deposit Contribution")));
            FieldClass = FlowField;
        }
        field(50099; "Payroll Updated"; Boolean)
        {
        }
        field(50100; "Last Marking Date"; Date)
        {
        }
        field(50101; "Dividends Capitalised %"; Decimal)
        {

            trigger OnValidate()
            begin
                /*IF ("Dividends Capitalised %" < 0) OR ("Dividends Capitalised %" > 100) THEN
                ERROR('Invalied Entry.');*/

            end;
        }
        field(50102; "FOSA Outstanding Balance"; Decimal)
        {
            /*             CalcFormula = sum("Detailed Cust. Ledg. Entry".Amount where("Customer No." = field("No."),
                                                                              "Transaction Type" = filter("Share Capital" | "Interest Paid" | "FOSA Shares")));
                        FieldClass = FlowField; */
        }
        field(50103; "FOSA Oustanding Interest"; Decimal)
        {
            CalcFormula = sum("Detailed Cust. Ledg. Entry".Amount where("Customer No." = field("No."),
                                                                  "Transaction Type" = filter("Deposit Contribution")));
            FieldClass = FlowField;
        }
        field(50104; "Formation/Province"; Code[1])
        {

            trigger OnValidate()
            begin
                /*Vend.RESET;
                Vend.SETRANGE(Vend."Staff No","Payroll/Staff No");
                IF Vend.FIND('-') THEN BEGIN
                REPEAT
                Vend."Formation/Province":="Formation/Province";
                Vend.MODIFY;
                UNTIL Vend.NEXT=0;
                END;*/

            end;
        }
        field(50105; "Division/Department"; Code[1])
        {
            TableRelation = "Member Departments"."No.";
        }
        field(50106; "Station/Section"; Code[1])
        {
            //   TableRelation = Table51516159.Field1;
        }
        field(50107; "Closing Deposit Balance"; Decimal)
        {
        }
        field(50108; "Closing Loan Balance"; Decimal)
        {
        }
        field(50109; "Closing Insurance Balance"; Decimal)
        {
        }
        field(50110; "Dividend Progression"; Decimal)
        {
        }
        field(50111; "Closing Date"; Date)
        {
            CalcFormula = max("Cust. Ledger Entry"."Posting Date" where("Customer No." = field("No.")));
            FieldClass = FlowField;
        }
        field(50112; "Welfare Fund"; Decimal)
        {
            Editable = false;
            FieldClass = Normal;
        }
        field(50113; "Discounted Dividends"; Decimal)
        {
        }
        field(50114; "Mode of Dividend Payment"; Option)
        {
            OptionCaption = ' ,FOSA,EFT,Cheque,Defaulted Loan (Capitalised)';
            OptionMembers = " ",FOSA,EFT,Cheque,"Defaulted Loan";
        }
        field(50115; "Qualifying Shares"; Decimal)
        {
        }
        field(50116; "Defaulter Overide Reasons"; Text[1])
        {
        }
        field(50117; "Defaulter Overide"; Boolean)
        {

            trigger OnValidate()
            begin


            end;
        }
        field(50118; "Closure Remarks"; Text[10])
        {
        }
        field(50119; "Bank Account No."; Code[15])
        {
        }
        field(50120; "Bank Code"; Code[10])
        {
            TableRelation = "Banks Ver2";
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                BanksVer2.Reset;
                BanksVer2.SetRange(BanksVer2."Bank Code", "Bank Code");
                if BanksVer2.FindFirst then begin
                    "Bank Name" := BanksVer2."Bank Name";
                end;
            end;
        }
        field(50121; "Dividend Processed"; Boolean)
        {
        }
        field(50122; "Dividend Error"; Boolean)
        {
        }
        field(50123; "Dividend Capitalized"; Decimal)
        {
        }
        field(50124; "Dividend Paid FOSA"; Decimal)
        {
        }
        field(50125; "Dividend Paid EFT"; Decimal)
        {
        }
        field(50126; "Dividend Withholding Tax"; Decimal)
        {
        }
        field(50127; "Loan Last Payment Date"; Date)
        {
            FieldClass = Normal;
        }
        field(50128; "Outstanding Interest"; Decimal)
        {
            CalcFormula = sum("Detailed Cust. Ledg. Entry".Amount where("Customer No." = field("No."),
                                                                          "Transaction Type" = filter("Interest Paid" | "Interest Due")));
            FieldClass = FlowField;
        }
        field(50129; "Last Transaction Date"; Date)
        {
            FieldClass = Normal;
        }
        field(50130; "Account Category"; Enum AccountCategoryEnum)
        {

        }
        field(50205; "Group Category"; Option)
        {
            OptionMembers = "Co-operate",Chamaa;
            OptionCaption = 'Co-operate,Chamaa';
        }
        field(50131; "Type Of Organisation"; Option)
        {
            OptionCaption = ' ,Club,Association,Partnership,Investment,Merry go round,Other,Group';
            OptionMembers = " ",Club,Association,Partnership,Investment,"Merry go round",Other,Group;
        }
        field(50132; "Source Of Funds"; Option)
        {
            OptionCaption = ' ,Business Receipts,Income from Investment,Salary,Other';
            OptionMembers = " ","Business Receipts","Income from Investment",Salary,Other;
        }
        field(50133; "MPESA Mobile No"; Code[15])
        {
        }
        field(50134; "Force No."; Code[10])
        {
            Enabled = false;
        }
        field(50135; "Last Advice Date"; Date)
        {
        }
        field(50136; "Advice Type"; Option)
        {
            OptionMembers = " ","New Member","Shares Adjustment","ABF Adjustment","Registration Fees",Withdrawal,Reintroduction,"Reintroduction With Reg Fees";
        }
        field(50137; "Signing Instructions"; Option)
        {
            OptionCaption = 'Any to Sign,Two to Sign,Three to Sign,All to Sign';
            OptionMembers = "Any to Sign","Two to Sign","Three to Sign","All to Sign";
        }
        field(50138; "Share Balance BF"; Decimal)
        {
        }
        field(50139; "Move to"; Integer)
        {
            TableRelation = "Approvals Set Up".Stage where("Approval Type" = const("File Movement"));

            trigger OnValidate()
            begin
                Approvalsetup.Reset;
                Approvalsetup.SetRange(Approvalsetup.Stage, "Move to");
                if Approvalsetup.Find('-') then begin
                    "Move to description" := Approvalsetup.Station;
                end;
            end;
        }
        field(50140; "File Movement Remarks1"; Option)
        {
            OptionCaption = ' ,Reconciliation purposes,Auditing purposes,Refunds,Loan & Signatories,Withdrawal,Risks payment,Cheque Payment,Custody,Document Filing,Passbook,Complaint Letters,Defaulters,Dividends,Termination,New Members Details,New Members Verification';
            OptionMembers = " ","Reconciliation purposes","Auditing purposes",Refunds,"Loan & Signatories",Withdrawal,"Risks payment","Cheque Payment",Custody,"Document Filing",Passbook,"Complaint Letters",Defaulters,Dividends,Termination,"New Members Details","New Members Verification";
        }
        field(50141; "File MVT User ID"; Code[10])
        {
            Enabled = false;
        }
        field(50142; "File MVT Time"; Time)
        {
        }
        field(50143; "File Previous Location"; Code[10])
        {
            Enabled = false;
        }
        field(50144; "File MVT Date"; Date)
        {
        }
        field(50145; "file received date"; Date)
        {
        }
        field(50146; "File received Time"; Time)
        {
        }
        field(50147; "File Received by"; Code[40])
        {
            Enabled = false;
        }
        field(50148; "file Received"; Boolean)
        {
        }
        field(50149; User; Code[15])
        {
            TableRelation = "User Setup";
        }
        field(50150; "Change Log"; Integer)
        {
            CalcFormula = count("Change Log Entry" where("Primary Key Field 1 Value" = field("No.")));
            FieldClass = FlowField;
        }
        field(50151; Section; Code[10])
        {
            TableRelation = if (Section = const('')) "HR Leave Carry Allocation".Status;
        }
        field(50152; rejoined; Boolean)
        {
        }
        field(50153; "Job title"; Code[10])
        {
            Enabled = false;
        }
        field(50154; Pin; Code[100])
        {
        }
        field(50155; "Electral Zone"; Code[100])
        {
            TableRelation = "Member Delegate Zones".Code;
        }
        field(50156; "Remitance mode"; Option)
        {
            OptionCaption = ',Check off,Cash,Standing Order';
            OptionMembers = ,"Check off",Cash,"Standing Order";
        }
        field(50157; "Terms of Service"; Option)
        {
            OptionCaption = ',Permanent,Temporary,Contract';
            OptionMembers = ,Permanent,"Temporary",Contract;
        }
        field(50158; Comment1; Text[10])
        {
        }
        field(50159; Comment2; Text[10])
        {
            Enabled = false;
        }
        field(50160; "Current file location"; Code[10])
        {
            Enabled = false;
        }
        field(50161; "Work Province"; Code[10])
        {
            Enabled = false;
        }
        field(50162; "Work District"; Code[10])
        {
            Enabled = false;
        }
        field(50163; "Sacco Branch"; Code[10])
        {
        }
        field(50164; "Bank Branch Code"; Code[20])
        {
            TableRelation = "Banks Ver2"."Branch Code" where("Bank Code" = field("Bank Code"));

            trigger OnValidate()
            begin
                BanksVer2.Reset;
                BanksVer2.SetRange("Branch Code", "Bank Branch Code");
                BanksVer2.SetRange("Bank Code", "Bank Code");
                if BanksVer2.FindFirst then begin
                    "Bank Branch Name" := BanksVer2."Branch Name";
                end;
            end;
        }
        field(50165; "Customer Paypoint"; Code[10])
        {
            Enabled = false;
        }
        field(50166; "Date File Opened"; Date)
        {
        }
        field(50167; "File Status"; Code[10])
        {
            Enabled = false;
        }
        field(50168; "Customer Title"; Code[10])
        {
            Enabled = false;
        }
        field(50169; "Folio Number"; Code[10])
        {
            Enabled = false;
        }
        field(50170; "Move to description"; Text[20])
        {
            Enabled = false;
        }
        field(50171; Filelocc; Integer)
        {
            CalcFormula = max("File Movement Tracker"."Entry No." where("Member No." = field("No.")));
            FieldClass = FlowField;
        }
        field(50172; "S Card No."; Code[10])
        {
        }
        field(50173; "Reason for file overstay"; Text[10])
        {
            Enabled = false;
        }
        field(50174; "Loc Description"; Text[10])
        {
            Enabled = false;
        }
        field(50175; "Current Balance"; Decimal)
        {
        }
        field(50176; "Member Transfer Date"; Date)
        {
        }
        field(50177; "Contact Person"; Code[20])
        {
        }
        field(50178; "Member withdrawable Deposits"; Decimal)
        {
            // CalcFormula = sum("Detailed Cust. Ledg. Entry".Amount where("Customer No." = field("No."),
            //                                                       "Posting Date" = field("Date Filter"),
            //                                                       "Document No." = field("Document No. Filter"),
            //                                                       "Transaction Type" = const(depe)));
            // FieldClass = FlowField;
        }
        field(50179; "Current Location"; Text[10])
        {
            Enabled = false;
        }
        field(50180; "Group Code"; Code[10])
        {
            Enabled = false;
        }
        field(50181; "Xmas Contribution"; Decimal)
        {
            // CalcFormula = sum("Detailed Cust. Ledg. Entry".Amount where("Customer No." = field("No."),
            //                                                        "Transaction Type" = const("Silver Savings"),
            //                                                        "Posting Date" = field("Date Filter"),
            //                                                        "Document No." = field("Document No. Filter")));
            Editable = false;
            // FieldClass = FlowField;
        }
        field(50182; "Risk Fund"; Decimal)
        {
            /*             CalcFormula = sum("Detailed Cust. Ledg. Entry".Amount where("Customer No." = field("No."),
                                                                               "Transaction Type" = const("Benevolent Fund"),
                                                                               "Posting Date" = field("Date Filter"),
                                                                               "Document No." = field("Document No. Filter")));
                        Editable = false;
                        FieldClass = FlowField; */
        }
        field(50183; "Office Branch"; Code[2])
        {
        }
        field(50184; Department; Code[1])
        {
            TableRelation = "Member Departments"."No.";
        }
        field(50185; Occupation; Text[200])
        {
        }
        field(50186; Designation; Code[2048])
        {
            TableRelation = Designation.Designation;
        }
        field(50187; "Village/Residence"; Text[200])
        {
            TableRelation = "Approvals Set Up".Stage where("Approval Type" = const("File Movement"));
        }
        field(50188; "Contact Person Phone"; Code[20])
        {
        }
        field(50189; "Development Shares"; Decimal)
        {
            // CalcFormula = sum("Detailed Cust. Ledg. Entry".Amount where("Customer No." = field("No."),
            //                                                       "Transaction Type" = filter(),
            //                                                       "Posting Date" = field("Date Filter")));
            // FieldClass = FlowField;
        }
        field(50190; "Recruited By"; Code[40])
        {
        }
        field(50191; "ContactPerson Relation"; Code[15])
        {
            TableRelation = "Relationship Types";
        }
        field(50192; "ContactPerson Occupation"; Code[15])
        {
        }
        field(50193; "Insurance on Shares"; Decimal)
        {
        }
        field(50194; Disabled; Boolean)
        {
        }
        field(50195; "Mobile No. 2"; Code[15])
        {
        }
        field(50196; "Employer Name"; Code[100])
        {
        }
        field(50197; Title; Enum "TitleEnum")
        {
            DataClassification = ToBeClassified;
        }
        field(50198; Town; Code[15])
        {
            Editable = false;
            TableRelation = "Post Code".City;
        }
        field(50202; "Home Town"; Code[10])
        {
            Editable = false;
        }
        field(50206; "Loans Defaulter Status"; Option)
        {
            CalcFormula = lookup("Loans Register"."Loans Category-SASRA" where("Client Code" = field("No.")));
            FieldClass = FlowField;
            OptionCaption = 'Perfoming,Watch,Substandard,Doubtful,Loss';
            OptionMembers = Perfoming,Watch,Substandard,Doubtful,Loss;
        }
        field(50207; "Home Postal Code"; Code[10])
        {
            TableRelation = "Post Code".Code;
        }
        field(50208; "Total Loans Outstanding"; Decimal)
        {
            CalcFormula = sum("Detailed Cust. Ledg. Entry".Amount where("Customer No." = field("No."),
                                                                  "Transaction Type" = filter(Loan | Repayment)));
            FieldClass = FlowField;
        }
        field(50209; "No of Loans Guaranteed"; Integer)
        {
            CalcFormula = count("Loans Guarantee Details" where("Member No" = field("No."),
                                                                 "Outstanding Balance" = filter(<> 0),
                                                                 Substituted = const(false)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50210; "Member Can Guarantee  Loan"; Boolean)
        {
        }
        field(50211; "FOSA  Account Bal"; Decimal)
        {
            CalcFormula = - sum("Detailed Vendor Ledg. Entry".Amount where("Vendor No." = field("FOSA Account No."),
                                                                            Reversed = filter(false), "Posting Date" = field("Date Filter")));

            Editable = false;
            FieldClass = FlowField;
        }
        field(50212; "Rejoining Date"; Date)
        {
        }
        field(50213; "Active Loans Guarantor"; Integer)
        {
            CalcFormula = count("Loans Guarantee Details" where("Member No" = field("No."),
                                                                 "Outstanding Balance" = filter(> 0)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50214; "Loans Guaranteed"; Integer)
        {
            CalcFormula = count("Loans Guarantee Details" where("Substituted Guarantor" = field("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50215; "Member Deposit Mult 3"; Decimal)
        {
        }
        field(50216; "New loan Eligibility"; Decimal)
        {
        }
        field(50217; "Share Certificate No"; Integer)
        {
        }
        field(50218; "Last Share Certificate No"; Integer)
        {
            CalcFormula = max("Members Register"."Share Certificate No");
            FieldClass = FlowField;
        }
        field(50219; "No Of Days"; Integer)
        {
        }
        field(50220; "Application No."; Code[20])
        {
            CalcFormula = lookup("Members Register"."No." where("No." = field("No.")));
            Editable = true;
            FieldClass = FlowField;
            TableRelation = "Members Register"."No.";
        }
        field(50221; "Member Category"; Option)
        {
            OptionCaption = 'New Application,Account Reactivation,Transfer';
            OptionMembers = "New Application","Account Reactivation",Transfer;
        }
        field(50222; "Terms Of Employment"; Option)
        {
            OptionCaption = ' ,Permanent,Temporary,Contract,Private,Probation';
            OptionMembers = " ",Permanent,"Temporary",Contract,Private,Probation;
        }
        field(50223; "Nominee Envelope No."; Code[20])
        {
            Enabled = false;
        }
        field(50224; Defaulter; Boolean)
        {
        }
        field(50225; "Shares Variance"; Decimal)
        {
        }
        field(50226; "Net Dividend Payable"; Decimal)
        {
        }
        field(50227; "Tax on Dividend"; Decimal)
        {
        }
        field(50228; "Div Amount"; Decimal)
        {
        }
        field(50229; "Payroll Agency"; Code[10])
        {
            Enabled = false;
        }
        field(50230; "Introduced By"; Code[40])
        {
            Enabled = false;
        }
        field(50231; "Introducer Name"; Text[20])
        {
            Enabled = false;
        }
        field(50232; "Introducer Staff No"; Code[20])
        {
            Enabled = false;
        }
        field(50233; BoostedDate; Date)
        {
        }
        field(50234; BoostedAmount; Decimal)
        {
        }
        field(50235; "Bridge Amount Release"; Decimal)
        {
            CalcFormula = sum("Loan Offset Details"."Monthly Repayment" where("Client Code" = field("No.")));
            FieldClass = FlowField;
        }
        field(50236; "Repayment Method"; Option)
        {
            OptionCaption = ' ,Amortised,Reducing Balance,Straight Line,Constants,Ukulima Flat';
            OptionMembers = " ",Amortised,"Reducing Balance","Straight Line",Constants,"Ukulima Flat";
        }
        field(50237; Staff; Boolean)
        {
        }
        field(50238; "Death date"; Date)
        {
        }
        field(50239; "Edit Status"; Option)
        {
            OptionCaption = 'Open,Pending,Approved,Rejected';
            OptionMembers = Open,Pending,Approved,Rejected;
        }
        field(50240; "Deposit Boosted Date"; Date)
        {
        }
        field(50241; "Deposit Boosted Amount"; Decimal)
        {
        }
        field(50242; "Investment Account"; Decimal)
        {
            CalcFormula = sum("Detailed Cust. Ledg. Entry".Amount where("Customer No." = field("No."),
                                                                  "Posting Date" = field("Date Filter"),
                                                                  "Document No." = field("Document No. Filter"),
                                                                  "Transaction Type" = const("Loan Insurance Charged")));
            FieldClass = FlowField;
        }
        field(50243; "Mobile No 3"; Code[15])
        {
        }
        field(50244; "Share Capital B Class"; Decimal)
        {
            CalcFormula = sum("Detailed Cust. Ledg. Entry".Amount where("Customer No." = field("No."),
                                                                   "Posting Date" = field("Date Filter"),
                                                                   "Document No." = field("Document No. Filter"),
                                                                   "Transaction Type" = const("Share Capital")));
            FieldClass = FlowField;
        }
        field(50245; "Normal Shares B Class"; Decimal)
        {
            CalcFormula = sum("Detailed Cust. Ledg. Entry".Amount where("Customer No." = field("No."),
                                                                   "Posting Date" = field("Date Filter"),
                                                                   "Document No." = field("Document No. Filter"),
                                                                   "Transaction Type" = const("Share Capital")));
            FieldClass = FlowField;
        }
        field(50246; "FOSA Shares"; Decimal)
        {
            CalcFormula = sum("Detailed Vendor Ledg. Entry".Amount where("Vendor No." = field("FOSA Shares Account No"),
                                                                           "Posting Date" = field("Date Filter")));
            FieldClass = FlowField;
        }
        field(50247; "Members Parish"; Code[10])
        {
            Enabled = false;
            TableRelation = "Member's Parishes".Code;

            trigger OnValidate()
            begin
                Parishes.Reset;
                Parishes.SetRange(Parishes.Code, "Members Parish");
                if Parishes.Find('-') then begin
                    "Parish Name" := Parishes.Description;
                    "Member Share Class" := Parishes."Share Class";
                end;
            end;
        }
        field(50248; "Parish Name"; Text[20])
        {
            Enabled = false;
        }
        field(50249; "Occupation Details"; Option)
        {
            OptionCaption = ' ,Employed,Self-Employed,Contracting,Others,Employed & Self Employed';
            OptionMembers = " ",Employed,"Self-Employed",Contracting,Others,"Employed & Self Employed";
        }
        field(50250; "Contracting Details"; Text[20])
        {
        }
        field(50251; "Others Details"; Text[15])
        {
        }
        field(50252; Products; Option)
        {
            OptionCaption = 'BOSA Account,BOSA+Current Account,BOSA+Smart Saver,BOSA+Fixed Deposit,Smart Saver Only,Current Only,Fixed  Deposit Only,Fixed+Smart Saver,Fixed+Current,Current+Smart Saver';
            OptionMembers = "BOSA Account","BOSA+Current Account","BOSA+Smart Saver","BOSA+Fixed Deposit","Smart Saver Only","Current Only","Fixed  Deposit Only","Fixed+Smart Saver","Fixed+Current","Current+Smart Saver";
        }
        field(50253; "Joint Account Name"; Text[35])
        {
        }
        field(50254; "Postal Code 2"; Code[10])
        {
            TableRelation = "Post Code";
        }
        field(50255; "Town 2"; Code[20])
        {
        }
        field(50256; "Passport 2"; Code[20])
        {
        }
        field(50257; "Member Parish 2"; Code[1])
        {
            Enabled = false;
        }
        field(50258; "Member Parish Name 2"; Text[1])
        {
            Enabled = false;
        }
        field(50259; "Name of the Group/Corporate"; Text[30])
        {
        }
        field(50260; "Date of Registration"; Date)
        {
        }
        field(50261; "No of Members"; Integer)
        {
        }
        field(50262; "Group/Corporate Trade"; Code[20])
        {
        }
        field(50263; "Certificate No"; Code[25])
        {
        }
        field(50264; "ID No.2"; Code[15])
        {
        }
        field(50265; "Picture 2"; Blob)
        {
            Enabled = false;
            SubType = Bitmap;
        }
        field(50266; "Signature  2"; Blob)
        {
            Enabled = false;
            SubType = Bitmap;
        }
        field(50267; Title2; Option)
        {
            OptionCaption = ' ,Mr.,Mrs.,Miss.,DR.,Prof.,Fr.,Sr.,Bro.';
            OptionMembers = " ","Mr.","Mrs.","Miss.","DR.","Prof.","Fr.","Sr.","Bro.";
        }
        field(50268; "Mobile No. Three"; Code[15])
        {
        }
        field(50269; "Date of Birth2"; Date)
        {

            trigger OnValidate()
            begin
                if "Date of Birth" > Today then
                    Error('Date of birth cannot be greater than today');


                if "Date of Birth" <> 0D then begin
                    if GenSetUp.Get() then begin
                        if CalcDate(GenSetUp."Min. Member Age", "Date of Birth") > Today then
                            Error('Applicant bellow the mininmum membership age of %1', GenSetUp."Min. Member Age");
                    end;
                end;
            end;
        }
        field(50270; "Marital Status2"; Option)
        {
            OptionMembers = " ",Single,Married,Devorced,Widower,Widow;
        }
        field(50271; Gender2; Option)
        {
            OptionCaption = ' ,Male,Female';
            OptionMembers = " ",Male,Female;
        }
        field(50272; "Address3-Joint"; Code[15])
        {
            Enabled = false;
        }
        field(50273; "Home Postal Code2"; Code[15])
        {
            TableRelation = "Post Code";

            trigger OnValidate()
            begin
                PostCode.Reset;
                PostCode.SetRange(PostCode.Code, "Home Postal Code");
                if PostCode.Find('-') then begin
                    "Home Town" := PostCode.City
                end;
            end;
        }
        field(50274; "Home Town2"; Text[15])
        {
        }
        field(50275; "Payroll/Staff No2"; Code[5])
        {
            Enabled = false;
        }
        field(50276; "Employer Code2"; Code[5])
        {
            TableRelation = "HR Asset Transfer Header";

            trigger OnValidate()
            begin
                Employer.Get("Employer Code");
                "Employer Name" := Employer."Employer Name";
            end;
        }
        field(50277; "Employer Name2"; Code[10])
        {
        }
        field(50278; "E-Mail (Personal3)"; Text[5])
        {
            Enabled = false;
        }
        field(50279; "Member Share Class"; Option)
        {
            OptionCaption = ' ,Class A,Class B';
            OptionMembers = " ","Class A","Class B";
        }
        field(50280; "Member's Residence"; Code[35])
        {
        }
        field(50281; "Postal Code 3"; Code[15])
        {
            Enabled = false;
            TableRelation = "Post Code";
        }
        field(50282; "Town 3"; Code[15])
        {
            Enabled = false;
        }
        field(50283; "Passport 3"; Code[15])
        {
            Enabled = false;
        }
        field(50284; "Member Parish 3"; Code[10])
        {
            Enabled = false;
        }
        field(50285; "Member Parish Name 3"; Text[10])
        {
            Enabled = false;
        }
        field(50286; "Picture 3"; Blob)
        {
            SubType = Bitmap;
        }
        field(50287; "Signature  3"; Blob)
        {
            SubType = Bitmap;
        }
        field(50288; Title3; Option)
        {
            OptionCaption = ' ,Mr.,Mrs.,Miss.,DR.,Prof.,Fr.,Sr.,Bro.';
            OptionMembers = " ","Mr.","Mrs.","Miss.","DR.","Prof.","Fr.","Sr.","Bro.";
        }
        field(50289; "Mobile No. 3-Joint"; Code[15])
        {
        }
        field(50290; "Date of Birth3"; Date)
        {

            trigger OnValidate()
            begin
                if "Date of Birth" > Today then
                    Error('Date of birth cannot be greater than today');


                if "Date of Birth" <> 0D then begin
                    if GenSetUp.Get() then begin
                        if CalcDate(GenSetUp."Min. Member Age", "Date of Birth") > Today then
                            Error('Applicant bellow the mininmum membership age of %1', GenSetUp."Min. Member Age");
                    end;
                end;
            end;
        }
        field(50291; "Marital Status3"; Option)
        {
            Enabled = false;
            OptionMembers = " ",Single,Married,Devorced,Widower,Widow;
        }
        field(50292; Gender3; Option)
        {
            Enabled = false;
            OptionCaption = ' ,Male,Female';
            OptionMembers = " ",Male,Female;
        }
        field(50293; Address3; Code[10])
        {
            Enabled = false;
        }
        field(50294; "Home Postal Code3"; Code[5])
        {
            Enabled = false;
            TableRelation = "Post Code";

            trigger OnValidate()
            begin
                PostCode.Reset;
                PostCode.SetRange(PostCode.Code, "Home Postal Code");
                if PostCode.Find('-') then begin
                    "Home Town" := PostCode.City
                end;
            end;
        }
        field(50295; "Home Town3"; Text[10])
        {
            Enabled = false;
        }
        field(50296; "Payroll/Staff No3"; Code[15])
        {
            Enabled = false;
        }
        field(50297; "Employer Code3"; Code[5])
        {
            Enabled = false;
            TableRelation = "HR Asset Transfer Header";

            trigger OnValidate()
            begin
                Employer.Get("Employer Code");
                "Employer Name" := Employer."Employer Name";
            end;
        }
        field(50298; "Employer Name3"; Code[5])
        {
            Enabled = false;
        }
        field(50299; "E-Mail (Personal2)"; Text[15])
        {
        }
        field(50300; "Name 3"; Code[20])
        {
        }
        field(50301; "ID No.3"; Code[10])
        {
        }
        field(50302; "Mobile No. 4"; Code[5])
        {
        }
        field(50303; Address4; Code[5])
        {
            Enabled = false;
        }
        field(50304; "Assigned System ID"; Code[15])
        {
            Enabled = false;
            TableRelation = User."User Name";
        }
        field(50305; "Risk Fund Arrears"; Decimal)
        {
            // CalcFormula = sum("Detailed Cust. Ledg. Entry".Amount where("Customer No." = field("No."),
            //                                                       "Transaction Type" = filter("45" | "44"),
            //                                                       "Posting Date" = field("Date Filter")));
            // FieldClass = FlowField;
        }
        field(50306; Password; Text[20])
        {
        }
        field(50307; "Pension No"; Code[15])
        {
        }
        field(50308; "Benevolent Fund"; Decimal)
        {
            /*             CalcFormula = - sum("Detailed Cust. Ledg. Entry".Amount where("Customer No." = field("No."),
                                                                              "Posting Date" = field("Date Filter"),
                                                                              "Transaction Type" = filter("Benevolent Fund")));
                        FieldClass = FlowField; */
        }
        field(50309; "Risk Fund Paid"; Decimal)
        {
            // CalcFormula = sum("Detailed Cust. Ledg. Entry".Amount where("Customer No." = field("No."),
            //                                                       "Transaction Type" = filter(),
            //                                                       "Posting Date" = field("Date Filter")));
            // FieldClass = FlowField;
        }
        field(50310; "BRID No"; Code[15])
        {
            Enabled = false;
        }
        field(50311; "Gross Dividend Amount Payable"; Decimal)
        {
        }
        field(50312; "Card No"; Code[15])
        {
        }
        field(50313; "Funeral Rider"; Decimal)
        {
            // CalcFormula = sum("Detailed Cust. Ledg. Entry".Amount where("Customer No." = field("No."),
            //                                                       "Transaction Type" = filter("48"),
            //                                                       "Posting Date" = field("Date Filter")));
            // FieldClass = FlowField;
        }
        field(50314; "Loan Liabilities"; Decimal)
        {
            CalcFormula = sum("Detailed Cust. Ledg. Entry".Amount where("Customer No." = field("No."),
                                                                  "Posting Date" = field("Date Filter"),
                                                                  "Transaction Type" = filter("Share Capital" | "Interest Paid" | "Deposit Contribution")));
            FieldClass = FlowField;
        }
        field(50315; "Last Deposit Contribution Date"; Date)
        {
            CalcFormula = max("Cust. Ledger Entry"."Posting Date" where("Customer No." = field("No."),
                                                                          "Transaction Type" = filter("Deposit Contribution"),
                                                                          Amount = filter(< 0)));
            FieldClass = FlowField;
        }
        field(50316; "Member House Group"; Code[15])
        {
            TableRelation = "Member House Groups"."Cell Group Code";

            trigger OnValidate()
            begin
                if ObjCellGroup.Get("Member House Group") then begin
                    "Member House Group Name" := ObjCellGroup."Cell Group Name";
                end;
                /*CellGroups.RESET;
                CellGroups.SETRANGE(CellGroups."Cell Group Code","Member Cell Group");
                IF CellGroups.FIND('-') THEN BEGIN
                "Member Cell Group Name":=CellGroups."Cell Group Name";
                END;*/

            end;
        }
        field(50317; "Member House Group Name"; Code[20])
        {
        }
        field(50318; "No Of Group Members."; Integer)
        {
        }
        field(50319; "Group Account Name"; Code[20])
        {
            Enabled = false;
        }
        field(50320; "Business Loan Officer"; Code[10])
        {
        }
        field(50321; "Group Account"; Boolean)
        {
        }
        field(50322; "FOSA Account"; Code[15])
        {
        }
        field(50323; "Micro Group Code"; Code[5])
        {
            Enabled = false;
        }
        field(50324; "Loan Officer Name"; Code[15])
        {
            Enabled = false;
        }
        field(50325; "BOSA Account No."; Code[15])
        {
        }
        field(50326; "Any Other Sacco"; Text[5])
        {
        }
        field(50327; "Member class"; Option)
        {
            OptionCaption = ',Plantinum A,Plantinum B,Diamond,Gold';
            OptionMembers = ,"Plantinum A","Plantinum B",Diamond,Gold;
        }
        field(50328; "Employment Terms"; Option)
        {
            OptionCaption = ' ,Permanent,Casual';
            OptionMembers = " ",Permanent,Casual;
        }
        field(50329; "Group Deposits"; Decimal)
        {
            CalcFormula = sum("Detailed Cust. Ledg. Entry".Amount where("Group Code" = field("No."),
                                                                   "Transaction Type" = filter("Deposit Contribution"),
                                                                   "Posting Date" = field("Date Filter")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50330; "Group Loan Balance"; Decimal)
        {
            CalcFormula = sum("Detailed Cust. Ledg. Entry".Amount where("Group Code" = field("No."),
                                                                  "Transaction Type" = filter(Loan | Repayment),
                                                                  "Posting Date" = field("Date Filter")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50331; "No of Group Members"; Integer)
        {
            Editable = false;
        }
        field(50332; "No of Active Group Members"; Integer)
        {
            Editable = false;
        }
        field(50333; "No of Dormant Group Members"; Integer)
        {
            Editable = false;
            FieldClass = Normal;
        }
        field(50334; "Pending Loan Application Amt"; Decimal)
        {
            CalcFormula = sum("Loans Register"."Requested Amount" where("Client Code" = field("No."),
                                                                          "Loan Status" = filter(Application | Appraisal)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50335; "Pending Loan Application No."; Code[30])
        {
            CalcFormula = lookup("Loans Register"."Loan  No." where("Client Code" = field("No."),
                                                                     "Loan Status" = filter(Application | Appraisal)));
            FieldClass = FlowField;
        }
        field(50336; "Member Of a Group"; Boolean)
        {
        }
        field(50337; TLoansGuaranteed; Decimal)
        {
            CalcFormula = sum("Loans Guarantee Details"."Amont Guaranteed" where("Member No" = field("No."),
                                                                                  "Outstanding Balance" = filter(> 0)));
            FieldClass = FlowField;
        }
        field(50338; "Total Committed Shares"; Decimal)
        {
            CalcFormula = sum("Loans Guarantee Details"."Amont Guaranteed" where("Member No" = field("No."),
                                                                                  "Outstanding Balance" = filter(> 0)));
            FieldClass = FlowField;
        }
        field(50339; "Existing Loan Repayments"; Decimal)
        {
            CalcFormula = sum("Loans Register".Repayment where("Client Code" = field("No."),
                                                                Posted = const(true),
                                                                "Outstanding Balance" = filter(> 0)));
            FieldClass = FlowField;
        }
        field(50340; "Existing Fosa Loan Repayments"; Decimal)
        {
            CalcFormula = sum("Loans Register".Repayment where("Client Code" = field("FOSA Account No.")));
            FieldClass = FlowField;
        }
        field(50341; "Employer Address"; Code[20])
        {
        }
        field(50342; "Date of Employment"; Date)
        {
        }
        field(50343; "Position Held"; Code[20])
        {
        }
        field(50344; "Expected Monthly Income"; Code[20])
        {
            TableRelation = "Expected Monthly TurnOver".Code;

            trigger OnValidate()
            begin
                ObjExpectedTurnOver.Reset;
                ObjExpectedTurnOver.SetRange(ObjExpectedTurnOver.Code, "Expected Monthly Income");
                if ObjExpectedTurnOver.FindSet then
                    "Expected Monthly Income Amount" := ObjExpectedTurnOver."Maximum Amount";
            end;
        }
        field(50345; "Nature Of Business"; Code[30])
        {
        }
        field(50346; Industry; Code[15])
        {
        }
        field(50347; "Business Name"; Code[30])
        {
        }
        field(50348; "Physical Business Location"; Code[25])
        {
        }
        field(50349; "Year of Commence"; Date)
        {
        }
        field(50350; "Identification Document"; Option)
        {
            OptionCaption = 'National_ID,Passport Card,Aliens Card,Birth Certificate,Company Reg. No,Driving License';
            OptionMembers = "National_ID","Passport Card","Aliens Card","Birth Certificate","Company Reg. No","Driving License";
        }
        field(50351; "Referee Member No"; Code[10])
        {
            TableRelation = Customer."No.";

            trigger OnValidate()
            begin
                if Cust.Get("Referee Member No") then begin
                    "Referee Name" := Cust.Name;
                    "Referee Mobile Phone No" := Cust."Mobile Phone No";
                    "Referee ID No" := Cust."ID No.";
                end;
            end;
        }
        field(50352; "Referee Name"; Code[40])
        {
            Editable = false;
        }
        field(50353; "Referee ID No"; Code[20])
        {
            Editable = false;
        }
        field(50354; "Referee Mobile Phone No"; Code[15])
        {
            Editable = false;
        }
        field(50355; "Email Indemnified"; Boolean)
        {
        }
        field(50356; "Send E-Statements"; Boolean)
        {
        }
        field(50357; "Reason For Membership Withdraw"; Option)
        {
            OptionCaption = 'Relocation,Financial Constraints,House/Group Challages,Join another Institution,Personal Reasons,Other';
            OptionMembers = Relocation,"Financial Constraints","House/Group Challages","Join another Institution","Personal Reasons",Other;
        }
        field(50358; "Action On Dividend Earned"; Option)
        {
            OptionCaption = 'Pay to FOSA Account,Capitalize On Deposits,Repay Loans';
            OptionMembers = "Pay to FOSA Account","Capitalize On Deposits","Repay Loans";
        }
        field(50359; "Deposits Account No"; Code[15])
        {
            FieldClass = FlowField;
            CalcFormula = lookup(Vendor."No." where("BOSA Account No" = field("No."), "Account Type" = filter('003')));
        }
        field(50360; "Share Capital No"; Code[15])
        {
            FieldClass = FlowField;
            CalcFormula = lookup(Vendor."No." where("BOSA Account No" = field("No."), "Account Type" = filter('002')));
        }
        field(50361; "Benevolent Fund No"; Code[15])
        {
        }
        field(50362; "Loans Recoverd from Guarantors"; Decimal)
        {
            CalcFormula = sum("Detailed Cust. Ledg. Entry".Amount where("Customer No." = field("No."),
                                                                   "Recovery Transaction Type" = filter("Guarantor Recoverd"),
                                                                   "Document No." = field("Document No. Filter"),
                                                                   "Posting Date" = field("Date Filter")));
            FieldClass = FlowField;
        }
        field(50363; "Loan Recovered From Guarantors"; Code[20])
        {
            CalcFormula = lookup("Cust. Ledger Entry"."Recoverd Loan" where("Customer No." = field("No.")));
            FieldClass = FlowField;
        }
        field(50364; "ID Date of Issue"; Date)
        {
        }
        field(50365; "Literacy Level"; Text[25])
        {
        }
        field(50366; "Created By"; Code[200])
        {
        }
        field(50367; "Modified By"; Code[48])
        {
        }
        field(50368; "Modified On"; Date)
        {
        }
        field(50369; "Approved By"; Code[48])
        {
        }
        field(50370; "Approved On"; Date)
        {
        }
        field(50371; "Additional Shares"; Decimal)
        {
            CalcFormula = sum("Detailed Vendor Ledg. Entry".Amount where("Vendor No." = field("Additional Shares Account No"),
                                                                           "Posting Date" = field("Date Filter")));
            FieldClass = FlowField;
        }
        field(50372; "FOSA Shares Account No"; Code[15])
        {
        }
        field(50373; "Additional Shares Account No"; Code[15])
        {
        }
        field(50374; "No of House Group Changes"; Integer)
        {
            CalcFormula = count("House Group Change Request" where("Member No" = field("No."),
                                                                    "Change Effected" = filter(true)));
            FieldClass = FlowField;
        }
        field(50375; "Last Contribution Entry No"; Integer)
        {
            CalcFormula = max("Cust. Ledger Entry"."Entry No." where("Customer No." = field("No."),
                                                                       "Transaction Type" = filter("Deposit Contribution"),
                                                                       Amount = filter(< 0)));
            FieldClass = FlowField;
        }
        field(50376; "House Group Status"; Option)
        {
            OptionCaption = 'Active,Exiting the Group';
            OptionMembers = Active,"Exiting the Group";
        }
        field(50377; "Member Residency Status"; Text[20])
        {
            Description = 'What is the customer''s residency status?';
            TableRelation = "Customer Risk Rating"."Sub Category" where(Category = filter("Residency Status"));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(50378; "Individual Category"; Text[40])
        {
            Description = 'What is the customer category?';
            TableRelation = "Customer Risk Rating"."Sub Category" where(Category = filter(Individuals));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(50379; Entities; Text[35])
        {
            Description = 'What is the Entity Type?';
            TableRelation = "Customer Risk Rating"."Sub Category" where(Category = filter(Entities));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(50380; "Industry Type"; Text[40])
        {
            Description = 'What Is the Industry Type?';
            TableRelation = "Customer Risk Rating"."Sub Category" where(Category = filter(Industry));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(50381; "Length Of Relationship"; Text[35])
        {
            Description = 'What Is the Lenght Of the Relationship';
            TableRelation = "Customer Risk Rating"."Sub Category" where(Category = filter("Length Of Relationship"));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(50382; "International Trade"; Text[35])
        {
            Description = 'Is the customer involved in International Trade?';
            TableRelation = "Customer Risk Rating"."Sub Category" where(Category = filter("International Trade"));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(50383; "Electronic Payment"; Text[20])
        {
            Description = 'Does the customer engage in electronic payments?';
            TableRelation = "Product Risk Rating"."Product Type Code" where("Product Category" = filter("Electronic Payment"));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(50384; "Accounts Type Taken"; Text[40])
        {
            Description = 'Which account type is the customer taking?';
            TableRelation = "Product Risk Rating"."Product Type Code" where("Product Category" = filter(Accounts));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(50385; "Cards Type Taken"; Text[15])
        {
            Description = 'Which card is the customer taking?';
            TableRelation = "Product Risk Rating"."Product Type Code" where("Product Category" = filter(Cards));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(50386; "Others(Channels)"; Text[40])
        {
            Description = 'Which products or channels is the customer taking?';
            TableRelation = "Product Risk Rating"."Product Type Code" where("Product Category" = filter(Others));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(50387; "No of BD Trainings Attended"; Integer)
        {
            CalcFormula = count("CRM Traineees" where("Member No" = field("No."),
                                                       Attended = filter(true)));
            FieldClass = FlowField;
        }
        field(50388; "Member Needs House Group"; Boolean)
        {
        }
        field(50389; "Exit Application Done By"; Code[40])
        {
        }
        field(50390; "Exit Application Done On"; Date)
        {
        }
        field(50391; "Member Risk Level"; Option)
        {
            OptionCaption = 'Low Risk,Medium Risk,High Risk';
            OptionMembers = "Low Risk","Medium Risk","High Risk";
        }
        field(50392; "Due Diligence Measure"; Text[40])
        {
        }
        field(50393; "Monthly TurnOver_Actual"; Decimal)
        {
        }
        field(50394; "Password Reset Date"; DateTime)
        {
        }
        field(50395; "FOSA Shares Status"; Option)
        {
            CalcFormula = lookup(Vendor.Status where("No." = field("FOSA Shares Account No")));
            FieldClass = FlowField;
            OptionCaption = 'Active,Closed,Dormant,Frozen,Deceased';
            OptionMembers = Active,Closed,Dormant,Frozen,Deceased;
        }
        field(50396; "Share Capital Status"; Option)
        {
            CalcFormula = lookup(Vendor.Status where("No." = field("Share Capital No")));
            FieldClass = FlowField;
            OptionMembers = Active,Closed,Dormant,Frozen,Deceased;
        }
        field(50397; "Deposits Account Status"; Option)
        {
            CalcFormula = lookup(Vendor.Status where("No." = field("Deposits Account No")));
            FieldClass = FlowField;
            OptionCaption = 'Active,Closed,Dormant,Frozen,Deceased';
            OptionMembers = Active,Closed,Dormant,Frozen,Deceased;
        }
        field(50398; "Previous Status"; Option)
        {
            OptionCaption = 'Active,Awaiting Exit,Exited,Dormant,Deceased';
            OptionMembers = Active,"Awaiting Exit",Exited,Dormant,Deceased;

            trigger OnValidate()
            begin
                //Advice:=TRUE;
                //"Status Change Date" := TODAY;
                //"Last Marking Date" := TODAY;
                //MODIFY;
                /*
                IF xRec.Status=xRec.Status::Deceased THEN
                ERROR('Deceased status cannot be changed');
                
                Vend2.RESET;
                Vend2.SETRANGE(Vend2."Staff No","Payroll/Staff No");
                Vend2.SETRANGE(Vend2."Account Type",'PRIME');
                IF Vend2.FIND('-') THEN BEGIN
                REPEAT
                IF Status = Status::Deceased THEN BEGIN
                IF (Vend2."Account Type"<>'JUNIOR') THEN BEGIN
                Vend2.Status:=Vend2.Status::"6";
                Vend2.Blocked:=Vend2.Blocked::All;
                Vend2.MODIFY;
                END;
                END;
                UNTIL Vend2.NEXT = 0;
                END;
                
                //Charge Entrance fee on reinstament
                IF Status=Status::"Re-instated" THEN BEGIN
                GenSetUp.GET(0);
                "Registration Fee":=GenSetUp."Registration Fee";
                MODIFY;
                END;
                
                IF (Status<>Status::Active) OR (Status<>Status::Dormant) THEN
                Blocked:=Blocked::All;
                 */

            end;
        }
        field(50399; "Status Changed On"; Date)
        {
        }
        field(50400; "Status Changed By"; Code[40])
        {
        }
        field(50401; Agee; Integer)
        {
        }
        field(50402; "No of Next of Kin"; Integer)
        {
            CalcFormula = count("Members Next of Kin" where("Account No" = field("No.")));
            FieldClass = FlowField;
        }
        field(50403; "Insider Status"; Option)
        {
            OptionCaption = ' ,Board Member,Staff Member,Delegate Member,Regular Member';
            OptionMembers = " ","Board Member","Staff Member","Delegate Member","Regular Member";

            trigger OnValidate()
            begin
                ObjLoans.Reset;
                ObjLoans.SetRange(ObjLoans."Client Code", "No.");
                ObjLoans.SetFilter(ObjLoans."Loan Status", '<>%1', ObjLoans."loan status"::Closed);
                if ObjLoans.FindSet then begin
                    repeat
                        ObjLoans."Insider Status" := "Insider Status";
                        ObjLoans.Modify
                    until ObjLoans.Next = 0;
                end;
            end;
        }
        field(50404; Dormancy; Boolean)
        {
            CalcFormula = exist("Detailed Vendor Ledg. Entry" where("Member No" = field("No."),
                                                                     "Posting Date" = field("Date Filter")));
            FieldClass = FlowField;
        }
        field(50405; "OTP Code"; Code[5])
        {
        }
        field(50406; "Total BOSA Loan Balance"; Decimal)
        {
            CalcFormula = sum("Detailed Cust. Ledg. Entry".Amount where("Customer No." = field("No."),
                                                                  "Transaction Type" = filter(Loan | Repayment),
                                                                  "Loan Type" = filter('301' | '302' | '303' | '306' | '322')));
            FieldClass = FlowField;
        }
        field(50407; "Benevolent Fund Historical"; Decimal)
        {
            CalcFormula = sum("Member Historical Ledger Entry"."Credit Amount" where("Account No." = field("Benevolent Fund No"),
                                                                                      "Posting Date" = field("Date Filter")));
            FieldClass = FlowField;
        }
        field(50408; "Deposits Contributed"; Decimal)
        {
            CalcFormula = sum("Detailed Vendor Ledg. Entry"."Credit Amount" where("Vendor No." = field("Deposits Account No"),
                                                                                   "Posting Date" = field("Date Filter"),
                                                                                   "Document No." = filter(<> 'BALB/F9THNOV2018')));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50409; "Deposit Contributed Historical"; Decimal)
        {
            CalcFormula = sum("Member Historical Ledger Entry"."Credit Amount" where("Account No." = field("Deposits Account No"),
                                                                                      "Posting Date" = field("Date Filter")));
            FieldClass = FlowField;
        }
        field(50410; "Deposits Penalty Exists"; Boolean)
        {
            CalcFormula = exist("Deposit Arrears Penalty Buffer" where(Settled = filter(false),
                                                                        "Member No" = field("No.")));
            FieldClass = FlowField;
        }
        field(50411; "LSA Account No"; Code[20])
        {
            CalcFormula = lookup(Vendor."No." where("BOSA Account No" = field("No."),
                                                     Status = filter(<> Closed | Deceased),
                                                     "Account Type" = filter(507)));
            FieldClass = FlowField;
        }
        field(50412; "Block Mobile Loan"; Boolean)
        {
        }
        field(50413; "Member Deposits"; Decimal)
        {
            CalcFormula = sum("Detailed Vendor Ledg. Entry".Amount where("Vendor No." = field("Deposits Account No")));
            FieldClass = FlowField;
        }
        field(50414; "Deposit Multiplier"; Integer)
        {
            CalcFormula = max("Product Deposit>Loan Analysis"."Deposit Multiplier" where("Product Code" = filter('301'),
                                                                                          "Minimum Deposit" = field(upperlimit("Current Shares")),
                                                                                          "Minimum Share Capital" = field(upperlimit("Shares Retained"))));
            FieldClass = FlowField;
        }
        field(50415; "Computer Name"; Text[10])
        {
        }
        field(50416; "Online Member"; Boolean)
        {
        }
        field(50417; "KYC Completed"; Boolean)
        {
        }
        field(50418; "Expected Monthly Income Amount"; Decimal)
        {
        }
        field(50419; "Block Normal Loan"; Boolean)
        {
        }
        field(50420; "Additional Shares Status"; Option)
        {
            CalcFormula = lookup(Vendor.Status where("No." = field("Additional Shares Account No")));
            FieldClass = FlowField;
            OptionCaption = 'Active,Closed,Dormant,Frozen,Deceased';
            OptionMembers = Active,Closed,Dormant,Frozen,Deceased;
        }
        field(50421; PictureEmpty; Boolean)
        {
        }
        field(50422; SignatureEmpty; Boolean)
        {
        }
        field(50423; "First Name"; Code[200])
        {
        }
        field(50424; "Middle Name"; Code[200])
        {

            trigger OnValidate()
            begin
                /*FnRunCheckApplicantAgainstSactions("First Name","Middle Name","Last Name");
                FnRunCheckApplicantAgainstPEPs("First Name","Middle Name","Last Name");
                */

            end;
        }
        field(50425; "Last Name"; Code[200])
        {

            trigger OnValidate()
            begin
                /*FnRunCheckApplicantAgainstSactions("First Name","Middle Name","Last Name");
                FnRunCheckApplicantAgainstPEPs("First Name","Middle Name","Last Name");*/

            end;
        }
        field(50426; "Referee Risk Rate"; Text[30])
        {
        }
        field(50427; "Has ATM Card"; Boolean)
        {
            CalcFormula = exist("ATM Card Nos Buffer" where("ID No" = field("ID No.")));
            FieldClass = FlowField;
        }
        field(50428; "Is Mobile Registered"; Boolean)
        {
        }
        field(50429; "Referee Commission Paid"; Boolean)
        {
        }
        field(50430; "Deposits Contributed Ver1"; Decimal)
        {
            CalcFormula = sum("Detailed Vendor Ledg. Entry".Amount where("Vendor No." = field("Deposits Account No"),
                                                                          "Posting Date" = field("Date Filter")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50431; "Member Last Transaction Date"; Date)
        {
            CalcFormula = max("Detailed Cust. Ledg. Entry"."Posting Date" where("Customer No." = field("No."), "Transaction Type" = filter("Deposit Contribution")));
            FieldClass = FlowField;
        }
        field(50432; "Dormant Date"; Date)
        {
        }
        field(50433; "Last Transaction Date VerII"; Date)
        {
        }
        field(50434; "Member Credit Score"; Decimal)
        {
        }
        field(50435; "Member Credit Score Desc."; Text[5])
        {
        }
        field(50436; "Member Payment Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Checkoff,Standing Order';
            OptionMembers = " ",Checkoff,"Standing Order";
        }
        field(50437; "Standing Order No"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50438; "Bank Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50439; "Has Silver Deposit"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50440; "Silver Account No"; Code[1])
        {
            DataClassification = ToBeClassified;
        }
        field(50441; "Bank Branch Name"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50442; "Junior Savings"; Decimal)
        {
            // CalcFormula = sum("Detailed Cust. Ledg. Entry".Amount where("Customer No." = field("No."),
            //                                                        "Transaction Type" = const("Junior Savings"),
            //                                                        "Posting Date" = field("Date Filter")));
            Editable = false;
            // FieldClass = FlowField;
        }
        field(50443; "Safari Savings"; Decimal)
        {
            // CalcFormula = sum("Detailed Cust. Ledg. Entry".Amount where("Customer No." = field("No."),
            //                                                        "Transaction Type" = const("Safari Savings"),
            //                                                        "Posting Date" = field("Date Filter")));
            Editable = false;
            // FieldClass = FlowField;
        }
        field(50444; "Silver Savings"; Decimal)
        {
            // CalcFormula = sum("Detailed Cust. Ledg. Entry".Amount where("Customer No." = field("No."),
            //                                                        "Transaction Type" = const("Silver Savings"),
            //                                                        "Posting Date" = field("Date Filter")));
            Editable = false;
            // FieldClass = FlowField;
        }
        field(50445; "Development Loan"; Decimal)
        {
            CalcFormula = sum("Detailed Cust. Ledg. Entry".Amount where("Customer No." = field("No."),
            Reversed = filter(false),
                                                                  "Loan Type" = const('DL'),
                                                                  "Posting Date" = field("Date Filter"),
                                                                  "Transaction Type" = filter(Loan | Repayment)));
            FieldClass = FlowField;
        }
        field(50446; "Emergency Loan"; Decimal)
        {
            CalcFormula = sum("Detailed Cust. Ledg. Entry".Amount where("Customer No." = field("No."),
                                                                  "Loan Type" = const('EL'),
                                                                  "Posting Date" = field("Date Filter"),
                                                                  "Transaction Type" = filter(Loan | Repayment)));
            FieldClass = FlowField;
        }
        field(50447; "Instant Loan"; Decimal)
        {
            CalcFormula = sum("Detailed Cust. Ledg. Entry".Amount where("Customer No." = field("No."),
                                                                  "Loan Type" = const('IL'),
                                                                  "Posting Date" = field("Date Filter"),
                                                                  "Transaction Type" = filter(Loan | Repayment)));
            FieldClass = FlowField;
        }
        field(50448; "Maono Shamba Loan"; Decimal)
        {
            CalcFormula = sum("Detailed Cust. Ledg. Entry".Amount where("Customer No." = field("No."),
                                                                  "Loan Type" = const('MSL'),
                                                                  "Posting Date" = field("Date Filter"),
                                                                  "Transaction Type" = filter(Loan | Repayment)));
            FieldClass = FlowField;
        }
        field(50449; "School Fees Loan"; Decimal)
        {
            CalcFormula = sum("Detailed Cust. Ledg. Entry".Amount where("Customer No." = field("No."),
                                                                  "Loan Type" = const('SL'),
                                                                  "Posting Date" = field("Date Filter"),
                                                                  "Transaction Type" = filter(Loan | Repayment)));
            FieldClass = FlowField;
        }
        field(50450; "Super Plus Loan"; Decimal)
        {
            CalcFormula = sum("Detailed Cust. Ledg. Entry".Amount where("Customer No." = field("No."),
                                                                  "Loan Type" = const('SPL'),
                                                                  "Posting Date" = field("Date Filter"),
                                                                  "Transaction Type" = filter(Loan | Repayment)));
            FieldClass = FlowField;
        }
        field(50451; "Super School Fees Laon"; Decimal)
        {
            CalcFormula = sum("Detailed Cust. Ledg. Entry".Amount where("Customer No." = field("No."),
                                                                  "Loan Type" = const('SSL'),
                                                                  "Posting Date" = field("Date Filter"),
                                                                  "Transaction Type" = filter(Loan | Repayment)));
            FieldClass = FlowField;
        }
        field(50452; "Top Loan"; Decimal)
        {
            CalcFormula = sum("Detailed Cust. Ledg. Entry".Amount where("Customer No." = field("No."),
                                                                  "Loan Type" = const('TL'),
                                                                  "Posting Date" = field("Date Filter"),
                                                                  "Transaction Type" = filter(Loan | Repayment)));
            FieldClass = FlowField;
        }
        field(50453; "Top Loan 1"; Decimal)
        {
            CalcFormula = sum("Detailed Cust. Ledg. Entry".Amount where("Customer No." = field("No."),
                                                                  "Loan Type" = const('TL1'),
                                                                  "Posting Date" = field("Date Filter"),
                                                                  "Transaction Type" = filter(Loan | Repayment)));
            FieldClass = FlowField;
        }
        field(50454; "Vs Member Loan"; Decimal)
        {
            CalcFormula = sum("Detailed Cust. Ledg. Entry".Amount where("Customer No." = field("No."),
                                                                  "Loan Type" = const('VS-MEMBER'),
                                                                  "Posting Date" = field("Date Filter"),
                                                                  "Transaction Type" = filter(Loan | Repayment)));
            FieldClass = FlowField;
        }
        field(50455; "Group Account No"; Code[20])
        {

        }
        field(50456; Piccture; MediaSet)
        {

        }
        field(50457; "Group ID No"; Code[20])
        {

        }
        field(50458; "No of PF Nos"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count(Customer where("Payroll No" = field("Payroll No"), Status = filter(<> Closed)));
        }
        field(50459; "No of ID Nos"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count(Customer where("ID No." = field("ID No."), Status = filter(<> Closed)));
        }
        field(50460; "Rejoined By"; Code[20])
        {

        }
        field(50461; "Internet Banking"; Boolean)
        {
        }
        field(50462; "Mobile Banking"; Boolean)
        {
        }
        field(50463; "Mobile Banking Status"; Boolean)
        {
        }
        field(50464; "Mobile Banking Registered"; Boolean)
        {
        }
        field(50465; "Mobile Banking Applicant"; Boolean)
        {
        }
        field(50467; "Old Account No"; Code[150])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50468; "Old Accounts No"; Code[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50469; "Dependant Savings 1"; Decimal)
        {
            /*             CalcFormula = - sum("Detailed Cust. Ledg. Entry".Amount where("Customer No." = field("No."),
                                                                              "Transaction Type" = filter("Dependant 1 Savings"), "Posting Date" = field("Date Filter")
                                                                              ));
                        FieldClass = FlowField; */
        }
        field(50470; "Dependant Savings 2"; Decimal)
        {
            /*             CalcFormula = - sum("Detailed Cust. Ledg. Entry".Amount where("Customer No." = field("No."),
                                                                              "Transaction Type" = filter("Dependant 2 Savings"), "Posting Date" = field("Date Filter")
                                                                              ));
                        FieldClass = FlowField; */
        }
        field(50471; "Dependant Savings 3"; Decimal)
        {
            /*   CalcFormula = - sum("Detailed Cust. Ledg. Entry".Amount where("Customer No." = field("No."),
                                                                    "Transaction Type" = filter("Dependant 3 Savings"), "Posting Date" = field("Date Filter")
                                                                    ));
              FieldClass = FlowField; */
        }
        field(50472; "Interest On Deposits"; Decimal)
        {
            CalcFormula = - sum("Detailed Cust. Ledg. Entry".Amount where("Customer No." = field("No."),
                                                                  "Transaction Type" = filter("Interest on Deposits"), "Posting Date" = field("Date Filter")
                                                                  ));
            FieldClass = FlowField;
        }
        field(50473; "Share Boost Fee"; Decimal)
        {
            /*             CalcFormula = - sum("Detailed Cust. Ledg. Entry".Amount where("Customer No." = field("No."),
                                                                              "Transaction Type" = filter("Share Boost Fee"), "Posting Date" = field("Date Filter")
                                                                              ));
                        FieldClass = FlowField; */
        }
        field(50474; "Rejoining Fee"; Decimal)
        {
            /*             CalcFormula = - sum("Detailed Cust. Ledg. Entry".Amount where("Customer No." = field("No."),
                                                                              "Transaction Type" = filter("Rejoining Fee"), "Posting Date" = field("Date Filter")
                                                                              ));
                        FieldClass = FlowField; */
        }
        field(50475; "Dormant Reactivation Fee"; Decimal)
        {
            /*             CalcFormula = - sum("Detailed Cust. Ledg. Entry".Amount where("Customer No." = field("No."),
                                                                              "Transaction Type" = filter("Dormant Reactivation Fee"), "Posting Date" = field("Date Filter")
                                                                              ));
                        FieldClass = FlowField; */
        }
        field(50476; "HouseHold Savings"; Decimal)
        {
            /*             CalcFormula = - sum("Detailed Cust. Ledg. Entry".Amount where("Customer No." = field("No."),
                                                                              "Transaction Type" = filter("HouseHold Savings"), "Posting Date" = field("Date Filter")
                                                                              ));
                        FieldClass = FlowField; */
        }
        field(50477; "Holiday Savings"; Decimal)
        {
            /*             CalcFormula = - sum("Detailed Cust. Ledg. Entry".Amount where("Customer No." = field("No."),
                                                                              "Transaction Type" = filter("Holiday Savings"), "Posting Date" = field("Date Filter")
                                                                              ));
                        FieldClass = FlowField; */
        }
        field(50478; "Utafiti Housing"; Decimal)
        {
            /*             CalcFormula = - sum("Detailed Cust. Ledg. Entry".Amount where("Customer No." = field("No."),
                                                                              "Transaction Type" = filter("Utafiti Housing"), "Posting Date" = field("Date Filter")
                                                                              ));
                        FieldClass = FlowField; */
        }

        field(50479; "Station"; Code[100])
        {
            DataClassification = ToBeClassified;

        }

        field(50480; "Reffered By Member No"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = Customer where(ISNormalMember = const(true));
            trigger OnValidate()
            var
                Cust: Record Customer;
            begin
                Cust.Reset();
                Cust.SetRange(Cust."No.", "Reffered By Member No");
                if Cust.FindFirst() then begin
                    "Reffered By Member Name" := Cust.Name;
                end;
            end;
        }

        field(50481; "Reffered By Member Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }

        field(50482; "NHIF No"; Code[100])
        {
            DataClassification = ToBeClassified;


        }

        field(50483; "Religion."; enum MemberReligionEnum)
        {
            DataClassification = ToBeClassified;


        }
        field(50484; "Member Type"; Option)
        {
            OptionMembers = Member,Staff,Board,"Station Representative";
            OptionCaption = 'Member,Staff,Board,Station Representative';

        }

        field(50485; "Exempted From Tax"; Boolean)
        {

        }

        field(50486; "How did you know about us?"; Enum "Lead Source")
        {

        }
        field(50487; "Sub-county"; Code[100])
        {

        }
        field(50488; "Area"; Code[100])
        {

        }
        field(50489; "Work E-Mail"; Code[100])
        {

        }

        field(50490; "Nearest Landmark"; Text[100])
        {

        }

        field(50491; "Secondary Mobile No"; Code[100])
        {

        }

        field(50492; "Surname"; Code[100])
        {

        }
        field(50493; "Mode Of Remmittance"; Option)
        {
            OptionCaption = ',Checkoff,"Standing Order",Cash,M-Pesa,"Direct Debit"';
            OptionMembers = ,Checkoff,"Standing Order",Cash,"M-Pesa","Direct Debit";
        }

        field(50494; "Station Representative"; Text[100])
        {
            DataClassification = ToBeClassified;

        }

        field(50495; "Retirement Date"; Date)
        {
            DataClassification = ToBeClassified;

        }

        field(50496; "Receive SMS Notification"; Boolean)
        {
            DataClassification = ToBeClassified;

        }


        field(50497; "Workstation"; text[100])
        {
            TableRelation = WorkStations.Code;

        }

        field(50498; "Employment Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Active In Service,Retired from Service';
            OptionMembers = "Active In Service","Retired from Service";
        }
        field(50499; "Why Exempt from Tax?"; Text[2048])
        {
            DataClassification = ToBeClassified;
        }

        field(50500; "Old FOSA Account"; Code[60])
        {
            DataClassification = ToBeClassified;
        }
        field(50501; "Checkoff Account"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50502; "Salary Account"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50503; "Jipange Balance"; Decimal)
        {
            CalcFormula = - sum("Detailed Vendor Ledg. Entry".Amount where("Vendor No." = field("FOSA Account No.")));
            FieldClass = FlowField;
            Editable = false;
        }
        field(50504; "ATM No"; Code[16])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50505; "Employment Start Date"; Date)
        {
            Editable = false;
        }
        field(50506; "Employment End Date"; Date)
        {
            Editable = false;
        }

        field(50507; "Employment Period"; DateFormula)
        {
            Editable = false;
        }
        field(50508; "Tax Exemption Start Date"; Date)
        {
            Editable = false;
        }
        field(50509; "Tax Exemption End Date"; Date)
        {
            Editable = false;
        }
        field(50510; "Tax Exemption Period"; DateFormula)
        {
            Editable = false;
        }
        field(50511; "Membership Status"; Option)
        {
            // Editable = true;
            OptionCaption = 'Active,Deceased,Retired,Dormant,Awaiting Exit,Exited,Fully Exited,Re-instated,Closed';
            OptionMembers = Active,Deceased,Retired,Dormant,"Awaiting Exit",Exited,"Fully Exited","Re-instated",Closed;

            trigger OnValidate()
            begin
                Vend.Reset();
                Vend.SetRange("BOSA Account No", "No.");
                Vend.SetRange("Creditor Type", Vend."Creditor Type"::"FOSA Account");
                if vend.FindSet() then begin
                    repeat
                        Vend.Status := Status;
                        vend."Membership Status" := "Membership Status";
                        vend.modify;
                    until Vend.Next() = 0;
                end;
            end;
        }

        field(50512; "Checkoff Loans"; Decimal)
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum("Checkoff Loans".Amount where(Payroll = field("Payroll No")));
        }
        field(50513; "KTDA Buying Centre"; Code[20])
        {

        }
        field(50514; "Paid Registration Fee"; Boolean)
        {

        }
        field(50515; "ID Front"; MediaSet)
        {

        }
        field(50516; "ID Back"; MediaSet)
        {

        }

        field(50517; "Pays Benevolent"; Boolean)
        {

        }

        field(50518; "Monthly Sch.Fees Cont."; Decimal)
        {

        }

        field(50519; "Checkoff Member"; Boolean)
        {

        }

        field(50520; "Last Checkoff Date"; Date)
        {

        }

        field(50521; "Last Checkoff Amount"; Decimal)
        {

        }

        field(50522; "Variation Date Deposits"; Date)
        {

        }
        field(50523; "Variation Date ESS"; Date)
        {

        }
        field(50524; "School Fees Shares"; Decimal)
        {
            CalcFormula = - sum("Detailed Vendor Ledg. Entry".Amount where("Vendor No." = field("School Fees Shares Account"),/* "Document No." = filter(<>'ESSSBBF310324'),*/
                                                                        Reversed = filter(false), "Posting Date" = field("Date Filter")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50535; "School Fees Shares Account"; Code[60])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50525; "Main Sector"; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "Main Sector".Code;
            trigger OnValidate()
            var
                MainS: Record "Main Sector";
            begin
                MainS.reset;
                MainS.Setrange(MainS.Code, "Main Sector");
                if MainS.FindFirst then begin
                    "Main Sector Name" := MainS.Description;
                end;
            end;
        }
        field(50526; "Sub Sector"; Code[20])
        {
            //DataClassification = ToBeClassified;
            Editable = false;

            TableRelation = "Sub Sector".Code where("Main Sector" = field("Main Sector"));
            trigger OnValidate()
            var
                MainS: Record "Sub Sector";
            begin
                MainS.reset;
                MainS.Setrange(MainS.Code, "Sub Sector");
                if MainS.FindFirst then begin
                    "SubSector Name" := MainS.Description;
                end;
            end;
        }
        field(50527; "Sector Specific"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Specific Sector".Code; //where("Sub-Sector" = field("Sub Sector"));

            trigger OnValidate()
            var
                SpecificSector: Record "Specific Sector";
                SubS: Record "Sub Sector";
                MainS: Record "Main Sector";
            begin
                SpecificSector.Reset();
                SpecificSector.SetRange(SpecificSector.Code, "Sector Specific");
                if SpecificSector.Findfirst then begin
                    "Sector Specific Name" := SpecificSector.Description;
                    SubS.RESET;
                    SubS.Setrange(SubS.Code, SpecificSector."Sub-Sector");
                    if SubS.FindFirst() then begin
                        "Sub Sector" := SubS.code;
                        "SubSector Name" := SubS.Description;
                    end;

                    MainS.reset;
                    MainS.SetRange(MainS.Code, SpecificSector."Main Sector");
                    if MainS.FindFirst() then begin
                        "Main Sector" := MainS.Code;
                        "Main Sector Name" := MainS.Description;
                    end;
                end;


            end;

        }
        field(50528; "Sector Specific Name"; Text[2048])
        {

        }
        field(50529; "Main Sector Name"; Text[2048])
        {

        }
        field(50530; "SubSector Name"; Text[2048])
        {

        }
        field(50531; "Sales Person"; Text[2048])
        {
            TableRelation = "HR Employees"."No.";
        }
        field(50532; "Customer Service Rep."; Code[20])
        {
            TableRelation = "HR Employees"."No.";
            trigger
            OnValidate()
            begin
                if HREmployee.Get("Customer Service Rep.") then begin
                    "Customer Service Rep. Name" := HREmployee."First Name" + ' ' + HREmployee."Middle Name" + ' ' + HREmployee."Last Name";
                end;
            end;
        }
        field(50533; "Customer Service Rep. Name"; Text[500])
        {

        }
        field(50534; "Has Next of Kin"; Boolean)
        {
            FieldClass = FlowField;
            CalcFormula = Exist("Members Next of Kin" where("Account No" = field("No.")));
        }
        field(50536; "Principle Balance"; Decimal)
        {
            /*             FieldClass = FlowField;
                        CalcFormula = Sum("Member Ledger Entry".Amount WHERE("Customer No." = FIELD("No."), "Transaction Type" = FILTER(Loan | "Loan Repayment"))); */
        }
        field(50537; "Old Ordinary Account NAV2016"; Code[20])
        {
            Editable = false;
        }
        field(50538; "Loan Defaulter"; Boolean)
        {
            // Editable=false;
        }
        field(50539; "ESS Contribution"; Decimal)
        {
            // Editable=false;
        }
        field(50540; "Customer Principal Balance"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Detailed Cust. Ledg. Entry".Amount WHERE("Customer No." = FIELD("No."), "Transaction Type" = FILTER(Loan | Repayment)));
        }
        field(50541; "Dividend Year"; Code[40])
        {

        }
        field(50542; "Last Deposit Contr Date"; Date)
        {
            FieldClass = FlowField;
            CalcFormula = max("Detailed Vendor Ledg. Entry"."Posting Date" where("Vendor No." = field("Deposits Account No"), "Posting Group" = const('BOSA DEPOSITS')));
        }
        field(50543; "Over-Guaranteed"; Boolean)
        {

        }
        field(50544; "Amount Guaranteed"; Decimal)
        {

        }
        field(50545; "Current Ability"; Decimal)
        {

        }
        field(50546; "Applicant No."; Code[20])
        {

        }
        field(50547; "Created On"; Date)
        {
        }
        field(50548; "Wezesha Savings"; Decimal)
        {
            CalcFormula = - sum("Detailed Vendor Ledg. Entry".Amount where("Vendor No." = field("Wezesha Savings Acc"),
                                                                    Reversed = filter(False), "Posting Date" = field("Date Filter")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50549; "Ordinary Savings"; Decimal)
        {
            CalcFormula = - sum("Detailed Vendor Ledg. Entry".Amount where("Vendor No." = field("Ordinary Savings Acc"),
                                                                    Reversed = filter(False), "Posting Date" = field("Date Filter")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50550; "Chamaa Savings"; Decimal)
        {
            CalcFormula = - sum("Detailed Vendor Ledg. Entry".Amount where("Vendor No." = field("Chamaa Savings Acc"),
                                                                        Reversed = filter(False), "Posting Date" = field("Date Filter")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50551; "Jibambe Savings"; Decimal)
        {
            CalcFormula = - sum("Detailed Vendor Ledg. Entry".Amount where("Vendor No." = field("Jibambe Savings Acc"),
                                                                        Reversed = filter(False), "Posting Date" = field("Date Filter")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50552; "Fixed Deposit"; Decimal)
        {
            CalcFormula = - sum("Detailed Vendor Ledg. Entry".Amount where("Vendor No." = field("Fixed Deposit Acc"),
                                                                        Reversed = filter(False), "Posting Date" = field("Date Filter")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50553; "Mdosi Junior"; Decimal)
        {
            CalcFormula = - sum("Detailed Vendor Ledg. Entry".Amount where("Vendor No." = field("Mdosi Junior Acc")
                                                                    , Reversed = filter(False),
                                                                   "Posting Date" = field("Date Filter")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50554; "Pension Akiba"; Decimal)
        {
            CalcFormula = - sum("Detailed Vendor Ledg. Entry".Amount where("Vendor No." = field("Pension Akiba Acc"),
                                                                        Reversed = filter(False), "Posting Date" = field("Date Filter")));
            Editable = false;
            FieldClass = FlowField;
        }

        field(50555; "Business Account"; Decimal)
        {
            CalcFormula = - sum("Detailed Vendor Ledg. Entry".Amount where("Vendor No." = field("Business Account Acc")
                                                                    , Reversed = filter(False),
                                                                   "Posting Date" = field("Date Filter")));
            Editable = false;
            FieldClass = FlowField;
        }

        field(50556; "Wezesha Savings Acc"; code[100])
        {

        }
        field(50557; "Ordinary Savings Acc"; code[100])
        {

        }
        field(50558; "Chamaa Savings Acc"; code[100])
        {

        }
        field(50559; "Jibambe Savings Acc"; code[100])
        {

        }
        field(50560; "Fixed Deposit Acc"; code[100])
        {

        }
        field(50561; "Mdosi Junior Acc"; code[100])
        {

        }
        field(50562; "Pension Akiba Acc"; code[100])
        {

        }

        field(50563; "Business Account Acc"; code[100])
        {

        }
        field(50564; "Last Deposit Date Sch"; Date)
        {
            FieldClass = FlowField;
            CalcFormula = Max("Member Ledger Entry"."Posting Date" WHERE("Transaction Type" = FILTER("Dividend"), "Customer No." = FIELD("No.")));
        }
        field(50565; "Last Deposit Date Deposit"; Date)
        {
            FieldClass = FlowField;
            CalcFormula = Max("Member Ledger Entry"."Posting Date" WHERE("Transaction Type" = FILTER("Deposit Contribution"), "Customer No." = FIELD("No.")));

        }
        field(50566; "Share Capital Found"; Boolean)
        {
            CalcFormula = exist(Vendor where("BOSA Account No" = field("No."), "Account Type" = filter('101')));
            FieldClass = FlowField;
        }

        field(50567; "Deposits Found"; Boolean)
        {
            CalcFormula = exist(Vendor where("BOSA Account No" = field("No."), "Account Type" = filter('102')));
            FieldClass = FlowField;
        }


        field(50568; "Ordinary Found"; Boolean)
        {
            CalcFormula = exist(Vendor where("BOSA Account No" = field("No."), "Account Type" = filter('103')));
            FieldClass = FlowField;
        }
        field(50569; "Coop Shares"; Decimal)
        {

        }

        field(50570; "Coop Shares Net"; Decimal)
        {

        }
        field(50571; "Total Mdosi Jr"; Decimal)
        {

        }
        field(50572; "Share Capital Contribution"; Decimal)
        {

        }
        field(50573; "Jibambe Savings Contribution"; Decimal)
        {

        }
        field(50574; "Wezesha Savings Contribution"; Decimal)
        {

        }
        field(50575; "Mdosi Jr Contribution"; Decimal)
        {

        }
        field(50576; "Pension Akiba Contribution"; Decimal)
        {

        }
        field(50577; "ESS Interest Amount"; Decimal)
        {

        }
        field(50578; "Deposits Interest Amount"; Decimal)
        {

        }
        field(50579; "ESS Net Interest Amount"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = - sum("Dividends Progression"."Net Dividends" where("Member No" = field("No."), "Deposit Type" = filter(ESS), Posted = filter(false)));
        }
        field(50580; "ESS Gross Interest Amount"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = - sum("Dividends Progression"."Gross Dividends" where("Member No" = field("No."), "Deposit Type" = filter(ESS), Posted = filter(false)));
        }
        field(50581; "ESS WHT Amount"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = - sum("Dividends Progression"."Witholding Tax" where("Member No" = field("No."), "Deposit Type" = filter(ESS), Posted = filter(false)));
        }
        field(50582; "Deposits Net Interest Amount"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = - sum("Dividends Progression"."Net Dividends" where("Member No" = field("No."), "Deposit Type" = filter(Deposits), Posted = filter(false)));
        }
        field(50583; "Deposits Gross Interest Amount"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = - sum("Dividends Progression"."Gross Dividends" where("Member No" = field("No."), "Deposit Type" = filter(Deposits), Posted = filter(false)));
        }
        field(50584; "Deposits WHT Amount"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = - sum("Dividends Progression"."Witholding Tax" where("Member No" = field("No."), "Deposit Type" = filter(Deposits), Posted = filter(false)));
        }
        field(50585; "Dividend Net Interest Amount"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = - sum("Dividends Progression"."Net Dividends" where("Member No" = field("No."), "Deposit Type" = filter("Share Capital"), Posted = filter(false)));
        }
        field(50586; "Dividend Gross Interest Amount"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = - sum("Dividends Progression"."Gross Dividends" where("Member No" = field("No."), "Deposit Type" = filter("Share Capital"), Posted = filter(false)));
        }
        field(50587; "Dividend WHT Amount"; Decimal)
        {
            FieldClass = FlowField;//
            CalcFormula = - sum("Dividends Progression"."Witholding Tax" where("Member No" = field("No."), "Deposit Type" = filter("Share Capital"), Posted = filter(false)));
        }
        field(50588; "Gross Dividends"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = - sum("Dividends Progression"."Gross Dividends" where("Member No" = field("No."), "Deposit Type" = filter(Deposits | "Share Capital"), Posted = filter(false)));
        }

        field(50589; "Net Dividends Total"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = - sum("Dividends Progression"."Net Dividends" where("Member No" = field("No."), "Deposit Type" = filter(Deposits | "Share Capital"), Posted = filter(false)));
        }

        field(50590; "Upright Pensioner"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'This is a member whose pension is sufficient to repay their pension loans exclusively without repaying their salary loans from the same pension';
        }
        field(50591; "Member Region"; code[30])
        {
            TableRelation = "Member Delegate Zones".Code;//
        }
        field(50592; "Downline ID"; Code[60])
        {
            DataClassification = ToBeClassified;
            TableRelation = if ("How did you know about us?" = filter('Member|Staff')) Customer where(ISNormalMember = const(true));
        }
        field(50593; "MLM Level"; Code[20])
        {
            TableRelation = "MLM Level Setup"."Level Code";

        }
        field(50594; "Commission Paid"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Commission Paid';
        }
        field(50595; "Upline ID"; Code[60])
        {
            DataClassification = ToBeClassified;
            TableRelation = if ("How did you know about us?" = filter('Member|Staff')) Customer where(ISNormalMember = const(true));
        }
        field(50596; "Lead Source ID"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Lead Source ID';
        }
        field(50597; "Marketing Campaign ID"; Code[40])
        {
            Caption = 'Marketing Campaign ID';
            ToolTip = 'Specifies Marketing Campaign ID';
            TableRelation = "Marketing Campaign"."Campaign ID";
        }
        field(50598; "Marketing Event ID"; Code[40])
        {
            Caption = 'Marketing Event ID';
            ToolTip = 'Specifies who Marketing Event ID.';
            TableRelation = "Marketing Event"."Event ID" where("Campaign ID" = field("Marketing Campaign ID"));
        }
        field(50599; "Commission Posted"; Boolean)
        {
            Caption = 'Commission Posted';
            ToolTip = 'Specifies if the commission has been posted.';

        }
        field(50600; "Property Type"; Enum "Property Type")
        {
            Caption = 'Property Type';
            ToolTip = 'Specifies the type of property owned by the member.';

        }
        field(50601; "Loan Purpose"; Enum "Loan Purpose")
        {
            Caption = 'Loan Purpose';
            ToolTip = 'Specifies the purpose of the loan applied for by the member.';

        }
        field(50602; "Loan Purpose Specification"; Text[500])
        {
            Caption = 'Loan Purpose Specification';
            ToolTip = 'Specifies the specific purpose of the loan applied for by the member.';

        }
        field(50603; "Proposed Location County"; Text[500])
        {
            Caption = 'Proposed Location County';
            ToolTip = 'Specifies the proposed property location for the member.';

        }
        field(50604; "Proposed Location Town"; Text[500])
        {
            Caption = 'Proposed Location Town';
            ToolTip = 'Specifies the proposed property location town for the member.';

        }
        field(50605; "Is the property owned? "; Boolean)
        {
            Caption = 'Is the property owned?';
            ToolTip = 'Specifies whether the proposed property is owned by the member.';

        }
        field(50606; "Contact Person Address"; Text[500])
        {
            Caption = 'Contact Person Address';
            ToolTip = 'Specifies the address of the contact person for the member.';

        }
        field(50607; "Contact Person Postal Code"; Text[500])
        {
            Caption = 'Contact Person Postal Code';
            ToolTip = 'Specifies the postal code of the contact person for the member.';

        }
        field(50608; "Contact Person Town"; Text[500])
        {
            Caption = 'Contact Person Town';
            ToolTip = 'Specifies the town of the contact person for the member.';

        }



    }

    keys
    {
        key(Key30; "Employer Code", "Mobile Phone No")
        {
        }
        key(Key35; "Payroll No", "Customer Type")
        {
        }
        key(Key36; "Payroll No")
        {
        }
        key(Key37; "ID No.")
        {
        }
        key(Key38; "Mobile Phone No")
        {
        }
        key(Key39; "FOSA Account No.")
        {
        }


    }
    fieldgroups
    {
        addlast(DropDown; "Payroll No", "ID No.", "FOSA Account No.", "Employer Code", "Customer Service Rep.", "Mobile Phone No")
        {
        }

    }


    trigger OnRename()
    begin
        "Last Date Modified" := Today;
        CalcFields("Current Shares", "Shares Retained");
    end;

    var
        myInt: Integer;
        MembersRec: Record "Members Register";
        Text000: label 'You cannot delete %1 %2 because there is at least one outstanding Sales %3 for this customer.';
        Text002: label 'Do you wish to create a contact for %1 %2?';
        SalesSetup: Record "Sacco No. Series";
        CommentLine: Record "Comment Line";
        SalesOrderLine: Record "Sales Line";
        CustBankAcc: Record "Customer Bank Account";
        ShipToAddr: Record "Ship-to Address";
        PostCode: Record "Post Code";
        GenBusPostingGrp: Record "Gen. Business Posting Group";
        ShippingAgentService: Record "Shipping Agent Services";
        //ItemCrossReference: Record "Item Cross Reference";
        RMSetup: Record "Marketing Setup";
        SalesPrice: Record "Sales Price";
        SalesLineDisc: Record "Sales Line Discount";
        SalesPrepmtPct: Record "Sales Prepayment %";
        ServContract: Record "Service Contract Header";
        ServHeader: Record "Service Header";
        ServiceItem: Record "Service Item";
        NoSeriesMgt: Codeunit "No. Series";
        MoveEntries: Codeunit MoveEntries;
        UpdateContFromCust: Codeunit "CustCont-Update";
        DimMgt: Codeunit DimensionManagement;
        InsertFromContact: Boolean;
        Text003: label 'Contact %1 %2 is not related to customer %3 %4.';
        Text004: label 'post';
        Text005: label 'create';
        Text006: label 'You cannot %1 this type of document when Customer %2 is blocked with type %3';
        Text007: label 'You cannot delete %1 %2 because there is at least one not cancelled Service Contract for this customer.';
        Text008: label 'Deleting the %1 %2 will cause the %3 to be deleted for the associated Service Items. Do you want to continue?';
        Text009: label 'Cannot delete customer.';
        Text010: label 'The %1 %2 has been assigned to %3 %4.\The same %1 cannot be entered on more than one %3. Enter another code.';
        Text011: label 'Reconciling IC transactions may be difficult if you change IC Partner Code because this %1 has ledger entries in a fiscal year that has not yet been closed.\ Do you still want to change the IC Partner Code?';
        Text012: label 'You cannot change the contents of the %1 field because this %2 has one or more open ledger entries.';
        Text013: label 'You cannot delete %1 %2 because there is at least one outstanding Service %3 for this customer.';
        Text014: label 'Before you can use Online Map, you must fill in the Online Map Setup window.\See Setting Up Online Map in Help.';
        Text015: label 'You cannot delete %1 %2 because there is at least one %3 associated to this customer.';
        Loans: Record "Loans Register";
        GenSetUp: Record "Sacco General Set-Up";
        MinShares: Decimal;
        MovementTracker: Record "Movement Tracker";
        Cust: Record "Members Register";
        Vend: Record Vendor;
        CustFosa: Code[20];
        Vend2: Record Vendor;
        FOSAAccount: Record Vendor;
        StatusPermissions: Record "Status Change Permision";
        RefundsR: Record Refunds;
        Text001: label 'You cannot delete %1 %2 because there is at least one transaction %3 for this customer.';
        Approvalsetup: Record "Approvals Set Up";
        DataSheet: Record "Data Sheet Main";
        Employer: Record "Employers Register";
        Parishes: Record "Member's Parishes";
        SurestepFactory: Codeunit "Au Factory";
        ObjCellGroup: Record "Member House Groups";
        ObjLoans: Record "Loans Register";
        ObjExpectedTurnOver: Record "Expected Monthly TurnOver";
        BanksVer2: Record "Banks Ver2";
        HREmployee: Record "HR Employees";

}


