page 51021 "Teller & Treasury Trans List1"
{
    ApplicationArea = All;
    Caption = 'Teller & Treasury Trans List';
    CardPageID = "Teller & Treasury Trans Card2";
    DeleteAllowed = false;
    Editable = false;
    PageType = List;
    SourceTable = "Treasury Transactions";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(No;Rec.No)
                {
                    Editable = false;
                }
                field(Teller;Rec."To Account")
                {
                    Caption = 'Teller';
                }
                field("Amount to request";Rec."Amount to request")
                {
                    Caption = 'Amount to Request';
                }
                field("Date Requested";Rec."Requested Date")
                {
                    Caption = 'Date Requested';
                    Editable = false;
                }
                field("Time Requested";Rec."Requested Time")
                {
                    Caption = 'Time Requested';
                    Editable = false;
                }
                field(Requested;Rec.requested)
                {
                    Caption = 'Requested';
                    Editable = false;
                    Enabled = false;
                }
                field("Date Posted";Rec."Date Posted")
                {
                }
                field("Transaction Date";Rec."Transaction Date")
                {
                }
            }
        }
    }

    actions
    {
    }
}




