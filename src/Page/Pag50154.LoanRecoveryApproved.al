//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50154 "Loan Recovery - Approved"
{
    ApplicationArea = All;
    CardPageID = "Loan Recovery Header";
    Editable = false;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "Loan Recovery Header";
    SourceTableView = where(Posted = filter(false),
                            Status = filter(Approved));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Document No";Rec."Document No")
                {
                }
                field("Member No";Rec."Member No")
                {
                }
                field("Member Name";Rec."Member Name")
                {
                }
                field("Application Date";Rec."Application Date")
                {
                }
                field("Created By";Rec."Created By")
                {
                }
                field("Recovery Type";Rec."Recovery Type")
                {
                }
                field("Loan to Attach";Rec."Loan to Attach")
                {
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Members Statistics")
            {
                Caption = 'Member Statistics';
                Image = Statistics;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                RunObject = Page "Members Statistics";
                RunPageLink = "No." = field("Member No");
            }
        }
    }

    trigger OnOpenPage()
    begin
        //SetRange("Created By", UserId);
    end;

    var
        ObjLoanRecoveryH: Record "Loan Recovery Header";
}






