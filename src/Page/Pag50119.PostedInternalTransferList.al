//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50119 "Posted Internal Transfer List."
{
    ApplicationArea = All;
    CardPageID = "Sacco Transfer Card";
    Editable = false;
    DeleteAllowed = false;
    PageType = List;
    SourceTable = "Sacco Transfers";
    SourceTableView = where(Posted = filter(true));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(No; rec.No)
                {
                }
                field("Transaction Date";Rec."Transaction Date")
                {
                }
                field("Schedule Total";Rec."Schedule Total")
                {
                }
                field(Approved; rec.Approved)
                {
                }
                field("Approved By";Rec."Approved By")
                {
                }
                field(Posted; rec.Posted)
                {
                }
                field("No. Series";Rec."No. Series")
                {
                }
                field("Responsibility Center";Rec."Responsibility Center")
                {
                }
                field("Transaction Description";Rec."Transaction Description")
                {
                }
                field("Source Account Type";Rec."Source Account Type")
                {
                }
                field("Source Account No.";Rec."Source Account No.")
                {
                }
                field("Source Transaction Type";Rec."Source Transaction Type")
                {
                }
                field("Source Account Name";Rec."Source Account Name")
                {
                }
                field("Source Loan No";Rec."Source Loan No")
                {
                }
                field("Created By";Rec."Created By")
                {
                }
                field(Debit; rec.Debit)
                {
                }
                field(Refund; rec.Refund)
                {
                }
                field("Guarantor Recovery";Rec."Guarantor Recovery")
                {
                }
                field("Payrol No.";Rec."Payrol No.")
                {
                }
                field("Global Dimension 1 Code";Rec."Global Dimension 1 Code")
                {
                }
                field("Global Dimension 2 Code";Rec."Global Dimension 2 Code")
                {
                }
                field("Bosa Number";Rec."Bosa Number")
                {
                }
                field(Status; rec.Status)
                {
                }
                field("Savings Account Type";Rec."Savings Account Type")
                {
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        rec.SetRange("Created By", UserId);
    end;
}




