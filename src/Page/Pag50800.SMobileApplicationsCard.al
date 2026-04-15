//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50800 "S-Mobile Applications Card"
{
    ApplicationArea = All;
    PageType = Card;
    SourceTable ="MOBILE Applications";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No.";Rec."No.")
                {
                    Editable = false;
                }
                field("Account No";Rec."Account No")
                {
                }
                field("Account Name";Rec."Account Name")
                {
                    Editable = false;
                }
                field(Telephone; Rec.Telephone)
                {
                }
                field("ID No";Rec."ID No")
                {
                    Editable = false;
                }
            }
            group("Other Details")
            {
                Caption = 'Other Details';
                field(Status; Rec.Status)
                {
                    Editable = false;
                }
                field("Date Applied";Rec."Date Applied")
                {
                    Editable = false;
                }
                field("Time Applied";Rec."Time Applied")
                {
                    Editable = false;
                }
                field("Created By";Rec."Created By")
                {
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Send for approval")
            {
                Caption = 'Send for approval';
                Image = Approve;
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;

                trigger OnAction()
                begin
                    if Rec.Status <> Rec.Status::Application then
                        Error('Application is already sent for approval');

                    Rec.TestField(Telephone);
                    Rec.TestField("Account No");

                    //Status := Status::" Pending Approval";
                    Rec.Modify;
                    Message('Application has been sent to approval');
                end;
            }
        }
    }
}






