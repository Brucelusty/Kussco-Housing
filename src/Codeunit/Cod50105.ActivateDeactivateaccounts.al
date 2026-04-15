codeunit 50105 "Activate/Deactivate accounts"
{

    trigger OnRun()
    begin
        //FnMarkAccountAsActive();
        // FnMarkAccountAsDormant();
        FnMarkMemberAsActive();
        // FnMarkMemberAsDormant();
    end;

    var
        GenSetup: Record "Sacco General Set-Up";
        ProgressWindow: Dialog;
        //Checkoff: Record "50699";
        LineNo: Integer;
        MonthOne: Boolean;
        MonthTwo: Boolean;
        MonthThree: Boolean;
        MemberLedger: Record "Detailed Cust. Ledg. Entry";
        MonthOneM: Date;
        MonthTwoM: Date;
        MonthThreeM: Date;
        MinimumContrib: Decimal;
        TotalContrib: Decimal;

    procedure FnMarkMemberAsDormant()
    var
        Members: Record Customer;
        MemberLedgerEntry: Record "Member Ledger Entry";
        MinDate: Date;
        DormancyPeriod: DateFormula;
    begin
        /*         GenSetup.GET();
                MinDate:=0D;

                MinDate:=CALCDATE('<-3M>',TODAY);
                Members.RESET;
                Members.SETRANGE(Members.Status,Members.Status::Active);
                IF Members.FINDFIRST THEN BEGIN
                ProgressWindow.OPEN('Mark Member Account as Dormant #1#######');
                REPEAT
                SLEEP(100);
                Members.CALCFIELDS(Members."Last Deposit Date Deposit");
                IF Members."Last Deposit Date Deposit"<MinDate THEN BEGIN
                Members.Status:=Members.Status::Dormant;
                Members.MODIFY;
                END;
                ProgressWindow.UPDATE(1,Members."No."+':'+Members.Name);
                UNTIL Members.NEXT=0;
                ProgressWindow.CLOSE;
                END; */
    end;

    procedure FnMarkMemberAsActive()
    var
        Members: Record Customer;
        MemberLedgerEntry: Record "Detailed Cust. Ledg. Entry";

        MemberLedgers: Record "Member Ledger Entry";

        Found: Boolean;
        TotalContribs: Decimal;
        MinDate: Date;
        DormancyPeriod: DateFormula;

        DtVendor: Record "Detailed Vendor Ledg. Entry";
    begin
        GenSetup.GET();
        MinDate := 0D;
        MinDate := CALCDATE('<-3M>', TODAY);
        Members.RESET;
        // Members.SETRANGE(Members."No.",'013711');
        IF Members.FindSet() THEN BEGIN
            ProgressWindow.OPEN('Mark Member Account as Active #1#######');
            REPEAT
                SLEEP(100);
                MonthOne := FALSE;
                MonthTwo := FALSE;
                MonthThree := FALSE;
                MonthOneM := CALCDATE('CM', CALCDATE('-CM-2M', TODAY));
                MonthTwoM := CALCDATE('CM', CALCDATE('-1M', MonthOneM));
                MonthThreeM := CALCDATE('-3M', TODAY);
                //MESSAGE('Month1%1Month%2Month%3',MonthOneM,MonthTwoM,MonthThreeM);
                /*MemberLedger.RESET;
                MemberLedger.SETRANGE(MemberLedger."Customer No.",Members."No.");
                MemberLedger.SETFILTER(MemberLedger."Transaction Type",'%1',MemberLedger."Transaction Type"::"Deposit Contribution");
                MemberLedger.SETFILTER(MemberLedger."Posting Date",'%1..%2',CALCDATE('-CM',MonthOneM),MonthOneM);
                MemberLedger.SETRANGE(MemberLedger.Reversed,FALSE);
                MemberLedger.SETFILTER(MemberLedger.Amount,'<%1',0);
                IF MemberLedger.FINDFIRST THEN BEGIN
                MonthOne:=TRUE;
                END;

                MemberLedger.RESET;
                MemberLedger.SETRANGE(MemberLedger."Customer No.",Members."No.");
                MemberLedger.SETFILTER(MemberLedger."Transaction Type",'%1',MemberLedger."Transaction Type"::"Deposit Contribution");
                MemberLedger.SETFILTER(MemberLedger."Posting Date",'%1..%2',CALCDATE('-CM',MonthTwoM),MonthTwoM);
                MemberLedger.SETRANGE(MemberLedger.Reversed,FALSE);
                MemberLedger.SETFILTER(MemberLedger.Amount,'<%1',0);
                IF MemberLedger.FINDFIRST THEN BEGIN
                MonthTwo:=TRUE;
                END;


                MemberLedger.RESET;
                MemberLedger.SETRANGE(MemberLedger."Customer No.",Members."No.");
                MemberLedger.SETFILTER(MemberLedger."Transaction Type",'%1',MemberLedger."Transaction Type"::"Deposit Contribution");
                MemberLedger.SETFILTER(MemberLedger."Posting Date",'%1..%2',CALCDATE('-CM',MonthThreeM),MonthThreeM);
                MemberLedger.SETRANGE(MemberLedger.Reversed,FALSE);
                MemberLedger.SETFILTER(MemberLedger.Amount,'<%1',0);
                IF MemberLedger.FINDFIRST THEN BEGIN
                //MESSAGE('Month3');
                MonthThree:=TRUE;
                END;*/

                TotalContrib := 0;
                /*                 MemberLedger.RESET;
                                MemberLedger.SETRANGE(MemberLedger."Customer No.", Members."No.");
                                MemberLedger.SETFILTER(MemberLedger."Transaction Type", '%1', MemberLedger."Transaction Type"::"Deposit Contribution");
                                MemberLedger.SETFILTER(MemberLedger."Posting Date", '%1..%2', CALCDATE('-3M', TODAY), TODAY);
                                MemberLedger.SetFilter(MemberLedger."Document No.", '<>%1', 'DEPOSBBF310324');
                                MemberLedger.SETRANGE(MemberLedger.Reversed, FALSE);
                                IF MemberLedger.FINDSET THEN BEGIN
                                    MemberLedger.CALCSUMS(MemberLedger."Amount (LCY)");
                                    TotalContrib := -MemberLedger."Amount (LCY)";
                                END; */

                DtVendor.Reset();
                DtVendor.SetRange(DtVendor."Vendor No.", Members."Deposits Account No");
                DtVendor.SetFilter(DtVendor."Posting Date", '%1..%2', CALCDATE('-3M', TODAY), TODAY);
                DtVendor.SetFilter(DtVendor."Document No.", '<>%1', 'DEPOSBBF310324');
                DtVendor.SetRange(DtVendor.Reversed, false);
                if DtVendor.FindSet then begin
                    DtVendor.CalcSums(DtVendor.Amount);
                    TotalContrib := -DtVendor.Amount;
                end;

                TotalContribs := 0;
                MemberLedgers.RESET;
                MemberLedgers.SETRANGE(MemberLedgers."Customer No.", Members."No.");
                MemberLedgers.SETFILTER(MemberLedgers."Transaction Type", '%1', MemberLedgers."Transaction Type"::"Deposit Contribution");
                MemberLedgers.SETFILTER(MemberLedgers."Posting Date", '%1..%2', CALCDATE('-3M', TODAY), TODAY);
                MemberLedgers.SETRANGE(MemberLedgers.Reversed, FALSE);
                IF MemberLedgers.FINDSET THEN BEGIN
                    MemberLedgers.CALCSUMS(MemberLedgers."Amount (LCY)");
                    TotalContribs := -MemberLedgers."Amount (LCY)";
                END;

                MinimumContrib := GenSetup."Min. Contribution";

                TotalContrib := TotalContrib + TotalContribs;

                IF TotalContrib > 0 THEN
                    Members.Status := Members.Status::Active
                ELSE
                    Members.Status := Members.Status::Dormant;

                if Members."Registration Date" <> 0D then begin
                    if CalcDate('3M', Members."Registration Date") > Today then
                        Members.Status := Members.Status::Active;
                end;

                Members.MODIFY;

                ProgressWindow.UPDATE(1, Members."No." + ':' + Members.Name);
            UNTIL Members.NEXT = 0;
            ProgressWindow.CLOSE;
        END;

    end;

    procedure FnMarkAccountAsDormant()
    var
        Vendor: Record Vendor;
        VendorLedgerEntry: Record 25;
        MinDate: Date;
        DormancyPeriod: DateFormula;
    begin
        GenSetup.GET();
        MinDate := 0D;

        MinDate := CALCDATE('<-6M>', TODAY);
        Vendor.RESET;
        Vendor.SETRANGE(Vendor.Status, Vendor.Status::Active);
        Vendor.SETRANGE(Vendor."Account Type", 'ORDINARY');
        //Vendor.SETRANGE(Vendor."No.",'0502-001-00405');
        IF Vendor.FINDFIRST THEN BEGIN
            ProgressWindow.OPEN('Mark FOSA Account as Dormant #1#######');
            REPEAT
                SLEEP(100);
                VendorLedgerEntry.RESET;
                VendorLedgerEntry.SETRANGE(VendorLedgerEntry."Vendor No.", Vendor."No.");
                //Vendor.SETRANGE(Vendor."No.",'0502-009-26668');
                IF VendorLedgerEntry.FINDLAST THEN BEGIN
                    //MESSAGE('%1-%2',MinDate,VendorLedgerEntry."Posting Date");
                    IF VendorLedgerEntry."Posting Date" < MinDate THEN BEGIN
                        Vendor.Status := Vendor.Status::Dormant;
                        Vendor.MODIFY;
                    END;
                END ELSE BEGIN
                    Vendor.Status := Vendor.Status::Dormant;
                    Vendor.MODIFY;
                END;
                ProgressWindow.UPDATE(1, Vendor."No." + ':' + Vendor.Name);
            UNTIL Vendor.NEXT = 0;
            ProgressWindow.CLOSE;
        END;
    end;

    procedure FnMarkAccountAsActive()
    var
        Vendor: Record 23;
        VendorLedgerEntry: Record 25;
        MinDate: Date;
        DormancyPeriod: DateFormula;
    begin
        GenSetup.GET();
        MinDate := 0D;
        MinDate := CALCDATE('<-6M>', TODAY);
        Vendor.RESET;
        Vendor.SETRANGE(Vendor.Status, Vendor.Status::Dormant);
        Vendor.SETRANGE(Vendor."Account Type", 'ORDINARY');
        //Vendor.SETRANGE(Vendor."No.",'0502-009-26668');
        //Vendor.SETRANGE(Vendor."No.",'0502-001-00405');
        IF Vendor.FINDFIRST THEN BEGIN
            ProgressWindow.OPEN('Mark FOSA Account as Active #1#######');
            REPEAT
                SLEEP(100);
                VendorLedgerEntry.RESET;
                VendorLedgerEntry.SETRANGE(VendorLedgerEntry."Vendor No.", Vendor."No.");
                IF VendorLedgerEntry.FINDLAST THEN BEGIN
                    // MESSAGE('Min date %1-compare date%2',MinDate,VendorLedgerEntry."Posting Date");
                    IF VendorLedgerEntry."Posting Date" >= MinDate THEN BEGIN
                        Vendor.Status := Vendor.Status::Active;
                        Vendor.MODIFY;
                    END;
                END ELSE BEGIN
                    Vendor.Status := Vendor.Status::Dormant;
                    Vendor.MODIFY;
                END;
                ProgressWindow.UPDATE(1, Vendor."No." + ':' + Vendor.Name);
            UNTIL Vendor.NEXT = 0;
            ProgressWindow.CLOSE;
        END;
    end;

    procedure FnInsertCheckoffSMS("Client Code": Code[40]; Deduction: Text[40]; Amount: Decimal)
    begin
        //    IF Checkoff.FINDLAST THEN
        //     LineNo:=Checkoff.No+1
        //  ELSE
        //   LineNo:=1;
    end;

    procedure FnMarkAccountAsDefaulter()
    var
        Loans: Record "Loans Register";
        Members: Record Customer;
        Defaulter: Boolean;
    begin
        IF Members.FINDFIRST THEN BEGIN
            Defaulter := FALSE;
            REPEAT
                Loans.SETRANGE(Loans."Client Code", Members."No.");
                Loans.SETAUTOCALCFIELDS(Loans."Outstanding Balance");
                Loans.SETFILTER(Loans."Outstanding Balance", '>%1', 0);
                Loans.SETFILTER(Loans."Loans Category-SASRA", '%1|%2|%3', Loans."Loans Category-SASRA"::Loss, Loans."Loans Category-SASRA"::Loss, Loans."Loans Category-SASRA"::Substandard);
                IF Loans.FINDFIRST THEN BEGIN
                    REPEAT
                        Defaulter := TRUE;
                    UNTIL Loans.NEXT = 0;
                END;
            // IF Defaulter=TRUE THEN
            // Members."Loan Status":=Members."Loan Status"::Defaulter
            //  ELSE
            //Members."Loan Status":=Members."Loan Status"::Performing;
            //  Members.MODIFY;
            UNTIL Members.NEXT = 0;
        END;
    end;
}

