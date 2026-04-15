report 50007 "UpdateLoanDibursementDate"
{
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    DefaultRenderingLayout = LayoutName;

    dataset
    {
        dataitem(Batch; "Loans Register")
        {
            RequestFilterFields = "Loan  No.";

            //DataItemTableView = where(Interest = filter(<>0),Posted=const(true));
            // DataItemTableView = where("Loan Product Type" = filter(''));
            column(Trace; "Loan  No.")
            {

            }
            trigger OnAfterGetRecord()
            var

                loanapp: Record "Loans Register";
                MembersRegister: Record "Members Register";
                RSchedule: Record "Loan Repayment Schedule";
                TransFound: Boolean;
                DocumentX: code[100];
            begin
                /*                 TransFound := false;
                                DocumentX := '';
                                DocumentX := CopyStr(Batch.Trace, 1, 19);
                                DetVendor.Reset();
                                // DetVendor.SetRange(DetVendor."Vendor No.",Batch."Vendor No");
                                DetVendor.SetRange(DetVendor."Document No.", DocumentX);
                                if DetVendor.FindFirst() then begin
                                    // Message('here');
                                    TransFound := true;
                                end;

                                Batch."Transaction Found" := TransFound;
                                Batch.Modify(); */
                //  if loantype.Get(DataItemName.loa) then begin
                //DataItemName


                //   end;

                Loan.Reset();
                Loan.SetRange(Loan."Loan  No.", Batch."Loan  No.");
                if Loan.FindFirst() then begin
                    If loantype.Get(Loan."Loan Product Type") then begin
                        Loan."Repayment Method" := loantype."Repayment Method";
                        Loan."Loan Product Type Name" := loantype."Product Description";
                    end;
                    Loan.Modify(true);
                    // AuFactory.FnGenerateLoanRepaymentSchedule(Loan."Loan  No.");
                end;

                if MembersRegister.Get(Loan."Client Code") then begin
                    Loan."Client Name" := MembersRegister.Name;

                    Loan.Modify(true);

                end;
                    // Message('%1', LoanType."Interest rate");
                    // DataItemName.Interest := loantype."Interest rate";
                    // DataItemName."Repayment Method" := loantype."Repayment Method";
                    // DataItemName."Loan Product Type Name" := loantype."Product Description";
                    // LPrincipal := ROUND(DataItemName."Approved Amount" / DataItemName.Installments, 1, '>');
                    // if DataItemName.Installments > 12 then
                    ///   LInterest := ROUND((DataItemName.Interest / 12 / 100) * DataItemName."Approved Amount", 1, '>')
                    // else
                    // LInterest := ROUND((DataItemName.Interest / DataItemName.Installments / 100) * DataItemName."Approved Amount", 1, '>');
                    //LPrincipal := TotalMRepay - LInterest;

                    /*               RSchedule.Reset();
                                  RSchedule.SetRange(RSchedule."Loan No.",DataItemName."Loan  No.");
                                  if RSchedule.FindFirst() then begin 
                                     DataItemName."Loan Principle Repayment" := Round(RSchedule."Principal Repayment",1,'>');
                                    DataItemName."Loan Interest Repayment" := Round(RSchedule."Monthly Interest",1,'>');
                                    DataItemName.Repayment:= Round(RSchedule."Monthly Repayment",1,'>');
                                    DataItemName.Modify();
                                    end; */

                    // if DataItemName."Repayment Start Date" = 0D then begin
                    //     DataItemName."Repayment Start Date" := CalcDate('1M', DataItemName."Issued Date");
                    // end;
                    //DataItemName."Repayment Frequency" := DataItemName."Repayment Frequency"::Monthly;
                    //if DataItemName."Loan Product Type" <> 'SALARY IN ADVANCE' then begin

                    // DataItemName.Validate(DataItemName."Loan Disbursement Date");
                    //if DataItemName.Interest <> 0 then begin
                    //  DataItemName.Interest := loantype."Interest rate";

                    // DataItemName.Modify(true);
                    //end;
                    // AuFactory.FnGenerateLoanRepaymentSchedule(DataItemName."Loan  No.");
                    //end;

                    // end;

                    //IF   DataItemName."Application Date"=TODAY THEN BEGIN       
                    //DataItemName.Validate("Approved Amount");
                    //DataItemName.Modify(true);
                    //END;
                    /*                 //end;
                                    MembersRegister.Reset();
                                    MembersRegister.SetRange("No.", "Client Code");
                                    if MembersRegister.Find('-') then begin
                                        "Employer Code" := MembersRegister."Employer Code";
                                        "Employer Name" := MembersRegister."Employer Name";
                                        //modify(true);
                                    end; */
                    /*            if DataItemName."Loan Disbursement Date"<=20231231D then begin
                                    DataItemName."Recovery Mode":=DataItemName."Recovery Mode"::Salary;
                                    DataItemName.Modify();
                                end; */

                    /*            // LoanregisterCopy.Reset();;
                                LoanregisterCopy.setrange(LoanregisterCopy."Loan  No.",DataItemName."Loan Number");
                                if LoanregisterCopy.FindFirst() then begin
                                    LoanregisterCopy."Issued Date":=DataItemName."Disbursement Date";
                                    LoanregisterCopy."Loan Disbursement Date":=DataItemName."Disbursement Date";
                                    LoanregisterCopy.Modify();
                                end; */

                    //  if DataItemName.

                end;
        }
    }



    rendering
    {
        layout(LayoutName)
        {
            Type = RDLC;
            LayoutFile = 'mylayout.rdl';
        }
    }

    var
        myInt: Integer;
        AuFactory: Codeunit "Au Factory";
        TotalMRepay: Decimal;
        LInterest: Decimal;
        loantype: Record "Loan Products Setup";
        LPrincipal: Decimal;
        DetVendor: Record "Detailed Vendor Ledg. Entry";
        Loan: Record "Loans Register";

}
