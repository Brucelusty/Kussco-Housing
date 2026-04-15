//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50935 "Next of Kin-Change"
{
    ApplicationArea = All;
    PageType = ListPart;
    SourceTable = "Next of Kin/Account Sign";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Date of Birth";Rec."Date of Birth")
                {
                }
                field(Address; Rec.Address)
                {
                }
                field(Telephone; Rec.Telephone)
                {
                }
                field(Fax; Rec.Fax)
                {
                }
                field(Email; Rec.Email)
                {
                }
                field("ID No.";Rec."ID No.")
                {
                }
                field("%Allocation";Rec."%Allocation")
                {
                }
                field("Total Allocation";Rec."Total Allocation")
                {
                }
                field("Maximun Allocation %";Rec."Maximun Allocation %")
                {
                }
                field(Age; Rec.Age)
                {
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Populate)
            {
                Caption = 'Populate';
                Image = GetLines;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    Message('12345');
                end;
            }
        }
    }

    var
        ProductNxK: Record "FOSA Account NOK Details";
        MembNxK: Record "Members Next of Kin";
        cloudRequest: Record "Pension Processing Headerr";
}






