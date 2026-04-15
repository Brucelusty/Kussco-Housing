//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50547 "HR Asset Return Form"
{
    ApplicationArea = All;
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = List;
    UsageCategory = Lists;
    RefreshOnActivate = true;
    SourceTable = "Misc. Article Information";

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                field("Misc. Article Code"; Rec."Misc. Article Code")
                {
                }
                field(Description; Rec.Description)
                {
                }
                // field(Returned;Returned)
                // {
                // }
                // field("Status On Return";"Status On Return")
                // {
                // }
                // field("Date Returned";"Date Returned")
                // {
                // }
                // field(Recommendations;Recommendations)
                // {
                // }
                // field("Received By";"Received By")
                // {
                // }
            }
        }
    }

    actions
    {
    }

    var
        EI: Record "HR Employee Exit Interviews";


    procedure refresh()
    begin
        CurrPage.Update(false);
    end;
}






