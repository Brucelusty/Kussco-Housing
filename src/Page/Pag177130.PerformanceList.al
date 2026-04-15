namespace KUSCCOHOUSING.KUSCCOHOUSING;

page 51200 "Performance List"
{
    ApplicationArea = All;
    PageType = List;
    SourceTable = "Performance Header";
    CardPageId = "Performance Card";
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.") { }
                field("Period"; Rec."Period") { }
                field("Scope"; Rec."Scope") { }
                field("Officer ID"; Rec."Officer ID") { }
                field("Total Score"; Rec."Total Score") { }
                field("Rating"; Rec."Rating") { }
            }
        }
    }
}




