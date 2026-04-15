report 50647 CustomerDormantAccounts
{
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = 'Layouts/CustomersDormantAccounts.rdlc';

    dataset
    {
        dataitem(Customer; Customer)
        {
            DataItemTableView = sorting("No.") where(isnormalmember = filter(true), status = filter(Active | Dormant));
            RequestFilterFields = "No.", Status;
            column(FORMAT_TODAY_0_4_; format(Today, 0, 4)) { }
            column(Companyname; CompanyName) { }
            column(CompanyAddress; TheCompany.Address) { }
            column(CompanyAddress2; TheCompany."Address 2") { }
            column(Company_PhoneNo; TheCompany."Phone No.") { }
            column(Company_Email; TheCompany."E-Mail") { }
            column(CompanyPicture; TheCompany.Picture) { }
            column(No; Customer."No.") { }
            column(Serial; Serial) { }
            Column(Name; Customer.Name) { }
            column(Status; Customer."Membership Status") { }
            column(Current_Shares; Customer."Current Shares") { }
            column(Employer_Code; "Employer Code")
            {
            }
            column(Payroll_No; "Payroll No")
            {
            }
            column(ReportTitle; ReportTitle) { }

            trigger OnAfterGetRecord()
            begin
                Serial := Serial + 1;
                // SetsUp.Get();
                // OurCust.Reset();
                // OurCust.SetRange(OurCust."No.", "No.");
                // if OurCust.Find('-') then begin
                //     OurCust.CalcFields(OurCust."Last Payment Date");
                //     if OurCust."Member Last Transaction Date" <> 0D then begin
                //         TheDormantDate := CalcDate(SetsUp."Max. Non Contribution Periods", OurCust."Last Payment Date");
                //         if TheDormantDate < CurrentDate then begin
                //             Customer.Status := Status::Dormant;
                //             OurCust.Modify();
                //         end;

                //         if OurCust."Last Payment Date" = 0D then begin
                //             Customer.Status := Status::Dormant;
                //             Modify();
                //         end;
                //         if TheDormantDate > CurrentDate then begin
                //             Customer.Status := Status::Active;
                //             Modify();
                //         end;
                //     end
                // end;
            end;

            trigger OnPreDataItem()
            begin
                if CurrentDate = 0D then
                    CurrentDate := Today;
                TheDateFilter := '..' + format(CurrentDate);
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

        trigger OnOpenPage()
        begin

        end;
    }
    trigger OnInitReport()
    begin
        TheCompany.Get;
        TheCompany.CalcFields(Picture);
    end;

    trigger OnPostReport()
    begin

    end;

    trigger onPreReport()
    begin

    end;

    var
        Serial: integer;
        SetsUp: Record "Sacco General Set-Up";
        OurCust: Record Customer;
        CurrentDate: Date;
        TheDateFilter: Text[30];
        TheDormantDate: date;
        TheCompany: Record "Company Information";

        ReportTitle: Label 'Transaction Status Report';
        myInt: Integer;
}



