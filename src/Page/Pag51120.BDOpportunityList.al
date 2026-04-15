page 51120 "BD Opportunity List"
{
    ApplicationArea = All;
    PageType = ListPart;
    SourceTable = "BD Opportunity";
    CardPageId="BD Opportunity Card";
     DeleteAllowed=false;
     InsertAllowed=true;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Opportunity No."; Rec."Opportunity No.") { }
                field("Estimated Value"; Rec."Estimated Value") { }
                field(Stage; Rec.Stage) { }
                field("Expected Start Date"; Rec."Expected Start Date") { }
            }
        }
    }
}


