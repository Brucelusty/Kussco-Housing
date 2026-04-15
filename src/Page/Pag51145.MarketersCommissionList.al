page 51145 "Marketers Commission List"
{
    ApplicationArea = All;
    PageType = List;
    SourceTable = "Marketers Commission Header";
    Caption = 'Marketers Commission List';
    CardPageId = "Marketers Commission Card";
     SourceTableView=where(Posted = filter(false));

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Document No."; Rec."Document No.")
                {
                }

                field("Start Date"; Rec."Start Date")
                {
                }

                field("End Date"; Rec."End Date")
                {
                }

                field("Application Date"; Rec."Application Date")
                {
                }

                field("User ID"; Rec."User ID")
                {
                }
            }
        }
    }
}


