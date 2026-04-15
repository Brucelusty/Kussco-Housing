pageextension 50030 ProfileSettings extends "User Settings"
{
    layout
    {
        // Add changes to page layout here
    }
    
    actions
    {
        // Add changes to page actions here
    }
    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        User.RESET;
        User.SETRANGE("User ID", UserId);
        IF User.FINDFIRST THEN
            IF User."Lock Change Profile & Company" = false THEN
                ERROR('You do not have permissions to change profile and company');
    end;
    var
        myInt: Integer;
        User: Record "User Setup";

}
