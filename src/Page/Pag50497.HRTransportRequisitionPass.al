//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50497 "HR Transport Requisition Pass"
{
    ApplicationArea = All;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "HR Transport Allocations";
    SourceTableView = sorting("Allocation No", "Requisition No");

    layout
    {
        area(content)
        {
            repeater(Control1102756000)
            {
                field("Requisition No";Rec."Requisition No")
                {
                }
                field("Employee No";Rec."Employee No")
                {
                }
                field("Passenger/s Full Name/s";Rec."Passenger/s Full Name/s")
                {
                    Editable = false;
                }
                field(From; Rec.From)
                {
                }
                field("To";Rec."To")
                {
                }
                field(Dept; Rec.Dept)
                {
                }
            }
        }
    }

    actions
    {
    }
}






