page 50091 OTP
{
    ApplicationArea = All;

    PageType = ConfirmationDialog;

    layout
    {
        area(content)
        {
            field(InputOTP; InputOTP)
            {
                MultiLine = true;
            }
        }
    }

    actions
    {
    }

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    var
        OTPLog: Record "OTP LOGS";
        retry: Integer;
        failed: Boolean;
    begin
        if CloseAction = Action::No then begin
            Error('Canceling is not allowed. insert Correct OTP.');
        end;
        if CloseAction = Action::Yes then begin
            failed := true;
            // while failed = true do begin
            //     retry := 0;
            //     failed := false;
            //     OTPLog.Reset();
            //     OTPLog.SetRange("User Id", UserId);
            //     if OTPLog.FindLast() then begin
            //         if InputOTP <> OTPLog.OTP then begin
            //             while retry < 4 do begin
            //                 Error('The Inputted OTP is Incorrect. Try Again.');
            //                 retry += 1;
            //                 failed := true;
            //             end;
            //             if retry > 3 then begin
            //                 Error('You have inputted the wrong OTP 3 times. Another OTP has been sent to your inbox.');
            //             end;
            //         end;
            //     end;
            // end;
        end;
    end;

    var
        InputOTP: Integer;
    procedure GetEnterOTP(): Integer
    begin
        exit(InputOTP);
    end;
}
//member no. 0126026


