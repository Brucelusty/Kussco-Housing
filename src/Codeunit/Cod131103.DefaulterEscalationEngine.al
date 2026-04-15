namespace KUSCCOHOUSING.KUSCCOHOUSING;

codeunit 50127 "Defaulter Escalation Engine"
{
    // Caption = 'Defaulter Escalation Engine';
    SingleInstance = true;
    Subtype = Normal;

    procedure RunAll()
    var
        DefaulterCase: Record "Defaulter Case";
    begin
        if DefaulterCase.FindSet() then
            repeat
                ProcessEscalation(DefaulterCase);
            until DefaulterCase.Next() = 0;
    end;

    procedure ProcessEscalation(var DefaulterCase: Record "Defaulter Case")
    var
        CommRec: Record "Defaulter Communication";
        PlanRec: Record "Recovery Payment Plan";
    //  AuditRec: Record "Recovery Audit Log";
    begin
        // 1️⃣ Skip if under payment plan and on-track
        if DefaulterCase."Under Payment Plan" then
            exit;

        // 2️⃣ Check Days in Arrears and advance stage
        case DefaulterCase."Recovery Stage" of
            DefaulterCase."Recovery Stage"::"In-house":
                if DefaulterCase."Days in Arrears" > 30 then
                    SetNextStage(DefaulterCase, DefaulterCase."Recovery Stage"::"Statutory Notice");

            DefaulterCase."Recovery Stage"::"Statutory Notice":
                if AllNoticesExpired(DefaulterCase) then
                    SetNextStage(DefaulterCase, DefaulterCase."Recovery Stage"::Legal);

            DefaulterCase."Recovery Stage"::Legal:
                if DefaulterCase."Days in Arrears" > 90 then
                    SetNextStage(DefaulterCase, DefaulterCase."Recovery Stage"::"Forced Sale");

            DefaulterCase."Recovery Stage"::"Forced Sale":
                if DefaulterCase."FSV" > 0 then
                    SetNextStage(DefaulterCase, DefaulterCase."Recovery Stage"::Auction);

            DefaulterCase."Recovery Stage"::Auction:
                if AuctionUnsuccessful(DefaulterCase) then
                    SetNextStage(DefaulterCase, DefaulterCase."Recovery Stage"::"Repeat Auction");

            DefaulterCase."Recovery Stage"::"Repeat Auction":
                if AuctionUnsuccessful(DefaulterCase) then
                    SetNextStage(DefaulterCase, DefaulterCase."Recovery Stage"::"Conditional Suspension");
        end;
    end;

    local procedure SetNextStage(var DefaulterCase: Record "Defaulter Case"; NextStage: Enum "Recovery Stage")
    var
        AuditRec: Record "Recovery Audit Log";
    begin
        AuditRec.Init;
        AuditRec."Case No." := DefaulterCase."Case No.";
        AuditRec."Action Type" := 'Stage Change';
        AuditRec."Old Value" := Format(DefaulterCase."Recovery Stage");
        AuditRec."New Value" := Format(NextStage);
        AuditRec."User ID" := UserId;
        AuditRec."Date Time" := CurrentDateTime;
        AuditRec.Insert;

        DefaulterCase.Validate("Recovery Stage", NextStage);
        DefaulterCase.Modify(true);
    end;

    local procedure AllNoticesExpired(DefaulterCase: Record "Defaulter Case"): Boolean
    var
        NoticeRec: Record "Statutory Notice Entry";
    begin
        if NoticeRec.Get(DefaulterCase."Case No.") then
            if NoticeRec."Expiry Date" >= Today then
                exit(false);
        exit(true);
    end;

    local procedure AuctionUnsuccessful(DefaulterCase: Record "Defaulter Case"): Boolean
    var
        AuctionRec: Record "Auction Entry";
    begin
        if AuctionRec.Get(DefaulterCase."Case No.") then
            if AuctionRec.Status = AuctionRec.Status::Unsuccessful then
                exit(true);
        exit(false);
    end;

    [IntegrationEvent(false, false)]
    procedure OnEscalationStageChange(var DefaulterCase: Record "Defaulter Case"; OldStage: Enum "Recovery Stage"; NewStage: Enum "Recovery Stage")
    begin
        // Event raised for notifications or extensions
    end;
}

