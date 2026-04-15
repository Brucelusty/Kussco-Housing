//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51000 "CRM Trainings"
{
    ApplicationArea = All;
    CardPageID = "CRM Training Card";
    Editable = false;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "CRM Trainings";
    SourceTableView = where("Training Status" = filter(Open));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Rec.Code)
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("Start Date";Rec."Start Date")
                {
                }
                field("End Date";Rec."End Date")
                {
                }
                field(Location; Rec.Location)
                {
                }
                field(Provider; Rec.Provider)
                {
                }
                field("Need Source";Rec."Need Source")
                {
                }
                field(Closed; Rec.Closed)
                {
                }
            }
        }
    }

    actions
    {
    }
}






