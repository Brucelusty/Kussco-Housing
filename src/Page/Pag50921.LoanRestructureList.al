//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50921 "Loan Restructure List"
{
    ApplicationArea = All;
    CardPageID = "Loan Restructure Card";
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "Loan Restructure";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Document No"; Rec."Document No")
                {
                }
                field("Member No"; Rec."Member No")
                {
                }
                field("Member Name"; Rec."Member Name")
                {
                }
                field("Loan to Restructure"; Rec."Loan to Restructure")
                {
                }
                field("Loan Product Type"; Rec."Loan Product Type")
                {
                }
                field("Loan Product Name"; Rec."Loan Product Name")
                {
                }
                field("Approved Amount"; Rec."Approved Amount")
                {
                }
                field("Current Payoff Amount"; Rec."Current Payoff Amount")
                {
                }
                field("User ID"; Rec."User ID")
                {
                }
                field("Application Date"; Rec."Application Date")
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
        area(creation)
        {
            action("Members Statistics")
            {
                Caption = 'Member Statistics';
                Image = Statistics;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                RunObject = Page "Members Statistics";
               // RunPageLink = 
            }
        }
    }
}






