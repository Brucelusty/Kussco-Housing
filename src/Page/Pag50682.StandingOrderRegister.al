//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50682 "Standing Order Register"
{
    ApplicationArea = All;
    Editable = false;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "Standing Order Register";

    layout
    {
        area(content)
        {
            repeater(Control1102760000)
            {
                field("Register No.";Rec."Register No.")
                {
                }
                field(Date; Rec.Date)
                {
                }
                field("Source Account No.";Rec."Source Account No.")
                {
                }
                field("Account Name";Rec."Account Name")
                {
                }
                field("Destination Account Type";Rec."Destination Account Type")
                {
                }
                field("Destination Account No.";Rec."Destination Account No.")
                {
                }
                field("Destination Account Name";Rec."Destination Account Name")
                {
                }
                field("Don't Allow Partial Deduction";Rec."Don't Allow Partial Deduction")
                {
                }
                field("Deduction Status";Rec."Deduction Status")
                {
                }
                field(Amount; Rec.Amount)
                {
                }
                field("Amount Deducted";Rec."Amount Deducted")
                {
                }
                field("Amount-""Amount Deducted"""; Rec.Amount - Rec."Amount Deducted")
                {
                    Caption = 'Balance';
                }
                field(Remarks; Rec.Remarks)
                {
                }
                field(EFT; Rec.EFT)
                {
                }
                field("Transfered to EFT";Rec."Transfered to EFT")
                {
                }
                field("Standing Order No.";Rec."Standing Order No.")
                {
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Statement)
            {
                Caption = 'Print';
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    //REPORT.RUN(,TRUE,TRUE)
                end;
            }
        }
    }
}






