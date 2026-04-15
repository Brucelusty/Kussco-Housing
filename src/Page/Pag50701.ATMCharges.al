//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50701 "ATM Charges"
{
    ApplicationArea = All;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "ATM Charges";

    layout
    {
        area(content)
        {
            repeater(Control1102756000)
            {
                field("Transaction Type";Rec."Transaction Type")
                {
                }
                field("Total Amount";Rec."Total Amount")
                {
                }
                field("Sacco Amount";Rec."Sacco Amount")
                {
                }
                field(Source; Rec.Source)
                {
                }
                field("Atm Income A/c";Rec."Atm Income A/c")
                {
                }
                field("Atm Bank Settlement A/C";Rec."Atm Bank Settlement A/C")
                {
                }
                field("Excise Duty";Rec."Excise Duty")
                {
                }
                 field(Channel;Rec.Channel)
                {
                }
                 field(Code;Rec.Code)
                {
                }

            }
        }
    }

    actions
    {
    }
}






