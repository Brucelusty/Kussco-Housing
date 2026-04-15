//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50709 "Teller Till List"
{
    ApplicationArea = All;
    CardPageID = "Teller Till Card";
    Editable = false;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "Bank Account";
    SourceTableView = where("Account Type" = filter(Cashier));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                }
                field(Name; Rec.Name)
                {
                }
                field(CashierID; Rec.CashierID)
                {
                }
                field("Balance (LCY)"; Rec."Balance (LCY)")
                {
                    Caption = 'Running Balance';
                }
            }
        }
    }

    actions
    {
    }
}






