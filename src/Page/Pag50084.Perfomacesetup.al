page 50084 Perfomacesetup
{
    ApplicationArea = All;
    Caption = 'Perfomacesetup';
    PageType = Card;
    SourceTable = "PMS Setup";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field("External Maximum Score"; Rec."External Maximum Score")
                {
                    ToolTip = 'Specifies the value of the External Maximum Score field.';
                    Visible = false;
                }
                field("External Minimum Score"; Rec."External Minimum Score")
                {
                    ToolTip = 'Specifies the value of the External Minimum Score field.';
                    Visible = false;
                }
                field("Maximun value Core Performance"; Rec."Maximun value Core Performance")
                {
                    ToolTip = 'Specifies the value of the Maximun value Core Performance field.';
                    Visible = false;
                }
                field("Minimum Value Core Performance"; Rec."Minimum Value Core Performance")
                {
                    ToolTip = 'Specifies the value of the Minimum Value Core Performance field.';
                    Visible = false;
                }
                field("Target Numbers"; Rec."Target Numbers")
                {
                    ToolTip = 'Specifies the value of the Target Numbers field.';
                    Visible = false;
                }
                field("Performance Numbers"; Rec."Performance Numbers")
                {
                    ToolTip = 'Specifies the value of the Performance Numbers field.';
                }
                field("Peers Minimum Score"; Rec."Peers Minimum Score")
                {
                    ToolTip = 'Specifies the value of the Peers Minimum Score field.';
                    Visible = false;
                }
                field("Peers Maximum Score"; Rec."Peers Maximum Score")
                {
                    ToolTip = 'Specifies the value of the Peers Maximum Score field.';
                    Visible = false;
                }
                field("Surbodinate Minimum Score"; Rec."Surbodinate Minimum Score")
                {
                    ToolTip = 'Specifies the value of the Surbodinate Minimum Score field.';
                    Visible = false;
                }
                field("Surbodinate Maximum Score"; Rec."Surbodinate Maximum Score")
                {
                    ToolTip = 'Specifies the value of the Surbodinate Maximum Score field.';
                    Visible = false;
                }
                field("Total Rating% Peers"; Rec."Total Rating% Peers")
                {
                    ToolTip = 'Specifies the value of the Total Rating% Peers field.';
                    Visible = false;
                }
                field("Total Rating% External"; Rec."Total Rating% External")
                {
                    ToolTip = 'Specifies the value of the Total Rating% External field.';
                    Visible = false;
                }
                field("Total Rating%Subordinates"; Rec."Total Rating%Subordinates")
                {
                    ToolTip = 'Specifies the value of the Total Rating%Subordinates field.';
                    Visible = false;
                }
                field("Values Minimum Score"; Rec."Values Minimum Score")
                {
                    ToolTip = 'Specifies the value of the Values Minimum Score field.';
                    Visible = false;
                }
                field("Values Maximum Score"; Rec."Values Maximum Score")
                {
                    ToolTip = 'Specifies the value of the Values Maximum Score field.';
                    Visible = false;
                }
                field("Workplan Application Nos"; Rec."Workplan Application Nos")
                {
                    ToolTip = 'Specifies the value of the Workplan Application Nos field.';
                    Visible = false;
                }
                field("Workplan Department Nos"; Rec."Workplan Department Nos")
                {
                    ToolTip = 'Specifies the value of the Workplan Department Nos field.';
                    Visible = false;
                }
                field("Workplan Numbers"; Rec."Workplan Numbers")
                {
                    ToolTip = 'Specifies the value of the Workplan Numbers field.';
                    Visible = false;
                }
            }
        }
    }
}


