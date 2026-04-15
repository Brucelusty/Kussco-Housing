page 50022 "Matured Notice List"
{
    ApplicationArea = All;
    Caption = 'Matured Notice List';
    PageType = List;
    CardPageId = "Matured Notice Card";
    UsageCategory = Lists;
    SourceTable = "Withdrawal Notice";
    Editable = false;
    DeleteAllowed = false;
    InsertAllowed = false;
    SourceTableView=where("Approval Status"=filter(Approved),Converted=filter(false));
    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                }
                field("Member No"; Rec."Member No")
                {
                }
                field(Name; Rec.Name)
                {
                }
                field("Notice Date"; Rec."Notice Date")
                {
                }

            }
        }
        area(Factboxes)
        {

        }
    }

    actions

    {

        area(Processing)
        {
            action("Send Approval Request")
            {

                trigger OnAction();
                begin

                end;
            }
        }
    }
    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        Rec.SetFilter(Rec."Maturity Date", '>=%1', Today);
        Rec.SetRange(Rec."Approval Status", Rec."Approval Status"::Approved);
    end;

    trigger OnAfterGetCurrRecord()
    var
        myInt: Integer;
    begin
        Rec.SetFilter(Rec."Maturity Date", '>=%1', Today);
        Rec.SetRange(Rec."Approval Status", Rec."Approval Status"::Approved);
    end;

    trigger OnAfterGetRecord()
    var
        myInt: Integer;
    begin
        Rec.SetFilter(Rec."Maturity Date", '>=%1', Today);
        Rec.SetRange(Rec."Approval Status", Rec."Approval Status"::Approved);
    end;
}


