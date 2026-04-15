page 65725 "My Loan Portflolio"
{
    ApplicationArea = All;
    PageType = List;
    SourceTable = "Loans Register";
    UsageCategory = Lists;
    CardPageId = "My Portfolio Card";
    SourceTableView = where(Posted = filter(true));

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Loan  No."; Rec."Loan  No.") { Editable = false; }
                field("Client Name"; Rec."Client Name") { }
                field("Outstanding Balance"; Rec."Outstanding Balance") { }
                field("Days in Arrears"; Rec."Days in Arrears") { }
                field("Recovery Stage"; Rec."Recovery Stage") { }
                field("Portfolio Officer"; Rec."Portfolio Officer") { }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    var
        myInt: Integer;
    begin
        Rec.SetFilter("Portfolio Officer", UserId);
    end;

    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        Rec.SetFilter("Portfolio Officer", UserId);
    end;

    trigger OnAfterGetRecord()
    var
        myInt: Integer;
    begin
        Rec.SetFilter("Portfolio Officer", UserId);
    end;

}


