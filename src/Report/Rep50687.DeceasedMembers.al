report 50687 DeceasedMembers
{
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout='Layouts/MembersDeceased.rdlc';
    
    dataset
    {
        dataitem(Customer;Customer)
        {
            DataItemTableView = where("Membership Status" = const(Deceased));
            RequestFilterFields = "No.", "Membership Status";
            column(Format_to_today; Format(Today, 0, 4)){}
            column(Name;Name){}
            column(Member_No;"Member No")
            {}
            column(Payroll_No;"Payroll No")
            {}
            column(Employer_Code;"Employer Code")
            {}
            column(ID_No_;"ID No.")
            {}
            column(Gender;Gender)
            {}
            
            column(Membership_Status;"Membership Status"){}
            column(Companyname; CompanyInfo.Name){}
            column(Companypicture; CompanyInfo.Picture){}
            column(CompanyAddress2; CompanyInfo."Address 2")
            {}
            column(CompanyAddress; CompanyInfo.Address)
            {}
            column(CompanyPhoneNo;CompanyInfo."Phone No.")
            {}
            column(CompanyEmail; CompanyInfo."E-Mail")
            {}
            column(ReportTitle;ReportTitle){}
            column(Current_Shares;"Current Shares")
            {}
            column(FOSA_Shares;"FOSA Shares")
            {}
        trigger OnAfterGetRecord()
        begin
            TheCust.Reset();
            TheCust.SetFilter(TheCust."Membership Status",'<>%1',TheCust."Membership Status"::Deceased);
            if TheCust.find('-') then 
            CurrReport.Skip();          
        end;
        }
    }
    

        trigger OnPreReport();															
            begin															
                CompanyInfo.Get();															
                CompanyInfo.CalcFields(CompanyInfo.Picture);


                if CurrentDate = 0D then
                    CurrentDate := Today;
                DateSFilter := '..' + format(CurrentDate);														
            end;

    
    var
        CurrentDate: Date;
        DatesFilter: Text[30]; 
        TheCust: Record Customer;
        CompanyInfo: Record "Company Information";
        ReportTitle: Label 'Deceased Members Report';
}



