//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50382 "Imprest List"
{
    ApplicationArea = All;
    Caption = 'Staff Travel  List';
    CardPageID = "Imprest Request";
    Editable = false;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "Imprest Header";
    SourceTableView = where(Posted = const(false));

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                field("No.";Rec."No.")
                {
                }
                field(Date; Rec.Date)
                {
                }
                field("Account No.";Rec."Account No.")
                {
                }
                field(Payee; Rec.Payee)
                {
                }
                field("Total Net Amount";Rec."Total Net Amount")
                {
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Print/Preview")
            {
                Image = Print;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    ImprestHeader.Reset;
                    ImprestHeader.SetRange(ImprestHeader."No.", Rec."No.");
                    Report.run(172130, true, false, ImprestHeader);
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        Rec.SetRange(Cashier, UserId);
    end;

    var
        ImprestHeader: Record "Imprest Header";
}






