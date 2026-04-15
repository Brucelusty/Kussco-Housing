//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50331 "Posted Payment Line"
{
    ApplicationArea = All;
    PageType = ListPart;
    SourceTable = "Payment Line.";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Account Name";Rec."Account Name")
                {
                }
                field("Posted By";Rec."Posted By")
                {
                }
                field(Posted; Rec.Posted)
                {
                }
                field("Date Posted";Rec."Date Posted")
                {
                }
                field("Time Posted";Rec."Time Posted")
                {
                }
                field(Amount; Rec.Amount)
                {
                }
                field(Remarks; Rec.Remarks)
                {
                }
                field("Transaction Name";Rec."Transaction Name")
                {
                }
                field("VAT Code";Rec."VAT Code")
                {
                }
                field("Withholding Tax Code";Rec."Withholding Tax Code")
                {
                }
                field("VAT Amount";Rec."VAT Amount")
                {
                }
                field("Withholding Tax Amount";Rec."Withholding Tax Amount")
                {
                }
                field("Net Amount";Rec."Net Amount")
                {
                }
                field("Paying Bank Account";Rec."Paying Bank Account")
                {
                }
                field("PO/INV No";Rec."PO/INV No")
                {
                }
                field("Bank Account No";Rec."Bank Account No")
                {
                }
                field("Total Allocation";Rec."Total Allocation")
                {
                }
                field("Total Expenditure";Rec."Total Expenditure")
                {
                }
                field("Total Commitments";Rec."Total Commitments")
                {
                }
            }
        }
    }

    actions
    {
    }
}






