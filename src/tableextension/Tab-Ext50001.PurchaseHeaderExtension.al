tableextension 50001 "PurchaseHeaderExtension" extends "Purchase Header"
{
    fields
    {

        field(50000; DocApprovalType; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Purchase,Requisition,Quote,Capex';
            OptionMembers = Purchase,Requisition,Quote,Capex;
        }
        field(50053; "Type of Payment"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = General,Imprest,PurchaseRequisition,ExpenseRequisition;
            OptionCaption = 'General,Imprest,PurchaseRequisition,ExpenseRequisition';
        }
        field(50001; PR; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50002; Requisition; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50003; Service; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50004; "User ID"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50005; "Doc Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = ,PurchReq,"Mission Proposal";
        }
        field(50006; Completed; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50007; "Requisition No"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Purchase Header"."No." where(PR = const(true),
                                                           Status = const(Released));

            trigger OnValidate()
            begin
                //CHECK WHETHER HAS LINES AND DELETE
                if Confirm('If you change the requisition no. the current lines will be deleted. Do you want to continue?') then begin

                    PurchLine.Reset;
                    PurchLine.SetRange(PurchLine."Document No.", "No.");

                    if PurchLine.Find('-') then
                        PurchLine.DeleteAll;


                    //POPULATTE PURCHASE LINE WHEN USER SELECTS RFQ.
                    RFQ.Reset;
                    RFQ.SetRange("Document No.", "Requisition No");
                    if RFQ.Find('-') then begin
                        repeat
                            PurchLine2.Init;

                            LineNo := LineNo + 1000;
                            PurchLine2."Document Type" := "Document Type";
                            PurchLine2.Validate("Document Type");
                            PurchLine2."Document No." := "No.";
                            PurchLine2.Validate("Document No.");
                            PurchLine2."Line No." := LineNo;
                            PurchLine2.Type := RFQ.Type;
                            PurchLine2."No." := RFQ."No.";
                            PurchLine2.Validate("No.");
                            PurchLine2.Description := RFQ.Description;
                            PurchLine2."Description 2" := RFQ."Description 2";
                            PurchLine2.Quantity := RFQ.Quantity;
                            PurchLine2.Validate(Quantity);
                            PurchLine2."Unit of Measure Code" := RFQ."Unit of Measure Code";
                            PurchLine2.Validate("Unit of Measure Code");
                            PurchLine2."Direct Unit Cost" := RFQ."Direct Unit Cost";
                            PurchLine2.Validate("Direct Unit Cost");
                            PurchLine2."Location Code" := RFQ."Location Code";
                            //PurchLine2."RFQ No.":="Request for Quote No.";
                            //PurchLine2.VALIDATE("RFQ No.");
                            PurchLine2."Location Code" := "Location Code";
                            PurchLine2."Shortcut Dimension 1 Code" := "Shortcut Dimension 1 Code";
                            PurchLine2."Shortcut Dimension 2 Code" := "Shortcut Dimension 2 Code";
                            PurchLine2.Insert(true);

                        until RFQ.Next = 0;
                    end;
                end;
            end;
        }
        field(50008; "Order No"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(50009; "Invoice No"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(50010; "Strategic Focus Area"; Code[2048])
        {
            DataClassification = ToBeClassified;
            //TableRelation = "Standard Text".Code where (Type=const("Focus Area"));
        }
        field(50011; "Sub Pillar"; Code[2048])
        {
            DataClassification = ToBeClassified;
            //TableRelation = "Standard Text".Code where (Type=const("Sub Pillar"));
        }
        field(50012; "Project Title"; Code[2048])
        {
            DataClassification = ToBeClassified;
        }
        field(50013; Country; Code[10])
        {
            DataClassification = ToBeClassified;
            //TableRelation = "Country/Region" where(Type = const(Country));
        }
        field(50014; County; Code[10])
        {
            DataClassification = ToBeClassified;
            //TableRelation = "Country/Region" where(Type = const(County));
        }
        field(50015; "Date(s) of Activity"; Text[500])
        {
            DataClassification = ToBeClassified;
        }
        field(50016; "Mission Team"; Text[2048])
        {
            DataClassification = ToBeClassified;
        }
        field(50017; "Invited Members/Partners"; Text[2048])
        {
            DataClassification = ToBeClassified;
        }
        field(50018; MP; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50019; "Mission Proposal No"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = if ("Type of Payment" = filter('ExpenseRequisition')) "Purchase Header"."No." where("AU Form Type" = filter("Expense Requisition"),

            Status = const(Released))
            //, "Account No" = field("Account No"));


            ELSE
            if ("Type of Payment" = filter('Purchaserequisition')) "Purchase Header"."No." where("AU Form Type" = filter("Purchase Requisition"),

            Status = const(Released));



        }
        field(50020; IM; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50021; "Paying Account No"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Bank Account";

            trigger OnValidate()
            begin
                if BankAccount.Get("Paying Account No") then
                    "Paying Account Name" := BankAccount.Name;
            end;
        }
        field(50022; "Paying Account Name"; Text[60])
        {
            DataClassification = ToBeClassified;
        }
        field(50023; "Cheque No"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50024; "Account No"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = Customer;

            trigger OnValidate()
            begin
                if Customer.Get("Account No") then
                    "Account Name" := Customer.Name;
            end;
        }
        field(50025; "Account Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50026; "Imprest No"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Purchase Header"."No." where(IM = const(true),
                                                           Surrendered = const(false),
                                                           Status = const(Released));
        }
        field(50027; SR; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50028; Surrendered; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50029; "Shortcut Dimension 3 Code"; Code[20])
        {
            CaptionClass = '1,2,3';
            Caption = 'Shortcut Dimension 3 Code';
            DataClassification = ToBeClassified;
            // TableRelation = "Dimension Value".Code where("Global Dimension No." = const(3),
            //                                               Blocked = const(false),
            //                                               "Project Code" = field("Shortcut Dimension 1 Code"));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(1, "Shortcut Dimension 1 Code");
            end;
        }
        field(50030; "Shortcut Dimension 4 Code"; Code[20])
        {
            CaptionClass = '1,2,4';
            Caption = 'Shortcut Dimension 4 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(4),
                                                          Blocked = const(false));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(2, "Shortcut Dimension 2 Code");
            end;
        }
        field(50031; "Shortcut Dimension 5 Code"; Code[20])
        {
            CaptionClass = '1,2,5';
            Caption = 'Shortcut Dimension 5 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(5),
                                                          Blocked = const(false));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(2, "Shortcut Dimension 2 Code");
            end;
        }
        field(50032; Background; Text[2048])
        {
            DataClassification = ToBeClassified;
        }
        field(50033; "Contribution to focus"; Text[2048])
        {
            DataClassification = ToBeClassified;
        }
        field(50034; "Main Outcome"; Text[2048])
        {
            DataClassification = ToBeClassified;
        }
        field(50035; "Budget Balance"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50038; "Mission Total"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CalcFormula = sum("Purchase Line"."Total Ksh" where("Document Type" = field("Document Type"),
                                                                 "Document No." = field("No.")));
            Caption = 'Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50039; "Shortcut Dimension 6 Code"; Code[20])
        {
            CaptionClass = '1,2,6';
            Caption = 'Shortcut Dimension 6 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(6),
                                                          Blocked = const(false));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(2, "Shortcut Dimension 2 Code");
            end;
        }
        field(50040; "Shortcut Dimension 7 Code"; Code[20])
        {
            CaptionClass = '1,2,7';
            Caption = 'Shortcut Dimension 7 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(7),
                                                          Blocked = const(false));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(2, "Shortcut Dimension 2 Code");
            end;
        }
        field(50041; "Shortcut Dimension 8 Code"; Code[20])
        {
            CaptionClass = '1,2,8';
            Caption = 'Shortcut Dimension 8 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(8),
                                                          Blocked = const(false));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(2, "Shortcut Dimension 2 Code");
            end;
        }
        field(50042; "Payment Voucher No"; Code[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50036; "Expense Requisition No"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Purchase Header"."No." where("AU Form Type" = filter("Expense Requisition"));

            //Status = const(Released)) //, "Account No" = field("Account No"));

        }
        field(50037; "Imprest Requisition No"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = if ("Type of Payment" = filter('Imprest')) "Purchase Header"."No." where("AU Form Type" = filter("Imprest Requisition"),

            Status = const(Released)) else
            if ("Type of Payment" = filter('Imprest')) "Purchase Header"."No." where("AU Form Type" = filter("Imprest Requisition"),

            Status = const(Released))
            //, "Account No" = field("Account No"));


            ELSE
            if ("Type of Payment" = filter('Purchaserequisition')) "Purchase Header"."No." where(PR = filter(true),

            Status = const(Released));



        }
        field(50073; "Imprest Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50074; "Imprest Holder"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "HR Employees";
        }
        field(50075; "Previous Imprest Accounted"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50076; "No of Days Outstanding"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50077; "Finance Action"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50078; InsertPortal; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                //CHECK WHETHER HAS LINES AND DELETE
                //IF CONFIRM('If you change the imprest no. the current lines will be deleted. Do you want to continue?')  THEN BEGIN

                PurchLine.Reset;
                PurchLine.SetRange(PurchLine."Document No.", "No.");

                if PurchLine.Find('-') then
                    PurchLine.DeleteAll;

                PurchaseHeader2.Reset;
                PurchaseHeader2.SetRange("No.", "Imprest No");
                if PurchaseHeader2.FindFirst then begin
                    "Mission Proposal No" := PurchaseHeader2."Mission Proposal No";
                    "Shortcut Dimension 1 Code" := PurchaseHeader2."Shortcut Dimension 1 Code";
                    "Shortcut Dimension 2 Code" := PurchaseHeader2."Shortcut Dimension 2 Code";
                    "Shortcut Dimension 3 Code" := PurchaseHeader2."Shortcut Dimension 3 Code";
                    "Shortcut Dimension 4 Code" := PurchaseHeader2."Shortcut Dimension 4 Code";
                    "Shortcut Dimension 5 Code" := PurchaseHeader2."Shortcut Dimension 5 Code";
                    Purpose := PurchaseHeader2.Purpose;
                end;
                //POPULATTE PURCHASE LINE WHEN USER SELECTS IMP.
                RFQ.Reset;
                RFQ.SetRange("Document No.", "Imprest No");
                if RFQ.Find('-') then begin
                    repeat
                        PurchLine2.Init;
                        /*
                        LineNo:=LineNo+1000;
                        PurchLine2."Document Type":="Document Type";
                        PurchLine2.VALIDATE("Document Type");
                        PurchLine2."Document No.":="No.";
                        PurchLine2.VALIDATE("Document No.");
                        PurchLine2."Line No.":=LineNo;
                        PurchLine2.Type:=RFQ.Type;
                        PurchLine2."Line Type":=
                        PurchLine2."No.":=RFQ."No.";
                        PurchLine2.VALIDATE("No.");
                        PurchLine2.Description:=RFQ.Description;
                        PurchLine2."Description 2":=RFQ."Description 2";
                        PurchLine2.Quantity:=RFQ.Quantity;
                        PurchLine2.VALIDATE(Quantity);
                        PurchLine2."Unit of Measure Code":=RFQ."Unit of Measure Code";
                        PurchLine2.VALIDATE("Unit of Measure Code");
                        PurchLine2."Direct Unit Cost":=RFQ."Direct Unit Cost";
                        PurchLine2.VALIDATE("Direct Unit Cost");
                        PurchLine2."Location Code":=RFQ."Location Code";
                        PurchLine2."Location Code":="Location Code";
                        PurchLine2."Expense Category":=RFQ."Expense Category";
                        PurchLine2."Shortcut Dimension 1 Code":="Shortcut Dimension 1 Code";
                        PurchLine2."Shortcut Dimension 2 Code":="Shortcut Dimension 2 Code";
                        */

                        PurchLine2.Copy(RFQ);
                        PurchLine2."Document No." := "No.";
                        if PurchLine2.noOfDays <> 0 then begin
                            PurchLine2."Amount Spent" := PurchLine2.noOfDays * PurchLine2.Amount;
                        end else begin
                            PurchLine2."Amount Spent" := PurchLine2.Amount;
                        end;
                        //PurchLine2."Shortcut Dimension 3 Code":="Shortcut Dimension 3 Code";
                        PurchLine2.Insert(true);

                    until RFQ.Next = 0;
                end;
                //END;

            end;
        }
        field(50079; "Employee No"; Code[20])
        {
            DataClassification = ToBeClassified;

            TableRelation = "HR Employees"."No.";
        }
        field(50080; "Employee Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50081; Archived; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50082; APP; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50083; "Appraisal Code"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(50084; fromDate; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50054; "Purcahse Requisition No"; code[50])
        {
            //TableRelation = "Purchase Header"."No." where("AU Form Type" = filter("Purchase Requisition"), Status = filter(Released));
        }
        field(50085; "Review From"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50086; briefOfProject; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(50087; travelTo; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50088; placeOfStay; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(50089; contactPerson; Text[60])
        {
            DataClassification = ToBeClassified;
        }
        field(50090; itemsInPosession; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(50091; modeOfTransport; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50092; Purpose; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(50093; Commenting; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50094; PM; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50095; "Review To"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50096; Approver1Signature; Blob)
        {
            DataClassification = ToBeClassified;
        }
        field(50097; Approver2Name; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50098; Approver2Signature; Blob)
        {
            DataClassification = ToBeClassified;
        }
        field(50099; Approver3Name; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50100; Approver3Signature; Blob)
        {
            DataClassification = ToBeClassified;
        }
        field(50101; Approver1Date; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(50102; Approver2Date; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(50103; Approver3Date; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(50104; RequesterDate; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(50105; Approver1Name; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50106; "Requester Signature"; Blob)
        {
            DataClassification = ToBeClassified;
        }
        field(50107; "RFQ No"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Purchase Header"."No." where("AU Form Type" = filter(RFQ));

        }
        field(50108; "LPO No"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50109; "Travel Total"; Decimal)
        {
            CalcFormula = sum("Purchase Line".Amount where("Document No." = field("No.")));
            FieldClass = FlowField;
        }
        field(50110; "AU Form Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ',Imprest Accounting,Imprest Requisition,Payment Voucher,Receipt Voucher,Salary Advance,Funds Transfer,Petty Cash Voucher,Claim Voucher,Purchase Requisition,RFQ,Purchase Request,Purchase Quotes,Purchase Order,Purchase Invoice,Expense Requisition,Jounal Posting';
            OptionMembers = ,"Imprest Accounting","Imprest Requisition","Payment Voucher","Receipt Voucher","Salary Advance","Funds Transfer","Petty Cash Voucher","Claim Voucher","Purchase Requisition","RFQ","Purchase Request","Purchase Quotes","Purchase Order","Purchase Invoice","Expense Requisition","Jounal Posting'";
        }
        field(50111; "Withholding Tax Amount"; Decimal)
        {
            CalcFormula = sum("Purchase Line"."Withholding Tax Amount" where("Document Type" = field("Document Type"),
                                                                              "Document No." = field("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50112; "Net Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CalcFormula = sum("Purchase Line"."Net Amount" where("Document Type" = field("Document Type"),
                                                                  "Document No." = field("No.")));
            Caption = 'Net Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50113; "Net Amount in foreign Currency"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CalcFormula = sum("Purchase Line"."Unit Cost (LCY)" where("Document Type" = field("Document Type"),
                                                                       "Document No." = field("No.")));
            Caption = 'Net Amount in foreign Currency';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50114; Posted; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50115; Approver4Date; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(50116; Approver4Name; Text[100])
        {
            DataClassification = ToBeClassified;
        }


        field(50118; Approver4Signature; Blob)
        {
            DataClassification = ToBeClassified;
        }
        field(50121; "Consultancy Tax Amount"; Decimal)
        {
            CalcFormula = sum("Purchase Line"."Consultancy Fee" where("Document Type" = field("Document Type"),
                                                                              "Document No." = field("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50120; "Total Unit Cost"; Decimal)
        {
            CalcFormula = sum("Purchase Line"."Amount In Foreign" where("Document No." = field("No.")));
            FieldClass = FlowField;
        }
        field(50119; Department; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50043; "Payee Naration"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50046; "Mission Naration"; Text[2048])
        {
            DataClassification = ToBeClassified;
        }
        field(50050; "CashBook Naration"; Text[2048])
        {
            DataClassification = ToBeClassified;
        }
        field(50045; "Responsibility Center Name"; Text[2048])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            Caption = 'Department';
        }
        field(50047; "Bank No Series"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(50044; "Applies To Document No"; Code[50])
        {

            TableRelation = "Purchase Header"."No." where(Status = filter(Released), "AU Form Type" = filter('Payment Voucher'));

        }
        field(50117; CustomerBalance; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CalcFormula = Sum("Detailed Cust. Ledg. Entry"."Amount (LCY)" WHERE("Customer No." = FIELD("Account No")));
            Caption = 'Balance Due';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50048; "Total Cash Refund"; Decimal)
        {
            CalcFormula = sum("Purchase Line"."Cash Refund" where("Document Type" = field("Document Type"),
                                                                 "Document No." = field("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50049; "Total Amount Spent"; Decimal)
        {
            CalcFormula = sum("Purchase Line"."Amount Spent" where("Document Type" = field("Document Type"),
                                                                       "Document No." = field("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50051; "Send For Approval By"; Text[2048])
        {
            DataClassification = ToBeClassified;
        }
        field(50052; "Date Send For Approval"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(50055; "LPO Awarded"; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50056; "LPO Not Awarded"; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50057; "Amount Posted"; Decimal)
        {
            CalcFormula = sum("G/L Entry"."Debit Amount" where("External Document No." = field("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50058; "Amount Posted to Bank"; Decimal)
        {
            CalcFormula = sum("Bank Account Ledger Entry".Amount where("Document No." = field("Bank No Series")
                                                                              ));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50059; Rejected; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50060; "Bank No Series Inserted"; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50061; "Total Disbursed Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50062; Cleardates; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = true;
        }
        field(50063; "Responsible Officer"; Text[100])
        {
            DataClassification = ToBeClassified;
            Editable = true;
        }
        field(50064; "Procurement Type Code"; Text[100])
        {
            DataClassification = ToBeClassified;
            Editable = true;
        }
        field(50065; "Type"; Text[100])
        {
            DataClassification = ToBeClassified;
            Editable = true;
        }
        field(50066; "Requisition No."; Text[100])
        {
            DataClassification = ToBeClassified;
            Editable = true;
        }
        field(50067; "Archive Unused Doc"; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = true;
        }
        field(50068; "Printed"; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = true;
        }
        field(50069; "Cancelled"; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = true;
        }
        field(50070; "Cancelled Date"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = true;
        }
        field(50071; "Cancelled By"; Code[100])
        {
            DataClassification = ToBeClassified;
            Editable = true;
        }
        field(50072; "Narration"; Text[1000])
        {
            DataClassification = ToBeClassified;
            Editable = true;
        }

        //Printed
        //"Archive Unused Doc"

    }



    var
        Text003: label 'You cannot rename a %1.';
        ConfirmChangeQst: label 'Do you want to change %1?', Comment = '%1 = a Field Caption like Currency Code';
        Text005: label 'You cannot reset %1 because the document still has one or more lines.';
        YouCannotChangeFieldErr: label 'You cannot change %1 because the order is associated with one or more sales orders.', Comment = '%1 - fieldcaption';
        Text007: label '%1 is greater than %2 in the %3 table.\';
        Text008: label 'Confirm change?';
        Text009: label 'Deleting this document will cause a gap in the number series for receipts. An empty receipt %1 will be created to fill this gap in the number series.\\Do you want to continue?', Comment = '%1 = Document No.';
        Text012: label 'Deleting this document will cause a gap in the number series for posted invoices. An empty posted invoice %1 will be created to fill this gap in the number series.\\Do you want to continue?', Comment = '%1 = Document No.';
        Text014: label 'Deleting this document will cause a gap in the number series for posted credit memos. An empty posted credit memo %1 will be created to fill this gap in the number series.\\Do you want to continue?', Comment = '%1 = Document No.';
        RecreatePurchLinesMsg: label 'If you change %1, the existing purchase lines will be deleted and new purchase lines based on the new information in the header will be created.\\Do you want to continue?', Comment = '%1: FieldCaption';
        ResetItemChargeAssignMsg: label 'If you change %1, the existing purchase lines will be deleted and new purchase lines based on the new information in the header will be created.\The amount of the item charge assignment will be reset to 0.\\Do you want to continue?', Comment = '%1: FieldCaption';
        Text018: label 'You must delete the existing purchase lines before you can change %1.';
        LinesNotUpdatedMsg: label 'You have changed %1 on the purchase header, but it has not been changed on the existing purchase lines.', Comment = 'You have changed Posting Date on the purchase header, but it has not been changed on the existing purchase lines.';
        Text020: label 'You must update the existing purchase lines manually.';
        AffectExchangeRateMsg: label 'The change may affect the exchange rate that is used for price calculation on the purchase lines.';
        Text022: label 'Do you want to update the exchange rate?';
        Text023: label 'You cannot delete this document. Your identification is set up to process from %1 %2 only.';
        Text025: label 'You have modified the %1 field. Note that the recalculation of VAT may cause penny differences, so you must check the amounts afterwards. ';
        Text027: label 'Do you want to update the %2 field on the lines to reflect the new value of %1?';
        Text028: label 'Your identification is set up to process from %1 %2 only.';
        Text029: label 'Deleting this document will cause a gap in the number series for return shipments. An empty return shipment %1 will be created to fill this gap in the number series.\\Do you want to continue?', Comment = '%1 = Document No.';
        Text032: label 'You have modified %1.\\Do you want to update the lines?', Comment = 'You have modified Currency Factor.\\Do you want to update the lines?';
        PurchSetup: Record "Purchases & Payables Setup";
        GLSetup: Record "General Ledger Setup";
        GLAcc: Record "G/L Account";
        PurchLine: Record "Purchase Line";
        xPurchLine: Record "Purchase Line";
        VendLedgEntry: Record "Vendor Ledger Entry";
        Vend: Record Vendor;
        PaymentTerms: Record "Payment Terms";
        PaymentMethod: Record "Payment Method";
        CurrExchRate: Record "Currency Exchange Rate";
        PurchHeader: Record "Purchase Header";
        PurchCommentLine: Record "Purch. Comment Line";
        Cust: Record Customer;
        CompanyInfo: Record "Company Information";
        PostCode: Record "Post Code";
        OrderAddr: Record "Order Address";
        BankAcc: Record "Bank Account";
        PurchRcptHeader: Record "Purch. Rcpt. Header";
        PurchInvHeader: Record "Purch. Inv. Header";
        PurchCrMemoHeader: Record "Purch. Cr. Memo Hdr.";
        ReturnShptHeader: Record "Return Shipment Header";
        PurchInvHeaderPrepmt: Record "Purch. Inv. Header";
        PurchCrMemoHeaderPrepmt: Record "Purch. Cr. Memo Hdr.";
        GenBusPostingGrp: Record "Gen. Business Posting Group";
        RespCenter: Record "Responsibility Center";
        Location: Record Location;
        WhseRequest: Record "Warehouse Request";
        InvtSetup: Record "Inventory Setup";
        SalespersonPurchaser: Record "Salesperson/Purchaser";
        NoSeriesMgt: Codeunit "No. Series";
        DimMgt: Codeunit DimensionManagement;
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        UserSetupMgt: Codeunit "User Setup Management";
        LeadTimeMgt: Codeunit "Lead-Time Management";
        PostingSetupMgt: Codeunit PostingSetupManagement;
        CurrencyDate: Date;
        HideValidationDialog: Boolean;
        Confirmed: Boolean;
        Text034: label 'You cannot change the %1 when the %2 has been filled in.';
        Text037: label 'Contact %1 %2 is not related to vendor %3.';
        Text038: label 'Contact %1 %2 is related to a different company than vendor %3.';
        Text039: label 'Contact %1 %2 is not related to a vendor.';
        SkipBuyFromContact: Boolean;
        SkipPayToContact: Boolean;
        Text040: label 'You can not change the %1 field because %2 %3 has %4 = %5 and the %6 has already been assigned %7 %8.';
        Text042: label 'You must cancel the approval process if you wish to change the %1.';
        Text045: label 'Deleting this document will cause a gap in the number series for prepayment invoices. An empty prepayment invoice %1 will be created to fill this gap in the number series.\\Do you want to continue?';
        Text046: label 'Deleting this document will cause a gap in the number series for prepayment credit memos. An empty prepayment credit memo %1 will be created to fill this gap in the number series.\\Do you want to continue?';
        Text049: label '%1 is set up to process from %2 %3 only.';
        Text050: label 'Reservations exist for this order. These reservations will be canceled if a date conflict is caused by this change.\\Do you want to continue?';
        Text051: label 'You may have changed a dimension.\\Do you want to update the lines?';
        Text052: label 'The %1 field on the purchase order %2 must be the same as on sales order %3.';
        UpdateDocumentDate: Boolean;
        PrepaymentInvoicesNotPaidErr: label 'You cannot post the document of type %1 with the number %2 before all related prepayment invoices are posted.', Comment = 'You cannot post the document of type Order with the number 1001 before all related prepayment invoices are posted.';
        Text054: label 'There are unpaid prepayment invoices that are related to the document of type %1 with the number %2.';
        DeferralLineQst: label 'You have changed the %1 on the purchase header, do you want to update the deferral schedules for the lines with this date?', Comment = '%1=The posting date on the document.';
        PostedDocsToPrintCreatedMsg: label 'One or more related posted documents have been generated during deletion to fill gaps in the posting number series. You can view or print the documents from the respective document archive.';
        BuyFromVendorTxt: label 'Buy-from Vendor';
        PayToVendorTxt: label 'Pay-to Vendor';
        DocumentNotPostedClosePageQst: label 'The document has been saved but is not yet posted.\\Are you sure you want to exit?';
        PurchOrderDocTxt: label 'Purchase Order';
        SelectNoSeriesAllowed: Boolean;
        PurchQuoteDocTxt: label 'Purchase Quote';
        MixedDropshipmentErr: label 'You cannot print the purchase order because it contains one or more lines for drop shipment in addition to regular purchase lines.';
        ModifyVendorAddressNotificationLbl: label 'Update the address';
        DontShowAgainActionLbl: label 'Don''t show again';
        ModifyVendorAddressNotificationMsg: label 'The address you entered for %1 is different from the Vendor''s existing address.', Comment = '%1=Vendor name';
        ModifyBuyFromVendorAddressNotificationNameTxt: label 'Update Buy-from Vendor Address';
        ModifyBuyFromVendorAddressNotificationDescriptionTxt: label 'Warn if the Buy-from address on sales documents is different from the Vendor''s existing address.';
        ModifyPayToVendorAddressNotificationNameTxt: label 'Update Pay-to Vendor Address';
        ModifyPayToVendorAddressNotificationDescriptionTxt: label 'Warn if the Pay-to address on sales documents is different from the Vendor''s existing address.';
        PurchaseAlreadyExistsTxt: label 'Purchase %1 %2 already exists for this vendor.', Comment = '%1 = Document Type; %2 = Document No.';
        ShowVendLedgEntryTxt: label 'Show the vendor ledger entry.';
        ShowDocAlreadyExistNotificationNameTxt: label 'Purchase document with same external document number already exists.';
        ShowDocAlreadyExistNotificationDescriptionTxt: label 'Warn if purchase document with same external document number already exists.';
        DuplicatedCaptionsNotAllowedErr: label 'Field captions must not be duplicated when using this method. Use UpdatePurchLinesByFieldNo instead.';
        MissingExchangeRatesQst: label 'There are no exchange rates for currency %1 and date %2. Do you want to add them now? Otherwise, the last change you made will be reverted.', Comment = '%1 - currency code, %2 - posting date';
        SplitMessageTxt: label '%1\%2', Comment = 'Some message text 1.\Some message text 2.';
        StatusCheckSuspended: Boolean;
        RFQ: Record "Purchase Line";
        PurchLine2: Record "Purchase Line";
        LineNo: Integer;
        BankAccount: Record "Bank Account";
        Customer: Record Customer;
        PurchaseHeader2: Record "Purchase Header";
        HREmployees: Record "HR Employees";


}
