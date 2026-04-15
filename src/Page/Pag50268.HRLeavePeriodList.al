//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50268 "HR Leave Period List"
{
    ApplicationArea = All;
    PageType = List;
    DeleteAllowed = false;
    InsertAllowed = false;
    Editable = false;
    UsageCategory = Lists;
    SourceTable = "HR Leave Periods";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Period Code";Rec."Period Code")
                {
                }
                field("Period Description";Rec."Period Description")
                {
                }
                field("Starting Date";Rec."Starting Date")
                {
                }
                field(Name; Rec.Name)
                {
                }
                field("New Fiscal Year";Rec."New Fiscal Year")
                {
                    Editable = true;
                }
                field(Closed; Rec.Closed)
                {
                    // Editable = false;
                }
                field("Date Locked";Rec."Date Locked")
                {
                }
            }
        }
        area(factboxes)
        {
            systempart(Control1102755008; Outlook)
            {
            }
            systempart(Control1102755009; Notes)
            {
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("<Report 172233>")
            {
                Caption = '&Create Year';
                Ellipsis = true;
                Image = CreateYear;
                Promoted = true;
                PromotedCategory = Process;
                // RunObject = Report UnknownReport51516233;
            }
            action("C&lose Year")
            {
                Caption = 'C&lose Year';
                Image = CloseYear;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Codeunit "Leave Year-Close";
            }
        }
    }
}






