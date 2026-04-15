page 65726 "Followup List"
{
    ApplicationArea = All;
    PageType = List;
    SourceTable = "Loans Register";
    UsageCategory = Lists;
    CardPageId = "Follow Up Card";
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
                field("Assigned Officer"; Rec."Assigned Officer") { }
            }
        }
    }
    trigger OnAfterGetCurrRecord()
    var
        myInt: Integer;
    begin
        Rec.SetFilter("Followup Officer", UserId);
    end;

    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        Rec.SetFilter("Followup Officer", UserId);
    end;

    trigger OnAfterGetRecord()
    var
        myInt: Integer;
    begin
        Rec.SetFilter("Followup Officer", UserId);
    end;
}


