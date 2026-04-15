//************************************************************************
page 50231 "Penalty Counter List"
{
    ApplicationArea = All;
    PageType = List;
    DeleteAllowed = false;
    Editable = false;
    SourceTable = "Penalty Counter";

    layout
    {
        area(Content)
        {
            Repeater(GroupName)
            {
                field("Loan Number";Rec."Loan Number")
                {
                }
                field("Member Number";Rec."Member Number")
                {
                }
                field("Member Name";Rec."Member Name")
                {
                }
                field("Personal Number";Rec."Personal Number")
                {
                }
                field("Product Type";Rec."Product Type")
                {
                }
                field("Date Entered";Rec."Date Entered")
                {
                }
                field("Penalty Number";Rec."Penalty Number")
                {
                }
                field("Next Penalty Date";Rec."Next Penalty Date")
                {
                }
                field("Amount Charged";Rec."Amount Charged")
                {
                    Style = StrongAccent;
                }
                field("Date Penalty Paid";Rec."Date Penalty Paid")
                {
                    Style = StrongAccent;
                }
                field(Reversed;Rec.Reversed)
                {
                }
                field("Rectified By";Rec."Rectified By")
                {
                }
                field("Rectified On";Rec."Rectified On")
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
            action(Rectify)
            {
                Image = Recalculate;
                ToolTip = 'Rectify Loan Penalty';
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction() begin
                    users.Reset();
                    users.SetRange("User ID", UserId);
                    if users.Find('-') then begin
                        if users."Can Rectify Penalty" = true then begin
                            if Confirm('Do you wish to rectify this loan penalty entry?', true) = false then exit;
                            Rec.Reversed := true;
                            Rec."Rectified By" := UserId;
                            Rec."Rectified On" := Today;
                            Rec.Modify;
                        end;
                    end;
                end;
            }
        }
    }

    var
    users: Record "User Setup";
}




