//************************************************************************
tableextension 50019 "CustPostGrpsTbExt" extends "Customer Posting Group"
{
    fields
    {
        // Add changes to table fields here
        field(50000; "Shares Deposits Account"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";

            trigger OnValidate()
            begin
                //Prevent Changing once entries exist
                TestNoEntriesExist(FieldCaption("Shares Deposits Account"), "Shares Deposits Account");
            end;
        }
        field(50001; "Registration Fees Account"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";

            trigger OnValidate()
            begin
                //Prevent Changing once entries exist
                TestNoEntriesExist(FieldCaption("Registration Fees Account"), "Registration Fees Account");
            end;
        }
        field(50002; "Dividend Account"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";

            trigger OnValidate()
            begin
                //Prevent Changing once entries exist
                TestNoEntriesExist(FieldCaption("Dividend Account"), "Dividend Account");
            end;
        }
        field(50003; "Withdrawal Fee"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";

            trigger OnValidate()
            begin
                //Prevent Changing once entries exist
                TestNoEntriesExist(FieldCaption("Withdrawal Fee"), "Withdrawal Fee");
            end;
        }
        field(50004; "Investment Account"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";

            trigger OnValidate()
            begin
                //Prevent Changing once entries exist
                TestNoEntriesExist(FieldCaption("Investment Account"), "Investment Account");
            end;
        }
        field(50005; "Un-allocated Funds Account"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";

            trigger OnValidate()
            begin
                //Prevent Changing once entries exist
                TestNoEntriesExist(FieldCaption("Un-allocated Funds Account"), "Un-allocated Funds Account");
            end;
        }
        field(50006; "Prepayment Account"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(50007; "Withdrawable Deposits"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";

            trigger OnValidate()
            begin
                //Prevent Changing once entries exist
                TestNoEntriesExist(FieldCaption("Withdrawable Deposits"), "Withdrawable Deposits");
            end;
        }
        field(50008; "Loan Form Fee"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(50009; "Passbook Fee"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(50010; "Risk Fund Charged Account"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(50011; "Risk Fund Paid Account"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(50012; "Group Shares"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(50013; "Savings Account"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(50014; "Shares Capital Account"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(50015; "Insurance Fund Account"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(50016; "Benevolent Fund Account"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(50017; "Recovery Account"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(50018; "FOSA Shares"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(50019; "Additional Shares"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(50020; "Junior Savings Account"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(50021; "Safari Savings Account"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(50022; "Silver Savings Account"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(50023; "Coop Shares Account"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }

    }

    var
        myInt: Integer;

    procedure TestNoEntriesExist(CurrentFieldName: Text[100]; GLNO: Code[20])
    var
        MembLedgEntry: Record "Member Ledger Entry";
    begin
        /*
          //**To prevent change of field
         MembLedgEntry.SETCURRENTKEY(MembLedgEntry."Customer Posting Group");
         MembLedgEntry.SETRANGE(MembLedgEntry."Customer Posting Group");
         IF MembLedgEntry.FIND('-') THEN
          ERROR(
          Text000,   CurrentFieldName);
          */

    end;
}


