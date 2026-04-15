namespace KUSCCOHOUSING.KUSCCOHOUSING;

enum 50101 "Loan Purpose"
{
    Extensible = true;

    value(0; "Land Purchase")
    {
        Caption = 'Land Purchase';
    }
    value(1; "Construction/Development")
    {
        Caption = 'Construction / Development';
    }
    value(2; "Home Improvement")
    {
        Caption = 'Home Improvement or Renovation';
    }
    value(3; "Refinancing")
    {
        Caption = 'Refinancing (Existing Property Loan)';
    }
    value(4; "Investment Property")
    {
        Caption = 'Investment Property Purchase';
    }
    value(5; Other)
    {
        Caption = 'Other';
    }
}
