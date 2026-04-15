page 51066 "Portfolio at Risk"
{
    ApplicationArea = All;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "PAR Table";
    CardPageId = "Portfolio at Risk Card";
    Editable = false;
    PromotedActionCategories = 'New,Report,Process,PAR';
    
    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                
                field("Loan Product";Rec."Loan Product")
                {
                }
                field("Total Performing";Rec."Total Performing")
                {
                }
                field("Performing Provision";Rec."Performing Provision")
                {
                }
                field(Performing;Rec.Performing)
                {
                    Style = Favorable;
                }
                field("Total Watch";Rec."Total Watch")
                {
                }
                field("Watch Provision";Rec."Watch Provision")
                {
                }
                field(Watch;Rec.Watch)
                {
                }
                field("Total Substandard";Rec."Total Substandard")
                {
                }
                field("Substandard Provision";Rec."Substandard Provision")
                {
                }
                field(Substandard;Rec.Substandard)
                {
                    Style = AttentionAccent;
                }
                field("Total Doubtful";Rec."Total Doubtful")
                {
                }
                field("Doubtful Provision";Rec."Doubtful Provision")
                {
                }
                field(Doubtful;Rec.Doubtful)
                {
                    Style = Attention;
                }
                field("Total Loss";Rec."Total Loss")
                {
                }
                field("Loss Provision";Rec."Loss Provision")
                {
                }
                field(Loss;Rec.Loss)
                {
                    Style = Unfavorable;
                }
                field("Total Loan";Rec."Total Loan")
                {
                }
                field("Total Provisioning";Rec."Total Provisioning")
                {
                }
                field("PAR Ratio";Rec."PAR Ratio")
                {
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
                Image = CalculateCost;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedOnly = true;
                
                trigger OnAction()
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
                        parTable.Init();
                        parTable.No := 1;
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
                        if not parTable.Insert then parTable.Modify;
                    end;
                end;
            }
            action("Generate Report")
            {
                Image = Report2;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedOnly = true;
                RunObject = report "Portfolio at Risk_PaR";
            }
            action("Loan Grading Report")
            {
                Image = SelectReport;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedOnly = true;
                RunObject = report "Loan Grading";
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
}


