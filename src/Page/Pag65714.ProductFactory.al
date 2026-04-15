page 65714 "Product Factory"
{
    ApplicationArea = All;
    CardPageID = "Product Factory Card";
    DeleteAllowed = false;
    Editable = false;
    PageType = List;
    SourceTable = "AU Product Setup";
    

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Product ID";rec."Product ID")
                {
                }
                field("Product Description";rec."Product Description")
                {
                }
                field("Product Class Type";rec."Product Class Type")
                {
                }
                field("USSD Product Name";rec."USSD Product Name")
                {
                }
                field("Key Word";rec."Key Word")
                {
                }
                field("Account Type";rec."Account Type")
                {
                }
            }
        }
    }

    actions
    {
    }

    trigger OnInit()
    begin
        RestrictAccess(USERID);
    end;

    procedure RestrictAccess(UserNo: Code[100])
    var
        SaccoPermissions: Record //"51516702"
        "AU Permissions";
        ErrorOnRestrictViewTxt: Label 'You do not have permissions to EDIT this Page. Contact your system administrator for further details';
    begin
        SaccoPermissions.RESET;
        SaccoPermissions.SETRANGE("User ID",UserNo);
        SaccoPermissions.SETRANGE("Sky Mobile Setups",TRUE);
        IF NOT SaccoPermissions.FIND('-') THEN BEGIN
            // ERROR('You do not have Setup Permissions');
        END;
    end;
}




