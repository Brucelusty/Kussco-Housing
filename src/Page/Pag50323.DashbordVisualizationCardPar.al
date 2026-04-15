page 50323 "Dashbord Visualization CardPar"
{
    ApplicationArea = All;
    Caption = 'Navigate';
    PageType = CardPart;
    SourceTable = "Dashboard Visualization";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field("Organization Logo"; Rec."Organization Logo")
                {
                    Caption = '';
                    Visible = true;
                    ToolTip = 'Specifies the value of the Organization Logo field.';
                }
                field("Fixed Asset"; Rec."Fixed Asset")
                {
                    Caption = '';

                    ToolTip = 'Specifies the value of the Fixed Asset field.';
                }
                field(TextNavigate; 'Fixed Asset')
                {
                    ShowCaption = false;
                    trigger OnDrillDown()
                    begin
                        Page.Run(page::"Fixed Asset List");
                    end;
                }
                field(Customers; Rec.Customers)
                {
                    Visible = false;
                    Caption = '';
                    ToolTip = 'Specifies the value of the Customers field.';
                }
                field(CustomersNavigate; 'Customers')
                {
                    ShowCaption = false;
                    Visible = false;
                    trigger OnDrillDown()
                    begin
                        Page.Run(page::"Customer List");
                    end;
                }
                field(LPOs; Rec.LPOs)
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the LPOs field.';
                }
                field(Currency; Rec.Currency)
                {
                    Visible = false;
                    Caption = '';
                    ToolTip = 'Specifies the value of the Currency field.';
                    trigger OnDrillDown()
                    begin
                        Page.Run(page::Currencies);
                    end;
                }
                field(COA; Rec.COA)
                {
                    Caption = '';
                    ToolTip = 'Specifies the value of the COA field.';
                }
                field(TextNavigateCOA; 'COA')
                {
                    ShowCaption = false;
                    trigger OnDrillDown()
                    begin
                        Page.Run(page::"Chart of Accounts");
                    end;
                }
                field("General Ledger Entries"; Rec."General Ledger Entries")
                {
                    Caption = '';
                    ToolTip = 'Specifies the value of the General Ledger Entries field.';
                }
                field(TextNavigateGls; 'General Ledger Entries')
                {
                    ShowCaption = false;
                    trigger OnDrillDown()
                    begin
                        Page.Run(page::"General Ledger Entries");
                    end;
                }
                field(Banks; Rec.Banks)
                {
                    Visible = false;
                    Caption = '';
                    ToolTip = 'Specifies the value of the Banks field.';
                }
                field(TextNavigateBanks; 'List of Banks')
                {
                    Visible = false;
                    ShowCaption = false;
                    trigger OnDrillDown()
                    begin
                        Page.Run(page::"Bank Account List");
                    end;
                }
                field(Vendors; Rec.Vendors)
                {
                    Visible = false;
                    Caption = '';
                    ToolTip = 'Specifies the value of the Vendors field.';
                }
                field(TextNavigateVendors; 'List of Vendors')
                {
                    ShowCaption = false;
                    Visible = false;
                    trigger OnDrillDown()
                    begin
                        Page.Run(page::"Vendor List");
                    end;
                }

            }
        }
    }
}


