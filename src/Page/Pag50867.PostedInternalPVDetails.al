//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50867 "Posted Internal PV Details"
{
    ApplicationArea = All;
    PageType = ListPart;
    SourceTable = "Internal PV Lines";

    layout
    {
        area(content)
        {
            repeater(Control17)
            {
                field(Type; Rec.Type)
                {
                }
                field("Account Type"; Rec."Account Type")
                {
                }
                field("Account No."; Rec."Account No.")
                {
                }
                field("Account Name"; Rec."Account Name")
                {
                    Editable = false;
                }
                field(Description; Rec.Description)
                {
                }
                field("Credit Amount"; Rec."Credit Amount")
                {
                }
                field("Debit Amount"; Rec."Debit Amount")
                {
                }
            }
        }
    }

    actions
    {
    }

    var
        DCHAR: Integer;
        NotAvailable: Boolean;
        AvailableBal: Decimal;
        Charges: Decimal;
        Accounts: Record Vendor;
        AccountTypes: Record "Account Types-Saving Products";
}






