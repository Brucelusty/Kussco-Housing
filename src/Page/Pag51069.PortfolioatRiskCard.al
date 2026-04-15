page 51069 "Portfolio at Risk Card"
{
    ApplicationArea = All;
    PageType = Card;
    UsageCategory = Lists;
    SourceTable = "PAR Table";
    
    layout
    {
        area(Content)
        {
            Group(General)
            {
                field("Loan Product";Rec."Loan Product")
                {
                }
                field("Date of Generation";Rec."Date of Generation")
                {
                    Editable = false;
                }
                field("Time of Generation";Rec."Time of Generation")
                {
                    Editable = false;
                }
            }
            Group(Provisioning)
            {
                field("Total Performing";Rec."Total Performing")
                {
                    Editable = false;
                }
                field("Performing Provision";Rec."Performing Provision")
                {
                    Editable = false;
                }
                field("Total Watch";Rec."Total Watch")
                {
                    Editable = false;
                }
                field("Watch Provision";Rec."Watch Provision")
                {
                    Editable = false;
                }
                field("Total Substandard";Rec."Total Substandard")
                {
                    Editable = false;
                }
                field("Substandard Provision";Rec."Substandard Provision")
                {
                    Editable = false;
                }
                field("Total Doubtful";Rec."Total Doubtful")
                {
                    Editable = false;
                }
                field("Doubtful Provision";Rec."Doubtful Provision")
                {
                    Editable = false;
                }
                field("Total Loss";Rec."Total Loss")
                {
                    Editable = false;
                }
                field("Loss Provision";Rec."Loss Provision")
                {
                    Editable = false;
                }
                field("Total Loan";Rec."Total Loan")
                {
                    Editable = false;
                }
                field("Total Provisioning";Rec."Total Provisioning")
                {
                    Editable = false;
                }
                field("PAR Ratio";Rec."PAR Ratio")
                {
                    Editable = false;
                }
            }
        }
    }
    
    actions
    {
        area(Processing)
        {
            action(PAR)
            {
                ToolTip = 'Calculate the PAR Provisionings.';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                
                trigger OnAction()
                begin
                    PARperProduct(Rec."Loan Product");
                end;
            }
            action("Generate Report")
            {
                Promoted = true;
                PromotedCategory = Report;
                
                RunObject = report "Portfolio at Risk_PaR";
                trigger OnAction() begin
                    parTable.Reset();
                    parTable.SetRange("Loan Product", Rec."Loan Product");
                    if parTable.Find('-') then begin
                        Report.Run(175062, false, false, parTable);
                    end;
                end;
            }
        }
    }

    var
    totalLoan: Decimal;
    totalProv: Decimal;
    totalPAR: Decimal;
    outstandingBal: Decimal;
    totalLoansPerf: Decimal;
    totalLoansWatch: Decimal;
    totalLoansSub: Decimal;
    totalLoansDoubt: Decimal;
    totalLoansLoss: Decimal;
    perfProv: Decimal;
    watchProv: Decimal;
    substProv: Decimal;
    doubtProv: Decimal;
    lossProv: Decimal;
    PARRatio: Decimal;
    loansReg: Record "Loans Register";
   // parCode: Codeunit "PAR Test";
    PARvalues: array[30] of Decimal;
    parTable: Record "PAR Table";
    procedure PARperProduct(LoanType: Code[20])
    var
    begin
        outstandingBal:= 0;
        totalLoansPerf:= 0;
        totalLoansWatch:= 0;
        totalLoansSub:= 0;
        totalLoansDoubt:= 0;
        totalLoansLoss:= 0;
        perfProv:= 0;
        watchProv:= 0;
        substProv:= 0;
        doubtProv:= 0;
        lossProv:= 0;
        PARRatio:=- 0;

        loansReg.Reset();
        loansReg.SetRange("Loan Product Type", LoanType);
        loansReg.SetAutoCalcFields("Outstanding Balance");
        loansReg.SetFilter("Outstanding Balance", '>%1', 0);
        if loansReg.FindSet() then begin
            repeat
                if loansReg."Loans Category" = loansReg."Loans Category"::Perfoming then begin
                    totalLoansPerf:= totalLoansPerf + loansReg."Outstanding Balance";
                    totalLoansPerf:= totalLoansPerf;
                    perfProv:= Round(((totalLoansPerf)*(1/100)), 0.01, '=');
                end else if loansReg."Loans Category" = loansReg."Loans Category"::Watch then begin
                    totalLoansWatch:= totalLoansWatch + loansReg."Outstanding Balance";
                    totalLoansWatch:= totalLoansWatch;
                    watchProv:= Round(((totalLoansWatch)*(5/100)), 0.01, '=');
                end else if loansReg."Loans Category" = loansReg."Loans Category"::Substandard then begin
                    totalLoansSub:= totalLoansSub + loansReg."Outstanding Balance";
                    totalLoansSub:= totalLoansSub;
                    substProv:= Round(((totalLoansSub)*(25/100)), 0.01, '=');
                end else if loansReg."Loans Category" = loansReg."Loans Category"::Doubtful then begin
                    totalLoansDoubt:= totalLoansDoubt + loansReg."Outstanding Balance";
                    totalLoansDoubt:= totalLoansDoubt;
                    doubtProv:= Round(((totalLoansDoubt)*(50/100)), 0.01, '=');
                end else if loansReg."Loans Category" = loansReg."Loans Category"::Loss then begin
                    totalLoansLoss:= totalLoansLoss + loansReg."Outstanding Balance";
                    totalLoansLoss:= totalLoansLoss;
                    lossProv:= Round(totalLoansLoss, 0.01, '=');
                end;
            until loansReg.Next() = 0;

            totalLoan:= totalLoansPerf + totalLoansWatch + totalLoansSub + totalLoansDoubt + totalLoansLoss;
            totalProv:= perfProv + watchProv + substProv + doubtProv + lossProv;
            totalPAR:= totalLoansSub + totalLoansDoubt + totalLoansLoss;
            PARRatio:= Round(((totalPAR/totalLoan) * 100), 0.01, '=');

            parTable.Reset();
            parTable.SetRange("Loan Product", Rec."Loan Product");
            if parTable.Find('-') then begin
                parTable."Total Performing":= totalLoansPerf;
                parTable."Performing Provision":= perfProv;
                parTable."Total Watch":= totalLoansWatch;
                parTable."Watch Provision":= watchProv;
                parTable."Total Substandard":= totalLoansSub;
                parTable."Substandard Provision":= substProv;
                parTable."Total Doubtful":= totalLoansDoubt;
                parTable."Doubtful Provision":= doubtProv;
                parTable."Total Loss":= totalLoansLoss;
                parTable."Loss Provision":= lossProv;
                parTable."Total Loan":= totalLoan;
                parTable."Total Provisioning":= totalProv;
                parTable."PAR Ratio":= PARRatio;
                parTable."Date of Generation":= Today;
                parTable."Time of Generation":= Time;
                parTable.Modify;
            end;
            // parTable.No := 1;
            // parTable."Loan Product":= Rec."Loan Product";
        end;
    end;
}


