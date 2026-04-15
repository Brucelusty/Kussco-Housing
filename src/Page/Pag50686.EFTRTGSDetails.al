//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50686 "EFT/RTGS Details"
{
    ApplicationArea = All;
    PageType = ListPart;
    SourceTable = "EFT/RTGS Details";
    SourceTableView = sorting("Header No", No);

    layout
    {
        area(content)
        {
            repeater(Control17)
            {
                field("Account No";Rec."Account No")
                {
                }
                field("Account Name";Rec."Account Name")
                {
                    Editable = false;
                }
                field("Phone No.";Rec."Phone No.")
                {
                    Visible = false;
                }
                field("Account Type";Rec."Account Type")
                {
                    Editable = false;
                }
                field("Transaction Description";Rec."Transaction Description")
                {
                }
                field(Amount; Rec.Amount)
                {
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        DCHAR := 0;
        DCHAR := StrLen(Rec."Destination Account No");

        NotAvailable := true;
        AvailableBal := 0;


        //Available Bal
        if Accounts.Get(Rec."Account No") then begin
            Accounts.CalcFields(Accounts.Balance, Accounts."Uncleared Cheques", Accounts."ATM Transactions");
            if AccountTypes.Get(Accounts."Account Type") then begin
                AvailableBal := Accounts.Balance - (Accounts."Uncleared Cheques" + Accounts."ATM Transactions" + Charges + AccountTypes."Minimum Balance");

                if Rec.Amount <= AvailableBal then
                    NotAvailable := false;

            end;
        end;
    end;

    var
        DCHAR: Integer;
        NotAvailable: Boolean;
        AvailableBal: Decimal;
        Charges: Decimal;
        Accounts: Record Vendor;
        AccountTypes: Record "Account Types-Saving Products";
}






