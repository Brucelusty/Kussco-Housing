//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50862 "MPESA C2B Transaction"
{
    ApplicationArea = All;
    Editable = false;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = MPESAC2BTransactions;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(ColumnID; Rec.ColumnID)
                {
                }
                field(ReceiptNumber; Rec.ReceiptNumber)
                {
                }
                field(CustomerName; Rec.CustomerName)
                {
                }
                field(PhoneNumber; Rec.PhoneNumber)
                {
                }
                field(AccountNumber; Rec.AccountNumber)
                {
                }
                field(TrxAmount; Rec.TrxAmount)
                {
                }
                field(TrxStatus; Rec.TrxStatus)
                {
                }
                field(Posted; Rec.Posted)
                {
                }
                field(Validated; Rec.Validated)
                {
                }
                field(DateValidated; Rec.DateValidated)
                {
                }
                field(DateCompleted; Rec.DateCompleted)
                {
                }
                field("Un Identified Payments"; Rec."Un Identified Payments")
                {
                }
                field(TrxDetails; Rec.TrxDetails)
                {
                }
                field(DatePosted; Rec.DatePosted)
                {
                }
                field(Alerted; Rec.Alerted)
                {
                }
                field(Reversed; Rec.Reversed)
                {
                }
                field("Un Identified Payment Posted"; Rec."Un Identified Payment Posted")
                {
                }
            }
        }
    }

    actions
    {
    }
}






