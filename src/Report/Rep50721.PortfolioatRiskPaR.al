report 50721 "Portfolio at Risk_PaR"
{
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = 'Layouts/PARReport.rdlc';
    // ProcessingOnly = true;
    
    dataset
    {
        dataitem("PAR Table";"PAR Table")
        {
            RequestFilterFields = "Loan Product";
            column(Total_Performing;"Total Performing")
            {}
            column(Total_Watch;"Total Watch")
            {}
            column(Total_Substandard;"Total Substandard")
            {}
            column(Total_Doubtful;"Total Doubtful")
            {}
            column(Total_Loss;"Total Loss")
            {}
            column(Performing_Provision;"Performing Provision")
            {}
            column(Watch_Provision;"Watch Provision")
            {}
            column(Substandard_Provision;"Substandard Provision")
            {}
            column(Doubtful_Provision;"Doubtful Provision")
            {}
            column(Loss_Provision;"Loss Provision")
            {}
            column(Total_Loan;"Total Loan")
            {}
            column(Total_Provisioning;"Total Provisioning")
            {}
            column(PAR_Ratio;"PAR Ratio")
            {}
            column(Loan_Product;"Loan Product")
            {}
            column(loanTypename;loanTypename)
            {}
            // column()
            // {}
            trigger OnAfterGetRecord() begin
                if loanTypes.Get("PAR Table"."Loan Product") then begin
                    loanTypename:= loanTypes."Product Description";
                end;
            end;
        }
    }
    
    var
    myInt: Integer;
    loanTypename: Text[250];
    loanTypes: Record "Loan Products Setup";
}
