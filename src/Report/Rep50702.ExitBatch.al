report 50702 ExitBatch
{
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = 'Layouts\ExitBatch.rdlc';

    dataset
    {
        dataitem("Membership Exist"; "Membership Exist")
        {
            column(companyPicture; CompanyInfo.Picture)
            { }
            column(CompanyName; CompanyInfo.Name)
            { }
            column(CompanyAddress2; CompanyInfo."Address 2")
            { }
            column(CompanyAddress; CompanyInfo.Address)
            { }
            column(CompanyPhoneNo; CompanyInfo."Phone No.")
            { }
            column(Status; Status) { }
            column(authBy; authBy) { }
            column(prepBy; prepBy) { }
            // column(){}
            // column(){}
            // column(){}
            column(Mode_Of_Disbursement; "Mode Of Disbursement") { }
            column(Member_Name; "Member Name") { }
            column(Member_No_; "Member No.") { }
            column(Payroll_StaffNo; "Payroll/StaffNo") { }
            column(Member_Deposits; "Member Deposits") { }
            column(Amount_To_Disburse; "Amount To Disburse") { }
            column(Share_Capital; "Share Capital") { }
            column(SchoolFeesShares; SchoolFeesShares) { }
            column(Total_Loan; "Total Loan") { }
            column(Exit_Batch_No_; "Exit Batch No.") { }
            column(Exit_Notice_Date; "Exit Notice Date") { }
            column(Application_Date; "Application Date") { }
            column(Withdrawal_Fee; "Withdrawal Fee") { }
            column(NetRefun; NetRefun) { }
            column(Serial; Serial) { }
            trigger OnAfterGetRecord()
            var
                sacco: Record "Sacco General Set-Up";
                MemExit: Record "Membership Exist";
                exitBatch: Record "Member Exit Batch";
            begin
                Serial := Serial + 1;
                sacco.Get();
                "Withdrawal Fee" := Sacco."Withdrawal Fee";

                // MemExit.Reset();
                // MemExit.SetRange(MemExit."No.", "No.");
                // if memExit.FindSet() then begin
                //     // repeat
                //     // NetRefun := "Member Deposits" - "Withdrawal Fee";
                //     // until MemExit.Next() = 0;
                // end;

                exitBatch.Reset();
                exitBatch.SetRange("Exit Batch No.", "Membership Exist"."Exit Batch No.");
                if exitBatch.Find('-') then begin
                    prepBy := exitBatch."Prepared By";
                    authBy := exitBatch."Authorised By";
                end;

            end;


        }

    }


    trigger OnPreReport();
    begin
        CompanyInfo.Get();
        CompanyInfo.CalcFields(CompanyInfo.Picture);

    end;

    var
        myInt: Integer;
        CompanyInfo: Record "Company Information";
        Serial: integer;
        NetRefun: Decimal;
        prepBy: Code[20];
        authBy: Code[20];
}


