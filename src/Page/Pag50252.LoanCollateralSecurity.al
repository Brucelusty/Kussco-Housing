//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50252 "Loan Collateral Security"
{
    ApplicationArea = All;
    PageType = ListPart;
    SourceTable = "Loan Collateral Details";

    layout
    {
        area(content)
        {
            repeater(Control1102756000)
            {
                field("Collateral Register Doc";Rec."Collateral Register Doc")
                {
                }
                field("Registered Owner";Rec."Registered Owner")
                {
                    Editable = false;
                }
                field("Reference No";Rec."Reference No")
                {
                }

                field("Security Details";Rec."Security Details")
                {
                    Editable = false;
                }
                field("Registration/Reference No";Rec."Registration/Reference No")
                {
                    Editable = false;
                }
                field(Value; Rec.Value)
                {
                }
               field("Current Value";Rec."Current Value")
                {
                }
                field("Comitted Collateral Value";Rec."Comitted Collateral Value")
                {
                    Editable = false;
                }
                field(Category; Rec.Category)
                {
                    Editable = false;
                    Visible= false;
                }

                field(Remarks; Rec.Remarks)
                {
                }
            }
        }
    }

    actions
    {
    }
}






