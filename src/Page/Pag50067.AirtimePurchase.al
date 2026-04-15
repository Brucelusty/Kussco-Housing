page 50067 "Airtime Purchase"
{
    ApplicationArea = All;
    Caption = 'Airtime Purchase';
    PageType = List;
    SourceTable = "Airtime Purchase Charges";
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Code; Rec.Code) { }
                field("Min Band"; Rec."Min Band") { }
                field("Upper Band"; Rec."Upper Band") { }
                field("Sacco Comm"; Rec."Sacco Comm") { }

                field("Sacco Comm G/L"; Rec."Sacco Comm G/L") { }
                field("Use Percentage"; Rec."Use Percentage") { }
                field(Percentage; Rec.Percentage) { }
                field("Vendor Comm"; Rec."Vendor Comm") { }

                field("Vendor Comm G/L"; Rec."Vendor Comm G/L") { }


                field("Mpesa Account"; Rec."Mpesa Account") { Visible = false; }
                field("Excise Duty"; Rec."Excise Duty") { Visible = false; }
                field(Total; Rec.Total) { }

            }
        }
    }
}


