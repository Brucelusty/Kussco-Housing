report 50000 "Member Accounts Bal Listing"
{
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = 'Layouts/FullMemberAccountsBalListing.RDLC';

    dataset
    {
        dataitem(Vendor; Vendor)
        {
            RequestFilterFields = "BOSA Account No", "Account Type", "Global Dimension 2 Code";//Change this code to the actual one
            PrintOnlyIfDetail = false;
            column(BOSA_Account_No; "BOSA Account No")
            {

            }
            column(No__; "No.")
            {

            }
            column(Name; Name)
            {

            }
            column(Account_Type; "Account Type")
            {

            }
            column(Account_Type_Name; "Account Type Name")
            {

            }
            column(Status; Status)
            {

            }
            column(branch; "Global Dimension 2 Code")
            {

            }
            column(Member_Type; "Member Type")
            {

            }
            column(Post_Code; "Post Code")
            {

            }
            column(Mobile_Phone_No; "Mobile Phone No")
            {

            }
            column(Monthly_Contribution; "Monthly Contribution")
            {

            }
            column(Balance; Balance)
            {

            }
            column(contrFreq; format(contrFreq))
            {

            }
            column(LastPostedDate; LastPostedDate)
            {

            }
            column(Address; Address)
            {

            }
            column(Customer_Next_of_Kin; "Customer Next of Kin")
            {

            }
            column(lastTransactDate; lastTransactDate)
            {

            }
            // dataitem(Customer;Customer)
            // {
            //     DataItemLink = "No." = field("BOSA Account No");

            //     column(Has_Next_of_Kin;"Has Next of Kin")
            //     {

            //     }
            // }
            trigger
            OnAfterGetRecord()
            begin
                VendorNo := "No.";
                VendorLedgerEntry.Reset();
                vendorLedgerEntry.SetRange("Vendor No.", VendorNo);
                vendorLedgerEntry.SetRange("Posting Date", 0D, Today);
                VendorLedgerEntry.SetCurrentKey("Vendor No.");
                vendorLedgerEntry.SetAscending("Posting Date", true);
                if vendorLedgerEntry.FindLast() then begin
                    LastPostedDate := vendorLedgerEntry."Posting Date";
                    //MESSAGE('The last posted date for vendor %1 is %2.', VendorNo, FORMAT(LastPostedDate));
                    lastTransactDate := LastPostedDate;
                end else begin
                    // Handle the case where no entries are found for the specified vendor
                    //MESSAGE('No ledger entries found for vendor %1.', VendorNo);
                end;
                if VendorLedgerEntry."Posting Group" = 'DEPOSITS' then begin
                    if VendorLedgerEntry.Find('-') then begin
                        repeat
                            contributionFreq := VendorLedgerEntry.Count();
                            contrFreq := contributionFreq;
                        until (VendorLedgerEntry.Next = 0);
                        //Message('The total count for %1 was %2.', VendorNo, contributionFreq);
                    end;
                end;
            end;

            trigger
            OnPreDataItem()
            begin


            end;
        }

    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(Options)
                {
                    caption = 'Options';
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
            currentDate: DateTime;
            contributionFreq: Integer;
            contrFreq: Integer;
            lastTransactDate: Date;
            vend: Record Vendor;
            dim: Record "Dimension Value";
            branch: Code[20];
            ObjAccountTypess: Record "Account Types-Saving Products";
            LastPostedDate: Date;
            VendorNo: Code[20];
            VendorLedgerEntry: Record "Detailed Vendor Ledg. Entry";

        trigger
        OnInitReport()
        begin
            currentDate := CurrentDateTime;
            // ObjAccountTypess.Get(Vendor."BOSA Account No");
            // branch := ObjAccountTypess.Branch;
        end;
    }


