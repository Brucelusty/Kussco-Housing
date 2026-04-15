//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50458 "Cue Sacco Roles"
{

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
        }
        field(2; "Application Loans"; Integer)
        {
            CalcFormula = count("Loans Register" where("Loan Status" = filter(Application),
                                                        Posted = filter(false)));
            FieldClass = FlowField;
        }
        field(3; "Appraisal Loans"; Integer)
        {
            CalcFormula = count("Loans Register" where("Loan Status" = filter(Appraisal),
                                                        Posted = filter(false)));
            FieldClass = FlowField;
        }
        field(4; "Approved Loans"; Integer)
        {
            CalcFormula = count("Loans Register" where("Loan Status" = filter(Disbursed),
                                                        Posted = filter(false)));
            FieldClass = FlowField;
        }
        field(5; "Rejected Loans"; Integer)
        {
            CalcFormula = count("Loans Register" where("Approval Status" = filter(Rejected),
                                                        Posted = filter(false)));
            FieldClass = FlowField;
        }
        field(6; "Pending Account Opening"; Integer)
        {
            CalcFormula = count("Membership Applications" where("Membership Approval Status" = filter("Pending Approval")));
            FieldClass = FlowField;
        }
        field(7; "Approved Accounts Opening"; Integer)
        {
            CalcFormula = count("Membership Applications" where("Membership Approval Status" = filter(Approved)));
            FieldClass = FlowField;
        }
        field(8; "Pending Loan Batches"; Integer)
        {
            CalcFormula = count("Loan Disburesment-Batching" where(Status = filter("Pending Approval")));
            FieldClass = FlowField;
        }
        field(9; "Approved Loan Batches"; Integer)
        {
            CalcFormula = count("Loan Disburesment-Batching" where(Status = filter(Approved),
                                                                    Posted = filter(false)));
            FieldClass = FlowField;
        }
        field(10; "Pending Payment Voucher"; Integer)
        {
            FieldClass = Normal;
        }
        field(11; "Approved Payment Voucher"; Integer)
        {
        }
        field(12; "Pending Petty Cash"; Integer)
        {
        }
        field(13; "Approved  Petty Cash"; Integer)
        {
            FieldClass = Normal;
        }
        field(14; "Open Account Opening"; Integer)
        {
            CalcFormula = count("Membership Applications" where("Membership Approval Status" = filter(Open)));
            FieldClass = FlowField;
        }
        field(20; "Date Filter"; Date)
        {
            Caption = 'Date Filter';
            Editable = false;
            FieldClass = FlowFilter;
        }
        field(21; "Date Filter2"; Date)
        {
            Caption = 'Date Filter2';
            Editable = false;
            FieldClass = FlowFilter;
        }
        field(22; "Open Member Applications"; Integer)
        {
            CalcFormula = count("Membership Applications" where("Membership Approval Status" = filter(Open)));
            FieldClass = FlowField;
        }
        field(23; "Pending Member Applications"; Integer)
        {
            CalcFormula = count("Membership Applications" where("Membership Approval Status" = filter("Pending Approval")));
            FieldClass = FlowField;
        }
        field(24; "Rejected Member Applications"; Integer)
        {
            CalcFormula = count("Membership Applications" where("Membership Approval Status" = filter(Rejected)));
            FieldClass = FlowField;
        }
        field(25; "Total Members"; Integer)
        {
            CalcFormula = count("Customer" where(ISNormalMember = filter(true)));
            FieldClass = FlowField;
        }
        field(26; "Total Individual Members"; Integer)
        {
            CalcFormula = count("Customer" where(ISNormalMember = filter(true), "Account Category" = filter(Individual)));
            FieldClass = FlowField;
        }
        field(27; "Total Joint Members"; Integer)
        {
            CalcFormula = count("Customer" where(ISNormalMember = filter(true), "Account Category" = filter(joint)));
            FieldClass = FlowField;
        }
        field(28; "Total Corporate Members"; Integer)
        {
            CalcFormula = count("Customer" where(ISNormalMember = filter(true), "Account Category" = filter(Corporate)));
            FieldClass = FlowField;
        }
        field(30; "Total Male Members"; Integer)
        {
            CalcFormula = count("Customer" where(ISNormalMember = filter(true), "Account Category" = filter(Individual), Gender = filter(Male)));
            FieldClass = FlowField;
        }
        field(31; "Total Female Members"; Integer)
        {
            CalcFormula = count("Customer" where(ISNormalMember = filter(true), "Account Category" = filter(Individual), Gender = filter(female)));
            FieldClass = FlowField;
        }
        field(32; "Total Leads"; Integer)
        {
            CalcFormula = count("Customer Contact" where(Converted = filter(False)));
            FieldClass = FlowField;
        }
        field(33; "Unassigned Leads"; Integer)
        {
            CalcFormula = count("Customer Contact" where(Converted = filter(False), "Sales Agent Code" = filter(<> '')));
            FieldClass = FlowField;
        }
        field(34; "Total Campaigns Done"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Marketing Campaign");
            
        }
        field(35; "Total Marketing Events"; Integer)
        {
            CalcFormula = count("Marketing Event");
            FieldClass = FlowField;
        }
        field(36; "New Members This Month"; Integer)
        {
            CalcFormula = count("Customer" where(ISNormalMember = filter(true), "Registration Date" = filter('-CM..CM')));
            FieldClass = FlowField;
        }

        field(37; "Loans In Valuation"; Integer)
        {
            CalcFormula = count("Loans Register" where("Loan Status" = filter(Valuation),
                                                        Posted = filter(false)));
            FieldClass = FlowField;
        }
        field(38; "Loans In Credit Committeee"; Integer)
        {
            CalcFormula = count("Loans Register" where("Loan Status" = filter("Credit Committee"),
                                                        Posted = filter(false)));
            FieldClass = FlowField;
        }
        field(39; "Loans being Charged"; Integer)
        {
            CalcFormula = count("Loans Register" where("Loan Status" = filter(Legal),
                                                        Posted = filter(false)));
            FieldClass = FlowField;
        }
        field(40; "Running Loans"; Integer)
        {
            CalcFormula = count("Loans Register" where(Posted = filter(true),"Outstanding Balance"=filter(>0)));
            FieldClass = FlowField;
        }
        field(41; "Total Loan Book"; Decimal)
        {
            CalcFormula = sum("Detailed Cust. Ledg. Entry".amount where("transaction Type"= filter(Loan|Repayment)));
            FieldClass = FlowField;
        }
                field(42; "Total Interest"; Decimal)
        {
            CalcFormula = sum("Detailed Cust. Ledg. Entry".amount where("transaction Type"= filter("Interest Due"|"Interest Paid")));
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Primary Key")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}




