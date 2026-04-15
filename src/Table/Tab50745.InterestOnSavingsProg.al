table 50745 "Interest On Savings Prog"
{

    fields
    {
        field(1;"FOSA Account";Code[20])
        {
        }
        field(2;Date;Date)
        {
        }
        field(3;"Gross Interest";Decimal)
        {
        }
        field(4;"Witholding Tax";Decimal)
        {
        }
        field(5;"Net Dividends";Decimal)
        {
        }
        field(6;"Qualifying Shares";Decimal)
        {
        }
        field(7;"FOSA Balance";Decimal)
        {
        }
        field(8;Posted;Boolean)
        {
        }
        field(9; Period; Option)
        {
            OptionCaption = '" ",Jan-Mar,Apr-Jun,Jul-Sep,Oct-Dec';
            OptionMembers = " ","Jan-Mar","Apr-Jun","Jul-Sep","Oct-Dec";
        }
        field(10;Year;Code[10])
        {
        }
        field(11;"Member No";Code[20])
        {
        }
        field(12;"PF No";Code[10])
        {
        }
        field(13;"Member Name";Text[250])
        {
        }
        field(14;"Account Type";Code[10])
        {
        }
        field(15;"Account Type Name";Code[50])
        {
        }
        field(16;"First Interest";Decimal)
        {
        }
        field(17;"Second Interest";Decimal)
        {
        }
        field(18;"Third Interest";Decimal)
        {
        }
        field(19;"Start Date";Date)
        {
        }
        field(20;"End Date";Date)
        {
        }
    }

    keys
    {
        // key(Key1;"FOSA Account",Date)
        // {
        //     SumIndexFields = "Gross Interest","Net Dividends","FOSA Balance","Qualifying Shares","Witholding Tax";
        // }
        key(Key1;"FOSA Account", Period, Year)
        {
            SumIndexFields = "Gross Interest","Net Dividends","FOSA Balance","Qualifying Shares","Witholding Tax";
        }
    }

    fieldgroups
    {}
}

