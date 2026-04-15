//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50848 "Member Agent Account Card"
{
    ApplicationArea = All;
    PageType = Card;
    SourceTable = "Member Agent Details";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Account No";Rec."Account No")
                {
                }
                field(Names; Rec.Names)
                {
                }
                field("Agent Serial No";Rec."Agent Serial No")
                {
                }
                field("Date Of Birth";Rec."Date Of Birth")
                {
                }
                field("Staff/Payroll";Rec."Staff/Payroll")
                {
                }
                field("ID No.";Rec."ID No.")
                {
                }
                field(Designation; Rec.Designation)
                {
                }
                field("Allowed Balance Enquiry";Rec."Allowed Balance Enquiry")
                {
                }
                field("Allowed  Correspondence";Rec."Allowed  Correspondence")
                {
                }
                field("Allowed FOSA Withdrawals";Rec."Allowed FOSA Withdrawals")
                {
                }
                field("Allowed Loan Processing";Rec."Allowed Loan Processing")
                {
                }
                field("Expiry Date";Rec."Expiry Date")
                {
                }
                field("BOSA No.";Rec."BOSA No.")
                {
                }
                field("Email Address";Rec."Email Address")
                {
                }
            }
        }
        area(factboxes)
        {
            part(Control1000000006;"M_Agent Picture-Uploaded")
            {
                Caption = 'Agent Picture';
                SubPageLink = "Account No" = field("Account No");
            }
            part(Control1000000007;"M_Agent Signature-Uploaded")
            {
                Caption = 'Agent Signature';
                SubPageLink = "Account No" = field("Account No");
            }
        }
    }

    actions
    {
    }

    trigger OnNextRecord(Steps: Integer): Integer
    begin
        //"Entry No":=10000+1;
    end;
}






