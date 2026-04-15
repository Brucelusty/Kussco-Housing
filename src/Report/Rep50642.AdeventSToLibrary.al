//<---------------------------------------------------------------------->															
report 50642 "AdeventSToLibrary"
{
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(DataItemName; "Company Information")
        {
            trigger OnAfterGetRecord()
            var
            // myInt: Integer;															
            begin
                WFEvents.AddEventsToLib();
                WFEvents.AddResponsesToLib();
                WFEvents.AddEventsPredecessor();
            end;


        }
    }


    var
        WFEvents: codeunit "Custom Workflow Events";
}

