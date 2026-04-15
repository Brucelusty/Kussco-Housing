page 65716 "Sacco Setup"
{
    ApplicationArea = All;
    PageType = Card;
    SourceTable = "Sacco Setup";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No.";Rec."No.")
                {
                }
                field("Excise Duty G/L"; rec."Excise Duty G/L")
                {
                }
                field("Excise Duty (%)"; rec."Excise Duty (%)")
                {
                }
                                field("Sacco SMS Income GL"; rec."Sacco SMS Income GL")
                {
                    Caption='Investment SMS Income GL';
                }
                field("Sacco SMS Expense GL"; rec."Sacco SMS Expense GL")
                {
                    Caption='Investment SMS Expense GL';
                }
                field("Mobile Vendor Account"; rec."Mobile Vendor Account")
                {
                }

                field("Vendor SMS Split Amount"; rec."Vendor SMS Split Amount")
                {
                }
                field("Maximum Mobile Loan Limit"; rec."Maximum Mobile Loan Limit")
                {
                     Visible=false;
                }
                field("Minimum Share Capital"; rec."Minimum Share Capital")
                {
                }
                field("Initial Loan Limit"; rec."Initial Loan Limit")
                {
                     Visible=false;
                }
                field("Defaulter Initial Limit"; rec."Defaulter Initial Limit")
                {
                     Visible=false;
                }
                field("Loan Increment"; rec."Loan Increment")
                {
                     Visible=false;
                }
                field("Defaulter Loan Increment"; rec."Defaulter Loan Increment")
                {
                     Visible=false;
                }
                field("Loan Penalty %"; rec."Loan Penalty %")
                {
                    Visible=false;
                }
                field("SMS Sender ID"; rec."SMS Sender ID")
                {
                }
                field("SMS Sender Name"; rec."SMS Sender Name")
                {
                }
                field("Virtual Members Images Path"; rec."Virtual Members Images Path")
                {
                    Visible=false;
                }
                field("Loan Interest Expense GL"; rec."Loan Interest Expense GL")
                {
                }
                field("Mbanking Application Name"; rec."Mbanking Application Name")
                {
                }
                field("USSD Code"; rec."USSD Code")
                {
                }
                field("MBanking Application Nos"; rec."MBanking Application Nos")
                {
                    Visible=false;
                }
                field("Max Posting Attempts"; rec."Max Posting Attempts")
                {
                    Visible=false;
                }
            }
        }
    }

    actions
    {
    }
}




