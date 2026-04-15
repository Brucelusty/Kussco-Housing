report 51200 "Membership Acceptance Letter"
{
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = Word;
    WordLayout = 'Layouts/Individual&JointMembershipAcceptance.docx';
    
    dataset
    {
        dataitem(IndividualJointMembers; Customer)
        {
            column(Format_to_today; Format(Today, 0, 4)) { }
            column(Account_No; "No.")
            {
                
            }

            column(Name; Name)
            {
                
            }

            column(Address; Address)
            {
                
            }

            column(Post_Code; "Post Code")
            {
                
            }

            column(County; County)
            {
                
            }

            column(Mobile_Phone_No; "Mobile Phone No")
            {
                
            }
        }
    }
    
}
