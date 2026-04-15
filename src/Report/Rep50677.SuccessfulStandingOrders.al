report 50677 "Successful Standing Orders"
{
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = 'Layouts\SuccessfulStandingOrder.rdlc';

    dataset
    {
        dataitem("Standing Order Register"; "Standing Order Register")
        {
            RequestFilterFields = "Deduction Status";
            // DataItemTableView = sorting("Register No.")where("Deduction Status"=filter(Successfull | "Partial Deduction" ));
            column(Register_No_; "Register No.")
            {
            }
            column(Source_Account_No_; "Source Account No.")
            {
            }
            column(Staff_Payroll_No_; "Staff/Payroll No.")
            {
            }
            column(Account_Name; "Account Name")
            {
            }
            column(Destination_Account_Type; "Destination Account Type")
            {
            }
            column(Deduction_Status; "Deduction Status")
            {
            }
            column(Standing_Order_No_; "Standing Order No.")
            {
            }
            column(companyname; companyname)
            {
            }
            column(companypicture; CompanyInfo.Picture)
            {
            }
            column(TheVariance; TheVariance)
            {
            }
            column(deductiontype; sto."Standing Order Dedution Type")
            { }

            trigger OnPreDataItem()

            begin
                if CurrentDate = 0D then
                    CurrentDate := Today;
                DateFilter := '..' + format(CurrentDate);
            end;

            trigger OnAfterGetRecord()
            var
                StandingOrder: Record "Standing Orders";
                OrderReg: Record "Standing Order Register";
            begin
                StandingOrder.Reset();
                StandingOrder.SetRange(StandingOrder."No.", OrderReg."Register No.");
                if "Deduction Status" = "Deduction Status"::"Partial Deduction" then begin
                    if StandingOrder.Find('-') then begin
                        TheVariance := Amount - "Amount Deducted";
                    end;
                end;
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
        CompanyInfo.Get();
        CompanyInfo.CalcFields(CompanyInfo.Picture);
    end;

    var
        CurrentDate: Date;
        DateFilter: Text[30];
        CompanyInfo: Record "Company Information";
        TheVariance: Decimal;
        sto: Record "Standing Orders";
}



