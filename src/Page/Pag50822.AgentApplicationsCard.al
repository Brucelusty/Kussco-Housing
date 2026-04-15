//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50822 "Agent Applications Card"
{
    ApplicationArea = All;
    PageType = Card;
    SourceTable = "Agent Applications";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Agent Code";Rec."Agent Code")
                {
                    ShowMandatory = true;
                }
                field("Float Account"; Rec.Account)
                {
                    ShowMandatory = true;
                }
                field("Date Entered";Rec."Date Entered")
                {
                    ShowMandatory = true;
                }
                field("Time Entered";Rec."Time Entered")
                {
                    ShowMandatory = true;
                }
                field("Entered By";Rec."Entered By")
                {
                }
                field("Document Serial No";Rec."Document Serial No")
                {
                }
                field("Document Date";Rec."Document Date")
                {
                    ShowMandatory = true;
                }
                field("Agent ID No";Rec."Customer ID No")
                {
                    ShowMandatory = true;
                }
                field("Date of Birth";Rec."Date of Birth")
                {
                }
                field(Name; Rec.Name)
                {
                    ShowMandatory = true;
                }
                field("Mobile No";Rec."Mobile No")
                {
                    ShowMandatory = true;
                }
                field(Status; Rec.Status)
                {
                }
                field(Comments; Rec.Comments)
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
                field("Rejection Reason";Rec."Rejection Reason")
                {
                }
                field("Sent To Server";Rec."Sent To Server")
                {
                    Editable = false;
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
                    ShowMandatory = true;
                }
                field("Withdrawal Limit Amount";Rec."Withdrawal Limit Amount")
                {
                    Editable = false;
                    ShowMandatory = true;
                }
                field("Name of the Proposed Agent";Rec."Name of the Proposed Agent")
                {
                    ShowMandatory = true;
                }
                field("Comm Account";Rec."Comm Account")
                {
                    ShowMandatory = true;
                }
                field("Type of Business";Rec."Type of Business")
                {
                }
                field("Place of Business";Rec."Place of Business")
                {
                    ShowMandatory = true;
                }
                field("Business/Work Experience";Rec."Business/Work Experience")
                {
                }
                field("Branch Registered at";Rec."Branch Registered at")
                {
                    ShowMandatory = true;
                }
                field(Branch; Rec.Branch)
                {
                }
            }
        }
    }

    actions
    {
    }
}






