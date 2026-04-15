page 51031 "Net Salary List"
{
    ApplicationArea = All;

    // Editable = false;
    // ModifyAllowed = false;
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "Salary Details";
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Member No"; Rec."Member No")
                {
                    Editable = true;
                }
                field("Payroll No"; Rec."Payroll No")
                {
                    Editable = true;
                }
                field(Region; Rec.Region)
                {
                    Editable = true;
                }
                field(Grade; Rec.Grade)
                {
                    Editable = true;
                }
                field("Gross Amount"; Rec."Gross Amount")
                {
                    Editable = true;
                }
                field("Net Salary"; Rec."Net Salary")
                {
                    Editable = true;
                }
                field("Salary Type"; Rec."Salary Type")
                {
                    Editable = true;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    Editable = true;
                }
                field("Posting Month";Rec."Posting Month")
                {
                    Editable = false;
                }
                field("Posting Year";Rec."Posting Year")
                {
                    Editable = false;
                }
                field("FOSA Account No"; Rec."FOSA Account No")
                {
                    Editable = true;
                }
                field("Document Number"; Rec."Document Number")
                {
                    Editable = true;
                }
            }
        }
    }
}


