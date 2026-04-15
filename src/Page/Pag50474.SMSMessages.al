page 50474 "SMS Messages."
{
    ApplicationArea = All;
    Caption = 'SMS Messages';
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "Sms Entry 2";

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Entry No"; Rec.EntryNo)
                {
                }
                field("Telephone No"; Rec."Phone Number")
                {

                }
                field("SMS Message"; Rec.Message)
                {
                }
                field("Date Entered"; Rec.Response)
                {
                }
                field("Time Entered"; Rec."Message Date")
                {
                }


            }
        }
        area(Factboxes)
        {

        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {

                trigger OnAction();
                begin

                end;
            }
        }
    }
}


