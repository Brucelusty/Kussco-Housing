table 50716 "ReceiptsProcessing_L-Checkoff"
{

    fields
    {
        field(1;"Staff/Payroll No";Code[20])
        {
        }
        field(2;Amount;Decimal)
        {
        }
        field(3;"No Repayment";Boolean)
        {
        }
        field(4;"Staff Not Found";Boolean)
        {
        }
        field(5;"Date Filter";Date)
        {
            FieldClass = FlowFilter;
        }
        field(6;"Transaction Date";Date)
        {
        }
        field(8;Generated;Boolean)
        {
        }
        field(9;"Payment No";Integer)
        {
        }
        field(10;Posted;Boolean)
        {
        }
        field(11;"Multiple Receipts";Boolean)
        {
        }
        field(12;Name;Text[200])
        {
        }
        field(13;"Early Remitances";Boolean)
        {
        }
        field(14;"Early Remitance Amount";Decimal)
        {
        }
        field(15;"Trans Type";Option)
        {
            OptionCaption = ' ,sShare,sLoan,sDeposits,sInterest,sInsurance,sBenevolent';
            OptionMembers = " ",sShare,sLoan,sDeposits,sInterest,sInsurance,sBenevolent;
        }
        field(16;Description;Text[60])
        {
        }
        field(17;"Member Found";Boolean)
        {
        }
        field(18;"Search Index";Code[20])
        {
        }
        field(19;"Loan Found";Boolean)
        {
        }
        field(20;"Loan No";Code[20])
        {
            TableRelation = "Loans Register"."Loan  No." WHERE ("Client Code"=FIELD("Member No"),
                                                                Posted=CONST(true));

            trigger OnValidate()
            begin
                 memb.RESET;
                 memb.SETRANGE(memb."No.","Member No");
                 IF memb.FIND('-') THEN BEGIN
                  loans.RESET;
                  loans.SETRANGE(loans."Loan  No.","Loan No");
                  IF loans.FIND('-') THEN BEGIN
                   IF "Trans Type"="Trans Type"::sInsurance THEN BEGIN
                    Amount:=100;
                   END ELSE IF "Trans Type"="Trans Type"::sDeposits THEN BEGIN
                   loans.CALCFIELDS(loans."Interest Due",loans."Outstanding Balance");
                  /// IF loans."Interest Due">0 THEN
                  // Amount:=loans."Interest Due";
                    Amount:=0.01*loans."Outstanding Balance";
                   END ELSE IF  "Trans Type"="Trans Type"::sLoan THEN BEGIN
                   Amount:=loans.Repayment;
                  END;
                END;
                END;
            end;
        }
        field(21;User;Code[20])
        {
        }
        field(22;"Member Moved";Boolean)
        {
        }
        field(23;"Employer Code";Code[20])
        {
        }
        field(24;"Batch No.";Code[30])
        {
            TableRelation = "Loan Disburesment-Batching"."Batch No.";
        }
        field(25;"Member No";Code[20])
        {
            TableRelation = "Members Register"."No." WHERE ("Customer Type"=FILTER(Member));

            trigger OnValidate()
            begin
                memb.RESET;
                memb.SETRANGE(memb."No.","Member No");
                IF memb.FIND('-') THEN BEGIN
                "Staff/Payroll No":=memb."Payroll No";
                "ID No.":=memb."ID No.";
                Name:=memb.Name;
                "Employer Code":=memb."Employer Code";
                IF "Trans Type"="Trans Type"::sShare THEN BEGIN
                Amount:=memb."Monthly Contribution"
                END ELSE IF "Trans Type"="Trans Type"::sInterest THEN BEGIN
                Amount:=200
                END ELSE IF "Trans Type"="Trans Type"::sInsurance THEN BEGIN
                Amount:=100
                END ELSE IF "Trans Type"="Trans Type"::sBenevolent THEN BEGIN
                //memb.CALCFIELDS(memb."KMA Withdrawable Savings");
                //Amount:=memb."KMA Withdrawable Savings"*-1;
               // END ELSE IF "Trans Type"="Trans Type"::"7" THEN BEGIN
                //memb.CALCFIELDS(memb."Children Savings");
                //Amount:=memb."Children Savings"*-1;
               /// END ELSE IF "Trans Type"="Trans Type"::"8" THEN BEGIN
                //memb.CALCFIELDS(memb."CIC Fixed Deposits");
                //Amount:=memb."CIC Fixed Deposits"*-1;
                //END ELSE IF "Trans Type"="Trans Type"::"9" THEN BEGIN
                //memb.CALCFIELDS(memb."UAP Premiums");
                //Amount:=memb."UAP Premiums"*-1;




                END;
                END;
            end;
        }
        field(26;"ID No.";Code[20])
        {
        }
        field(27;"Receipt Header No";Code[20])
        {
            TableRelation = "ReceiptsProcessing_H-Checkoff".No;
        }
        field(28;"Receipt Line No";Integer)
        {
            AutoIncrement = true;
        }
        field(29;"Account Type";Option)
        {
            OptionCaption = 'G/L Account,Customer,Vendor,Bank Account,Fixed Asset,IC Partner,Member,None,Staff';
            OptionMembers = "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner",Member,"None",Staff;
        }
        field(30;"Entry No";Integer)
        {
        }
        field(31;"Xmas Contribution";Decimal)
        {
        }
        field(32;"Xmas Account";Code[10])
        {
        }
        field(33;"Transaction Type";Option)
        {
            OptionCaption = 'Loan,Deposits,ESS';
            OptionMembers = Loan,Deposits,ESS;
        }
        field(34;"Loan Code";Code[10])
        {
        }
        field(35;"Loan Product Type";Code[50])
        {
        }
        field(36;"Loan type Code";Code[50])
        {
        }
        field(37;"Posting Date";Date)
        {
            CalcFormula = Lookup("ReceiptsProcessing_H-Checkoff"."Posting date" WHERE (No=FIELD("Receipt Header No")));
            FieldClass = FlowField;
        }
        field(38;"Deposit Amount";Decimal)
        {
            CalcFormula = Lookup("Member Ledger Entry".Amount WHERE ("Document No."=FIELD("Document No"),
                                                                     "Customer No."=FIELD("Member No"),
                                                                     "Transaction Type"=CONST("Deposit Contribution")));
            FieldClass = FlowField;
        }
        field(39;"Document No";Code[40])
        {
            CalcFormula = Lookup("ReceiptsProcessing_H-Checkoff"."Document No" WHERE (No=FIELD("Receipt Header No")));
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1;"Receipt Header No","Receipt Line No")
        {
            SumIndexFields = Amount;
        }
        key(Key2;"Receipt Line No")
        {
        }
        key(Key3;"Staff/Payroll No")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        IF Posted = TRUE THEN
        ERROR('You cannot delete a Posted Check Off');
    end;

    trigger OnModify()
    begin
        IF Posted = TRUE THEN
        ERROR('You cannot modify a Posted Check Off');
    end;

    trigger OnRename()
    begin
        IF Posted = TRUE THEN
        ERROR('You cannot rename a Posted Check Off');
    end;

    var
        memb: Record Customer;
        loans: Record "Loans Register";
}

