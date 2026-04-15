page 50076 "OTP Logs"
{
    ApplicationArea = All;
    PageType = List;
    SourceTable = "OTP Logs";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Session ID";Rec."Session ID")
                {
                }
                field("User Id";Rec."User Id")
                {
                }
                field(OTP;Rec.OTP)
                {
                }
                field("Generated On";Rec."Generated On")
                {
                }
                field("Expiration Time";Rec."Expiration Time")
                {
                }
            }
        }
    }
}


