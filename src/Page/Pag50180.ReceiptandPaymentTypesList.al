//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50180 "Receipt and Payment Types List"

{
    ApplicationArea = All;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "Receipts and Payment Types";

    layout
    {
        area(content)
        {
            repeater(Control1102758000)
            {
                field("Code"; Rec.Code)
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("Account Type"; Rec."Account Type")
                {
                }
                field(Type; Rec.Type)
                {
                }
                field("VAT Chargeable"; Rec."VAT Chargeable")
                {
                }
                field("Withholding Tax Chargeable"; Rec."Withholding Tax Chargeable")
                {
                }
                field("VAT Code"; Rec."VAT Code")
                {
                }
                field("Withholding Tax Code"; Rec."Withholding Tax Code")
                {
                }
                field("Default Grouping"; Rec."Default Grouping")
                {
                }
                field("G/L Account"; Rec."G/L Account")
                {
                }
                field("Pending Voucher"; Rec."Pending Voucher")
                {
                }
                field("Bank Account"; Rec."Bank Account")
                {
                }
                field("Transation Remarks"; Rec."Transation Remarks")
                {
                }
            }
        }
    }

    actions
    {
    }

    trigger OnInit()
    begin
        CurrPage.LookupMode := true;
    end;
}






