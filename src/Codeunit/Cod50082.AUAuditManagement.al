codeunit 50082 "AU Audit Management"
{
    trigger OnRun()
    begin

    end;

    procedure FnInsertAuditRecords(UserIDS: Code[80]; TransactionType: Text[150]; Amount: Decimal; Source: Code[80]; Date: Date; Time: Time; LoanNumber: Code[80]; DocumentNo: Code[80]; AccountNo: Code[80]; ATMNo: Code[80])
    var
        EntryNos: Integer;
    begin
        If AuditT.FindLast() then
            EntryNos := AuditT.EntryNo + 1
        else
            EntryNos := 1;
        AuditT.LOCKTABLE(TRUE);
        AuditT.INIT;
        AuditT.EntryNo := EntryNos;
        AuditT."User Id" := UserIDS;
        AuditT."Transaction Type" := TransactionType;
        AuditT.Amount := Amount;
        AuditT.Source := Source;
        AuditT.Date := Date;
        AuditT.Time := Time;
        AuditT."Loan Number" := LoanNumber;
        AuditT."Document Number" := DocumentNo;
        AuditT."Account Number" := AccountNo;
        AuditT."ATM Card" := ATMNo;
        AuditT."Computer Name" := ComputerName;
        //AuditT."IP Address":=IPAddress;
        AuditT.INSERT(true);
        COMMIT;
    end;


    /* [EventSubscriber(ObjectType::Codeunit, Codeunit::"System Initialization", 'OnAfterInitialization', '', false, false)]
        local procedure InsertLoggedInUsers()
        var
            ClientTypeManagement: Codeunit "Client Type Management";
        begin

         Audit.FnInsertAuditRecords(UserId,'System Login',0,'',today,time,'','','','');
        end; */
    var
        myInt: Integer;
        ComputerName: Text[250];
        Lentry: integer;

        ActiveSession: Record "Active Session";

        Audit: Codeunit "AU Audit Management";
        i: Integer;
        AuditT: Record "Audit Trail";


    //ron Addition
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"System Initialization", OnAfterLogin, '', false, false)]
    local procedure InitPasswordLogIfEmpty()
    var
        ChangePassword: Record "Password History";
        UserSetup: Record "User Setup";
        ICTSetup: Record "ICT Setup";
    begin
        ICTSetup.Reset();
        ICTSetup.SetRange("Enforce Password Expiry", true);
        if ICTSetup.Find('-') then begin

            UserSetup.Reset();
            UserSetup.SetRange("User ID", UserId);
            UserSetup.SetRange("Password Does Not Expire", false);
            if UserSetup.FindSet() then begin

                ChangePassword.Reset();
                ChangePassword.SetRange(UserName, UserSetup."User ID");
                if not ChangePassword.FindFirst() then begin

                    ChangePassword.Init();
                    ChangePassword.No := ChangePassword.GetNextLineNo();
                    ChangePassword.UserName := UserSetup."User ID";
                    ChangePassword.Validate("Last Password Change", Today());
                    ChangePassword."User Security ID" := GetUserSecurityID(UserSetup."User ID");
                    ChangePassword."Changed?" := false;
                    ChangePassword.Insert(true);
                end;
            end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"System Initialization", OnAfterLogin, '', false, false)]
    local procedure CheckifPasswordhadExpired()
    var
        ChangePassword: Record "Password History";
        ICTSetup: Record "ICT Setup";
        UserSetup: Record "User Setup";
        User: Record User;
        PasswordExpiryMsg: Label 'Hi %1, Your password has expired. You will be required to change it on your next login';
    begin
       /*  ICTSetup.Reset();
        ICTSetup.SetRange("Enforce Password Expiry", true);
        if ICTSetup.Find('-') then begin
            if ICTSetup."Enforce Password Expiry" = true then begin
                UserSetup.Reset();
                UserSetup.SetRange("User ID", UserId);
                UserSetup.SetRange("Password Does Not Expire", false);
                if UserSetup.Find('-') then begin
                    ChangePassword.Reset();
                    ChangePassword.SetRange(UserName, UserId);
                    if ChangePassword.Find('-') then
                        if ChangePassword."Next Password Change" <= Today() then begin
                            ChangePassword.Validate("Next Password Change");
                            if User.Get(ChangePassword."User Security ID") then begin
                                Message(StrSubstNo(PasswordExpiryMsg, UserId()));
                                User.Validate("Change Password", true);
                                User.Modify(true)
                            end;

                        end;
                end;
            end;
        end; */
    end;

    local procedure GetUserSecurityID(UserName: Code[50]): GUID
    var
        UserRec: Record User;
    begin
        UserRec.SetRange("User Name", UserName);
        if UserRec.FindFirst() then
            exit(UserRec."User Security ID");
    end;
}
