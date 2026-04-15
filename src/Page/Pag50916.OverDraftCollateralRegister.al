//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50916 "OverDraft Collateral Register"
{
    ApplicationArea = All;
    PageType = ListPart;
    SourceTable = "OD Collateral Details";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Rec.Code)
                {
                    Caption = 'Collateral Type';
                }
                field("Collateral Registe Doc";Rec."Collateral Registe Doc")
                {
                    Caption = 'Collateral Details Register';
                }
                field("Security Details";Rec."Security Details")
                {
                }
                field(Value; Rec.Value)
                {
                }
                field("Collateral Multiplier";Rec."Collateral Multiplier")
                {
                }
                field("Guarantee Value";Rec."Guarantee Value")
                {
                }
                field("Motor Vehicle Registration No";Rec."Motor Vehicle Registration No")
                {
                }
                field("Title Deed No.";Rec."Title Deed No.")
                {
                }
                field("Comitted Collateral Value";Rec."Comitted Collateral Value")
                {
                }
            }
        }
    }

    actions
    {
    }
}






