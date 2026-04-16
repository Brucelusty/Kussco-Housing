table 65731 Biodata
{
    Caption = 'Biodata';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            OptimizeForTextSearch = true;
            ToolTip = 'Specifies the number of the customer. The field is either filled automatically from a defined number series, or you enter the number manually because you have enabled manual number entry in the number-series setup.';


        }
        field(2; Name; Text[100])
        {
            Caption = 'Name';
            OptimizeForTextSearch = true;
            ToolTip = 'Specifies the customer''s name that appears on all related documents. For companies, specify the company''s name here, and then add the relevant people as contacts that you link to this customer.';

        }
        field(3; "Search Name"; Code[100])
        {
            Caption = 'Search Name';
            OptimizeForTextSearch = true;
            ToolTip = 'Specifies an alternate name that you can use to search for a customer.';
        }
        field(4; "Name 2"; Text[50])
        {
            Caption = 'Name 2';
            OptimizeForTextSearch = true;
            ToolTip = 'Specifies an additional part of the name.';
        }
        field(5; Address; Text[100])
        {
            Caption = 'Address';
            OptimizeForTextSearch = true;
            ToolTip = 'Specifies the customer''s address. This address will appear on all sales documents for the customer.';
        }
        field(6; "Address 2"; Text[50])
        {
            Caption = 'Address 2';
            OptimizeForTextSearch = true;
            ToolTip = 'Specifies additional address information.';
        }
        field(7; City; Text[30])
        {
            Caption = 'City';
            OptimizeForTextSearch = true;
            TableRelation = if ("Country/Region Code" = const('')) "Post Code".City
            else
            if ("Country/Region Code" = filter(<> '')) "Post Code".City where("Country/Region Code" = field("Country/Region Code"));
            ValidateTableRelation = false;
            ToolTip = 'Specifies the customer''s city.';


        }
        field(8; Contact; Text[100])
        {
            Caption = 'Contact';
            OptimizeForTextSearch = true;
            ToolTip = 'Specifies the name of the person you regularly contact when you do business with this customer.';


        }
        field(9; "Phone No."; Text[30])
        {
            Caption = 'Phone No.';
            OptimizeForTextSearch = true;
            ExtendedDatatype = PhoneNo;
            ToolTip = 'Specifies the customer''s telephone number.';


        }
        field(10; "Telex No."; Text[20])
        {
            Caption = 'Telex No.';
            OptimizeForTextSearch = true;
        }
        field(11; "Document Sending Profile"; Code[20])
        {
            Caption = 'Document Sending Profile';
            TableRelation = "Document Sending Profile".Code;
            ToolTip = 'Specifies the preferred method of sending documents to this customer, so that you do not have to select a sending option every time that you post and send a document to the customer. Sales documents to this customer will be sent using the specified sending profile and will override the default document sending profile.';
        }
        field(12; "Ship-to Code"; Code[10])
        {
            Caption = 'Ship-to Code';
            TableRelation = "Ship-to Address".Code where("Customer No." = field("No."));
            ToolTip = 'Specifies the code for another shipment address than the customer''s own address, which is entered by default.';
        }
        field(14; "Our Account No."; Text[20])
        {
            Caption = 'Our Account No.';
            OptimizeForTextSearch = true;
        }
        field(15; "Territory Code"; Code[10])
        {
            Caption = 'Territory Code';
            TableRelation = Territory;
        }
        field(16; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1),
                                                          Blocked = const(false));


        }
        field(17; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2),
                                                          Blocked = const(false));


        }
        field(18; "Chain Name"; Code[10])
        {
            Caption = 'Chain Name';
        }
        field(19; "Budgeted Amount"; Decimal)
        {
            AutoFormatExpression = Rec."Currency Code";
            AutoFormatType = 1;
            Caption = 'Budgeted Amount';
        }
        field(20; "Credit Limit (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Credit Limit (LCY)';
            Tooltip = 'Specifies the maximum amount of credit that you extend to the customer for their purchases before you issue warnings. The value 0 represents unlimited credit.';
        }
        field(21; "Customer Posting Group"; Code[20])
        {
            Caption = 'Customer Posting Group';
            TableRelation = "Customer Posting Group";
            ToolTip = 'Specifies the customer''s market type to link business transactions to.';
        }
        field(22; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            TableRelation = Currency;
            ToolTip = 'Specifies the default currency for the customer.';


        }
        field(23; "Customer Price Group"; Code[10])
        {
            Caption = 'Customer Price Group';
            TableRelation = "Customer Price Group";
            ToolTip = 'Specifies the customer price group code, which you can use to set up special sales prices in the Sales Prices window.';
        }
        field(24; "Language Code"; Code[10])
        {
            Caption = 'Language Code';
            TableRelation = Language;
            ToolTip = 'Specifies the language that is used when translating specified text on documents to foreign business partner, such as an item description on an order confirmation.';


        }
        field(25; "Registration Number"; Text[50])
        {
            Caption = 'Registration No.';
            OptimizeForTextSearch = true;
            ToolTip = 'Specifies the registration number of the customer. You can enter a maximum of 20 characters, both numbers and letters.';


        }
        field(26; "Statistics Group"; Integer)
        {
            Caption = 'Statistics Group';
            ToolTip = 'Specifies the statistics group.';
        }
        field(27; "Payment Terms Code"; Code[10])
        {
            Caption = 'Payment Terms Code';
            TableRelation = "Payment Terms";
            ToolTip = 'Specifies a code that indicates the payment terms that you require of the customer.';


        }
        field(28; "Fin. Charge Terms Code"; Code[10])
        {
            Caption = 'Fin. Charge Terms Code';
            TableRelation = "Finance Charge Terms";
            ToolTip = 'Specifies the code for the involved finance charges in case of late payment.';
        }
        field(29; "Salesperson Code"; Code[20])
        {
            Caption = 'Salesperson Code';
            TableRelation = "Salesperson/Purchaser" where(Blocked = const(false));
            ToolTip = 'Specifies a code for the salesperson who normally handles this customer''s account.';


        }
        field(30; "Shipment Method Code"; Code[10])
        {
            Caption = 'Shipment Method Code';
            TableRelation = "Shipment Method";
            ToolTip = 'Specifies which shipment method to use when you ship items to the customer.';


        }
        field(31; "Shipping Agent Code"; Code[10])
        {
            AccessByPermission = TableData "Shipping Agent Services" = R;
            Caption = 'Shipping Agent Code';
            TableRelation = "Shipping Agent";
            ToolTip = 'Specifies which shipping company is used when you ship items to the customer.';

            trigger OnValidate()
            begin
                if "Shipping Agent Code" <> xRec."Shipping Agent Code" then
                    Validate("Shipping Agent Service Code", '');
            end;
        }
        field(32; "Place of Export"; Code[20])
        {
            Caption = 'Place of Export';
        }
        field(33; "Invoice Disc. Code"; Code[20])
        {
            Caption = 'Invoice Disc. Code';
            TableRelation = Customer;
            ValidateTableRelation = false;
            ToolTip = 'Specifies a code for the invoice discount terms that you have defined for the customer.';
        }
        field(34; "Customer Disc. Group"; Code[20])
        {
            Caption = 'Customer Disc. Group';
            TableRelation = "Customer Discount Group";
            ToolTip = 'Specifies the customer discount group code, which you can use as a criterion to set up special discounts in the Sales Line Discounts window.';
        }
        field(35; "Country/Region Code"; Code[10])
        {
            Caption = 'Country/Region Code';
            TableRelation = "Country/Region";
            ToolTip = 'Specifies the country/region of the address.';


        }
        field(36; "Collection Method"; Code[20])
        {
            Caption = 'Collection Method';
        }
        field(37; Amount; Decimal)
        {
            AutoFormatExpression = Rec."Currency Code";
            AutoFormatType = 1;
            Caption = 'Amount';
        }
        field(38; Comment; Boolean)
        {
            CalcFormula = exist("Comment Line" where("Table Name" = const(Customer),
                                                      "No." = field("No.")));
            Caption = 'Comment';
            Editable = false;
            FieldClass = FlowField;
        }
        field(39; Blocked; Enum "Customer Blocked")
        {
            Caption = 'Blocked';
            ToolTip = 'Specifies which transactions with the customer that cannot be processed, for example, because the customer is insolvent.';


        }
#if not CLEANSCHEMA30
        field(40; "Invoice Copies"; Integer)
        {
            Caption = 'Invoice Copies';
            ObsoleteReason = 'This field is not used consequently and hence does not work as expected. It should be retired.';
#if not CLEAN27
            ObsoleteState = Pending;
            ObsoleteTag = '27.0';
#else
            ObsoleteState = Removed;
            ObsoleteTag = '30.0';
#endif
        }
#endif
        field(41; "Last Statement No."; Integer)
        {
            Caption = 'Last Statement No.';
            ToolTip = 'Specifies the number of the last statement that was printed for this customer.';
        }
        field(42; "Print Statements"; Boolean)
        {
            Caption = 'Print Statements';
            ToolTip = 'Specifies whether to include this customer when you print the Statement report.';
        }
        field(45; "Bill-to Customer No."; Code[20])
        {
            Caption = 'Bill-to Customer No.';
            TableRelation = Customer;
            ToolTip = 'Specifies a different customer who will be invoiced for products that you sell to the customer in the Name field on the customer card.';
            OptimizeForTextSearch = true;
        }
        field(46; Priority; Integer)
        {
            Caption = 'Priority';
            ToolTip = 'Specifies a number that corresponds to the priority you give the customer. The higher the number, the higher the priority.';
        }
        field(47; "Payment Method Code"; Code[10])
        {
            Caption = 'Payment Method Code';
            TableRelation = "Payment Method";
            ToolTip = 'Specifies how the customer usually submits payment, such as bank transfer or check.';


        }
        field(48; "Format Region"; Text[80])
        {
            Caption = 'Format Region';
            OptimizeForTextSearch = true;
            TableRelation = "Language Selection"."Language Tag";
            ToolTip = 'Specifies the Format Region to be used on printouts for this customer.';
        }
#pragma warning disable AA0232
        field(52; "First Transaction Date"; Date)
        {
            Caption = 'Customer Since';
            ToolTip = 'Specifies the date of the first transaction with the customer.';
            FieldClass = FlowField;
            CalcFormula = min("Cust. Ledger Entry"."Posting Date" where("Customer No." = field("No.")));
        }
#pragma warning restore AA0232
        field(53; "Last Modified Date Time"; DateTime)
        {
            Caption = 'Last Modified Date Time';
            Editable = false;
        }
        field(54; "Last Date Modified"; Date)
        {
            Caption = 'Last Date Modified';
            Editable = false;
            ToolTip = 'Specifies when the customer card was last modified.';
        }
        field(55; "Date Filter"; Date)
        {
            Caption = 'Date Filter';
            FieldClass = FlowFilter;
        }
        field(56; "Global Dimension 1 Filter"; Code[20])
        {
            CaptionClass = '1,3,1';
            Caption = 'Global Dimension 1 Filter';
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(57; "Global Dimension 2 Filter"; Code[20])
        {
            CaptionClass = '1,3,2';
            Caption = 'Global Dimension 2 Filter';
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(58; Balance; Decimal)
        {
            AutoFormatExpression = Rec."Currency Code";
            AutoFormatType = 1;
            CalcFormula = sum("Detailed Cust. Ledg. Entry".Amount where("Customer No." = field("No."),
                                                                         "Initial Entry Global Dim. 1" = field("Global Dimension 1 Filter"),
                                                                         "Initial Entry Global Dim. 2" = field("Global Dimension 2 Filter"),
                                                                         "Currency Code" = field("Currency Filter")));
            Caption = 'Balance';
            Editable = false;
            FieldClass = FlowField;
        }
        field(59; "Balance (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = sum("Detailed Cust. Ledg. Entry"."Amount (LCY)" where("Customer No." = field("No."),
                                                                                 "Initial Entry Global Dim. 1" = field("Global Dimension 1 Filter"),
                                                                                 "Initial Entry Global Dim. 2" = field("Global Dimension 2 Filter"),
                                                                                 "Currency Code" = field("Currency Filter")));
            Caption = 'Balance (LCY)';
            Editable = false;
            FieldClass = FlowField;
            ToolTip = 'Specifies the payment amount that the customer owes for completed sales. This value is also known as the customer''s balance.';
        }
        field(60; "Net Change"; Decimal)
        {
            AutoFormatExpression = Rec."Currency Code";
            AutoFormatType = 1;
            CalcFormula = sum("Detailed Cust. Ledg. Entry".Amount where("Customer No." = field("No."),
                                                                         "Initial Entry Global Dim. 1" = field("Global Dimension 1 Filter"),
                                                                         "Initial Entry Global Dim. 2" = field("Global Dimension 2 Filter"),
                                                                         "Posting Date" = field("Date Filter"),
                                                                         "Currency Code" = field("Currency Filter")));
            Caption = 'Net Change';
            Editable = false;
            FieldClass = FlowField;
        }
        field(61; "Net Change (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = sum("Detailed Cust. Ledg. Entry"."Amount (LCY)" where("Customer No." = field("No."),
                                                                                 "Initial Entry Global Dim. 1" = field("Global Dimension 1 Filter"),
                                                                                 "Initial Entry Global Dim. 2" = field("Global Dimension 2 Filter"),
                                                                                 "Posting Date" = field("Date Filter"),
                                                                                 "Currency Code" = field("Currency Filter")));
            Caption = 'Net Change (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(62; "Sales (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = sum("Cust. Ledger Entry"."Sales (LCY)" where("Customer No." = field("No."),
                                                                        "Global Dimension 1 Code" = field("Global Dimension 1 Filter"),
                                                                        "Global Dimension 2 Code" = field("Global Dimension 2 Filter"),
                                                                        "Posting Date" = field("Date Filter"),
                                                                        "Currency Code" = field("Currency Filter")));
            Caption = 'Sales (LCY)';
            Editable = false;
            FieldClass = FlowField;
            ToolTip = 'Specifies the total net amount of sales to the customer in LCY.';
        }
        field(63; "Profit (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = sum("Cust. Ledger Entry"."Profit (LCY)" where("Customer No." = field("No."),
                                                                         "Global Dimension 1 Code" = field("Global Dimension 1 Filter"),
                                                                         "Global Dimension 2 Code" = field("Global Dimension 2 Filter"),
                                                                         "Posting Date" = field("Date Filter"),
                                                                         "Currency Code" = field("Currency Filter")));
            Caption = 'Profit (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(64; "Inv. Discounts (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = sum("Cust. Ledger Entry"."Inv. Discount (LCY)" where("Customer No." = field("No."),
                                                                                "Global Dimension 1 Code" = field("Global Dimension 1 Filter"),
                                                                                "Global Dimension 2 Code" = field("Global Dimension 2 Filter"),
                                                                                "Posting Date" = field("Date Filter"),
                                                                                "Currency Code" = field("Currency Filter")));
            Caption = 'Inv. Discounts (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(65; "Pmt. Discounts (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = - sum("Detailed Cust. Ledg. Entry"."Amount (LCY)" where("Customer No." = field("No."),
                                                                                  "Entry Type" = filter("Payment Discount" .. "Payment Discount (VAT Adjustment)"),
                                                                                  "Initial Entry Global Dim. 1" = field("Global Dimension 1 Filter"),
                                                                                  "Initial Entry Global Dim. 2" = field("Global Dimension 2 Filter"),
                                                                                  "Posting Date" = field("Date Filter"),
                                                                                  "Currency Code" = field("Currency Filter")));
            Caption = 'Pmt. Discounts (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(66; "Balance Due"; Decimal)
        {
            AutoFormatExpression = Rec."Currency Code";
            AutoFormatType = 1;
            CalcFormula = sum("Detailed Cust. Ledg. Entry".Amount where("Customer No." = field("No."),
                                                                         "Initial Entry Due Date" = field(upperlimit("Date Filter")),
                                                                         "Initial Entry Global Dim. 1" = field("Global Dimension 1 Filter"),
                                                                         "Initial Entry Global Dim. 2" = field("Global Dimension 2 Filter"),
                                                                         "Currency Code" = field("Currency Filter")));
            Caption = 'Balance Due';
            Editable = false;
            FieldClass = FlowField;
        }
        field(67; "Balance Due (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = sum("Detailed Cust. Ledg. Entry"."Amount (LCY)" where("Customer No." = field("No."),
                                                                                 "Initial Entry Due Date" = field(upperlimit("Date Filter")),
                                                                                 "Initial Entry Global Dim. 1" = field("Global Dimension 1 Filter"),
                                                                                 "Initial Entry Global Dim. 2" = field("Global Dimension 2 Filter"),
                                                                                 "Currency Code" = field("Currency Filter")));
            Caption = 'Balance Due (LCY)';
            Editable = false;
            FieldClass = FlowField;
            ToolTip = 'Specifies payments from the customer that are overdue per today''s date.';
        }
        field(69; Payments; Decimal)
        {
            AutoFormatExpression = Rec."Currency Code";
            AutoFormatType = 1;
            CalcFormula = - sum("Detailed Cust. Ledg. Entry".Amount where("Initial Document Type" = const(Payment),
                                                                          "Entry Type" = const("Initial Entry"),
                                                                          "Customer No." = field("No."),
                                                                          "Initial Entry Global Dim. 1" = field("Global Dimension 1 Filter"),
                                                                          "Initial Entry Global Dim. 2" = field("Global Dimension 2 Filter"),
                                                                          "Posting Date" = field("Date Filter"),
                                                                          "Currency Code" = field("Currency Filter")));
            Caption = 'Payments';
            Editable = false;
            FieldClass = FlowField;
        }
        field(70; "Invoice Amounts"; Decimal)
        {
            AutoFormatExpression = Rec."Currency Code";
            AutoFormatType = 1;
            CalcFormula = sum("Detailed Cust. Ledg. Entry".Amount where("Initial Document Type" = const(Invoice),
                                                                         "Entry Type" = const("Initial Entry"),
                                                                         "Customer No." = field("No."),
                                                                         "Initial Entry Global Dim. 1" = field("Global Dimension 1 Filter"),
                                                                         "Initial Entry Global Dim. 2" = field("Global Dimension 2 Filter"),
                                                                         "Posting Date" = field("Date Filter"),
                                                                         "Currency Code" = field("Currency Filter")));
            Caption = 'Invoice Amounts';
            Editable = false;
            FieldClass = FlowField;
        }
        field(71; "Cr. Memo Amounts"; Decimal)
        {
            AutoFormatExpression = Rec."Currency Code";
            AutoFormatType = 1;
            CalcFormula = - sum("Detailed Cust. Ledg. Entry".Amount where("Initial Document Type" = const("Credit Memo"),
                                                                          "Entry Type" = const("Initial Entry"),
                                                                          "Customer No." = field("No."),
                                                                          "Initial Entry Global Dim. 1" = field("Global Dimension 1 Filter"),
                                                                          "Initial Entry Global Dim. 2" = field("Global Dimension 2 Filter"),
                                                                          "Posting Date" = field("Date Filter"),
                                                                          "Currency Code" = field("Currency Filter")));
            Caption = 'Cr. Memo Amounts';
            Editable = false;
            FieldClass = FlowField;
        }
        field(72; "Finance Charge Memo Amounts"; Decimal)
        {
            AutoFormatExpression = Rec."Currency Code";
            AutoFormatType = 1;
            CalcFormula = sum("Detailed Cust. Ledg. Entry".Amount where("Initial Document Type" = const("Finance Charge Memo"),
                                                                         "Entry Type" = const("Initial Entry"),
                                                                         "Customer No." = field("No."),
                                                                         "Initial Entry Global Dim. 1" = field("Global Dimension 1 Filter"),
                                                                         "Initial Entry Global Dim. 2" = field("Global Dimension 2 Filter"),
                                                                         "Posting Date" = field("Date Filter"),
                                                                         "Currency Code" = field("Currency Filter")));
            Caption = 'Finance Charge Memo Amounts';
            Editable = false;
            FieldClass = FlowField;
        }
        field(74; "Payments (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = - sum("Detailed Cust. Ledg. Entry"."Amount (LCY)" where("Initial Document Type" = const(Payment),
                                                                                  "Entry Type" = const("Initial Entry"),
                                                                                  "Customer No." = field("No."),
                                                                                  "Initial Entry Global Dim. 1" = field("Global Dimension 1 Filter"),
                                                                                  "Initial Entry Global Dim. 2" = field("Global Dimension 2 Filter"),
                                                                                  "Posting Date" = field("Date Filter"),
                                                                                  "Currency Code" = field("Currency Filter")));
            Caption = 'Payments (LCY)';
            Editable = false;
            FieldClass = FlowField;
            ToolTip = 'Specifies the sum of payments received from the customer.';
        }
        field(75; "Inv. Amounts (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = sum("Detailed Cust. Ledg. Entry"."Amount (LCY)" where("Initial Document Type" = const(Invoice),
                                                                                 "Entry Type" = const("Initial Entry"),
                                                                                 "Customer No." = field("No."),
                                                                                 "Initial Entry Global Dim. 1" = field("Global Dimension 1 Filter"),
                                                                                 "Initial Entry Global Dim. 2" = field("Global Dimension 2 Filter"),
                                                                                 "Posting Date" = field("Date Filter"),
                                                                                 "Currency Code" = field("Currency Filter")));
            Caption = 'Inv. Amounts (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(76; "Cr. Memo Amounts (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = - sum("Detailed Cust. Ledg. Entry"."Amount (LCY)" where("Initial Document Type" = const("Credit Memo"),
                                                                                  "Entry Type" = const("Initial Entry"),
                                                                                  "Customer No." = field("No."),
                                                                                  "Initial Entry Global Dim. 1" = field("Global Dimension 1 Filter"),
                                                                                  "Initial Entry Global Dim. 2" = field("Global Dimension 2 Filter"),
                                                                                  "Posting Date" = field("Date Filter"),
                                                                                  "Currency Code" = field("Currency Filter")));
            Caption = 'Cr. Memo Amounts (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(77; "Fin. Charge Memo Amounts (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = sum("Detailed Cust. Ledg. Entry"."Amount (LCY)" where("Initial Document Type" = const("Finance Charge Memo"),
                                                                                 "Entry Type" = const("Initial Entry"),
                                                                                 "Customer No." = field("No."),
                                                                                 "Initial Entry Global Dim. 1" = field("Global Dimension 1 Filter"),
                                                                                 "Initial Entry Global Dim. 2" = field("Global Dimension 2 Filter"),
                                                                                 "Posting Date" = field("Date Filter"),
                                                                                 "Currency Code" = field("Currency Filter")));
            Caption = 'Fin. Charge Memo Amounts (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(78; "Outstanding Orders"; Decimal)
        {
            AccessByPermission = TableData "Sales Shipment Header" = R;
            AutoFormatExpression = Rec."Currency Code";
            AutoFormatType = 1;
            CalcFormula = sum("Sales Line"."Outstanding Amount" where("Document Type" = const(Order),
                                                                       "Bill-to Customer No." = field("No."),
                                                                       "Shortcut Dimension 1 Code" = field("Global Dimension 1 Filter"),
                                                                       "Shortcut Dimension 2 Code" = field("Global Dimension 2 Filter"),
                                                                       "Currency Code" = field("Currency Filter")));
            Caption = 'Outstanding Orders';
            Editable = false;
            FieldClass = FlowField;
        }
        field(79; "Shipped Not Invoiced"; Decimal)
        {
            AccessByPermission = TableData "Sales Shipment Header" = R;
            AutoFormatExpression = Rec."Currency Code";
            AutoFormatType = 1;
            CalcFormula = sum("Sales Line"."Shipped Not Invoiced" where("Document Type" = const(Order),
                                                                         "Bill-to Customer No." = field("No."),
                                                                         "Shortcut Dimension 1 Code" = field("Global Dimension 1 Filter"),
                                                                         "Shortcut Dimension 2 Code" = field("Global Dimension 2 Filter"),
                                                                         "Currency Code" = field("Currency Filter")));
            Caption = 'Shipped Not Invoiced';
            Editable = false;
            FieldClass = FlowField;
        }
        field(80; "Application Method"; Enum "Application Method")
        {
            Caption = 'Application Method';
            ToolTip = 'Specifies how to apply payments to entries for this customer.';
        }
        field(82; "Prices Including VAT"; Boolean)
        {
            Caption = 'Prices Including VAT';
            ToolTip = 'Specifies if the Unit Price and Line Amount fields on document lines should be shown with or without VAT.';
        }
        field(83; "Location Code"; Code[10])
        {
            Caption = 'Location Code';
            TableRelation = Location where("Use As In-Transit" = const(false));
            ToolTip = 'Specifies from which location sales to this customer will be processed by default.';
        }
        field(84; "Fax No."; Text[30])
        {
            Caption = 'Fax No.';
            OptimizeForTextSearch = true;
            ToolTip = 'Specifies the customer''s fax number.';
        }
        field(85; "Telex Answer Back"; Text[20])
        {
            Caption = 'Telex Answer Back';
            OptimizeForTextSearch = true;
        }
        field(86; "VAT Registration No."; Text[20])
        {
            Caption = 'VAT Registration No.';
            OptimizeForTextSearch = true;
            ToolTip = 'Specifies the customer''s VAT registration number for customers in EU countries/regions.';


        }
        field(87; "Combine Shipments"; Boolean)
        {
            AccessByPermission = TableData "Sales Shipment Header" = R;
            Caption = 'Combine Sales Shipments';
            ToolTip = 'Specifies if several orders delivered to the customer can appear on the same sales invoice.';
        }
        field(88; "Gen. Bus. Posting Group"; Code[20])
        {
            Caption = 'Gen. Bus. Posting Group';
            TableRelation = "Gen. Business Posting Group";
            ToolTip = 'Specifies the customer''s trade type to link transactions made for this customer with the appropriate general ledger account according to the general posting setup.';

            trigger OnValidate()
            begin
                if xRec."Gen. Bus. Posting Group" <> "Gen. Bus. Posting Group" then
                    if GenBusPostingGrp.ValidateVatBusPostingGroup(GenBusPostingGrp, "Gen. Bus. Posting Group") then
                        Validate("VAT Bus. Posting Group", GenBusPostingGrp."Def. VAT Bus. Posting Group");
            end;
        }
        field(90; GLN; Code[13])
        {
            Caption = 'GLN';
            Numeric = true;
            ToolTip = 'Specifies the customer in connection with electronic document sending.';

            trigger OnValidate()
            var
                GLNCalculator: Codeunit "GLN Calculator";
            begin
                if GLN <> '' then
                    GLNCalculator.AssertValidCheckDigit13(GLN);
            end;
        }
        field(91; "Post Code"; Code[20])
        {
            Caption = 'Post Code';
            TableRelation = if ("Country/Region Code" = const('')) "Post Code"
            else
            if ("Country/Region Code" = filter(<> '')) "Post Code" where("Country/Region Code" = field("Country/Region Code"));
            ValidateTableRelation = false;
            ToolTip = 'Specifies the post code.';


        }
        field(92; County; Text[30])
        {
            CaptionClass = '5,1,' + "Country/Region Code";
            Caption = 'County';
            OptimizeForTextSearch = true;
            ToolTip = 'Specifies the state, province or county as a part of the address.';
        }
        field(93; "EORI Number"; Text[40])
        {
            Caption = 'EORI Number';
            OptimizeForTextSearch = true;
            ToolTip = 'Specifies the Economic Operators Registration and Identification number that is used when you exchange information with the customs authorities due to trade into or out of the European Union.';
        }
        field(95; "Use GLN in Electronic Document"; Boolean)
        {
            Caption = 'Use GLN in Electronic Documents';
            ToolTip = 'Specifies whether the GLN is used in electronic documents as a party identification number.';
        }
        field(97; "Debit Amount"; Decimal)
        {
            AutoFormatExpression = Rec."Currency Code";
            AutoFormatType = 1;
            BlankZero = true;
            CalcFormula = sum("Detailed Cust. Ledg. Entry"."Debit Amount" where("Customer No." = field("No."),
                                                                                 "Entry Type" = filter(<> Application),
                                                                                 "Initial Entry Global Dim. 1" = field("Global Dimension 1 Filter"),
                                                                                 "Initial Entry Global Dim. 2" = field("Global Dimension 2 Filter"),
                                                                                 "Posting Date" = field("Date Filter"),
                                                                                 "Currency Code" = field("Currency Filter")));
            Caption = 'Debit Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(98; "Credit Amount"; Decimal)
        {
            AutoFormatExpression = Rec."Currency Code";
            AutoFormatType = 1;
            BlankZero = true;
            CalcFormula = sum("Detailed Cust. Ledg. Entry"."Credit Amount" where("Customer No." = field("No."),
                                                                                  "Entry Type" = filter(<> Application),
                                                                                  "Initial Entry Global Dim. 1" = field("Global Dimension 1 Filter"),
                                                                                  "Initial Entry Global Dim. 2" = field("Global Dimension 2 Filter"),
                                                                                  "Posting Date" = field("Date Filter"),
                                                                                  "Currency Code" = field("Currency Filter")));
            Caption = 'Credit Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(99; "Debit Amount (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            BlankZero = true;
            CalcFormula = sum("Detailed Cust. Ledg. Entry"."Debit Amount (LCY)" where("Customer No." = field("No."),
                                                                                       "Entry Type" = filter(<> Application),
                                                                                       "Initial Entry Global Dim. 1" = field("Global Dimension 1 Filter"),
                                                                                       "Initial Entry Global Dim. 2" = field("Global Dimension 2 Filter"),
                                                                                       "Posting Date" = field("Date Filter"),
                                                                                       "Currency Code" = field("Currency Filter")));
            Caption = 'Debit Amount (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(100; "Credit Amount (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            BlankZero = true;
            CalcFormula = sum("Detailed Cust. Ledg. Entry"."Credit Amount (LCY)" where("Customer No." = field("No."),
                                                                                        "Entry Type" = filter(<> Application),
                                                                                        "Initial Entry Global Dim. 1" = field("Global Dimension 1 Filter"),
                                                                                        "Initial Entry Global Dim. 2" = field("Global Dimension 2 Filter"),
                                                                                        "Posting Date" = field("Date Filter"),
                                                                                        "Currency Code" = field("Currency Filter")));
            Caption = 'Credit Amount (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(102; "E-Mail"; Text[80])
        {
            Caption = 'Email';
            OptimizeForTextSearch = true;
            ExtendedDatatype = EMail;
            ToolTip = 'Specifies the customer''s email address.';


        }
#if not CLEAN27
#pragma warning disable AS0086
#endif
        field(103; "Home Page"; Text[255])
#if not CLEAN27
#pragma warning restore AS0086
#endif
        {
            Caption = 'Home Page';
            OptimizeForTextSearch = true;
            ExtendedDatatype = URL;
            ToolTip = 'Specifies the customer''s home page address.';
        }
        field(104; "Reminder Terms Code"; Code[10])
        {
            Caption = 'Reminder Terms Code';
            TableRelation = "Reminder Terms";
            ToolTip = 'Specifies how reminders about late payments are handled for this customer.';

#if not CLEAN25
            trigger OnLookup()
            var
                ReminderTermsRecord: Record "Reminder Terms";
                ReminderTerms: Page "Reminder Terms";
            begin
                ReminderTerms.LookupMode(true);
                if ReminderTerms.RunModal() <> ACTION::LookupOK then
                    exit;

                ReminderTerms.SetSelectionFilter(ReminderTermsRecord);
                ReminderTermsRecord.FindFirst();
                Rec."Reminder Terms Code" := ReminderTermsRecord.Code;
            end;
#endif
        }
        field(105; "Reminder Amounts"; Decimal)
        {
            AutoFormatExpression = Rec."Currency Code";
            AutoFormatType = 1;
            CalcFormula = sum("Detailed Cust. Ledg. Entry".Amount where("Initial Document Type" = const(Reminder),
                                                                         "Entry Type" = const("Initial Entry"),
                                                                         "Customer No." = field("No."),
                                                                         "Initial Entry Global Dim. 1" = field("Global Dimension 1 Filter"),
                                                                         "Initial Entry Global Dim. 2" = field("Global Dimension 2 Filter"),
                                                                         "Posting Date" = field("Date Filter"),
                                                                         "Currency Code" = field("Currency Filter")));
            Caption = 'Reminder Amounts';
            Editable = false;
            FieldClass = FlowField;
        }
        field(106; "Reminder Amounts (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = sum("Detailed Cust. Ledg. Entry"."Amount (LCY)" where("Initial Document Type" = const(Reminder),
                                                                                 "Entry Type" = const("Initial Entry"),
                                                                                 "Customer No." = field("No."),
                                                                                 "Initial Entry Global Dim. 1" = field("Global Dimension 1 Filter"),
                                                                                 "Initial Entry Global Dim. 2" = field("Global Dimension 2 Filter"),
                                                                                 "Posting Date" = field("Date Filter"),
                                                                                 "Currency Code" = field("Currency Filter")));
            Caption = 'Reminder Amounts (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(107; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(108; "Tax Area Code"; Code[20])
        {
            Caption = 'Tax Area Code';
            TableRelation = "Tax Area";
            ToolTip = 'Specifies the tax area that is used to calculate and post sales tax.';

            trigger OnValidate()
            begin

            end;
        }
        field(109; "Tax Liable"; Boolean)
        {
            Caption = 'Tax Liable';
            ToolTip = 'Specifies if the customer or vendor is liable for sales tax.';
        }
        field(110; "VAT Bus. Posting Group"; Code[20])
        {
            Caption = 'VAT Bus. Posting Group';
            TableRelation = "VAT Business Posting Group";
            ToolTip = 'Specifies the customer''s VAT specification to link transactions made for this customer to.';


        }
        field(111; "Currency Filter"; Code[10])
        {
            Caption = 'Currency Filter';
            FieldClass = FlowFilter;
            TableRelation = Currency;
        }
        field(113; "Outstanding Orders (LCY)"; Decimal)
        {
            AccessByPermission = TableData "Sales Shipment Header" = R;
            AutoFormatType = 1;
            CalcFormula = sum("Sales Line"."Outstanding Amount (LCY)" where("Document Type" = const(Order),
                                                                             "Bill-to Customer No." = field("No."),
                                                                             "Shortcut Dimension 1 Code" = field("Global Dimension 1 Filter"),
                                                                             "Shortcut Dimension 2 Code" = field("Global Dimension 2 Filter"),
                                                                             "Currency Code" = field("Currency Filter")));
            Caption = 'Outstanding Orders (LCY)';
            Editable = false;
            FieldClass = FlowField;
            ToolTip = 'Specifies your expected sales income from the customer in LCY based on ongoing sales orders.';
        }
        field(114; "Shipped Not Invoiced (LCY)"; Decimal)
        {
            AccessByPermission = TableData "Sales Shipment Header" = R;
            AutoFormatType = 1;
            CalcFormula = sum("Sales Line"."Shipped Not Invoiced (LCY)" where("Document Type" = const(Order),
                                                                               "Bill-to Customer No." = field("No."),
                                                                               "Shortcut Dimension 1 Code" = field("Global Dimension 1 Filter"),
                                                                               "Shortcut Dimension 2 Code" = field("Global Dimension 2 Filter"),
                                                                               "Currency Code" = field("Currency Filter")));
            Caption = 'Shipped Not Invoiced (LCY)';
            Editable = false;
            FieldClass = FlowField;
            ToolTip = 'Specifies your expected sales income from the customer in LCY based on ongoing sales orders where items have been shipped.';
        }
        field(115; Reserve; Enum "Reserve Method")
        {
            AccessByPermission = TableData "Sales Shipment Header" = R;
            Caption = 'Reserve';
            InitValue = Optional;
            ToolTip = 'Specifies whether items will never, automatically (Always), or optionally be reserved for this customer. Optional means that you must manually reserve items for this customer.';
        }
        field(116; "Block Payment Tolerance"; Boolean)
        {
            Caption = 'Block Payment Tolerance';
            ToolTip = 'Specifies that the customer is not allowed a payment tolerance.';


        }
        field(117; "Pmt. Disc. Tolerance (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = - sum("Detailed Cust. Ledg. Entry"."Amount (LCY)" where("Customer No." = field("No."),
                                                                                  "Entry Type" = filter("Payment Discount Tolerance" | "Payment Discount Tolerance (VAT Adjustment)" | "Payment Discount Tolerance (VAT Excl.)"),
                                                                                  "Initial Entry Global Dim. 1" = field("Global Dimension 1 Filter"),
                                                                                  "Initial Entry Global Dim. 2" = field("Global Dimension 2 Filter"),
                                                                                  "Posting Date" = field("Date Filter"),
                                                                                  "Currency Code" = field("Currency Filter")));
            Caption = 'Pmt. Disc. Tolerance (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(118; "Pmt. Tolerance (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = - sum("Detailed Cust. Ledg. Entry"."Amount (LCY)" where("Customer No." = field("No."),
                                                                                  "Entry Type" = filter("Payment Tolerance" | "Payment Tolerance (VAT Adjustment)" | "Payment Tolerance (VAT Excl.)"),
                                                                                  "Initial Entry Global Dim. 1" = field("Global Dimension 1 Filter"),
                                                                                  "Initial Entry Global Dim. 2" = field("Global Dimension 2 Filter"),
                                                                                  "Posting Date" = field("Date Filter"),
                                                                                  "Currency Code" = field("Currency Filter")));
            Caption = 'Pmt. Tolerance (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(119; "IC Partner Code"; Code[20])
        {
            Caption = 'IC Partner Code';
            TableRelation = "IC Partner";
            ToolTip = 'Specifies the customer''s intercompany partner code.';

            trigger OnValidate()
            var
                CustLedgEntry: Record "Cust. Ledger Entry";
                AccountingPeriod: Record "Accounting Period";
                ICPartner: Record "IC Partner";
                ConfirmManagement: Codeunit "Confirm Management";
            begin
                if xRec."IC Partner Code" <> "IC Partner Code" then begin
                    if not CustLedgEntry.SetCurrentKey("Customer No.", Open) then
                        CustLedgEntry.SetCurrentKey("Customer No.");
                    CustLedgEntry.SetRange("Customer No.", "No.");
                    CustLedgEntry.SetRange(Open, true);
                    if CustLedgEntry.FindLast() then
                        Error(Text012, FieldCaption("IC Partner Code"), TableCaption);

                    CustLedgEntry.Reset();
                    CustLedgEntry.SetCurrentKey("Customer No.", "Posting Date");
                    CustLedgEntry.SetRange("Customer No.", "No.");
                    AccountingPeriod.SetRange(Closed, false);
                    if AccountingPeriod.FindFirst() then begin
                        CustLedgEntry.SetFilter("Posting Date", '>=%1', AccountingPeriod."Starting Date");
                        if CustLedgEntry.FindFirst() then
                            if not ConfirmManagement.GetResponseOrDefault(StrSubstNo(Text011, TableCaption), true) then
                                "IC Partner Code" := xRec."IC Partner Code";
                    end;
                end;

                if "IC Partner Code" <> '' then begin
                    ICPartner.Get("IC Partner Code");
                    if (ICPartner."Customer No." <> '') and (ICPartner."Customer No." <> "No.") then
                        Error(Text010, FieldCaption("IC Partner Code"), "IC Partner Code", TableCaption(), ICPartner."Customer No.");
                    ICPartner."Customer No." := "No.";
                    ICPartner.Modify();
                end;

                if (xRec."IC Partner Code" <> "IC Partner Code") and ICPartner.Get(xRec."IC Partner Code") then begin
                    ICPartner."Customer No." := '';
                    ICPartner.Modify();
                end;
            end;
        }
        field(120; Refunds; Decimal)
        {
            CalcFormula = sum("Detailed Cust. Ledg. Entry".Amount where("Initial Document Type" = const(Refund),
                                                                         "Entry Type" = const("Initial Entry"),
                                                                         "Customer No." = field("No."),
                                                                         "Initial Entry Global Dim. 1" = field("Global Dimension 1 Filter"),
                                                                         "Initial Entry Global Dim. 2" = field("Global Dimension 2 Filter"),
                                                                         "Posting Date" = field("Date Filter"),
                                                                         "Currency Code" = field("Currency Filter")));
            Caption = 'Refunds';
            FieldClass = FlowField;
        }
        field(121; "Refunds (LCY)"; Decimal)
        {
            CalcFormula = sum("Detailed Cust. Ledg. Entry"."Amount (LCY)" where("Initial Document Type" = const(Refund),
                                                                                 "Entry Type" = const("Initial Entry"),
                                                                                 "Customer No." = field("No."),
                                                                                 "Initial Entry Global Dim. 1" = field("Global Dimension 1 Filter"),
                                                                                 "Initial Entry Global Dim. 2" = field("Global Dimension 2 Filter"),
                                                                                 "Posting Date" = field("Date Filter"),
                                                                                 "Currency Code" = field("Currency Filter")));
            Caption = 'Refunds (LCY)';
            FieldClass = FlowField;
            ToolTip = 'Specifies the sum of refunds received from the customer.';
            AutoFormatType = 1;
        }
        field(122; "Other Amounts"; Decimal)
        {
            CalcFormula = sum("Detailed Cust. Ledg. Entry".Amount where("Initial Document Type" = const(" "),
                                                                         "Entry Type" = const("Initial Entry"),
                                                                         "Customer No." = field("No."),
                                                                         "Initial Entry Global Dim. 1" = field("Global Dimension 1 Filter"),
                                                                         "Initial Entry Global Dim. 2" = field("Global Dimension 2 Filter"),
                                                                         "Posting Date" = field("Date Filter"),
                                                                         "Currency Code" = field("Currency Filter")));
            Caption = 'Other Amounts';
            FieldClass = FlowField;
        }
        field(123; "Other Amounts (LCY)"; Decimal)
        {
            CalcFormula = sum("Detailed Cust. Ledg. Entry"."Amount (LCY)" where("Initial Document Type" = const(" "),
                                                                                 "Entry Type" = const("Initial Entry"),
                                                                                 "Customer No." = field("No."),
                                                                                 "Initial Entry Global Dim. 1" = field("Global Dimension 1 Filter"),
                                                                                 "Initial Entry Global Dim. 2" = field("Global Dimension 2 Filter"),
                                                                                 "Posting Date" = field("Date Filter"),
                                                                                 "Currency Code" = field("Currency Filter")));
            Caption = 'Other Amounts (LCY)';
            FieldClass = FlowField;
            AutoFormatType = 1;
        }
        field(124; "Prepayment %"; Decimal)
        {
            Caption = 'Prepayment %';
            DecimalPlaces = 0 : 5;
            MaxValue = 100;
            MinValue = 0;
            ToolTip = 'Specifies a prepayment percentage that applies to all orders for this customer, regardless of the items or services on the order lines.';
        }
        field(125; "Outstanding Invoices (LCY)"; Decimal)
        {
            AccessByPermission = TableData "Sales Shipment Header" = R;
            AutoFormatType = 1;
            CalcFormula = sum("Sales Line"."Outstanding Amount (LCY)" where("Document Type" = const(Invoice),
                                                                             "Bill-to Customer No." = field("No."),
                                                                             "Shortcut Dimension 1 Code" = field("Global Dimension 1 Filter"),
                                                                             "Shortcut Dimension 2 Code" = field("Global Dimension 2 Filter"),
                                                                             "Currency Code" = field("Currency Filter")));
            Caption = 'Outstanding Invoices (LCY)';
            Editable = false;
            FieldClass = FlowField;
            ToolTip = 'Specifies your expected sales income from the customer in LCY based on unpaid sales invoices.';
        }
        field(126; "Outstanding Invoices"; Decimal)
        {
            AccessByPermission = TableData "Sales Shipment Header" = R;
            AutoFormatExpression = Rec."Currency Code";
            AutoFormatType = 1;
            CalcFormula = sum("Sales Line"."Outstanding Amount" where("Document Type" = const(Invoice),
                                                                       "Bill-to Customer No." = field("No."),
                                                                       "Shortcut Dimension 1 Code" = field("Global Dimension 1 Filter"),
                                                                       "Shortcut Dimension 2 Code" = field("Global Dimension 2 Filter"),
                                                                       "Currency Code" = field("Currency Filter")));
            Caption = 'Outstanding Invoices';
            Editable = false;
            FieldClass = FlowField;
        }
        field(130; "Bill-to No. Of Archived Doc."; Integer)
        {
            CalcFormula = count("Sales Header Archive" where("Document Type" = const(Order),
                                                              "Bill-to Customer No." = field("No.")));
            Caption = 'Bill-to No. Of Sales Archived Doc.';
            FieldClass = FlowField;
        }
        field(131; "Sell-to No. Of Archived Doc."; Integer)
        {
            CalcFormula = count("Sales Header Archive" where("Document Type" = const(Order),
                                                              "Sell-to Customer No." = field("No.")));
            Caption = 'Sell-to No. Of Sales Archived Doc.';
            FieldClass = FlowField;
        }
        field(132; "Partner Type"; Enum "Partner Type")
        {
            Caption = 'Partner Type';
            ToolTip = 'Specifies for direct debit collections if the customer that the payment is collected from is a person or a company.';
        }
        field(133; "Intrastat Partner Type"; Enum "Partner Type")
        {
            Caption = 'Intrastat Partner Type';
            ToolTip = 'Specifies for Intrastat reporting if the customer is a person or a company.';
        }
        field(134; "Exclude from Pmt. Practices"; Boolean)
        {
            Caption = 'Exclude from Payment Practices';
            ToolTip = 'Specifies that the customer must be excluded from Payment Practices calculations.';
        }
        field(140; Image; Media)
        {
            Caption = 'Image';
            ExtendedDatatype = Person;
            ToolTip = 'Specifies the picture of the customer, for example, a logo.';
        }
        field(150; "Privacy Blocked"; Boolean)
        {
            Caption = 'Privacy Blocked';
            ToolTip = 'Specifies whether to limit access to data for the data subject during daily operations. This is useful, for example, when protecting data from changes while it is under privacy review.';

            trigger OnValidate()
            begin
                if "Privacy Blocked" then
                    Blocked := Blocked::All
                else
                    Blocked := Blocked::" ";
            end;
        }
        field(160; "Disable Search by Name"; Boolean)
        {
            Caption = 'Disable Search by Name';
            DataClassification = SystemMetadata;
            ToolTip = 'Specifies that you can change the customer name on open sales documents. The change applies only to the documents.';
        }
        field(175; "Allow Multiple Posting Groups"; Boolean)
        {
            Caption = 'Allow Multiple Posting Groups';
            DataClassification = SystemMetadata;
            ToolTip = 'Specifies if multiple posting groups can be used for posting business transactions for this customer.';
        }
        field(288; "Preferred Bank Account Code"; Code[20])
        {
            Caption = 'Preferred Bank Account Code';
            TableRelation = "Customer Bank Account".Code where("Customer No." = field("No."));
            ToolTip = 'Specifies the customer''s bank account that will be used by default when you process refunds to the customer and direct debit collections.';
        }
#if not CLEANSCHEMA26
        field(720; "Coupled to CRM"; Boolean)
        {
            Caption = 'Coupled to Dataverse';
            Editable = false;
            ObsoleteReason = 'Replaced by flow field Coupled to Dataverse';
            ObsoleteState = Removed;
            ObsoleteTag = '26.0';
        }
#endif
        field(721; "Coupled to Dataverse"; Boolean)
        {
            FieldClass = FlowField;
            Caption = 'Coupled to Dataverse';
            Editable = false;
            CalcFormula = exist("CRM Integration Record" where("Integration ID" = field(SystemId), "Table ID" = const(Database::Customer)));
            ToolTip = 'Specifies that the customer is coupled to an account in Dataverse.';
        }
        field(840; "Cash Flow Payment Terms Code"; Code[10])
        {
            Caption = 'Cash Flow Payment Terms Code';
            TableRelation = "Payment Terms";
            ToolTip = 'Specifies a payment term that will be used to calculate cash flow for the customer.';
        }
        field(5049; "Primary Contact No."; Code[20])
        {
            Caption = 'Primary Contact No.';
            TableRelation = Contact;
            ToolTip = 'Specifies the contact number for the customer.';


        }
        field(5050; "Contact Type"; Enum "Contact Type")
        {
            Caption = 'Contact Type';
        }
        field(5061; "Mobile Phone No."; Text[30])
        {
            Caption = 'Mobile Phone No.';
            OptimizeForTextSearch = true;
            ExtendedDatatype = PhoneNo;
            ToolTip = 'Specifies the customer''s mobile telephone number.';

        }
        field(5700; "Responsibility Center"; Code[10])
        {
            Caption = 'Responsibility Center';
            TableRelation = "Responsibility Center";
            ToolTip = 'Specifies the code for the responsibility center that will administer this customer by default.';
        }
        field(5750; "Shipping Advice"; Enum "Sales Header Shipping Advice")
        {
            AccessByPermission = TableData "Sales Shipment Header" = R;
            Caption = 'Shipping Advice';
            ToolTip = 'Specifies if the customer accepts partial shipment of orders.';
        }
        field(5790; "Shipping Time"; DateFormula)
        {
            AccessByPermission = TableData "Shipping Agent Services" = R;
            Caption = 'Shipping Time';
            ToolTip = 'Specifies how long it takes from when the items are shipped from the warehouse to when they are delivered.';
        }
        field(5792; "Shipping Agent Service Code"; Code[10])
        {
            Caption = 'Shipping Agent Service Code';
            TableRelation = "Shipping Agent Services".Code where("Shipping Agent Code" = field("Shipping Agent Code"));
            ToolTip = 'Specifies the code for the shipping agent service to use for this customer.';

            trigger OnValidate()
            begin
                if ("Shipping Agent Code" <> '') and
                   ("Shipping Agent Service Code" <> '')
                then
                    if ShippingAgentService.Get("Shipping Agent Code", "Shipping Agent Service Code") then
                        "Shipping Time" := ShippingAgentService."Shipping Time"
                    else
                        Evaluate("Shipping Time", '<>');
            end;
        }
        field(7000; "Price Calculation Method"; Enum "Price Calculation Method")
        {
            Caption = 'Price Calculation Method';
            ToolTip = 'Specifies the default price calculation method.';

            trigger OnValidate()
            var
                PriceCalculationMgt: Codeunit "Price Calculation Mgt.";
                PriceType: Enum "Price Type";
            begin
                if "Price Calculation Method" <> "Price Calculation Method"::" " then
                    PriceCalculationMgt.VerifyMethodImplemented("Price Calculation Method", PriceType::Sale);
            end;
        }
        field(7001; "Allow Line Disc."; Boolean)
        {
            Caption = 'Allow Line Disc.';
            InitValue = true;
            ToolTip = 'Specifies if a sales line discount is calculated when a special sales price is offered according to setup in the Sales Prices window.';
        }
        field(7171; "No. of Quotes"; Integer)
        {
            CalcFormula = count("Sales Header" where("Document Type" = const(Quote),
                                                      "Sell-to Customer No." = field("No.")));
            Caption = 'No. of Quotes';
            Editable = false;
            FieldClass = FlowField;
        }
        field(7172; "No. of Blanket Orders"; Integer)
        {
            AccessByPermission = TableData "Sales Shipment Header" = R;
            CalcFormula = count("Sales Header" where("Document Type" = const("Blanket Order"),
                                                      "Sell-to Customer No." = field("No.")));
            Caption = 'No. of Blanket Orders';
            Editable = false;
            FieldClass = FlowField;
        }
        field(7173; "No. of Orders"; Integer)
        {
            AccessByPermission = TableData "Sales Shipment Header" = R;
            CalcFormula = count("Sales Header" where("Document Type" = const(Order),
                                                      "Sell-to Customer No." = field("No.")));
            Caption = 'No. of Orders';
            Editable = false;
            FieldClass = FlowField;
        }
        field(7174; "No. of Invoices"; Integer)
        {
            CalcFormula = count("Sales Header" where("Document Type" = const(Invoice),
                                                      "Sell-to Customer No." = field("No.")));
            Caption = 'No. of Invoices';
            Editable = false;
            FieldClass = FlowField;
        }
        field(7175; "No. of Return Orders"; Integer)
        {
            AccessByPermission = TableData "Return Receipt Header" = R;
            CalcFormula = count("Sales Header" where("Document Type" = const("Return Order"),
                                                      "Sell-to Customer No." = field("No.")));
            Caption = 'No. of Return Orders';
            Editable = false;
            FieldClass = FlowField;
        }
        field(7176; "No. of Credit Memos"; Integer)
        {
            CalcFormula = count("Sales Header" where("Document Type" = const("Credit Memo"),
                                                      "Sell-to Customer No." = field("No.")));
            Caption = 'No. of Credit Memos';
            Editable = false;
            FieldClass = FlowField;
        }
        field(7177; "No. of Pstd. Shipments"; Integer)
        {
            CalcFormula = count("Sales Shipment Header" where("Sell-to Customer No." = field("No.")));
            Caption = 'No. of Pstd. Shipments';
            Editable = false;
            FieldClass = FlowField;
        }
        field(7178; "No. of Pstd. Invoices"; Integer)
        {
            CalcFormula = count("Sales Invoice Header" where("Sell-to Customer No." = field("No.")));
            Caption = 'No. of Pstd. Invoices';
            Editable = false;
            FieldClass = FlowField;
        }
        field(7179; "No. of Pstd. Return Receipts"; Integer)
        {
            CalcFormula = count("Return Receipt Header" where("Sell-to Customer No." = field("No.")));
            Caption = 'No. of Pstd. Return Receipts';
            Editable = false;
            FieldClass = FlowField;
        }
        field(7180; "No. of Pstd. Credit Memos"; Integer)
        {
            CalcFormula = count("Sales Cr.Memo Header" where("Sell-to Customer No." = field("No.")));
            Caption = 'No. of Pstd. Credit Memos';
            Editable = false;
            FieldClass = FlowField;
        }
        field(7181; "No. of Ship-to Addresses"; Integer)
        {
            CalcFormula = count("Ship-to Address" where("Customer No." = field("No.")));
            Caption = 'No. of Ship-to Addresses';
            Editable = false;
            FieldClass = FlowField;
        }
        field(7182; "Bill-To No. of Quotes"; Integer)
        {
            CalcFormula = count("Sales Header" where("Document Type" = const(Quote),
                                                      "Bill-to Customer No." = field("No.")));
            Caption = 'Bill-To No. of Quotes';
            Editable = false;
            FieldClass = FlowField;
        }
        field(7183; "Bill-To No. of Blanket Orders"; Integer)
        {
            AccessByPermission = TableData "Sales Shipment Header" = R;
            CalcFormula = count("Sales Header" where("Document Type" = const("Blanket Order"),
                                                      "Bill-to Customer No." = field("No.")));
            Caption = 'Bill-To No. of Blanket Orders';
            Editable = false;
            FieldClass = FlowField;
        }
        field(7184; "Bill-To No. of Orders"; Integer)
        {
            AccessByPermission = TableData "Sales Shipment Header" = R;
            CalcFormula = count("Sales Header" where("Document Type" = const(Order),
                                                      "Bill-to Customer No." = field("No.")));
            Caption = 'Bill-To No. of Orders';
            Editable = false;
            FieldClass = FlowField;
        }
        field(7185; "Bill-To No. of Invoices"; Integer)
        {
            CalcFormula = count("Sales Header" where("Document Type" = const(Invoice),
                                                      "Bill-to Customer No." = field("No.")));
            Caption = 'Bill-To No. of Invoices';
            Editable = false;
            FieldClass = FlowField;
        }
        field(7186; "Bill-To No. of Return Orders"; Integer)
        {
            AccessByPermission = TableData "Return Receipt Header" = R;
            CalcFormula = count("Sales Header" where("Document Type" = const("Return Order"),
                                                      "Bill-to Customer No." = field("No.")));
            Caption = 'Bill-To No. of Return Orders';
            Editable = false;
            FieldClass = FlowField;
        }
        field(7187; "Bill-To No. of Credit Memos"; Integer)
        {
            CalcFormula = count("Sales Header" where("Document Type" = const("Credit Memo"),
                                                      "Bill-to Customer No." = field("No.")));
            Caption = 'Bill-To No. of Credit Memos';
            Editable = false;
            FieldClass = FlowField;
        }
        field(7188; "Bill-To No. of Pstd. Shipments"; Integer)
        {
            CalcFormula = count("Sales Shipment Header" where("Bill-to Customer No." = field("No.")));
            Caption = 'Bill-To No. of Pstd. Shipments';
            Editable = false;
            FieldClass = FlowField;
        }
        field(7189; "Bill-To No. of Pstd. Invoices"; Integer)
        {
            CalcFormula = count("Sales Invoice Header" where("Bill-to Customer No." = field("No.")));
            Caption = 'Bill-To No. of Pstd. Invoices';
            Editable = false;
            FieldClass = FlowField;
        }
        field(7190; "Bill-To No. of Pstd. Return R."; Integer)
        {
            CalcFormula = count("Return Receipt Header" where("Bill-to Customer No." = field("No.")));
            Caption = 'Bill-To No. of Pstd. Return R.';
            Editable = false;
            FieldClass = FlowField;
        }
        field(7191; "Bill-To No. of Pstd. Cr. Memos"; Integer)
        {
            CalcFormula = count("Sales Cr.Memo Header" where("Bill-to Customer No." = field("No.")));
            Caption = 'Bill-To No. of Pstd. Cr. Memos';
            Editable = false;
            FieldClass = FlowField;
        }
        field(7600; "Base Calendar Code"; Code[10])
        {
            Caption = 'Base Calendar Code';
            TableRelation = "Base Calendar";
            ToolTip = 'Specifies a customizable calendar for shipment planning that holds the customer''s working days and holidays.';
        }
        field(7601; "Copy Sell-to Addr. to Qte From"; Enum "Contact Type")
        {
            AccessByPermission = TableData Contact = R;
            Caption = 'Copy Sell-to Addr. to Qte From';
            ToolTip = 'Specifies which customer address is inserted on sales quotes that you create for the customer.';
        }
        field(7602; "Validate EU Vat Reg. No."; Boolean)
        {
            Caption = 'Validate EU VAT Reg. No.';
        }
        field(8001; "Currency Id"; Guid)
        {
            Caption = 'Currency Id';
            TableRelation = Currency.SystemId;

            trigger OnValidate()
            begin

            end;
        }
        field(8002; "Payment Terms Id"; Guid)
        {
            Caption = 'Payment Terms Id';
            TableRelation = "Payment Terms".SystemId;


        }
        field(8003; "Shipment Method Id"; Guid)
        {
            Caption = 'Shipment Method Id';
            TableRelation = "Shipment Method".SystemId;

            trigger OnValidate()
            begin

            end;
        }
        field(8004; "Payment Method Id"; Guid)
        {
            Caption = 'Payment Method Id';
            TableRelation = "Payment Method".SystemId;

            trigger OnValidate()
            begin

            end;
        }
        field(9003; "Tax Area ID"; Guid)
        {
            Caption = 'Tax Area ID';

            trigger OnValidate()
            begin

            end;
        }
        field(9005; "Contact ID"; Guid)
        {
            Caption = 'Contact ID';
        }
        field(9006; "Contact Graph Id"; Text[250])
        {
            Caption = 'Contact Graph Id';
            OptimizeForTextSearch = true;
        }
        field(53900; "Account Type"; Option)
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
        field(53901; "Employee Job Group"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Salary Processing Header".No;
        }
        field(53902; "Donor Category"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Intramural,Extramural';
            OptionMembers = " ",Intramural,Extramural;
        }
        field(53903; "Allow Indirect Cost"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(53904; "CPD Provider Reg Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(53905; "Member Category Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(53906; "No. SeriesCPD"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(53907; "No. SeriesMember"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(53908; "ISNormalMember"; Boolean)
        {
            DataClassification = ToBeClassified;

        }
        field(53909; "ID Number"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(53910; "Member Category Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(53911; "Graduation Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(53912; "Member No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(53913; Gender; Option)
        {
            DataClassification = ToBeClassified;
            //OptionMembers = Male,Female;
            OptionCaption = ' ,Male,Female';
            OptionMembers = " ",Male,Female;
        }
        field(53914; "Date Of Birth"; Date)
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
        field(53915; Religion; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(53916; Citizenship; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(53917; "Passport No"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(53918; Age; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(53919; "Spa Membership Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ",Full,Partial;
        }
        field(53920; "Insurance Account"; Boolean)
        {

        }
        field(171999; "Staff Paid"; Boolean)
        {

        }
        field(53926; "Code"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(53927; CodeII; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(53928; "Vs No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(53929; Debtors; Decimal)
        {
            CalcFormula = sum("Detailed Cust. Ledg. Entry".Amount
             where("Posting Date" = field("Date Filter"),
                                                                 "Customer No." = field("No.")));
            FieldClass = FlowField;
        }
        field(53930; "Last Deposit Date"; Date)
        {
            FieldClass = FlowField;
            CalcFormula = max("Detailed Vendor Ledg. Entry"."Posting Date" where("Vendor No." = field("Deposits Account No"), Reversed = filter(false)));
        }
        field(53931; "Recruited Members"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count(Customer where("Reffered By Member No" = field("No.")));
        }
        field(53932; "Total Interest Income"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = - sum("Detailed Cust. Ledg. Entry".Amount where("Customer No." = field("No."), Reversed = filter(false),
                                                                        "Transaction Type" = filter("Interest Paid"), "Posting Date" = field("Date Filter")));
        }
        field(68216; "Old Deposit Balance"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = - sum("Old Member Ledger Entries".Amount where("Member No." = field("No."), Reveresed = filter('FALSE'), Transaction = filter('Deposit Contribution'), "Posting Date" = field("Date Filter")));
        }
        field(68217; "Old ESS Balance"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = - sum("Old Member Ledger Entries".Amount where("Member No." = field("No."), Reveresed = filter('FALSE'), Transaction = filter('SchFee Shares'), "Posting Date" = field("Date Filter")));
        }
        field(68218; "Old Share Capital Balance"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = - sum("Old Member Ledger Entries".Amount where("Member No." = field("No."), Reveresed = filter('FALSE'), Transaction = filter('Shares Capital'), "Posting Date" = field("Date Filter")));
        }
        field(68000; testing; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(68300; "Customer Type"; Option)
        {
            OptionCaption = ' ,Member,FOSA,Investments,Property,MicroFinance';
            OptionMembers = " ",Member,FOSA,Investments,Property,MicroFinance;
        }
        field(68001; "Registration Date"; Date)
        {
        }
        field(68002; "Current Loan"; Decimal)
        {
            CalcFormula = sum("Detailed Cust. Ledg. Entry".Amount where("Customer No." = field("No."), "Transaction Type" = const("Share Capital"),
                                                                  "Posting Date" = field("Date Filter"), "Document No." = field("Document No. Filter")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(68003; "Current Shares"; Decimal)
        {
            // CalcFormula = - sum("Detailed Vendor Ledg. Entry".Amount where("Vendor No." = field("Deposits Account No"),/* "Document No." = filter(<>'DEPOSBBF310324'),*/
            //Reversed = filter(False), "Posting Date" = field("Date Filter")));
            CalcFormula = - sum("Detailed Cust. Ledg. Entry".Amount where("Customer No." = field("No."),
                                                                  "Transaction Type" = filter("Deposit Contribution"), "Posting Date" = field("Date Filter")
                                                                  ));

            Editable = false;
            FieldClass = FlowField;
        }
        field(68004; "Total Repayments"; Decimal)
        {
            Editable = false;
        }
        field(68005; "Principal Balance"; Decimal)
        {
        }
        field(68006; "Principal Repayment"; Decimal)
        {
        }
        field(68008; "Debtors Type"; Option)
        {
            OptionCaption = ' ,Staff,Client,Others';
            OptionMembers = " ",Staff,Client,Others;
        }
        field(68009; "Total Loan Balance"; Decimal)
        {
            CalcFormula = sum("Detailed Cust. Ledg. Entry".Amount where("Customer No." = field("No."), Reversed = filter(false), "Posting Date" = field("Date Filter"),
                                                                        "Transaction Type" = filter(repayment | Loan | "Interest Paid" | "Interest Due" | "Loan Penalty Charged" | "Loan Penalty Paid")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(68011; "Outstanding Balance"; Decimal)
        {
            CalcFormula = sum("Detailed Cust. Ledg. Entry".Amount where("Customer No." = field("No."), Reversed = filter(false),
                                                                  "Transaction Type" = filter(repayment | Loan), "Posting Date" = field("Date Filter")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(68012; Status; Option)
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
        field(68013; "FOSA Account No."; Code[20])
        {
            TableRelation = Vendor."No.";
        }
        field(68015; "Old Account No2."; Code[10])
        {
            Enabled = false;
        }
        field(68016; "Loan Product Filter"; Code[15])
        {
            FieldClass = FlowFilter;
            TableRelation = "Loan Products Setup".Code;
        }
        field(68017; "Employer Code"; Code[120])
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
        field(68018; "Date of BirthN"; Date)
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
        field(68019; "E-Mail (Personal)"; Text[50])
        {
        }
        field(68020; "Station/Department"; Code[2])
        {
        }
        field(68021; "Home Address"; Text[20])
        {
        }
        field(68022; Location; Text[50])
        {
            Enabled = false;
        }
        field(68023; "Sub-Location"; Text[20])
        {
            Enabled = false;
        }
        field(68024; District; Text[20])
        {
        }
        field(68025; "Resons for Status Change"; Text[20])
        {
        }
        field(68026; "Payroll No"; Code[20])
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
        field(68027; "ID No."; Code[30])
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
        field(68028; "Mobile Phone No"; Code[30])
        {
        }
        field(68534; "Group Mobile Phone No"; code[30])
        {

        }
        field(68029; "Marital Status"; enum "Marital Status")
        {

        }
        field(68030; Signature; MediaSet)
        {
            Caption = 'Signature';
        }
        field(68031; "Passport No."; Code[10])
        {
        }
        field(68032; Genderr; Option)
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
        field(68033; "Withdrawal Date"; Date)
        {
        }
        field(68034; "Withdrawal Fee"; Decimal)
        {
            Editable = false;
            FieldClass = Normal;
        }
        field(68035; "Status - Withdrawal App."; Option)
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
        field(68036; "Withdrawal Application Date"; Date)
        {

            trigger OnValidate()
            begin
                if "Withdrawal Application Date" <> 0D then
                    "Withdrawal Date" := CalcDate('2M', "Withdrawal Application Date");

                GenSetUp.Get();
                "Withdrawal Fee" := GenSetUp."Withdrawal Fee";
                "Membership Status" := "Membership Status"::"Fully Exited";
                //  Blocked := Blocked::All;
            end;
        }
        field(68037; "Investment Monthly Cont"; Decimal)
        {
        }
        field(68038; "Investment Max Limit."; Decimal)
        {
        }
        field(68039; "Current Investment Total"; Decimal)
        {
            CalcFormula = sum("Detailed Cust. Ledg. Entry".Amount where("Customer No." = field("No."),
                                                                   "Transaction Type" = const("Loan Insurance Charged"),
                                                                   "Posting Date" = field("Date Filter"),
                                                                   "Document No." = field("Document No. Filter")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(68040; "Document No. Filter"; Code[10])
        {
            FieldClass = FlowFilter;
        }
        field(68041; "Shares Retained"; Decimal)
        {
            //CalcFormula = - sum("Detailed Vendor Ledg. Entry".Amount where("Vendor No." = field("Share Capital No"), /*"Document No." = filter(<>'SHARCBBF310324'),*/
            // Reversed = filter(False), "Posting Date" = field("Date Filter")));
            CalcFormula = - sum("Detailed Cust. Ledg. Entry".Amount where("Customer No." = field("No."),
                                                                  "Transaction Type" = filter("Share Capital"), "Posting Date" = field("Date Filter")
                                                                  ));
            Editable = false;
            FieldClass = FlowField;
        }
        field(68043; "Registration Fee Paid"; Decimal)
        {
            CalcFormula = - sum("Detailed Cust. Ledg. Entry".Amount where("Customer No." = field("No."), Reversed = filter(false),
                                                                           "Transaction Type" = const("Registration Fee")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(68044; "Registration Fee"; Decimal)
        {
        }
        field(68045; "Society Code"; Code[10])
        {
        }
        field(68046; "Insurance Fund"; Decimal)
        {
            /*             CalcFormula = sum("Detailed Cust. Ledg. Entry".Amount where("Customer No." = field("No."),
                                                                               "Transaction Type" = filter(insuranc),
                                                                               "Posting Date" = field("Date Filter"),
                                                                               "Document No." = field("Document No. Filter")));
                        Editable = false;
                        FieldClass = FlowField; */
        }
        field(68047; "Monthly Contribution"; Decimal)
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
                //DataSheet.Name := Name;
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
        field(68048; "Investment B/F"; Decimal)
        {
        }
        field(68049; "Dividend Amount"; Decimal)
        {
            /*             CalcFormula = - sum("Detailed Cust. Ledg. Entry".Amount where("Customer No." = field("No."),
                                                                            "Transaction Type" = const(Dividend),
                                                                          "Posting Date" = field("Date Filter")));
                        FieldClass = FlowField; */
        }
        field(68050; "Name of Chief"; Text[500])
        {
        }
        field(68051; "Office Telephone No."; Code[50])
        {
        }
        field(68052; "Extension No."; Code[50])
        {
        }
        field(68053; "Welfare Contribution"; Decimal)
        {

            trigger OnValidate()
            begin
                //Advice:=TRUE;
            end;
        }
        field(68054; Advice; Boolean)
        {
        }
        field(68055; Province; Code[50])
        {
            Enabled = false;
        }
        field(68056; "Previous Share Contribution"; Decimal)
        {
        }
        field(68057; "Un-allocated Funds"; Decimal)
        {
            /*             CalcFormula = - sum("Detailed Cust. Ledg. Entry".Amount where("Customer No." = field("No."),
                                                                               "Transaction Type" = const("Coop Shares"),
                                                                               "Posting Date" = field("Date Filter"),
                                                                               "Document No." = field("Document No. Filter")));
                        Editable = false;
                        Caption = 'Coop Shares';
                        FieldClass = FlowField; */
        }
        field(68058; "Refund Request Amount"; Decimal)
        {
            Editable = false;
        }
        field(68059; "Refund Issued"; Boolean)
        {
            Editable = false;
        }
        field(68060; "Batch No."; Code[50])
        {
            Enabled = false;

            trigger OnValidate()
            begin


            end;
        }
        field(68061; "Current Status"; Option)
        {
            OptionMembers = Approved,Rejected;
        }
        field(68062; "Cheque No."; Code[20])
        {
        }
        field(68063; "Cheque Date"; Date)
        {
        }
        field(68064; "Accrued Interest"; Decimal)
        {
            CalcFormula = sum("Detailed Cust. Ledg. Entry".Amount where("Customer No." = field("No."),
                                                                  "Transaction Type" = filter("Deposit Contribution")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(68065; "Defaulted Loans Recovered"; Boolean)
        {
        }
        field(68066; "Withdrawal Posted"; Boolean)
        {
        }
        field(68069; "Loan No. Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = "Loans Register"."Loan  No." where("Client Code" = field("No."));
        }
        field(68070; "Currect File Location"; Code[10])
        {
            CalcFormula = max("File Movement Tracker".Station where("Member No." = field("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(68071; "Move To1"; Integer)
        {
            TableRelation = "Approvals Set Up".Stage where("Approval Type" = const("File Movement"));
        }
        field(68073; "File Movement Remarks"; Text[10])
        {
            Enabled = false;
        }
        field(68076; "Status Change Date"; Date)
        {
        }
        field(68077; "Last Payment Date"; Date)
        {

            FieldClass = FlowField;
            CalcFormula = max("Cust. Ledger Entry"."Posting Date" where("Customer No." = field("No.")));
        }
        field(68078; "Discounted Amount"; Decimal)
        {
        }
        field(68079; "Current Savings"; Decimal)
        {
            CalcFormula = sum("Detailed Cust. Ledg. Entry".Amount where("Customer No." = field("No."),
                                                                   "Transaction Type" = const("Deposit Contribution")));
            FieldClass = FlowField;
        }
        field(68080; "Payroll Updated"; Boolean)
        {
        }
        field(68081; "Last Marking Date"; Date)
        {
        }
        field(68082; "Dividends Capitalised %"; Decimal)
        {

            trigger OnValidate()
            begin
                /*IF ("Dividends Capitalised %" < 0) OR ("Dividends Capitalised %" > 100) THEN
                ERROR('Invalied Entry.');*/

            end;
        }
        field(68083; "FOSA Outstanding Balance"; Decimal)
        {
            /*             CalcFormula = sum("Detailed Cust. Ledg. Entry".Amount where("Customer No." = field("No."),
                                                                              "Transaction Type" = filter("Share Capital" | "Interest Paid" | "FOSA Shares")));
                        FieldClass = FlowField; */
        }
        field(68084; "FOSA Oustanding Interest"; Decimal)
        {
            CalcFormula = sum("Detailed Cust. Ledg. Entry".Amount where("Customer No." = field("No."),
                                                                  "Transaction Type" = filter("Deposit Contribution")));
            FieldClass = FlowField;
        }
        field(68085; "Formation/Province"; Code[1])
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
        field(68086; "Division/Department"; Code[1])
        {
            TableRelation = "Member Departments"."No.";
        }
        field(68087; "Station/Section"; Code[1])
        {
            //   TableRelation = Table51516159.Field1;
        }
        field(68088; "Closing Deposit Balance"; Decimal)
        {
        }
        field(68089; "Closing Loan Balance"; Decimal)
        {
        }
        field(68090; "Closing Insurance Balance"; Decimal)
        {
        }
        field(68091; "Dividend Progression"; Decimal)
        {
        }
        field(68092; "Closing Date"; Date)
        {
            CalcFormula = max("Cust. Ledger Entry"."Posting Date" where("Customer No." = field("No.")));
            FieldClass = FlowField;
        }
        field(68093; "Welfare Fund"; Decimal)
        {
            Editable = false;
            FieldClass = Normal;
        }
        field(68094; "Discounted Dividends"; Decimal)
        {
        }
        field(68095; "Mode of Dividend Payment"; Option)
        {
            OptionCaption = ' ,FOSA,EFT,Cheque,Defaulted Loan (Capitalised)';
            OptionMembers = " ",FOSA,EFT,Cheque,"Defaulted Loan";
        }
        field(68096; "Qualifying Shares"; Decimal)
        {
        }
        field(68097; "Defaulter Overide Reasons"; Text[1])
        {
        }
        field(68098; "Defaulter Overide"; Boolean)
        {

            trigger OnValidate()
            begin


            end;
        }
        field(68099; "Closure Remarks"; Text[10])
        {
        }
        field(68100; "Bank Account No."; Code[15])
        {
        }
        field(68101; "Bank Code"; Code[10])
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
        field(68102; "Dividend Processed"; Boolean)
        {
        }
        field(68103; "Dividend Error"; Boolean)
        {
        }
        field(68104; "Dividend Capitalized"; Decimal)
        {
        }
        field(68105; "Dividend Paid FOSA"; Decimal)
        {
        }
        field(68106; "Dividend Paid EFT"; Decimal)
        {
        }
        field(68107; "Dividend Withholding Tax"; Decimal)
        {
        }
        field(68109; "Loan Last Payment Date"; Date)
        {
            FieldClass = Normal;
        }
        field(68110; "Outstanding Interest"; Decimal)
        {
            CalcFormula = sum("Detailed Cust. Ledg. Entry".Amount where("Customer No." = field("No."),
                                                                          "Transaction Type" = filter("Interest Paid" | "Interest Due")));
            FieldClass = FlowField;
        }
        field(68111; "Last Transaction Date"; Date)
        {
            FieldClass = Normal;
        }
        field(68112; "Account Category"; Enum AccountCategoryEnum)
        {

        }
        field(69000; "Group Category"; Option)
        {
            OptionMembers = "Co-operate",Chamaa;
            OptionCaption = 'Co-operate,Chamaa';
        }
        field(68113; "Type Of Organisation"; Option)
        {
            OptionCaption = ' ,Club,Association,Partnership,Investment,Merry go round,Other,Group';
            OptionMembers = " ",Club,Association,Partnership,Investment,"Merry go round",Other,Group;
        }
        field(68114; "Source Of Funds"; Option)
        {
            OptionCaption = ' ,Business Receipts,Income from Investment,Salary,Other';
            OptionMembers = " ","Business Receipts","Income from Investment",Salary,Other;
        }
        field(68115; "MPESA Mobile No"; Code[15])
        {
        }
        field(68120; "Force No."; Code[10])
        {
            Enabled = false;
        }
        field(68121; "Last Advice Date"; Date)
        {
        }
        field(68122; "Advice Type"; Option)
        {
            OptionMembers = " ","New Member","Shares Adjustment","ABF Adjustment","Registration Fees",Withdrawal,Reintroduction,"Reintroduction With Reg Fees";
        }
        field(68137; "Signing Instructions"; Option)
        {
            OptionCaption = 'Any to Sign,Two to Sign,Three to Sign,All to Sign';
            OptionMembers = "Any to Sign","Two to Sign","Three to Sign","All to Sign";
        }
        field(68140; "Share Balance BF"; Decimal)
        {
        }
        field(68143; "Move to"; Integer)
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
        field(68144; "File Movement Remarks1"; Option)
        {
            OptionCaption = ' ,Reconciliation purposes,Auditing purposes,Refunds,Loan & Signatories,Withdrawal,Risks payment,Cheque Payment,Custody,Document Filing,Passbook,Complaint Letters,Defaulters,Dividends,Termination,New Members Details,New Members Verification';
            OptionMembers = " ","Reconciliation purposes","Auditing purposes",Refunds,"Loan & Signatories",Withdrawal,"Risks payment","Cheque Payment",Custody,"Document Filing",Passbook,"Complaint Letters",Defaulters,Dividends,Termination,"New Members Details","New Members Verification";
        }
        field(68145; "File MVT User ID"; Code[10])
        {
            Enabled = false;
        }
        field(68146; "File MVT Time"; Time)
        {
        }
        field(68147; "File Previous Location"; Code[10])
        {
            Enabled = false;
        }
        field(68148; "File MVT Date"; Date)
        {
        }
        field(68149; "file received date"; Date)
        {
        }
        field(68150; "File received Time"; Time)
        {
        }
        field(68151; "File Received by"; Code[40])
        {
            Enabled = false;
        }
        field(68152; "file Received"; Boolean)
        {
        }
        field(68153; User; Code[15])
        {
            TableRelation = "User Setup";
        }
        field(68154; "Change Log"; Integer)
        {
            CalcFormula = count("Change Log Entry" where("Primary Key Field 1 Value" = field("No.")));
            FieldClass = FlowField;
        }
        field(68155; Section; Code[10])
        {
            TableRelation = if (Section = const('')) "HR Leave Carry Allocation".Status;
        }
        field(68156; rejoined; Boolean)
        {
        }
        field(68157; "Job title"; Code[10])
        {
            Enabled = false;
        }
        field(68158; "KRA Pin"; Code[100])
        {
        }
        field(68159; "Electral Zone"; Code[100])
        {
            TableRelation = "Member Delegate Zones".Code;
        }
        field(68160; "Remitance mode"; Option)
        {
            OptionCaption = ',Check off,Cash,Standing Order';
            OptionMembers = ,"Check off",Cash,"Standing Order";
        }
        field(68161; "Terms of Service"; Option)
        {
            OptionCaption = ',Permanent,Temporary,Contract';
            OptionMembers = ,Permanent,"Temporary",Contract;
        }
        field(68162; Comment1; Text[10])
        {
        }
        field(68163; Comment2; Text[10])
        {
            Enabled = false;
        }
        field(68164; "Current file location"; Code[10])
        {
            Enabled = false;
        }
        field(68165; "Work Province"; Code[10])
        {
            Enabled = false;
        }
        field(68166; "Work District"; Code[10])
        {
            Enabled = false;
        }
        field(68167; "Sacco Branch"; Code[10])
        {
        }
        field(68168; "Bank Branch Code"; Code[20])
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
        field(68169; "Customer Paypoint"; Code[10])
        {
            Enabled = false;
        }
        field(68170; "Date File Opened"; Date)
        {
        }
        field(68171; "File Status"; Code[10])
        {
            Enabled = false;
        }
        field(68172; "Customer Title"; Code[10])
        {
            Enabled = false;
        }
        field(68173; "Folio Number"; Code[10])
        {
            Enabled = false;
        }
        field(68174; "Move to description"; Text[20])
        {
            Enabled = false;
        }
        field(68175; Filelocc; Integer)
        {
            CalcFormula = max("File Movement Tracker"."Entry No." where("Member No." = field("No.")));
            FieldClass = FlowField;
        }
        field(68176; "S Card No."; Code[10])
        {
        }
        field(68177; "Reason for file overstay"; Text[10])
        {
            Enabled = false;
        }
        field(68179; "Loc Description"; Text[10])
        {
            Enabled = false;
        }
        field(68180; "Current Balance"; Decimal)
        {
        }
        field(68181; "Member Transfer Date"; Date)
        {
        }
        field(68182; "Contact Person"; Code[20])
        {
        }
        field(68183; "Member withdrawable Deposits"; Decimal)
        {
            // CalcFormula = sum("Detailed Cust. Ledg. Entry".Amount where("Customer No." = field("No."),
            //                                                       "Posting Date" = field("Date Filter"),
            //                                                       "Document No." = field("Document No. Filter"),
            //                                                       "Transaction Type" = const(depe)));
            // FieldClass = FlowField;
        }
        field(68184; "Current Location"; Text[10])
        {
            Enabled = false;
        }
        field(68185; "Group Code"; Code[10])
        {
            Enabled = false;
        }
        field(68186; "Xmas Contribution"; Decimal)
        {
            // CalcFormula = sum("Detailed Cust. Ledg. Entry".Amount where("Customer No." = field("No."),
            //                                                        "Transaction Type" = const("Silver Savings"),
            //                                                        "Posting Date" = field("Date Filter"),
            //                                                        "Document No." = field("Document No. Filter")));
            Editable = false;
            // FieldClass = FlowField;
        }
        field(68187; "Risk Fund"; Decimal)
        {
            /*             CalcFormula = sum("Detailed Cust. Ledg. Entry".Amount where("Customer No." = field("No."),
                                                                               "Transaction Type" = const("Benevolent Fund"),
                                                                               "Posting Date" = field("Date Filter"),
                                                                               "Document No." = field("Document No. Filter")));
                        Editable = false;
                        FieldClass = FlowField; */
        }
        field(68188; "Office Branch"; Code[2])
        {
        }
        field(68189; Department; Code[1])
        {
            TableRelation = "Member Departments"."No.";
        }
        field(68190; Occupation; Text[20])
        {
        }
        field(68191; Designation; Code[2048])
        {
            TableRelation = Designation.Designation;
        }
        field(68192; "Village/Residence"; Text[30])
        {
            TableRelation = "Approvals Set Up".Stage where("Approval Type" = const("File Movement"));
        }
        field(68194; "Contact Person Phone"; Code[20])
        {
        }
        field(68195; "Development Shares"; Decimal)
        {
            // CalcFormula = sum("Detailed Cust. Ledg. Entry".Amount where("Customer No." = field("No."),
            //                                                       "Transaction Type" = filter(),
            //                                                       "Posting Date" = field("Date Filter")));
            // FieldClass = FlowField;
        }
        field(68198; "Recruited By"; Code[40])
        {
        }
        field(68200; "ContactPerson Relation"; Code[15])
        {
            TableRelation = "Relationship Types";
        }
        field(68201; "ContactPerson Occupation"; Code[15])
        {
        }
        field(68206; "Insurance on Shares"; Decimal)
        {
        }
        field(68207; Disabled; Boolean)
        {
        }
        field(68212; "Mobile No. 2"; Code[15])
        {
        }
        field(68213; "Employer Name"; Code[100])
        {
        }
        field(68214; Title; Enum "TitleEnum")
        {
            DataClassification = ToBeClassified;
        }
        field(68215; Town; Code[15])
        {
            Editable = false;
            TableRelation = "Post Code".City;
        }
        field(68222; "Home Town"; Code[10])
        {
            Editable = false;
        }
        field(69038; "Loans Defaulter Status"; Option)
        {
            CalcFormula = lookup("Loans Register"."Loans Category-SASRA" where("Client Code" = field("No.")));
            FieldClass = FlowField;
            OptionCaption = 'Perfoming,Watch,Substandard,Doubtful,Loss';
            OptionMembers = Perfoming,Watch,Substandard,Doubtful,Loss;
        }
        field(69039; "Home Postal Code"; Code[10])
        {
            TableRelation = "Post Code".Code;
        }
        field(69040; "Total Loans Outstanding"; Decimal)
        {
            CalcFormula = sum("Detailed Cust. Ledg. Entry".Amount where("Customer No." = field("No."),
                                                                  "Transaction Type" = filter(Loan | Repayment)));
            FieldClass = FlowField;
        }
        field(69041; "No of Loans Guaranteed"; Integer)
        {
            CalcFormula = count("Loans Guarantee Details" where("Member No" = field("No."),
                                                                 "Outstanding Balance" = filter(<> 0),
                                                                 Substituted = const(false)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(69046; "Member Can Guarantee  Loan"; Boolean)
        {
        }
        field(69047; "FOSA  Account Bal"; Decimal)
        {
            CalcFormula = - sum("Detailed Vendor Ledg. Entry".Amount where("Vendor No." = field("FOSA Account No."),
                                                                            Reversed = filter(false), "Posting Date" = field("Date Filter")));

            Editable = false;
            FieldClass = FlowField;
        }
        field(69048; "Rejoining Date"; Date)
        {
        }
        field(69049; "Active Loans Guarantor"; Integer)
        {
            CalcFormula = count("Loans Guarantee Details" where("Member No" = field("No."),
                                                                 "Outstanding Balance" = filter(> 0)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(69050; "Loans Guaranteed"; Integer)
        {
            CalcFormula = count("Loans Guarantee Details" where("Substituted Guarantor" = field("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(69051; "Member Deposit Mult 3"; Decimal)
        {
        }
        field(69052; "New loan Eligibility"; Decimal)
        {
        }
        field(69053; "Share Certificate No"; Integer)
        {
        }
        field(69054; "Last Share Certificate No"; Integer)
        {
            CalcFormula = max("Members Register"."Share Certificate No");
            FieldClass = FlowField;
        }
        field(69055; "No Of Days"; Integer)
        {
        }
        field(69056; "Application No."; Code[20])
        {
            CalcFormula = lookup("Members Register"."No." where("No." = field("No.")));
            Editable = true;
            FieldClass = FlowField;
            TableRelation = "Members Register"."No.";
        }
        field(69057; "Member Category"; Option)
        {
            OptionCaption = 'New Application,Account Reactivation,Transfer';
            OptionMembers = "New Application","Account Reactivation",Transfer;
        }
        field(69058; "Terms Of Employment"; Option)
        {
            OptionCaption = ' ,Permanent,Temporary,Contract,Private,Probation';
            OptionMembers = " ",Permanent,"Temporary",Contract,Private,Probation;
        }
        field(69059; "Nominee Envelope No."; Code[20])
        {
            Enabled = false;
        }
        field(69060; Defaulter; Boolean)
        {
        }
        field(69061; "Shares Variance"; Decimal)
        {
        }
        field(69062; "Net Dividend Payable"; Decimal)
        {
        }
        field(69063; "Tax on Dividend"; Decimal)
        {
        }
        field(69064; "Div Amount"; Decimal)
        {
        }
        field(69065; "Payroll Agency"; Code[10])
        {
            Enabled = false;
        }
        field(69066; "Introduced By"; Code[40])
        {
            Enabled = false;
        }
        field(69067; "Introducer Name"; Text[20])
        {
            Enabled = false;
        }
        field(69068; "Introducer Staff No"; Code[20])
        {
            Enabled = false;
        }
        field(69069; BoostedDate; Date)
        {
        }
        field(69070; BoostedAmount; Decimal)
        {
        }
        field(69071; "Bridge Amount Release"; Decimal)
        {
            CalcFormula = sum("Loan Offset Details"."Monthly Repayment" where("Client Code" = field("No.")));
            FieldClass = FlowField;
        }
        field(69072; "Repayment Method"; Option)
        {
            OptionCaption = ' ,Amortised,Reducing Balance,Straight Line,Constants,Ukulima Flat';
            OptionMembers = " ",Amortised,"Reducing Balance","Straight Line",Constants,"Ukulima Flat";
        }
        field(69073; Staff; Boolean)
        {
        }
        field(69074; "Death date"; Date)
        {
        }
        field(69075; "Edit Status"; Option)
        {
            OptionCaption = 'Open,Pending,Approved,Rejected';
            OptionMembers = Open,Pending,Approved,Rejected;
        }
        field(69076; "Deposit Boosted Date"; Date)
        {
        }
        field(69077; "Deposit Boosted Amount"; Decimal)
        {
        }
        field(69078; "Investment Account"; Decimal)
        {
            CalcFormula = sum("Detailed Cust. Ledg. Entry".Amount where("Customer No." = field("No."),
                                                                  "Posting Date" = field("Date Filter"),
                                                                  "Document No." = field("Document No. Filter"),
                                                                  "Transaction Type" = const("Loan Insurance Charged")));
            FieldClass = FlowField;
        }
        field(69079; "Mobile No 3"; Code[15])
        {
        }
        field(69080; "Share Capital B Class"; Decimal)
        {
            CalcFormula = sum("Detailed Cust. Ledg. Entry".Amount where("Customer No." = field("No."),
                                                                   "Posting Date" = field("Date Filter"),
                                                                   "Document No." = field("Document No. Filter"),
                                                                   "Transaction Type" = const("Share Capital")));
            FieldClass = FlowField;
        }
        field(69081; "Normal Shares B Class"; Decimal)
        {
            CalcFormula = sum("Detailed Cust. Ledg. Entry".Amount where("Customer No." = field("No."),
                                                                   "Posting Date" = field("Date Filter"),
                                                                   "Document No." = field("Document No. Filter"),
                                                                   "Transaction Type" = const("Share Capital")));
            FieldClass = FlowField;
        }
        field(69082; "FOSA Shares"; Decimal)
        {
            CalcFormula = sum("Detailed Vendor Ledg. Entry".Amount where("Vendor No." = field("FOSA Shares Account No"),
                                                                           "Posting Date" = field("Date Filter")));
            FieldClass = FlowField;
        }
        field(69083; "Members Parish"; Code[10])
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
        field(69084; "Parish Name"; Text[20])
        {
            Enabled = false;
        }
        field(69085; "Occupation Details"; Option)
        {
            OptionCaption = ' ,Employed,Self-Employed,Contracting,Others,Employed & Self Employed';
            OptionMembers = " ",Employed,"Self-Employed",Contracting,Others,"Employed & Self Employed";
        }
        field(69086; "Contracting Details"; Text[20])
        {
        }
        field(69087; "Others Details"; Text[15])
        {
        }
        field(69088; Products; Option)
        {
            OptionCaption = 'BOSA Account,BOSA+Current Account,BOSA+Smart Saver,BOSA+Fixed Deposit,Smart Saver Only,Current Only,Fixed  Deposit Only,Fixed+Smart Saver,Fixed+Current,Current+Smart Saver';
            OptionMembers = "BOSA Account","BOSA+Current Account","BOSA+Smart Saver","BOSA+Fixed Deposit","Smart Saver Only","Current Only","Fixed  Deposit Only","Fixed+Smart Saver","Fixed+Current","Current+Smart Saver";
        }
        field(69089; "Joint Account Name"; Text[35])
        {
        }
        field(69090; "Postal Code 2"; Code[10])
        {
            TableRelation = "Post Code";
        }
        field(69091; "Town 2"; Code[20])
        {
        }
        field(69092; "Passport 2"; Code[20])
        {
        }
        field(69093; "Member Parish 2"; Code[1])
        {
            Enabled = false;
        }
        field(69094; "Member Parish Name 2"; Text[1])
        {
            Enabled = false;
        }
        field(69095; "Name of the Group/Corporate"; Text[30])
        {
        }
        field(69096; "Date of Registration"; Date)
        {
        }
        field(69097; "No of Members"; Integer)
        {
        }
        field(69098; "Group/Corporate Trade"; Code[20])
        {
        }
        field(69099; "Certificate No"; Code[25])
        {
        }
        field(69100; "ID No.2"; Code[15])
        {
        }
        field(69101; "Picture 2"; Blob)
        {
            Enabled = false;
            SubType = Bitmap;
        }
        field(69102; "Signature  2"; Blob)
        {
            Enabled = false;
            SubType = Bitmap;
        }
        field(69103; Title2; Option)
        {
            OptionCaption = ' ,Mr.,Mrs.,Miss.,DR.,Prof.,Fr.,Sr.,Bro.';
            OptionMembers = " ","Mr.","Mrs.","Miss.","DR.","Prof.","Fr.","Sr.","Bro.";
        }
        field(69104; "Mobile No. Three"; Code[15])
        {
        }
        field(69105; "Date of Birth2"; Date)
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
        field(69106; "Marital Status2"; Option)
        {
            OptionMembers = " ",Single,Married,Devorced,Widower,Widow;
        }
        field(69107; Gender2; Option)
        {
            OptionCaption = ' ,Male,Female';
            OptionMembers = " ",Male,Female;
        }
        field(69108; "Address3-Joint"; Code[15])
        {
            Enabled = false;
        }
        field(69109; "Home Postal Code2"; Code[15])
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
        field(69110; "Home Town2"; Text[15])
        {
        }
        field(69111; "Payroll/Staff No2"; Code[5])
        {
            Enabled = false;
        }
        field(69112; "Employer Code2"; Code[5])
        {
            TableRelation = "HR Asset Transfer Header";

            trigger OnValidate()
            begin
                Employer.Get("Employer Code");
                "Employer Name" := Employer."Employer Name";
            end;
        }
        field(69113; "Employer Name2"; Code[10])
        {
        }
        field(69114; "E-Mail (Personal3)"; Text[5])
        {
            Enabled = false;
        }
        field(69115; "Member Share Class"; Option)
        {
            OptionCaption = ' ,Class A,Class B';
            OptionMembers = " ","Class A","Class B";
        }
        field(69116; "Member's Residence"; Code[35])
        {
        }
        field(69117; "Postal Code 3"; Code[15])
        {
            Enabled = false;
            TableRelation = "Post Code";
        }
        field(69118; "Town 3"; Code[15])
        {
            Enabled = false;
        }
        field(69119; "Passport 3"; Code[15])
        {
            Enabled = false;
        }
        field(69120; "Member Parish 3"; Code[10])
        {
            Enabled = false;
        }
        field(69121; "Member Parish Name 3"; Text[10])
        {
            Enabled = false;
        }
        field(69122; "Picture 3"; Blob)
        {
            SubType = Bitmap;
        }
        field(69123; "Signature  3"; Blob)
        {
            SubType = Bitmap;
        }
        field(69124; Title3; Option)
        {
            OptionCaption = ' ,Mr.,Mrs.,Miss.,DR.,Prof.,Fr.,Sr.,Bro.';
            OptionMembers = " ","Mr.","Mrs.","Miss.","DR.","Prof.","Fr.","Sr.","Bro.";
        }
        field(69125; "Mobile No. 3-Joint"; Code[15])
        {
        }
        field(69126; "Date of Birth3"; Date)
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
        field(69127; "Marital Status3"; Option)
        {
            Enabled = false;
            OptionMembers = " ",Single,Married,Devorced,Widower,Widow;
        }
        field(69128; Gender3; Option)
        {
            Enabled = false;
            OptionCaption = ' ,Male,Female';
            OptionMembers = " ",Male,Female;
        }
        field(69129; Address3; Code[10])
        {
            Enabled = false;
        }
        field(69130; "Home Postal Code3"; Code[5])
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
        field(69131; "Home Town3"; Text[10])
        {
            Enabled = false;
        }
        field(69132; "Payroll/Staff No3"; Code[15])
        {
            Enabled = false;
        }
        field(69133; "Employer Code3"; Code[5])
        {
            Enabled = false;
            TableRelation = "HR Asset Transfer Header";

            trigger OnValidate()
            begin
                Employer.Get("Employer Code");
                "Employer Name" := Employer."Employer Name";
            end;
        }
        field(69134; "Employer Name3"; Code[5])
        {
            Enabled = false;
        }
        field(69135; "E-Mail (Personal2)"; Text[15])
        {
        }
        field(69136; "Name 3"; Code[20])
        {
        }
        field(69137; "ID No.3"; Code[10])
        {
        }
        field(69138; "Mobile No. 4"; Code[5])
        {
        }
        field(69139; Address4; Code[5])
        {
            Enabled = false;
        }
        field(69140; "Assigned System ID"; Code[15])
        {
            Enabled = false;
            TableRelation = User."User Name";
        }
        field(69141; "Risk Fund Arrears"; Decimal)
        {
            // CalcFormula = sum("Detailed Cust. Ledg. Entry".Amount where("Customer No." = field("No."),
            //                                                       "Transaction Type" = filter("45" | "44"),
            //                                                       "Posting Date" = field("Date Filter")));
            // FieldClass = FlowField;
        }
        field(69142; Password; Text[20])
        {
        }
        field(69143; "Pension No"; Code[15])
        {
        }
        field(69144; "Benevolent Fund"; Decimal)
        {
            /*             CalcFormula = - sum("Detailed Cust. Ledg. Entry".Amount where("Customer No." = field("No."),
                                                                              "Posting Date" = field("Date Filter"),
                                                                              "Transaction Type" = filter("Benevolent Fund")));
                        FieldClass = FlowField; */
        }
        field(69145; "Risk Fund Paid"; Decimal)
        {
            // CalcFormula = sum("Detailed Cust. Ledg. Entry".Amount where("Customer No." = field("No."),
            //                                                       "Transaction Type" = filter(),
            //                                                       "Posting Date" = field("Date Filter")));
            // FieldClass = FlowField;
        }
        field(69146; "BRID No"; Code[15])
        {
            Enabled = false;
        }
        field(69147; "Gross Dividend Amount Payable"; Decimal)
        {
        }
        field(69148; "Card No"; Code[15])
        {
        }
        field(69149; "Funeral Rider"; Decimal)
        {
            // CalcFormula = sum("Detailed Cust. Ledg. Entry".Amount where("Customer No." = field("No."),
            //                                                       "Transaction Type" = filter("48"),
            //                                                       "Posting Date" = field("Date Filter")));
            // FieldClass = FlowField;
        }
        field(69150; "Loan Liabilities"; Decimal)
        {
            CalcFormula = sum("Detailed Cust. Ledg. Entry".Amount where("Customer No." = field("No."),
                                                                  "Posting Date" = field("Date Filter"),
                                                                  "Transaction Type" = filter("Share Capital" | "Interest Paid" | "Deposit Contribution")));
            FieldClass = FlowField;
        }
        field(69151; "Last Deposit Contribution Date"; Date)
        {
            CalcFormula = max("Cust. Ledger Entry"."Posting Date" where("Customer No." = field("No."),
                                                                          "Transaction Type" = filter("Deposit Contribution"),
                                                                          Amount = filter(< 0)));
            FieldClass = FlowField;
        }
        field(69153; "Member House Group"; Code[15])
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
        field(69154; "Member House Group Name"; Code[20])
        {
        }
        field(69155; "No Of Group Members."; Integer)
        {
        }
        field(69156; "Group Account Name"; Code[20])
        {
            Enabled = false;
        }
        field(69157; "Business Loan Officer"; Code[10])
        {
        }
        field(69158; "Group Account"; Boolean)
        {
        }
        field(69160; "FOSA Account"; Code[15])
        {
        }
        field(69161; "Micro Group Code"; Code[5])
        {
            Enabled = false;
        }
        field(69162; "Loan Officer Name"; Code[15])
        {
            Enabled = false;
        }
        field(69163; "BOSA Account No."; Code[15])
        {
        }
        field(69164; "Any Other Sacco"; Text[5])
        {
        }
        field(69165; "Member class"; Option)
        {
            OptionCaption = ',Plantinum A,Plantinum B,Diamond,Gold';
            OptionMembers = ,"Plantinum A","Plantinum B",Diamond,Gold;
        }
        field(69166; "Employment Terms"; Option)
        {
            OptionCaption = ' ,Permanent,Casual';
            OptionMembers = " ",Permanent,Casual;
        }
        field(69167; "Group Deposits"; Decimal)
        {
            CalcFormula = sum("Detailed Cust. Ledg. Entry".Amount where("Group Code" = field("No."),
                                                                   "Transaction Type" = filter("Deposit Contribution"),
                                                                   "Posting Date" = field("Date Filter")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(69168; "Group Loan Balance"; Decimal)
        {
            CalcFormula = sum("Detailed Cust. Ledg. Entry".Amount where("Group Code" = field("No."),
                                                                  "Transaction Type" = filter(Loan | Repayment),
                                                                  "Posting Date" = field("Date Filter")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(69169; "No of Group Members"; Integer)
        {
            Editable = false;
        }
        field(69170; "No of Active Group Members"; Integer)
        {
            Editable = false;
        }
        field(69171; "No of Dormant Group Members"; Integer)
        {
            Editable = false;
            FieldClass = Normal;
        }
        field(69172; "Pending Loan Application Amt"; Decimal)
        {
            CalcFormula = sum("Loans Register"."Requested Amount" where("Client Code" = field("No."),
                                                                          "Loan Status" = filter(Application | Appraisal)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(69173; "Pending Loan Application No."; Code[30])
        {
            CalcFormula = lookup("Loans Register"."Loan  No." where("Client Code" = field("No."),
                                                                     "Loan Status" = filter(Application | Appraisal)));
            FieldClass = FlowField;
        }
        field(69174; "Member Of a Group"; Boolean)
        {
        }
        field(69175; TLoansGuaranteed; Decimal)
        {
            CalcFormula = sum("Loans Guarantee Details"."Amont Guaranteed" where("Member No" = field("No."),
                                                                                  "Outstanding Balance" = filter(> 0)));
            FieldClass = FlowField;
        }
        field(69176; "Total Committed Shares"; Decimal)
        {
            CalcFormula = sum("Loans Guarantee Details"."Amont Guaranteed" where("Member No" = field("No."),
                                                                                  "Outstanding Balance" = filter(> 0)));
            FieldClass = FlowField;
        }
        field(69177; "Existing Loan Repayments"; Decimal)
        {
            CalcFormula = sum("Loans Register".Repayment where("Client Code" = field("No."),
                                                                Posted = const(true),
                                                                "Outstanding Balance" = filter(> 0)));
            FieldClass = FlowField;
        }
        field(69178; "Existing Fosa Loan Repayments"; Decimal)
        {
            CalcFormula = sum("Loans Register".Repayment where("Client Code" = field("FOSA Account No.")));
            FieldClass = FlowField;
        }
        field(69179; "Employer Address"; Code[20])
        {
        }
        field(69180; "Date of Employment"; Date)
        {
        }
        field(69181; "Position Held"; Code[20])
        {
        }
        field(69182; "Expected Monthly Income"; Code[20])
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
        field(69183; "Nature Of Business"; Code[30])
        {
        }
        field(69184; Industry; Code[15])
        {
        }
        field(69185; "Business Name"; Code[30])
        {
        }
        field(69186; "Physical Business Location"; Code[25])
        {
        }
        field(69187; "Year of Commence"; Date)
        {
        }
        field(69188; "Identification Document"; Option)
        {
            OptionCaption = 'National_ID,Passport Card,Aliens Card,Birth Certificate,Company Reg. No,Driving License';
            OptionMembers = "National_ID","Passport Card","Aliens Card","Birth Certificate","Company Reg. No","Driving License";
        }
        field(69189; "Referee Member No"; Code[10])
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
        field(69190; "Referee Name"; Code[40])
        {
            Editable = false;
        }
        field(69191; "Referee ID No"; Code[20])
        {
            Editable = false;
        }
        field(69192; "Referee Mobile Phone No"; Code[15])
        {
            Editable = false;
        }
        field(69193; "Email Indemnified"; Boolean)
        {
        }
        field(69194; "Send E-Statements"; Boolean)
        {
        }
        field(69195; "Reason For Membership Withdraw"; Option)
        {
            OptionCaption = 'Relocation,Financial Constraints,House/Group Challages,Join another Institution,Personal Reasons,Other';
            OptionMembers = Relocation,"Financial Constraints","House/Group Challages","Join another Institution","Personal Reasons",Other;
        }
        field(69196; "Action On Dividend Earned"; Option)
        {
            OptionCaption = 'Pay to FOSA Account,Capitalize On Deposits,Repay Loans';
            OptionMembers = "Pay to FOSA Account","Capitalize On Deposits","Repay Loans";
        }
        field(69197; "Deposits Account No"; Code[15])
        {
            FieldClass = FlowField;
            CalcFormula = lookup(Vendor."No." where("BOSA Account No" = field("No."), "Account Type" = filter('003')));
        }
        field(69198; "Share Capital No"; Code[15])
        {
            FieldClass = FlowField;
            CalcFormula = lookup(Vendor."No." where("BOSA Account No" = field("No."), "Account Type" = filter('002')));
        }
        field(69199; "Benevolent Fund No"; Code[15])
        {
        }
        field(69200; "Loans Recoverd from Guarantors"; Decimal)
        {
            CalcFormula = sum("Detailed Cust. Ledg. Entry".Amount where("Customer No." = field("No."),
                                                                   "Recovery Transaction Type" = filter("Guarantor Recoverd"),
                                                                   "Document No." = field("Document No. Filter"),
                                                                   "Posting Date" = field("Date Filter")));
            FieldClass = FlowField;
        }
        field(69201; "Loan Recovered From Guarantors"; Code[20])
        {
            CalcFormula = lookup("Cust. Ledger Entry"."Recoverd Loan" where("Customer No." = field("No.")));
            FieldClass = FlowField;
        }
        field(69202; "ID Date of Issue"; Date)
        {
        }
        field(69203; "Literacy Level"; Text[25])
        {
        }
        field(69204; "Created By"; Code[200])
        {
        }
        field(69205; "Modified By"; Code[48])
        {
        }
        field(69206; "Modified On"; Date)
        {
        }
        field(69207; "Approved By"; Code[48])
        {
        }
        field(69208; "Approved On"; Date)
        {
        }
        field(69210; "Additional Shares"; Decimal)
        {
            CalcFormula = sum("Detailed Vendor Ledg. Entry".Amount where("Vendor No." = field("Additional Shares Account No"),
                                                                           "Posting Date" = field("Date Filter")));
            FieldClass = FlowField;
        }
        field(69211; "FOSA Shares Account No"; Code[15])
        {
        }
        field(69212; "Additional Shares Account No"; Code[15])
        {
        }
        field(69213; "No of House Group Changes"; Integer)
        {
            CalcFormula = count("House Group Change Request" where("Member No" = field("No."),
                                                                    "Change Effected" = filter(true)));
            FieldClass = FlowField;
        }
        field(69215; "Last Contribution Entry No"; Integer)
        {
            CalcFormula = max("Cust. Ledger Entry"."Entry No." where("Customer No." = field("No."),
                                                                       "Transaction Type" = filter("Deposit Contribution"),
                                                                       Amount = filter(< 0)));
            FieldClass = FlowField;
        }
        field(69216; "House Group Status"; Option)
        {
            OptionCaption = 'Active,Exiting the Group';
            OptionMembers = Active,"Exiting the Group";
        }
        field(69217; "Member Residency Status"; Text[20])
        {
            Description = 'What is the customer''s residency status?';
            TableRelation = "Customer Risk Rating"."Sub Category" where(Category = filter("Residency Status"));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(69218; "Individual Category"; Text[40])
        {
            Description = 'What is the customer category?';
            TableRelation = "Customer Risk Rating"."Sub Category" where(Category = filter(Individuals));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(69219; Entities; Text[35])
        {
            Description = 'What is the Entity Type?';
            TableRelation = "Customer Risk Rating"."Sub Category" where(Category = filter(Entities));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(69220; "Industry Type"; Text[40])
        {
            Description = 'What Is the Industry Type?';
            TableRelation = "Customer Risk Rating"."Sub Category" where(Category = filter(Industry));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(69221; "Length Of Relationship"; Text[35])
        {
            Description = 'What Is the Lenght Of the Relationship';
            TableRelation = "Customer Risk Rating"."Sub Category" where(Category = filter("Length Of Relationship"));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(69222; "International Trade"; Text[35])
        {
            Description = 'Is the customer involved in International Trade?';
            TableRelation = "Customer Risk Rating"."Sub Category" where(Category = filter("International Trade"));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(69223; "Electronic Payment"; Text[20])
        {
            Description = 'Does the customer engage in electronic payments?';
            TableRelation = "Product Risk Rating"."Product Type Code" where("Product Category" = filter("Electronic Payment"));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(69224; "Accounts Type Taken"; Text[40])
        {
            Description = 'Which account type is the customer taking?';
            TableRelation = "Product Risk Rating"."Product Type Code" where("Product Category" = filter(Accounts));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(69225; "Cards Type Taken"; Text[15])
        {
            Description = 'Which card is the customer taking?';
            TableRelation = "Product Risk Rating"."Product Type Code" where("Product Category" = filter(Cards));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(69226; "Others(Channels)"; Text[40])
        {
            Description = 'Which products or channels is the customer taking?';
            TableRelation = "Product Risk Rating"."Product Type Code" where("Product Category" = filter(Others));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(69227; "No of BD Trainings Attended"; Integer)
        {
            CalcFormula = count("CRM Traineees" where("Member No" = field("No."),
                                                       Attended = filter(true)));
            FieldClass = FlowField;
        }
        field(69228; "Member Needs House Group"; Boolean)
        {
        }
        field(69229; "Exit Application Done By"; Code[40])
        {
        }
        field(69230; "Exit Application Done On"; Date)
        {
        }
        field(69231; "Member Risk Level"; Option)
        {
            OptionCaption = 'Low Risk,Medium Risk,High Risk';
            OptionMembers = "Low Risk","Medium Risk","High Risk";
        }
        field(69232; "Due Diligence Measure"; Text[40])
        {
        }
        field(69233; "Monthly TurnOver_Actual"; Decimal)
        {
        }
        field(69234; "Password Reset Date"; DateTime)
        {
        }
        field(69235; "FOSA Shares Status"; Option)
        {
            CalcFormula = lookup(Vendor.Status where("No." = field("FOSA Shares Account No")));
            FieldClass = FlowField;
            OptionCaption = 'Active,Closed,Dormant,Frozen,Deceased';
            OptionMembers = Active,Closed,Dormant,Frozen,Deceased;
        }
        field(69236; "Share Capital Status"; Option)
        {
            CalcFormula = lookup(Vendor.Status where("No." = field("Share Capital No")));
            FieldClass = FlowField;
            OptionMembers = Active,Closed,Dormant,Frozen,Deceased;
        }
        field(69237; "Deposits Account Status"; Option)
        {
            CalcFormula = lookup(Vendor.Status where("No." = field("Deposits Account No")));
            FieldClass = FlowField;
            OptionCaption = 'Active,Closed,Dormant,Frozen,Deceased';
            OptionMembers = Active,Closed,Dormant,Frozen,Deceased;
        }
        field(69238; "Previous Status"; Option)
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
        field(69239; "Status Changed On"; Date)
        {
        }
        field(69240; "Status Changed By"; Code[40])
        {
        }
        field(69241; Agee; Integer)
        {
        }
        field(69242; "No of Next of Kin"; Integer)
        {
            CalcFormula = count("Members Next of Kin" where("Account No" = field("No.")));
            FieldClass = FlowField;
        }
        field(69243; "Insider Status"; Option)
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
        field(69244; Dormancy; Boolean)
        {
            CalcFormula = exist("Detailed Vendor Ledg. Entry" where("Member No" = field("No."),
                                                                     "Posting Date" = field("Date Filter")));
            FieldClass = FlowField;
        }
        field(69245; "OTP Code"; Code[5])
        {
        }
        field(69246; "Total BOSA Loan Balance"; Decimal)
        {
            CalcFormula = sum("Detailed Cust. Ledg. Entry".Amount where("Customer No." = field("No."),
                                                                  "Transaction Type" = filter(Loan | Repayment),
                                                                  "Loan Type" = filter('301' | '302' | '303' | '306' | '322')));
            FieldClass = FlowField;
        }
        field(69247; "Benevolent Fund Historical"; Decimal)
        {
            CalcFormula = sum("Member Historical Ledger Entry"."Credit Amount" where("Account No." = field("Benevolent Fund No"),
                                                                                      "Posting Date" = field("Date Filter")));
            FieldClass = FlowField;
        }
        field(69248; "Deposits Contributed"; Decimal)
        {
            CalcFormula = sum("Detailed Vendor Ledg. Entry"."Credit Amount" where("Vendor No." = field("Deposits Account No"),
                                                                                   "Posting Date" = field("Date Filter"),
                                                                                   "Document No." = filter(<> 'BALB/F9THNOV2018')));
            Editable = false;
            FieldClass = FlowField;
        }
        field(69249; "Deposit Contributed Historical"; Decimal)
        {
            CalcFormula = sum("Member Historical Ledger Entry"."Credit Amount" where("Account No." = field("Deposits Account No"),
                                                                                      "Posting Date" = field("Date Filter")));
            FieldClass = FlowField;
        }
        field(69250; "Deposits Penalty Exists"; Boolean)
        {
            CalcFormula = exist("Deposit Arrears Penalty Buffer" where(Settled = filter(false),
                                                                        "Member No" = field("No.")));
            FieldClass = FlowField;
        }
        field(69251; "LSA Account No"; Code[20])
        {
            CalcFormula = lookup(Vendor."No." where("BOSA Account No" = field("No."),
                                                     Status = filter(<> Closed | Deceased),
                                                     "Account Type" = filter(507)));
            FieldClass = FlowField;
        }
        field(69252; "Block Mobile Loan"; Boolean)
        {
        }
        field(69253; "Member Deposits"; Decimal)
        {
            CalcFormula = sum("Detailed Vendor Ledg. Entry".Amount where("Vendor No." = field("Deposits Account No")));
            FieldClass = FlowField;
        }
        field(69254; "Deposit Multiplier"; Integer)
        {
            CalcFormula = max("Product Deposit>Loan Analysis"."Deposit Multiplier" where("Product Code" = filter('301'),
                                                                                          "Minimum Deposit" = field(upperlimit("Current Shares")),
                                                                                          "Minimum Share Capital" = field(upperlimit("Shares Retained"))));
            FieldClass = FlowField;
        }
        field(69255; "Computer Name"; Text[10])
        {
        }
        field(69256; "Online Member"; Boolean)
        {
        }
        field(69257; "KYC Completed"; Boolean)
        {
        }
        field(69258; "Expected Monthly Income Amount"; Decimal)
        {
        }
        field(69259; "Block Normal Loan"; Boolean)
        {
        }
        field(69260; "Additional Shares Status"; Option)
        {
            CalcFormula = lookup(Vendor.Status where("No." = field("Additional Shares Account No")));
            FieldClass = FlowField;
            OptionCaption = 'Active,Closed,Dormant,Frozen,Deceased';
            OptionMembers = Active,Closed,Dormant,Frozen,Deceased;
        }
        field(69261; PictureEmpty; Boolean)
        {
        }
        field(69262; SignatureEmpty; Boolean)
        {
        }
        field(69263; "First Name"; Code[200])
        {
        }
        field(69264; "Middle Name"; Code[200])
        {

            trigger OnValidate()
            begin
                /*FnRunCheckApplicantAgainstSactions("First Name","Middle Name","Last Name");
                FnRunCheckApplicantAgainstPEPs("First Name","Middle Name","Last Name");
                */

            end;
        }
        field(69265; "Last Name"; Code[200])
        {

            trigger OnValidate()
            begin
                /*FnRunCheckApplicantAgainstSactions("First Name","Middle Name","Last Name");
                FnRunCheckApplicantAgainstPEPs("First Name","Middle Name","Last Name");*/

            end;
        }
        field(69266; "Referee Risk Rate"; Text[30])
        {
        }
        field(69267; "Has ATM Card"; Boolean)
        {
            CalcFormula = exist("ATM Card Nos Buffer" where("ID No" = field("ID No.")));
            FieldClass = FlowField;
        }
        field(69268; "Is Mobile Registered"; Boolean)
        {
        }
        field(69269; "Referee Commission Paid"; Boolean)
        {
        }
        field(69270; "Deposits Contributed Ver1"; Decimal)
        {
            CalcFormula = sum("Detailed Vendor Ledg. Entry".Amount where("Vendor No." = field("Deposits Account No"),
                                                                          "Posting Date" = field("Date Filter")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(69271; "Member Last Transaction Date"; Date)
        {
            CalcFormula = max("Detailed Cust. Ledg. Entry"."Posting Date" where("Customer No." = field("No."), "Transaction Type" = filter("Deposit Contribution")));
            FieldClass = FlowField;
        }
        field(69272; "Dormant Date"; Date)
        {
        }
        field(69273; "Last Transaction Date VerII"; Date)
        {
        }
        field(69274; "Member Credit Score"; Decimal)
        {
        }
        field(69275; "Member Credit Score Desc."; Text[5])
        {
        }
        field(69276; "Member Payment Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Checkoff,Standing Order';
            OptionMembers = " ",Checkoff,"Standing Order";
        }
        field(69277; "Standing Order No"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(69278; "Bank Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(69279; "Has Silver Deposit"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(69280; "Silver Account No"; Code[1])
        {
            DataClassification = ToBeClassified;
        }
        field(69281; "Bank Branch Name"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(69282; "Junior Savings"; Decimal)
        {
            // CalcFormula = sum("Detailed Cust. Ledg. Entry".Amount where("Customer No." = field("No."),
            //                                                        "Transaction Type" = const("Junior Savings"),
            //                                                        "Posting Date" = field("Date Filter")));
            Editable = false;
            // FieldClass = FlowField;
        }
        field(69283; "Safari Savings"; Decimal)
        {
            // CalcFormula = sum("Detailed Cust. Ledg. Entry".Amount where("Customer No." = field("No."),
            //                                                        "Transaction Type" = const("Safari Savings"),
            //                                                        "Posting Date" = field("Date Filter")));
            Editable = false;
            // FieldClass = FlowField;
        }
        field(69284; "Silver Savings"; Decimal)
        {
            // CalcFormula = sum("Detailed Cust. Ledg. Entry".Amount where("Customer No." = field("No."),
            //                                                        "Transaction Type" = const("Silver Savings"),
            //                                                        "Posting Date" = field("Date Filter")));
            Editable = false;
            // FieldClass = FlowField;
        }
        field(69285; "Development Loan"; Decimal)
        {
            CalcFormula = sum("Detailed Cust. Ledg. Entry".Amount where("Customer No." = field("No."),
            Reversed = filter(false),
                                                                  "Loan Type" = const('DL'),
                                                                  "Posting Date" = field("Date Filter"),
                                                                  "Transaction Type" = filter(Loan | Repayment)));
            FieldClass = FlowField;
        }
        field(69286; "Emergency Loan"; Decimal)
        {
            CalcFormula = sum("Detailed Cust. Ledg. Entry".Amount where("Customer No." = field("No."),
                                                                  "Loan Type" = const('EL'),
                                                                  "Posting Date" = field("Date Filter"),
                                                                  "Transaction Type" = filter(Loan | Repayment)));
            FieldClass = FlowField;
        }
        field(69287; "Instant Loan"; Decimal)
        {
            CalcFormula = sum("Detailed Cust. Ledg. Entry".Amount where("Customer No." = field("No."),
                                                                  "Loan Type" = const('IL'),
                                                                  "Posting Date" = field("Date Filter"),
                                                                  "Transaction Type" = filter(Loan | Repayment)));
            FieldClass = FlowField;
        }
        field(69288; "Maono Shamba Loan"; Decimal)
        {
            CalcFormula = sum("Detailed Cust. Ledg. Entry".Amount where("Customer No." = field("No."),
                                                                  "Loan Type" = const('MSL'),
                                                                  "Posting Date" = field("Date Filter"),
                                                                  "Transaction Type" = filter(Loan | Repayment)));
            FieldClass = FlowField;
        }
        field(69289; "School Fees Loan"; Decimal)
        {
            CalcFormula = sum("Detailed Cust. Ledg. Entry".Amount where("Customer No." = field("No."),
                                                                  "Loan Type" = const('SL'),
                                                                  "Posting Date" = field("Date Filter"),
                                                                  "Transaction Type" = filter(Loan | Repayment)));
            FieldClass = FlowField;
        }
        field(69290; "Super Plus Loan"; Decimal)
        {
            CalcFormula = sum("Detailed Cust. Ledg. Entry".Amount where("Customer No." = field("No."),
                                                                  "Loan Type" = const('SPL'),
                                                                  "Posting Date" = field("Date Filter"),
                                                                  "Transaction Type" = filter(Loan | Repayment)));
            FieldClass = FlowField;
        }
        field(69291; "Super School Fees Laon"; Decimal)
        {
            CalcFormula = sum("Detailed Cust. Ledg. Entry".Amount where("Customer No." = field("No."),
                                                                  "Loan Type" = const('SSL'),
                                                                  "Posting Date" = field("Date Filter"),
                                                                  "Transaction Type" = filter(Loan | Repayment)));
            FieldClass = FlowField;
        }
        field(69292; "Top Loan"; Decimal)
        {
            CalcFormula = sum("Detailed Cust. Ledg. Entry".Amount where("Customer No." = field("No."),
                                                                  "Loan Type" = const('TL'),
                                                                  "Posting Date" = field("Date Filter"),
                                                                  "Transaction Type" = filter(Loan | Repayment)));
            FieldClass = FlowField;
        }
        field(69293; "Top Loan 1"; Decimal)
        {
            CalcFormula = sum("Detailed Cust. Ledg. Entry".Amount where("Customer No." = field("No."),
                                                                  "Loan Type" = const('TL1'),
                                                                  "Posting Date" = field("Date Filter"),
                                                                  "Transaction Type" = filter(Loan | Repayment)));
            FieldClass = FlowField;
        }
        field(69294; "Vs Member Loan"; Decimal)
        {
            CalcFormula = sum("Detailed Cust. Ledg. Entry".Amount where("Customer No." = field("No."),
                                                                  "Loan Type" = const('VS-MEMBER'),
                                                                  "Posting Date" = field("Date Filter"),
                                                                  "Transaction Type" = filter(Loan | Repayment)));
            FieldClass = FlowField;
        }
        field(69295; "Group Account No"; Code[20])
        {

        }
        field(69296; Piccture; MediaSet)
        {

        }
        field(69297; "Group ID No"; Code[20])
        {

        }
        field(69300; "No of PF Nos"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count(Customer where("Payroll No" = field("Payroll No"), Status = filter(<> Closed)));
        }
        field(69400; "No of ID Nos"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count(Customer where("ID No." = field("ID No."), Status = filter(<> Closed)));
        }
        field(69500; "Rejoined By"; Code[20])
        {

        }
        field(69501; "Internet Banking"; Boolean)
        {
        }
        field(69502; "Mobile Banking"; Boolean)
        {
        }
        field(69503; "Mobile Banking Status"; Boolean)
        {
        }
        field(69504; "Mobile Banking Registered"; Boolean)
        {
        }
        field(69505; "Mobile Banking Applicant"; Boolean)
        {
        }
        field(172000; "Old Account No"; Code[150])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(172001; "Old Accounts No"; Code[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(172002; "Dependant Savings 1"; Decimal)
        {
            /*             CalcFormula = - sum("Detailed Cust. Ledg. Entry".Amount where("Customer No." = field("No."),
                                                                              "Transaction Type" = filter("Dependant 1 Savings"), "Posting Date" = field("Date Filter")
                                                                              ));
                        FieldClass = FlowField; */
        }
        field(172003; "Dependant Savings 2"; Decimal)
        {
            /*             CalcFormula = - sum("Detailed Cust. Ledg. Entry".Amount where("Customer No." = field("No."),
                                                                              "Transaction Type" = filter("Dependant 2 Savings"), "Posting Date" = field("Date Filter")
                                                                              ));
                        FieldClass = FlowField; */
        }
        field(172004; "Dependant Savings 3"; Decimal)
        {
            /*   CalcFormula = - sum("Detailed Cust. Ledg. Entry".Amount where("Customer No." = field("No."),
                                                                    "Transaction Type" = filter("Dependant 3 Savings"), "Posting Date" = field("Date Filter")
                                                                    ));
              FieldClass = FlowField; */
        }
        field(172005; "Interest On Deposits"; Decimal)
        {
            CalcFormula = - sum("Detailed Cust. Ledg. Entry".Amount where("Customer No." = field("No."),
                                                                  "Transaction Type" = filter("Interest on Deposits"), "Posting Date" = field("Date Filter")
                                                                  ));
            FieldClass = FlowField;
        }
        field(172006; "Share Boost Fee"; Decimal)
        {
            /*             CalcFormula = - sum("Detailed Cust. Ledg. Entry".Amount where("Customer No." = field("No."),
                                                                              "Transaction Type" = filter("Share Boost Fee"), "Posting Date" = field("Date Filter")
                                                                              ));
                        FieldClass = FlowField; */
        }
        field(172007; "Rejoining Fee"; Decimal)
        {
            /*             CalcFormula = - sum("Detailed Cust. Ledg. Entry".Amount where("Customer No." = field("No."),
                                                                              "Transaction Type" = filter("Rejoining Fee"), "Posting Date" = field("Date Filter")
                                                                              ));
                        FieldClass = FlowField; */
        }
        field(172008; "Dormant Reactivation Fee"; Decimal)
        {
            /*             CalcFormula = - sum("Detailed Cust. Ledg. Entry".Amount where("Customer No." = field("No."),
                                                                              "Transaction Type" = filter("Dormant Reactivation Fee"), "Posting Date" = field("Date Filter")
                                                                              ));
                        FieldClass = FlowField; */
        }
        field(172009; "HouseHold Savings"; Decimal)
        {
            /*             CalcFormula = - sum("Detailed Cust. Ledg. Entry".Amount where("Customer No." = field("No."),
                                                                              "Transaction Type" = filter("HouseHold Savings"), "Posting Date" = field("Date Filter")
                                                                              ));
                        FieldClass = FlowField; */
        }
        field(172010; "Holiday Savings"; Decimal)
        {
            /*             CalcFormula = - sum("Detailed Cust. Ledg. Entry".Amount where("Customer No." = field("No."),
                                                                              "Transaction Type" = filter("Holiday Savings"), "Posting Date" = field("Date Filter")
                                                                              ));
                        FieldClass = FlowField; */
        }
        field(172011; "Utafiti Housing"; Decimal)
        {
            /*             CalcFormula = - sum("Detailed Cust. Ledg. Entry".Amount where("Customer No." = field("No."),
                                                                              "Transaction Type" = filter("Utafiti Housing"), "Posting Date" = field("Date Filter")
                                                                              ));
                        FieldClass = FlowField; */
        }

        field(172012; "Station"; Code[100])
        {
            DataClassification = ToBeClassified;

        }

        field(172013; "Reffered By Member No"; Code[100])
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

        field(172014; "Reffered By Member Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }

        field(172015; "NHIF No"; Code[100])
        {
            DataClassification = ToBeClassified;


        }

        field(172016; "Religion."; enum MemberReligionEnum)
        {
            DataClassification = ToBeClassified;


        }
        field(172017; "Member Type"; Option)
        {
            OptionMembers = Member,Staff,Board,"Station Representative";
            OptionCaption = 'Member,Staff,Board,Station Representative';

        }

        field(172018; "Exempted From Tax"; Boolean)
        {

        }

        field(172019; "How did you know about us?"; Enum "Lead Source")
        {

        }
        field(172020; "Sub-county"; Code[100])
        {

        }
        field(172021; "Area"; Code[100])
        {

        }
        field(172022; "Work E-Mail"; Code[100])
        {

        }

        field(172023; "Nearest Landmark"; Text[100])
        {

        }

        field(172024; "Secondary Mobile No"; Code[100])
        {

        }

        field(172025; "Surname"; Code[100])
        {

        }
        field(172026; "Mode Of Remmittance"; Option)
        {
            OptionCaption = ',Checkoff,"Standing Order",Cash,M-Pesa,"Direct Debit"';
            OptionMembers = ,Checkoff,"Standing Order",Cash,"M-Pesa","Direct Debit";
        }

        field(172027; "Station Representative"; Text[100])
        {
            DataClassification = ToBeClassified;

        }

        field(172028; "Retirement Date"; Date)
        {
            DataClassification = ToBeClassified;

        }

        field(172029; "Receive SMS Notification"; Boolean)
        {
            DataClassification = ToBeClassified;

        }


        field(172030; "Workstation"; text[100])
        {
            TableRelation = WorkStations.Code;

        }

        field(172031; "Employment Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Active In Service,Retired from Service';
            OptionMembers = "Active In Service","Retired from Service";
        }
        field(172032; "Why Exempt from Tax?"; Text[2048])
        {
            DataClassification = ToBeClassified;
        }

        field(172033; "Old FOSA Account"; Code[60])
        {
            DataClassification = ToBeClassified;
        }
        field(172034; "Checkoff Account"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(172035; "Salary Account"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(172036; "Jipange Balance"; Decimal)
        {
            CalcFormula = - sum("Detailed Vendor Ledg. Entry".Amount where("Vendor No." = field("FOSA Account No.")));
            FieldClass = FlowField;
            Editable = false;
        }
        field(172037; "ATM No"; Code[16])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(172038; "Employment Start Date"; Date)
        {
            Editable = false;
        }
        field(172039; "Employment End Date"; Date)
        {
            Editable = false;
        }

        field(172040; "Employment Period"; DateFormula)
        {
            Editable = false;
        }
        field(172041; "Tax Exemption Start Date"; Date)
        {
            Editable = false;
        }
        field(172042; "Tax Exemption End Date"; Date)
        {
            Editable = false;
        }
        field(172043; "Tax Exemption Period"; DateFormula)
        {
            Editable = false;
        }
        field(172044; "Membership Status"; Option)
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

        field(172045; "Checkoff Loans"; Decimal)
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum("Checkoff Loans".Amount where(Payroll = field("Payroll No")));
        }
        field(172046; "KTDA Buying Centre"; Code[20])
        {

        }
        field(172050; "Paid Registration Fee"; Boolean)
        {

        }
        field(172051; "ID Front"; MediaSet)
        {

        }
        field(172052; "ID Back"; MediaSet)
        {

        }

        field(172053; "Pays Benevolent"; Boolean)
        {

        }

        field(172054; "Monthly Sch.Fees Cont."; Decimal)
        {

        }

        field(172055; "Checkoff Member"; Boolean)
        {

        }

        field(172056; "Last Checkoff Date"; Date)
        {

        }

        field(172057; "Last Checkoff Amount"; Decimal)
        {

        }

        field(172058; "Variation Date Deposits"; Date)
        {

        }
        field(172059; "Variation Date ESS"; Date)
        {

        }
        field(172060; "School Fees Shares"; Decimal)
        {
            CalcFormula = - sum("Detailed Vendor Ledg. Entry".Amount where("Vendor No." = field("School Fees Shares Account"),/* "Document No." = filter(<>'ESSSBBF310324'),*/
                                                                        Reversed = filter(false), "Posting Date" = field("Date Filter")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(172071; "School Fees Shares Account"; Code[60])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(172061; "Main Sector"; Code[20])
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
        field(172062; "Sub Sector"; Code[20])
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
        field(172063; "Sector Specific"; Code[20])
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
        field(172064; "Sector Specific Name"; Text[2048])
        {

        }
        field(172065; "Main Sector Name"; Text[2048])
        {

        }
        field(172066; "SubSector Name"; Text[2048])
        {

        }
        field(172067; "Sales Person"; Text[2048])
        {
            TableRelation = "HR Employees"."No.";
        }
        field(172068; "Customer Service Rep."; Code[20])
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
        field(172069; "Customer Service Rep. Name"; Text[500])
        {

        }
        field(172070; "Has Next of Kin"; Boolean)
        {
            FieldClass = FlowField;
            CalcFormula = Exist("Members Next of Kin" where("Account No" = field("No.")));
        }
        field(172074; "Principle Balance"; Decimal)
        {
            /*             FieldClass = FlowField;
                        CalcFormula = Sum("Member Ledger Entry".Amount WHERE("Customer No." = FIELD("No."), "Transaction Type" = FILTER(Loan | "Loan Repayment"))); */
        }
        field(172075; "Old Ordinary Account NAV2016"; Code[20])
        {
            Editable = false;
        }
        field(172076; "Loan Defaulter"; Boolean)
        {
            // Editable=false;
        }
        field(172077; "ESS Contribution"; Decimal)
        {
            // Editable=false;
        }
        field(172078; "Customer Principal Balance"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Detailed Cust. Ledg. Entry".Amount WHERE("Customer No." = FIELD("No."), "Transaction Type" = FILTER(Loan | Repayment)));
        }
        field(172079; "Dividend Year"; Code[40])
        {

        }
        field(172080; "Last Deposit Contr Date"; Date)
        {
            FieldClass = FlowField;
            CalcFormula = max("Detailed Vendor Ledg. Entry"."Posting Date" where("Vendor No." = field("Deposits Account No"), "Posting Group" = const('BOSA DEPOSITS')));
        }
        field(172081; "Over-Guaranteed"; Boolean)
        {

        }
        field(172082; "Amount Guaranteed"; Decimal)
        {

        }
        field(172083; "Current Ability"; Decimal)
        {

        }
        field(172084; "Applicant No."; Code[20])
        {

        }
        field(172085; "Created On"; Date)
        {
        }
        field(172086; "Wezesha Savings"; Decimal)
        {
            CalcFormula = - sum("Detailed Vendor Ledg. Entry".Amount where("Vendor No." = field("Wezesha Savings Acc"),
                                                                    Reversed = filter(False), "Posting Date" = field("Date Filter")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(172087; "Ordinary Savings"; Decimal)
        {
            CalcFormula = - sum("Detailed Vendor Ledg. Entry".Amount where("Vendor No." = field("Ordinary Savings Acc"),
                                                                    Reversed = filter(False), "Posting Date" = field("Date Filter")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(172088; "Chamaa Savings"; Decimal)
        {
            CalcFormula = - sum("Detailed Vendor Ledg. Entry".Amount where("Vendor No." = field("Chamaa Savings Acc"),
                                                                        Reversed = filter(False), "Posting Date" = field("Date Filter")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(172089; "Jibambe Savings"; Decimal)
        {
            CalcFormula = - sum("Detailed Vendor Ledg. Entry".Amount where("Vendor No." = field("Jibambe Savings Acc"),
                                                                        Reversed = filter(False), "Posting Date" = field("Date Filter")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(172090; "Fixed Deposit"; Decimal)
        {
            CalcFormula = - sum("Detailed Vendor Ledg. Entry".Amount where("Vendor No." = field("Fixed Deposit Acc"),
                                                                        Reversed = filter(False), "Posting Date" = field("Date Filter")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(172091; "Mdosi Junior"; Decimal)
        {
            CalcFormula = - sum("Detailed Vendor Ledg. Entry".Amount where("Vendor No." = field("Mdosi Junior Acc")
                                                                    , Reversed = filter(False),
                                                                   "Posting Date" = field("Date Filter")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(172092; "Pension Akiba"; Decimal)
        {
            /*             CalcFormula = - sum("Detailed Vendor Ledg. Entry".Amount where("Vendor No." = field("Pension Akiba Acc"),
                                                                                    Reversed = filter(False), "Posting Date" = field("Date Filter")));
                        Editable = false;
                        FieldClass = FlowField; */
        }

        field(172093; "Business Account"; Decimal)
        {
            CalcFormula = - sum("Detailed Vendor Ledg. Entry".Amount where("Vendor No." = field("Business Account Acc")
                                                                    , Reversed = filter(False),
                                                                   "Posting Date" = field("Date Filter")));
            Editable = false;
            FieldClass = FlowField;
        }

        field(172094; "Wezesha Savings Acc"; code[100])
        {

        }
        field(172095; "Ordinary Savings Acc"; code[100])
        {

        }
        field(172096; "Chamaa Savings Acc"; code[100])
        {

        }
        field(172097; "Jibambe Savings Acc"; code[100])
        {

        }
        field(172098; "Fixed Deposit Acc"; code[100])
        {

        }
        field(172099; "Mdosi Junior Acc"; code[100])
        {

        }
        field(172100; "Pension Akiba Acc"; code[100])
        {

        }

        field(172101; "Business Account Acc"; code[100])
        {

        }
        field(172102; "Last Deposit Date Sch"; Date)
        {
            FieldClass = FlowField;
            CalcFormula = Max("Member Ledger Entry"."Posting Date" WHERE("Transaction Type" = FILTER("Dividend"), "Customer No." = FIELD("No.")));
        }
        field(172103; "Last Deposit Date Deposit"; Date)
        {
            FieldClass = FlowField;
            CalcFormula = Max("Member Ledger Entry"."Posting Date" WHERE("Transaction Type" = FILTER("Deposit Contribution"), "Customer No." = FIELD("No.")));

        }
        field(172104; "Share Capital Found"; Boolean)
        {
            CalcFormula = exist(Vendor where("BOSA Account No" = field("No."), "Account Type" = filter('101')));
            FieldClass = FlowField;
        }

        field(172105; "Deposits Found"; Boolean)
        {
            CalcFormula = exist(Vendor where("BOSA Account No" = field("No."), "Account Type" = filter('102')));
            FieldClass = FlowField;
        }


        field(172106; "Ordinary Found"; Boolean)
        {
            CalcFormula = exist(Vendor where("BOSA Account No" = field("No."), "Account Type" = filter('103')));
            FieldClass = FlowField;
        }
        field(172107; "Coop Shares"; Decimal)
        {

        }

        field(172108; "Coop Shares Net"; Decimal)
        {

        }
        field(172109; "Total Mdosi Jr"; Decimal)
        {

        }
        field(172110; "Share Capital Contribution"; Decimal)
        {

        }
        field(172111; "Jibambe Savings Contribution"; Decimal)
        {

        }
        field(172112; "Wezesha Savings Contribution"; Decimal)
        {

        }
        field(172113; "Mdosi Jr Contribution"; Decimal)
        {

        }
        field(172114; "Pension Akiba Contribution"; Decimal)
        {

        }
        field(172115; "ESS Interest Amount"; Decimal)
        {

        }
        field(172116; "Deposits Interest Amount"; Decimal)
        {

        }
        field(172117; "ESS Net Interest Amount"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = - sum("Dividends Progression"."Net Dividends" where("Member No" = field("No."), "Deposit Type" = filter(ESS), Posted = filter(false)));
        }
        field(172118; "ESS Gross Interest Amount"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = - sum("Dividends Progression"."Gross Dividends" where("Member No" = field("No."), "Deposit Type" = filter(ESS), Posted = filter(false)));
        }
        field(172119; "ESS WHT Amount"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = - sum("Dividends Progression"."Witholding Tax" where("Member No" = field("No."), "Deposit Type" = filter(ESS), Posted = filter(false)));
        }
        field(172120; "Deposits Net Interest Amount"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = - sum("Dividends Progression"."Net Dividends" where("Member No" = field("No."), "Deposit Type" = filter(Deposits), Posted = filter(false)));
        }
        field(172121; "Deposits Gross Interest Amount"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = - sum("Dividends Progression"."Gross Dividends" where("Member No" = field("No."), "Deposit Type" = filter(Deposits), Posted = filter(false)));
        }
        field(172122; "Deposits WHT Amount"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = - sum("Dividends Progression"."Witholding Tax" where("Member No" = field("No."), "Deposit Type" = filter(Deposits), Posted = filter(false)));
        }
        field(172123; "Dividend Net Interest Amount"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = - sum("Dividends Progression"."Net Dividends" where("Member No" = field("No."), "Deposit Type" = filter("Share Capital"), Posted = filter(false)));
        }
        field(172124; "Dividend Gross Interest Amount"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = - sum("Dividends Progression"."Gross Dividends" where("Member No" = field("No."), "Deposit Type" = filter("Share Capital"), Posted = filter(false)));
        }
        field(172125; "Dividend WHT Amount"; Decimal)
        {
            FieldClass = FlowField;//
            CalcFormula = - sum("Dividends Progression"."Witholding Tax" where("Member No" = field("No."), "Deposit Type" = filter("Share Capital"), Posted = filter(false)));
        }
        field(172126; "Gross Dividends"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = - sum("Dividends Progression"."Gross Dividends" where("Member No" = field("No."), "Deposit Type" = filter(Deposits | "Share Capital"), Posted = filter(false)));
        }

        field(172127; "Net Dividends Total"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = - sum("Dividends Progression"."Net Dividends" where("Member No" = field("No."), "Deposit Type" = filter(Deposits | "Share Capital"), Posted = filter(false)));
        }

        field(172128; "Upright Pensioner"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'This is a member whose pension is sufficient to repay their pension loans exclusively without repaying their salary loans from the same pension';
        }
        field(172129; "Member Region"; code[30])
        {
            TableRelation = "Member Delegate Zones".Code;//
        }
        field(172130; "Downline ID"; Code[60])
        {
            DataClassification = ToBeClassified;
            TableRelation = if ("How did you know about us?" = filter('Member|Staff')) Customer where(ISNormalMember = const(true));
        }
        field(172131; "MLM Level"; Code[20])
        {
            TableRelation = "MLM Level Setup"."Level Code";

        }
        field(172132; "Commission Paid"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Commission Paid';
        }
        field(172133; "Upline ID"; Code[60])
        {
            DataClassification = ToBeClassified;
            TableRelation = if ("How did you know about us?" = filter('Member|Staff')) Customer where(ISNormalMember = const(true));
        }
        field(172134; "Lead Source ID"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Lead Source ID';
        }
        field(172135; "Marketing Campaign ID"; Code[40])
        {
            Caption = 'Marketing Campaign ID';
            ToolTip = 'Specifies Marketing Campaign ID';
            TableRelation = "Marketing Campaign"."Campaign ID";
        }
        field(172136; "Marketing Event ID"; Code[40])
        {
            Caption = 'Marketing Event ID';
            ToolTip = 'Specifies who Marketing Event ID.';
            TableRelation = "Marketing Event"."Event ID" where("Campaign ID" = field("Marketing Campaign ID"));
        }
        field(172137; "Commission Posted"; Boolean)
        {
            Caption = 'Commission Posted';
            ToolTip = 'Specifies if the commission has been posted.';

        }
        field(172138; "Occupation2"; Code[20])
        {
            Caption = 'Occupation2';
            ToolTip = 'Specifies if the member has occupation 2.';

        }
        field(172139; "Occupation3"; Code[20])
        {
            Caption = 'Occupation3';
            ToolTip = 'Specifies if the member has occupation 3.';

        }
        field(172140; "Religion2"; Code[20])
        {
            Caption = 'Religion2';
            ToolTip = 'Specifies if the member has religion 2.';

        }
        field(172141; "Religion3"; Code[20])
        {
            Caption = 'Religion3';
            ToolTip = 'Specifies if the member has religion 3.';

        }
        field(172142; "County2"; Code[20])
        {
            Caption = 'County2';
            ToolTip = 'Specifies the second county of residence for the member.';

        }
        field(172143; "County3"; Code[20])
        {
            Caption = 'County3';
            ToolTip = 'Specifies the third county of residence for the member.';

        }
        field(172144; "Employer2"; Code[20])
        {
            Caption = 'Employer2';
            ToolTip = 'Specifies the second employer of the member.';

        }
        field(172145; "Employer3"; Code[20])
        {
            Caption = 'Employer3';
            ToolTip = 'Specifies the third employer of the member.';

        }
        field(172146; "Residence2"; Code[20])
        {
            Caption = 'Residence2';
            ToolTip = 'Specifies the second residence of the member.';

        }
        field(172147; "Residence3"; Code[20])
        {
            Caption = 'Residence3';
            ToolTip = 'Specifies the third residence of the member.';

        }
        field(172148; "First Name2"; Code[20])
        {
            Caption = 'First Name2';
            ToolTip = 'Specifies the second first name of the member.';

        }
        field(172149; "First Name3"; Code[20])
        {
            Caption = 'First Name3';
            ToolTip = 'Specifies the third first name of the member.';

        }
        field(172150; "Middle Name2"; Code[20])
        {
            Caption = 'Middle Name2';
            ToolTip = 'Specifies the second middle name of the member.';

        }
        field(172151; "Middle Name3"; Code[20])
        {
            Caption = 'Middle Name3';
            ToolTip = 'Specifies the third middle name of the member.';

        }
        field(172152; "Last Name2"; Code[20])
        {
            Caption = 'Last Name2';
            ToolTip = 'Specifies the second last name of the member.';

        }
        field(172153; "Last Name3"; Code[20])
        {
            Caption = 'Last Name3';
            ToolTip = 'Specifies the third last name of the member.';

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
