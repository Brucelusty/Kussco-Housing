//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50905 "CRB Check Charge List"
{
    ApplicationArea = All;
    CardPageID = "CRB Charge Card";
    Editable = false;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "CRB Check Charge";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Document No";Rec."Document No")
                {
                }
                field("Member No";Rec."Member No")
                {
                }
                field("Member Name";Rec."Member Name")
                {
                }
                field("FOSA Account to Charge";Rec."FOSA Account to Charge")
                {
                }
                field("Loan No";Rec."Loan No")
                {
                }
                field("Charge Effected";Rec."Charge Effected")
                {
                }
                field("Charged By";Rec."Charged By")
                {
                    Caption = 'Charged Effected By';
                }
                field("Charged On";Rec."Charged On")
                {
                    Caption = 'Charged Effected On';
                }
            }
        }
    }

    actions
    {
    }
}






