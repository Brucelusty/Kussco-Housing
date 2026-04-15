//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51007 "Loan Stages"
{
    ApplicationArea = All;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "Loan Stages";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Loan Stage"; Rec."Loan Stage")
                {
                }
                field("Loan Stage Description"; Rec."Loan Stage Description")
                {
                }
                field("Loan Security Applicable"; Rec."Loan Security Applicable")
                {
                }
                field("Min Loan Amount"; Rec."Min Loan Amount")
                {
                }
                field("Max Loan Amount"; Rec."Max Loan Amount")
                {
                }
                field("Loan Purpose"; Rec."Loan Purpose")
                {
                }
                field("Loan Purpose Description"; Rec."Loan Purpose Description")
                {
                }
                field("Mobile App Specific"; Rec."Mobile App Specific")
                {
                }
            }
        }
    }

    actions
    {
    }
}






