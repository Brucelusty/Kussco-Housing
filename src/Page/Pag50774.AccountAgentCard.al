//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50774 "Account Agent Card"
{
    ApplicationArea = All;
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    SourceTable = "Account Agent Details";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Document No";Rec."Document No")
                {
                }
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
                field("Mobile No.";Rec."Mobile No.")
                {
                }
                field("Email Address";Rec."Email Address")
                {
                }
                field("ID No.";Rec."ID No.")
                {
                }
                field("Date Of Birth";Rec."Date Of Birth")
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
                field("Allow Cheque Processing";Rec."Allow Cheque Processing")
                {
                }
                field("Operation Instruction";Rec."Operation Instruction")
                {
                }
                field("Expiry Date";Rec."Expiry Date")
                {
                }
            }
        }
        area(factboxes)
        {
            part(Control2; "Account Agent Picture-Uploaded")
            {
                Caption = 'Picture';
                SubPageLink = "Document No" = field("Document No");
            }
            part(Control1; "Account AgenSignatory-Uploaded")
            {
                Caption = 'Signature';
                SubPageLink = "Document No" = field("Document No");
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




