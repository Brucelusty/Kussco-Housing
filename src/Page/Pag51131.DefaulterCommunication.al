page 51131 "Defaulter Communication"
{
    ApplicationArea = All;
    PageType = ListPart;
    SourceTable = "Defaulter Communication";

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Date Time"; Rec."Date Time") { }
                field("Channel"; Rec."Channel") { }
                field("Call Attempts"; Rec."Call Attempts") { }
                field("Outcome"; Rec."Outcome") { }
                field("Promise To Pay Date"; Rec."Promise To Pay Date") { }
                field("Next Follow-up Date"; Rec."Next Follow-up Date") { }
                field("Summary"; Rec."Summary") { }
                field("Created By"; Rec."Created By") {Visible=false; }
                
            }
        }
    }
}
    


