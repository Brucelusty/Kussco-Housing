page 51015 "Delayed Payment  Lines"
{
    ApplicationArea = All;
    Caption = 'Delayed Payment  Lines';
    PageType = ListPart;
    SourceTable = "Delayed Payment Lines";
    //DeleteAllowed = false;
    ModifyAllowed = true;
    InsertAllowed = true;
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Staff No."; Rec."Staff No.")
                {
                    ToolTip = 'Specifies the value of the Staff No. field.';
                }
                field("Member No"; Rec."Member No")
                {
                    ToolTip = 'Specifies the value of the Member No field.';
                }
                field("Account Name"; Rec."Account Name")
                {
                    ToolTip = 'Specifies the value of the Member No field.';
                }
                field(Region; Rec.Region)
                {
                    ToolTip = 'Specifies the value of the Region field.';
                }
                field(Grade; Rec.Grade)
                {
                    ToolTip = 'Specifies the value of the Grade field.';
                }
                field(Amount; Rec.Amount)
                {
                    ToolTip = 'Specifies the value of the Amount field.';
                }
                field(Name; Rec.Name)
                {
                    ToolTip = 'Specifies the value of the Name field.';
                }
                field("New Salary"; Rec."New Salary")
                {
                    ToolTip = 'Specifies the value of the Name field.';
                }
            }
        }
    }
}


