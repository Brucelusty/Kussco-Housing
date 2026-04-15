//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50356 "Cheque Book Request SubPage"
{
    ApplicationArea = All;
    PageType = ListPart;
    SourceTable = "Cheque Book Request Lines";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Cheque Book Application No";Rec."Cheque Book Application No")
                {
                }
                field("Cheque Book Account No";Rec."Cheque Book Account No")
                {
                }
                field("Account Name";Rec."Account Name")
                {
                }
                field("Cheque Book No";Rec."Cheque Book No")
                {
                }
                field(Ordered; Rec.Ordered)
                {
                }
                field("Ordered By";Rec."Ordered By")
                {
                }
                field("Ordered On";Rec."Ordered On")
                {
                }
            }
        }
    }

    actions
    {
    }
}






