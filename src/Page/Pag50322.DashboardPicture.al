page 50322 "Dashboard Picture"
{
    ApplicationArea = All;
    Caption = 'Dashboard Visualization';
    PageType = Card;
    SourceTable = "Dashboard Visualization";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field("Code"; Rec."Code")
                {
                    ToolTip = 'Specifies the value of the Code field.';
                }
                field("Organization Logo"; Rec."Organization Logo")
                {
                    ToolTip = 'Specifies the value of the Organization Logo field.';
                }
                field("Fixed Asset"; Rec."Fixed Asset")
                {
                    ToolTip = 'Specifies the value of the Fixed Asset field.';
                }
                field(Customers; Rec.Customers)
                {
                    ToolTip = 'Specifies the value of the Customers field.';
                }
                field(LPOs; Rec.LPOs)
                {
                    ToolTip = 'Specifies the value of the LPOs field.';
                }
                field(Currency; Rec.Currency)
                {
                    ToolTip = 'Specifies the value of the Currency field.';
                }
                field(COA; Rec.COA)
                {
                    ToolTip = 'Specifies the value of the COA field.';
                }
                field("General Ledger Entries"; Rec."General Ledger Entries")
                {
                    ToolTip = 'Specifies the value of the General Ledger Entries field.';
                }
                field(Banks; Rec.Banks)
                {
                    ToolTip = 'Specifies the value of the Banks field.';
                }
                field(Vendors; Rec.Vendors)
                {
                    ToolTip = 'Specifies the value of the Vendors field.';
                }
            }
        }
    }
}


