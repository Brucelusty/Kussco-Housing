report 50676 "Member Status Change Request"
{
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = 'Layouts\MemberStatusChange.rdlc';


    dataset
    {
        dataitem("Change Request"; "Change Request")
        {
            DataItemTableView = where(Changed = filter(True));
            column(No; No)
            {
            }
            column(Status; Status)
            {
            }
            column(Capture_Date; "Capture Date")
            {
            }
            column(Approval_Date; "Approval Date")
            {
            }
            column(Captured_by; "Captured by")
            {
            }
            column(Approved_by; "Approved by")
            {
            }
            column(Type; Type)
            {
            }
            column(Reason_for_change; "Reason for change")
            {
            }
            column(Name; Name)
            {
            }
            column(Account_No; "Account No")
            {
            }
            column(Personal_No; "Personal No")
            {
            }
            column(CompanyName; CompanyName)
            {
            }
            column(companypicture; CompanyInfo.Picture)
            {
            }
            trigger OnPreDataItem()

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
        CompanyInfo.Get();
        CompanyInfo.CalcFields(CompanyInfo.Picture);
    end;

    var
        CurrentDate: Date;
        DateFilter: Text[30];
        CompanyInfo: Record "Company Information";
}



