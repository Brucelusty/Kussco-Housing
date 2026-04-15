//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50996 "Loan Demand Notices List"
{
    ApplicationArea = All;
    CardPageID = "Loan Demand Notices Card";
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "Default Notices Register";

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
                field("Loan In Default"; Rec."Loan In Default")
                {
                }
                field("Loan Product"; Rec."Loan Product")
                {
                }
                field("Loan Instalments"; Rec."Loan Instalments")
                {
                }
                field("Loan Disbursement Date"; Rec."Loan Disbursement Date")
                {
                }
                field("Expected Completion Date"; Rec."Expected Completion Date")
                {
                }
                field("Amount In Arrears"; Rec."Amount In Arrears")
                {
                }
                field("Days In Arrears"; Rec."Days In Arrears")
                {
                }
                field("Loan Outstanding Balance"; Rec."Loan Outstanding Balance")
                {
                }
                field("Notice Type"; Rec."Notice Type")
                {
                }
                field("Demand Notice Date"; Rec."Demand Notice Date")
                {
                }
                field("User ID"; Rec."User ID")
                {
                }
                field("No. Series"; Rec."No. Series")
                {
                }
            }
        }
    }

    actions
    {
    }
}






