//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50441 "PRF Lists"
{
    ApplicationArea = All;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "Purchase Line";
    SourceTableView = where("Document Type" = const(Quote));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Document No.";Rec."Document No.")
                {
                }
                field(Type; Rec.Type)
                {
                }
                field("No.";Rec."No.")
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("Description 2";Rec."Description 2")
                {
                }
                field("Unit of Measure";Rec."Unit of Measure")
                {
                }
                field(Quantity; Rec.Quantity)
                {
                }
                field("Direct Unit Cost";Rec."Direct Unit Cost")
                {
                }
            }
        }
    }

    actions
    {
    }


    procedure SetSelection(var Collection: Record "Purchase Line")
    begin
        CurrPage.SetSelectionFilter(Collection);
    end;
}






