//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50558 "HR Education Assistance List"
{
    ApplicationArea = All;
    CardPageID = "HR Education Assistance";
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "HR Education Assistance";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Employee No.";Rec."Employee No.")
                {
                }
                field("Employee First Name";Rec."Employee First Name")
                {
                }
                field("Employee Last Name";Rec."Employee Last Name")
                {
                }
                field("Type Of Institution";Rec."Type Of Institution")
                {
                }
                field("Educational Institution";Rec."Educational Institution")
                {
                }
                field("Year Of Study";Rec."Year Of Study")
                {
                }
                field("Refund Level";Rec."Refund Level")
                {
                }
                field("Student Number";Rec."Student Number")
                {
                }
                field("Study Period";Rec."Study Period")
                {
                }
                field("Total Cost";Rec."Total Cost")
                {
                }
            }
        }
    }

    actions
    {
    }
}






