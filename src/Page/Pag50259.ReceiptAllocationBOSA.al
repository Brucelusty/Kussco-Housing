//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50259 "Receipt Allocation-BOSA"
{
    ApplicationArea = All;
    PageType = ListPart;
    SourceTable = "Receipt Allocation";
    Caption = 'Member Receipt Allocation';

    layout
    {
        area(content)
        {
            repeater(Control1102760000)
            {
                field("STO Account Type"; Rec."STO Account Type")
                {
                    visible = true;
                    Caption = 'Account Type';
                }

                field("Member No"; Rec."Member No")
                {
                    Caption = 'Account No';
                }
                field("Account Type Name"; Rec."Account Type Name")
                {
                    Editable = false;
                    Caption = 'Account Type';
                    //Visible = false;
                }
                field("Destination Acount Name"; Rec."Destination Acount Name")
                {
                    Editable = false;
                }
                field("STO Transaction Type"; Rec."STO Transaction Type") { Visible = false;  }
                field("Transaction Type"; Rec."Transaction Type")
                {
                    //Editable = false;
                    // Visible=false;

                    OptionCaption = '';
                    trigger OnValidate()
                    begin
                        if (Rec."Transaction Type" <> Rec."transaction type"::" ") then begin
                            Rec."Account Type" := Rec."account type"::Customer
                        end else
                            Rec."Account Type" := Rec."account type"::Vendor;
                    end;
                }
                field(Description; Rec.Description)
                {
                }
                field("Loan No."; Rec."Loan No.")
                {
                }
                field(Amount; Rec.Amount)
                {
                }
                field("Document No";Rec."Document No")
                {
                    Editable=false;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Account Type" := Rec."account type"::Member;
    end;

    trigger OnOpenPage()
    begin
 

    end;

    var
        sto: Record "Standing Orders";
        Loan: Record "Loans Register";
        ReceiptAllocation: Record "Receipt Allocation";
        ReceiptH: Record "Receipts & Payments";
}






