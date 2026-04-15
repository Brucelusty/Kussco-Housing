//************************************************************************
page 50235 "Custom Headline"
{
    ApplicationArea = All;
    Caption = 'Headline';
    PageType = HeadlinePart;
    RefreshOnActivate = true;


    layout
    {
        area(Content)
        {
            group(logo)
            {
                usercontrol("Sacco Logo"; "Logo Control Addin")
                {
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {

                trigger OnAction()
                begin

                end;
            }
        }
    }

    var
        myInt: Integer;
}




