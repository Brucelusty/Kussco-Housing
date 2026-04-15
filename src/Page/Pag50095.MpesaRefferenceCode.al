page 50095 "Mpesa Refference Code"
{
    ApplicationArea = All;

    PageType = ConfirmationDialog;

    layout
    {
        area(content)
        {
            field(MPESAReff; MPESAReff)
            {
                Caption = 'MPESA Refference Code';
            }
        }
    }

    actions
    {
    }


    var
    MPESAReff: Code[20];
    procedure GetEnterMPESAReff(): Code[20]
    begin
        exit(MPESAReff);
    end;
}
//member no. 0126026


