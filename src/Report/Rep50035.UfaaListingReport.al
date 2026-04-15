report 50035 "Ufaa Listing Report"
{
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'Layouts\Ufaa Listing Report.rdlc';

    dataset
    {
        dataitem("UFAA Buffer"; "UFAA Buffer")
        {
            RequestFilterFields = Source, "Account Type";

            column(companyPicture; CompanyInfo.Picture)
            { }
            column(CompanyName; CompanyInfo.Name)
            { }
            column(CompanyAddress2; CompanyInfo."Address 2")
            { }
            column(CompanyAddress; CompanyInfo.Address)
            { }
            column(CompanyPhoneNo; CompanyInfo."Phone No.")
            { }
            column(CompanyEmail; CompanyInfo."E-Mail")
            { }
            column(No_UFAABuffer; "UFAA Buffer".No)
            {
            }
            column(MemberNo_UFAABuffer; "UFAA Buffer"."Member No")
            {
            }
            column(FOSAAccount_UFAABuffer; "UFAA Buffer"."FOSA Account")
            {
            }
            column(MobileNumber_UFAABuffer; "UFAA Buffer"."Mobile Number")
            {
            }
            column(IDNumber_UFAABuffer; "UFAA Buffer"."ID Number")
            {
            }
            column(WithdrawalNoticeDate_UFAABuffer; "UFAA Buffer"."Withdrawal Notice Date")
            {
            }
            column(Source_UFAABuffer; "UFAA Buffer".Source)
            {
            }
            column(Shares; "UFAA Buffer".Shares)
            { }
            column(Deposits_UFAABuffer; "UFAA Buffer".Deposits)
            {
            }
            column(Serial; Serial) { }
            column(FosaBalance_UFAABuffer; "UFAA Buffer"."Fosa Balance")
            {
            }
            column(SchoolFeesDeposits_UFAABuffer; "UFAA Buffer"."School Fees Deposits")
            {
            }
            column(Chamaa; "UFAA Buffer".Chamaa)
            { }
            column(Jibambe; "UFAA Buffer".Jibambe)
            { }
            column(Wezesha; "UFAA Buffer".Wezesha)
            { }
            column(FixedDep; "UFAA Buffer".FixedDep)
            { }
            column(Mdosi; "UFAA Buffer".Mdosi)
            { }
            column(PensionAkiba; "UFAA Buffer".PensionAkiba) { }
            column(BusinessAct; "UFAA Buffer".BusinessAct) { }
            column(AccountType_UFAABuffer; "UFAA Buffer"."Account Type")
            {
            }
            column(MembersName_UFAABuffer; "UFAA Buffer"."Members Name")
            {
            }
            column(LastTransactionDate_UFAABuffer; "UFAA Buffer"."Last Transaction Date")
            {
            }
            column(MemberPF_UFAABuffer; "UFAA Buffer"."Member PF")
            {
            }
            column(EmployerCode;"UFAA Buffer".EmployerCode)
            {}
            column(Withdrawal_Notice_Date;"Withdrawal Notice Date"){}
            column(Activity;Activity){}
            column(Last_Transact_Date_Ordinary;"Last Transact Date_Ordinary")
            {}
            column(Last_Ord_Transact_Description;"Last Ord Transact Description")
            {}
            column(Old_Last_Date;"Old Last Date")
            {}
            column(Old_Last_Description;"Old Last Description")
            {}
            // column()
            // {}

            trigger OnAfterGetRecord()
            var
                mem: Record Customer;
                ufaa: Record "UFAA Buffer";
            begin
                Serial := Serial + 1;

                mem.reset();
                mem.SetRange(mem."No.", ufaa."Member No");
                if mem.FindFirst() then begin
                    ufaa."Member No" := Mem."No.";
                    ufaa."Member PF" := Mem."Payroll No";
                    ufaa."Mobile Number" := Mem."Mobile Phone No";
                    ufaa."ID Number" := Mem."ID No.";
                    ufaa."Members Name" := Mem.Name;
                    ufaa.EmployerCode := Mem."Employer Code";
                end

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
        CompanyInfo.GET();
        CompanyInfo.CALCFIELDS(CompanyInfo.Picture);
    end;

    var
        CompanyInfo: Record "Company Information";
        Serial: integer;
}

