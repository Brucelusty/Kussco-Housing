page 65718 "Staggered Charges"
{
    ApplicationArea = All;
    PageType = Card;
    SourceTable ="Staggered Charges";
    

    layout
    {
        area(content)
        {
            group(General)
            {
                field(Code;rec.Code)
                {
                }
                field(Description;rec.Description)
                {
                }
            }
           // part(part; 65719)
           // {
          //      SubPageLink = Code=FIELD(Code);
           // }
        }
    }

    actions
    {
    }
}




