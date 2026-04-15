//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50481 "HR Employee Kin SF"
{
    ApplicationArea = All;
    Caption = 'HR Employee Kin & Beneficiaries';
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "HR Employee Kin";

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field(Type;Rec.Type)
                {
                }
                field(Relationship;Rec.Relationship)
                {
                }
                field(SurName;Rec.SurName)
                {
                }
                field("Other Names";Rec."Other Names")
                {
                }
                field("ID No/Passport No";Rec."ID No/Passport No")
                {
                }
                field("Date Of Birth";Rec."Date Of Birth")
                {
                }
                field(Occupation;Rec.Occupation)
                {
                }
                field(Address;Rec.Address)
                {
                }
                field("E-mail";Rec."E-mail")
                {
                }
                field("Office Tel No";Rec."Office Tel No")
                {
                }
                field("Home Tel No";Rec."Home Tel No")
                {
                }
                field(Comment;Rec.Comment)
                {
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Next of Kin")
            {
                Caption = '&Next of Kin';
                action("Co&mments")
                {
                    Caption = 'Co&mments';
                    RunObject = Page "Human Resource Comment Sheet";
                    RunPageLink = "Table Name" = const("Employee Relative"),
                                  "No." = field("Employee Code"),
                                  "Table Line No." = field("Line No.");
                }
            }
        }
    }

    var
        D: Date;
}






