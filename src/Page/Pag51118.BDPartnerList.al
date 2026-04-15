page 51118 "BD Partner List"
{
    ApplicationArea = All;
    PageType = List;
    SourceTable = "BD Partner";
    CardPageId = "BD Partner Card";
    UsageCategory = Lists;
    DeleteAllowed = false;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Partner No."; Rec."Partner No.") { }
                field("Partner Name"; Rec."Partner Name") { }
                field("Partner Type"; Rec."Partner Type") { }
                field(Status; Rec.Status) { }
                field("Assigned BD Officer"; Rec."Assigned BD Officer") { }
                field("Last Activity Date"; Rec."Last Activity Date") { }
            }
        }
    }
}


