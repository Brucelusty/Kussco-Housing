//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50552 "HR Transport Requisition List"
{
    ApplicationArea = All;
    CardPageID = "HR Staff Transport Requisition";
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "HR Transport Requisition";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Application Code";Rec."Application Code")
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("Supervisor Email";Rec."Supervisor Email")
                {
                }
                field("Job Tittle";Rec."Job Tittle")
                {
                }
                field("User ID";Rec."User ID")
                {
                }
                field("Employee No";Rec."Employee No")
                {
                }
                field(Supervisor; Rec.Supervisor)
                {
                }
                field("Responsibility Center";Rec."Responsibility Center")
                {
                }
                field(Comment; Rec.Comment)
                {
                }
                field("Purpose of Trip";Rec."Purpose of Trip")
                {
                }
                field("Transport type";Rec."Transport type")
                {
                }
                field("Time of Trip";Rec."Time of Trip")
                {
                }
                field("Pickup Point";Rec."Pickup Point")
                {
                }
                field("From Destination";Rec."From Destination")
                {
                }
                field("To Destination";Rec."To Destination")
                {
                }
            }
        }
    }

    actions
    {
    }
}






