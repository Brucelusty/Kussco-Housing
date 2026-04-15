//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50757 "Cheque Book Application - New"
{
    ApplicationArea = All;
    CardPageID = "Cheque Application";
    Editable = false;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "Cheque Book Application";
    SourceTableView = where("Cheque Book Ordered" = filter(false));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No.";Rec."No.")
                {
                }
                field("Account No.";Rec."Account No.")
                {
                }
                field(Name; Rec.Name)
                {
                }
                field("ID No.";Rec."ID No.")
                {
                }
                field("Cheque Book Account No.";Rec."Cheque Book Account No.")
                {
                }
                field("Application Date";Rec."Application Date")
                {
                }
                field(Status; Rec.Status)
                {
                }
                field("Requested By";Rec."Requested By")
                {
                }
                field("Cheque Book Fee Charged";Rec."Cheque Book Fee Charged")
                {
                }
                field("Cheque Book Fee Charged On";Rec."Cheque Book Fee Charged On")
                {
                }
                field("Cheque Book Fee Charged By";Rec."Cheque Book Fee Charged By")
                {
                }
            }
        }
    }

    actions
    {
    }
}






