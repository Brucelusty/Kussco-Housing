codeunit 50101 "Loan Aging Classification"
{

    trigger OnRun()
    begin
        FnClassifyLoans();
        //Activate.FnMarkAccountAsDefaulter();
        //CODEUNIT.RUN(51516164,TRUE)
    end;

    var
        Loans: Record "Loans Register";
        RSchedule: Record "Loan Repayment Schedule";
        TotalExpectedAmount: Decimal;
        TotalPaidAMount: Decimal;
        MonthlyRepayments: Decimal;
        NumberOfMonths: Decimal;
        NumberOfDays: Decimal;
        Arrears: Decimal;
        Generate: Codeunit "Generate Schedule";
        TotalInterestPaid: Decimal;
        GenSetup: Record "Sacco General Set-Up";
        ProgressWindow: Dialog;
        Loanss: Record "Loans Register";
        // Activate: Codeunit "Activate";

    procedure FnClassifyLoans()
    begin
        Loans.RESET;
        Loans.SETRANGE(Loans.Posted,TRUE);
        Loans.SETAUTOCALCFIELDS(Loans."Totals Loan Outstanding");
        Loans.SETFILTER(Loans."Totals Loan Outstanding",'>%1',0);
        Loans.SETRANGE(Loans.Posted,TRUE);
        //Loans.SETRANGE(Loans."Loan  No.",'LN020359');
        
        IF Loans.FINDFIRST THEN
        BEGIN
        ProgressWindow.OPEN('Classifying loans #1#######');
        REPEAT
        SLEEP(100);
        Loans.CALCFIELDS(Loans."Outstanding Balance");
        IF Loans."Outstanding Balance">0 THEN BEGIN
        TotalExpectedAmount:=0;
        TotalPaidAMount:=0;
        MonthlyRepayments:=0;
        NumberOfMonths:=0;
        NumberOfDays:=0;
        Arrears:=0;
        TotalInterestPaid:=0;
        
        RSchedule.RESET;
        RSchedule.SETRANGE(RSchedule."Loan No.",Loans."Loan  No.");
        IF NOT RSchedule.FINDFIRST THEN BEGIN
        Loans.VALIDATE(Loans."Loan Disbursement Date");
        Generate.Autogenerateschedule(Loans."Loan  No.");
        END;
        RSchedule.RESET;
        RSchedule.SETRANGE(RSchedule."Loan No.",Loans."Loan  No.");
        RSchedule.SETFILTER(RSchedule."Repayment Date",'<=%1',TODAY);
        IF RSchedule.FINDSET THEN
        BEGIN
        RSchedule.CALCSUMS(RSchedule."Monthly Repayment");
        TotalExpectedAmount:=RSchedule."Monthly Repayment";
        END;
        
        Loans.CALCFIELDS(Loans."Outstanding Balance",Loans."Current Interest Paid");
        TotalPaidAMount:=Loans."Approved Amount"-Loans."Outstanding Balance";
        TotalInterestPaid:=Loans."Current Interest Paid"*-1;
        TotalPaidAMount:=TotalPaidAMount+TotalInterestPaid;
        Arrears:=TotalExpectedAmount-TotalPaidAMount;
        Loans."Amount in Arrears":=Arrears;
        
        RSchedule.RESET;
        RSchedule.SETRANGE(RSchedule."Loan No.",Loans."Loan  No.");
        IF RSchedule.FINDFIRST THEN BEGIN
        MonthlyRepayments:=RSchedule."Monthly Repayment"
        END;
        IF MonthlyRepayments>0 THEN BEGIN
        NumberOfMonths:=ROUND((Arrears/MonthlyRepayments),1,'=');
        NumberOfDays:=NumberOfMonths*30;
        Loans."Days In Arrears":=NumberOfDays;
        // END ELSE BEGIN
        //Generate.Autogenerateschedule(Loans."Loan  No.");
        // NumberOfMonths:=ROUND((Arrears/MonthlyRepayments),1,'=');
        // NumberOfDays:=NumberOfMonths*30;
        END;
        //MESSAGE('Expected%1 Pid%2 Arrears%3NoOfdays%4 Repayment%5',TotalExpectedAmount,TotalPaidAMount,Arrears,NumberOfDays,MonthlyRepayments);
        IF Loans."Expected Date of Completion">=TODAY THEN BEGIN
        IF NumberOfDays<=30 THEN BEGIN
        Loans."Loans Category-SASRA":=Loans."Loans Category-SASRA"::Perfoming;
        Loans."Loans Category":=Loans."Loans Category"::Perfoming;
        END ELSE IF(NumberOfDays>30) AND (NumberOfDays<=60) THEN BEGIN
        Loans."Loans Category-SASRA":=Loans."Loans Category-SASRA"::Watch;
        Loans."Loans Category":=Loans."Loans Category"::Watch;
        END ELSE IF(NumberOfDays>60) AND (NumberOfDays<=180) THEN BEGIN
        Loans."Loans Category-SASRA":=Loans."Loans Category-SASRA"::Substandard;
        Loans."Loans Category":=Loans."Loans Category"::Substandard;
        END ELSE IF(NumberOfDays>180) AND (NumberOfDays<=360) THEN BEGIN
        Loans."Loans Category-SASRA":=Loans."Loans Category-SASRA"::Doubtful;//
        Loans."Loans Category":=Loans."Loans Category"::Doubtful;
        END ELSE IF(NumberOfDays>360)  THEN BEGIN
        Loans."Loans Category-SASRA":=Loans."Loans Category-SASRA"::Loss;
        Loans."Loans Category":=Loans."Loans Category"::Loss;
        END;
        END ELSE BEGIN
        Loans."Loans Category-SASRA":=Loans."Loans Category-SASRA"::Loss;
        Loans."Loans Category":=Loans."Loans Category"::Loss;
        END;
        IF Loans."Loans Category"=Loans."Loans Category"::Loss THEN BEGIN
        FunctionMarkAsDefaulter(Loans."Staff No");
        END;
        END;
        Loans.CALCFIELDS(Loans."Outstanding Interest");
        
        FnFindLoansWithInterest(Loans."Loan  No.");
        IF (Loans."Outstanding Balance"=0) AND (Loans."Outstanding Interest"=0) THEN BEGIN
        Loans."Loans Category-SASRA":=Loans."Loans Category-SASRA"::Perfoming;
        Loans."Loans Category":=Loans."Loans Category"::Perfoming;
        END;
        Loans.CALCFIELDS(Loans."Outstanding Penalty");
        IF (Loans."Outstanding Balance"<0) OR (Loans."Outstanding Interest"<0)/* OR (Loans."Oustanding Penalty"<0)*/ THEN BEGIN
        //MESSAGE('hERE');
        Loans."Loans Category-SASRA":=Loans."Loans Category-SASRA"::Loss;
        Loans."Loans Category":=Loans."Loans Category"::Loss;
        END;
        
        //MESSAGE('hERE2');
        IF (Loans."Expected Date of Completion"<TODAY) AND (Loans."Outstanding Interest">0) THEN BEGIN
        Loans."Loans Category-SASRA":=Loans."Loans Category-SASRA"::Loss;
        Loans."Loans Category":=Loans."Loans Category"::Loss;
        END;
        
        IF (Loans."Outstanding Balance"<=0) AND (Loans."Outstanding Interest">0) THEN BEGIN
        Loans."Loans Category-SASRA":=Loans."Loans Category-SASRA"::Loss;
        Loans."Loans Category":=Loans."Loans Category"::Loss;
        END;
        
        IF (Loans."Expected Date of Completion"<TODAY) AND (Loans."Outstanding Penalty">0) THEN BEGIN
        Loans."Loans Category-SASRA":=Loans."Loans Category-SASRA"::Loss;
        Loans."Loans Category":=Loans."Loans Category"::Loss;
        END;
        //MESSAGE('Here%1',Loans."Loan  No.");
        //IF (Loans."Loans Category"=Loans."Loans Category"::Substandard) OR (Loans."Loans Category"=Loans."Loans Category"::Doubtful) OR (Loans."Loans Category"=Loans."Loans Category"::Loss) THEN BEGIN
        //FnMarkMemberAsDefaulter(Loans."Loan  No.");
        
        //END;
        
        Loanss.RESET;
        Loanss.SETRANGE(Loanss."Loan  No.",Loans."Loan  No.");
        IF Loanss.FINDFIRST THEN BEGIN
        Loanss."Loans Category-SASRA":=Loans."Loans Category";
        Loanss."Loans Category":=Loans."Loans Category";
        Loanss.MODIFY;
        END;
        
        //MESSAGE('LoansCat%1SasraCat%2',Loans."Loans Category",Loanss."Loans Category-SASRA");
        //Loans.MODIFY;
        //COMMIT;
        ProgressWindow.UPDATE(1,Loans."Loan  No."+':'+Loans."Client Name");
        UNTIL Loans.NEXT=0;
        //FnUnmarkAsDefaulter();
        
        ProgressWindow.CLOSE;
        END;

    end;

    local procedure FnSendDefaultEmails()
    begin
    end;

    procedure FunctionMarkAsDefaulter(PFnumber: Code[20])
    var
        Members: Record "Members Register";
    begin
        Members.RESET;
        Members.SETRANGE(Members."Payroll No",PFnumber);
        IF Members.FINDFIRST THEN BEGIN
        Members.Defaulter:=TRUE;
        Members.MODIFY;
        END;
    end;

    procedure FnMarkMemberAsDormant()
    var
        Members: Record "Members Register";
        MemberLedgerEntry: Record "Member Ledger Entry";
        MinDate: Date;
        DormancyPeriod: DateFormula;
    begin
        GenSetup.GET();
        MinDate:=0D;

        MinDate:=CALCDATE('<-3M>',TODAY);
        Members.RESET;
        Members.SETRANGE(Members.Status,Members.Status::Active);
        IF Members.FINDFIRST THEN BEGIN
        REPEAT
        // MemberLedgerEntry.RESET;
        // MemberLedgerEntry.SETRANGE(MemberLedgerEntry."Customer No.",Members."No.");
        // MemberLedgerEntry.SETRANGE(MemberLedgerEntry."Transaction Type",MemberLedgerEntry."Transaction Type"::"Deposit Contribution");
        // IF MemberLedgerEntry.FINDLAST THEN BEGIN
        IF Members."Last Payment Date"<MinDate THEN BEGIN
        Members.Status:=Members.Status::Dormant;
        Members.MODIFY;
        END;
        UNTIL Members.NEXT=0;
        END;
    end;

    procedure FnMarkMemberAsActive()
    var
        Members: Record "Members Register";
        MemberLedgerEntry: Record "Member Ledger Entry";
        MinDate: Date;
        DormancyPeriod: DateFormula;
    begin
        GenSetup.GET();
        MinDate:=0D;
        MinDate:=CALCDATE('<-3M>',TODAY);
        Members.RESET;
        Members.SETRANGE(Members.Status,Members.Status::Dormant);
        IF Members.FINDFIRST THEN BEGIN
        REPEAT
        // MemberLedgerEntry.RESET;
        // MemberLedgerEntry.SETRANGE(MemberLedgerEntry."Customer No.",Members."No.");
        // MemberLedgerEntry.SETRANGE(MemberLedgerEntry."Transaction Type",MemberLedgerEntry."Transaction Type"::"Deposit Contribution");
        // IF MemberLedgerEntry.FINDLAST THEN BEGIN
        IF Members."Last Payment Date">=MinDate THEN BEGIN
        Members.Status:=Members.Status::Active;
        Members.MODIFY;
        END;
        UNTIL Members.NEXT=0;
        END;
    end;

    local procedure FnFindLoansWithInterest(Loans: Code[40])
    var
        LoansR: Record "Loans Register";
    begin
        LoansR.RESET;
        LoansR.SETRANGE(LoansR."Loan  No.",Loans);
        IF LoansR.FINDFIRST THEN BEGIN
        LoansR.CALCFIELDS(LoansR."Outstanding Balance",LoansR."Outstanding Interest");
        IF (LoansR."Outstanding Balance"=0) AND (LoansR."Outstanding Interest">0) THEN BEGIN
        LoansR."Loans Category-SASRA":=LoansR."Loans Category-SASRA"::Doubtful;
        LoansR."Loans Category":=LoansR."Loans Category"::Doubtful;
        LoansR.MODIFY;
        END;
        END;
    end;

    procedure FnClassifyLoansIndividual(LoanNo: Code[20]): Decimal
    begin
        Loans.RESET;
        Loans.SETRANGE(Loans.Posted,TRUE);
        Loans.SETRANGE(Loans."Loan  No.",LoanNo);
        IF Loans.FINDFIRST THEN
        BEGIN
        Loans.CALCFIELDS(Loans."Outstanding Balance");
        IF Loans."Outstanding Balance">0 THEN BEGIN
        TotalExpectedAmount:=0;
        TotalPaidAMount:=0;
        MonthlyRepayments:=0;
        NumberOfMonths:=0;
        NumberOfDays:=0;
        Arrears:=0;
        TotalInterestPaid:=0;

        RSchedule.RESET;
        RSchedule.SETRANGE(RSchedule."Loan No.",Loans."Loan  No.");
        IF NOT RSchedule.FINDFIRST THEN BEGIN
        Loans.VALIDATE(Loans."Loan Disbursement Date");
        Generate.Autogenerateschedule(Loans."Loan  No.");
        END;
        RSchedule.RESET;
        RSchedule.SETRANGE(RSchedule."Loan No.",Loans."Loan  No.");
        RSchedule.SETFILTER(RSchedule."Repayment Date",'<=%1',TODAY);
        IF RSchedule.FINDSET THEN
        BEGIN
        RSchedule.CALCSUMS(RSchedule."Monthly Repayment");
        TotalExpectedAmount:=RSchedule."Monthly Repayment";
        END;

        Loans.CALCFIELDS(Loans."Outstanding Balance",Loans."Current Interest Paid");
        TotalPaidAMount:=Loans."Approved Amount"-Loans."Outstanding Balance";
        TotalInterestPaid:=Loans."Current Interest Paid"*-1;
        TotalPaidAMount:=TotalPaidAMount+TotalInterestPaid;
        Arrears:=TotalExpectedAmount-TotalPaidAMount;
        Loans."Amount in Arrears":=Arrears;


        RSchedule.RESET;
        RSchedule.SETRANGE(RSchedule."Loan No.",Loans."Loan  No.");
        IF RSchedule.FINDFIRST THEN BEGIN
        MonthlyRepayments:=RSchedule."Monthly Repayment"
        END;
         //MESSAGE('Arrears%1Repayment%2 The%3',Arrears,MonthlyRepayments,TotalPaidAMount);
        IF MonthlyRepayments>0 THEN BEGIN
        NumberOfMonths:=ROUND((Arrears/MonthlyRepayments),1,'=');
        NumberOfDays:=NumberOfMonths*30;
        Loans."Days In Arrears":=NumberOfDays;
        // END ELSE BEGIN
        //Generate.Autogenerateschedule(Loans."Loan  No.");
        // NumberOfMonths:=ROUND((Arrears/MonthlyRepayments),1,'=');
        // NumberOfDays:=NumberOfMonths*30;
        END;
        //MESSAGE('Expected%1 Pid%2 Arrears%3NoOfdays%4 Repayment%5',TotalExpectedAmount,TotalPaidAMount,Arrears,NumberOfDays,MonthlyRepayments);
        IF Loans."Expected Date of Completion">=TODAY THEN BEGIN
        IF NumberOfDays<=30 THEN BEGIN
        Loans."Loans Category-SASRA":=Loans."Loans Category-SASRA"::Perfoming;
        Loans."Loans Category":=Loans."Loans Category"::Perfoming;
        END ELSE IF(NumberOfDays>30) AND (NumberOfDays<=60) THEN BEGIN
        Loans."Loans Category-SASRA":=Loans."Loans Category-SASRA"::Watch;
        Loans."Loans Category":=Loans."Loans Category"::Watch;
        END ELSE IF(NumberOfDays>60) AND (NumberOfDays<=180) THEN BEGIN
        Loans."Loans Category-SASRA":=Loans."Loans Category-SASRA"::Substandard;
        Loans."Loans Category":=Loans."Loans Category"::Substandard;
        END ELSE IF(NumberOfDays>180) AND (NumberOfDays<=360) THEN BEGIN
        Loans."Loans Category-SASRA":=Loans."Loans Category-SASRA"::Doubtful;
        Loans."Loans Category":=Loans."Loans Category"::Doubtful;
        END ELSE IF(NumberOfDays>360)  THEN BEGIN
        Loans."Loans Category-SASRA":=Loans."Loans Category-SASRA"::Loss;
        Loans."Loans Category":=Loans."Loans Category"::Loss;
        END;
        END ELSE BEGIN
        Loans."Loans Category-SASRA":=Loans."Loans Category-SASRA"::Loss;
        Loans."Loans Category":=Loans."Loans Category"::Loss;
        END;
        IF Loans."Loans Category"=Loans."Loans Category"::Loss THEN BEGIN
        //FunctionMarkAsDefaulter(Loans."Staff No");
        END;
        END;
        Loans.CALCFIELDS(Loans."Outstanding Interest");

        FnFindLoansWithInterest(Loans."Loan  No.");
        IF (Loans."Outstanding Balance"=0) AND (Loans."Outstanding Interest"=0) THEN BEGIN
        Loans."Loans Category-SASRA":=Loans."Loans Category-SASRA"::Perfoming;
        Loans."Loans Category":=Loans."Loans Category"::Perfoming;
        END;
        Loans.CALCFIELDS(Loans."Outstanding Penalty",Loans."Outstanding Balance");
        IF (Loans."Outstanding Balance"<0) OR (Loans."Outstanding Interest"<0) OR (Loans."Outstanding Interest"<0) THEN BEGIN
        //MESSAGE('hERE');
        Loans."Loans Category-SASRA":=Loans."Loans Category-SASRA"::Loss;
        Loans."Loans Category":=Loans."Loans Category"::Loss;

        END;

        IF (Loans."Expected Date of Completion"<TODAY) AND (Loans."Outstanding Interest">0) THEN BEGIN
        Loans."Loans Category-SASRA":=Loans."Loans Category-SASRA"::Loss;
        Loans."Loans Category":=Loans."Loans Category"::Loss;
        //MESSAGE('LoansCategory%1Cat%2',Loans."Loans Category-SASRA",Loans."Loans Category");
        END;

        IF (Loans."Outstanding Balance"<=0) AND (Loans."Outstanding Interest">0) THEN BEGIN
        Loans."Loans Category-SASRA":=Loans."Loans Category-SASRA"::Loss;
        Loans."Loans Category":=Loans."Loans Category"::Loss;
        END;

        IF (Loans."Expected Date of Completion"<TODAY) AND (Loans."Outstanding Penalty">0) THEN BEGIN
        Loans."Loans Category-SASRA":=Loans."Loans Category-SASRA"::Loss;
        Loans."Loans Category":=Loans."Loans Category"::Loss;
        END;

        Loanss.RESET;
        Loanss.SETRANGE(Loanss."Loan  No.",Loans."Loan  No.");
        IF Loanss.FINDFIRST THEN BEGIN
        Loanss."Loans Category-SASRA":=Loans."Loans Category-SASRA";
        Loanss."Loans Category":=Loans."Loans Category";
        Loanss.MODIFY;
        END;
        //Loans.MODIFY();


        //COMMIT;
        //IF (Loans."Loans Category"=Loans."Loans Category"::Substandard) OR (Loans."Loans Category"=Loans."Loans Category"::Doubtful) OR (Loans."Loans Category"=Loans."Loans Category"::Loss) THEN BEGIN
        //FnMarkMemberAsDefaulter(Loans."Loan  No.");
        //END;
        //FnUnmarkAsDefaulter(Loans."BOSA No");

        MESSAGE('Classification Done.');
        END;
    end;

    procedure FnMarkMemberAsDefaulter(ClientCode: Code[20])
    var
        Members: Record "Members Register";
        MemberLedgerEntry: Record "Member Ledger Entry";
        MinDate: Date;
        DormancyPeriod: DateFormula;
        MembersR: Record "Members Register";
        LoansX: Record "Loans Register";
    begin
        LoansX.RESET;
        LoansX.SETRANGE(LoansX."Loan  No.",ClientCode);
        IF LoansX.FINDFIRST THEN BEGIN
        LoansX.CALCFIELDS("No Of Defaulted Loans");
        IF LoansX."No Of Defaulted Loans">0 THEN BEGIN
        MembersR.RESET;
        MembersR.SETRANGE(MembersR."No.",LoansX."BOSA No");
        IF MembersR.FINDFIRST THEN
        MembersR."Loan Defaulter":=TRUE;
        MembersR."Loan Status":=MembersR."Loan Status"::Defaulter;
        MembersR.MODIFY;
        END;

        IF LoansX."No Of Defaulted Loans"=0 THEN BEGIN
        MembersR.RESET;
        MembersR.SETRANGE(MembersR."No.",Loans."BOSA No");
        IF MembersR.FINDFIRST THEN
        MembersR."Loan Status":=MembersR."Loan Status"::Performing;
        MembersR."Loan Defaulter":=FALSE;
        MembersR.MODIFY;
        END;

        END;
    end;

    procedure FnUnmarkAsDefaulter()
    var
        LoansR: Record "Loans Register";
        MembersR: Record "Members Register";
    begin

        IF MembersR.FINDFIRST THEN BEGIN
        ProgressWindow.OPEN('Classifying loans #1#######');
        REPEAT
        SLEEP(100);
        LoansR.RESET;
        LoansR.SETRANGE(LoansR."BOSA No",MembersR."No.");
        LoansR.SETRANGE(LoansR.Posted,TRUE);
        IF NOT LoansR.FINDFIRST THEN BEGIN
        MembersR."Loan Defaulter":=FALSE;
        MembersR."Loan Status":=MembersR."Loan Status"::Performing;
        MembersR.MODIFY;
        END;
        ProgressWindow.UPDATE(1,MembersR."No."+':'+MembersR.Name);
        UNTIL MembersR.NEXT=0;
        ProgressWindow.CLOSE;
        END;
    end;

    procedure FnMarkMembers()
    var
        Members: Record "Members Register";
        MemberLedgerEntry: Record "Member Ledger Entry";
        MinDate: Date;
        DormancyPeriod: DateFormula;
        MembersR: Record "Members register";
        LoansX: Record "Loans Register";
    begin
        IF MembersR.FINDFIRST THEN BEGIN
        ProgressWindow.OPEN('Mark Members #1#######');
        REPEAT
        MembersR.CALCFIELDS("No Of Defaulted Loans");
        IF MembersR."No Of Defaulted Loans">0 THEN BEGIN
        Members."Loan Defaulter":=TRUE;
        Members."Loan Status":=MembersR."Loan Status"::Defaulter;
        MembersR.MODIFY;
        END;

        IF MembersR."No Of Defaulted Loans"=0 THEN BEGIN
        MembersR."Loan Status":=MembersR."Loan Status"::Performing;
        MembersR."Loan Defaulter":=FALSE;
        MembersR.MODIFY;
        END;
        ProgressWindow.UPDATE(1,MembersR."No."+':'+MembersR.Name);
        UNTIL MembersR.NEXT=0;
        ProgressWindow.CLOSE;
        END;
    end;
}

