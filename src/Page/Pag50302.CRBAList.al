//************************************************************************
Page 50302 "CRBA List"
{
    ApplicationArea = All;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "CRBA Datas";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(No; Rec.No)
                {
                }
                field(Surname; Rec.Surname)
                {
                }
                
                field("Forename 1";Rec."Forename 1")
                {
                }
                field("Forename 2";Rec."Forename 2")
                {
                }
                field("Forename 3";Rec."Forename 3")
                {
                }
                field("Trading As";Rec."Trading As")
                {

                }
                field("Date of Birth";Rec."Date of Birth")
                {
                }
                field("Client Code";Rec."Client Code")
                {
                }
                field("Account Number";Rec."Account Number")
                {
                }
                field("Old Account No.";Rec."Old Account No.")
                {
                }
                field(Gender; Rec.Gender)
                {
                }
                field(Nationality; Rec.Nationality)
                {
                }
                field("Marital Status 2";Rec."Marital Status 2")
                {
                }
                field("Primary Identification 1";Rec."Primary Identification Code")
                {
                }
                field("Primary Identification 2";Rec."Primary Identification 1")
                {
                }
                field("Secondary Identification code";Rec."Secondary Identification code")
                {
                }
                field("Secondary Identification 1";Rec."Secondary Identification 1")
                {
                }
                field("Other Identification Type";Rec."Other Identification Type")
                {
                }
                field("Other Identification Code";Rec."Other Identification Code")
                {
                }
                field("Passport Country Code";Rec."Passport Country Code")
                {
                }
                field("Mobile No";Rec."Mobile No")
                {
                }
                field("Home Telephone";Rec."Home Telephone")
                {
                }
                field("Work Telephone";Rec."Work Telephone")
                {
                }
                field("Postal Address 1";Rec."Postal Address 1")
                {
                }
                field("Postal Address 2";Rec."Postal Address 2")
                {
                }
                field("Postal Location Town";Rec."Postal Location Town")
                {
                }
                field("Postal Location Country";Rec."Postal Location Country")
                {
                }
                field("Post Code";Rec."Post Code")
                {
                }
                field("Physical Address 1";Rec."Physical Address 1")
                {
                }
                field("Physical Address 2";Rec."Physical Address 2")
                {
                }
                field("Plot Number";Rec."Plot Number")
                {
                }
                field("Location Town";Rec."Location Town")
                {
                }
                field("Location Country";Rec."Location Country")
                {
                }
                field("Type of Residence";Rec."Type of Residence")
                {
                }
                field("PIN Number";Rec."PIN Number")
                {
                }
                field("Customer Work Email";Rec."Customer Work Email")
                {
                }                
                field("Employer Name";Rec."Employer Name")
                {
                }
                field("Occupational Industry Type";Rec."Occupational Industry Type")
                {
                }
                field("Employment Type";Rec."Employment Type")
                {
                }
                field("Employment Date";Rec."Employment Date")
                {
                }
                field("Income Amount";Rec."Income Amount")
                {
                }
                field("Lenders Registered Name";Rec."Lenders Registered Name")
                {
                }
                field("Lenders Trading Name";Rec."Lenders Trading Name")
                {
                }
                field("Lenders Branch Name";Rec."Lenders Branch Name")
                {
                }
                field("Lenders Branch Code";Rec."Lenders Branch Code")
                {
                }
                field("Joint Single Indicator";Rec."Joint Single Indicator")
                {
                    Caption = 'Account Type';
                }
                field("Account Product Type";Rec."Account Product Type")
                {
                }
                field("Date Account Opened";Rec."Date Account Opened")
                {
                }
                field("Installment Due Date";Rec."Installment Due Date")
                {
                }
                field("Original Amount";Rec."Original Amount")
                {
                }
                field("Currency of Facility";Rec."Currency of Facility")
                {
                }
                field("Amount in Kenya shillings";Rec."Amount in Kenya shillings")
                {
                }
                field("Current Balance";Rec."Current Balance")
                {
                }
                field("Overdue Balance";Rec."Overdue Balance")
                {
                }
                field("Overdue Date";Rec."Overdue Date")
                {
                }
                field("No of Days in Arreas";Rec."No of Days in Arreas")
                {
                }
                field("No of Installment In";Rec."No of Installment In")
                {
                }
                field("Prudential Risk Classification";Rec."Prudential Risk Classification")
                {
                }
                field("Account Status";Rec."Account Status")
                {
                }
                field("Account Status Date";Rec."Account Status Date")
                {
                }
                field("Account Closure Reason";Rec."Account Closure Reason")
                {
                }
                field("Repayment Period";Rec."Repayment Period")
                {
                }
                field("Deferred Payment Date";Rec."Deferred Payment Date")
                {
                }
                field("Deferred Payment";Rec."Deferred Payment")
                {
                }
                field("Payment Frequency";Rec."Payment Frequency")
                {
                }
                field("Disbursement Date";Rec."Disbursement Date")
                {
                }
                field("Insallment Amount";Rec."Insallment Amount")
                {
                }
                field("Date of Latest Payment";Rec."Date of Latest Payment")
                {
                }
                field("Last Payment Amount";Rec."Last Payment Amount")
                {
                }
                field("Type of Security";Rec."Type of Security")
                {
                }
            }
        }
    }

    actions
    {

        area(Processing)
        {
            action("Generate CRB list")
            {
                Image = Report;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = report "CRB Report Old NAV";

                trigger OnAction()
                begin

                end;
            }

            action("CRB list")
            {
                Image = Excel;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = report "CRB Report(Processed)";

                trigger OnAction()
                begin

                end;
            }
        }
    }
}






