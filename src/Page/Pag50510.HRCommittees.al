//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50510 "HR Committees"
{
    ApplicationArea = All;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "HR Committees";

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field("Code";Rec.Code)
                {
                }
                field(Description;Rec.Description)
                {
                }
                field(Roles;Rec.Roles)
                {
                }
                field("Monetary Benefit?";Rec."Monetary Benefit?")
                {
                }
                field("Transaction Code";Rec."Transaction Code")
                {
                    Enabled = false;
                    Visible = false;
                }
                field(Amount;Rec."Transaction Amount")
                {
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Committee)
            {
                Caption = 'Committee';
                action(Members)
                {
                    Caption = 'Members';
                    RunObject = Page "HR Commitee Members";
                    RunPageLink = Committee = field(Code);
                }
            }
        }
    }
}






