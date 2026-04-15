page 50208 "Departmental KVDs"
{
    ApplicationArea = All;
    PageType = ListPart;
    UsageCategory = Administration;
    SourceTable = "Departmental KVD Weights";
    DeleteAllowed = false;
    
    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(KVD;Rec.KVD)
                {}
                field("Value Driver";Rec."Value Driver")
                {
                    Editable = false;
                }
                field("Department code";Rec."Department code")
                {
                    Editable = false;
                }
                field("Total Weight";Rec."Total Weight")
                {}
                field("Total KPI Weights";Rec."Total KPI Weights")
                {
                    Enabled = false;
                }
            }
        }
    }
    
    actions
    {
        area(Processing)
        {
            action(KPIs)
            {
                Image = PreviewChecks;
                RunObject = page "Departmental KPIs";
                RunPageLink = "Parent KVD" = field(KVD), "Department Code" = field("Department code");
            }
        }
    }
    
    var
        myInt: Integer;
}


