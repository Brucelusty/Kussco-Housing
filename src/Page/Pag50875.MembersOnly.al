//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50875 "Members Only"
{
    ApplicationArea = All;
    PageType = CardPart;
    SourceTable = "Membership Cue";

    layout
    {
        area(content)
        {
            cuegroup(Members)
            {
                field("Active Members";Rec."Active Members")
                {
                    //image ="None";
                    Style = Favorable;
                    StyleExpr = true;
                }
                field("Dormant Members";Rec."Dormant Members")
                {
                    //image ="None";
                }
                field("Non-Active Members";Rec."Non-Active Members")
                {
                    //Image = PEople;
                    Style = Attention;
                    StyleExpr = true;
                }
                field("Deceased Members";Rec."Deceased Members")
                {
                    Image = People;
                }
                field("Withdrawn Members";Rec."Withdrawn Members")
                {
                    // //image ="None";
                }
            }
            cuegroup("Account Category")
            {
                Caption = 'Account Categories';
                
            }
            cuegroup("Account Categories")
            {
                Caption = 'Gender';
                field("Female Members";Rec."Female Members")
                {
                    //image ="None";
                }
                field("Male Members";Rec."Male Members")
                {
                    //image ="None";
                }
                field("Junior Members";Rec."Junior Members")
                {
                    Image = Library;
                }
            }
            cuegroup(Control2)
            {
                field("Requests to Approve";Rec."Requests to Approve")
                {
                    DrillDownPageID = "Requests to Approve";
                }
                field("Requests Sent for Approval";Rec."Requests Sent for Approval")
                {
                    DrillDownPageID = Approvals;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        if not Rec.Get(UserId) then begin
            Rec.Init;
            Rec."User ID" := UserId;
            Rec.Insert;
        end;
    end;
}






