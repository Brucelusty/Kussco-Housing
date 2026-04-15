page 50200 "WorkStation List"
{
    ApplicationArea = All;
    Caption = 'Workstation List';
    PageType = List;
    UsageCategory = Lists;
    SourceTable = WorkStations;
    // DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field(EmployerCode;Rec.EmployerCode)
                {
                    Caption = 'Employer Code';
                }
                field(Code; Rec.Code)
                {
                }
                field(Region;Rec.Region)
                {
                }
                field(Description; Rec.Description)
                {
                }
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
            action(TeaBuyingCentres)
            {
                Caption = 'Buying Centres';
                Image = WorkCenter;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                RunObject = page "KTDA Buying Centres";
                // RunPageLink = Factory = field(Code), "Workstation Region" = field(Region);
                RunPageLink = Factory = field(Code);
            }
            action(DutyStations)
            {
                Caption = 'Duty Stations';
                Image = Salutation;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                RunObject = page "Duty Stations";
                // RunPageLink = Factory = field(Code), "Workstation Region" = field(Region);
                RunPageLink = Factory = field(Code);
            }
        }
    }
}


