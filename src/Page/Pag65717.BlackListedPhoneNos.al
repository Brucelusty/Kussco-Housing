page 65717 "Black-Listed Phone Nos"
{
    ApplicationArea = All;
    // 
    // StatusPermission.RESET;
    // StatusPermission.SETRANGE("User ID",USERID);
    // StatusPermission.SETRANGE("Black-List Accounts",TRUE);
    // IF NOT StatusPermission.FIND('-') THEN BEGIN
    //     ERROR('You do not have the following permission: "Black-List Accounts"');
    // END;

    PageType = List;
    SourceTable = "AU Black-Listed Phone Nos";
    

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Transactional Phone No.";rec."Transactional Phone No.")
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
                RunObject = XMLport 50056;
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




