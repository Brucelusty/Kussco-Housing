page 50210 "Specific Departmental KVDs"
{
    ApplicationArea = All;
    PageType = List;
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
            }
            // part("Key Performance Indicators"; "Departmental KPIs")
            // {
            //     SubPageLink = "Parent KVD" = field(KVD), "Department Code" = field("Department code");
            // }
        }
    }
    
    actions
    {
        
    }

    trigger OnAfterGetRecord()
    begin
        departments.Reset();
        departments.SetRange("Department Head UserId", UserId);
        if departments.FindSet() then begin
            Rec.SetRange("Department Code", departments.Code);
        end else begin
            users.Reset();
            users.SetRange("Is Manager", true);
            users.SetRange("User ID", UserId);
            if users.Find('-') then begin
                // users.Reset();
                // users.SetRange("Can Edit KPIs", true);
                // users.SetRange("User ID", UserId);
                // if users.Find('-') = false then begin
                //     Rec.SetRange();
                // end;
            end else Error('The user %1 does not have permissions to view departmental KPIs.', UserId);
        end;
    end;
    trigger OnAfterGetCurrRecord()
    begin
        departments.Reset();
        departments.SetRange("Department Head UserId", UserId);
        if departments.FindSet() then begin
            Rec.SetRange("Department Code", departments.Code);
        end else begin
            users.Reset();
            users.SetRange("Is Manager", true);
            users.SetRange("User ID", UserId);
            if users.Find('-') then begin
                // users.Reset();
                // users.SetRange("Can Edit KPIs", true);
                // users.SetRange("User ID", UserId);
                // if users.Find('-') = false then begin
                //     Rec.SetRange();
                // end;
            end else Error('The user %1 does not have permissions to view departmental KPIs.', UserId);
        end;
    end;
    
    var
    myInt: Integer;
    deptHead: Code[20];
    users: Record "User Setup";
    employees: Record "HR Employees";
    departments: Record "Responsibility Center";
}


