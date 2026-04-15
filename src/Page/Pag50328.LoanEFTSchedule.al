//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50328 "Loan EFT Schedule"
{
    ApplicationArea = All;
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "Loans Register";
    SourceTableView = where("Bank Account No" = filter(<> ''),
                            Posted = const(true));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Staff No";Rec."Staff No")
                {
                    Caption = 'Ref No';
                }
                field("Client Code";Rec."Client Code")
                {
                }
                field("Loan Product Type";Rec."Loan Product Type")
                {
                }
                field("Loan Product Type Name";Rec."Loan Product Type Name")
                {
                }
                field("Client Name";Rec."Client Name")
                {
                }
                field("Beneficiary Account";Rec."Bank Account No")
                {
                }
                field("Bank code";Rec."Bank code")
                {
                }
                field("Bank Branch";Rec."Bank Branch")
                {
                }
                field("Net Disbursed";Rec."Loan Disbursed Amount")
                {
                }
                field("Loan Disbursement Date";Rec."Loan Disbursement Date")
                {
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    var
        ObjLoanProductCharges: Record "Loan Product Charges";
    begin
        GenSetUp.Get;
        Upfronts := 0;
        "Net Disbursed" := 0;
        ProductChargesAmount := 0;
        ObjLoanProductCharges.Reset;
        ObjLoanProductCharges.SetRange(ObjLoanProductCharges."Product Code", Rec."Loan Product Type");
        if ObjLoanProductCharges.Find('-') then begin


            if ObjLoanProductCharges."Use Perc" then begin
                ProductChargesAmount := ProductChargesAmount + ((ObjLoanProductCharges.Percentage * Rec."Approved Amount") / 100);

            end
            else
                ProductChargesAmount := ProductChargesAmount + ObjLoanProductCharges.Amount;
        end;

        Rec.CalcFields("Loan Offset Amount", "Offset Commission");
        Upfronts := Rec."Loan Offset Amount" + Rec."Offset Commission" + GenSetUp."Loan Trasfer Fee-Cheque" +
       Rec. "Boosted Amount" + Rec."Deposit Reinstatement" + ProductChargesAmount + Rec."Share Capital Due";
        "Net Disbursed" := Rec."Approved Amount" - Upfronts;
    end;

    var
        "Net Disbursed": Decimal;
        Upfronts: Decimal;
        GenSetUp: Record "Sacco General Set-Up";
        ProductChargesAmount: Decimal;
}






