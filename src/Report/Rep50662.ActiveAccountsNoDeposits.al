report 50662 "Active Accounts No Deposits"
{
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = 'Layouts/ActiveNoDeposits.RDLC';

    dataset
    {
        dataitem(Vendor; Vendor)
        {
            DataItemTableView = sorting("No.") where(status = filter(Active), Balance = filter(= 0), "Account Type" = filter('102'));
            PrintOnlyIfDetail = false;
            column(BOSA_Account_No; "BOSA Account No")
            {

            }
            column(No_; "No.")
            { }
            column(Name; Name)
            { }
            column(Deposits_Contributed_Ver1; "Deposits Contributed Ver1")
            {

            }
            column(Balance; Balance)
            { }
            column(Last_DepositDate; lastTransactDate)
            {

            }
            column(Mode_Of_Remmittance; "Mode Of Remmittance")
            { }
            column(Months_No_Deposits; months)
            {

            }
            // trigger
            // OnAfterGetRecord();
            // begin
            //     Datefilter := '01012000' + '..' + Format(asAt);
            //     //MESSAGE(Datefilter);															
            //     ven.Reset;
            //     ven.SetRange(ven."No.", Vendor."No.");
            //     ven.SetFilter(ven."Last Date Modified", Datefilter);
            //     if ven.FindSet then begin
            //         months:= Round((asAt - ven."Last Date Modified")/30, 1, '<');
            //     end;
            // end;
            trigger
            OnAfterGetRecord();
            begin
                Datefilter := '01012000' + '..' + Format(asAt);
                VendorNo := "No.";
                VendorLedgerEntry.Reset();
                vendorLedgerEntry.SetRange("Vendor No.", VendorNo);
                vendorLedgerEntry.SetFilter("Posting Date", datefilter);
                if VendorLedgerEntry."Posting Group" = 'DEPOSITS' then begin
                    if vendorLedgerEntry.FindFirst() then begin
                        LastPostedDate := vendorLedgerEntry."Posting Date";
                        lastTransactDate := LastPostedDate;
                    end;
                    months := Round((asAt - lastTransactDate) / 30, 1, '>');
                end;
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                field(asAt; asAt)
                {
                    ApplicationArea = All;

                }
            }
        }
    }

    // rendering
    // {
    //     layout(LayoutName)
    //     {
    //         Type = Excel;
    //         LayoutFile = 'mySpreadsheet.xlsx';
    //     }
    // }

    var
        myInt: Integer;
        months: Decimal;
        asAt: Date;
        ven: Record vendor;
        datefilter: Text;
        dim: Record "Dimension Value";
        branch: Code[20];
        vendorledgerentry: Record "Detailed Vendor Ledg. Entry";
        vendorNo: Code[20];
        lastposteddate: Date;
        lastTransactDate: Date;


    trigger
    OnInitReport()
    begin

    end;
    // trigger
    // OnPreReport()
    // begin
    //     if ven.Get(Vendor."BOSA Account No")
    //     then
    //     begin
    //         months:= (asAt - ven."Last Date Modified")/30;
    //         Message(Format(months));
    //     end;
    // end;
}



