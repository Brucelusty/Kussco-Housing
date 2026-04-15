page 65709 "MBanking Permissions"
{
    ApplicationArea = All;
 
    DeleteAllowed = false;
    ModifyAllowed = true;
    PageType = List;
    SourceTable = "AU Permissions";


    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("User ID"; rec."User ID")
                {
                }
                field("Reset Mpesa Pin"; rec."Reset Mpesa Pin")
                {
                }
                field("Update Paybill Transaction"; rec."Update Paybill Transaction")
                {
                }
                field("Sky Mobile Setups"; rec."Sky Mobile Setups")
                {
                }
                field("Black-List Accounts"; rec."Black-List Accounts")
                {
                }
                field("View BlackListed Accounts"; rec."View BlackListed Accounts")
                {
                }
                field("Approve Mobile Banking"; rec."Approve Mobile Banking")
                {
                }
                field("Create MBanking Applications"; rec."Create MBanking Applications")
                {
                }
                field("Reverse Sky Transactions"; rec."Reverse Sky Transactions")
                {
                }
                field("Mpesa Reconciliation"; rec."Mpesa Reconciliation")
                {
                }
                field("Reverse M Bank Transfer"; rec."Reverse M Bank Transfer")
                {
                }
                field("ATM Permisions"; rec."ATM Permisions")
                {
                }
                field("T-Kash Accounts"; rec."T-Kash Accounts")
                {
                }
            }
        }
    }
    //
    actions
    {
    }

    trigger OnInit()
    begin
        Permission.RESET;
        Permission.SETRANGE("User ID", USERID);
        Permission.SETRANGE("Sky Mobile Setups", TRUE);
        IF NOT Permission.FINDFIRST THEN
            ERROR('You do not have the following permission: "Sky Mobile Setups"');
    end;

    trigger OnOpenPage()
    begin
        RestrictAccess(USERID);
    end;

    var
        SaccoPermissions: Record //"51516702"
        "AU Permissions";
        Permission: Record //"51516702"
        "AU Permissions";

    procedure RestrictAccess(UserNo: Code[100])
    var
        StatusPermission: Record 91;
        ErrorOnRestrictViewTxt: Label 'You do not have permissions to EDIT this Page. Contact your system administrator for further details';
    begin
        SaccoPermissions.RESET;
        SaccoPermissions.SETRANGE("User ID", UserNo);
        SaccoPermissions.SETRANGE("Sky Mobile Setups", TRUE);
        IF NOT SaccoPermissions.FIND('-') THEN BEGIN
            ERROR('You do not have Setup Permissions');
        END;
    end;
}




