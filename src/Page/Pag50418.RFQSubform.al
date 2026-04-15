//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50418 "RFQ Subform"
{
    ApplicationArea = All;
    PageType = ListPart;
    SourceTable = "Purchase Quote Line";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Type; Rec.Type)
                {
                }
                field("Expense Code";Rec."Expense Code")
                {
                    Visible = false;
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
                    Visible = false;
                }
                field(Amount; Rec.Amount)
                {
                    Visible = false;
                }
                field("PRF No";Rec."PRF No")
                {
                    Visible = false;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Set Specification")
            {
                Caption = 'Set Specification';

                trigger OnAction()
                var
                    PParams: Record "Purchase Quote Params";
                begin
                    PParams.Reset;
                    PParams.SetRange(PParams."Document Type", Rec."Document Type");
                    PParams.SetRange(PParams."Document No.", Rec."Document No.");
                    PParams.SetRange(PParams."Line No.", Rec."Line No.");
                    Page.Run(51516780, PParams);
                end;
            }
        }
    }
}






