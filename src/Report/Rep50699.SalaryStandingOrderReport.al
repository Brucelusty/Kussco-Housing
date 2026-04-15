report 50699 "Salary Standing Order Report"
{
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'Layouts\Salary Standing Order Report.rdlc';

    dataset
    {
        dataitem("Standing Orders";"Standing Orders")
        {
            DataItemTableView = SORTING("Staff/Payroll No.")
                                ORDER(Ascending)
                                WHERE(Status=CONST(Approved),
                                     "Standing Order Dedution Type"=FILTER(Salary|Pension));
            RequestFilterFields = "Effective/Start Date","End Date","Destination Account No.";
            column(CompanyPic;CompanyInformation.Picture)
            {
            }
            column(CompanyName;CompanyInformation.Name)
            {
            }
            column(No_StandingOrders;"Standing Orders"."No.")
            {
            }
            column(SourceAccountNo_StandingOrders;"Standing Orders"."Source Account No.")
            {
            }
            column(StaffPayrollNo_StandingOrders;"Standing Orders"."Staff/Payroll No.")
            {
            }
            column(AccountName_StandingOrders;"Standing Orders"."Account Name")
            {
            }
            column(BOSAAccountNo_StandingOrders;"Standing Orders"."BOSA Account No.")
            {
            }
            column(EffectiveStartDate_StandingOrders;"Standing Orders"."Effective/Start Date")
            {
            }
            column(EndDate_StandingOrders;"Standing Orders"."End Date")
            {
            }
            column(Status_StandingOrders;"Standing Orders".Status)
            {
            }
            column(Filters;Filters)
            {
            }
            column(TheCount;TheCount)
            {
            }
            column(DocumentNo;DocumentNo)
            {
            }
            column(Amount_StandingOrders;"Standing Orders".Amount)
            {
            }
            dataitem("Receipt Allocation";"Receipt Allocation")
            {
                DataItemLink = "Document No"=FIELD("No.");
                column(MemberNo_ReceiptAllocation;"Receipt Allocation"."Member No")
                {
                }
                column(TransactionType_ReceiptAllocation;"Receipt Allocation"."Transaction Type")
                {
                }
                column(LoanNo_ReceiptAllocation;"Receipt Allocation"."Loan No.")
                {
                }
                column(Amount_ReceiptAllocation;"Receipt Allocation".Amount)
                {
                }
                column(AmtReceived;AmtReceived)
                {
                }
                column(Variance;Variance)
                {
                }

                trigger OnAfterGetRecord()
                var
                    MemberLedger: Record "Member Ledger Entry";
                begin
                    ///MESSAGE('%1',DocumentNo);
                    AmtReceived := 0;
                    MemberLedger.RESET;
                    MemberLedger.SETRANGE(MemberLedger."Customer No.","Receipt Allocation"."Member No");
                    MemberLedger.SETRANGE(MemberLedger."Transaction Type","Receipt Allocation"."Transaction Type");
                    MemberLedger.SETRANGE(MemberLedger."Document No.",DocumentNo);
                    MemberLedger.SETRANGE(MemberLedger.Reversed,FALSE);
                    MemberLedger.SETFILTER(MemberLedger."Credit Amount",'>0');
                    IF MemberLedger.FINDFIRST THEN BEGIN
                       MemberLedger.CALCSUMS("Credit Amount");
                       AmtReceived := MemberLedger."Credit Amount";
                      END;

                    Variance := "Receipt Allocation".Amount - AmtReceived;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                TheCount := TheCount +1;
            end;

            trigger OnPreDataItem()
            begin
                CompanyInformation.GET;
                CompanyInformation.CALCFIELDS(CompanyInformation.Picture);
                IF DocumentNo='' THEN
                  ERROR('Document no must have a value!');
                "Standing Orders".SETFILTER("Standing Orders"."Staff/Payroll No.",COPYSTR(DocumentNo,1,3)+'*');
                Filters := "Standing Orders".GETFILTERS;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Filters)
                {
                    field("Document No";DocumentNo)
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

    labels
    {
    }

    var
        CompanyInformation: Record "Company Information";
        DocumentNo: Code[20];
        AmtReceived: Decimal;
        Filters: Text;
        Variance: Decimal;
        TheCount: Integer;
}




