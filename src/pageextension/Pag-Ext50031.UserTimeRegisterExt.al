pageextension 50031 "User Time Register Ext" extends "User Time Registers"
{
    layout
    {
        addbefore(Minutes)
        {
            field("Login Time";Rec."Login Time")
            {
                ApplicationArea = Basic, Suite;
            }
        }
        addafter(Minutes)
        {
            field("Logout Time";Rec."Logout Time")
            {
                ApplicationArea = Basic, Suite;
            }
        }
    }
    
    actions
    {
        // Add changes to page actions here
    }
    
    var
    myInt: Integer;
    loginTime: Time;
    logoutTime: Time;
    hour: Integer;
    minute: Integer;
    minuteDuration: Duration;
    second: Integer;
    typeHelper: Codeunit 10;
    initialization: Codeunit "System Initialization";
    usertimeReg: Record "User Time Register";

    trigger OnAfterGetRecord() begin    
        loginTime:= 0T;
        loginTime:= DT2Time(Rec.SystemCreatedAt);
        Rec."Login Time":= loginTime;

        logoutTime:= 0T;
        minute:= 0;
        minuteDuration:= Rec.Minutes*60000;
        logoutTime:= Rec."Login Time" + minuteDuration;
        Rec."Logout Time":= logoutTime;
    end;

}
