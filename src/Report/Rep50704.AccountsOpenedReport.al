report 50704 "Accounts Opened Report"
{
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'Layouts\Accounts Opened Report.rdlc';

    dataset
    {
        dataitem("FOSA Account Applicat. Details";"FOSA Account Applicat. Details")
        {
            DataItemTableView = sorting(Name) where("Account Type" = filter(105|106|107|108|109|110|111), created = filter(true), status = filter(Approved));
            RequestFilterFields = "Registration Date";
            column(Personal_No_;"Staff No")
            {
            }
            column(Name_Accounts;Name)
            {
            }
            column(No_Accounts;"No.")
            {
            }
            column(AccountType_Accounts;"Account Type Name")
            {
            }
            column(Status_Accounts;Status)
            {
            }
            // column(SmsNotification_Accounts;"Sms Notification")
            // {
            // }
            column(RecruitedBy_Accounts;"Recruited By")
            {
            }
            column(ApplicationDate_Accounts;SystemCreatedAt)
            {
            }
            column(ApprovedBy_Accounts;"Created By")
            {
            }
            column(PhoneNo_Accounts;"Phone No.")
            {
            }
            column(MobilePhoneNo_Accounts;"Mobile Phone No")
            {
            }
            column(Monthly_Contribution;"Monthly Contribution")
            {}
            column(Employer_Code;"Employer Code")
            {}
            // column(FixedDeposit_Accounts;"Fixed Deposit")
            // {
            // }
            column(CompName;CompInfo.Name)
            {
            }
            column(CompAddress;CompInfo.Address)
            {
            }
            column(CompCity;CompInfo.City)
            {
            }
            column(CompPicture;CompInfo.Picture)
            {
            }
            column(BOSA_Account_No;"BOSA Account No")
            {

            }
            column(CreatedBy_Accounts;"Created By")
            {
            }
            trigger OnAfterGetRecord()
            var
                fosa: Record "FOSA Account Applicat. Details";
                Vend: record Vendor;
            begin
                // fosa.reset();
                // fosa.SetRange(Name, Vend.Name);
                // if fosa.FindSet() then begin
                //    "Created By" := fosa."Created By";
                //    "Recruited By" := fosa."Recruited By";
                //    "Monthly Contribution" := fosa."Monthly Contribution";
                //    "Staff No" := Vend."Personal No.";
                // end;
            end;
                   
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        CompInfo.GET();
        CompInfo.CALCFIELDS(CompInfo.Picture);
    end;

    var
        CompInfo: Record "Company Information";
        fosa: Record "FOSA Account Applicat. Details";
}

