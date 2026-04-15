//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50584 "Hr Asset Transfer Lines"
{
    ApplicationArea = All;
    DeleteAllowed = false;
    PageType = ListPart;
    SourceTable = "HR Asset Transfer Lines";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No.";Rec."No.")
                {
                }
                field("Asset No.";Rec."Asset No.")
                {
                }
                field("Asset Bar Code";Rec."Asset Bar Code")
                {
                }
                field("Asset Description";Rec."Asset Description")
                {
                }
                field("FA Location";Rec."FA Location")
                {
                }
                field("Asset Serial No";Rec."Asset Serial No")
                {
                }
                field("Responsible Employee Code";Rec."Responsible Employee Code")
                {
                }
                field("Employee Name";Rec."Employee Name")
                {
                }
                field("New Responsible Employee Code";Rec."New Responsible Employee Code")
                {
                }
                field("New Employee Name";Rec."New Employee Name")
                {
                }
                field("Global Dimension 1 Code";Rec."Global Dimension 1 Code")
                {
                }
                field("Dimension 1 Name";Rec."Dimension 1 Name")
                {
                }
                field("New Global Dimension 1 Code";Rec."New Global Dimension 1 Code")
                {
                }
                field("New  Dimension 1 Name";Rec."New  Dimension 1 Name")
                {
                }
                field("Global Dimension 2 Code";Rec."Global Dimension 2 Code")
                {
                }
                field("Dimension 2 Name";Rec."Dimension 2 Name")
                {
                }
                field("New Global Dimension 2 Code";Rec."New Global Dimension 2 Code")
                {
                }
                field("New  Dimension 2 Name";Rec."New  Dimension 2 Name")
                {
                }
                field("Global Dimension 3 Code";Rec."Global Dimension 3 Code")
                {
                }
                field("Dimension 3 Name";Rec."Dimension 3 Name")
                {
                }
                field("New Global Dimension 3 Code";Rec."New Global Dimension 3 Code")
                {
                }
                field("New  Dimension 3 Name";Rec."New  Dimension 3 Name")
                {
                }
                field("Is Asset Expected Back?";Rec."Is Asset Expected Back?")
                {
                }
                field("New Asset Location";Rec."New Asset Location")
                {
                }
                field("Reason for Transfer";Rec."Reason for Transfer")
                {
                }
            }
        }
    }

    actions
    {
    }
}






