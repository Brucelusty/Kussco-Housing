page 65712 "Black-Listed Accounts"
{
    ApplicationArea = All;
    PageType = List;
    SourceTable = "AU Black-Listed Account Nos";
    

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Account No.";rec."Account No.")
                {
                }
                field(Reason;rec.Reason)
                {
                }
                field("Black-Listed";rec."Black-Listed")
                {
                }
                field("BlackList on Loan";rec."BlackList on Loan")
                {
                }
                field("BlackList on Deposit";rec."BlackList on Deposit")
                {
                }
                field("BlackList on Withdrawal";rec."BlackList on Withdrawal")
                {
                }
                field("Black-Listed By";rec."Black-Listed By")
                {
                }
                field("Date Black-Listed";rec."Date Black-Listed")
                {
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Import)
            {
                Promoted = true;
                PromotedIsBig = true;
                RunObject = XMLport 50058;
            }
        }
    }

    trigger OnInit()
    begin

        StatusPermission.RESET;
        StatusPermission.SETRANGE("User ID",USERID);
        StatusPermission.SETRANGE("View BlackListed Accounts",TRUE);
        IF NOT StatusPermission.FIND('-') THEN BEGIN
            ERROR('You do not have the following permission: "Black-List Accounts"');
        END;
    end;

    var
        StatusPermission: Record //"51516702"
        "AU Permissions";
}




