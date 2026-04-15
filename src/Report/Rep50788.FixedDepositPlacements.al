report 50788 "Fixed Deposit Placements"
{
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    DefaultRenderingLayout = DepositPlacements;
    
    dataset
    {
        dataitem("Fixed Deposit Placement";"Fixed Deposit Placement")
        {
            column(Fixed_Deposit_No_;"Fixed Deposit No.")
            {}
            column(Member_No;"Member No")
            {}
            column(Member_Name;"Member Name")
            {}
            column(Fixed_Deposit_Account_No;"Fixed Deposit Account No")
            {}
            column(Amount_to_Fix;"Amount to Fix")
            {}
            column(Fixed_Deposit_Start_Date;"Fixed Deposit Start Date")
            {}
            column(Fixed_Duration;"Fixed Duration")
            {}
            column(Application_Date;"Application Date")
            {}
            column(FD_Interest_Rate;"FD Interest Rate")
            {}
            column(Created_On;"Created On")
            {}
            column(Created_By;"Created By")
            {}
            column(Date_Effected;"Date Effected")
            {}
            column(Fixed_Deposit_Type;"Fixed Deposit Type")
            {}
            column(Expected_Interest_Earned;"Expected Interest Earned")
            {}
            column(Expected_Tax_After_Term_Period;"Expected Tax After Term Period")
            {}
            column(Expected_Net_After_Term_Period;"Expected Net After Term Period")
            {}
            column(FD_Maturity_Date;"FD Maturity Date")
            {}
            column(Maturity_Instructions;"Maturity Instructions")
            {}
            column(Closed;Closed)
            {}
            column(FD_Closed_By;"FD Closed By")
            {}
            column(FD_Closed_On;"FD Closed On")
            {}
            // column()
            // {}
            column(company_Name;company.Name)
            {}
            column(company_Picture;company.Picture)
            {}
        }
    }
    
    requestpage
    {
        AboutTitle = 'Teaching tip title';
        AboutText = 'Teaching tip content';
    }
    
    rendering
    {
        layout(DepositPlacements)
        {
            Type = RDLC;
            LayoutFile = 'Layouts\DepositPlacements.rdlc';
        }
    }

    trigger OnInitReport() begin
        company.Get();
        company.CalcFields(Picture);
    end;
    
    var
    myInt: Integer;
    company: Record "Company Information";
}
