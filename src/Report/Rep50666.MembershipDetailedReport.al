report 50666 "Membership Detailed Report"
{
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = 'Layouts/MemberDetailedReport.rdlc';

    dataset
    {
        dataitem(Customer; Customer)
        {
            RequestFilterFields = "No.", "Membership Status", "Registration Date", "Current Shares", "Employer Code", "Date Filter";
            CalcFields = "Current Shares", "Shares Retained", "Customer Principal Balance";
            DataItemTableView = where(IsNormalMember = filter(true));
            column(No_; "No.")
            {
            }
            column(Format_to_today; Format(Today, 0, 4)) { }

            column(Name; Name)
            {
            }
            column(Employer_Code; "Employer Code")
            {
            }
            column(Payroll_No; "Payroll No")
            {
            }
            column(ID_No_; "ID No.")
            {
            }
            column(Pin; Pin)
            {
            }
            column(Phone_No_; "Phone No.")
            {
            }
            column(Mobile_Phone_No; "Mobile Phone No")
            {
            }
            column(E_Mail; "E-Mail")
            {
            }
            column(Registration_Date; "Registration Date")
            {
            }
            column(Recruited_By; "Recruited By")
            {
            }
            column(LoansTotal; LoansTotal)
            {
            }
            column(Monthly_Contribution; "Monthly Contribution")
            {
            }
            column(Current_Shares; "Current Shares")
            {
            }
            column(Shares_Retained; "Shares Retained")
            {
            }
            column(Outstanding_Balance; "Outstanding Balance")
            {
            }
            column(Gender; Gender)
            {
            }
            column(Date_Of_Birth; "Date Of Birth")
            {
            }
            column(Principle_Balance; "Customer Principal Balance")
            {
            }
            column(Status; Status)
            {
            }
            column(Membership_Status; "Membership Status")
            {
            }
            column(Age; Age)
            {
            }
            column(Retirement_Date; "Retirement Date")
            {
            }
            column(Last_Payment_Date; "Last Payment Date")
            {
            }
            column(CompanyName; CompanyName)
            {
            }
            column(CompanyAddress2; CompanyAbt."Address 2")
            { }
            column(CompanyAddress; CompanyAbt.Address)
            { }
            column(CompanyPhoneNo; CompanyAbt."Phone No.")
            { }
            column(CompanyEmail; CompanyAbt."E-Mail") { }
            column(Picture; CompanyAbt.Picture)
            {
            }
            column(Member_Deposits; "Member Deposits")
            {

            }
            column(Referee_ID_No; "Referee ID No")
            { }
            column(Referee_Name; "Referee Name") { }
            column(Serial; Serial) { }
            column(Reffered_By_Member_No; "Reffered By Member No")
            { }
            column(Reffered_By_Member_Name; "Reffered By Member Name") { }
            column(RefPayrollNo; RefPayrollNo) { }
            column(CustomerServiceRep; CustomerServiceRep) { }


            trigger OnAfterGetRecord()
            var
                Cust: Record Customer;

            begin
                Serial := Serial + 1;

                Cust.Reset();
                Cust.SetRange("No.", Customer."Reffered By Member No");
                if Cust.Find('-') then begin
                    RefPayrollNo := Cust."Payroll No";
                end else begin
                    RefPayrollNo := '';
                end;

                Cust.Reset();
                Cust.SetRange("Payroll No", Customer."Sales Person");
                if Cust.Find('-') then begin
                    CustomerServiceRep := Cust."Name";
                end else begin
                    CustomerServiceRep := '';
                end;

            end;

            // trigger OnPreDataItem()
            // var
            //     DateFilter: Text[30];
            // begin
            //     Serial:=0;

            //     if CurrentDate = 0D then
            //         CurrentDate := Today;
            //     DateFilter := '..' + format(CurrentDate);
            // end;
        }

    }

    trigger OnInitReport()

    begin
        CompanyAbt.Get();
        CompanyAbt.CalcFields(Picture);

    end;


    var
        CompanyAbt: Record "Company Information";
        OurCust: Record Customer;
        CurrentDate: Date;
        LoansReg: Record "Loans Register";
        LoansTotal: Decimal;
        Datefilter: Date;
        Serial: integer;
        RefPayrollNo: code[20];
        CustomerServiceRep: Text[150];

}


