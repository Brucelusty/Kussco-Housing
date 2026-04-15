enum 50026 "Auction Status"
{
    Extensible = true;
    Caption = 'Auction Status';

    value(0; Draft)
    {
        Caption = 'Draft';
    }

    value(1; Scheduled)
    {
        Caption = 'Scheduled';
    }

    value(2; Advertised)
    {
        Caption = 'Advertised';
    }

    value(3; "Awaiting Auction Date")
    {
        Caption = 'Awaiting Auction Date';
    }

    value(4; "In Progress")
    {
        Caption = 'In Progress';
    }

    value(5; Successful)
    {
        Caption = 'Successful';
    }

    value(6; Unsuccessful)
    {
        Caption = 'Unsuccessful';
    }

    value(7; "Sold – Pending Completion")
    {
        Caption = 'Sold – Pending Completion';
    }

    value(8; Completed)
    {
        Caption = 'Completed';
    }

    value(9; Cancelled)
    {
        Caption = 'Cancelled';
    }

    value(10; "Repeat Auction Required")
    {
        Caption = 'Repeat Auction Required';
    }
}
