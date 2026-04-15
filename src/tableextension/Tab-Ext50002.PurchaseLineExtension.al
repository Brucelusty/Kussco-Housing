tableextension 50002 "PurchaseLineExtension" extends "Purchase Line"
{
    fields
    {

        field(50024; "ShortcutDimCode[3]"; Code[20])
        {
            DataClassification = ToBeClassified;

            CaptionClass = '1,2,3';
            Caption = 'Shortcut Dimension 5 Code';

            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(3),
                                                          Blocked = const(false));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(2, "Shortcut Dimension 2 Code");
            end;

        }
        field(50025; "ShortcutDimCode[4]"; Code[20])
        {
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,4';
            Caption = 'Shortcut Dimension 5 Code';

            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(4),
                                                          Blocked = const(false));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(2, "Shortcut Dimension 2 Code");
            end;
        }
        field(50026; "ShortcutDimCode[5]"; Code[20])
        {
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,5';
            Caption = 'Shortcut Dimension 5 Code';

            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(5),
                                                          Blocked = const(false));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(2, "Shortcut Dimension 2 Code");
            end;
        }
        field(50027; "ShortcutDimCode[6]"; Code[20])
        {
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,6';
            Caption = 'Shortcut Dimension 5 Code';

            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(6),
                                                          Blocked = const(false));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(2, "Shortcut Dimension 2 Code");
            end;
        }
        field(50028; "ShortcutDimCode[7]"; Code[20])
        {
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,7';
            Caption = 'Shortcut Dimension 5 Code';

            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(7),
                                                          Blocked = const(false));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(2, "Shortcut Dimension 2 Code");
            end;
        }
        field(50029; "ShortcutDimCode[8]"; Code[20])
        {
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,8';
            Caption = 'Shortcut Dimension 5 Code';

            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(8),
                                                          Blocked = const(false));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(2, "Shortcut Dimension 2 Code");
            end;
        }
        field(50030; "Amount Spent"; Decimal)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                Rec."Actual Incurred Amount Base Currency" := (Rec."Amount Spent") / (rec."Currency Factor");
            end;
        }
        field(50031; "Cash Refund"; Decimal)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                Rec."Actual Receipt Amount Base Currency" := (Rec."Cash Refund") / (rec."Currency Factor");
            end;
        }
        field(50032; "Cash Refund  Account"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Bank Account";
        }
        field(50033; "Expense Category"; Code[100])
        {
            DataClassification = ToBeClassified;
            //TableRelation = "Standard Text" where (Type=const("GL Category"));

            trigger OnValidate()
            begin
                exp := "Expense Category";
                Type := Type::"G/L Account";
                if StandardText.Get("Expense Category") then
                    // Validate("No.", StandardText."GL Account");

                    "Expense Category" := exp;
            end;
        }
        field(50034; "Line Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = ,Objectives,"Team Roles",Activity,"Budget Info","Budget Notes",Performance,Sections,PersonalQualities,Reflections,CapacityNeeds,ActionPoints;
        }
        field(50035; "No of days"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50036; "No of pax"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50037; Ksh; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                "Total Ksh" := "No of days" * "No of pax" * Ksh;
            end;
        }
        field(50038; "other currency"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                "Total Other Currency" := "No of days" * "No of pax" * "other currency";
            end;
        }
        field(50039; "Total Ksh"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50040; "Total Other Currency"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50041; "Mission Expense Category"; Code[100])
        {
            DataClassification = ToBeClassified;
            //TableRelation = "Standard Text" where(Type = const("GL Category"));
        }
        field(50042; keyResultAreas; Text[200])
        {
            DataClassification = ToBeClassified;
            Description = 'Performance start';
        }
        field(50043; keyActivities; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(50044; performanceMeasures; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(50045; commentsOnAchievedResults; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(50046; target; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50047; actualAchieved; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50048; percentageOfTarget; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50049; rating; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50050; weightingRating; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50051; weighting; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50052; appraisalType; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'Sections start';
            OptionCaption = 'Technical Capacity,Organisation and planning skills,Efficiency and Effectiveness,Communication,Leadership';
            OptionMembers = "Technical Capacity","Organisation and planning skills","Efficiency and Effectiveness",Communication,Leadership;
        }
        field(50053; appraisalDescription; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(50054; staffRating; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50055; supervisorRating; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50056; personalDescription; Text[200])
        {
            DataClassification = ToBeClassified;
            Description = 'Personal Qualities start';
        }
        field(50057; score; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(50058; comments; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(50059; reflectionDescription; Text[200])
        {
            DataClassification = ToBeClassified;
            Description = 'Start refelctions';
        }
        field(50060; selfAppraisal; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(50061; supervisorsFeedback; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(50062; capacity; Text[200])
        {
            DataClassification = ToBeClassified;
            Description = 'Start capacity needs';
        }
        field(50063; completionDate; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50064; capacityNeedsDescription; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(50065; remedialMeasures; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(50066; planning; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(50067; personResponsible; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(50068; agreedActionPoints; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(50069; timelines; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(50070; date; DateTime)
        {
            DataClassification = ToBeClassified;
            Description = '// Activity details';
        }
        field(50071; departureTime; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(50072; departurePlace; Text[60])
        {
            DataClassification = ToBeClassified;
        }
        field(50073; arrivalTime; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(50074; arrivalPlace; Text[60])
        {
            DataClassification = ToBeClassified;
        }
        field(50075; remarks; Text[60])
        {
            DataClassification = ToBeClassified;
        }
        field(50076; dateFrom; Date)
        {
            DataClassification = ToBeClassified;
            Description = 'Accomodation detailld';
        }
        field(50077; dateTo; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50078; accomodtionCatered; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50079; locationOfStay; Text[60])
        {
            DataClassification = ToBeClassified;
        }
        field(50080; noOfNights; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50081; "location."; Text[50])
        {
            DataClassification = ToBeClassified;
            Description = 'MelsAndInc';
        }
        field(50082; noOfDays; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50083; "Travel Line Total"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50084; "Expense Account"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account"."No.";
        }
        field(50085; amountToRefund; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50086; "Withholding Tax Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50087; "Withholding Tax Code"; Code[30])
        {
            DataClassification = ToBeClassified;
            //TableRelation = "Withholding Tax Setup".Code;

        }
        field(50088; "Withholding Tax Rate %"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50089; "Net Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50090; "Remaining Budget Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50091; "Committed Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50092; "Actual Incurred Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50093; Difference; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50094; "Description 3"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50095; "Description 4"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50096; "Description 5"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50097; "Description 6"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50098; "Line Comments"; Text[2048])
        {
            DataClassification = ToBeClassified;
        }
        modify("No.")
        {
            // TableRelation = IF (Type = CONST(Donors),
            //                          "System-Created Entry" = CONST(false)) Customer
            // else
            // if (Type = const(Banks)) "Bank Account"
            // else
            // if (Type = const("Grantee/Subgrantee/Consultants")) Vendor
            // else
            // if (type = const(Imprest)) Customer;

            trigger OnAfterValidate()
            var
                Banks: Record "Bank Account";
                Vendor: Record Vendor;
                Customer: Record Customer;
            begin
                // if (Rec.Type = Rec.Type::Donors) or (Rec.Type = Rec.Type::Imprest) then begin
                //     if Customer.Get("No.") then
                //         Description := Customer.Name
                // end else
                //     if (Rec.Type = Rec.Type::Banks) then begin
                //         if Banks.Get("No.") then
                //             Description := Banks.Name
                //     end else
                //         if Rec.Type = Rec.Type::"Grantee/Subgrantee/Consultants" then begin
                //             if Vendor.Get("No.") then
                //                 Description := Vendor.Name;
                //         end;
            end;
        }
        field(50000; "Consultancy Fee"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50001; "Withholdingg Tax(Consultancy/Professional)"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50002; "Imprest Account No"; Code[20])
        {
            TableRelation = "Customer"."No.";
        }
        field(50003; "Imprest Account Name"; Text[50])
        {

        }
        field(50004; "Budget Speed key"; Code[2000])
        {
            //TableRelation = "Donors Budget Matrix line"."Budget Line No Code";

            trigger OnValidate()
            var
                //DonorBudgetMatrix: Record "Donors Budget Matrix line";
                StandardText: Record "Standard Text";
                GL: Record "G/L Account";
                NewLineNo: Integer;
            begin
                Quantity := 1;
                PurchHeader.Reset();
                PurchHeader.SetRange("No.", "Document No.");
                if PurchHeader.FindFirst() then begin
                    "Currency Code" := PurchHeader."Currency Code";
                end;


                //end;
                //end;
            end;


        }
        field(50005; "Bank Account Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50006; "Bank Account Number"; Text[100])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50007; "Currency Factor"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50008; "Budget Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                PurchaseHeder: Record "Purchase Header";
                CurrencyFactor: Decimal;
            begin
                CurrencyFactor := 0;

                PurchaseHeder.Reset();
                PurchaseHeder.SetRange("No.", Rec."Document No.");
                if PurchaseHeder.FindFirst() then begin
                    CurrencyFactor := PurchaseHeder."Currency Factor";
                end;
                "Foreign Budget Amount" := ROUND(CurrExchRate.ExchangeAmtLCYToFCY(Today, "Currency Code", "Budget Amount", CurrencyFactor));
            end;
        }
        field(50009; "Budget Line description"; Text[2048])
        {
            DataClassification = ToBeClassified;
        }
        field(50010; "Budget Balance"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50011; "Country"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Dimension Code" = filter('COUNTRY')
                                                          );
        }
        field(50012; "Amount In Foreign"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50013; "Gross Amount Subject To Withnolding"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50015; "Budget Line Codes"; Code[1000])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Budget Entry"."Global Dimension 2 Code";
            trigger OnValidate()
            var

                GLBudgetEntry: Record "G/L Budget Entry";
            begin

                if GLBudgetEntry.Get("Shortcut Dimension 2 Code") then
                    "Shortcut Dimension 2 Code" := GLBudgetEntry."Global Dimension 2 Code";
                "Budget Line description" := GLBudgetEntry."Budget Line Description";


            end;
        }
        field(50014; "Account No New"; Code[100])
        {
            // TableRelation = IF (Type = CONST(Donors),
            //                          "System-Created Entry" = CONST(false)) Customer
            // else
            // if (Type = const(Banks)) "Bank Account"
            // else
            // if (Type = const("G/L Account")) "G/L Account"
            // else
            // if (Type = const("Grantee/Subgrantee/Consultants")) Vendor
            // else
            // if (type = const(Imprest)) Customer;

            trigger OnValidate()
            var
                Banks: Record "Bank Account";
                Vendor: Record Vendor;
                Customer: Record Customer;
                COA: Record "G/L Account";
            begin
                // if (Rec.Type = Rec.Type::Donors) or (Rec.Type = Rec.Type::Imprest) then begin
                //     if Customer.Get("Account No New") then
                //         "No." := Customer."No.";
                //     Description := Customer.Name
                // end else
                //     if (Rec.Type = Rec.Type::"G/L Account") then begin
                //         if COA.Get("Account No New") then
                //             "No." := COA."No.";
                //         Description := COA.Name
                //     end else
                //         if (Rec.Type = Rec.Type::Banks) then begin
                //             if Banks.Get("Account No New") then
                //                 "No." := Banks."No.";
                //             Description := Banks.Name
                //         end else

                //             if Rec.Type = Rec.Type::"Grantee/Subgrantee/Consultants" then begin
                //                 if Vendor.Get("Account No New") then
                //                     "No." := Vendor."No.";
                //                 Description := Vendor.Name;
                //             end;
            end;
        }
        field(50016; "Type New"; Enum "Purchase Line Type")
        {
            trigger OnValidate()
            var
                Banks: Record "Bank Account";
                Vendor: Record Vendor;
                Customer: Record Customer;
                COA: Record "G/L Account";
            begin
                // if (Rec."Type New" = Rec."Type New"::Donors) then begin
                //     Rec.Type := Rec.Type::Donors;
                // end else
                //     if (Rec."Type New" = Rec."Type New"::Imprest) then begin
                //         Rec.Type := Rec.Type::Imprest;
                //     end else
                //         if (Rec."Type New" = Rec."Type New"::"G/L Account") then begin
                //             Rec.Type := Rec.Type::"G/L Account";
                //         end else
                //             if (Rec."Type New" = Rec."Type New"::Banks) then begin
                //                 Rec.Type := Rec.Type::Banks;
                //             end else
                //                 if (Rec."Type New" = Rec."Type New"::"Fixed Asset") then begin
                //                     Rec.Type := Rec.Type::"Fixed Asset";
                //                 end else
                //                     if (Rec."Type New" = Rec."Type New"::"Grantee/Subgrantee/Consultants") then begin
                //                         Rec.Type := Rec.Type::"Grantee/Subgrantee/Consultants";
                //                     end else
                //                         if (Rec."Type New" = Rec."Type New"::Item) then begin
                //                             Rec.Type := Rec.Type::Item;
                //                         end else
                //                             if (Rec.Type = Rec.Type::" ") then begin
                //                                 Rec.Type := Rec.Type::" ";
                //                             end;
            end;
        }
        field(50017; "Foreign Budget Amount"; Decimal)
        {
            Editable = false;
        }
        field(50018; "Actual Incurred Amount Base Currency"; Decimal)
        {
            Editable = false;
        }
        field(50019; "Actual Receipt Amount Base Currency"; Decimal)
        {
            Editable = false;
        }
        field(50020; "Debit Amount"; Decimal)
        {

        }
        field(50021; "Credit Amount"; Decimal)
        {

        }
        field(50022; "Account Type"; Enum "Gen. Journal Account Type")
        {
            trigger OnValidate()
            var
                Banks: Record "Bank Account";
                Vendor: Record Vendor;
                Customer: Record Customer;
                COA: Record "G/L Account";
            begin
                // if (Rec."Account Type" = Rec."Account Type"::Customer) then begin
                //     Rec.Type := Rec.Type::Donors;
                // end else
                //     if (Rec."Account Type" = Rec."Account Type"::"G/L Account") then begin
                //         Rec.Type := Rec.Type::"G/L Account";
                //     end else



                //         if (Rec."Account Type" = Rec."Account Type"::"Bank Account") then begin
                //             Rec.Type := Rec.Type::Banks;
                //         end;
            end;
        }
        field(50023; Committed; Boolean)
        {

        }
        //Committed
        modify("Direct Unit Cost")
        {
            Caption = 'Amount';
            CaptionClass = 'Amount';
        }

    }



    var
        Text000: label 'You cannot rename a %1.';
        Text001: label 'You cannot change %1 because the order line is associated with sales order %2.';
        Text002: label 'Prices including VAT cannot be calculated when %1 is %2.';
        Text003: label 'You cannot purchase resources.';
        Text004: label 'must not be less than %1';
        Text006: label 'You cannot invoice more than %1 units.';
        Text007: label 'You cannot invoice more than %1 base units.';
        Text008: label 'You cannot receive more than %1 units.';
        Text009: label 'You cannot receive more than %1 base units.';
        Text010: label 'You cannot change %1 when %2 is %3.';
        Text011: label ' must be 0 when %1 is %2';
        Text012: label 'must not be specified when %1 = %2';
        Text016: label '%1 is required for %2 = %3.';
        Text017: label '\The entered information may be disregarded by warehouse operations.';
        Text018: label '%1 %2 is earlier than the work date %3.';
        Text020: label 'You cannot return more than %1 units.';
        Text021: label 'You cannot return more than %1 base units.';
        Text022: label 'You cannot change %1, if item charge is already posted.';
        Text023: label 'You cannot change the %1 when the %2 has been filled in.';
        Text029: label 'must be positive.';
        Text030: label 'must be negative.';
        Text031: label 'You cannot define item tracking on this line because it is linked to production order %1.';
        Text032: label '%1 must not be greater than the sum of %2 and %3.';
        Text033: label 'Warehouse ';
        Text034: label 'Inventory ';
        Text035: label '%1 units for %2 %3 have already been returned or transferred. Therefore, only %4 units can be returned.';
        Text037: label 'cannot be %1.';
        Text038: label 'cannot be less than %1.';
        Text039: label 'cannot be more than %1.';
        Text040: label 'You must use form %1 to enter %2, if item tracking is used.';
        ItemChargeAssignmentErr: label 'You can only assign Item Charges for Line Types of Charge (Item).';
        Text99000000: label 'You cannot change %1 when the purchase order is associated to a production order.';
        PurchHeader: Record "Purchase Header";
        PurchLine2: Record "Purchase Line";
        GLAcc: Record "G/L Account";
        Currency: Record Currency;
        CurrExchRate: Record "Currency Exchange Rate";
        VATPostingSetup: Record "VAT Posting Setup";
        GenBusPostingGrp: Record "Gen. Business Posting Group";
        GenProdPostingGrp: Record "Gen. Product Posting Group";
        UnitOfMeasure: Record "Unit of Measure";
        ItemCharge: Record "Item Charge";
        SKU: Record "Stockkeeping Unit";
        //WithholdingTaxSetup: Record "Withholding Tax Setup";
        WorkCenter: Record "Work Center";
        InvtSetup: Record "Inventory Setup";
        Location: Record Location;
        GLSetup: Record "General Ledger Setup";
        CalChange: Record "Customized Calendar Change";
        TempJobJnlLine: Record "Job Journal Line" temporary;
        PurchSetup: Record "Purchases & Payables Setup";
        SalesTaxCalculate: Codeunit "Sales Tax Calculate";
        ReservEngineMgt: Codeunit "Reservation Engine Mgt.";
        ReservePurchLine: Codeunit "Purch. Line-Reserve";
        UOMMgt: Codeunit "Unit of Measure Management";
        AddOnIntegrMgt: Codeunit AddOnIntegrManagement;
        DimMgt: Codeunit DimensionManagement;
        DistIntegration: Codeunit "Dist. Integration";
        CatalogItemMgt: Codeunit "Catalog Item Management";
        WhseValidateSourceLine: Codeunit "Whse. Validate Source Line";
        LeadTimeMgt: Codeunit "Lead-Time Management";
        //PurchPriceCalcMgt: Codeunit "Purch. Price Calc. Mgt.";
        CalendarMgmt: Codeunit "Calendar Management";
        CheckDateConflict: Codeunit "Reservation-Check Date Confl.";
        DeferralUtilities: Codeunit "Deferral Utilities";
        PostingSetupMgt: Codeunit PostingSetupManagement;
        TrackingBlocked: Boolean;
        StatusCheckSuspended: Boolean;
        GLSetupRead: Boolean;
        UnitCostCurrency: Decimal;
        UpdateFromVAT: Boolean;
        Text042: label 'You cannot return more than the %1 units that you have received for %2 %3.';
        Text043: label 'must be positive when %1 is not 0.';
        Text044: label 'You cannot change %1 because this purchase order is associated with %2 %3.';
        Text046: label '%3 will not update %1 when changing %2 because a prepayment invoice has been posted. Do you want to continue?', Comment = '%1 - product name';
        Text047: label '%1 can only be set when %2 is set.';
        Text048: label '%1 cannot be changed when %2 is set.';
        PrePaymentLineAmountEntered: Boolean;
        Text049: label 'You have changed one or more dimensions on the %1, which is already shipped. When you post the line with the changed dimension to General Ledger, amounts on the Inventory Interim account will be out of balance when reported per dimension.\\Do you want to keep the changed dimension?';
        Text050: label 'Cancelled.';
        Text051: label 'must have the same sign as the receipt';
        Text052: label 'The quantity that you are trying to invoice is greater than the quantity in receipt %1.';
        Text053: label 'must have the same sign as the return shipment';
        Text054: label 'The quantity that you are trying to invoice is greater than the quantity in return shipment %1.';
        AnotherItemWithSameDescrQst: label 'Item No. %1 also has the description "%2".\Do you want to change the current item no. to %1?', Comment = '%1=Item no., %2=item description';
        AnotherChargeItemWithSameDescQst: label 'Item charge No. %1 also has the description "%2".\Do you want to change the current item charge no. to %1?', Comment = '%1=Item charge no., %2=item charge description';
        PurchSetupRead: Boolean;
        CannotFindDescErr: label 'Cannot find %1 with Description %2.\\Make sure to use the correct type.', Comment = '%1 = Type caption %2 = Description';
        CommentLbl: label 'Comment';
        LineDiscountPctErr: label 'The value in the Line Discount % field must be between 0 and 100.';
        PurchasingBlockedErr: label 'You cannot purchase this item because the Purchasing Blocked check box is selected on the item card.';
        CannotChangePrepaidServiceChargeErr: label 'You cannot change the line because it will affect service charges that are already invoiced as part of a prepayment.';
        StandardText: Record "Standard Text";
        exp: Code[100];


}

