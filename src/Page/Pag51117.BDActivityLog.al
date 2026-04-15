page 51117 "BD Activity Log"
{
    ApplicationArea = All;
    PageType = ListPart;
    SourceTable = "BD Activity Log";
   // UsageCategory = Lists;
   // CardPageId = "BD Activity Card";
   // Editable=false;
    //DeleteAllowed=false;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Partner No."; Rec."Partner No.") { Editable=false;}
                field("Activity Type"; Rec."Activity Type") { }
                field("Activity Date"; Rec."Activity Date") { }
                field("BD Officer"; Rec."BD Officer") {Visible = false; }
                field("Next Follow-Up Date"; Rec."Next Follow-Up Date") { }
            }
        }
    }
}


