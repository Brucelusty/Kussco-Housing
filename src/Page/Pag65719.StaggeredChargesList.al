page 65719 "Staggered Charges List"
{
    ApplicationArea = All;
    CardPageID = "Staggered Charges";
    PageType = List;
    SourceTable = "Staggered Charges";
    

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Code;rec.Code)
                {
                }
                field(Description;rec.Description)
                {
                }
            }
        }
    }

    actions
    {
    }
}




