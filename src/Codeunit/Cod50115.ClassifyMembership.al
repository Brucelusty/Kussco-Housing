codeunit 50115 "Classify Membership"
{
    trigger OnRun()
    begin
       // RunClassifyDormancy();
        // FnClassifyMemberCategory();
        // FNUpdateFOSAAccounts();
    end;

    local procedure RunClassifyDormancy()
    var
        myInt: Integer;
    begin
        cust.LockTable();
        vend.LockTable();
        saccoGen.Get();
        cust.Reset();
        cust.SetRange(ISNormalMember, true);
        cust.SetFilter("Membership Status", '%1|%2', cust."Membership Status"::Active, cust."Membership Status"::Dormant);
        if cust.FindSet() then begin
            repeat
                cust.CalcFields("Shares Retained");
                vend.Reset();
                vend.SetRange("BOSA Account No", cust."No.");
                vend.SetRange("Account Type", '102');
                if vend.Find('-') then begin
                    vend.CalcFields("Last Account Credit Trans");
                    startDate := CalcDate('<CM-1M>', Today);
                    refDepdate := CalcDate('<-' + Format(saccoGen."Dormancy Period") + '>', startDate);
                    // Error('Start Date:%1, Refference Date:%2.', startDate, refDepdate);
                    if vend."Last Account Credit Trans" <> 0D then begin
                        if vend."Last Account Credit Trans" < refDepdate then begin
                            cust."Membership Status" := cust."Membership Status"::Dormant;
                            cust.Validate("Membership Status");
                            cust.modify;
                        end else begin
                            cust."Membership Status" := cust."Membership Status"::Active;
                            cust.Validate("Membership Status");
                            cust.modify;
                        end;
                    end else begin
                        if cust."Shares Retained" <= 0 then begin
                            cust."Membership Status" := cust."Membership Status"::Dormant;
                            cust.Validate("Membership Status");
                            cust.modify;
                        end;
                    end;
                    // end else begin
                    //     cust."Membership Status" := cust."Membership Status"::Closed;
                    //     cust.Validate("Membership Status");
                    //     cust.modify;
                end;
            until cust.Next() = 0;
        end;

        cust.Reset();
        cust.SetRange(ISNormalMember, true);
        cust.SetFilter("Membership Status", '%1', cust."Membership Status"::Closed);
        if cust.FindSet() then begin
            repeat
                cust.CalcFields("Shares Retained");
                if cust."Registration Date" <> 0D then begin
                    if /*(cust."Shares Retained" >= 0) and */(cust."Registration Date">CalcDate('<-6M>',Today))then begin
                        cust."Membership Status" := cust."Membership Status"::Dormant;
                        cust.Validate("Membership Status");
                        cust.modify;
                    end;
                end;


                
            until cust.Next() = 0;
        end;
    end;

    local procedure FnClassifyMemberCategory()
    var
        myInt: Integer;
    begin

        // cust.Reset();
        // cust.SetRange(ISNormalMember, true);
        // cust.SetRange("Insider Status", cust."Insider Status"::"Delegate Member");
        // if cust.FindSet() then begin
        //     repeat
        //     insider.Init();
        //     insider."Member No":= cust."No.";
        //     insider."Member Name":= cust.Name;
        //     insider."ID No.":= cust."ID No.";
        //     insider."E-Mail":= cust."E-Mail";
        //     insider."Mobile No.":= cust."Mobile Phone No";
        //     insider.Employer:= cust."Employer Code";
        //     insider."Position Held" := insider."Position Held"::Delegate;
        //     if not insider.Insert() then insider.Modify();
        //     until cust.Next()=0;
        // end;

        insider.Reset();
        insider.SetRange("Position Held", insider."Position Held"::Delegate);
        if insider.FindSet() then begin
            repeat
                cust.Reset();
                if cust.Get(insider."Member No") then begin
                    cust."Member Type" := cust."Member Type"::"Station Representative";
                    cust."Insider Status" := cust."Insider Status"::"Delegate Member";
                    cust.Modify();
                end;
            until insider.Next() = 0;
        end;
    end;

    local procedure FNUpdateFOSAAccounts()
    var
    begin
        cust.Reset();
        cust.SetRange(ISNormalMember, true);
        if cust.FindSet() then begin
            repeat
                Vend.Reset();
                Vend.SetRange("BOSA Account No", cust."No.");
                if Vend.Find('-') then begin
                    repeat
                        if Vend."Account Type" = '101' then begin
                            cust."Share Capital No" := Vend."No.";
                            cust.Modify(true);
                        end else
                            if Vend."Account Type" = '102' then begin
                                cust."Deposits Account No" := Vend."No.";
                                cust.Modify(true);
                            end else
                                if Vend."Account Type" = '103' then begin
                                    cust."FOSA Account No." := Vend."No.";
                                    cust."Ordinary Savings Acc" := Vend."No.";
                                    cust.Modify(true);
                                end else
                                    if Vend."Account Type" = '104' then begin
                                        cust."School Fees Shares Account" := Vend."No.";
                                        cust.Modify(true);
                                    end else
                                        if Vend."Account Type" = '105' then begin
                                            cust."Chamaa Savings Acc" := Vend."No.";
                                            cust.Modify(true);
                                        end else
                                            if Vend."Account Type" = '106' then begin
                                                cust."Jibambe Savings Acc" := Vend."No.";
                                                cust.Modify(true);
                                            end else
                                                if Vend."Account Type" = '107' then begin
                                                    cust."Wezesha Savings Acc" := Vend."No.";
                                                    cust.Modify(true);
                                                end else
                                                    if Vend."Account Type" = '108' then begin
                                                        cust."Fixed Deposit Acc" := Vend."No.";
                                                        cust.Modify(true);
                                                    end else
                                                        if Vend."Account Type" = '109' then begin
                                                            cust."Mdosi Junior Acc" := Vend."No.";
                                                            cust.Modify(true);
                                                        end else
                                                            if Vend."Account Type" = '110' then begin
                                                                cust."Pension Akiba Acc" := Vend."No.";
                                                                cust.Modify(true);
                                                            end else
                                                                if Vend."Account Type" = '111' then begin
                                                                    cust."Business Account Acc" := Vend."No.";
                                                                    cust.Modify(true);
                                                                end;
                    until Vend.Next() = 0;
                end;
            until cust.Next() = 0;
        end;
    end;

    var
        lineNo: Integer;
        startDate: Date;
        refDepdate: Date;
        docNo: Code[20];
        batchTemplate: Code[20];
        batchName: Code[20];
        AUFactory: Codeunit "Au Factory";
        GenJournalLine: Record "Gen. Journal Line";
        cust: Record Customer;
        vend: Record Vendor;
        saccoGen: Record "Sacco General Set-Up";
        insider: Record InsiderLending;
        employees: Record "Payroll Employee.";

}
