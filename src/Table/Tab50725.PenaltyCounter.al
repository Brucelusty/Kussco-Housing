table 50725 "Penalty Counter"
{

    fields
    {
        field(1;"Loan Number";Code[30])
        {
            TableRelation = "Loans Register"."Loan  No." WHERE (Posted=CONST(true),
                                                                "Loan Product Type"=CONST('A03'));

            trigger OnValidate()
            begin
                IF LoansRegister.GET("Loan Number") THEN BEGIN
                  "Member Number" := LoansRegister."Client Code";
                  "Member Name" := LoansRegister."Client Name";
                  "Product Type" := LoansRegister."Loan Product Type";
                  "Date Entered" := TODAY;
                  "Personal Number" := LoansRegister."Staff No";
                END;
                "Created By" := USERID;
            end;
        }
        field(2;"Penalty Number";Integer)
        {
        }
        field(3;"Next Penalty Date";Date)
        {
        }
        field(4;"Member Number";Code[30])
        {
            TableRelation = "Members Register"."No.";
        }
        field(5;"Product Type";Code[30])
        {
            TableRelation = "Loan Products Setup".Code WHERE (AvailableOnMobile=CONST(true));
        }
        field(6;"Added Manually";Boolean)
        {
        }
        field(7;"Date Entered";Date)
        {
        }
        field(8;"Date Penalty Paid";Date)
        {
            FieldClass = FlowField;
            CalcFormula = max("Detailed Cust. Ledg. Entry"."Posting Date" where("Customer No." = field("Member Number"), "Loan No" = field("Loan Number"),
                                                                                "Transaction Type" = filter("Loan Penalty Paid")));
        }
        field(9;"Created By";Code[50])
        {
            Editable = false;
        }
        field(10;"Member Name";Text[30])
        {

            trigger OnValidate()
            var
                Member: Record "Membership Applications";
            begin

                IF LoansRegister.GET("Loan Number") THEN BEGIN
                "Member Name" := LoansRegister."Client Name";
                END;
            end;
        }
        field(11;"Personal Number";Code[30])
        {

            trigger OnValidate()
            var
                MembershipApplications: Record "Membership Applications";
            begin
                // MembershipApplications.RESET;
                // MembershipApplications.SETRANGE("No.","Member Number");
                // IF MembershipApplications.FINDFIRST THEN BEGIN
                //   "Personal Number":=MembershipApplications."Payroll/Staff No";
                // END;
                "Personal Number":=LoansRegister."Staff No";
            end;
        }
        field(12; "Amount Charged"; Decimal)
        {
            
        }
        field(13; Reversed; Boolean)
        {
            
        }
        field(14; "Rectified By"; Code[20])
        {
            
        }
        field(15; "Rectified On"; Date)
        {
            
        }
    }

    keys
    {
        key(Key1;"Loan Number")
        {
        }
    }

    fieldgroups
    {
    }

    var
        LoansRegister: Record "Loans Register";
}

