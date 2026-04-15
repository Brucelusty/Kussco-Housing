//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50662 "Loan Collateral Setup"
{
    ApplicationArea = All;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "Loan Collateral Set-up";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Rec.Code)
                {
                    ShowMandatory = true;
                }
                field(Type; Rec.Type)
                {
                    ShowMandatory = true;
                }
                field("Security Description"; Rec."Security Description")
                {
                    ShowMandatory = true;
                }
                field(Security;Rec.Security)
                {
                    ShowMandatory = true;
                }
                field(Category; Rec.Category)
                {
                }
                field("Collateral Posting Group";Rec."Collateral Posting Group")
                {
                    ShowMandatory = True;
                }
                field("Collateral Multiplier"; Rec."Value Considered")
                {
                    ShowMandatory = true;
                }
            }
        }
    }

    actions
    {
    }
}






