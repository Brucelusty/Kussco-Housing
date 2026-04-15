Page 50317 "HR Leave Period"
{
    ApplicationArea = All;
    PageType = List;
    SourceTable = "HR Leave Periods";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Period Code"; Rec."Period Code")
                {
                }
                field("Starting Date"; Rec."Starting Date")
                {
                }
                field(Name; Rec.Name)
                {
                    Editable = true;
                }
                field("New Fiscal Year"; Rec."New Fiscal Year")
                {
                }
                field(Closed; Rec.Closed)
                {
                    Editable = true;
                }
                field("Period Description"; Rec."Period Description")
                {
                }

            }
        }
    }

    actions
    {
    }
}



