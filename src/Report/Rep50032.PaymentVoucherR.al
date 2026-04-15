report 50032 "Payment Voucher R"
{
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = 'Layouts/PaymentVoucherN.rdlc';


    dataset
    {
        dataitem("Payments Header "; "Payments Header")
        {
            column(No_; "No.") { }
            column(Date; Date) { }

            column(Paying_Type; "Paying Type") { }
            column(Paying_Bank_Account; "Paying Bank Account") { }
            column(Payee; Payee) { }
            column(Payment_Narration; "Payment Narration") { }
            column(Cheque_No_; "Cheque No.") { }

            column(Payment_Release_Date; "Payment Release Date") { }
            column(Total_Payment_Amount; "Total Payment Amount") { }

            column(CompanyInformation_Pic; CompanyInformation.Picture) { }
            column(CompanyInformation_address; CompanyInformation.Address) { }
            column(CompanyInformation_Phone; CompanyInformation."Phone No.") { }
            column(CompanyInformation_name; CompanyInformation.Name) { }
            column(CompanyInformation_Address2; CompanyInformation."Address 2") { }
            column(CompanyInformation_homepage; CompanyInformation."Home Page") { }
            column(CompanyInformation_Email; CompanyInformation."E-Mail") { }


            dataitem("Payment Line"; "Payment Line")
            {
                DataItemLink = "No" = field("No.");
                column(LineDocNo; No) { }
                column(Account_Type; "Account Type") { }
                column(Account_No_; "Account No.") { }
                column(Account_Name; "Account Name") { }

                column(LineNarration; Remarks) { }
                column(Amount; Amount) { }




            }
            trigger OnPreDataItem()
            begin
                CompanyInformation.Get();
                CompanyInformation.CalcFields(Picture);
            end;
        }

    }

    // requestpage
    // {
    //     layout
    //     {
    //         area(Content)
    //         {
    //             group(GroupName)
    //             {
    //                 field(Name; SourceExpression)
    //                 {

    //                 }
    //             }
    //         }
    //     }

    // actions
    // {
    //     area(processing)
    //     {
    //         action(ActionName)
    //         {

    //         }
    //     }
    // }
    //  }



    var
        myInt: Integer;
        CompanyInformation: Record "Company Information";
}
