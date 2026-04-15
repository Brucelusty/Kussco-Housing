//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50314 "Membership App Products"
{
    ApplicationArea = All;
    PageType = ListPart;
    UsageCategory = Lists;
    SourceTable = "Membership Reg. Products Appli";
    Editable = false;
    layout
    {
        area(content)
        {
            repeater(Group)
            {

                field("Membership Applicaton No"; Rec."Membership Applicaton No")
                {
                }
                field(Product; Rec.Product)
                {
                }
                field("Product Name"; Rec."Product Name")
                {
                    Editable = false;
                }
                field("Product Source"; Rec."Product Source")
                {
                    Editable = false;
                    Visible=false;
                }
                field("Account Category"; Rec."Account Category")
                {
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetCurrRecord()
    begin
        if ObjMemberApp.Get(Rec."Membership Applicaton No") then begin
            Rec."Account Category" := Format(ObjMemberApp."Account Category");
        end;
    end;

    var
        ObjMemberApp: Record "Membership Applications";
}






