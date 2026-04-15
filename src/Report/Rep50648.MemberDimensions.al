report 50648 MemberDimensions
{
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = 'Layouts\MemberDimensions.rdlc';


    dataset
    {
        dataitem(Customer; Customer)
        {
            CalcFields = "Current Shares";
            PrintOnlyIfDetail = false;
            RequestFilterFields = "No.", "Membership Status", Status, "Member Type", Name, Gender, Age, "Employer Code", "Retirement Date";
            DataItemTableView = where(IsNormalMember = filter(true));

            column(Format_to_today; Format(Today, 0, 4)) { }
            column(No_; "No.") { }
            column(ID_No_; "ID No.") { }
            column(Membership_Status; "Membership Status") { }
            column(Status; Status) { }
            column(Name; Name) { }
            column(Gender; Gender) { }
            column(Age; Age) { }
            column(Employer_Code; "Employer Code") { }
            column(Mobile_Phone_No; "Mobile Phone No") { }
            column(How_did_you_know_about_us_; "How did you know about us?") { }
            column(Reffered_By_Member_Name; "Reffered By Member Name") { }
            column(Referee_Member_No; "Referee Member No") { }
            column(Payroll_No; "Payroll No") { }
            column(Retirement_Date; "Retirement Date") { }
            column(companyname; CompanyName) { }
            column(companypicture; TheCompany.Picture) { }
            column(ReportTitle; ReportTitle) { }

            trigger OnAfterGetRecord()
            var
                MemberAge: Integer;
                DaysAge: Integer;
                YearsAge: Decimal;
                RetiresIn: Date;
                RetirementYear: Integer;
            begin
                MemberAge := Date2DMY(Today, 3);
                TheCust.Reset();
                TheCust.SetRange(TheCust."No.", "No.");
                TheCust.SetFilter(TheCust."Date Of Birth", '<>%1', 0D);
                if TheCust.FindSet() then begin
                    DaysAge := Today - "Date Of Birth";
                    // Message('Members Age in Days is %1', DaysAge);
                    YearsAge := DaysAge / 365;
                    Age := Format(Round(YearsAge, 1, '<'));
                    // Message('The Members age is %1', Age);
                end;

                // SaccoSetsUp.Reset();
                // SaccoSetsUp.SetFilter(SaccoSetsUp."Retirement Age", format(SaccoSetsUp."Retirement Age"));
                // if SaccoSetsUp.Find('-') then begin
                //     RetiresIn := CalcDate(SaccoSetsUp."Retirement Age", TheCust."Date Of Birth");
                //     "Retirement Date" := RetiresIn;
                // end;

            end;

            trigger OnPreDataItem()
            var
                DateFilter: Text[30];
            begin
                if CurrentDate = 0D then
                    CurrentDate := Today;
                DateFilter := '..' + format(CurrentDate);
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
                    field(CurrentDate; CurrentDate)
                    {
                        ApplicationArea = All;

                    }
                }
            }
        }
    }
    trigger OnInitReport()
    begin
        TheCompany.Get;
        TheCompany.CalcFields(Picture);
    end;

    var
        SaccoSetsUp: Record "Sacco General Set-Up";
        CurrentDate: Date;
        TheCust: Record Customer;
        TheAge: Decimal;
        TheCompany: Record "Company Information";
        ReportTitle: Label 'Member List Report';

}



