//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50780 "Loan Collateral Register List"
{
    ApplicationArea = All;
    CardPageID = "Loan Collateral Register Card";
    Editable = false;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "Loan Collateral Register";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Document No";Rec."Document No")
                {
                }
                field("Collateral Description";Rec."Collateral Description")
                {
                }
                field("Collateral Code";Rec."Collateral Code")
                {
                }
                field("Registered Owner";Rec."Registered Owner")
                {
                }
                field("Member No.";Rec."Member No.")
                {
                }
                field("Member Name";Rec."Member Name")
                {
                }
                field("Registration/Reference No";Rec."Registration/Reference No")
                {
                }
                field("Asset Value";Rec."Asset Value")
                {
                }
                field("Market Value";Rec."Market Value")
                {
                }
                field("Forced Sale Value";Rec."Forced Sale Value")
                {
                }
                field("Date Received";Rec."Date Received")
                {
                }
                field("Received By";Rec."Received By")
                {
                }
                field("Date Released";Rec."Date Released")
                {
                }
                field("Released By";Rec."Released By")
                {
                }
                field("Last Collateral Action";Rec."Last Collateral Action")
                {
                }
                field("Collateral Registered";Rec."Collateral Registered")
                {
                }
            }
        }
    }

    actions
    {
    }
}






