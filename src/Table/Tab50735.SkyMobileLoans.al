table 50735 "Sky Mobile Loans"
{

    fields
    {
        field(1;"Entry No";Integer)
        {
            AutoIncrement = true;
            Editable = false;
        }
        field(2;"Account No";Text[30])
        {
            Editable = false;
        }
        field(3;Date;DateTime)
        {
        }
        field(4;"Requested Amount";Decimal)
        {
            Editable = false;
        }
        field(5;Posted;Boolean)
        {
            Editable = true;
        }
        field(6;Status;Option)
        {
            Editable = true;
            OptionCaption = 'Pending,Successful,Failed,Pending Guarantors,Guarantors Qualified';
            OptionMembers = Pending,Successful,Failed,"Pending Guarantors","Guarantors Qualified";
        }
        field(7;"Date Posted";DateTime)
        {
        }
        field(8;Remarks;Text[200])
        {
            Editable = false;
        }
        field(9;DocumentNo;Text[30])
        {
            Editable = false;
        }
        field(10;"Latest Salary Amount";Decimal)
        {
            Editable = false;
        }
        field(11;"STO Amount";Decimal)
        {
        }
        field(12;"Net Salary";Decimal)
        {
        }
        field(13;"Total loans";Decimal)
        {
        }
        field(14;"Approved Amount";Decimal)
        {
        }
        field(15;"Commision Amount";Decimal)
        {
        }
        field(16;"Loan Product Type";Code[20])
        {
            TableRelation = "Loan Products Setup";
        }
        field(17;Amount;Decimal)
        {
        }
        field(18;"Session ID";Code[20])
        {
        }
        field(19;"Date Entered";Date)
        {
        }
        field(20;"Time Entered";Time)
        {
        }
        field(21;"Telephone No";Text[20])
        {
        }
        field(22;Message;Text[250])
        {
        }
        field(23;"Member No.";Code[20])
        {
        }
        field(24;"Entry Code";Text[50])
        {
        }
        field(25;Installments;Integer)
        {
        }
        field(50050;Deactivated;Boolean)
        {
        }
        field(50051;"Deactivated By";Code[50])
        {
        }
        field(50052;"Date Deactivated";Date)
        {
        }
        field(50053;"Micro Loan Category";Code[20])
        {
            //TableRelation = //39005554;
        }
        field(50054;"Needs Guarantors";Boolean)
        {
        }
        field(50055;"Micro Loan";Boolean)
        {
        }
        field(50056;Name;Text[200])
        {
        }
        field(50057;"Staff No.";Code[20])
        {
        }
        field(50058;Overdraft;Boolean)
        {
        }
        field(50059;"Posting Attempts";Integer)
        {
        }
        field(50060;"Account Name";Text[50])
        {
        }
        field(50061;"Loan Name";Text[30])
        {
            TableRelation = "Loan Products Setup" WHERE ("Product Description"=CONST('Loan Name'));
        }
        field(50062;"Expected Guarantors";Integer)
        {
        }
        field(50063;Source;Code[30])
        {
        }
        field(50064;"Loan No";Code[30])
        {
            TableRelation = "Loans Register";
        }
        field(50065;PendingAmount;Decimal)
        {
        }
        field(50066;"Amount Guaranteed";Decimal)
        {
        }
        field(50067;"Qualified Amount";Decimal)
        {
        }
        field(50068;"Added Guarantors";Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Mobile Loan Guarantors" WHERE ("Loan Entry No."=FIELD("Entry No")));
        }
        field(50069;"Accepted Guarantors";Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Mobile Loan Guarantors" WHERE ("Loan Entry No."=FIELD("Entry No"),
                                                                "Guarantor Accepted"=CONST(Yes)));
        }
        field(50070;"Loan Complete";Boolean)
        {
        }
    }

    keys
    {
        key(Key1;"Entry No")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
           ERROR('Deletion not allowed');
    end;
}

