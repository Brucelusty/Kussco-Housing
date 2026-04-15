table 50724 "UFAA Buffer"
{

    fields
    {
        field(1;No;Integer)
        {
            Editable = false;
        }
        field(2;"Member No";Code[40])
        {
            Editable = false;
        }
       
        field(3;"FOSA Account";Code[40])
        {
            Editable = false;
        }
        field(4;Source;Option)
        {
            Editable = false;
            OptionCaption = ',BOSA,FOSA';
            OptionMembers = ,BOSA,FOSA;
        }
        field(30; Shares; Decimal)
        {
            Editable = false;
        }
        field(5;Deposits;Decimal)
        {
            Editable = false;
        }
        field(6;"Fosa Balance";Decimal)
        {
            Editable = false;
        }
        field(9;"School Fees Deposits";Decimal)
        {
            Editable = false;
        }
        field(31;Chamaa; Decimal)
        {
            Editable = false;
        }
        field(32; Jibambe; Decimal)
        {
            Editable = false;
        }
        field(33;"Wezesha";Decimal)
        {
            Editable = false;
        }
        field(34; FixedDep; Decimal)
        {
            Editable = false;
        }
        field(35; "Mdosi";Decimal)
        {
            Editable = false;
        }
        field(36;"PensionAkiba";Decimal)
        {
            Editable = false;
        }
        field(37;"BusinessAct";Decimal)
        {
            Editable = false;
        }
        field(7;"Account Type";Code[40])
        {
            Editable = false;
            TableRelation = "Account Types-Saving Products".Code;
        }
        field(8;"Members Name";Text[250])
        {
            Editable = false;
        }
     
        field(10;"Last Transaction Date";Date)
        {
            Editable = false;
        }
        field(11;"Member PF";Code[20])
        {
            Editable = false;
        }
        field(12;"Mobile Number";Code[40])
        {
        }
        field(13;"ID Number";Code[40])
        {
        }
        field(14;"Withdrawal Notice Date";Date)
        {
        }
        field(15; EmployerCode; code[30])
        {
            
        }
        field(16;"Last Transaction Date_Shares";Date)
        {
            Editable = false;
        }
        field(17; TransactionType; Enum FOSATransactionTypesEnum)
        {}
        field(18; "Last Transact Date_Ordinary"; Date)
        {}
        field(19; "Last Ord Transact Description"; Text[300])
        {}
        field(20; "Old Fosa No"; Code[20])
        {

        }

        field(21; Activity; Text[250])
        {
            CalcFormula = Lookup("Member Ledger Entry".Description WHERE("Customer No." = Field("Member No"),"Posting Date"=field("Last Transaction Date")));
            FieldClass = FlowField;

        }
        field(22; "Old Last Date"; Date)
        {
            
        }
        field(23; "Old Last Description"; Text[250])
        {

        }
    }

    keys
    {
        key(Key1;No)
        {
        }
    }

    fieldgroups
    {
    }
}

