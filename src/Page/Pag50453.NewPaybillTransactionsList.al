//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50453 "New Paybill Transactions List"
{
    ApplicationArea = All;
    CardPageID = "New Paybill Card";
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "File Movement Header";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No.";Rec."No.")
                {
                }
                field("File Number";Rec."File Number")
                {
                }
                field("File Name";Rec."File Name")
                {
                }
                field("Date Requested";Rec."Date Requested")
                {
                }
                field("Responsiblity Center";Rec."Responsiblity Center")
                {
                }
                field("Expected Return Date";Rec."Expected Return Date")
                {
                }
                field("Duration Requested";Rec."Duration Requested")
                {
                }
                field("Date Returned";Rec."Date Returned")
                {
                }
                field("File Location";Rec."File Location")
                {
                }
                field("Current File Location";Rec."Current File Location")
                {
                }
                field("Retrieved By";Rec."Retrieved By")
                {
                }
                field("User ID";Rec."User ID")
                {
                }
                field("Issuing File Location";Rec."Issuing File Location")
                {
                }
                field("No. Series";Rec."No. Series")
                {
                }
                field(Status; Rec.Status)
                {
                }
            }
        }
    }

    actions
    {
    }
}






