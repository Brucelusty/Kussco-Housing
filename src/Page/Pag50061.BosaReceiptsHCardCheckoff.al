page 50061 "Bosa Receipts H Card-Checkoff"
{
    ApplicationArea = All;
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "ReceiptsProcessing_H-Checkoff";
    SourceTableView = WHERE(Posted = CONST(false));
    // IF Posted=TRUE THEN
    // ERROR('This Check Off has already been posted');
    // 
    // 
    // IF "Account No" = '' THEN
    // ERROR('You must specify the Account No.');
    // 
    // IF "Document No" = '' THEN
    // ERROR('You must specify the Document No.');
    // 
    // 
    // IF "Posting date" = 0D THEN
    // ERROR('You must specify the Posting date.');
    // 
    // IF Amount = 0 THEN
    // ERROR('You must specify the Amount.');
    // 
    // IF "Employer Code"='' THEN
    // ERROR('You must specify Employer Code');
    // 
    // 
    // PDate:="Posting date";
    // DocNo:="Document No";
    // 
    // 
    // "Scheduled Amount":= ROUND("Scheduled Amount");
    // 
    // 
    // IF "Scheduled Amount"<>Amount THEN
    // ERROR('The Amount must be equal to the Scheduled Amount');
    // 
    // 
    // //delete journal line
    // Gnljnline.RESET;
    // Gnljnline.SETRANGE("Journal Template Name",'GENERAL');
    // Gnljnline.SETRANGE("Journal Batch Name",No);
    // Gnljnline.DELETEALL;
    // //end of deletion
    // //delete journal line
    // Gnljnline.RESET;
    // Gnljnline.SETRANGE("Journal Template Name",'GENERAL');
    // Gnljnline.SETRANGE("Journal Batch Name",No);
    // Gnljnline.INSERT;
    // //end of deletion
    // 
    // RunBal:=0;
    // 
    // IF DocNo='' THEN
    // ERROR('Kindly specify the document no.');
    // 
    // ReceiptsProcessingLines.RESET;
    // ReceiptsProcessingLines.SETRANGE(ReceiptsProcessingLines."Receipt Header No",No);
    // ReceiptsProcessingLines.SETRANGE(ReceiptsProcessingLines.Posted,FALSE);
    // IF ReceiptsProcessingLines.FIND('-') THEN BEGIN
    // REPEAT
    // 
    // 
    // ReceiptsProcessingLines.TESTFIELD(ReceiptsProcessingLines."Member No");
    // ReceiptsProcessingLines.TESTFIELD(ReceiptsProcessingLines."Trans Type");
    // {
    // IF (ReceiptsProcessingLines."Trans Type"=ReceiptsProcessingLines."Trans Type"::sLoan) OR
    // (ReceiptsProcessingLines."Trans Type"=ReceiptsProcessingLines."Trans Type"::sInterest) OR
    // (ReceiptsProcessingLines."Trans Type"=ReceiptsProcessingLines."Trans Type"::sInsurance) THEN
    // 
    // ReceiptsProcessingLines.TESTFIELD(ReceiptsProcessingLines."Loan No");
    // }
    // 
    // IF ReceiptsProcessingLines."Trans Type"=ReceiptsProcessingLines."Trans Type"::sInterest THEN BEGIN
    // 
    //     LineNo:=LineNo+500;
    //     Gnljnline.INIT;
    //     Gnljnline."Journal Template Name":='GENERAL';
    //     Gnljnline."Journal Batch Name":=No;
    //     Gnljnline."Line No.":=LineNo;
    //     Gnljnline."Account Type":=Gnljnline."Bal. Account Type"::Member;
    //     Gnljnline."Account No.":=ReceiptsProcessingLines."Member No";
    //     Gnljnline.VALIDATE(Gnljnline."Account No.");
    //     Gnljnline."Document No.":=DocNo;
    //     Gnljnline."Posting Date":=PDate;
    //     Gnljnline.Description:='Interest Paid';
    //     Gnljnline.Amount:=ROUND(-1*ReceiptsProcessingLines.Amount);
    //     Gnljnline.VALIDATE(Gnljnline.Amount);
    //     Gnljnline."Transaction Type":=Gnljnline."Transaction Type"::"Interest Paid";
    //     Gnljnline."Shortcut Dimension 1 Code":='BOSA';
    //     Gnljnline."Shortcut Dimension 2 Code":='NAIROBI';
    //     Gnljnline."Loan No":=ReceiptsProcessingLines."Loan No";
    //     IF Gnljnline.Amount<>0 THEN
    //     Gnljnline.INSERT;
    // 
    //     LineNo:=LineNo+1000;
    //     Gnljnline.INIT;
    //     Gnljnline."Journal Template Name":='GENERAL';
    //     Gnljnline."Journal Batch Name":=No;
    //     Gnljnline."Account Type":=Gnljnline."Account Type"::Customer;
    //     Gnljnline."Line No.":=LineNo;
    //     Gnljnline."Account No.":=ReceiptsProcessingLines."Employer Code";
    //     //Gnljnline.VALIDATE(Gnljnline."Account No.");
    //     Gnljnline."Document No.":=DocNo;
    //     Gnljnline."Posting Date":=PDate;
    //     Gnljnline.Description:='Interest Paid'+' '+ReceiptsProcessingLines."Loan No"+' '+ReceiptsProcessingLines."Staff/Payroll No";
    //     Gnljnline.Amount:=ROUND(ReceiptsProcessingLines.Amount);
    //     Gnljnline.VALIDATE(Gnljnline.Amount);
    //     //Gnljnline."Transaction Type":=Gnljnline."Transaction Type"::"Interest Paid";
    //     Gnljnline."Shortcut Dimension 1 Code":='BOSA';
    //     Gnljnline."Shortcut Dimension 2 Code":='NAIROBI';
    //     Gnljnline."Loan No":=ReceiptsProcessingLines."Loan No";
    //     IF Gnljnline.Amount<>0 THEN
    //     Gnljnline.INSERT;
    // 
    //     END;
    // 
    // IF ReceiptsProcessingLines."Trans Type"=ReceiptsProcessingLines."Trans Type"::sLoan THEN BEGIN
    // 
    //     LineNo:=LineNo+500;
    //     Gnljnline.INIT;
    //     Gnljnline."Journal Template Name":='GENERAL';
    //     Gnljnline."Journal Batch Name":=No;
    //     Gnljnline."Line No.":=LineNo;
    //     Gnljnline."Account Type":=Gnljnline."Account Type"::Member;
    //     Gnljnline."Account No.":=ReceiptsProcessingLines."Member No";
    //     Gnljnline.VALIDATE(Gnljnline."Account No.");
    //     //Gnljnline."Document No.":=DocNo;
    //     Gnljnline."Document No.":=DocNo;
    //     Gnljnline."Posting Date":=PDate;
    //     Gnljnline.Description:='Loan Repayment';
    //     Gnljnline.Amount:=ROUND(ReceiptsProcessingLines.Amount*-1);
    //     Gnljnline.VALIDATE(Gnljnline.Amount);
    //     Gnljnline."Transaction Type":=Gnljnline."Transaction Type"::Repayment;
    //     Gnljnline."Shortcut Dimension 1 Code":='BOSA';
    //     Gnljnline."Shortcut Dimension 2 Code":='NAIROBI';
    //     Gnljnline."Loan No":=ReceiptsProcessingLines."Loan No";
    //     IF Gnljnline.Amount<>0 THEN
    //     Gnljnline.INSERT;
    // 
    // 
    // 
    //     LineNo:=LineNo+1000;
    //     Gnljnline.INIT;
    //     Gnljnline."Journal Template Name":='GENERAL';
    //     Gnljnline."Journal Batch Name":=No;
    //     Gnljnline."Account Type":=Gnljnline."Account Type"::Customer;
    //     Gnljnline."Line No.":=LineNo;
    //     Gnljnline."Account No.":=ReceiptsProcessingLines."Employer Code";
    //     //Gnljnline.VALIDATE(Gnljnline."Account No.");
    //     //Gnljnline."Document No.":=DocNo;
    //     Gnljnline."Document No.":=DocNo;
    //     Gnljnline."Posting Date":=PDate;
    //     Gnljnline.Description:='Loan Repayment'+' '+ReceiptsProcessingLines."Loan No";
    //     Gnljnline.Amount:=ROUND(ReceiptsProcessingLines.Amount*1);
    //    // Gnljnline.VALIDATE(Gnljnline.Amount);
    //     Gnljnline."Shortcut Dimension 1 Code":='BOSA';
    //     Gnljnline."Shortcut Dimension 2 Code":='NAIROBI';
    //     Gnljnline."Loan No":=ReceiptsProcessingLines."Loan No";
    // 
    //     IF Gnljnline.Amount<>0 THEN
    //     Gnljnline.INSERT;
    // 
    //      END;
    // 
    // IF ReceiptsProcessingLines."Trans Type"=ReceiptsProcessingLines."Trans Type"::sDeposits THEN BEGIN
    // 
    // LineNo:=LineNo+500;
    // 
    // Gnljnline.INIT;
    // Gnljnline."Journal Template Name":='GENERAL';
    // Gnljnline."Journal Batch Name":=No;
    // Gnljnline."Line No.":=LineNo;
    // Gnljnline."Account Type":=Gnljnline."Account Type"::Member;
    // Gnljnline.VALIDATE(Gnljnline."Account Type");
    // Gnljnline."Account No.":=ReceiptsProcessingLines."Member No";
    // //Gnljnline.VALIDATE(Gnljnline."Account No.");
    // //Gnljnline."Document No.":=DocNo;
    // //Gnljnline."Posting Date":="ReceiptsProcessingLines"."Transaction Date";
    // Gnljnline."Document No.":=DocNo;
    // Gnljnline."Posting Date":=PDate;
    // Gnljnline.Description:='Deposit Contribution';
    // Gnljnline.Amount:=ROUND(ReceiptsProcessingLines.Amount*-1);
    // Gnljnline.VALIDATE(Gnljnline.Amount);
    // Gnljnline."Transaction Type":=Gnljnline."Transaction Type"::"Deposit Contribution";
    // Gnljnline."Shortcut Dimension 1 Code":='BOSA';
    // Gnljnline."Shortcut Dimension 2 Code":='NAIROBI';
    // //Gnljnline."Bal. Account Type":=Gnljnline."Bal. Account Type"::Customer;
    // //Gnljnline.VALIDATE(Gnljnline."Bal. Account Type");
    // //Gnljnline."Bal. Account No.":="ReceiptsProcessingLines"."Employer Code";
    // //Gnljnline.VALIDATE(Gnljnline."Bal. Account No.");
    // IF Gnljnline.Amount<>0 THEN
    // Gnljnline.INSERT;
    // 
    // LineNo:=LineNo+1000;
    // 
    // Gnljnline.INIT;
    // Gnljnline."Journal Template Name":='GENERAL';
    // Gnljnline."Journal Batch Name":=No;
    // Gnljnline."Line No.":=LineNo;
    // Gnljnline."Account Type":=Gnljnline."Account Type"::Customer;
    // Gnljnline.VALIDATE(Gnljnline."Account Type");
    // Gnljnline."Account No.":=ReceiptsProcessingLines."Employer Code";
    // //Gnljnline.VALIDATE(Gnljnline."Account No.");
    // //Gnljnline."Document No.":=DocNo;
    // //Gnljnline."Posting Date":="ReceiptsProcessingLines"."Transaction Date";
    // Gnljnline."Document No.":=DocNo;
    // Gnljnline."Posting Date":=PDate;
    // Gnljnline.Description:='Deposit Contribution'+ '-'+ReceiptsProcessingLines."Member No";
    // Gnljnline.Amount:=ROUND(ReceiptsProcessingLines.Amount*1);
    // Gnljnline.VALIDATE(Gnljnline.Amount);
    // //Gnljnline."Transaction Type":=Gnljnline."Transaction Type"::"Deposit Contribution";
    // Gnljnline."Shortcut Dimension 1 Code":='BOSA';
    // Gnljnline."Shortcut Dimension 2 Code":='NAIROBI';
    // //Gnljnline."Bal. Account Type":=Gnljnline."Bal. Account Type"::Customer;
    // //Gnljnline.VALIDATE(Gnljnline."Bal. Account Type");
    // //Gnljnline."Bal. Account No.":="ReceiptsProcessingLines"."Employer Code";
    // //Gnljnline.VALIDATE(Gnljnline."Bal. Account No.");
    // IF Gnljnline.Amount<>0 THEN
    // Gnljnline.INSERT;
    // 
    // END;
    // 
    // 
    // 
    // //Benevolent Fund
    // IF ReceiptsProcessingLines."Trans Type"=ReceiptsProcessingLines."Trans Type"::sBenevolent THEN BEGIN
    // 
    // LineNo:=LineNo+500;
    // 
    // Gnljnline.INIT;
    // Gnljnline."Journal Template Name":='GENERAL';
    // Gnljnline."Journal Batch Name":=No;
    // Gnljnline."Line No.":=LineNo;
    // Gnljnline."Account Type":=Gnljnline."Bal. Account Type"::Member;
    // Gnljnline."Account No.":=ReceiptsProcessingLines."Member No";
    // Gnljnline.VALIDATE(Gnljnline."Account No.");
    // //Gnljnline."Document No.":=DocNo;
    // //Gnljnline."Posting Date":="ReceiptsProcessingLines"."Transaction Date";
    // Gnljnline."Document No.":=DocNo;
    // Gnljnline."Posting Date":=PDate;
    // Gnljnline.Description:='Benevolent Fund';
    // Gnljnline.Amount:=ROUND(ReceiptsProcessingLines.Amount*-1);
    // Gnljnline.VALIDATE(Gnljnline.Amount);
    // Gnljnline."Transaction Type":=Gnljnline."Transaction Type"::"Benevolent Fund";
    // Gnljnline."Shortcut Dimension 1 Code":='BOSA';
    // Gnljnline."Shortcut Dimension 2 Code":='NAIROBI';
    // 
    // IF Gnljnline.Amount<>0 THEN
    // Gnljnline.INSERT;
    // 
    // 
    // LineNo:=LineNo+1000;
    // 
    // Gnljnline.INIT;
    // Gnljnline."Journal Template Name":='GENERAL';
    // Gnljnline."Journal Batch Name":=No;
    // Gnljnline."Account Type":=Gnljnline."Account Type"::Customer;
    // //Gnljnline."Account Type":=Gnljnline."Account Type"::"G/L Account";
    // Gnljnline."Line No.":=LineNo;
    // Gnljnline."Account No.":=ReceiptsProcessingLines."Employer Code";
    // //Gnljnline.VALIDATE(Gnljnline."Account No.");
    // //Gnljnline."Document No.":=DocNo;
    // //Gnljnline."Posting Date":="ReceiptsProcessingLines"."Transaction Date";
    // Gnljnline."Document No.":=DocNo;
    // Gnljnline."Posting Date":=PDate;
    // Gnljnline.Description:='Benevolent Fund'+ReceiptsProcessingLines."Member No";
    // Gnljnline.Amount:=ROUND(ReceiptsProcessingLines.Amount*1);
    // //Gnljnline.VALIDATE(Gnljnline.Amount);
    // //Gnljnline."Transaction Type":=Gnljnline."Transaction Type"::"Benevolent Fund";
    // Gnljnline."Shortcut Dimension 1 Code":='BOSA';
    // Gnljnline."Shortcut Dimension 2 Code":='NAIROBI';
    // 
    // IF Gnljnline.Amount<>0 THEN
    // Gnljnline.INSERT;
    // 
    // END;
    // 
    // //Loan Insurance
    // IF ReceiptsProcessingLines."Trans Type"=ReceiptsProcessingLines."Trans Type"::sInsurance THEN BEGIN
    // 
    // LineNo:=LineNo+500;
    // 
    // Gnljnline.INIT;
    // Gnljnline."Journal Template Name":='GENERAL';
    // Gnljnline."Journal Batch Name":=No;
    // Gnljnline."Line No.":=LineNo;
    // Gnljnline."Account Type":=Gnljnline."Bal. Account Type"::Member;
    // Gnljnline."Account No.":=ReceiptsProcessingLines."Member No";
    // Gnljnline.VALIDATE(Gnljnline."Account No.");
    // //Gnljnline."Posting Date":="ReceiptsProcessingLines"."Transaction Date";
    // Gnljnline."Document No.":=DocNo;
    // Gnljnline."Posting Date":=PDate;
    // Gnljnline.Description:='Loan Insurance 0.02%'+' '+ReceiptsProcessingLines."Loan No";
    // Gnljnline.Amount:=ROUND(ReceiptsProcessingLines.Amount*-1);
    // Gnljnline.VALIDATE(Gnljnline.Amount);
    // Gnljnline."Transaction Type":=Gnljnline."Transaction Type"::"Insurance Contribution";
    // Gnljnline."Shortcut Dimension 1 Code":='BOSA';
    // Gnljnline."Shortcut Dimension 2 Code":='NAIROBI';
    // 
    // IF Gnljnline.Amount<>0 THEN
    // Gnljnline.INSERT;
    // 
    // 
    // LineNo:=LineNo+1000;
    // 
    // Gnljnline.INIT;
    // Gnljnline."Journal Template Name":='GENERAL';
    // Gnljnline."Journal Batch Name":=No;
    // Gnljnline."Line No.":=LineNo;
    // Gnljnline."Account Type":=Gnljnline."Account Type"::Customer;
    // Gnljnline."Account No.":=ReceiptsProcessingLines."Employer Code";
    // Gnljnline.VALIDATE(Gnljnline."Account No.");
    // //Gnljnline."Posting Date":="ReceiptsProcessingLines"."Transaction Date";
    // Gnljnline."Document No.":=DocNo;
    // Gnljnline."Posting Date":=PDate;
    // Gnljnline.Description:='Loan Insurance 0.02%'+' '+ReceiptsProcessingLines."Loan No";
    // Gnljnline.Amount:=ROUND(ReceiptsProcessingLines.Amount*1);
    // Gnljnline.VALIDATE(Gnljnline.Amount);
    // //Gnljnline."Transaction Type":=Gnljnline."Transaction Type"::"Insurance Contribution";
    // Gnljnline."Shortcut Dimension 1 Code":='BOSA';
    // Gnljnline."Shortcut Dimension 2 Code":='NAIROBI';
    // 
    // IF Gnljnline.Amount<>0 THEN
    // Gnljnline.INSERT;
    // 
    // END;
    // 
    // 
    // //Share Capital
    // IF ReceiptsProcessingLines."Trans Type"=ReceiptsProcessingLines."Trans Type"::sShare THEN BEGIN
    // 
    // LineNo:=LineNo+500;
    // 
    // Gnljnline.INIT;
    // Gnljnline."Journal Template Name":='GENERAL';
    // Gnljnline."Journal Batch Name":=No;
    // Gnljnline."Line No.":=LineNo;
    // Gnljnline."Account Type":=Gnljnline."Bal. Account Type"::Member;
    // Gnljnline."Account No.":=ReceiptsProcessingLines."Member No";
    // Gnljnline.VALIDATE(Gnljnline."Account No.");
    // Gnljnline."Document No.":=DocNo;
    // Gnljnline."Posting Date":=PDate;
    // //Gnljnline."Posting Date":=ReceiptsProcessingLines."Transaction Date";
    // Gnljnline.Description:='Shares Contribution';
    // Gnljnline.Amount:=ReceiptsProcessingLines.Amount*-1;
    // Gnljnline.VALIDATE(Gnljnline.Amount);
    // Gnljnline."Transaction Type":=Gnljnline."Transaction Type"::"Shares Capital";
    // Gnljnline."Shortcut Dimension 1 Code":='BOSA';
    // Gnljnline."Shortcut Dimension 2 Code":='NAIROBI';
    // 
    // IF Gnljnline.Amount<>0 THEN
    // Gnljnline.INSERT;
    // 
    // LineNo:=LineNo+1000;
    // 
    // Gnljnline.INIT;
    // Gnljnline."Journal Template Name":='GENERAL';
    // Gnljnline."Journal Batch Name":=No;
    // Gnljnline."Line No.":=LineNo;
    // Gnljnline."Account Type":=Gnljnline."Account Type"::Customer;
    // Gnljnline."Account No.":=ReceiptsProcessingLines."Employer Code";
    // Gnljnline.VALIDATE(Gnljnline."Account No.");
    // Gnljnline."Posting Date":=ReceiptsProcessingLines."Transaction Date";
    // Gnljnline."Document No.":=DocNo;
    // Gnljnline."Posting Date":=PDate;
    // Gnljnline.Description:='Shares Contribution'+' '+ReceiptsProcessingLines."Staff/Payroll No";
    // Gnljnline.Amount:=ROUND(ReceiptsProcessingLines.Amount*1);
    // Gnljnline.VALIDATE(Gnljnline.Amount);
    // //Gnljnline."Transaction Type":=Gnljnline."Transaction Type"::"Insurance Contribution";
    // Gnljnline."Shortcut Dimension 1 Code":='BOSA';
    // Gnljnline."Shortcut Dimension 2 Code":='NAIROBI';
    // 
    // IF Gnljnline.Amount<>0 THEN
    // Gnljnline.INSERT;
    // 
    // END;
    //  {
    // //UAP
    // IF ReceiptsProcessingLines."Trans Type"=ReceiptsProcessingLines."Trans Type"::"9" THEN BEGIN
    // 
    // LineNo:=LineNo+1000;
    // 
    // Gnljnline.INIT;
    // Gnljnline."Journal Template Name":='GENERAL';
    // Gnljnline."Journal Batch Name":=No;
    // Gnljnline."Line No.":=LineNo;
    // Gnljnline."Account Type":=Gnljnline."Bal. Account Type"::Member;
    // Gnljnline."Account No.":=ReceiptsProcessingLines."Member No";
    // Gnljnline.VALIDATE(Gnljnline."Account No.");
    // Gnljnline."Document No.":=DocNo;
    // Gnljnline."Posting Date":=PDate;
    // //Gnljnline."Posting Date":="ReceiptsProcessingLines"."Transaction Date";
    // Gnljnline.Description:='UAP Premium';
    // Gnljnline.Amount:=ReceiptsProcessingLines.Amount*-1;
    // Gnljnline.VALIDATE(Gnljnline.Amount);
    // //Gnljnline."Transaction Type":=Gnljnline."Transaction Type"::"UAP Premiums";
    // Gnljnline."Shortcut Dimension 1 Code":='BOSA';
    // Gnljnline."Shortcut Dimension 2 Code":='NAIROBI';
    // 
    // IF Gnljnline.Amount<>0 THEN
    // Gnljnline.INSERT;
    // 
    // END;
    // 
    // 
    // 
    // IF ReceiptsProcessingLines."Trans Type"=ReceiptsProcessingLines."Trans Type"::sInsurance THEN BEGIN
    // 
    // LineNo:=LineNo+1000;
    // 
    // Gnljnline.INIT;
    // Gnljnline."Journal Template Name":='GENERAL';
    // Gnljnline."Journal Batch Name":=No;
    // Gnljnline."Line No.":=LineNo;
    // Gnljnline."Account Type":=Gnljnline."Bal. Account Type"::Member;
    // Gnljnline."Account No.":=ReceiptsProcessingLines."Member No";
    // Gnljnline.VALIDATE(Gnljnline."Account No.");
    // //Gnljnline."Document No.":=DocNo;
    // //Gnljnline."Posting Date":="ReceiptsProcessingLines"."Transaction Date";
    // Gnljnline."Document No.":=DocNo;
    // Gnljnline."Posting Date":=PDate;
    // Gnljnline.Description:='Administration fee paid';
    // Gnljnline.Amount:=ROUND(ReceiptsProcessingLines.Amount*-1);
    // Gnljnline.VALIDATE(Gnljnline.Amount);
    // //Gnljnline."Transaction Type":=Gnljnline."Transaction Type"::"Administration Fee Paid";
    // Gnljnline."Shortcut Dimension 1 Code":='BOSA';
    // Gnljnline."Shortcut Dimension 2 Code":='NAIROBI';
    // Gnljnline."Loan No":=ReceiptsProcessingLines."Loan No";
    // IF Gnljnline.Amount<>0 THEN
    // Gnljnline.INSERT;
    // 
    // END;
    // }
    // UNTIL ReceiptsProcessingLines.NEXT=0;
    // END;
    //  {
    // //Bank Entry
    // 
    // //BOSA Bank Entry
    // //IF ("Mode Of Disbursement"="Mode Of Disbursement"::Cheque) THEN BEGIN
    // IF(LBatches."Mode Of Disbursement"=LBatches."Mode Of Disbursement"::Cheque) THEN BEGIN
    //      //("Mode Of Disbursement"="Mode Of Disbursement"::"Transfer to FOSA") THEN BEGIN
    // LineNo:=LineNo+10000;
    // 
    // Gnljnline.INIT;
    // Gnljnline."Journal Template Name":=Jtemplate;
    // Gnljnline."Journal Batch Name":=JBatch;
    // Gnljnline."Line No.":=LineNo;
    // Gnljnline."Document No.":=DocNo;;
    // Gnljnline."Posting Date":="Posting date";
    // Gnljnline."External Document No.":=LBatches."Document No.";
    // Gnljnline."Account Type":=Gnljnline."Bal. Account Type"::"Bank Account";
    // Gnljnline."Account No.":=LBatches."BOSA Bank Account";
    // Gnljnline.VALIDATE(Gnljnline."Account No.");
    // Gnljnline.Description:=ReceiptsProcessingLines.Name;
    // Gnljnline.Amount:=ReceiptsProcessingLines.Amount*-1;
    // Gnljnline.VALIDATE(Gnljnline.Amount);
    // Gnljnline."Shortcut Dimension 1 Code":=DActivityBOSA;
    // Gnljnline."Shortcut Dimension 2 Code":=DBranchBOSA;
    // Gnljnline.VALIDATE(Gnljnline."Shortcut Dimension 1 Code");
    // Gnljnline.VALIDATE(Gnljnline."Shortcut Dimension 2 Code");
    // IF Gnljnline.Amount<>0 THEN
    // Gnljnline.INSERT;
    // 
    // END;
    // }
    // {
    // LineN:=LineN+100;
    // 
    // Gnljnline.INIT;
    // Gnljnline."Journal Template Name":='GENERAL';
    // Gnljnline."Journal Batch Name":=No;
    // Gnljnline."Document No.":=DocNo;
    // Gnljnline."External Document No.":=DocNo;
    // Gnljnline."Line No.":=LineN;
    // Gnljnline."Account Type":="Account Type";
    // Gnljnline."Account No.":="Account No";
    // Gnljnline.VALIDATE(Gnljnline."Account No.");
    // Gnljnline."Posting Date":=PDate;
    // Gnljnline.Description:='Check Off transfer';
    // Gnljnline.Amount:=Amount;
    // Gnljnline.VALIDATE(Gnljnline.Amount);
    // Gnljnline.VALIDATE(Gnljnline."Bal. Account No.");
    // Gnljnline."Shortcut Dimension 1 Code":='BOSA';
    // Gnljnline."Shortcut Dimension 2 Code":='NAIROBI';
    // IF Gnljnline.Amount<>0 THEN
    // Gnljnline.INSERT;
    // }
    // 
    // //Post New
    // Gnljnline.RESET;
    // Gnljnline.SETRANGE("Journal Template Name",'GENERAL');
    // Gnljnline.SETRANGE("Journal Batch Name",No);
    // IF Gnljnline.FIND('-') THEN BEGIN
    // //CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post B",Gnljnline);
    // END;
    // 
    // //Post New
    // Posted:=TRUE;
    // "Posted By":= UPPERCASE(No);
    // MODIFY;
    // 
    // {
    // "ReceiptsProcessingLines".RESET;
    // "ReceiptsProcessingLines".SETRANGE("ReceiptsProcessingLines"."Receipt Header No",No);
    //  IF "ReceiptsProcessingLines".FIND('-') THEN BEGIN
    //  REPEAT
    // "ReceiptsProcessingLines".Posted:=TRUE;
    // "ReceiptsProcessingLines".MODIFY;
    // UNTIL "ReceiptsProcessingLines".NEXT=0;
    // END;
    // MODIFY;
    // }



    layout
    {
        area(content)
        {
            group(General)
            {
                field(Nos; Rec.No)
                {
                    Editable = false;
                }
                field("Entered By"; Rec."Entered By")
                {
                    Enabled = false;
                }
                field("Date Entered"; Rec."Date Entered")
                {
                    Editable = false;
                }
                field("Posting date"; Rec."Posting date")
                {
                    Editable = true;
                }
                field("Loan CutOff Date"; Rec."Loan CutOff Date")
                {
                }
                field(Remarks; Rec.Remarks)
                {
                }
                field("Total Count"; Rec."Total Count")
                {
                }
                field("Posted By"; Rec."Posted By")
                {
                }
                field("Account Type"; Rec."Account Type")
                {
                }
                field("Account No"; Rec."Account No")
                {
                }
                field("Employer Code"; Rec."Employer Code")
                {
                }
                field("Document No"; Rec."Document No")
                {
                }
                field(Posted; Rec.Posted)
                {
                    Editable = true;
                }
                field(Amount; Rec.Amount)
                {
                }
                field("Scheduled Amount"; Rec."Scheduled Amount")
                {
                }
            }
            part("Bosa receipt lines"; "Bosa Receipt line-Checkoffs")
            {
                SubPageLink = "Receipt Header No" = FIELD(No);
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("<XMLport Import receipts>")
            {
                Caption = 'Import Receipts';
                Image = Import;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = XMLport "Import Checkoff Block";
            }
            action("Validate Receipts")
            {
                Caption = 'Validate Receipts';
                Image = ValidateEmailLoggingSetup;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    RcptBufLines.RESET;
                    RcptBufLines.SETRANGE(RcptBufLines."Receipt Header No", Rec.No);
                    IF RcptBufLines.FIND('-') THEN BEGIN
                        REPEAT
                            //MESSAGE('Message%1Payroll%2',RcptBufLines."Receipt Header No",RcptBufLines."Staff/Payroll No");
                            Memb.RESET;
                            Memb.SETRANGE(Memb."Payroll No", RcptBufLines."Staff/Payroll No");
                            IF Memb.FIND('-') THEN BEGIN
                                RcptBufLines."Member No" := Memb."No.";
                                RcptBufLines.Name := Memb.Name;
                                RcptBufLines."ID No." := Memb."ID No.";
                                //RcptBufLines."Trans Type":=RcptBufLines."Trans Type"::sLoan;
                                RcptBufLines."Member Found" := TRUE;
                                RcptBufLines.MODIFY;
                            END;
                        UNTIL RcptBufLines.NEXT = 0;
                    END;
                    MESSAGE('Successfull validated');
                end;
            }
            action("Post Block Checkoff")
            {
                Image = PostOrder;
                Promoted = true;
                PromotedCategory = Category9;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    RSchedule: Record "Loan Repayment Schedule";
                    Prod: Record "Loan Products Setup";
                    ExpectedPrincipalRepayment: Decimal;
                    ExpectedTotalRepayment: Decimal;
                begin
                    IF CONFIRM('Are You Sure You Want To Create Journal Lines?', TRUE, FALSE) = TRUE THEN BEGIN

                        Rec.TESTFIELD("Posting date");
                        Rec.TESTFIELD("Loan CutOff Date");

                        JournalBatchName := 'CHECKOFF';
                        //Delete journal
                        Gnljnline.RESET;
                        Gnljnline.SETRANGE("Journal Template Name", 'GENERAL');
                        Gnljnline.SETRANGE("Journal Batch Name", JournalBatchName);
                        IF Gnljnline.FIND('-') THEN
                            Gnljnline.DELETEALL;

                        //CheckoffMessages.DELETEALL;
                        SerialNo := 0;
                        RcptBufLines.RESET;
                        RcptBufLines.SETRANGE(RcptBufLines."Receipt Header No", Rec.No);
                        RcptBufLines.SETFILTER(RcptBufLines."Member Found", '%1', TRUE);
                        IF RcptBufLines.FIND('-') THEN BEGIN
                            WindowDialoag.OPEN('Processing Checkoff For Member No. #1#######');
                            REPEAT
                                SLEEP(1000);
                                WindowDialoag.UPDATE(1, RcptBufLines."Member No" + ':' + RcptBufLines.Name);
                                RunningBalance := 0;
                                RunningBalance := RcptBufLines.Amount;

                                IF RunningBalance > 0 THEN
                                    MessageC := '';
                                //Deduct Benovelent Fund
                                Members.RESET;
                                Members.SETRANGE(Members."No.", RcptBufLines."Member No");
                                IF Members.FINDFIRST THEN BEGIN

                                    IF Members."Pays Benevolent" = TRUE THEN BEGIN
                                        Benevolent := 0;
                                        IF RunningBalance >= 300 THEN
                                            Benevolent := 300
                                        ELSE
                                            Benevolent := RunningBalance;

                                        LineN := LineN + 10000;
                                        Sfactory.FnCreateGnlJournalLines('GENERAL', JournalBatchName, Rec."Document No", LineN, TransactionTypes::"Benevolent Fund", AccountTypes::Member, RcptBufLines."Member No", Rec."Posting date", -Benevolent,
                                        'BOSA', 'Benevolent Contribution', '');

                                        //                 IF CheckoffMessages.FINDLAST THEN
                                        //                SerialNo:=SerialNo+CheckoffMessages.No
                                        //                 ELSE
                                        //                 SerialNo:=1;
                                        //
                                        //                  CheckoffMessages.INIT;
                                        //                  CheckoffMessages.No:=SerialNo;
                                        //                  CheckoffMessages."Client Code":=RcptBufLines."Member No";
                                        //                  CheckoffMessages.Message:='Benevolent Contribution Ksh:'+FORMAT(Benevolent);
                                        //MessageC:='Benevolent Contribution Ksh:'+FORMAT(Benevolent);
                                        //CheckoffMessages.INSERT;
                                        /*LineN:=LineN+10000;
                                        Sfactory.FnCreateGnlJournalLine('GENERAL',JournalBatchName,"Document No",LineN,TransactionTypes::"Benevolent Fund","Account Type","Account No","Posting date",Benevolent,
                                        'BOSA','Benevolent Contribution','');*/
                                        RunningBalance := RunningBalance - Benevolent;

                                    END;
                                    //End Deduct Benovelent Fund


                                    IF RunningBalance > 0 THEN
                                        //Deduct Monthly Cntribution
                                        IF Members."Monthly Contribution" > 0 THEN BEGIN
                                            MonthlyContrib := 0;
                                            IF RunningBalance >= Members."Monthly Contribution" THEN
                                                MonthlyContrib := Members."Monthly Contribution"
                                            ELSE
                                                MonthlyContrib := RunningBalance;
                                            LineN := LineN + 10000;
                                            Sfactory.FnCreateGnlJournalLines('GENERAL', JournalBatchName, Rec."Document No", LineN, TransactionTypes::"Deposit Contribution", AccountTypes::Member, RcptBufLines."Member No", Rec."Posting date", -MonthlyContrib,
                                            'BOSA', 'Shares Contribution', '');


                                            //                   IF CheckoffMessages.FINDLAST THEN
                                            //                   SerialNo:=SerialNo+CheckoffMessages.No
                                            //                   ELSE
                                            //                   SerialNo:=1;
                                            //
                                            //                  CheckoffMessages.INIT;
                                            //                  CheckoffMessages.No:=SerialNo;
                                            //                  CheckoffMessages."Client Code":=RcptBufLines."Member No";
                                            //                  CheckoffMessages.Message:='Deposit Contribution Ksh:'+FORMAT(MonthlyContrib);
                                            MessageC := MessageC + ' ' + 'Deposit Contribution Ksh:' + FORMAT(MonthlyContrib);
                                            //                CheckoffMessages.INSERT;
                                            /*LineN:=LineN+10000;
                                            Sfactory.FnCreateGnlJournalLine('GENERAL',JournalBatchName,"Document No",LineN,TransactionTypes::"Deposit Contribution","Account Type","Account No","Posting date",MonthlyContrib,
                                            'BOSA','Shares Contribution','');*/
                                            RunningBalance := RunningBalance - MonthlyContrib;
                                            //End Monthly Contribution
                                        END;
                                END;

                                IF RunningBalance > 0 THEN BEGIN
                                    //Ess Deposits
                                    //Deduct Benovelent Fund
                                    Membersx.RESET;
                                    Membersx.SETRANGE(Membersx."No.", RcptBufLines."Member No");
                                    IF Membersx.FINDFIRST THEN BEGIN
                                        IF Membersx."Monthly Sch.Fees Cont." > 0 THEN BEGIN
                                            Ess := 0;
                                            IF RunningBalance >= Membersx."Monthly Sch.Fees Cont." THEN
                                                Ess := Membersx."Monthly Sch.Fees Cont."
                                            ELSE
                                                Ess := RunningBalance;

                                            LineN := LineN + 10000;
                                            Sfactory.FnCreateGnlJournalLines('GENERAL', JournalBatchName, Rec."Document No", LineN, TransactionTypes::"Deposit Contribution", AccountTypes::Vendor, RcptBufLines."Member No", Rec."Posting date", -Ess,
                                            'BOSA', 'Ess Contribution', '');
                                            //                    IF CheckoffMessages.FINDLAST THEN
                                            //                   SerialNo:=SerialNo+CheckoffMessages.No
                                            //                   ELSE
                                            //                   SerialNo:=1;
                                            //
                                            //                  CheckoffMessages.INIT;
                                            //                  CheckoffMessages.No:=SerialNo;
                                            //                  CheckoffMessages."Client Code":=RcptBufLines."Member No";
                                            //                  CheckoffMessages.Message:='Ess Contribution Ksh:'+FORMAT(Ess);
                                            MessageC := MessageC + ' ' + 'Ess Contribution Ksh:' + FORMAT(Ess);
                                            //                 CheckoffMessages.INSERT;
                                            /*LineN:=LineN+10000;
                                            Sfactory.FnCreateGnlJournalLine('GENERAL',JournalBatchName,"Document No",LineN,TransactionTypes::"SchFee Shares","Account Type","Account No","Posting date",Ess,
                                            'BOSA','Ess Contribution','');*/
                                            RunningBalance := RunningBalance - Ess;

                                        END;
                                    END;

                                END;

                                //Begin Loans
                                LoansR.RESET;
                                LoansR.SETRANGE(LoansR."Client Code", RcptBufLines."Member No");
                                LoansR.SETFILTER(LoansR.Posted, '%1', TRUE);
                                LoansR.SETFILTER("Outstanding Balance", '>0');
                                LoansR.SETRANGE(LoansR."Recovery Mode", LoansR."Recovery Mode"::Checkoff);
                                LoansR.SETRANGE(LoansR."Issued Date", 0D, Rec."Loan CutOff Date");
                                LoansR.SETRANGE(LoansR."Date filter", 0D, Rec."Posting date");
                                LoansR.SETAUTOCALCFIELDS("Outstanding Balance", "Outstanding Interest");
                                IF LoansR.FINDSET THEN BEGIN
                                    REPEAT

                                        // LoansR.CALCFIELDS(LoansR."Outstanding Balance",LoansR."Oustanding Interest");
                                        IF LoansR."Outstanding Interest" <> LoansR.InterestBalanceAsAt(Rec."Posting date") THEN
                                            LoansR."Outstanding Interest" := LoansR.InterestBalanceAsAt(Rec."Posting date");

                                        InterestBal := 0;
                                        //Interest Payment
                                        IF LoansR."Outstanding Interest" > 0 THEN BEGIN

                                            IF RunningBalance >= LoansR."Outstanding Interest" THEN
                                                InterestBal := LoansR."Outstanding Interest"
                                            ELSE
                                                InterestBal := RunningBalance;
                                            //MESSAGE('RunningBalInt%1Dedi%2LoanInt%3',RunningBalance,InterestBal,LoansR."Oustanding Interest");
                                            LineN := LineN + 10000;
                                            Sfactory.FnCreateGnlJournalLines('GENERAL', JournalBatchName, Rec."Document No", LineN, TransactionTypes::"Interest Paid", AccountTypes::Member, RcptBufLines."Member No", Rec."Posting date", -InterestBal,
                                            'BOSA', 'Interest Paid', LoansR."Loan  No.");

                                            /* LineN:=LineN+10000;
                                             Sfactory.FnCreateGnlJournalLine('GENERAL',JournalBatchName,"Document No",LineN,TransactionTypes::" ","Account Type","Account No","Posting date",InterestBal,
                                             'BOSA','Interest Paid','');*/
                                            IF InterestBal > 0 THEN BEGIN
                                                //                        IF CheckoffMessages.FINDLAST THEN
                                                //                       SerialNo:=SerialNo+CheckoffMessages.No
                                                //                        ELSE
                                                //                       SerialNo:=1;
                                                //
                                                //                      CheckoffMessages.INIT;
                                                //                      CheckoffMessages.No:=SerialNo;
                                                //                      CheckoffMessages."Client Code":=RcptBufLines."Member No";
                                                //                      CheckoffMessages.Message:='Interest Repayment Ksh:'+LoansR."Loan Product Type Name"+FORMAT(InterestBal);
                                                MessageC := MessageC + ' ' + 'Interest Repayment ' + LoansR."Loan Product Type Name" + ' Ksh:' + FORMAT(InterestBal);
                                                //                     CheckoffMessages.INSERT;
                                                RunningBalance := RunningBalance - InterestBal;
                                            END;
                                        END;
                                        //End Interest Payment

                                        //Loan Payment
                                        IF LoansR."Outstanding Balance" > 0 THEN BEGIN
                                            IF Prod.GET(LoansR."Loan Product Type") THEN
                                                IF Prod."Interest rate" <> 0 THEN
                                                    Sfactory.FnGenerateLoanSchedule(LoansR."Loan  No.");
                                            FnGetLoanArrears(LoansR."Loan  No.");
                                            LoanBal := 0;

                                            ExpectedTotalRepayment := LoansR.GetLoanExpectedRepayment(0, Rec."Posting date");
                                            ExpectedPrincipalRepayment := ExpectedTotalRepayment - InterestBal;
                                            IF ExpectedPrincipalRepayment < 0 THEN ExpectedPrincipalRepayment := 0;

                                            IF Arrear < ExpectedPrincipalRepayment THEN
                                                Arrear := ExpectedPrincipalRepayment;

                                            IF RunningBalance >= Arrear THEN
                                                LoanBal := Arrear
                                            ELSE
                                                LoanBal := RunningBalance;
                                            //MESSAGE('Loans%1Arrear%2Loanbal%3Outbal%4',LoansR."Loan  No.",Arrear,LoanBal);

                                            IF LoanBal > LoansR."Outstanding Balance" THEN
                                                LoanBal := LoansR."Outstanding Balance";//TransactionTypes::"Deposit Contribution",

                                            LineN := LineN + 10000;
                                            //Sfactory.FnCreateGnlJournalLines('GENERAL', JournalBatchName, Rec, Rec."Document No", LineN, TransactionTypes::"Repayment", AccountTypes::Member, RcptBufLines."Member No", Rec."Posting date", -LoanBal,
                                            //'BOSA', 'Loan Repayment', LoansR."Loan  No.");
                                            Sfactory.FnCreateGnlJournalLines('GENERAL', JournalBatchName, Rec."Document No", LineN, TransactionTypes::"Repayment", AccountTypes::Member, RcptBufLines."Member No", Rec."Posting date", -LoanBal,
                                               'BOSA', 'Loan Repayment', LoansR."Loan  No.");




                                            IF LoanBal > 0 THEN BEGIN
                                                //                            IF CheckoffMessages.FINDLAST THEN
                                                //                            SerialNo:=SerialNo+CheckoffMessages.No
                                                //                            ELSE
                                                //                           SerialNo:=1;
                                                //
                                                //                           CheckoffMessages.INIT;
                                                //                           CheckoffMessages.No:=SerialNo;
                                                //                           CheckoffMessages."Client Code":=RcptBufLines."Member No";
                                                //                         CheckoffMessages.Message:='Loan Repayment Ksh:'+LoansR."Loan Product Type Name"+FORMAT(LoanBal);
                                                MessageC := MessageC + ' ' + 'Loan Repayment ' + LoansR."Loan Product Type Name" + ' Ksh:' + FORMAT(LoanBal);
                                                //                         CheckoffMessages.INSERT;
                                            END;

                                            RunningBalance := RunningBalance - LoanBal;

                                        END;

                                    //End Loan Payment
                                    UNTIL LoansR.NEXT = 0;


                                END;


                                SerialNo := SerialNo + 1;


                                /*                                      CheckoffMessages.INIT;
                                                                     CheckoffMessages.No:=SerialNo;
                                                                     CheckoffMessages."Client Code":=RcptBufLines."Member No";
                                                                     MessageC:=PADSTR(MessageC,200);
                                                                     //Len1:=STRLEN(MessageC);
                                                                     CheckoffMessages.Message:=MessageC;
                                                                     //MESSAGE('Length%1',Len1);
                                                                    // MessageC:=MessageC+' '+'Ess Contribution Ksh:'+FORMAT(Ess);
                                                                     CheckoffMessages.INSERT; */


                                //End Deduct Benovelent Fund



                                //End ESS Deposits

                                //Balance to deposits
                                IF RunningBalance > 0 THEN BEGIN
                                    LineN := LineN + 10000;
                                    Sfactory.FnCreateGnlJournalLines('GENERAL', JournalBatchName, Rec."Document No", LineN, TransactionTypes::"Deposit Contribution", AccountTypes::Member, RcptBufLines."Member No", Rec."Posting date", -RunningBalance,
                                    'BOSA', 'Shares Contribution : Excess', '');

                                    /*LineN:=LineN+10000;
                                    Sfactory.FnCreateGnlJournalLine('GENERAL',JournalBatchName,"Document No",LineN,TransactionTypes::"Deposit Contribution","Account Type","Account No","Posting date",RunningBalance,
                                    'BOSA','Shares Contribution','');*/
                                END;
                                Membersx.RESET;
                                Membersx.SETRANGE(Membersx."No.", RcptBufLines."Member No");
                                IF Membersx.FINDFIRST THEN BEGIN
                                    Membersx."Checkoff Member" := TRUE;
                                    Membersx."Last Checkoff Date" := Rec."Posting date";
                                    Membersx."Last Checkoff Amount" := MonthlyContrib;
                                    Membersx.MODIFY;
                                END;
                            UNTIL RcptBufLines.NEXT = 0;
                            Rec.CALCFIELDS("Scheduled Amount");
                            LineN := LineN + 10000;
                            Sfactory.FnCreateGnlJournalLines('GENERAL', JournalBatchName, Rec."Document No", LineN, TransactionTypes::"Deposit Contribution", Rec."Account Type", Rec."Account No", Rec."Posting date", Rec."Scheduled Amount",
                            'BOSA', 'Balancing account', '');
                            WindowDialoag.CLOSE;
                        END;
                    END;

                end;
            }

            action("Post check off Deposits")
            {
                Caption = 'Post Deposits/ESS';
                Image = Post;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = false;

                trigger OnAction()
                begin
                    /*
                    genstup.GET();
                    IF Posted=TRUE THEN
                    ERROR('This Check Off has already been posted');
                    IF "Account No" = '' THEN
                    ERROR('You must specify the Account No.');
                    IF "Document No" = '' THEN
                    ERROR('You must specify the Document No.');
                    IF "Posting date" = 0D THEN
                    ERROR('You must specify the Posting date.');
                    IF "Posting date" = 0D THEN
                    ERROR('You must specify the Posting date.');
                    {IF "Loan CutOff Date" = 0D THEN
                    ERROR('You must specify the Loan CutOff Date.');
                    Datefilter:='..'+FORMAT("Loan CutOff Date");
                    IssueDate:="Loan CutOff Date";
                    startDate:=010100D;}
                    
                    //Delete journal
                    Gnljnline.RESET;
                    Gnljnline.SETRANGE("Journal Template Name",'GENERAL');
                    Gnljnline.SETRANGE("Journal Batch Name",JournalBatchName);
                    IF Gnljnline.FIND('-') THEN
                    Gnljnline.DELETEALL;
                    
                    RunBal:=0;
                    TotalWelfareAmount:=0;
                    CALCFIELDS("Scheduled Amount");
                    IF "Scheduled Amount" <>   Amount THEN BEGIN
                    ERROR('Scheduled Amount Is Not Equal To Cheque Amount');
                    END;
                    
                    RcptBufLines.RESET;
                    RcptBufLines.SETRANGE(RcptBufLines."Receipt Header No",No);
                    RcptBufLines.SETRANGE(RcptBufLines.Posted,FALSE);
                    IF RcptBufLines.FIND('-') THEN BEGIN
                    
                      REPEAT
                        RunBal:=0;
                        RunBal:=RcptBufLines.Amount;
                        {RunBal:=FnRunInterest(RcptBufLines,RunBal);
                        RunBal:=FnRecoverWelfare(RcptBufLines,RunBal);
                        RunBal:=FnRunPrinciple(RcptBufLines,RunBal);
                        RunBal:=FnRunEntranceFee(RcptBufLines,RunBal);
                        RunBal:=FnRunShareCapital(RcptBufLines,RunBal); }
                        RunBal:=FnRunDepositContribution(RcptBufLines,RunBal);
                        {RunBal:=FnRunXmasContribution(RcptBufLines,RunBal);
                        RunBal:=FnRecoverPrincipleFromExcess(RcptBufLines,RunBal);}
                        FnTransferExcessToUnallocatedFunds(RcptBufLines,RunBal);
                      UNTIL RcptBufLines.NEXT=0;
                    END;
                    {
                    //CREDIT WELFARE VENDOR ACCOUNT
                    LineN:=LineN+10000;
                    Gnljnline.INIT;
                    Gnljnline."Journal Template Name":='GENERAL';
                    Gnljnline."Journal Batch Name":=JournalBatchName;
                    Gnljnline."Line No.":=LineN;
                    Gnljnline."Account Type":=Gnljnline."Account Type"::Vendor;
                    Gnljnline."Account No.":='L25001000001';  //Insert Welfare Control account here
                    Gnljnline.VALIDATE(Gnljnline."Account No.");
                    Gnljnline."Document No.":="Document No";
                    Gnljnline."Posting Date":="Posting date";
                    Gnljnline.Description:='Welfare Contributions';
                    Gnljnline.Amount:=TotalWelfareAmount*-1;
                    Gnljnline.VALIDATE(Gnljnline.Amount);
                    Gnljnline."Shortcut Dimension 1 Code":='BOSA';
                    Gnljnline."Shortcut Dimension 2 Code":='001';
                    Gnljnline.VALIDATE(Gnljnline."Shortcut Dimension 1 Code");
                    Gnljnline.VALIDATE(Gnljnline."Shortcut Dimension 2 Code");
                    IF Gnljnline.Amount<>0 THEN
                    Gnljnline.INSERT;
                    }
                    //DEBIT TOTAL CHECK OFF
                    CALCFIELDS("Scheduled Amount");
                     LineN:=LineN+10000;
                     Gnljnline.INIT;
                     Gnljnline."Journal Template Name":='GENERAL';
                     Gnljnline."Journal Batch Name":=JournalBatchName;
                     Gnljnline."Line No.":=LineN;
                     Gnljnline."Account Type":="Account Type";
                     Gnljnline."Account No.":="Account No";
                     Gnljnline.VALIDATE(Gnljnline."Account No.");
                     Gnljnline."Document No.":="Document No";
                     Gnljnline."Posting Date":="Posting date";
                     Gnljnline.Description:='CHECKOFF '+Remarks;
                     Gnljnline.Amount:="Scheduled Amount";
                     Gnljnline.VALIDATE(Gnljnline.Amount);
                     Gnljnline."Shortcut Dimension 1 Code":='BOSA';
                     Gnljnline."Shortcut Dimension 2 Code":='NAIROBI';
                     Gnljnline.VALIDATE(Gnljnline."Shortcut Dimension 1 Code");
                     Gnljnline.VALIDATE(Gnljnline."Shortcut Dimension 2 Code");
                     IF Gnljnline.Amount<>0 THEN
                     Gnljnline.INSERT;
                    
                    //Post New  //To be Uncommented after thorough tests
                    {Gnljnline.RESET;
                    Gnljnline.SETRANGE("Journal Template Name",'GENERAL');
                    Gnljnline.SETRANGE("Journal Batch Name",JournalBatchName);
                    IF Gnljnline.FIND('-') THEN BEGIN
                    CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post",Gnljnline);
                    END;
                    Posted:=True;
                    MODIFY;}
                    MESSAGE('CheckOff Successfully Generated');
                    */

                end;
            }
            action("Post check off Loans")
            {
                Caption = 'Post check off Loans';
                Image = Post;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = false;

                trigger OnAction()
                begin
                    /*
                    genstup.GET();
                    IF Posted=TRUE THEN
                    ERROR('This Check Off has already been posted');
                    IF "Account No" = '' THEN
                    ERROR('You must specify the Account No.');
                    IF "Document No" = '' THEN
                    ERROR('You must specify the Document No.');
                    IF "Posting date" = 0D THEN
                    ERROR('You must specify the Posting date.');
                    IF "Posting date" = 0D THEN
                    ERROR('You must specify the Posting date.');
                    IF "Loan CutOff Date" = 0D THEN
                    ERROR('You must specify the Loan CutOff Date.');
                    Datefilter:='..'+FORMAT("Loan CutOff Date");
                    IssueDate:="Loan CutOff Date";
                    startDate:=010100D;
                    
                    //Delete journal
                    Gnljnline.RESET;
                    Gnljnline.SETRANGE("Journal Template Name",'GENERAL');
                    Gnljnline.SETRANGE("Journal Batch Name",JournalBatchName);
                    IF Gnljnline.FIND('-') THEN
                    Gnljnline.DELETEALL;
                    
                    RunBal:=0;
                    TotalWelfareAmount:=0;
                    CALCFIELDS("Scheduled Amount");
                    IF "Scheduled Amount" <>   Amount THEN BEGIN
                    ERROR('Scheduled Amount Is Not Equal To Cheque Amount');
                    END;
                    
                    RcptBufLines.RESET;
                    RcptBufLines.SETRANGE(RcptBufLines."Receipt Header No",No);
                    RcptBufLines.SETRANGE(RcptBufLines.Posted,FALSE);
                    IF RcptBufLines.FIND('-') THEN BEGIN
                    
                      REPEAT
                        RunBal:=0;
                        RunBal:=RcptBufLines.Amount;
                        RunBal:=FnRunInterest(RcptBufLines,RunBal);
                       // RunBal:=FnRecoverWelfare(RcptBufLines,RunBal);
                        RunBal:=FnRunPrinciple(RcptBufLines,RunBal);
                       // RunBal:=FnRunEntranceFee(RcptBufLines,RunBal);
                       // RunBal:=FnRunShareCapital(RcptBufLines,RunBal);
                       // RunBal:=FnRunDepositContribution(RcptBufLines,RunBal);
                       // RunBal:=FnRunXmasContribution(RcptBufLines,RunBal);
                        RunBal:=FnRecoverPrincipleFromExcess(RcptBufLines,RunBal);
                                FnTransferExcessToUnallocatedFunds(RcptBufLines,RunBal);
                      UNTIL RcptBufLines.NEXT=0;
                    END;
                    
                    {//CREDIT WELFARE VENDOR ACCOUNT
                    LineN:=LineN+10000;
                    Gnljnline.INIT;
                    Gnljnline."Journal Template Name":='GENERAL';
                    Gnljnline."Journal Batch Name":=JournalBatchName;
                    Gnljnline."Line No.":=LineN;
                    Gnljnline."Account Type":=Gnljnline."Account Type"::Vendor;
                    Gnljnline."Account No.":='L25001000001';  //Insert Welfare Control account here
                    Gnljnline.VALIDATE(Gnljnline."Account No.");
                    Gnljnline."Document No.":="Document No";
                    Gnljnline."Posting Date":="Posting date";
                    Gnljnline.Description:='Welfare Contributions';
                    Gnljnline.Amount:=TotalWelfareAmount*-1;
                    Gnljnline.VALIDATE(Gnljnline.Amount);
                    Gnljnline."Shortcut Dimension 1 Code":='BOSA';
                    Gnljnline."Shortcut Dimension 2 Code":='001';
                    Gnljnline.VALIDATE(Gnljnline."Shortcut Dimension 1 Code");
                    Gnljnline.VALIDATE(Gnljnline."Shortcut Dimension 2 Code");
                    IF Gnljnline.Amount<>0 THEN
                    Gnljnline.INSERT;}
                    
                    //DEBIT TOTAL CHECK OFF
                    CALCFIELDS("Scheduled Amount");
                     LineN:=LineN+10000;
                     Gnljnline.INIT;
                     Gnljnline."Journal Template Name":='GENERAL';
                     Gnljnline."Journal Batch Name":=JournalBatchName;
                     Gnljnline."Line No.":=LineN;
                     Gnljnline."Account Type":="Account Type";
                     Gnljnline."Account No.":="Account No";
                     Gnljnline.VALIDATE(Gnljnline."Account No.");
                     Gnljnline."Document No.":="Document No";
                     Gnljnline."Posting Date":="Posting date";
                     Gnljnline.Description:='CHECKOFF '+Remarks;
                     Gnljnline.Amount:="Scheduled Amount";
                     Gnljnline.VALIDATE(Gnljnline.Amount);
                     Gnljnline."Shortcut Dimension 1 Code":='BOSA';
                     Gnljnline."Shortcut Dimension 2 Code":='NAIROBI';
                     Gnljnline.VALIDATE(Gnljnline."Shortcut Dimension 1 Code");
                     Gnljnline.VALIDATE(Gnljnline."Shortcut Dimension 2 Code");
                     IF Gnljnline.Amount<>0 THEN
                     Gnljnline.INSERT;
                    
                    //Post New  //To be Uncommented after thorough tests
                    {Gnljnline.RESET;
                    Gnljnline.SETRANGE("Journal Template Name",'GENERAL');
                    Gnljnline.SETRANGE("Journal Batch Name",JournalBatchName);
                    IF Gnljnline.FIND('-') THEN BEGIN
                    CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post",Gnljnline);
                    END;
                    Posted:=True;
                    MODIFY;}
                    MESSAGE('CheckOff Successfully Generated');*/

                end;
            }
            action("Send SMS")
            {
                Image = "report";
                Promoted = true;

                trigger OnAction()
                var
                    ReceiptsProcessing_LCheckoff: Record "ReceiptsProcessing_L-Checkoff";
                begin
                    /*                             IF CONFIRM('Are you sure you want to send SMS?',TRUE,FALSE)=TRUE THEN BEGIN
                                                IF CheckoffMessages.FINDFIRST THEN BEGIN
                                                REPEAT
                                                Members.RESET;
                                                Members.SETRANGE(Members."No.",CheckoffMessages."Client Code");
                                                IF Members.FINDFIRST THEN BEGIN
                                                Members.CALCFIELDS(Members."Current Savings");
                                                Salutation:='';
                                                Salutation:='Dear '+Members.Name+' your checkoff deductions are as follows: '+' '+CheckoffMessages.Message+' Your total deposits is Ksh'+FORMAT(Members."Current Savings");
                                                SkyMbanking.SendSms(Source::CHECKOFFDEDUCTIONS,Members."Mobile Phone No",Salutation,'','',TRUE,200,TRUE);
                                                END;
                                                UNTIL CheckoffMessages.NEXT=0;
                                                END;
                                                END; */
                end;
            }
            action("Mark As Posted")
            {
                Image = "Action";
                Promoted = true;

                trigger OnAction()
                var
                    ReceiptsProcessing_LCheckoff: Record "ReceiptsProcessing_L-Checkoff";
                begin
                    IF CONFIRM('Are you sure you want to mark this checkoff as posted?', TRUE, FALSE) = TRUE THEN BEGIN
                        Rec.Posted := TRUE;
                        Rec."Posted By" := USERID;
                        Rec."Posting date" := TODAY;
                        Rec.MODIFY;
                    END;
                end;
            }
        }
    }

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec."Posting date" := TODAY;
        Rec."Date Entered" := TODAY;
    end;

    var
        RcptBufLinesTwo: Record "ReceiptsProcessing_L-Checkoff";
        LoansR: Record "Loans Register";
        LoansRegister: Record "Loans Register";
        Sfactory: Codeunit "AU Factory";
        TransactionTypes: Option " ","Registration Fee","Share Capital","Interest Paid",Repayment,"Deposit Contribution","Insurance Contribution","Benevolent Fund",Loan,"Unallocated Funds",Dividend,"FOSA Account","Loan Insurance Charged","Loan Insurance Paid","Recovery Account","FOSA Shares","Additional Shares","Interest Due","Capital Reserve","Loan Penalty Charged","Loan Penalty Paid","HouseHold Savings","Housing Coop Shares","Utafiti Housing","Holiday Savings","Dependant 1 Savings","Dependant 2 Savings","Dependant 3 Savings","Interest on Deposits","Share Boost Fee","Rejoining Fee","Dormant Reactivation Fee";
        AccountTypes: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner",Member,Investor;
        RunningBalance: Decimal;
        InterestBal: Decimal;
        LoanBal: Decimal;
        LSchedule: Record "Loan Repayment Schedule";
        Arrear: Decimal;
        Members: Record Customer;
        MonthlyContrib: Decimal;
        Benevolent: Decimal;
        WindowDialoag: Dialog;
        GenJournalLine: Record "Gen. Journal Line";
        RcptBufLines: Record "ReceiptsProcessing_L-Checkoff";
        Memb: Record "Customer";
        Gnljnline: Record "Gen. Journal Line";
        LineN: Integer;
        Ess: Decimal;
        Membersx: Record Customer;
        JournalBatchName: Code[20];
        //CheckoffMessages: Record "Checkoff Messages";
        SerialNo: Integer;
        LoanTypes: Code[30];
        MemberName: Text;
        MessageC: Text[1000];
        SMSMessage: Record "SMS Messages";
        iEntryNo: Integer;
        //  SkyMbanking: Codeunit "51516701";
        Source: Option NEW_MEMBER,NEW_ACCOUNT,LOAN_ACCOUNT_APPROVAL,DEPOSIT_CONFIRMATION,CASH_WITHDRAWAL_CONFIRM,LOAN_APPLICATION,LOAN_APPRAISAL,LOAN_GUARANTORS,LOAN_REJECTED,LOAN_POSTED,LOAN_DEFAULTED,SALARY_PROCESSING,TELLER_CASH_DEPOSIT,TELLER_CASH_WITHDRAWAL,TELLER_CHEQUE_DEPOSIT,FIXED_DEPOSIT_MATURITY,INTERACCOUNT_TRANSFER,ACCOUNT_STATUS,STATUS_ORDER,EFT_EFFECTED,ATM_APPLICATION_FAILED,ATM_COLLECTION,MBANKING,MEMBER_CHANGES,CASHIER_BELOW_LIMIT,CASHIER_ABOVE_LIMIT,INTERNETBANKING,CRM,MOBILE_PIN,CHECKOFFDEDUCTIONS;
        Salutation: Text;
        Len1: Integer;
        MessageX: Text[1000];









    local procedure FnSaveTempLoanAmount(ObjLoansRegister: Record "Loans Register"; TempBalance: Decimal)
    var
    //  ObjTempLoans: Record "Temp Loans Balances";
    begin
        /*         ObjTempLoans.RESET;
                ObjTempLoans.SETRANGE(ObjTempLoans."Member No",ObjLoansRegister."Client Code");
                ObjTempLoans.SETRANGE(ObjTempLoans."Loan No",ObjLoansRegister."Loan  No.");
                IF ObjTempLoans.FIND('-') THEN
                  ObjTempLoans.DELETEALL;

                ObjTempLoans.INIT;
                ObjTempLoans."Member No":=ObjLoansRegister."Client Code";
                ObjTempLoans."Loan No":=ObjLoansRegister."Loan  No.";
                ObjTempLoans."Outstanding Balance":=TempBalance;
                ObjTempLoans.INSERT; */
    end;

    local procedure FnGetMemberBranch(MemberNo: Code[50]): Code[100]
    var
        MemberBranch: Code[100];
    begin
        /*Cust.RESET;
        Cust.SETRANGE(Cust."No.",MemberNo);
        IF Cust.FIND('-') THEN BEGIN
          MemberBranch:=Cust."Global Dimension 2 Code";
          END;
        EXIT(MemberBranch);*/

    end;





    procedure FnGetLoanArrears(LoanNumber: Code[50])
    var
        LoansRe: Record "Loans Register";
        Lschedule: Record "Loan Repayment Schedule";
        ExpectedAmount: Decimal;
        PaidAmount: Decimal;
    begin
        ExpectedAmount := 0;
        Lschedule.RESET;
        Lschedule.SETRANGE(Lschedule."Loan No.", LoanNumber);
        Lschedule.SETFILTER(Lschedule."Repayment Date", '<=%1', Rec."Posting date");
        IF Lschedule.FINDSET THEN BEGIN
            Lschedule.CALCSUMS(Lschedule."Principal Repayment");
            ExpectedAmount := Lschedule."Principal Repayment";
        END;

        PaidAmount := 0;
        LoansRe.RESET;
        LoansRe.SETRANGE(LoansRe."Loan  No.", LoanNumber);
        IF LoansRe.FINDFIRST THEN BEGIN
            LoansRe.CALCFIELDS(LoansRe."Outstanding Balance");
            PaidAmount := LoansRe."Approved Amount" - LoansRe."Outstanding Balance";
        END;

        Arrear := 0;
        Arrear := ExpectedAmount - PaidAmount;
        IF Arrear > 0 THEN
            Arrear := Arrear
        ELSE
            Arrear := 0;
        //MESSAGE('LoansR%1Expected%2PaidAmount%3Arrears%4',LoanNumber,ExpectedAmount,PaidAmount,Arrear);
    end;
}


