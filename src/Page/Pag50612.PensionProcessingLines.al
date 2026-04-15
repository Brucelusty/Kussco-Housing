//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50612 "Pension Processing Lines"
{
    ApplicationArea = All;
    Editable = true;
    PageType = ListPart;
    SourceTable = "Pension Processing Lines";

    layout
    {
        area(content)
        {
            repeater(Control1102760000)
            {
                Editable = true;
                field("No.";Rec."No.")
                {
                    Editable = true;
                }
                field("Pension No";Rec."Pension No")
                {
                }
                field("Account No.";Rec."Account No.")
                {
                }
                field("Account Name";Rec."Account Name")
                {
                }
                field(Name; Rec.Name)
                {
                    Visible = false;
                }
                field(Amount; Rec.Amount)
                {
                }
                field("Employer Code";Rec."Employer Code")
                {
                }
                field("Global Dimension 2 Code";Rec."Global Dimension 2 Code")
                {
                }
                field("Branch Reff.";Rec."Branch Reff.")
                {
                    Visible = false;
                }
                field("ID No.";Rec."ID No.")
                {
                    Visible = false;
                }
                field("Original Account No.";Rec."Original Account No.")
                {
                    Visible = false;
                }
                field("Account Not Found";Rec."Account Not Found")
                {
                    Editable = false;
                    Visible = true;
                }
                field("Document No.";Rec."Document No.")
                {
                    Editable = false;
                    Visible = false;
                }
                field(Date; Rec.Date)
                {
                    Editable = false;
                    Visible = false;
                }
                field("BOSA Schedule";Rec."BOSA Schedule")
                {
                }
                field(Closed; Rec.Closed)
                {
                    Editable = false;
                    Visible = true;
                }
                field("Multiple Salary";Rec."Multiple Salary")
                {
                    Editable = false;
                    Visible = true;
                }
                field("Bosa No";Rec."Bosa No")
                {
                }
                field("Salary Header No.";Rec."Salary Header No.")
                {
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin

        //SETRANGE(USER,USERID);
    end;
}






