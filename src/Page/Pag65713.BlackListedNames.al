page 65713 "Black-Listed Names"
{
    ApplicationArea = All;
    PageType = List;
    SourceTable = "AU Black-Listed Names";
   

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Name;rec.Name)
                {
                }
                field(Reason;rec.Reason)
                {
                }
                field("Black-Listed";rec."Black-Listed")
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
                RunObject = XMLport 50057;
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




