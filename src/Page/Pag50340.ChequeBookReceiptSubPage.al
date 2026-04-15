//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50340 "Cheque Book Receipt SubPage"
{
    ApplicationArea = All;
    PageType = ListPart;
    SourceTable = "Cheque Book Receipt Lines";

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
                    Editable = false;
                }
                field("Cheque Book Application Date";Rec."Cheque Book Application Date")
                {
                    Editable = false;
                }
                field(Received; Rec.Received)
                {
                }
                field("Received By";Rec."Received By")
                {
                    Editable = false;
                }
                field("Received On";Rec."Received On")
                {
                    Editable = false;
                }
            }
        }
    }

    actions
    {
    }
}






