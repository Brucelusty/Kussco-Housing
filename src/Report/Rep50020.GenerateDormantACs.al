//<---------------------------------------------------------------------->															


Report 50020 "Generate Dormant A|Cs"
{
    ApplicationArea = All;
    RDLCLayout = 'Layouts/GenerateDormantACs.rdlc';
    DefaultLayout = RDLC;
    UsageCategory = Tasks;
    ProcessingOnly = true;
    UseRequestPage = true;


    dataset
    {
        dataitem(Customer; Customer)
        {
            DataItemTableView = SORTING("No.") WHERE(isnormalmember = filter(true), Status = FILTER(Active | Dormant));
            RequestFilterFields = "No.";
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(COMPANYNAME; CompanyName)
            {
            }
            column(Company_Address; Company.Address)
            {
            }
            column(Company_Address2; Company."Address 2")
            {
            }
            column(Company_PhoneNo; Company."Phone No.")
            {
            }
            column(Company_Email; Company."E-Mail")
            {
            }
            column(Company_Picture; Company.Picture)
            {
            }
            column(CurrReport_PAGENO; CurrReport.PageNo)
            {
            }
            column(USERID; UserId)
            {
            }
            column(S_No; SN)
            {
            }
            column(No; Customer."No.")
            {
            }
            column(Name; Customer.Name)
            {
            }
            column(Current_Shares; Customer."Current Shares")
            {
            }

            trigger OnAfterGetRecord()
            begin
                /*                 GenSetup.Get();

                                Cust.Reset;
                                Cust.SetRange(Cust."No.", "No.");
                                if Cust.Find('-') then begin
                                    Cust.CalcFields(Cust."Member Last Transaction Date");
                                    if Cust."Member Last Transaction Date" <> 0D then begin
                                        DormancyDate := CalcDate(GenSetup."Max. Non Contribution Periods", Cust."Member Last Transaction Date");
                                        if DormancyDate > AsAt then begin
                                            Status := Status::Active;
                                            Modify;
                                        end;
                                        if DormancyDate < AsAt then begin
                                            Status := Status::Dormant;
                                            Modify;
                                        end;
                                    end;
                                end; */
            end;

            trigger OnPreDataItem()
            begin
                /*                 if AsAt = 0D then
                                    AsAt := Today;
                                DateFilter := '..' + Format(AsAt); */
            end;
        }
        // dataitem("Company Information"; "Company Information")
        // {
        //     //DataItemTableView = SORTING(ni) WHERE("Customer Type"=CONST(Member),Status=FILTER(Active|Dormant));
        //     column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
        //     {
        //     }
        //     column(COMPANYNAME; COMPANYNAME)
        //     {
        //     }
        //     column(Company_Address; Company.Address)
        //     {
        //     }
        //     column(Company_Address2; Company."Address 2")
        //     {
        //     }
        //     column(Company_PhoneNo; Company."Phone No.")
        //     {
        //     }
        //     column(Company_Email; Company."E-Mail")
        //     {
        //     }
        //     column(Company_Picture; Company.Picture)
        //     {
        //     }

        //     column(UserId; UserId)
        //     {
        //     }
        //     column(S_No; SN)
        //     {
        //     }
        //     trigger OnPreDataItem();
        //     begin
        //         IF AsAt = 0D THEN
        //             AsAt := TODAY;

        //     end;

        //     trigger OnAfterGetRecord();
        //     begin
        //         if AsAt <> 0D then begin
        //             SFactory.FnRunGetMembershipDormancyStatus(AsAt);
        //         end;
        //         Message('Executed Successfully');
        //     end;

        // }
    }

    requestpage
    {


        SaveValues = false;
        layout
        {
            area(content)
            {
                field(AsAt; AsAt)
                {
                    ApplicationArea = All;
                }

            }
        }

        actions
        {
        }
        trigger OnOpenPage()
        begin
            //:= false;															
        end;
    }

    trigger OnInitReport()
    begin
        Company.Get;
        Company.CalcFields(Picture);
        ;


    end;

    trigger OnPostReport()
    begin
        ;

    end;

    trigger OnPreReport()
    begin
        ;

    end;

    var
        Loans_RegisterCaptionLbl: label 'Approved Loans Report';
        SFactory: Codeunit "Au Factory";
        CurrReport_PAGENOCaptionLbl: label 'Page';
        Loan_TypeCaptionLbl: label 'Loan Type';
        Client_No_CaptionLbl: label 'Client No.';
        Outstanding_LoanCaptionLbl: label 'Outstanding Loan';
        PeriodCaptionLbl: label 'Period';
        Approved_DateCaptionLbl: label 'Approved Date';
        Loan_TypeCaption_Control1102760043Lbl: label 'Loan Type';

        Counter: Integer;
        Verified_By__________________________________________________CaptionLbl: label 'Verified By..................................................';
        Confirmed_By__________________________________________________CaptionLbl: label 'Confirmed By..................................................';
        Sign________________________CaptionLbl: label 'Sign........................';
        Sign________________________Caption_Control1102755003Lbl: label 'Sign........................';
        Date________________________CaptionLbl: label 'Date........................';
        Date________________________Caption_Control1102755005Lbl: label 'Date........................';
        NameCreditOff: label 'Name......................................';
        NameCreditDate: label 'Date........................................';
        NameCreditSign: label 'Signature..................................';
        NameCreditMNG: label 'Name......................................';
        NameCreditMNGDate: label 'Date.....................................';
        NameCreditMNGSign: label 'Signature..................................';
        NameCEO: label 'Name........................................';
        NameCEOSign: label 'Signature...................................';
        NameCEODate: label 'Date.....................................';
        CreditCom1: label 'Name........................................';
        CreditCom1Sign: label 'Signature...................................';
        CreditCom1Date: label 'Date.........................................';
        CreditCom2: label 'Name........................................';
        CreditCom2Sign: label 'Signature....................................';
        CreditCom2Date: label 'Date..........................................';
        CreditCom3: label 'Name.........................................';
        CreditComDate3: label 'Date..........................................';
        CreditComSign3: label 'Signature..................................';
        Comment: label '....................';
        SN: Integer;
        Company: Record "Company Information";
        GenSetup: Record "Sacco General Set-Up";
        Cust: Record Customer;
        AsAt: Date;
        DateFilter: Text[30];
        DormancyDate: Date;
}





