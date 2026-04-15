//************************************************************************
tableextension 50009 "GLaccountExt" extends "G/L Account"
{

    fields
    {
        // Add changes to table fields here
        field(50018; "Budget Controlled"; Boolean)
        {
        }
        field(50019; "Expense Code"; Code[10])
        {
            TableRelation = "Expense Code";

            trigger OnValidate()
            begin
                //Expense code only applicable if account type is posting and Budgetary control is applicable
                TestField("Account Type", "account type"::Posting);
                TestField("Budget Controlled", true);
            end;
        }
        field(50020; "Donor defined Account"; Boolean)
        {
            Description = 'Select if the Account is donor Defined';
        }
        field(50000; test; Code[20])
        {
        }
        field(50001; "Grant Expense"; Boolean)
        {
        }
        field(50002; Status; Option)
        {
            Editable = true;
            OptionMembers = New,"Pending Approval",Approved,Rejected;
        }
        field(50003; "Responsibility Center"; Code[20])
        {
            //TableRelation = Table55929.Field1;
        }
        field(50004; "Old No."; Code[200])
        {
        }
        field(50005; "Date Created"; Date)
        {
        }
        field(50006; "Created By"; Code[70])
        {
        }
        field(50007; "Capital adequecy"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = '  ,ShareCapital,StatutoryReserve,RetainedEarnings,NetSurplusaftertax,LoansandAdvances,Cash,InvestmentsinSubsidiary,Otherreserves,GovernmentSecurities,DepositsandBalancesatOtherInstitutions,OtherAssets,PropertyandEquipment,TotalDepositsLiabilities,GeneralReserves';
            OptionMembers = "  ",ShareCapital,StatutoryReserve,RetainedEarnings,NetSurplusaftertax,LoansandAdvances,Cash,InvestmentsinSubsidiary,Otherreserves,GovernmentSecurities,DepositsandBalancesatOtherInstitutions,Otherassets,PropertyandEquipment,TotalDepositsLiabilities,GeneralReserves;
        }
        field(50008; "Form2F(Statement of C Income)"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = '  ,InterestonLoanPortfolio,FeesCommissiononLoanPortfolio,GovernmentSecurities,InvestmentinCompaniesshares,nterestExpenseonDeposits,DividendExpenses,OtherFinancialExpense,FeesCommissionExpense,OtherExpense,ProvisionforLoanLosses,PersonnelExpenses,GovernanceExpenses,MarketingExpenses,DepreciationandAmortizationCharges,AdministrativeExpenses,Taxes,NonOperatingIncome,NonOperatingExpense,Donations,PlacementinBanks,CostofExternalBorrowings,EquityInvestmentsinsubsidiaries,Derivatives';
            OptionMembers = "  ",InterestonLoanPortfolio,FeesCommissiononLoanPortfolio,GovernmentSecurities,InvestmentinCompaniesshares,nterestExpenseonDeposits,DividendExpenses,OtherFinancialExpense,FeesCommissionExpense,OtherExpense,ProvisionforLoanLosses,PersonnelExpenses,GovernanceExpenses,MarketingExpenses,DepreciationandAmortizationCharges,AdministrativeExpenses,Taxes,NonOperatingIncome,NonOperatingExpense,Donations,PlacementinBanks,CostofExternalBorrowings,EquityInvestmentsinsubsidiaries,Derivatives;
        }
        field(50009; "Form2F1(Statement of C Income)"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = '  ,PersonnelExpenses,GovernanceExpenses,MarketingExpenses,DepreciationandAmortizationCharges,AdministrativeExpenses,Taxes,NonOperatingIncome,NonOperatingExpense,Donations,PlacementinBanks,CostofExternalBorrowings,EquityInvestmentsinsubsidiaries';
            OptionMembers = "  ",PersonnelExpenses,GovernanceExpenses,MarketingExpenses,DepreciationandAmortizationCharges,AdministrativeExpenses,Taxes,NonOperatingIncome,NonOperatingExpense,Donations,PlacementinBanks,CostofExternalBorrowings,EquityInvestmentsinsubsidiaries;
        }
        field(50010; "Form2E(investment)"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Core_Capital,Nonearningassets,totaldeposits,subsidiaryandrelatedentities,Equityinvestment,Otherinvestments,otherassets';
            OptionMembers = " ",Core_Capital,Nonearningassets,totaldeposits,subsidiaryandrelatedentities,Equityinvestment,Otherinvestments,otherassets;
        }
        field(50011; "Form2E(investment)New"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Nonearningassets';
            OptionMembers = " ",Nonearningassets;
        }
        field(50012; "Form2E(investment)Land"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,LandBuilding';
            OptionMembers = " ",LandBuilding;
        }
        field(50013; Liquidity; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,TotalOtherliabilitiesNew,TimeDeposits,balanceswithotherfinancialinsti,GovSecurities,BankBalances,LocalNotes,OverdraftsandMaturedLoans,BalanceswithotherSaccoSocieties,MaturedLiabilities';
            OptionMembers = " ",TotalOtherliabilitiesNew,TimeDeposits,balanceswithotherfinancialinsti,GovSecurities,BankBalances,LocalNotes,OverdraftsandMaturedLoans,BalanceswithotherSaccoSocieties,MaturedLiabilities;
        }
        field(50014; StatementOfFP; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = '  ,Cashinhand,Cashatbank,GrossLoanPortfolio,PropertyEquipment,AllowanceforLoanLoss,PrepaymentsSundryReceivables,Investmentincompanies,Other Assets,IntangibleAssets,ExternalBorrowings,Placement,EquityInvestments,DividendPayable,CurrentYearSurplus,Nonwithdrawabledeposits,ShareCapital,PrioryarRetainedEarnings,StatutoryReserve,OtherReserves,RevaluationReserves,TaxPayable,OtherLiabilities,WithdrawableFOSASavings,ShortTermDeposits';
            OptionMembers = "  ",Cashinhand,Cashatbank,GrossLoanPortfolio,PropertyEquipment,AllowanceforLoanLoss,PrepaymentsSundryReceivables,Investmentincompanies,"Other Assets",IntangibleAssets,ExternalBorrowings,Placement,EquityInvestments,DividendPayable,CurrentYearSurplus,Nonwithdrawabledeposits,ShareCapital,PrioryarRetainedEarnings,StatutoryReserve,OtherReserves,RevaluationReserves,TaxPayable,OtherLiabilities,WithdrawableFOSASavings,ShortTermDeposits;
        }
        field(50015; StatementOfFP2; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Nonwithdrawabledeposits,ShareCapital,PrioryarRetainedEarnings,StatutoryReserve,OtherReserves,RevaluationReserves,TaxPayable,OtherLiabilities';
            OptionMembers = " ",Nonwithdrawabledeposits,ShareCapital,PrioryarRetainedEarnings,StatutoryReserve,OtherReserves,RevaluationReserves,TaxPayable,OtherLiabilities;
        }
        field(50016; "Form 2H other disc"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Core_Cpital,Liquidity,Depositliabilites,Otherliablilities,CoreCapitalDeduction,AllowanceForLoanLoss';
            OptionMembers = " ",Core_Cpital,Liquidity,Depositliabilites,Otherliablilities,CoreCapitalDeduction,AllowanceForLoanLoss;
        }
        field(50017; "Member No"; Code[60])
        {
            DataClassification = ToBeClassified;

        }

    }

    trigger OnInsert()
    begin
        userSetup.Reset();
        userSetup.Get(UserId);
        if userSetup."Can Edit Chart Of Accounts" = false then begin
            Error('The user %1 does not have permissions to create a G/L Account.', UserId);
        end;
    end;

    trigger OnDelete()
    var
        myInt: Integer;
    begin
        Error('Account can not be deleted.');
    end;

    trigger OnModify()
    begin
        userSetup.Reset();
        userSetup.Get(UserId);
        if userSetup."Can Edit Chart Of Accounts" = false then begin
            Error('The user %1 does not have permissions to edit the chart of accounts.', UserId);
        end;
    end;

    var
        myInt: Integer;
        userSetup: Record "User Setup";
}


