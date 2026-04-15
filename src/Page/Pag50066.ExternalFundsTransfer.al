page 50066 "External Funds Transfer"
{
    ApplicationArea = All;
    Caption = 'External Funds Transfer';
    PageType = List;
    SourceTable = "External Transfer Charges";
    UsageCategory = Administration;
    // Editable = false;
    // DeleteAllowed = false;
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Code; Rec.Code)
                {
                }
                field("Min Band"; Rec."Min Band")
                {
                }
                field("Upper Band"; Rec."Upper Band")
                {
                }
                field("Vendor Comm"; Rec."Vendor Comm")
                {
                }
                field("Vendor Comm G/L"; Rec."Vendor Comm G/L")
                {
                }
                field("Sacco Comm"; Rec."Sacco Comm")
                {
                }
                field("Sacco Comm G/L"; Rec."Sacco Comm G/L")
                {
                }
                field("Use Percentage"; Rec."Use Percentage")
                {
                }
                field(Percentage; Rec.Percentage)
                {
                }
                field(Mpesa;Rec.Mpesa)
                {
                }
                field(Total; Rec.Total)
                {
                }
            }
        }
    }
}


