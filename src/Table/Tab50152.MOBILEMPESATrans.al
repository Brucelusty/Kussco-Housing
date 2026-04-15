//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50152 "MOBILE MPESA Trans"
{

    fields
    {
        field(1; "Document No"; Code[200])
        {
        }
        field(2; "Transaction Date"; Date)
        {
        }
        field(3; "Account No"; Code[500])
        {
        }
        field(4; Description; Text[220])
        {
        }
        field(5; Amount; Decimal)
        {
        }
        field(6; Posted; Boolean)
        {
        }
        field(7; "Transaction Type"; Text[300])
        {
        }
        field(8; "Transaction Time"; Time)
        {
        }
        field(9; "Paybill Acc Balance"; Decimal)
        {
        }
        field(10; "Document Date"; Date)
        {
        }
        field(11; "Date Posted"; Date)
        {
        }
        field(12; "Time Posted"; Time)
        {
        }
        field(13; Changed; Boolean)
        {
        }
        field(14; "Date Changed"; Date)
        {
        }
        field(15; "Time Changed"; Time)
        {
        }
        field(16; "Changed By"; Code[300])
        {
        }
        field(17; "Approved By"; Code[300])
        {
        }
        field(18; "Key Word"; Text[300])
        {
        }
        field(19; Telephone; Text[300])
        {
        }
        field(20; "Account Name"; Text[300])
        {
        }
        field(21; "Needs Manual Posting"; Boolean)
        {
        }
        field(22; "Transaction Category"; Text[2046])
        {

        }
        field(23; "Transaction Date Time"; Text[200])
        {

        }
        field(24; Trace; Code[1048])
        {

        }

        field(25; "Reference"; Code[1048])
        {

        }
        field(26; LoanNo; Code[50])
        {

        }

        field(27; "Transaction Found"; Boolean)
        {

        }
        field(28; "Posted Time"; Time)
        {
        }
    }

    keys
    {
        key(Key1; "Document No", Description)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnModify()
    begin
        //ERROR('You are permitted to edit this transaction');
    end;
}




