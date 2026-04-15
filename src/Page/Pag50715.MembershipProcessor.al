//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50715 "Membership Processor"
{
    ApplicationArea = All;
    PageType = CardPart;
    SourceTable = "Cue Sacco Roles";
    

    layout
    {
        area(content)
        {
            group("Member Applications")
            {
                Caption = 'Membership';
                field("Total Campaigns Done"; Rec."Total Campaigns Done")
                {
                  AutoFormatType = 1; 
                }
                field("Total Marketing Events"; Rec."Total Marketing Events")
                {
                  AutoFormatType = 1; 
                }
                field("Total Leads"; Rec."Total Leads")
                {
                }
                field("Unassigned Leads"; Rec."Unassigned Leads")
                {
                }
                field("Open Member Applications"; Rec."Open Member Applications")
                {
                }
                field("Pending Member Applications"; Rec."Pending Member Applications")
                {
                }
                field("Rejected Member Applications"; Rec."Rejected Member Applications")
                {
                }
                field("Total Members"; Rec."Total Members")
                {
                    //AutoFormatType = 1;
                }
                field("New Members This Month"; Rec."New Members This Month")
                {
                }
                field("Total Male Members"; Rec."Total Male Members")
                {
                }
                field("Total Female Members"; Rec."Total Female Members")
                {
                }
                field("Total Individual Members"; Rec."Total Individual Members")
                {
                }
                field("Total Joint Members"; Rec."Total Joint Members")
                {
                }
                field("Total Corporate Members"; Rec."Total Corporate Members")
                {
                }
            }
        }
    }

    actions
    {
    }
}






