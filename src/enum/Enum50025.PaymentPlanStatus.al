enum 50025 "Payment Plan Status"
{
    Extensible = true;
    Caption = 'Payment Plan Status';

    value(0; Draft)
    {
        Caption = 'Draft';
    }

    value(1; "Pending Committee Approval")
    {
        Caption = 'Pending Committee Approval';
    }

    value(2; Approved)
    {
        Caption = 'Approved';
    }

    value(3; Rejected)
    {
        Caption = 'Rejected';
    }

    value(4; Active)
    {
        Caption = 'Active';
    }

    value(5; "On Track")
    {
        Caption = 'On Track';
    }

    value(6; Lapsing)
    {
        Caption = 'Lapsing';
    }

    value(7; Breached)
    {
        Caption = 'Breached';
    }

    value(8; Completed)
    {
        Caption = 'Completed';
    }

    value(9; Cancelled)
    {
        Caption = 'Cancelled';
    }
}
