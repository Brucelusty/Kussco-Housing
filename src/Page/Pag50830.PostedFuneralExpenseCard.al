//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50830 "Posted Funeral Expense Card"
{
    ApplicationArea = All;
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    SourceTable = "Funeral Expense Payment";

    layout
    {
        area(content)
        {
            field("No.";Rec."No.")
            {
            }
            field("Member No.";Rec."Member No.")
            {
            }
            field("Member Name";Rec."Member Name")
            {
            }
            field("Member ID No";Rec."Member ID No")
            {
            }
            field(Picture; Rec.Picture)
            {
            }
            field("Member Status";Rec."Member Status")
            {
            }
            field("Death Date";Rec."Death Date")
            {
            }
            field("Date Reported";Rec."Date Reported")
            {
            }
            field("Reported By";Rec."Reported By")
            {
            }
            field("Reporter ID No.";Rec."Reporter ID No.")
            {
            }
            field("Reporter Mobile No";Rec."Reporter Mobile No")
            {
            }
            field("Reporter Address";Rec."Reporter Address")
            {
            }
            field("Relationship With Deceased";Rec."Relationship With Deceased")
            {
            }
            field("Received Burial Permit";Rec."Received Burial Permit")
            {
            }
            field("Received Letter From Chief";Rec."Received Letter From Chief")
            {
            }
            field(Posted; Rec.Posted)
            {
                Editable = false;
            }
            field("Date Posted";Rec."Date Posted")
            {
                Editable = false;
            }
            field("Time Posted";Rec."Time Posted")
            {
                Editable = false;
            }
            field("Posted By";Rec."Posted By")
            {
                Editable = false;
            }
        }
    }

    actions
    {
    }
}




