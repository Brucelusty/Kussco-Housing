//************************************************************************
pageextension 50012 "DimensionValuespageExt" extends "Dimension Values"

{
    layout
    {
        addlast(Control1)
        {
            field("Global Dimension No."; Rec."Global Dimension No.")
            {
                ApplicationArea = All;
            }
        }

    }
}


