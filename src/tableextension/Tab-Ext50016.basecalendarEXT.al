//************************************************************************
tableextension 50016 "basecalendarEXT" extends "Base Calendar Change"
{
    fields
    {
        // Add changes to table fields here
        field(50000; "Date Day"; Integer)
        {
            // Caption = 'Nonworking';
            // InitValue = true;
        }
        field(50001; "Date Month"; Integer)
        {
            // Caption = 'Nonworking';
            // InitValue = true;
        }
    }

    var
        myInt: Integer;
}


