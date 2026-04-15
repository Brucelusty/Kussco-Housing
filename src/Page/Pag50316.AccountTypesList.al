//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50316 "Account Types List"
{
    ApplicationArea = All;
    CardPageID = "Account Types Card";
    Editable = false;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "Account Types-Saving Products";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Rec.Code)
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("Dormancy Period (M)"; Rec."Dormancy Period (M)")
                {
                }
                field("Minimum Balance"; Rec."Minimum Balance")
                {
                }
                field("Paybill Code";Rec."Paybill Code")
                {
                }
                field("Default Account"; Rec."Default Account")
                {
                }
                                field("Current Account"; Rec."Current Account")
                {
                }
                field("Product Type"; Rec."Product Type")
                {
                }
                field("Earns Interest"; Rec."Earns Interest")
                {
                }
                field("Entered By"; Rec."Entered By")
                {
                }
                field("Date Entered"; Rec."Date Entered")
                {
                }
                field("Time Entered"; Rec."Time Entered")
                {
                }
                field("Modified By"; Rec."Modified By")
                {
                }
                field("Last Date Modified"; Rec."Last Date Modified")
                {
                }
                field("Account Type"; Rec."Account Type")
                {
                    Visible = true;

                }
                
            }
        }
    }

    actions
    {
    }
}






