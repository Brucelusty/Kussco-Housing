//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50615 "Cheque Trans Verification"
{
    ApplicationArea = All;
    CardPageID = "Cheque Truncation Card";
    Editable = false;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "Cheque Issue Lines-Family";
    SourceTableView = where(Status = const(Pending));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Chq Receipt No";Rec."Chq Receipt No")
                {
                }
                field("Cheque Serial No";Rec."Cheque Serial No")
                {
                }
                field("Account No.";Rec."Account No.")
                {
                }
                field("Account Name";Rec."Account Name")
                {
                }
                field("Date _Refference No.";Rec."Date _Refference No.")
                {
                }
                field("Transaction Code";Rec."Transaction Code")
                {
                }
                field("Branch Code";Rec."Branch Code")
                {
                }
                field(Amount; Rec.Amount)
                {
                }
                field(Status; Rec.Status)
                {
                }
                field("Cheque No";Rec."Cheque No")
                {
                }
                field(FrontImage; Rec.FrontImage)
                {
                }
                field(FrontGrayImage; Rec.FrontGrayImage)
                {
                }
                field(BackImages; Rec.BackImages)
                {
                }
                field("Account Balance";Rec."Account Balance")
                {
                }
            }
        }
    }

    actions
    {
    }
}






