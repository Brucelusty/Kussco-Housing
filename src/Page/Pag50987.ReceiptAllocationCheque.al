//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50987 "Receipt Allocation Cheque"
{
    ApplicationArea = All;
    PageType = ListPart;
    SourceTable = "Receipt Allocation";

    layout
    {
        area(content)
        {
            repeater(Control1102760000)
            {
                field("STO Account Type";Rec."STO Account Type")
                {
                    visible = true;
                }
               
                field("Account Type"; Rec."Account Type")
                {
                    //Editable=false;
                }
                field("Member No"; Rec."Member No")
                {
                    Caption = 'Account No';
                }
                field("Destination Acount Name";Rec."Destination Acount Name")
                {
                   //Editable=false;
                }
                field("STO Transaction Type";Rec."STO Transaction Type"){}
                field("Transaction Type"; Rec."Transaction Type")
                {
                  //  Editable=false;

                    OptionCaption = '';
                    trigger OnValidate()
                    begin
                        if (Rec."Transaction Type" <> Rec."transaction type"::" ") and (Rec."Transaction Type" <> Rec."transaction type"::" ") then begin
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
        /*sto.RESET;
        sto.SETRANGE(sto."No.","Document No");
        IF sto.FIND('-') THEN BEGIN
        IF sto.Status=sto.Status::Approved THEN BEGIN
        CurrPage.EDITABLE:=FALSE;
        END ELSE
        CurrPage.EDITABLE:=TRUE;
        END;
        */

    end;

    var
        sto: Record "Standing Orders";
        Loan: Record "Loans Register";
        ReceiptAllocation: Record "Receipt Allocation";
        ReceiptH: Record "Receipts & Payments";
}






