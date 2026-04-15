//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50835 "Treasury CoinageP"
{
    ApplicationArea = All;
    PageType = ListPart;
    SourceTable = "Treasury Coinage";
    SourceTableView = sorting(Value)
                      order(descending);
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(No; Rec.No)
                {
                }
                field("Code"; Rec.Code)
                {
                }
                field(Description; Rec.Description)
                {
                }
                field(Type; Rec.Type)
                {
                }
                field(Value; Rec.Value)
                {
                }
                field(Quantity; Rec.Quantity)
                {
                }
                field("Total Amount"; Rec."Total Amount")
                {
                }
            }
        }
    }


}






