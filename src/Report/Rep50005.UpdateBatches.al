report 50005 "UpdateBatches"
{
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    // DefaultRenderingLayout = LayoutName;
    DefaultLayout = RDLC;
    RDLCLayout = 'Layouts/UpdateDetailedB.Rdlc';



    dataset
    {

        dataitem(Batch; "MOBILE MPESA Trans")
        {
            RequestFilterFields = "Transaction Date";
            column(Trace; Trace)
            {

            }
            trigger
            OnAfterGetRecord()
            var
                DetariledL: Record "Detailed Cust. Ledg. Entry";
                MessageX: text[1500];
                smsManagement: Codeunit "Sms Management";
                Loans: Record "Loans Register";
                Customer: record customer;
                DetVendor: Record "Detailed Vendor Ledg. Entry";

            begin

                /*                 Batch.Reset();
                                Batch.SetAutoCalcFields(Batch."No of Loans");
                                Batch.SetFilter("No of Loans", '%1', 0);
                                if Batch.Find('-') then begin
                                    repeat

                                        /*                         Loans.Reset();
                                                                Loans.SetRange("Batch No.", Batch."Batch No.");
                                                                if Loans.find('-') then begin
                                                                    repeat
                                                                        Loans.Posted := true;
                                                                        Loans."Loan Status" := Loans."loan status"::Disbursed;
                                                                        Loans."Issued Date" := Batch."Posting Date";
                                                                        Loans."Posting Date" := Batch."Posting Date";
                                                                        Loans."Disbursed By" := Batch."Posted By";
                                                                        Loans."Loan Disbursement Date" := Batch."Posting Date";
                                                                        Loans.Validate(Loans."Loan Disbursement Date");
                                                                        Loans.Modify;
                                                                    until Loans.Next() = 0;

                                                                end; */
                /*                         Batch.Posted := false;
                                        Batch.Modify();
                                    until Batch.Next() = 0;  */

                //  end;

                DetVendor.Reset();
                // DetVendor.SetRange(DetVendor."Vendor No.",Batch."Vendor No");
                DetVendor.SetRange(DetVendor."Document No.", CopyStr(Batch.Trace, 1, 19));
                if DetVendor.FindFirst() then begin
                    Batch."Transaction Found" := true;
                    Batch.Modify();
                end;
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
}
