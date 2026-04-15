page 65739 "Compliance Task Log"
{
    ApplicationArea = All;
    PageType = List;
    SourceTable = "Compliance Task Log";
    UsageCategory = Tasks;

    layout
    {
        area(Content)
        {
            repeater(Tasks)
            {
                field("Task ID"; Rec."Task ID")
                {
                }

                field("Staff ID"; Rec."Staff ID")
                {
                }

                field("Task Description"; Rec."Task Description")
                {
                }

                field("Task Date"; Rec."Task Date")
                {
                }

                field("Task Type"; Rec."Task Type")
                {
                }

                field("Issues Detected"; Rec."Issues Detected")
                {
                }

                field("Resolution Status"; Rec."Resolution Status")
                {
                }

                field(Comments; Rec.Comments)
                {
                }
            }
        }
    }
}


