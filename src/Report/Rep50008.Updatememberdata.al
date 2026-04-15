report 50008 "Update Member Data"
{
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    // DefaultRenderingLayout = LayoutName;
    DefaultLayout = RDLC;
    RDLCLayout = 'Layouts/UpdateDetememberdata.Rdlc';



    dataset
    {

        dataitem(Customer; "Workflow Event")
        {
            RequestFilterFields = "Table ID";
            // DataItemTableView = where("Document No" = filter('STO*'));
            column(Member_No; customer."Table ID")
            {

            }
            trigger
            OnAfterGetRecord()
            var
                DetariledL: Record "Detailed Cust. Ledg. Entry";
                MessageX: text[1500];
                smsManagement: Codeunit "Sms Management";
                Cust: Record "Employer Members";
                EmployerMembers: Record "Employer Members";
                Memberss: record Vendor;
                STO: Record "Standing Orders";

            begin


                Customer."Table ID" := 50368;
                Customer.Modify();
                /*                  Memberss.Reset();
                                Memberss.SetRange(Memberss."BOSA Account No", Customer."No.");
                                if Memberss.FindSet then begin */
                /*               repeat
                                  if Memberss."Account Type" = '101' then begin
                                      Customer."Share Capital No" := Memberss."No.";
                                  end;
                                  if Memberss."Account Type" = '102' then begin
                                      Customer."Deposits Account No" := Memberss."No.";
                                  end;
                                  if Memberss."Account Type" = '103' then begin
                                      Customer."Ordinary Savings Acc" := Memberss."No.";
                                  end;
                                  if Memberss."Account Type" = '104' then begin
                                      Customer."School Fees Shares Account" := Memberss."No.";
                                  end;
                                  if Memberss."Account Type" = '105' then begin
                                      Customer."Chamaa Savings Acc" := Memberss."No.";
                                  end;
                                  if Memberss."Account Type" = '106' then begin
                                      Customer."Jibambe Savings Acc" := Memberss."No.";
                                  end;
                                  if Memberss."Account Type" = '107' then begin
                                      Customer."Wezesha Savings Acc" := Memberss."No.";
                                  end;
                                  if Memberss."Account Type" = '108' then begin
                                      Customer."Fixed Deposit Acc" := Memberss."No.";
                                  end;
                                  if Memberss."Account Type" = '109' then begin
                                      Customer."Mdosi Junior Acc" := Memberss."No.";
                                  end;
                                  if Memberss."Account Type" = '110' then begin
                                      Customer."Pension Akiba Acc" := Memberss."No.";
                                  end;
                                  if Memberss."Account Type" = '111' then begin
                                      Customer."Business Account Acc" := Memberss."No.";
                                  end;


                                  Customer.Modify();
                              until Memberss.Next() = 0; */

           // end; 


                /*                 STO.Reset();
                                STO.SetRange(STO."BOSA Account No.", Customer."BOSA Account No");
                                if sto.FindsET() then begin
                                    repeat */
                //Error('eND');
                //Customer."Member No":=Customer."Account No";
                //    if Customer."STO Account Type" = Customer."STO Account Type"::"FOSA Account" then begin
                //        Customer."Transaction Type":=Customer."Transaction Type"::"FOSA Account";
                //       Customer.Modify();
                //     end;

                // Customer.Delete();

                //  until STO.Next() = 0;

                //end;




                //                 if Customer."No."='02347' then begin
                //                 //if Customer."No."='00409' then begin
                // Customer."No.":='0010102347';
                // Customer.Modify;
                // end;
                /*                 vendor.Reset();
                                vendor.SetRange(vendor."BOSA Account No", Customer."No.");
                                if vendor.Find('-') then begin
                                    repeat
                                        if Customer."ID No." <> '' then
                                            vendor."ID No." := Customer."ID No.";
                                        if Customer."Mobile Phone No" <> '' then begin
                                            vendor."Mobile Phone No" := Customer."Mobile Phone No";
                                            vendor."S-Mobile No" := Customer."Mobile Phone No";
                                            vendor."Mobile Phone No." := Customer."Mobile Phone No";
                                            vendor."S-Mobile No" := Customer."Mobile Phone No";
                                        end;

                                        if Customer."Payroll No" <> '' then
                                            vendor."Personal No." := Customer."Payroll No";
                                        If Customer."First Name" <> '' then
                                            vendor."First Name" := Customer."First Name";
                                        If Customer."Middle Name" <> '' then
                                            vendor."Middle Name" := Customer."Middle Name";
                                        If Customer."Last Name" <> '' then
                                            vendor."Last Name" := Customer."Last Name";
                                        if Customer."Date Of Birth" <> 0D then
                                            vendor."Date of Birth" := Customer."Date Of Birth";
                                        if Customer."Registration Date" <> 0D then
                                            vendor."Registration Date" := Customer."Registration Date";
                                        if Customer."Employer Code"<>'' then
                                        vendor."Employer Code":=Customer."Employer Code";

                                        vendor.Modify();
                                    until vendor.Next() = 0;
                                end; */
                /*                 Cust.Reset();
                                Cust.SetRange(Cust."Loan  No.", EmployerMembers."Member No");
                                if Cust.FindFirst() then begin
                                    if EmployerMembers."Recovery Mode" = EmployerMembers."Recovery Mode"::Checkoff then begin
                                        Cust."Recovery Mode" := Cust."Recovery Mode"::Checkoff;
                                    end;
                                    if EmployerMembers."Recovery Mode" = EmployerMembers."Recovery Mode"::Salary then begin
                                        Cust."Recovery Mode" := Cust."Recovery Mode"::Salary;
                                    end;
                                    Cust.Modify();

                                end; */
                // Cust.Reset();
                // Cust.SetRange(Cust."Member No",EmployerMembers."Loan  No.");
                // if  Cust.FindFirst() then begin
                //   Cust.Found:=true;
                //  Cust.Modify();
                //end;
                /*                   EmployerMembers.Reset();
                                EmployerMembers.SetRange(EmployerMembers."Member No", Vendor."BOSA Account No");
                                EmployerMembers.SetRange(EmployerMembers."Transaction Type", EmployerMembers."Transaction Type"::"Deposit Contribution");
                                IF EmployerMembers.FindFirst() then begin
                                    if (vendor."Account Type" = '102') then begin

                                        EmployerMembers."Vendor New" := vendor."No.";
                                        EmployerMembers."Account Type" := EmployerMembers."Account Type"::Vendor;
                                    end;
                                    EmployerMembers.Modify();
                                end;

                                EmployerMembers.Reset();
                                EmployerMembers.SetRange(EmployerMembers."Member No", Vendor."BOSA Account No");
                                EmployerMembers.SetRange(EmployerMembers."Transaction Type", EmployerMembers."Transaction Type"::"Benevolent Fund");
                                IF EmployerMembers.FindFirst() then begin
                                    if ("EmployerMembers"."Transaction Type" = "EmployerMembers"."Transaction Type"::"Benevolent Fund") then begin

                                        "EmployerMembers"."Vendor New" := vendor."BOSA Account No";
                                        "EmployerMembers"."Account Type" := EmployerMembers."Account Type"::member;
                                    end;
                                    // EmployerMembers.Modify();
                                end;

                                EmployerMembers.Reset();
                                EmployerMembers.SetRange(EmployerMembers."Member No", Vendor."BOSA Account No");
                                EmployerMembers.SetRange(EmployerMembers."Transaction Type", EmployerMembers."Transaction Type"::"FOSA Account");

                                IF EmployerMembers.FindFirst() then begin
                                    if (EmployerMembers."Transaction Type" = EmployerMembers."Transaction Type"::"FOSA Account") and (vendor."Account Type" = '103') then begin

                                        EmployerMembers."Vendor New" := vendor."No.";
                                        EmployerMembers."Account Type" := EmployerMembers."Account Type"::Vendor;
                                    end;
                                    EmployerMembers.Modify();
                                end;


                                EmployerMembers.Reset();
                                EmployerMembers.SetRange(EmployerMembers."Member No", Vendor."BOSA Account No");
                                EmployerMembers.SetRange(EmployerMembers."Transaction Type", EmployerMembers."Transaction Type"::"Interest Paid");
                                IF EmployerMembers.FindFirst() then begin
                                    if (EmployerMembers."Transaction Type" = EmployerMembers."Transaction Type"::"Interest Paid") then begin

                                        EmployerMembers."Vendor New" := vendor."BOSA Account No";
                                        EmployerMembers."Account Type" := EmployerMembers."Account Type"::member;
                                    end;
                                    // EmployerMembers.Modify();
                                end;


                                EmployerMembers.Reset();
                                EmployerMembers.SetRange(EmployerMembers."Member No", Vendor."BOSA Account No");
                                EmployerMembers.SetRange(EmployerMembers."Transaction Type", EmployerMembers."Transaction Type"::Repayment);
                                IF EmployerMembers.FindFirst() then begin
                                    if (EmployerMembers."Transaction Type" = EmployerMembers."Transaction Type"::Repayment) then begin

                                        EmployerMembers."Vendor New" := vendor."BOSA Account No";
                                        EmployerMembers."Account Type" := EmployerMembers."Account Type"::member;
                                    end;
                                    // EmployerMembers.Modify();
                                end;


                                EmployerMembers.Reset();
                                EmployerMembers.SetRange(EmployerMembers."Member No", Vendor."BOSA Account No");
                                EmployerMembers.SetRange(EmployerMembers."Transaction Type", EmployerMembers."Transaction Type"::"SchFees Shares");
                                IF EmployerMembers.FindFirst() then begin
                                    if (vendor."Account Type" = '104') then begin

                                        EmployerMembers."Vendor New" := vendor."No.";
                                        EmployerMembers."Account Type" := EmployerMembers."Account Type"::Vendor;
                                    end;
                                    EmployerMembers.Modify();
                                end;


                                EmployerMembers.Reset();
                                EmployerMembers.SetRange(EmployerMembers."Member No", Vendor."BOSA Account No");
                                EmployerMembers.SetRange(EmployerMembers."Transaction Type", EmployerMembers."Transaction Type"::"Shares Capital");
                                IF EmployerMembers.FindFirst() then begin
                                    if (vendor."Account Type" = '101') then begin

                                        EmployerMembers."Vendor New" := vendor."No.";
                                        EmployerMembers."Account Type" := EmployerMembers."Account Type"::Vendor;
                                    end;
                                    EmployerMembers.Modify();
                                end; */




            end;

            trigger OnPostDataItem()
            begin
                //Activate.FnMarkAccountAsActive();
            end;

        }
    }





    var
        myInt: Integer;

        Activate: Codeunit "Activate/Deactivate accounts";
}
