//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50562 "Mobile Membership Appl List"
{
    ApplicationArea = All;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = MobileAppMembershipApplication;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(MobileNo; Rec.MobileNo)
                {
                }
                field(IDNumber; Rec.IDNumber)
                {
                }
                field(FirstName; Rec.FirstName)
                {
                }
                field(MiddleName; Rec.MiddleName)
                {
                }
                field(LastName; Rec.LastName)
                {
                }
                field(FosaAccountOpened; Rec.FosaAccountOpened)
                {
                }
                field(NextOfKinDOB; Rec.NextOfKinDOB)
                {
                }
                field(BosaAccountOpened; Rec.BosaAccountOpened)
                {
                }
                field(ApplicationReceivedOn; Rec.ApplicationReceivedOn)
                {
                }
                field(ApplicationMaintained; Rec.ApplicationMaintained)
                {
                }
                field(RefereeName; Rec.RefereeName)
                {
                }
            }
        }
    }

    actions
    {
    }
}






