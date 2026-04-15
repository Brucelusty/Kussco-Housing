page 50063 Mpesaithraal
{
    ApplicationArea = All;
    Caption = 'Mpesaithraal';
    PageType = List;
    SourceTable = "MPESA  Withdrawal";
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

                field("Vendor Comm"; Rec."Vendor Comm") { }

                field("Vendor Comm G/L"; Rec."Vendor Comm G/L") { }
                field(Mpesa; Rec.Mpesa) { }

                field("Mpesa Account"; Rec."Mpesa Account") { }
                field("Excise Duty"; Rec."Excise Duty") { }
                field(Total; Rec.Total) { }

            }
        }
    }
}


