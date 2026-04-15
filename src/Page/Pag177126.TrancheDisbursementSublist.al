namespace KUSCCOHOUSING.KUSCCOHOUSING;

page 51198 "Tranche Disbursement Sublist"
{
    ApplicationArea = All;
    PageType = ListPart;
    SourceTable = "Tranche Disbursement Schedule";
    Caption = 'Tranche Disbursement Schedule';

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Loan Number"; Rec."Loan Number")
                {
                    Editable = false;
                }

                field("Member No"; Rec."Member No")
                {
                    Editable = false;
                    Visible = false;
                }

                field("Tranche Amount"; Rec."Tranche Amount")
                {
                }
                field("Scheduled Date"; Rec."Scheduled Date")
                {
                }
                field(Select; Rec.Select)
                {
                }

                field(Posted; Rec.Posted)
                {
                    Editable = false;
                }

                field("Posting Date"; Rec."Posting Date")
                {
                    Editable = false;
                }

                field("Posted By"; Rec."Posted By")
                {
                    Editable = false;

                }


            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Mark as Posted")
            {
                Caption = 'Post Tranche';
                Image = Post;
                Promoted = true;
                Visible=false;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    if Rec.Posted then
                        Error('This tranche is already posted.');

                    Rec.Posted := true;
                    Rec."Posting Date" := Today;
                    Rec."Posted By" := UserId;

                    Rec.Modify();
                end;
            }
        }
    }
}


