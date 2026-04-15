page 50013 "Revoked  Fixed deposit list"
{
    ApplicationArea = All;
    CardPageID = "Revoked FD Card";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Fixed Deposit";
    SourceTableView = WHERE(Revoked = FILTER(true));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("FD No"; rec."FD No")
                {
                    Editable = false;
                }
                field("Account No"; rec."Account No")
                {
                    Editable = false;
                }
                field("Account Name"; rec."Account Name")
                {
                    Editable = false;
                }
                field("Fd Duration"; rec."Fd Duration")
                {
                    Editable = false;
                }
                field(Amount; rec.Amount)
                {
                    Editable = false;
                }
                field("Interest Rate"; rec."Interest Rate")
                {
                    Editable = false;
                }
                field("ID NO"; rec."ID NO")
                {
                    Editable = false;
                }
                field("Creted by"; rec."Created by")
                {
                    Editable = false;
                }
                field("Amount After maturity"; rec."Amount After maturity")
                {
                    Editable = false;
                }
                field(Date; rec.Date)
                {
                    Editable = false;
                }
                field(MaturityDate; rec.MaturityDate)
                {
                    Editable = false;
                }
                field("Revoked Date"; rec."Revoked Date")
                {
                    Editable = false;
                }
                field("Revoked Time"; rec."Revoked Time")
                {
                    Editable = false;
                }
                field("Revoked By"; rec."Revoked By")
                {
                    Editable = false;
                }
            }
        }
    }

    actions
    {
    }
}




