table 50736 "Credit Rating"
{

    fields
    {
        field(1; "Loan No."; Code[20])
        {
        }
        field(2; "Document Date"; Date)
        {
        }
        field(3; "Loan Amount"; Decimal)
        {
        }
        field(5; "Date Entered"; Date)
        {
        }
        field(6; "Time Entered"; Time)
        {
        }
        field(7; "Entered By"; Code[100])
        {
        }
        field(11; "Account No"; Code[20])
        {
        }
        field(12; "Member No"; Code[20])
        {
        }
        field(13; "Telephone No"; Code[20])
        {
        }
        field(16; "Customer Name"; Text[150])
        {
        }
        field(19; Comments; Text[250])
        {
        }
        field(21; "Entry No"; Integer)
        {
            //AutoIncrement = true;
        }
        field(25; "Next Loan Application Date"; Date)
        {
        }
        field(29; Penalized; Boolean)
        {
        }
        field(30; "Penalty Date"; Date)
        {
        }
        field(31; "Last Notification"; Option)
        {
            OptionMembers = " ","1","2","3","4","5","6","7","8","9","10";
        }
        field(32; "Next Notification"; Option)
        {
            OptionMembers = " ","1","2","3","4","5","6","7","8","9","10";
        }
        field(33; "Loan Product Type"; Code[20])
        {
            TableRelation = "Loan Products Setup";
        }
        field(34; "New Rate"; Boolean)
        {
        }
        field(35; "Loan Limit"; Decimal)
        {
        }
        field(36; "Amount Recovered From BOSA"; Decimal)
        {
        }
        field(37; "Amount  Recovered From FOSA"; Decimal)
        {
        }
        field(38; "Test Amount"; Decimal)
        {
        }
        field(39; "Deposits Recovered"; Decimal)
        {

            //  FieldClass = FlowField;
            // CalcFormula = Sum("Defaulter Deposit Recovery"."Deposits Recovered" WHERE ("Loan No."=FIELD("Loan No.")));
        }
        field(40; "Deposit Balance Cleared"; Boolean)
        {
        }
        field(59; "FOSA Balance"; Decimal)
        {

            FieldClass = FlowField;
            AutoFormatType = 1;
            CalcFormula = - Sum("Detailed Vendor Ledg. Entry"."Amount (LCY)" WHERE("Vendor No." = FIELD("Account No")));
            Editable = false;
        }
        field(60; "Deposits Refunded"; Boolean)
        {
        }
        field(61; "Dep. Refund. Updated By"; Code[50])
        {
        }
        field(62; "Staff No."; Code[20])
        {
        }
        field(63; Reversed; Boolean)
        {
        }
        field(64; Installments; Integer)
        {

            FieldClass = FlowField;
            CalcFormula = Lookup("Loans Register".Installments WHERE("Loan  No." = FIELD("Loan No.")));
        }
        field(65; "End Date"; Date)
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Loans Register"."Expected Date of Completion" WHERE("Loan  No." = FIELD("Loan No.")));
        }
        field(67; AmountRecoveredFromShares; Decimal)
        {
        }
        field(68; "Check Entry"; Boolean)
        {
        }
        field(69; "New Limit"; Decimal)
        {
        }
        field(70; "Requested By"; Code[20])
        {
        }
        field(71; "Approved By"; Code[20])
        {
            trigger OnValidate() begin
                "Loan Limit" := "New Limit";
                Updated := true;
                "Updated By" := UserId;
                "Updated On" := CreateDateTime(Today, Time);
            end;
        }
        field(72; "Updated By"; Code[20])
        {
        }
        field(73; Updated; Boolean)
        {
        }
        field(74; "Updated On"; DateTime)
        {
        }


    }

    keys
    {
        key(Key1; "Loan No.", "Entry No")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        //ERROR('You cannot delete M-KAHAWA transactions.');
    end;

    var
        ObjCustomers: Record 18;
}

