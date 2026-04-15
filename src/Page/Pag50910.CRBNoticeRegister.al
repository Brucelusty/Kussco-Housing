//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50910 "CRB Notice Register"
{
    ApplicationArea = All;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "CRB Notice Register";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Loan No";Rec."Loan No")
                {
                    Editable = false;
                }
                field("Member No";Rec."Member No")
                {
                    Editable = false;
                }
                field("Member Name";Rec."Member Name")
                {
                    Editable = false;
                }
                field("Loan Product Type";Rec."Loan Product Type")
                {
                    Editable = false;
                }
                field("Loan Product Name";Rec."Loan Product Name")
                {
                    Editable = false;
                }
                field("Issued Date";Rec."Issued Date")
                {
                    Editable = false;
                }
                field("Approved Amount";Rec."Approved Amount")
                {
                    Editable = false;
                }
                field("Principle Outstanding";Rec."Principle Outstanding")
                {
                    Editable = false;
                }
                field("Amount In Arrears";Rec."Amount In Arrears")
                {
                    Editable = false;
                }
                field("Days In Arrears";Rec."Days In Arrears")
                {
                    Editable = false;
                }
                field("CRB Listed";Rec."CRB Listed")
                {
                }
                field("Date Listed";Rec."Date Listed")
                {
                }
                field("Listed By";Rec."Listed By")
                {
                }
                field(Delist; Rec.Delist)
                {
                }
                field("DeListed On";Rec."DeListed On")
                {
                }
                field("Delisted By";Rec."Delisted By")
                {
                }
            }
        }
    }

    actions
    {
    }
}






