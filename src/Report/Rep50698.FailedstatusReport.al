report 50698 "Failed status Report"
{
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'Layouts\Failed status Report.rdlc';

    dataset
    {
        dataitem("Standing Order Register";"Standing Order Register")
        {
            DataItemTableView = WHERE("Deduction Status"=FILTER(Failed));
            RequestFilterFields = Date;
            column(RegisterNo_StandingOrderRegister;"Standing Order Register"."Register No.")
            {
            }
            column(Date_StandingOrderRegister;"Standing Order Register".Date)
            {
            }
            column(AccountName_StandingOrderRegister;"Standing Order Register"."Account Name")
            {
            }
            column(Remarks_StandingOrderRegister;"Standing Order Register".Remarks)
            {
            }
            column(Amount_StandingOrderRegister;"Standing Order Register".Amount)
            {
            }
            column(StandingOrderNo_StandingOrderRegister;"Standing Order Register"."Standing Order No.")
            {
            }
            column(DeductionStatus_StandingOrderRegister;"Standing Order Register"."Deduction Status")
            {
            }
            column(SourceAccountNo_StandingOrderRegister;"Standing Order Register"."Source Account No.")
            {
            }
            column(DestinationAccountType_StandingOrderRegister;"Standing Order Register"."Destination Account Type")
            {
            }
            column(DestinationAccountName_StandingOrderRegister;"Standing Order Register"."Destination Account Name")
            {
            }
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
}

