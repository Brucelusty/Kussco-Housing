report 50784 "Member Salary Variance Rpt"
{
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
  //  DefaultRenderingLayout = PaymentVar;
      DefaultLayout = RDLC;
    RDLCLayout = 'Layouts/MemberPaymentVariances.rdlc';
    
    dataset
    {
        dataitem("Member Salary Variance Buffer";"Salary Processing Lines")
        {
            column(Document_No;"Salary Header No.")
            {}
            column(Member_No;"Member No")
            {}
            column(Payroll_No;"Staff No.")
            {}
            column(Member_Name;"Account Name")
            {}
            column(Member_Salary;"Amount")
            {}
            column(Expected_Deduction;"Expected Amount")
            {}
            column(Actual_Deduction;"Amount Deducted")
            {}
            column(Variance;"Expected Amount"-"Amount Deducted")
            {}

            column(monthText;monthText)
            {}

            trigger OnAfterGetRecord() begin
                // if "Member Salary Variance Buffer".Month = 1 then begin
                //     monthText := 'January';
                // end else if "Member Salary Variance Buffer".Month = 2 then begin
                //     monthText := 'February';
                // end else if "Member Salary Variance Buffer".Month = 3 then begin
                //     monthText := 'March';
                // end else if "Member Salary Variance Buffer".Month = 4 then begin
                //     monthText := 'April';
                // end else if "Member Salary Variance Buffer".Month = 5 then begin
                //     monthText := 'May';
                // end else if "Member Salary Variance Buffer".Month = 6 then begin
                //     monthText := 'June';
                // end else if "Member Salary Variance Buffer".Month = 7 then begin
                //     monthText := 'July';
                // end else if "Member Salary Variance Buffer".Month = 8 then begin
                //     monthText := 'August';
                // end else if "Member Salary Variance Buffer".Month = 9 then begin
                //     monthText := 'September';
                // end else if "Member Salary Variance Buffer".Month = 10 then begin
                //     monthText := 'October';
                // end else if "Member Salary Variance Buffer".Month = 11 then begin
                //     monthText := 'November';
                // end else if "Member Salary Variance Buffer".Month = 12 then begin
                //     monthText := 'December';
                // end else monthText := '';
            end;
        }
    }
    
/*     rendering
    {
        layout(PaymentVar)
        {
            Type = RDLC;
            LayoutFile = 'Layouts/MemberPaymentVariances.rdlc';
        }
    } */
    
    var
    myInt: Integer;
    monthText: Text[50];
}
