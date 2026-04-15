table 50796 "Checkoff Distributed Matrix"
{

    fields
    {
        field(1;"Employer Code";Code[50])
        {
            TableRelation = "Sacco Employers";
        }
        field(2;"Loan Product Code";Code[50])
        {
            TableRelation = "Loan Products Setup".Code;

            trigger OnValidate()
            begin
                LSetup.RESET;
                LSetup.SETRANGE(LSetup.Code,"Loan Product Code");
                IF LSetup.FIND('-') THEN
                BEGIN
                "Product Name":=LSetup."Product Description";
                END;
            end;
        }
        field(3;"Check off Code";Code[50])
        {
        }
        field(4;"check Interest";Boolean)
        {
        }
        field(5;"Product Name";Text[30])
        {
        }
    }

    keys
    {
        key(Key1;"Employer Code","Loan Product Code","Check off Code","Product Name")
        {
        }
    }

    fieldgroups
    {
    }

    var
        LSetup: Record "Loan Products Setup";
}

