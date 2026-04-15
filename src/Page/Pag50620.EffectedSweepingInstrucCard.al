//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50620 "Effected Sweeping Instruc Card"
{
    ApplicationArea = All;
    Editable = false;
    PageType = Card;
    SourceTable = "Member Sweeping Instructions";
    SourceTableView = where(Effected = filter(true));

    layout
    {
        area(content)
        {
            group(General)
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
                field("Monitor Account";Rec."Monitor Account")
                {
                }
                field("Monitor Account Type";Rec."Monitor Account Type")
                {
                }
                field("Monitor Account Type Desc";Rec."Monitor Account Type Desc")
                {
                    Caption = 'Monitor Account Type Description';
                }
                field("Check Minimum Threshold";Rec."Check Minimum Threshold")
                {
                    Caption = 'Sweep From Investment Min Threshold';
                    ToolTip = 'Sweep From Investment Account Amount Below Minimum Threshold';
                }
                field("Check Maximum Threshold";Rec."Check Maximum Threshold")
                {
                    Caption = 'Swep From Monitor Account Above Max Threshold';
                }
                group("Minimum Threshold")
                {
                    field("Minimum Account Threshold";Rec."Minimum Account Threshold")
                    {
                    }
                }
                group("Maximum Threshold")
                {
                    field("Maximum Account Threshold";Rec."Maximum Account Threshold")
                    {
                    }
                }
                field("Investment Account";Rec."Investment Account")
                {
                }
                field("Investment Account Type";Rec."Investment Account Type")
                {
                }
                field("Investment Account Type Desc";Rec."Investment Account Type Desc")
                {
                    Caption = 'Investment Account Type Description';
                }
                field("Schedule Frequency";Rec."Schedule Frequency")
                {

                    trigger OnValidate()
                    begin
                        WeeklyVisible := false;
                        MonthlyVisible := false;
                        if Rec."Schedule Frequency" = Rec."schedule frequency"::Weekly then begin
                            WeeklyVisible := true;
                        end;
                        if Rec."Schedule Frequency" = Rec."schedule frequency"::Monthly then begin
                            MonthlyVisible := true;
                        end;
                    end;
                }
                group("Weekly ")
                {
                    Visible = WeeklyVisible;
                    field("Day Of Week";Rec."Day Of Week")
                    {
                        Caption = 'Day Of Week';
                    }
                }
                group(Monthly)
                {
                    Visible = MonthlyVisible;
                    field("Day Of Month";Rec."Day Of Month")
                    {
                        Caption = 'Days Of Month e.g. 05,12,20';
                    }
                }
                field("Created On";Rec."Created On")
                {
                }
                field("Created By";Rec."Created By")
                {
                }
                field(Effected; Rec.Effected)
                {
                }
                field("Effected on";Rec."Effected on")
                {
                }
                field("Last Execution";Rec."Last Execution")
                {
                }
                field(Stopped; Rec.Stopped)
                {
                }
                field("Stopped By";Rec."Stopped By")
                {
                }
                field("Stopped On";Rec."Stopped On")
                {
                }
                label(Control32)
                {
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Stop Instruction")
            {
                Image = Stop;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    Rec.Status := Rec.Status::Stopped;
                    Rec.Stopped := true;
                    Rec."Stopped By" := UserId;
                    Rec."Stopped On" := Today();
                    Rec.Modify;
                    Message('Standing instruction stopped successfully');
                end;
            }
        }
    }

    var
        WeeklyVisible: Boolean;
        MonthlyVisible: Boolean;
}






