//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51034 "Member Exit Batch List"
{
    ApplicationArea = All;
    CardPageID = "Member Exit Batch Card";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    UsageCategory = Lists;
    PromotedActionCategories = 'New,Process,Reports,Approval,Budgetary Control,Cancellation,Category7_caption,Category8_caption,Category9_caption,Category10_caption';
    SourceTable = "Member Exit Batch";
    SourceTableView = where(Posted = filter(false));

    layout
    {
        area(content)
        {
            repeater(Control1102760000)
            {
                field("Exit Batch No."; rec."Exit Batch No.")
                {
                    Editable = false;
                }
                field("Mode Of Disbursement"; Rec."Mode Of Disbursement")
                {
                }
                field("Description/Remarks"; rec."Description/Remarks")
                {
                }
                field(Status; Rec.Status) { }
                field("Posting Date"; rec."Posting Date")
                {
                }
             
            }
        }
    }

    actions
    {
        area(navigation)
        {
        }
}

}






