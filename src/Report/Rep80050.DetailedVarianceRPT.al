namespace TelepostSacco.TelepostSacco;
using Microsoft.Sales.Receivables;

report 80050 "Detailed Variance RPT"
{
    ApplicationArea = All;
    Caption = 'Detailed Variance RPT';
    DefaultLayout = RDLC;
    RDLCLayout = 'Layouts/DetailedVarianceRPT.rdlc';

    dataset
    {
        dataitem(SalHeader; "Salary Processing Headerr")
        {
            column(AccountName; "Account Name")
            {
            }
            column(AccountNo; "Account No")
            {
            }
            column(AccountType; "Account Type")
            {
            }
            column(Amount; Amount)
            {
            }
            column(DateEntered; "Date Entered")
            {
            }
            column(DocumentNo; "Document No")
            {
            }
            column(EmployerCode; "Employer Code")
            {
            }
            column(EnteredBy; "Entered By")
            {
            }
            column(No; No)
            {
            }
            column(NoSeries; "No. Series")
            {
            }
            column(Posted; Posted)
            {
            }
            column(PostedBy; "Posted By")
            {
            }
            column(Postingdate; "Posting date")
            {
            }
            column(Remarks; Remarks)
            {
            }
            column(ScheduledAmount; "Scheduled Amount")
            {
            }
            column(SystemCreatedAt; SystemCreatedAt)
            {
            }
            column(SystemCreatedBy; SystemCreatedBy)
            {
            }
            column(SystemId; SystemId)
            {
            }
            column(SystemModifiedAt; SystemModifiedAt)
            {
            }
            column(SystemModifiedBy; SystemModifiedBy)
            {
            }
            column(TimeEntered; "Time Entered")
            {
            }
            column(TotalCount; "Total Count")
            {
            }
            column(TransactionType; "Transaction Type")
            {
            }


            dataitem(Salines; "Salary Processing Lines")
            {
                DataItemLink = "Salary Header No." = field(no);//
                column(LineAmount; Amount)
                {

                }
                column(Member_No; "Member No")
                {

                }
                column(Account_No_; "Account No.")
                {

                }
                column(Expected_Amount; "Expected Amount")
                {

                }

                column(Amount_Deducted; "Amount Deducted")
                {

                }

                column(InterestDeducted; InterestDeducted)
                {

                }

                column(ExpectedInterest; ExpectedInterest)
                {

                }
                column(PrincipleDeducted; PrincipleDeducted)
                {

                }

                column(ExpectedPrinciple; ExpectedPrinciple)
                {

                }
                trigger OnAfterGetRecord()
                var
                    myInt: Integer;
                begin
                    InterestDeducted := 0;
                    PrincipleDeducted := 0;
                    DetCust.Reset();
                    DetCust.SetRange(DetCust."Customer No.", Salines."Member No");
                    DetCust.SetFilter(DetCust."Document No.", Salines."Salary Header No.");
                    DetCust.SetRange(DetCust."Transaction Type", DetCust."Transaction Type"::"Interest Paid");
                    if DetCust.FindSet() then begin
                        DetCust.CalcSums(DetCust.Amount);
                        InterestDeducted := -DetCust.Amount;
                    end;


                    DetCust.Reset();
                    DetCust.SetRange(DetCust."Customer No.", Salines."Member No");
                    DetCust.SetFilter(DetCust."Document No.", Salines."Salary Header No.");
                    DetCust.SetRange(DetCust."Transaction Type", DetCust."Transaction Type"::Repayment);
                    if DetCust.FindSet() then begin
                        DetCust.CalcSums(DetCust.Amount);
                        PrincipleDeducted := -DetCust.Amount;
                    end;


                    ExpectedPrinciple := 0;
                    ExpectedInterest := 0;
                    ExpectedInterest := SalCard.FnRunInterestExpectedAmountVariance(Salines);
                    ExpectedPrinciple := SalCard.FnRunPrincipleExpectedAmountVariance(Salines);
                end;
            }
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
                }
            }
        }
        actions
        {
            area(Processing)
            {
            }
        }
    }

    var
        InterestDeducted: Decimal;
        PrincipleDeducted: Decimal;
        DepositContributed: Decimal;

        DetCust: Record "Detailed Cust. Ledg. Entry";

        SalCard: Page "Salary Processing Header";


        ExpectedPrinciple: Decimal;

        ExpectedInterest: Decimal;


}


