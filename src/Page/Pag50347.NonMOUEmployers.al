page 50347 "Non MOU Employers"
{
    ApplicationArea = All;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "Non MOU Employers";
    
    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Employer No.";Rec."Employer No.")
                {}
                field("Employer Name";Rec."Employer Name")
                {}
                field("MOU Signed";Rec."MOU Signed")
                {}
                field("Employer Address";Rec."Employer Address")
                {}
                field("Employer Physical Location";Rec."Employer Physical Location")
                {}
                field("Employer Phone No";Rec."Employer Phone No")
                {}
            }
        }
        area(Factboxes)
        {
            
        }
    }
    
    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                
                trigger OnAction()
                begin
                    
                end;
            }
        }
    }
}


