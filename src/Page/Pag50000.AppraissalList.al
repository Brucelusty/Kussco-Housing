Page 50000 "Appraissal List"
{
    ApplicationArea = All;
    CardPageID = "Appraisal Card";
    PageType = List;
    SourceTable = "HR Appraisal Header";
    UsageCategory = Lists;
    
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                }
                field("Appraisal Period"; Rec."Appraisal Period")
                {
                }
                field("Employee No."; Rec."Employee No.")
                {
                }
                field("Employee Name"; Rec."Employee Name")
                {
                }
            }
        }
    }

    actions
    {
    }

    trigger OnDeleteRecord(): Boolean
    begin
        Error('Records are not allowed to be deleted. create another record instead!!!');
    end;
}



