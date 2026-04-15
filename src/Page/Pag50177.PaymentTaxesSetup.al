//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50177 "Payment Taxes Setup"
{
    ApplicationArea = All;
    PageType = List;
    Editable = true;
    SourceTable = "tariff codes";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Code; Rec.Code)
                {
                }
                field(Type; Rec.Type)
                {
                }
                field(Description; Rec.Description)
                {

                }
                field(Percentage; Rec.Percentage)
                {
                }
                field("Account Type"; Rec."Account Type")
                {
                }
                field("Account No."; Rec."Account No.")
                {
                }


            }
        }
    }

    actions
    {
    }
}






