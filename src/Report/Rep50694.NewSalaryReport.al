report 50694 "NewSalary Report"
{
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'Layouts\New Sal  Report.rdlc';

    dataset
    {
        dataitem("Sacco Employers";"Sacco Employers")
        {
            RequestFilterFields = "Code";
            RequestFilterHeading = 'Employer';
            column(Membername;Membername)
            {
            }
            dataitem(Vendor;Vendor)
            {
                DataItemLink = "Territory Code"=FIELD(Code);
                column(StaffNo_Vendor;Vendor."Payroll/Staff No2")
                {
                }
                column(No_Vendor;Vendor."No.")
                {
                }
                column(Name_Vendor;Vendor.Name)
                {
                }
                column(Amount;Amount)
                {
                }
                column(empty;empty)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    Amount:=0;
                    empty:='';
                    VendorLedgerEntry.RESET;
                    VendorLedgerEntry.SETRANGE(VendorLedgerEntry."Vendor No.",Vendor."No.");
                    VendorLedgerEntry.SETFILTER(VendorLedgerEntry."Posting Date",'%1..%2',Lastmonthstartdate,Lastmonthenddate);
                    VendorLedgerEntry.SETRANGE(VendorLedgerEntry.Description,'Salary');
                    VendorLedgerEntry.SETFILTER(VendorLedgerEntry."Credit Amount",'>%1',0);
                    IF VendorLedgerEntry.FINDFIRST THEN BEGIN
                       VendorLedgerEntry.CALCFIELDS(VendorLedgerEntry.Amount);
                      Amount:=-1*VendorLedgerEntry.Amount;
                       VendorLedgerEntry2.RESET;
                       VendorLedgerEntry2.SETRANGE(VendorLedgerEntry2."Vendor No.",Vendor."No.");
                      // VendorLedgerEntry2.SETFILTER(VendorLedgerEntry2."Posting Date",'%1..%2',"Salary Date","Salary Date2");
                       VendorLedgerEntry2.SETFILTER(VendorLedgerEntry2."Posting Date",'<>%1&<>%2',"Salary Date","Salary Date2");
                       VendorLedgerEntry2.SETRANGE(VendorLedgerEntry2.Description,'Salary');
                       VendorLedgerEntry2.SETFILTER(VendorLedgerEntry2."Credit Amount",'>%1',0);
                       IF VendorLedgerEntry2.FINDFIRST THEN BEGIN
                         CurrReport.SKIP;
                         END;
                      END ELSE
                      CurrReport.SKIP;

                end;
            }

            trigger OnPreDataItem()
            begin
                Lastmonth:=CALCDATE('-1M',"Salary Date");
                Lastmonthstartdate:=CALCDATE('-CM',Lastmonth);
                Lastmonthenddate:=CALCDATE('-1D',"Salary Date");
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field("Salary Date";"Salary Date")
                {
                    Caption = 'Date of Salary From';
                    ApplicationArea = All;
                }
                field("Salary Date2";"Salary Date2")
                {
                    Caption = 'Date of Salary To';
                    ApplicationArea = All;
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
        "Salary Date": Date;
        Vendor2: Record "Vendor";
        VendorLedgerEntry: Record "Vendor Ledger Entry";
        Lastmonthstartdate: Date;
        Lastmonthenddate: Date;
        VendorLedgerEntry2: Record "Vendor Ledger Entry";
        Lastmonth: Date;
        Membername: Text;
        pfno: Text;
        Employer: Code[100];
        Amount: Decimal;
        "Salary Date2": Date;
        empty: Text;
}




