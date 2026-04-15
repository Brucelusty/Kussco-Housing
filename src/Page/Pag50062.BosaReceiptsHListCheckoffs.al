page 50062 "Bosa Receipts H List-Checkoffs"
{
    ApplicationArea = All;
    CardPageID = "Bosa Receipts H Card-Checkoff";
    Editable = false;
    PageType = List;
    SourceTable = "ReceiptsProcessing_H-Checkoff";
    SourceTableView = WHERE(Posted=FILTER(false));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(No;Rec.No)
                {
                }
                field("Posted By";Rec."Posted By")
                {
                }
                field("Account No";Rec."Account No")
                {
                }
                field("Document No";Rec."Document No")
                {
                }
                field(Amount;Rec.Amount)
                {
                }
                field("Scheduled Amount";Rec."Scheduled Amount")
                {
                }
                field("Account Name";Rec."Account Name")
                {
                }
                field("Employer Code";Rec."Employer Code")
                {
                }
            }
        }
    }

    actions
    {
    }
}




