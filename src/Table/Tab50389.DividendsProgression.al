//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50389 "Dividends Progression"
{

    fields
    {
        field(1; "Member No"; Code[20])
        {
        }
        field(2; Date; Date)
        {
        }
        field(3; "Gross Dividends"; Decimal)
        {
        }
        field(4; "Witholding Tax"; Decimal)
        {
        }
        field(5; "Net Dividends"; Decimal)
        {
        }
        field(6; "Qualifying Shares"; Decimal)
        {
        }
        field(7; Shares; Decimal)
        {
        }
        field(8; "Net Interest On Deposit"; Decimal) { }
        field(9; "IOD withholding Tax"; Decimal) { }
        field(10; "Dividend Withholding Tax"; Decimal) { }
        field(11; "Deposit Type"; Option)
        {
            OptionCaption = 'Share Capital,Deposits,ESS';
            OptionMembers = "Share Capital",Deposits,ESS;
        }
        field(12; "Interest Capitalizing Amount"; Decimal)
        {

        }
        field(13; Year; Integer)
        {

        }
        field(14; Posted; Boolean)
        {

        }
        field(51516150; "Share Capital"; Decimal)
        {
        }
        field(51516151; "Qualifying Share Capital"; Decimal)
        {
        }
        field(51516152; "Gross Interest On Deposit"; Decimal)
        {
        }
        field(51516153; "Entry No"; Integer)
        {
        }
        field(51516154; "PCK"; Boolean)
        {
        }
                field(51516155; "PCK Pensioner"; Boolean)
        {
        }
                        field(51516156; "Non PCK"; Boolean)
        {
        }


    }

    keys
    {
        key(Key1; "Member No", Date, "Deposit Type", "Entry No")
        {
            Clustered = true;
            SumIndexFields = "Gross Dividends", "Net Dividends", Shares, "Qualifying Shares", "Witholding Tax";
        }
        key(Key2; Date)
        {
        }
    }

    fieldgroups
    {
    }
}




