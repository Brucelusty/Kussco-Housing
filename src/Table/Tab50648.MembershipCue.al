//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50648 "Membership Cue"
{

    fields
    {
        field(1; "User ID"; Code[50])
        {
        }
        field(2; "Active Members"; Integer)
        {
            CalcFormula = count(Customer where("Membership Status" = const(Active), ISNormalMember = filter(true)));
            FieldClass = FlowField;
        }
        field(3; "Dormant Members"; Integer)
        {
            CalcFormula = count(Customer where("Membership Status" = const(Dormant), ISNormalMember = filter(true)));
            FieldClass = FlowField;
        }
        field(4; "Deceased Members"; Integer)
        {
            CalcFormula = count(Customer where("Membership Status" = const(Deceased), ISNormalMember = filter(true)));
            FieldClass = FlowField;
        }
        field(5; "Withdrawn Members"; Integer)
        {
            CalcFormula = count(Customer where("Membership Status" = const(Exited), ISNormalMember = filter(true)));
            FieldClass = FlowField;
        }
        field(6; "Male Members"; Integer)
        {
            CalcFormula = count(Customer where(Gender = const(Male), ISNormalMember = filter(true)));
            FieldClass = FlowField;
        }
        field(7; "Female Members"; Integer)
        {
            CalcFormula = count(Customer where(Gender = const(Female), ISNormalMember = filter(true)));
            FieldClass = FlowField;
        }
        field(8; "Resigned Members"; Integer)
        {
            // CalcFormula = count(Customer where (Status=const("9")));
            // FieldClass = FlowField;
        }
        field(9; BOSA; Integer)
        {
            CalcFormula = count("Loans Register" where("Loan Product Type" = const('BOSA'),
                                                        Posted = const(true)));
            FieldClass = FlowField;
        }
        field(10; "Closed Members"; Integer)
        {
            CalcFormula = count(Customer where("Membership Status" = filter(Closed), ISNormalMember = filter(true)));
            FieldClass = FlowField;
        }
        field(11; "Non-Members"; Integer)
        {
            CalcFormula = count(Customer where("Shares Retained" = filter(0),
             "Current Shares" = filter(0),"Ordinary Savings" = filter(>0), ISNormalMember = filter(true)));
            FieldClass = FlowField;
        }
        field(14; "Members with ID No"; Integer)
        {
            CalcFormula = count(Customer where("ID No." = filter(> '0'), ISNormalMember = filter(true)));
            FieldClass = FlowField;
        }
        field(15; "Members With Tell No"; Integer)
        {
            CalcFormula = count(Customer where("Phone No." = filter(> '0'), ISNormalMember = filter(true)));
            FieldClass = FlowField;
        }
        field(16; "Members With Mobile No"; Integer)
        {
            CalcFormula = count(Customer where("Mobile Phone No" = filter(> '0'), ISNormalMember = filter(true)));
            FieldClass = FlowField;
        }
        field(17; CROP; Integer)
        {
            CalcFormula = count("Loans Register" where("Loan Product Type" = const('CROP'),
                                                        Posted = const(true)));
            FieldClass = FlowField;
        }
        field(26; "Non-Active Members"; Integer)
        {
            CalcFormula = count(Customer where("Membership Status" = const(retired), ISNormalMember = filter(true)));
            FieldClass = FlowField;
        }
        field(27; "NoQsAsked Loan"; Integer)
        {
            CalcFormula = count("Loans Register" where("Loan Product Type" = const('NOQS'),
                                                        Posted = const(true)));
            FieldClass = FlowField;
        }
        field(28; StaffAsset; Integer)
        {
            CalcFormula = count("Loans Register" where("Loan Product Type" = const('312'),
                                                        Posted = const(true)));
            FieldClass = FlowField;
        }
        field(29; StaffCar; Integer)
        {
            CalcFormula = count("Loans Register" where("Loan Product Type" = const('SCAR'),
                                                        Posted = const(true)));
            FieldClass = FlowField;
        }
        field(30; "BDevt Loan"; Integer)
        {
            CalcFormula = count("Loans Register" where("Loan Product Type" = const('BDEVT'),
                                                        Posted = const(true)));
            FieldClass = FlowField;
        }
        field(31; "Normal Loan"; Integer)
        {
            CalcFormula = count("Loans Register" where("Loan Product Type" = const('NORMAL'),
                                                        Posted = const(true)));
            FieldClass = FlowField;
        }
        field(32; "Asset Financing Loan"; Integer)
        {
            CalcFormula = count("Loans Register" where("Loan Product Type" = const('ASSET'),
                                                        Posted = const(true)));
            FieldClass = FlowField;
        }
        field(33; "Junior Members"; Integer)
        {
        }
        field(34; "BOSA_SUPER-Book Balance"; Decimal)
        {
            CalcFormula = sum("Detailed Cust. Ledg. Entry".Amount where("Loan Type" = const('BOSA_SUPER')
            ));
            FieldClass = FlowField;
        }
        field(35; "BOSA_SUPER II-Book Balance"; Decimal)
        {
            CalcFormula = sum("Detailed Cust. Ledg. Entry".Amount where("Loan Type" = const('BOSA_SUPER II')
            ));
            FieldClass = FlowField;
        }
         field(36; "DEFAULT-Book Balance"; Decimal)
        {
            CalcFormula = sum("Detailed Cust. Ledg. Entry".Amount where("Loan Type" = const('DEFAULT')
            ));
            FieldClass = FlowField;
        }
        field(37; "DEVELOPMENT_LOAN-Book Balance"; Decimal)
        {
            CalcFormula = sum("Detailed Cust. Ledg. Entry".Amount where("Loan Type" = const('DEVELOPMENT_LOAN')
            ));
            FieldClass = FlowField;
        }
        field(38; "DEVELOPMENT_LOAN 2-Book Balance"; Decimal)
        {
            CalcFormula = sum("Detailed Cust. Ledg. Entry".Amount where("Loan Type" = const('DEVELOPMENT_LOAN 2')
            ));
            FieldClass = FlowField;
        }
        field(39; "DEVELOPMENT_LOAN III-Book Balance"; Decimal)
        {
            CalcFormula = sum("Detailed Cust. Ledg. Entry".Amount where("Loan Type" = const('DEVELOPMENT_LOAN III')
            ));
            FieldClass = FlowField;
        }
        field(40; "DIVIDEND_ADVANCE-Book Balance"; Decimal)
        {
            CalcFormula = sum("Detailed Cust. Ledg. Entry".Amount where("Loan Type" = const('DIVIDEND_ADVANCE')
            ));
            FieldClass = FlowField;
        }
        field(41; "EMERGENCY_LOAN-Book Balance"; Decimal)
        {
            CalcFormula = sum("Detailed Cust. Ledg. Entry".Amount where("Loan Type" = const('EMERGENCY_LOAN')
            ));
            FieldClass = FlowField;
        }
         field(42; "EMERGENCY_LOAN 2-Book Balance"; Decimal)
        {
            CalcFormula = sum("Detailed Cust. Ledg. Entry".Amount where("Loan Type" = const('EMERGENCY_LOAN 2')
            ));
            FieldClass = FlowField;
        }
         field(43; "FIT FOSA-Book Balance"; Decimal)
        {
            CalcFormula = sum("Detailed Cust. Ledg. Entry".Amount where("Loan Type" = const('FIT FOSA')
            ));
            FieldClass = FlowField;
        }
        field(44; "HIFADHI_LOAN-Book Balance"; Decimal)
        {
            CalcFormula = sum("Detailed Cust. Ledg. Entry".Amount where("Loan Type" = const('HIFADHI_LOAN')
            ));
            FieldClass = FlowField;
        }
        field(45; "HIFADHI_LOAN II-Book Balance"; Decimal)
        {
            CalcFormula = sum("Detailed Cust. Ledg. Entry".Amount where("Loan Type" = const('HIFADHI_LOAN II')
            ));
            FieldClass = FlowField;
        }
         field(46; "KARIBU LOAN-Book Balance"; Decimal)
        {
            CalcFormula = sum("Detailed Cust. Ledg. Entry".Amount where("Loan Type" = const('KARIBU LOAN')
            ));
            FieldClass = FlowField;
        }
         field(47; "M-BANKING ADVANCE-Book Balance"; Decimal)
        {
            CalcFormula = sum("Detailed Cust. Ledg. Entry".Amount where("Loan Type" = const('M-BANKING ADVANCE')
            ));
            FieldClass = FlowField;
        }
        field(48; "MEGA_LOAN-Book Balance"; Decimal)
        {
            CalcFormula = sum("Detailed Cust. Ledg. Entry".Amount where("Loan Type" = const('MEGA_LOAN')
            ));
            FieldClass = FlowField;
        }
         field(49; "MEGA_LOAN II-Book Balance"; Decimal)
        {
            CalcFormula = sum("Detailed Cust. Ledg. Entry".Amount where("Loan Type" = const('MEGA_LOAN II')
            ));
            FieldClass = FlowField;
        }
         field(50; "OKOA_LOAN-Book Balance"; Decimal)
        {
            CalcFormula = sum("Detailed Cust. Ledg. Entry".Amount where("Loan Type" = const('OKOA_LOAN')
            ));
            FieldClass = FlowField;
        }
         field(51; "ONE_MONTH-Book Balance"; Decimal)
        {
            CalcFormula = sum("Detailed Cust. Ledg. Entry".Amount where("Loan Type" = const('ONE_MONTH')
            ));
            FieldClass = FlowField;
        }
        field(52; "P.O.A_LOAN-Book Balance"; Decimal)
        {
            CalcFormula = sum("Detailed Cust. Ledg. Entry".Amount where("Loan Type" = const('P.O.A_LOAN')
            ));
            FieldClass = FlowField;
        }
         field(53; "SAFARICOM FOSA LOAN-Book Balance"; Decimal)
        {
            CalcFormula = sum("Detailed Cust. Ledg. Entry".Amount where("Loan Type" = const('SAFARICOM FOSA LOAN')
            ));
            FieldClass = FlowField;
        }
        field(54; "SAFARICOM_FOSA-Book Balance"; Decimal)
        {
            CalcFormula = sum("Detailed Cust. Ledg. Entry".Amount where("Loan Type" = const('SAFARICOM_FOSA')
            ));
            FieldClass = FlowField;
        }
        field(55; "SALARY IN ADVANCE-Book Balance"; Decimal)
        {
            CalcFormula = sum("Detailed Cust. Ledg. Entry".Amount where("Loan Type" = const('SALARY IN ADVANCE')
            ));
            FieldClass = FlowField;
        }
         field(56; "SCHOOL_FEES-Book Balance"; Decimal)
        {
            CalcFormula = sum("Detailed Cust. Ledg. Entry".Amount where("Loan Type" = const('SCHOOL_FEES')
            ));
            FieldClass = FlowField;
        }
         field(57; "SCHOOL_FEES 2-Book Balance"; Decimal)
        {
            CalcFormula = sum("Detailed Cust. Ledg. Entry".Amount where("Loan Type" = const('SCHOOL_FEES 2')
            ));
            FieldClass = FlowField;
        }
         field(58; "SHAMBA LOAN-Book Balance"; Decimal)
        {
            CalcFormula = sum("Detailed Cust. Ledg. Entry".Amount where("Loan Type" = const('SHAMBA LOAN')
            ));
            FieldClass = FlowField;
        }
        field(59; "SIX_MONTHS-Book Balance"; Decimal)
        {
            CalcFormula = sum("Detailed Cust. Ledg. Entry".Amount where("Loan Type" = const('SIX_MONTHS')
            ));
            FieldClass = FlowField;
        }
         field(60; "STAFF_LOAN 2-Book Balance"; Decimal)
        {
            CalcFormula = sum("Detailed Cust. Ledg. Entry".Amount where("Loan Type" = const('STAFF_LOAN 2')
            ));
            FieldClass = FlowField;
        }
        field(61; "THREE MONTHS ADVANCE-Book Balance"; Decimal)
        {
            CalcFormula = sum("Detailed Cust. Ledg. Entry".Amount where("Loan Type" = const('THREE MONTHS ADVANCE')
            ));
            FieldClass = FlowField;
        }
        field(93; "Loan Book Balance"; Decimal)
        {
            CalcFormula = sum("Detailed Cust. Ledg. Entry".Amount where("Transaction Type" = filter("Interest Paid"|Repayment|Loan|"Interest Due")
            ));
            FieldClass = FlowField;

            //"Registration Fee","Shares Capital","Interest Paid",Repayment,"Deposit Contribution","Insurance Contribution","Benevolent Fund",Loan,"Unallocated Funds",Dividend,"FOSA Account","Loan Insurance Charged","Loan Insurance Paid","Recovery Account","FOSA Shares","Additional Shares","Interest Due","Capital Reserve","Loan Penalty Charged","Loan Penalty Paid","HouseHold Savings","Housing Coop Shares","Utafiti Housing","Holiday Savings","Dependant 1 Savings","Dependant 2 Savings","Dependant 3 Savings","Interest on Deposits","Share Boost Fee","Rejoining Fee","Dormant Reactivation Fee"
        }
         field(94; "Share Capital Balance"; Decimal)
        {
            CalcFormula = sum("Detailed Cust. Ledg. Entry".Amount where("Transaction Type" = filter("Share Capital")
            ));
            FieldClass = FlowField;

            //"Registration Fee","Shares Capital","Interest Paid",Repayment,"Deposit Contribution","Insurance Contribution","Benevolent Fund",Loan,"Unallocated Funds",Dividend,"FOSA Account","Loan Insurance Charged","Loan Insurance Paid","Recovery Account","FOSA Shares","Additional Shares","Interest Due","Capital Reserve","Loan Penalty Charged","Loan Penalty Paid","HouseHold Savings","Housing Coop Shares","Utafiti Housing","Holiday Savings","Dependant 1 Savings","Dependant 2 Savings","Dependant 3 Savings","Interest on Deposits","Share Boost Fee","Rejoining Fee","Dormant Reactivation Fee"
        }
         field(95; "Deposit Contribution Balance"; Decimal)
        {
            CalcFormula = sum("Detailed Cust. Ledg. Entry".Amount where("Transaction Type" = filter("Deposit Contribution")
            ));
            FieldClass = FlowField;

            //"Registration Fee","Shares Capital","Interest Paid",Repayment,"Deposit Contribution","Insurance Contribution","Benevolent Fund",Loan,"Unallocated Funds",Dividend,"FOSA Account","Loan Insurance Charged","Loan Insurance Paid","Recovery Account","FOSA Shares","Additional Shares","Interest Due","Capital Reserve","Loan Penalty Charged","Loan Penalty Paid","HouseHold Savings","Housing Coop Shares","Utafiti Housing","Holiday Savings","Dependant 1 Savings","Dependant 2 Savings","Dependant 3 Savings","Interest on Deposits","Share Boost Fee","Rejoining Fee","Dormant Reactivation Fee"
        }
         field(96; "BBF Fund Balance"; Decimal)
        {
/*             CalcFormula = sum("Detailed Cust. Ledg. Entry".Amount where("Transaction Type" = filter("Benevolent Fund")
            ));
            FieldClass = FlowField;
 */
        }
        field(97; "Jipange Balance"; Decimal)
        {
            CalcFormula = sum("Detailed Vendor Ledg. Entry".Amount where("Posting Group"=const('SAVING ACCOUNT'))
            );
            FieldClass = FlowField;

        }
        field(98; "Fixed deposit Balance"; Decimal)
        {
            CalcFormula = sum("Detailed Vendor Ledg. Entry".Amount where("Posting Group"=const('FIXED DEPOSIT'))
            );
            FieldClass = FlowField;
            //CHILDREN

        }
        field(99; "Children Account Balance"; Decimal)
        {
            CalcFormula = sum("Detailed Vendor Ledg. Entry".Amount where("Posting Group"=const('CHILDREN'))
            );
            FieldClass = FlowField;
            //CHILDREN

        }
         field(100; "HOLIDAY Account Balance"; Decimal)
        {
            CalcFormula = sum("Detailed Vendor Ledg. Entry".Amount where("Posting Group"=const('HOLIDAY'))
            );
            FieldClass = FlowField;
            //CHILDREN

        }
         field(101; "VIP Account Balance"; Decimal)
        {
            CalcFormula = sum("Detailed Vendor Ledg. Entry".Amount where("Posting Group"=const('VIP ACCOUNT'))
            );
            FieldClass = FlowField;
            //CHILDREN

        }
        





       
       
       
        
        field(62; "Approved Applications"; Integer)
        {
            CalcFormula = count("Membership Applications" where("Membership Approval Status" = const(Approved),
                                                                 Created = const(true)));
            FieldClass = FlowField;
        }
        field(63; "Loans Pending Approval"; Integer)
        {
            CalcFormula = count("Loans Register" where("Approval Status" = const(Pending)));
            FieldClass = FlowField;
        }
        field(64; "Approved Loans"; Integer)
        {
            CalcFormula = count("Loans Register" where("Approval Status" = const(Approved),
                                                        Posted = const(false)));
            FieldClass = FlowField;
        }
        field(65; "Rejected Loans"; Integer)
        {
            CalcFormula = count("Loans Register" where("Approval Status" = const(Rejected),
                                                        "Loan Status" = const(Rejected)));
            FieldClass = FlowField;
        }
        field(66; "Requests to Approve"; Integer)
        {
            CalcFormula = count("Approval Entry" where("Approver ID" = field("User ID"),
                                                        Status = filter(Open)));
            Caption = 'Requests to Approve';
            FieldClass = FlowField;
        }
        field(67; "Requests Sent for Approval"; Integer)
        {
            CalcFormula = count("Approval Entry" where("Sender ID" = field("User ID"),
                                                        Status = filter(Open)));
            Caption = 'Requests Sent for Approval';
            FieldClass = FlowField;
        }
        field(68; "Leave Pending"; Integer)
        {
            CalcFormula = count("HR Leave Application" where(Status = const("Pending Approval")));
            FieldClass = FlowField;
        }
        field(69; "Leave Approved"; Integer)
        {
            CalcFormula = count("HR Leave Application" where(Status = const(Approved)));
            FieldClass = FlowField;
        }
        field(70; "Staff Claims Pending"; Integer)
        {
            CalcFormula = count("Staff Claims Header" where(Status = filter("Pending Approval")));
            FieldClass = FlowField;
        }
        field(71; "Staff Claims Approved"; Integer)
        {
            CalcFormula = count("Staff Claims Header" where(Status = filter(Approved)));
            FieldClass = FlowField;
        }
        field(72; "Pending Cheque Payments"; Integer)
        {
            CalcFormula = count("Payments Header" where(Status = const("Pending Approval")));
            FieldClass = FlowField;
        }
        field(73; "Approved Cheque Payments"; Integer)
        {
            CalcFormula = count("Payments Header" where(Status = const(Approved)));
            FieldClass = FlowField;
        }
        field(74; Logo; Blob)
        {

        }
        field(75; "House Hold Loan"; Integer)
        {
            CalcFormula = count("Loans Register" where("Loan Product Type" = const('HOUSEHOLD'),
                                                        Posted = const(true),
                                                        "Loan Status" = filter(Disbursed)));
            FieldClass = FlowField;
        }

        field(76; "Haraka Loan"; Integer)
        {
            CalcFormula = count("Loans Register" where("Loan Product Type" = const('HARAKA'),
                                                        Posted = const(true),
                                                        "Loan Status" = filter(Disbursed)));
            FieldClass = FlowField;
        }

        field(77; "Dhamana Loan"; Integer)
        {
            CalcFormula = count("Loans Register" where("Loan Product Type" = const('DHAMANA'),
                                                        Posted = const(true),
                                                        "Loan Status" = filter(Disbursed)));
            FieldClass = FlowField;
        }

        field(78; "Defaulted Loans"; Integer)
        {
            CalcFormula = count("Loans Register" where("Loan Product Type" = const('DEFAULT'),
                                                        Posted = const(true),
                                                        "Loan Status" = filter(Disbursed)));
            FieldClass = FlowField;
        }


    }

    keys
    {
        key(Key1; "User ID")
        {
            Clustered = true;
        }
    }


    fieldgroups
    {
    }
    trigger OnInsert()
    begin
    end;

    var
        company: record "Company Information";
}




