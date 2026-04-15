page 51046 "MPESA Withdrawal Buffer"
{
    ApplicationArea = All;
    Caption = 'MPESA Requests';
    PageType = List;
    SourceTable = "Mpesa Withdawal Buffer";
    // Editable = false;
    // ModifyAllowed = false;
    DeleteAllowed = false;
    InsertAllowed = false;
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Vendor No"; Rec."Vendor No")
                {
                    ToolTip = 'Specifies the value of the Member No field.';
                }
                field("Vendor Name"; Rec."Vendor Name")
                {
                    ToolTip = 'Specifies the value of the Payroll No field.';
                }
                field("Amount Requested"; Rec."Amount Requested")
                {
                    ToolTip = 'Specifies the value of the Region field.';
                }
                field("Account Balance";Rec."Account Balance")
                {
                    ToolTip = 'Specifies the value of the Region field.';
                }
                field("Originator ID"; Rec."Originator ID")
                {
                    ToolTip = 'Specifies the value of the Grade field.';
                }
                field(MpesaReferenceCode; Rec.Trace)
                {
                    Caption = 'Mpesa Reference Code';
                    // TableRelation = "MOBILE MPESA Trans".Trace;
                }
                field("Transaction Date"; Rec."Transaction Date")
                {
                    ToolTip = 'Specifies the value of the Gross Amount field.';
                }
                field("Posted Time"; Rec."Posted Time")
                { }
                field("Telephone No"; Rec."Telephone No")
                {
                    ToolTip = 'Specifies the value of the Net Salary field.';
                }
                field("Member No"; Rec."Member No")
                {
                    ToolTip = 'Specifies the value of the Net Salary field.';
                }
                field(Posted; Rec.Posted)
                {
                    ToolTip = 'Specifies the value of the Net Salary field.';
                    Editable = edit;
                }
                field(Reversed; Rec.Reversed)
                {
                    ToolTip = 'Specifies the value of the Net Salary field.';
                    Editable = edit;
                }
                field("Transaction Completed"; Rec."Transaction Completed")
                {
                    ToolTip = 'Specifies the value of the Net Salary field.';
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(RunGNL)
            {
                Caption = 'Run Journal Lines';
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction() begin
                    userSetup.Reset();
                    userSetup.SetRange("User ID", UserId);
                    if userSetup.Find('-') then begin
                        if userSetup."Post Pending ABC" = false then Error('The user %1 lacks the permissions to post penidng ABC transactions.', UserId);
                            
                        Clear(mpesaReff);
                        if mpesaReff.RunModal() = Action::Yes then begin
                            mpesa := mpesaReff.GetEnterMPESAReff();
                            if mpesa <> '' then begin
                                Message('You have inputted MPESA reff code: %1', mpesa);
                                runJournal.PostPendingWithdrawals(Rec."Originator ID", mpesa);
                            end else Message('You cannot post this transaction without an Mpesa Refference Code.');
                        end else if mpesaReff.RunModal() = Action::Cancel then begin
                            Message('You cannot "Cancel" this request.');
                            Clear(mpesaReff);
                        end else if mpesaReff.RunModal() = Action::No then begin
                            Message('You cannot "No" this request.');
                            Clear(mpesaReff);
                        end else if mpesaReff.RunModal() = Action::OK then begin
                            Message('You cannot "OK" this request.');
                            Clear(mpesaReff);
                        end;
                    end;
                end;
            }
        }
    }
    var
    edit: Boolean;
    mpesa: Code[20];
    mpesaReff: Page "Mpesa Refference Code";
    runJournal: Codeunit "Post Pending Paybill Trans";
    userSetup: Record "User Setup";

    trigger OnOpenPage() begin
        edit := false;
        if userSetup.Get(UserId) then begin
            if userSetup."Send Red Flagged SMS" = true then begin
                edit := true;
            end else edit := false;
        end;
    end;
    trigger OnAfterGetRecord()
    var
        TransCode: Record "MOBILE MPESA Trans";
        postedTime: Time;
    begin
        TransCode.Reset();
        TransCode.SetRange(TransCode."Document No", Rec."Originator ID");
        if TransCode.FindSet() then begin
            // Rec.Trace := TransCode.Trace;
        end;

        postedTime := DT2Time(Rec.SystemCreatedAt);
        Rec."Posted Time" := postedTime;
    end;
}



