report 51201 "Junior Membership Acceptance"
{
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = Word;
    WordLayout = 'Layouts/JuniorMembershipAcceptance.docx';
    
    dataset
    {
        dataitem(JuniorMember; Vendor)
        {
            column(Format_to_today; Format(Today, 0, 4)) { }
            column(BOSA_Account_No; "BOSA Account No")
            {
                
            }

            column(Name; Name)
            {
                
            }

            column(Child_Name; "Child Name")
            {
                
            }

            column(Address; Address)
            {
                
            }

            column(Postal_Code; "Postal Code")
            {
                
            }

            column(County; County)
            {
                
            }
        }
    }
    
}
