page 51101 "Member Delegate Zones"
{
    ApplicationArea = All;
    PageType = List;
    Caption='Member Regions';
    SourceTable = "Member Delegate Zones";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Code;Rec.Code)
                {
                }
                field(Description;Rec.Description)
                {
                }
                field("Zone Region";Rec."Zone Region")
                {
                    Visible=false;
                }
                field("Zone Members";Rec."Zone Members")
                {
                    Editable = false;
                }
            }
        }

    }
    actions
    {
        area(creation)
        {
        }
    }
}


