//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50819 "Agent applications List"
{
    ApplicationArea = All;
    CardPageID = "Agent Applications Card";
    Editable = false;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "Agent Applications";
    SourceTableView = where(Status = filter(Pending));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Agent Code"; Rec."Agent Code")
                {
                }
                field("Date Entered";Rec."Date Entered")
                {
                }
                field("Time Entered";Rec."Time Entered")
                {
                }
                field("Entered By";Rec."Entered By")
                {
                }
                field("Document Serial No";Rec."Document Serial No")
                {
                }
                field("Document Date";Rec."Document Date")
                {
                }
                field("Customer ID No";Rec."Customer ID No")
                {
                }
                field(Name; Rec.Name)
                {
                }
                field("Mobile No";Rec."Mobile No")
                {
                }
                field(Status; Rec.Status)
                {
                }
                field(Comments; Rec.Comments)
                {
                }
                field("Rejection Reason";Rec."Rejection Reason")
                {
                }
                field("Date Approved";Rec."Date Approved")
                {
                }
                field("Time Approved";Rec."Time Approved")
                {
                }
                field("Approved By";Rec."Approved By")
                {
                }
                field("Date Rejected";Rec."Date Rejected")
                {
                }
                field("Time Rejected";Rec."Time Rejected")
                {
                }
                field("Rejected By";Rec."Rejected By")
                {
                }
                field("Sent To Server";Rec."Sent To Server")
                {
                }
                field("No. Series";Rec."No. Series")
                {
                }
                field("1st Approval By";Rec."1st Approval By")
                {
                }
                field("Date 1st Approval";Rec."Date 1st Approval")
                {
                }
                field("Time First Approval";Rec."Time First Approval")
                {
                }
                field("Withdrawal Limit Code";Rec."Withdrawal Limit Code")
                {
                }
                field("Withdrawal Limit Amount";Rec."Withdrawal Limit Amount")
                {
                }
                field(Account; Rec.Account)
                {
                }
                field("Name of the Proposed Agent";Rec."Name of the Proposed Agent")
                {
                }
                field("Date of Birth";Rec."Date of Birth")
                {
                }
                field("Type of Business";Rec."Type of Business")
                {
                }
                field("Business/Work Experience";Rec."Business/Work Experience")
                {
                }
                field("Name of Banker";Rec."Name of Banker")
                {
                }
                field("PIN(KRA)";Rec."PIN(KRA)")
                {
                }
            }
        }
    }

    actions
    {
    }
}






