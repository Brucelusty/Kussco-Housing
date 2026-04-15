//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50772 "Account Agent App Card"
{
    ApplicationArea = All;
    PageType = Card;
    SourceTable = "Account Agents App Details";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Account No";Rec."Account No")
                {
                }
                field("BOSA No.";Rec."BOSA No.")
                {
                    Caption = 'Agent Member No';
                }
                field(Names; Rec.Names)
                {
                    Caption = 'Agent Name';
                }
                field("ID No.";Rec."ID No.")
                {
                }
                field("Mobile No.";Rec."Mobile No.")
                {
                }
                field("Email Address";Rec."Email Address")
                {
                }
                field("Date Of Birth";Rec."Date Of Birth")
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
                field(Designation; Rec.Designation)
                {
                }
            }
        }
        area(factboxes)
        {
            part(Control7; "Account Agent Picture-App")
            {
                Caption = 'Picture';
            }
            part(Control8; "Account Agent Signature-App")
            {
                Caption = 'Signature';
            }
        }
    }

    actions
    {
    }
}






