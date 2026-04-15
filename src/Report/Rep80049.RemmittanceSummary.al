namespace TelepostSacco.TelepostSacco;
using Microsoft.Purchases.Payables;
using Microsoft.Sales.Customer;
using Microsoft.Sales.Receivables;
using Microsoft.Purchases.Vendor;

report 80049 "Remmittance Summary"
{
    ApplicationArea = All;
    Caption = 'Remmittance Summary';
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = 'Layouts/RemmitanceSummary.RDLC';
    dataset
    {
        dataitem(EmployersRegister; "Employers Register")
        {
            column(Employees; Employees)
            {
            }
            column(EmployerCode; "Employer Code")
            {
            }
            column(EmployerName; "Employer Name")
            {
            }
            column(LoanRepayments; LoanRepayments)
            {
            }
            column(OrdContrib; OrdContrib)
            {
            }
            column(ESSContrib; ESSContrib)
            {
            }

            column(FDContrib; FDContrib)
            {
            }
            column(OtherFosaContrib; OtherFosaContrib)
            {
            }
            column(TotDepositContrib; TotDepositContrib)
            {
            }
            column(DepositContrib; DepositContrib)
            {
            }
            column(TotESSContrib; TotESSContrib)
            {
            }
            column(TotOrdContrib; TotOrdContrib)
            {
            }
            column(TotLoanRepayments; TotLoanRepayments)
            {
            }
            column(TotOtherFosaContrib; TotOtherFosaContrib)
            {
            }
            column(TotFDContrib; TotFDContrib)
            {
            }
            trigger OnPreDataItem()
            begin
                TotDepositContrib := 0;
                TotOrdContrib :=0;
                TotESSContrib :=0;
                TotOtherFosaContrib :=0;
                TotLoanRepayments:=0;
                TotFDContrib:=0;
            end;

            trigger OnAfterGetRecord()
            begin
                DepositContrib := 0;
                ESSContrib := 0;
                FDContrib := 0;
                OrdContrib := 0;
                OtherFosaContrib := 0;
                LoanRepayments := 0;
                TotalEmployer := 0;
                DateFilter := Format(CalcDate('-CM', AsAt)) + '..' + Format(CalcDate('CM', AsAt));

                Member.Reset();
                Member.SetCurrentKey("Employer Code");
                Member.SetRange(Member."Employer Code", "Employer Code");
                if Member.FindSet() then begin
                    repeat
                        Vend.Reset();
                        Vend.SetRange("BOSA Account No", Member."No.");
                        Vend.SetFilter("Account Type", '%1|%2|%3|%4|%5|%6|%7', '102', '103', '104', '106', '107', '108', '109');
                        if Vend.FindSet() then begin
                            repeat
                                VendL.Reset();
                                VendL.SetRange("Vendor No.", Vend."No.");
                                VendL.SetFilter("Document No.", 'SAL*');
                                VendL.SetRange("Ledger Entry Amount", true);
                                VendL.SetRange(Reversed, false);
                                VendL.SetFilter(VendL."Posting Date", '%1..%2', CalcDate('-CM', AsAt), CalcDate('CM', AsAt));
                                if VendL.FindSet() then begin
                                    VendL.CalcSums(Amount);
                                    case Vend."Account Type" of
                                        '102':
                                            DepositContrib += (-VendL.Amount);
                                        '103':
                                            OrdContrib += (-VendL.Amount);
                                        '104':
                                            ESSContrib += (-VendL.Amount);
                                        '108':
                                            FDContrib += (-VendL.Amount);
                                        '106', '107', '109':
                                            OtherFosaContrib += (-VendL.Amount);
                                    end;


                                end;


                                VendL.Reset();
                                VendL.SetRange("Vendor No.", Vend."No.");
                                VendL.SetFilter(Description, '*Pay2FOSA');
                                VendL.SetRange("Ledger Entry Amount", true);
                                VendL.SetRange(Reversed, false);
                                VendL.SetFilter(VendL."Posting Date", '%1..%2', CalcDate('-CM', AsAt), CalcDate('CM', AsAt));
                                if VendL.FindSet() then begin
                                    VendL.CalcSums(Amount);
                                    case Vend."Account Type" of
                                        '102':
                                            DepositContrib += (-VendL.Amount);
                                        '103':
                                            OrdContrib += (-VendL.Amount);
                                        '104':
                                            ESSContrib += (-VendL.Amount);
                                        '108':
                                            FDContrib += (-VendL.Amount);
                                        '106', '107', '109':
                                            OtherFosaContrib += (-VendL.Amount);
                                    end;


                                end;
                            until Vend.Next() = 0;
                        end;



                        CustL.Reset();
                        CustL.SetRange(CustL."Customer No.", Member."No.");
                        CustL.Setfilter(CustL."Document No.", 'SAL*');
                        CustL.SetRange(CustL."Ledger Entry Amount", true);
                        CustL.SetRange(CustL.Reversed, false);
                        CustL.SetFilter(CustL."Transaction Type", '%1|%2|%3', CustL."Transaction Type"::Repayment, CustL."Transaction Type"::"Interest Paid", CustL."Transaction Type"::"Loan Penalty Paid");
                        CustL.SetFilter(CustL."Posting Date", '%1..%2', CalcDate('-CM', AsAt), CalcDate('CM', AsAt));
                        IF CustL.FindSet() then BEGIN
                            CustL.CalcSums(CustL.Amount);
                            LoanRepayments += (-CustL.Amount);
                        END;
                    until Member.Next() = 0;


                end;
                TotDepositContrib += DepositContrib;
                TotOrdContrib += OrdContrib;
                TotESSContrib += ESSContrib;
                TotOtherFosaContrib += OtherFosaContrib;
                TotLoanRepayments += LoanRepayments;
                TotFDContrib += FDContrib;
                TotalEmployer := DepositContrib + OrdContrib + ESSContrib + OtherFosaContrib + LoanRepayments;
                if TotalEmployer = 0 then
                    CurrReport.Skip();
            end;
        }
    }
    requestpage
    {

        layout
        {
            area(content)
            {
                group("Please Select")
                {
                    field(AsAt; AsAt)
                    {
                    ApplicationArea = All;
                    }


                }
            }
        }

        actions
        {
        }
    }
    var
        VendL: Record "Detailed Vendor Ledg. Entry";

        CustL: Record "Detailed Cust. Ledg. Entry";
        Vend: Record Vendor;

        DepositContrib: Decimal;

        ESSContrib: Decimal;

        FDContrib: Decimal;

        OrdContrib: Decimal;

        OtherFosaContrib: Decimal;

        AsAt: Date;

        LoanRepayments: Decimal;

        TotalBalances: Decimal;

        Member: Record Customer;

        DateFilter: Text[40];

        TotDepositContrib: Decimal;

        TotESSContrib: Decimal;

        TotFDContrib: Decimal;

        TotOrdContrib: Decimal;

        TotLoanRepayments: Decimal;
        TotOtherFosaContrib: Decimal;

        TotalEmployer: Decimal;
}



