//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50650 "Posted Bosa Rcpt List-Checkof"
{
    ApplicationArea = All;
    CardPageID = "PostedBosa Rcpt HCard-Checkof";
    Editable = false;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "ReceiptsProcessing_H-Checkoff";
    SourceTableView = where(Posted = filter(true));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(No; Rec.No)
                {
                }
                field("Posted By";Rec."Posted By")
                {
                }
                field("Account No";Rec."Account No")
                {
                }
                field("Document No";Rec."Document No")
                {
                }
                field(Amount; Rec.Amount)
                {
                }
                field("Scheduled Amount";Rec."Scheduled Amount")
                {
                }
                field("Account Name";Rec."Account Name")
                {
                }
                field("Employer Code";Rec."Employer Code")
                {
                }
            }
        }
    }

    actions
    {
    }
}






