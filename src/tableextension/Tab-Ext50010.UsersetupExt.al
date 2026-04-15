//************************************************************************
tableextension 50010 "UsersetupExt" extends "User Setup"
{
    fields
    {
        // Add changes to table fields here
        field(50055; Leave; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50056; "Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50057; tetst; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            DataClassification = ToBeClassified;
            Description = 'Stores the reference of the second global dimension in the database';
            NotBlank = false;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(50058; "Code 2"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50059; "Code 3"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50060; "Cash Advance Staff Account"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Customer."No." where("Account Type" = const("Staff Advance"));
        }
        field(50061; "ReOpen/Release"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ",ReOpen,Release;
        }
        field(50062; "Location Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = Location.Code;
        }
        field(50063; "Edit Posted Dimensions"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50064; "Journal Template Name"; Code[10])
        {
            Caption = 'Journal Template Name';
            DataClassification = ToBeClassified;
            TableRelation = "Gen. Journal Template";
        }
        field(50065; "Journal Batch Name"; Code[10])
        {
            Caption = 'Journal Batch Name';
            DataClassification = ToBeClassified;
            TableRelation = "Gen. Journal Batch".Name where("Journal Template Name" = field("Journal Template Name"));
        }
        field(50000; "Internal Auditor"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50001; "Password Does Not Expire"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50002; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(50003; "Responsibility Center"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Online Access Group Priveleges".Dashboard;
        }
        field(50004; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(50005; "Unlimited PV Amount Approval"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50006; "PV Amount Approval Limit"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50007; "Unlimited PettyAmount Approval"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50008; "Petty C Amount Approval Limit"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50009; "Unlimited Imprest Amt Approval"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50010; "Imprest Amount Approval Limit"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50011; "Unlimited Store RqAmt Approval"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50012; "Store Req. Amt Approval Limit"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50013; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            DataClassification = ToBeClassified;
            Description = 'Stores the reference of the second global dimension in the database';
            NotBlank = false;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(50014; "Shortcut Dimension 3 Code"; Code[20])
        {
            CaptionClass = '1,2,3';
            Caption = 'Shortcut Dimension 3 Code';
            DataClassification = ToBeClassified;
            Description = 'Stores the reference of the Third global dimension in the database';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(3));
        }
        field(50015; "Shortcut Dimension 4 Code"; Code[20])
        {
            CaptionClass = '1,2,4';
            Caption = 'Shortcut Dimension 4 Code';
            DataClassification = ToBeClassified;
            Description = 'Stores the reference of the Third global dimension in the database';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(4));
        }
        field(50016; "Unlimited ImprestSurr Amt Appr"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50017; "ImprestSurr Amt Approval Limit"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50018; "Unlimited Interbank Amt Appr"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50019; "Interbank Amt Approval Limit"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50020; "Staff Travel Account"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Customer."No." where("Account Type" = const("Travel Advance"));
        }
        field(50021; "Post JVs"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50022; "Post Bank Rec"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50023; "Unlimited Receipt Amt Approval"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50024; "Receipt Amt Approval Limit"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50025; "Unlimited Claim Amt Approval"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50026; "Claim Amt Approval Limit"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50027; "Unlimited Advance Amt Approval"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50028; "Advance Amt Approval Limit"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50029; "Unlimited AdvSurr Amt Approval"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50030; "AdvSurr Amt Approval Limit"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50031; "Other Advance Staff Account"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Customer."No." where("Account Type" = const("Staff Advance"));
        }
        field(50032; "Unlimited Grant Amt Approval"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50033; "Grant Amt Approval Limit"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50034; "Unlimited GrantSurr Approval"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50035; "GrantSurr Amt Approval Limit"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50036; "User Signature"; Blob)
        {
            DataClassification = ToBeClassified;
        }
        field(50037; "Post Staff Grants"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50038; "ReValidate LPOs"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'Can ReOpen Expired LPOs';
        }
        field(50039; "Procurement Officer"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50040; "Compliance/Grants"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50041; "Payroll Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "prPayroll Type";
        }
        field(50042; test; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50043; "Archiving User"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "User Setup"."User ID";
        }
        field(50044; "Member Registration"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50045; "Member Verification"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50046; "CPD User"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50047; "Indexing User"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50048; "Post CPD Adjst"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50049; "Bulk SMS"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50050; "Can Capture Multiple Loans"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50051; "Change Defaulter Status"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50052; "Post Pending ABC"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50053; "Can View Staff Accounts"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50054; "Can Edit Chart Of Accounts"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50070; "Employee no"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "HR Employees"."No.";
        }
        field(50071; "View Payroll"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50072; "Create Vote"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50073; "Cancel Requisition"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50074; "Create Item"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50075; "Reversal Right"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50076; "Change GL"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50077; "Post Stores Requisition"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50078; "Re-Open Batch"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50079; "View Special Accounts"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50080; "Allow Back-Dating Transactions"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50081; "Allow Process Payroll"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50082; "Unblock Loan Application"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50083; "Is Manager"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50084; "Is Internal Auditor"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50085; "Post Pv"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50066; "Branch Code"; code[250])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(50067; "Can Process Allowances"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50068; "Can Rectify Penalty"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50069; "Debt Collector"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50086; "Loan Porfolio Manager"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        //New from .71
        field(50087; Overdraft; Boolean)
        {

        }
        //
        field(50088; "Loan Product Setup"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Can edit loan product setups.';
        }
        field(50089; "Can edit recovery mode"; Boolean)
        {
            DataClassification = ToBeClassified;
        }

        field(50090; "Change account status"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50091; "Add Employers"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50092; "Lock Change Profile & Company"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50093; "Freeze Amount"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50094; "Send Red Flagged SMS"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50095; "Phone Number"; Code[40])
        {
            DataClassification = ToBeClassified;
        }
        field(50096; "Department"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = ,HR,IT,Finance,Admin,"Mortgage",Recovery,Marketing;
            OptionCaption = ',HR,IT,Finance,Admin,Mortgage,Recovery,Marketing';
        }

    }

    var
        myInt: Integer;
}


