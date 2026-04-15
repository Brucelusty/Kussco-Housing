//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51035 "Exit Sub-Page List"
{
    ApplicationArea = All;
    //CardPageID = "Loans Application Card(Posted)";
    DeleteAllowed = false;
    // Editable = false;
    // InsertAllowed = false;
    PageType = ListPart;
    RefreshOnActivate = true;
    SourceTable = "Membership Exist";

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field("Member No."; Rec."Member No.")
                {
                    Editable = false;
                    Enabled = false;
                }
                field("Member name"; Rec."Member Name")
                {
                    Caption = 'Member Name';
                    Editable = false;
                    Enabled = false;
                }
                field("Payroll/StaffNo"; Rec."Payroll/StaffNo")
                {
                    Caption = 'Payroll No';
                    Editable = false;
                    Enabled = false;
                }
                field("Application Date"; Rec."Application Date")
                {
                    Editable = false;
                    Enabled = false;
                }
                field("Member Deposits"; Rec."Member Deposits")
                {
                    Editable = false;
                }
                field("Share Capital"; Rec."Share Capital")
                {
                    Editable = false;
                }
                field(SchoolFeesShares; Rec.SchoolFeesShares)
                {
                    Caption = 'ESS Shares';
                    Editable = false;
                }
                field("Total Loan"; Rec."Total Loan")
                {
                    Editable = false;
                }
                field("Amount To Disburse"; Rec."Amount To Disburse")
                {
                    ShowMandatory = true;
                    Style = StrongAccent;
                }
                field(Remainder; Rec.Remainder)
                {
                    Editable = false;
                }
                field("Fully Paid"; Rec."Fully Paid")
                {
                    // Editable = true;
                }
                field(Posted; Rec.Posted)
                {
                    Editable = false;
                    Visible = false;
                }
            }
        }
    }


    actions
    {


        /*        action("Loan Appraisal")
               {
                   Caption = 'Loan Appraisal';
                   Enabled = true;
                   Image = GanttChart;
                   Promoted = true;
                   // Visible = false;
                   PromotedCategory = Category4;
                   PromotedOnly = true;

                   trigger OnAction()
                   var
                       LoanApp: Record "Loans Register";
                   begin
                       rec.TestField("Mode of Disbursement");
                       LoanApp.Reset;
                       LoanApp.SetRange(LoanApp."Loan  No.", Rec."Loan  No.");
                       if LoanApp.Find('-') then begin
                           Report.Run(50084, true, false, LoanApp)
                       end;
                   end; 

               } */

    }

    trigger OnAfterGetCurrRecord()
    begin
        /*InterestDue:=SFactory.FnGetInterestDueTodate(Rec);
        OutstandingInterest:=SFactory.FnGetInterestDueTodate(Rec)-"Interest Paid";
        
        
        SFactory.FnGetLoanArrearsAmountII("Loan  No.");
        
        CALCFIELDS("Interest Due","Interest Paid");
        "Outstanding Interest":="Interest Due"-("Interest Paid");
        
        "Loan Current Payoff Amount":=SFactory.FnRunGetLoanPayoffAmount("Loan  No.");
        
        "Loan Amount Due":=SFactory.FnRunLoanAmountDue("Loan  No.");
        */

    end;

    trigger OnAfterGetRecord()
    begin
        //SFactory.FnGetLoanArrearsAmountII("Loan  No.");


        //"Loan Current Payoff Amount" := SFactory.FnRunGetLoanPayoffAmount("Loan  No.");

        //"Loan Amount Due" := SFactory.FnRunLoanAmountDue("Loan  No.");
    end;

    trigger OnOpenPage()
    begin
        //SetFilter("Loan Status", '<>%1', "loan status"::Closed);

        /*"Loan Current Payoff Amount":=SFactory.FnRunGetLoanPayoffAmount("Loan  No.");
        
        "Loan Amount Due":=SFactory.FnRunLoanAmountDue("Loan  No.");*/

    end;

    var
        NoSeriesMgt: Codeunit "No. Series";
        FieldStyle: Text;
        FieldStyleI: Text;
}




