//************************************************************************
page 50234 "CustomGLentryBuffer"
{
    ApplicationArea = All;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = Customglentrybuffer;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Entry No.";Rec."Entry No.")
                {

                }
                field("Document No.";Rec."Document No.")
                {

                }
                field("Document Date";Rec."Document Date")
                {

                }
                field("Posting Date";Rec."Posting Date")
                {

                }
                field("Gen. Posting Type";Rec."Gen. Posting Type")
                {

                }
                field(Amount; rec.Amount)
                {

                }
                field("Bal. Account Type";Rec."Bal. Account Type")
                {

                }
                field("Bal. Account No.";Rec."Bal. Account No.")
                {

                }
                field("Credit Amount";Rec."Credit Amount")
                {

                }
                field("Debit Amount";Rec."Debit Amount")
                {

                }
                field("Gen. Bus. Posting Group";Rec."Gen. Bus. Posting Group")
                {
                }
                field("Gen. Prod. Posting Group";Rec."Gen. Prod. Posting Group")
                {

                }
                field("Global Dimension 1 Code";Rec."Global Dimension 1 Code")
                {

                }
                field("Global Dimension 2 Code";Rec."Global Dimension 2 Code")
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
            action(ActionName)
            {

                trigger OnAction();
                begin

                end;
            }
        }
    }
}




