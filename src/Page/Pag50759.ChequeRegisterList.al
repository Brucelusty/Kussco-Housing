//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50759 "Cheque Register List"
{
    ApplicationArea = All;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "Cheques Register";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Cheque No.";Rec."Cheque No.")
                {
                }
                field("Cheque Book Account No.";Rec."Cheque Book Account No.")
                {
                    ShowMandatory=true;
                }
                field("Bank Name";Rec."Bank Name")
                {
                    Editable=false;
                }
                field(Status; Rec.Status)
                {
                }
                field("Action Date";Rec."Action Date")
                {
                }
                field("Application No.";Rec."Application No.")
                {
                }
                field("Actioned By";Rec."Actioned By")
                {
                }
                field("Account No.";Rec."Account No.")
                {
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Cancel Cheque")
            {

                trigger OnAction()
                begin

                    if Confirm('Are you sure you want to cancel cheque ?', false) = true then begin
                        if Rec.Status <> Rec.Status::Pending then
                            Error('Status must be pending');
                        Rec.Status := Rec.Status::Cancelled;
                        Rec."Action Date" := Today;
                        Rec."Actioned By" := UserId;
                        Rec.Modify;
                    end;
                end;
            }
            action("Stop Cheque")
            {

                trigger OnAction()
                begin

                    if Confirm('Are you sure you want to stop cheque ?', false) = true then begin
                        if Rec.Status <> Rec.Status::Pending then
                            Error('Status must be pending');
                        Rec.Status := Rec.Status::stopped;
                        Rec."Action Date" := Today;
                        Rec."Actioned By" := UserId;
                        Rec.Modify;
                    end;
                end;
            }
            action("Cancel Cheque Book")
            {

                trigger OnAction()
                begin
                    //reset;
                end;
            }
        }
    }
}






