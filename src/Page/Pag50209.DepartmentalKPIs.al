page 50209 "Departmental KPIs"
{
    ApplicationArea = All;
    PageType = ListPart;
    UsageCategory = Administration;
    SourceTable = "Departmental KPIs";
    // DeleteAllowed = false;
    
    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(KPI;Rec.KPI)
                {
                    // Editable = false;
                }
                field(Weight;Rec.Weight)
                {}
                field("KPI Target";Rec."KPI Target")
                {
                    // MultiLine = true;
                }
            }
        }
    }
    
    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        
    end;
    
    var
    myInt: Integer;
    deptHead: Code[20];
    users: Record "User Setup";
    employees: Record "HR Employees";
    departments: Record "Responsibility Center";
}


