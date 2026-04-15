//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50464 "Scheduled Statements Card"
{
    ApplicationArea = All;
    PageType = Card;
    SourceTable = "Scheduled Statements";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Document No"; Rec."Document No")
                {
                    Editable = false;
                }
                field("Member No"; Rec."Member No")
                {
                }
                field("Member Name"; Rec."Member Name")
                {
                    Editable = false;
                }
                field("Statement Type"; Rec."Statement Type")
                {

                    trigger OnValidate()
                    begin
                        EnableField := false;
                        if Rec."Statement Type" = Rec."statement type"::"Account Statement" then
                            EnableField := true;
                    end;
                }
                field("Account No"; Rec."Account No")
                {
                    Enabled = EnableField;
                }
                field("Account Email"; Rec."Account Email")
                {
                    Enabled = EnableField;
                }
                field("Statement Period"; Rec."Statement Period")
                {
                    Caption = 'Statement Period (e.g. -5D, -3W, -1M)';
                }
                field(Frequency; Rec.Frequency)
                {
                    OptionCaption = 'Daily,Weekly,Monthly';

                    trigger OnValidate()
                    begin
                        EnableWeeklyFreq := false;
                        EnableDayOfMonth := false;
                        if Rec.Frequency = Rec.Frequency::Weekly then
                            EnableWeeklyFreq := true;
                        if Rec.Frequency = Rec.Frequency::Mothly then
                            EnableDayOfMonth := true;
                    end;
                }
                field("Output Format"; Rec."Output Format")
                {
                    OptionCaption = 'PDF,EXCEL';
                }
                group(Control23)
                {
                    Visible = EnableWeeklyFreq;
                    field("Days of Week"; Rec."Days of Week")
                    {
                        Caption = 'Days of Week (Mo,Tu,We..)';
                    }
                }
                group(Control24)
                {
                    Visible = EnableDayOfMonth;
                    field("Days Of Month"; Rec."Days Of Month")
                    {
                        Caption = 'Days Of Month (01,05,30)';
                        Visible = EnableDayOfMonth;
                    }
                }
                field("Schedule Status"; Rec."Schedule Status")
                {
                }
                field("Created By"; Rec."Created By")
                {
                }
                field("Created On"; Rec."Created On")
                {
                }
                field("Activated By"; Rec."Activated By")
                {
                }
                field("Activated On"; Rec."Activated On")
                {
                }
                field("Stopped By"; Rec."Stopped By")
                {
                }
                field("Stopped On"; Rec."Stopped On")
                {
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action(ActiveSheduledStatement)
            {
                Caption = 'Activate Sheduled Statement';
                Image = Apply;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    if Confirm('Confirm Scheduled Statement Enable', false) = true then begin
                        Rec."Schedule Status" := Rec."schedule status"::Active;
                        Rec."Activated By" := UserId;
                        Rec."Activated On" := WorkDate;
                    end;
                end;
            }
            action(StopScheduledStatement)
            {
                Caption = 'Stop Scheduled Statement';
                Image = UnApply;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    if Confirm('Confirm Scheduled Statement Disable', false) = true then begin
                        Rec."Schedule Status" := Rec."schedule status"::Stopped;
                        Rec."Stopped By" := UserId;
                        Rec."Stopped On" := WorkDate;
                    end;
                end;
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        EnableField := false;
        if Rec."Statement Type" = Rec."statement type"::"Account Statement" then
            EnableField := true;

        EnableWeeklyFreq := false;
        EnableDayOfMonth := false;
        if Rec.Frequency = Rec.Frequency::Weekly then
            EnableWeeklyFreq := true;
        if Rec.Frequency = Rec.Frequency::Mothly then
            EnableDayOfMonth := true;
    end;

    trigger OnAfterGetRecord()
    begin
        EnableField := false;
        if Rec."Statement Type" = Rec."statement type"::"Account Statement" then
            EnableField := true;

        EnableWeeklyFreq := false;
        EnableDayOfMonth := false;
        if Rec.Frequency = Rec.Frequency::Weekly then
            EnableWeeklyFreq := true;
        if Rec.Frequency = Rec.Frequency::Mothly then
            EnableDayOfMonth := true;
    end;

    trigger OnOpenPage()
    begin
        EnableField := false;
        if Rec."Statement Type" = Rec."statement type"::"Account Statement" then
            EnableField := true;

        EnableWeeklyFreq := false;
        EnableDayOfMonth := false;
        if Rec.Frequency = Rec.Frequency::Weekly then
            EnableWeeklyFreq := true;
        if Rec.Frequency = Rec.Frequency::Mothly then
            EnableDayOfMonth := true;
    end;

    var
        EnableField: Boolean;
        EnableWeeklyFreq: Boolean;
        EnableDayOfMonth: Boolean;
}






