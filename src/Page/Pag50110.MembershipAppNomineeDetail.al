//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50110 "Membership App Nominee Detail"
{
    ApplicationArea = All;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "Member App Nominee";
    Caption = 'Next of Kin Details/Beneficiary/Contact Person';

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Next Of Kin Type"; Rec."Next Of Kin Type")
                {
                    Caption = 'Next of Kin Details/Beneficiary/Contact Person';
                }
                field(Name; rec.Name)
                {
                    ShowMandatory = true;
                }
                field(Relationship; Rec.Relationship)
                {
                    Editable = true;
                    ShowMandatory = true;
                }
                field("ID No."; Rec."ID No.")
                {
                }
                field("Birth Certificate No"; Rec."Birth Certificate No") { Visible = false; }
                field(Address; Rec.Address)
                {
                    Visible = false;
                }

                field(Email; Rec.Email)
                {
                    Visible = false;
                }


                field("Date of Birth"; Rec."Date of Birth")
                {
                    //Visible = false;
                }
                field(Age; Rec.Age)
                {
                    Editable = false;
                }
                field(Description; Rec.Description)
                {
                    Visible = false;
                }
                field("%Allocation"; Rec."%Allocation")
                {

                }
                                field(Telephone; Rec.Telephone)
                {
                    Caption='Contact No.';
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin

        MemberApp.Reset;
        MemberApp.SetRange(MemberApp."No.", Rec."Account No");
        if MemberApp.Find('-') then begin
            if MemberApp."Membership Approval Status" = MemberApp."Membership Approval Status"::Approved then begin                        //MESSAGE(FORMAT(MemberApp.Status));
                CurrPage.Editable := false;
            end else
                CurrPage.Editable := true;
        end;
        Rec."Maximun Allocation %" := 100;
    end;

    var
        MemberApp: Record "Membership Applications";
        ReltnShipTypeEditable: Boolean;
}






