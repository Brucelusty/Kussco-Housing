page 51129 "Defaulter Case List"
{
    ApplicationArea = All;
    PageType = List;
    SourceTable = "Loans Register";
    UsageCategory = Lists;
    CardPageId = "Defaulter Case Card";
    SourceTableView=where(Posted=filter(true));

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Loan  No.";Rec."Loan  No.") { Editable=false;}
                field("Client Name";Rec."Client Name") { }
                field("Outstanding Balance";Rec."Outstanding Balance") { }
                field("Days in Arrears"; Rec."Days in Arrears") { }
                field("Recovery Stage"; Rec."Recovery Stage") { }
             
            }
        }
    }
}


