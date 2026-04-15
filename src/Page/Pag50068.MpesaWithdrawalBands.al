page 50068 "Mpesa Withdrawal Bands"
{
    ApplicationArea = All;
    Caption = 'Mpesa Withdrawal Bands';
    PageType = List;
    SourceTable = "MPESA  Withdrawal Bands";
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
                field(Mpesa; Rec.Mpesa) { }
                field("Mpesa Account"; Rec."Mpesa Account") { }
                field("Excise Duty"; Rec."Excise Duty") { }
                field(Total; Rec.Total) { }

            }
        }
    }
}


