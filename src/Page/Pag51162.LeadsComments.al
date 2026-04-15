page 51162 "Leads Comments"
{
    ApplicationArea = All;
    PageType = ListPart;
    UsageCategory = Lists;
    SourceTable = "Leads Comment"; // Refers to Table 9697
    Caption = 'Leads Comments';
    Editable = true;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Document No."; Rec."Document No.")
                {
                    Visible = false; // Document No. is hidden per your request
                    ToolTip = 'Specifies the document number.';
                }
                field(Description; Rec.Description)
                {
                    //MultiLine = true; // Useful for your Text[1500] field
                    ToolTip = 'Specifies the description or comment.';
                }
                field("Interaction Type"; Rec."Interaction Type")
                {
                    //MultiLine = true; // Useful for your Text[1500] field
                    ToolTip = 'Specifies the interaction type.';
                }
                field("Date"; Rec."Date")
                {
                    ToolTip = 'Specifies the date of the entry.';
                }
                field("User ID"; Rec."User ID")
                {
                    ToolTip = 'Specifies the user who created the entry.';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            /*             action(ActionName)
                        {
                            Caption = 'Action Name';

                            trigger OnAction()
                            begin
                                // Add logic here
                            end;
                        } */
        }
    }
}


