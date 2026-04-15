page 51040 "ATM Pin Replacement Pending"
{
    ApplicationArea = All;
    PageType = List;
    UsageCategory = Lists;
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    CardPageId = "ATM Pin Replacement Card";
    SourceTable = "ATM Card Applications";
    SourceTableView = where("Request Type" = filter("Pin Replacement"), Status = filter(Pending));
    
    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("No.";Rec."No.")
                {
                }
                field("Request Type";Rec."Request Type")
                {
                }
                field("Account No";Rec."Account No")
                {
                }
                field("Account Type";Rec."Account Type")
                {
                }
                field("Account Name";Rec."Account Name")
                {
                }
                field("ATM Card No.";Rec."Previous Card No")
                {
                    Caption = 'ATM No.';
                }
                field("ID No";Rec."ID No")
                {
                }
                field("Phone No.";Rec."Phone No.")
                {
                }
                field(Status;Rec.Status)
                {
                }
                
                field("Application Date";Rec."Application Date")
                {
                }
                field("Captured By";Rec."Captured By")
                {
                }
                field("Pin Received";Rec."Pin Received")
                {
                }
                field("Pin Received By";Rec."Pin Received By")
                {
                }
                field("Pin Replacement Issued";Rec."Pin Replacement Issued")
                {
                }
                field("Pin Replacement Issued By";Rec."Pin Replacement Issued By")
                {
                }
            }
        }
    }
}


