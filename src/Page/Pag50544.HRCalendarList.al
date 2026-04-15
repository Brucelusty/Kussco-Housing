//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50544 "HR Calendar List"
{
    ApplicationArea = All;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "HR Calendar List";

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                Editable = true;
                field(Date; Rec.Date)
                {
                }
                field(Day; Rec.Day)
                {
                }
                field("Non Working"; Rec."Non Working")
                {
                }
                field(Reason; Rec.Reason)
                {
                }
            }
        }
    }

    actions
    {
    }
}






