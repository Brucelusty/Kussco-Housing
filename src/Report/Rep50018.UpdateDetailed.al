report 50018 "UpdateDetailed"
{
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    // DefaultRenderingLayout = LayoutName;
    DefaultLayout = RDLC;
    RDLCLayout = 'Layouts/UpdateDetailed.Rdlc';



    dataset
    {

        dataitem(Customers; "Detailed Cust. Ledg. Entry")//"G/L Entry"//"Detailed Cust. Ledg. Entry"
        {
            //RequestFilterFields = "Entry No.", "Posting Date", "Document No.";
            //DataItemTableView = where("G/L Account No." = filter('14006'));
            column(Posting_Date; "Posting Date")
            {

            }
            trigger
            OnAfterGetRecord()
            var
                EntryL: Record "G/L Entry";
                MessageX: text[1500];
                smsManagement: Codeunit "Sms Management";
                loans: Record "Loans Register";

                CustD: Record "Detailed Cust. Ledg. Entry";
                LoanTypes: Record "Loan Products Setup";
                register: Record "Loans Register";


            begin

                /*  Customers.CalcFields("Transaction Types", "Loan Number");*/

                //  Customers."GL Code" := FnGetReceivableAccount(Customers."Loan Number From Cust"); 
                //  Customers.Modify;

                EntryL.Reset();
                EntryL.SetRange(EntryL."Entry No.", Customers."Cust. Ledger Entry No.");
                //EntryL.SetRange(EntryL."G/L Account No.", '14006');
                if EntryL.FindFirst() then begin
                    EntryL."Transaction Types" := Customers."Transaction Type";
                    loans.Get(Customers."Loan No");
                    // EntryL.loa
                    EntryL.Modify();
                end;






                /*  register.Reset();

                 register.SetRange(register."Loan  No.", "Loan Number From Cust");
                 if register.FindFirst() then begin
                     if LoanTypes.Get(register."Loan Product Type") then begin
                         "GL Code" := LoanTypes."Loan Interest Account";

                     end;
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

    local procedure FnGetReceivableAccount(LoanNo: Code[40]) RecAccount: code[60]
    var
        LoanTypes: Record "Loan Products Setup";
        register: Record "Loans Register";
    begin
        register.Reset();
        ;
        register.SetRange(register."Loan  No.", LoanNo);
        if register.FindFirst() then begin
            if LoanTypes.Get(register."Loan Product Type") then begin
                RecAccount := LoanTypes."Loan Interest Account";
            end;
        end;
    end;
}
