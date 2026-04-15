Page 50312 "Sms setup 2"
{
    ApplicationArea = All;
    CardPageID = "SetupCard 2";
    PageType = List;
    SourceTable = "Sms Setup 2";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("User id";Rec."User id")
                {
                }
                field("Authenticatio Mode";Rec."Authenticatio Mode")
                {
                }
                field(Username;Rec.Username)
                {
                }
                field(Vendor;Rec.Vendor)
                {
                }
                field("Sms balance";Rec."Sms balance")
                {
                }
                field(Package;Rec.Package)
                {
                }
            }
        }
    }

    actions
    {
    }
}



