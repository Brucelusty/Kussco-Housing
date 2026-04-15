report 50006 "UpdateVend"
{
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    // DefaultRenderingLayout = LayoutName;
    DefaultLayout = RDLC;
    RDLCLayout = 'Layouts/UpdateDetailedv.Rdlc';



    dataset
    {

        dataitem(Vendor; "Detailed Cust. Ledg. Entry")
        {
            RequestFilterFields = "Entry No.";

            //DataItemTableView=where()
            column(No_; "Entry No.")
            {

            }
            trigger
            OnAfterGetRecord()
            var
                DetariledL: Record "Detailed Cust. Ledg. Entry";
                MessageX: text[1500];
                smsManagement: Codeunit "Sms Management";
                Cust: Record Customer;
                ReceiptAll: record "Receipt Allocation";

            begin

                //    DetCust.Reset();
                //  deta

                //                 if Customer."No."='02347' then begin//001-001962-8000
                //                 //if Customer."No."='00409' then begin
                // Customer."No.":='0010102347';
                // Customer.Modify;//
                // end;
                /*                 Cust.Reset();
                                Cust.SetRange(Cust."Account No", Customer."BOSA Account No");
                                if Cust.Find('-') then begin
                                    Customer."Salary earner" := true;
                                    Customer."Salary Processing" := true;
                                    Customer.Modify();
                                end; */

                // "Standing Orders"."Is Active" := true;
                // "Standing Orders".Modify();
                // if Customer."ATM No." <> '' then
                // Customer."Card Status" := Customer."Card Status"::Active;
                //   Customer.Modify();

                /*               Employers.Reset();
                              Employers.SetRange(Employers."Member No",Customer."No.");
                              if Employers.FindFirst() then begin
                                  Customer."ESS Contribution":=Employers."Monthly Contribution";
                                  Customer.Modify();
                              end;*/
                /*                 ReceiptAll.Reset();
                                ReceiptAll.SetRange(ReceiptAll."Document No","Standing Orders"."No.");
                                ReceiptAll.SetRange(ReceiptAll."Member No",'200-000-109');
                                if ReceiptAll.FindFirst() then begin
                                    ReceiptAll."Account No":="Standing Orders"."BOSA Account No.";
                                    ReceiptAll."STO Account Type":=ReceiptAll."STO Account Type"::Member;
                                    ReceiptAll."Transaction Type":=ReceiptAll."Transaction Type"::"Benevolent Fund";
                                    ReceiptAll."Account Type":=ReceiptAll."Account Type"::Customer;
                                    ReceiptAll."Member No":="Standing Orders"."BOSA Account No.";
                                    ReceiptAll.Modify();
                                end; */


                /*                 SH.Reset();
                                SH.SetRange(SH."FOSA Account No", Vendor."No.");
                                SH.SetFilter("Posting Date", '<=%1', 20240228D);
                                if not SH.FindFirst() then begin
                                    Vendor."Salary earner" := false;
                                    Vendor."Salary Processing" := false;
                                    Vendor.Modify();
                                end; */

                /*          Cust.Reset();
                         Cust.SetRange(Cust."No.", '002419');
                         If Cust.FindFirst() then begin

                             Vendor."Date of Birth" := Cust."Date of Birth";
                             Vendor."Last Name" := Cust."Last Name";
                             Vendor.Designation := Cust.Designation;
                             Vendor.Workstation := Cust.Workstation;
                             Vendor."First Name" := Cust."First Name";
                             Vendor."Middle Name" := Cust."Middle Name";
                             Vendor."Referee ID No" := Cust."Referee ID No";
                             Vendor."Marital Status" := Cust."Marital Status";
                             Vendor."Why Exempt from Tax?" := Cust."Why Exempt from Tax?";
                             Vendor.Name := Cust.Name;
                             Vendor."Creditor Type" := Vendor."creditor type"::"FOSA Account";
                             Vendor."Personal No." := Cust."Payroll No";
                             Vendor."ID No." := Cust."ID No.";
                             Vendor."Mobile Phone No" := Cust."Mobile Phone No";
                             Vendor."Phone No." := Cust."Mobile Phone No";
                             Vendor."Registration Date" := Cust."Registration Date";
                             Vendor."Post Code" := Cust."Post Code";
                             Vendor."BOSA Account No" := Cust."No.";
                             Vendor."Passport No." := Cust."Passport No.";
                             Vendor."Employer Code" := Cust."Employer Code";
                             Vendor.Status := Vendor.Status::Active;
                            // Vendor."Account Type" := ObjProductsApp.Product;
                             Vendor."Date of Birth" := Cust."Date of Birth";
                            // Vendor."Global Dimension 1 Code" := Format(ObjProductsApp."Product Source");
                             //Vendor."Global Dimension 2 Code" := Cust."Global Dimension 2 Code";
                             Vendor.Address := Cust.Address;
                             Vendor."Employment Start Date" := Cust."Employment Start Date";
                             Vendor."Employment End Date" := Cust."Employment End Date";
                             Vendor."Employment Period" := Cust."Employment Period";
                             Vendor.Designation := Cust.Designation;
                             Vendor.Workstation := Cust.Workstation;
                             Vendor.Modify() */
                ;
                //  end;
                /*               if Vendor."ATM No."<>'' then begin
                                Vendor."Card Status":=Vendor."Card Status"::Active;
                                Vendor.Modify();
                              end; */
            end;


        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {

                }
            }
        }
    }



    var
        myInt: Integer;
        Employers: Record "Employer Members";
        SH: Record "Salary Details";

        CustL: Record "Cust. Ledger Entry";
        VendL: Record "Vendor Ledger Entry";

        DetVend: Record "Detailed Vendor Ledg. Entry";

        DetCust: Record "Detailed Cust. Ledg. Entry";
}
