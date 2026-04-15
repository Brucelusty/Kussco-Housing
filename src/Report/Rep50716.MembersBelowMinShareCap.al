report 50716 "Members Below Min. Share Cap"
{
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = 'Layouts/MembersBelowMinShareCapital.rdlc';
    
    dataset
    {
        dataitem(Vendor;Vendor)
        {
            DataItemTableView = sorting("No.") where("Account Type" = const('101'), Balance = filter(<18000));
            RequestFilterFields = Status;
            column(Name;Name)
            {}
            column(Member_No;"BOSA Account No")
            {}
            column(No_;"No.")
            {}
            column(Personal_No_;"Personal No.")
            {}
            column(Status;Status)
            {}
            column(Balance;Balance)
            {}
            column(company_Name;company.Name)
            {}
            column(company_Picture;company.Picture)
            {}
            column(company_Address;company.Address)
            {}
            column(company_Email;company."E-Mail")
            {}
            column(company_Phone;company."Phone No.")
            {}
            // column()
            // {}

            trigger OnAfterGetRecord()
            begin
                // bal:= 0;
                // vend.Reset();
                // vend.SetRange("Account Type", '101');
                // vend.SetFilter(Balance, '<%1', minShareCap);
                // if vend.FindSet() then
                // begin
                //     repeat
                //         memberName:= vend.Name;
                //         memberNo:= vend."BOSA Account No";
                //         fosaNo:= vend."No.";
                //         payroll:= vend."Personal No.";
                //         bal:= vend.Balance;
                //     until vend.Next() = 0;
                // end;
            end;
        }
    }
    trigger OnInitReport()
    begin
        company.Get();
        company.CalcFields(Picture);
        saccoGen.Get();
        minShareCap := 0;
        minShareCap := saccoGen."Retained Shares";
    end;

    var
    myInt: Integer;
    minShareCap: Decimal;
    bal: Decimal;
    memberName: Text[250];
    memberNo: Code[20];
    fosaNo: Code[20];
    payroll: Code[20];
    company: Record "Company Information";
    vend: Record Vendor;
    cust: Record Customer;
    saccoGen: Record "Sacco General Set-Up";
}
