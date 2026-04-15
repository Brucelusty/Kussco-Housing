namespace PROGRESSIVE.PROGRESSIVE;

page 51166 "Customer Contact List"
{
    ApplicationArea = All;
    Caption = 'Customer Contact List';
    PageType = List;
    SourceTable = "Customer Contact";
    UsageCategory = Lists;//
    CardPageId = "Customer Contact Card";
    Editable = false;  // Keep the list read-only
    DeleteAllowed = false;//
    ModifyAllowed = false;
    InsertAllowed = true;  // 
    SourceTableView=where(Converted=const(false));

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the unique identifier for the contact';
                }

                field(Name; Rec.Name)
                {
                    ToolTip = 'Specifies the name of the contact';
                }

                field("Mobile Phone No"; Rec."Mobile Phone No")
                {
                    ToolTip = 'Specifies the contact phone number';
                }



                field("Marketing Channel"; Rec."Marketing Channel")
                {
                    ToolTip = 'Specifies how the contact was acquired';
                }

                field("Marketing Activity"; Rec."Marketing Activity")
                {
                    ToolTip = 'Specifies the marketing activity type';
                }

                field("Sales Agent Code"; Rec."Sales Agent Code")
                {
                    ToolTip = 'Specifies the sales agent code';
                }
                field("Sales Team Leader Code"; Rec."Sales Team Leader Code")
                {
                    Caption = 'STL Code';
                    ToolTip = 'Specifies the Sales Team Leader code';
                }
                field("Sales Executive Code"; Rec."Sales Executive Code")
                {
                    Caption = 'Sales Executive Code';
                    ToolTip = 'Specifies the sales executive code';
                }
            }
        }
    }

    actions
    {
        area(Navigation)
        {
            action(Card)
            {
                Caption = 'Customer Contact Card';
                Image = EditLines;
                RunObject = page "Customer Contact Card";
                RunPageLink = "No." = field("No.");
                ShortcutKey = 'Shift+F7';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'View or edit detailed information about the customer contact';
            }
        }
    }
}


