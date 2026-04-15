//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50253 "Member Next of Kin List"
{
    ApplicationArea = All;
    Editable = false;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "Members Next of Kin";

    layout
    {
        area(content)
        {
            repeater(Control1102760000)
            {
                field("Member No";Rec."Account No")
                {
                }
                field(Name; Rec.Name)
                {
                }
                field("Next Of Kin Type";Rec."Next Of Kin Type")
                {
                }
                field(Relationship; Rec.Relationship)
                {
                }
                field("ID No.";Rec."ID No.")
                {
                }
                field("Date of Birth";Rec."Date of Birth")
                {
                }
                field(Telephone; Rec.Telephone)
                {
                }
                field(Description;Rec.Description)
                {
                    Visible = false;
                }
                field(Email; Rec.Email)
                {
                }
                field(Address; Rec.Address)
                {
                    Visible = false;
                }
                field("%Allocation";Rec."%Allocation")
                {
                }
                field("NoK No.";Rec."NoK No.")
                {
                }
            }
        }
    }

    actions
    {
    }
}






