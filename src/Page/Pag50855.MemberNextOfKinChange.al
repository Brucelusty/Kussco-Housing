//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50855 "Member Next Of Kin Change"
{
    ApplicationArea = All;
    PageType = ListPart;
    SourceTable = "Member NOK Change Request";
    Caption = 'Member Next Of Kin Details';

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Member No";Rec."Member No")
                {
                }
                field("Member Name";Rec."Member Name")
                {
                    
                }
                field(Name; Rec.Name)
                {
                }
                 field("ID No.";Rec."ID No.")
                {
                }
                  field("Date of Birth";Rec."Date of Birth")
                {
                }
                field(Relationship; Rec.Relationship)
                {
                }
                  field("%Allocation";Rec."%Allocation")
                {
                }
                 field(Telephone; Rec.Telephone)
                {
                }
                field(Email; Rec.Email)
                {
                }
                field(Address; Rec.Address)
                {
                    Caption = 'Postal Address';
                }
                field("Next Of Kin Type";Rec."Next Of Kin Type")
                {
                }
               
               
                field(Description; Rec.Description)
                {
                }
              
            }
        }
    }

    actions
    {
    }
}






